# IT Help Desk Analytics and SLA Breach Prediction System

## Overview

This project analyzes IT help desk tickets using Python, MySQL, and Power BI. It explores ticket volume, priority distribution, ticket status, resolution time, support agent performance, and Service Level Agreement (SLA) breaches.

The project demonstrates an end-to-end data analytics workflow, from storing ticket data in a relational database to analyzing it with Python and presenting insights through an interactive Power BI dashboard.

## Objectives

- Analyze IT support ticket trends and workload.
- Measure average ticket resolution time.
- Identify tickets that exceeded their SLA targets.
- Compare ticket volume and SLA breaches by priority.
- Explore support agent performance.
- Build an interactive dashboard for reporting and decision support.

## Technologies Used

- **MySQL:** Data storage and SQL queries
- **Python:** Data cleaning, analysis, and visualization
- **Pandas:** Data manipulation and analysis
- **Power BI:** Interactive dashboard and KPI reporting
- **Google Colab:** Python notebook environment

## Project Workflow

1. Store employee, support agent, SLA rule, and ticket data in MySQL.
2. Query and export the data for analysis.
3. Analyze ticket resolution times and SLA compliance using Python.
4. Prepare datasets for Power BI.
5. Build an interactive dashboard with KPI cards, charts, and slicers.

## Key Dashboard Metrics

The current sample dataset contains 15 tickets.

| Metric | Sample Result |
|---|---:|
| Total Tickets | 15 |
| Open Tickets | 1 |
| Resolved tickets with resolution timestamps | 12 |
| Average Resolution Time | 13.75 hours |
| SLA Breach Rate among tickets with resolution timestamps | 58.33% |

These results describe the current sample dataset and may change if the data is modified.

## Dashboard Features

- Total ticket and open ticket KPI cards
- SLA breach rate KPI
- Average resolution time KPI
- Ticket count by priority
- Ticket distribution by status
- SLA breaches by priority
- Average resolution time by priority
- Filters for department, priority, and status

## Repository Structure

- `sql/` — Database schema, sample data inserts, and analytical queries
- `python/` — Python analysis notebook
- `data/` — Sample datasets and analysis outputs
- `powerbi/` — Power BI report
- `screenshots/` — Dashboard preview images
- `documentation/` — Project report and supporting documentation

## How to Run

1. Install MySQL and create the project database.
2. Execute the SQL scripts in the appropriate order.
3. Open the Python notebook in Google Colab or Jupyter Notebook.
4. Load the sample CSV datasets and run the analysis cells.
5. Open the Power BI report in Power BI Desktop and refresh the data sources if necessary.

## Future Enhancements

- Build and evaluate a machine-learning model to predict potential SLA breaches.
- Compare model performance using suitable classification metrics.
- Add additional ticket trends and operational KPIs.
- Expand the dataset to test the analysis on more records.

## Disclaimer

This project uses sample data for educational and portfolio purposes. The displayed metrics are illustrative results from the current dataset and should not be interpreted as real organizational performance.

## Author

MCA Student | Data Analytics Project

**Skills demonstrated:** SQL, Python, data analysis, KPI reporting, and Power BI dashboard development.
