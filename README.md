#🛒 E-Commerce Data Analytics Project
# Cart Abandonment  and conversion optimization Analysis 




## 📌 Overview

This project is an **end-to-end Data Analytics project** focused on analyzing e-commerce customer behavior, sales performance, conversion funnel, cart abandonment, payment failures, delivery performance, and product performance.

The project demonstrates the complete data analytics workflow, starting from **loading and cleaning raw data in Python** to performing **SQL analysis in SQL Server**, creating an interactive **Power BI dashboard**, preparing a detailed **project report**, and presenting the findings through a **PowerPoint presentation created using Gamma**.

### Project Workflow

**Raw Dataset → Python → EDA & Data Cleaning → SQL Server → Business Analysis → Power BI Dashboard → Report → Presentation**

---

## 🎯 Project Objectives

The main objectives of this project are to:

* Understand e-commerce customer behavior
* Analyze the sales and conversion funnel
* Identify major customer drop-off points
* Analyze cart abandonment
* Identify high-performing and low-performing products
* Analyze payment failures
* Understand the impact of delivery time on purchases
* Analyze customer and product performance
* Identify potential revenue loss
* Generate actionable business recommendations

---

# 📊 Dataset

The project uses an **e-commerce dataset** containing multiple related tables.

The main tables include:

* **Customers** — customer information and customer type
* **Products** — product details and categories
* **Sessions** — customer browsing and session activity
* **Orders** — order and sales information
* **Delivery** — delivery time and delivery-related information
* **Returns** — product return information

The dataset was initially provided in **Excel format** and was loaded into Python for analysis and preparation.

---

# 🛠️ Tools & Technologies

| Tool                | Purpose                               |
| ------------------- | ------------------------------------- |
| **Python**          | Data loading, cleaning and EDA        |
| **Pandas**          | Data manipulation and analysis        |
| **NumPy**           | Numerical analysis                    |
| **Matplotlib**      | Data visualization                    |
| **SQL Server**      | Business analysis and SQL queries     |
| **Power BI**        | Interactive dashboard                 |
| **DAX**             | KPI and calculated measures           |
| **Power Query**     | Data transformation                   |                     |
| **Gamma**           | Project presentation                  |
| **GitHub**          | Project version control and portfolio |

---

# 🔄 Project Steps

## 1. Load Dataset in Python

The Excel dataset was loaded into Python using **Pandas**.

The initial step included:

* Reading Excel files
* Loading multiple tables
* Checking dataset structure
* Understanding columns and data types
* Checking the number of rows and columns

Example:

```python
import pandas as pd

df = pd.read_excel("ecommerce_dataset.xlsx")
df.head()
```

---

## 2. Exploratory Data Analysis (EDA)

EDA was performed to understand the data and identify patterns.

The analysis included:

* Dataset shape
* Data types
* Missing values
* Duplicate records
* Unique values
* Descriptive statistics
* Category distribution
* Customer behavior
* Sales patterns
* Product performance
* Conversion behavior

Python was also used to create visualizations to identify trends and patterns.

---

## 3. Data Cleaning

The data was cleaned and prepared before further analysis.

Major cleaning activities included:

* Handling missing values
* Removing duplicate records
* Correcting data types
* Standardizing column names
* Checking inconsistent values
* Preparing date columns
* Validating categorical values
* Preparing data for SQL and Power BI

The cleaned data was then used for further analysis.

---

# 🗄️ 4. SQL Server Analysis

The cleaned dataset was loaded into **SQL Server** for structured business analysis.

SQL queries were created to answer important business questions.

### Basic Analysis

* Total revenue
* Total orders
* Average Order Value
* Monthly revenue
* Category performance
* Top products

### Funnel Analysis

The customer journey was analyzed as:

**Sessions → Product Views → Add to Cart → Checkout → Payment → Purchase**

Questions analyzed:

* What is the overall conversion rate?
* Where is the biggest funnel drop-off?
* How many customers add products to their cart?
* How many customers proceed to checkout?
* How many payment attempts are successful?

### Customer Analysis

* New vs returning customers
* Customer conversion
* Customer revenue
* High-value customers
* Customer abandonment

### Business Analysis

* Cart abandonment rate
* Payment failure rate
* Potentially lost revenue
* Discount vs conversion
* Delivery time vs purchase completion
* High-view / low-purchase products
* Product return analysis

The SQL queries are available in the `sql/` folder.

---

# 📈 5. Power BI Dashboard

The analyzed data was used to create an interactive **Power BI dashboard**.

The dashboard focuses on important business KPIs and customer behavior.

### Key KPIs

* Revenue
* Orders
* Customers
* Conversion Rate
* Average Order Value
* Cart Abandonment Rate
* Return Rate

### Dashboard Analysis

The dashboard includes analysis of:

* Sales performance
* Revenue trends
* Conversion funnel
* Cart abandonment
* Customer behavior
* Product performance
* Payment failures
* Delivery performance
* Returns

Interactive slicers allow users to analyze the data by dimensions such as:

* Date
* State
* Category
* Device
* Customer Type
* Traffic Source

The Power BI file is available in:

```text
powerbi/ecommerce_dashboard.pbix
```

---

# 📊 6. Business Insights & Results

The analysis was used to identify important business patterns and convert them into actionable recommendations.

Examples of insights include:

### 📱 tablet Abandonment

If tablet users show a higher abandonment rate than mobile and desktop users:

**Recommendation:** Improve the tablet shopping and checkout experience.

### 💳 Payment Failures

If a payment method has a high failure rate:

**Recommendation:** Investigate payment gateway issues and provide alternative payment options.

### 🚚 Delivery Time

If longer delivery times are associated with higher abandonment:

**Recommendation:** Improve fulfillment speed and provide faster delivery options.

### 🛍️ High Views but Low Purchases

Products receiving many views but few purchases may indicate issues with:

* Pricing
* Product images
* Product descriptions
* Reviews
* Product availability

**Recommendation:** Review and optimize these product attributes.

### 🔄 Product Returns

Categories with high return rates can indicate potential issues with:

* Product quality
* Product descriptions
* Sizing
* Customer expectations

**Recommendation:** Investigate the main return reasons and improve the customer experience.

---

# 📑 7. Project Report

A detailed project report was prepared to document:

* Business problem
* Dataset
* Data preparation
* EDA
* SQL analysis
* Power BI dashboard
* Key findings
* Business recommendations

The report is available in the project repository.

---

# 🎤 8. Project Presentation

A presentation was created using **Gamma** to communicate the project to a business audience.

The presentation covers:

* Business problem
* Objectives
* Data and methodology
* Analysis
* Dashboard
* Key insights
* Recommendations
* Conclusion

The presentation is available in the:

```text
presentation/
```

folder.

---

# 📁 Project Structure

```text
ecommerce-cart-abandonment-analysis/
│
├── README.md
│
├── data/
│   └── ecommerce_dataset.xlsx
│
├── sql/
│   ├── 01_basic_analysis.sql
│   ├── 02_funnel_analysis.sql
│   ├── 03_customer_analysis.sql
│   └── 04_business_cases.sql
│
├── python/
│   └── exploratory_analysis.ipynb
│
├── powerbi/
│   └── ecommerce_dashboard.pbix
│
├── dashboard/
│   ├── overview.png
│   ├── funnel.png
│   ├── abandonment.png
│   └── insights.png
│
└── presentation/
    └── project_presentation.pdf
```

---

# ▶️ How to Run the Project

## Step 1 — Clone the Repository

```bash
git clone <your-github-repository-url>
```

## Step 2 — Open the Python Notebook

Open:

```text
python/exploratory_analysis.ipynb
```

Run the notebook to perform:

* Data loading
* EDA
* Data cleaning
* Exploratory analysis

Make sure the required Python libraries are installed:

```bash
pip install pandas numpy matplotlib openpyxl jupyter
```

---

## Step 3 — Run SQL Analysis

Open SQL Server Management Studio (SSMS).

1. Create a database.
2. Load the cleaned dataset into SQL Server.
3. Open the SQL files from the `sql/` folder.
4. Run the queries.
5. Review the business analysis results.

---

## Step 4 — Open Power BI Dashboard

Open:

```text
powerbi/ecommerce_dashboard.pbix
```

If necessary, update the data source connection to your local SQL Server database.

Refresh the data and explore the dashboard.

---

## Step 5 — Review the Report & Presentation

Open the project report and Gamma-generated presentation to review the complete analysis, insights, and recommendations.

---

# 📌 Key Skills Demonstrated

This project demonstrates practical skills in:

* Python
* Pandas
* Exploratory Data Analysis
* Data Cleaning
* SQL Server
* SQL Querying
* Business Analysis
* E-commerce Analytics
* Data Visualization
* Power BI
* DAX
* Power Query
* KPI Development
* Dashboard Design
* Business Insights
* Data Storytelling
* Presentation Skills

---

# 💼 Conclusion

This project demonstrates an **end-to-end data analytics workflow** where raw e-commerce data is transformed into meaningful business insights.

It combines **Python, SQL Server, Power BI, and business analysis** to understand customer behavior, identify conversion problems, analyze cart abandonment, and provide data-driven recommendations.

The project reflects how a Data Analyst can move from:

**Raw Data → Analysis → Insights → Visualization → Business Recommendations**

---

## 👩‍💻 Author
Sudha Patel
Project Type: Data Analytics Portfolio Project
Domain: E-commerce
Focus: Cart Abandonment & Customer Conversion
Tools: Python | SQL Server | Power BI 
Role: Data Analyst — End-to-End Analytics Project

Aspiring Data Analyst | Python | SQL | Power BI | Excel

📌 Interested in Data Analytics, Business Intelligence, E-commerce Analytics, and Business Problem Solving.
