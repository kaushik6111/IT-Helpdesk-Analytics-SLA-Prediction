

USE helpdesk_analytics;

-- 1. Overall ticket summary
SELECT
    COUNT(*) AS total_tickets,
    SUM(status = 'Open') AS open_tickets,
    SUM(status = 'In Progress') AS in_progress_tickets,
    SUM(status = 'Resolved') AS resolved_tickets,
    SUM(status = 'Closed') AS closed_tickets
FROM tickets;

-- 2. Tickets by priority
SELECT
    priority,
    COUNT(*) AS total_tickets
FROM tickets
GROUP BY priority
ORDER BY FIELD(priority, 'Critical', 'High', 'Medium', 'Low');

-- 3. Tickets by status
SELECT
    status,
    COUNT(*) AS total_tickets
FROM tickets
GROUP BY status
ORDER BY total_tickets DESC;

-- 4. Average resolution time in hours
-- Only includes tickets that have a resolution timestamp.
SELECT
    ROUND(AVG(TIMESTAMPDIFF(
        SECOND, created_at, resolved_at
    ) / 3600.0), 2) AS avg_resolution_hours
FROM tickets
WHERE resolved_at IS NOT NULL;

-- 5. SLA breach analysis
-- For resolved tickets, compare actual resolution time
-- with the target for their priority.
SELECT
    t.ticket_id,
    t.priority,
    t.status,
    s.target_resolution_hours,
    ROUND(
        TIMESTAMPDIFF(SECOND, t.created_at,
            COALESCE(t.resolved_at, NOW())) / 3600.0,
        2
    ) AS elapsed_hours,
    CASE
        WHEN TIMESTAMPDIFF(
            SECOND, t.created_at, COALESCE(t.resolved_at, NOW())
        ) > s.target_resolution_hours * 3600
        THEN 'Yes'
        ELSE 'No'
    END AS sla_breached
FROM tickets t
JOIN sla_rules s
    ON t.priority = s.priority
ORDER BY t.ticket_id;

-- 6. SLA breach rate for resolved tickets only
SELECT
    COUNT(*) AS resolved_tickets,
    SUM(
        TIMESTAMPDIFF(SECOND, t.created_at, t.resolved_at)
        > s.target_resolution_hours * 3600
    ) AS breached_tickets,
    ROUND(
        100.0 * SUM(
            TIMESTAMPDIFF(SECOND, t.created_at, t.resolved_at)
            > s.target_resolution_hours * 3600
        ) / NULLIF(COUNT(*), 0),
        2
    ) AS breach_rate_percent
FROM tickets t
JOIN sla_rules s
    ON t.priority = s.priority
WHERE t.resolved_at IS NOT NULL;

-- 7. Agent performance
SELECT
    a.agent_name,
    a.team,
    COUNT(t.ticket_id) AS assigned_tickets,
    SUM(t.resolved_at IS NOT NULL) AS resolved_tickets,
    ROUND(
        AVG(
            CASE
                WHEN t.resolved_at IS NOT NULL
                THEN TIMESTAMPDIFF(
                    SECOND, t.created_at, t.resolved_at
                ) / 3600.0
            END
        ),
        2
    ) AS avg_resolution_hours
FROM support_agents a
LEFT JOIN tickets t
    ON a.agent_id = t.agent_id
GROUP BY a.agent_id, a.agent_name, a.team
ORDER BY resolved_tickets DESC;

-- 8. Ticket volume by issue type
SELECT
    issue_type,
    COUNT(*) AS total_tickets
FROM tickets
GROUP BY issue_type
ORDER BY total_tickets DESC;

-- 9. Daily ticket volume
SELECT
    DATE(created_at) AS ticket_date,
    COUNT(*) AS tickets_created
FROM tickets
GROUP BY DATE(created_at)
ORDER BY ticket_date;

-- 10. Department-wise ticket volume
SELECT
    e.department,
    COUNT(t.ticket_id) AS total_tickets
FROM employees e
JOIN tickets t
    ON e.employee_id = t.employee_id
GROUP BY e.department
ORDER BY total_tickets DESC;
