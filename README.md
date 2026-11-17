# FPO & Cooperative Procurement & Supply Chain Diagnostic

Status: Completed | Tools: Python, SQL, Excel, Tableau | Domain: AgriTech & FPO Supply Chain | Audit Variance: INR 0.00

## Executive Project Overview

This repository contains an industrial-grade Procurement, Quality Grading, and Financial Reconciliation Diagnostic for Farmer Producer Organizations (FPOs) and agricultural cooperatives. Processing 1,001 procurement batch records across 15 village collection centers in Andhra Pradesh, this project addresses key operational frictions: arrival volume volatility, quality deduction shrinkage (moisture and foreign matter refraction), logistics transport friction, and payout reconciliation errors.

The analytics pipeline models 83,534.39 Quintals of raw crop procurement across five high-value commodities (Paddy, Red Chilli, Maize, Turmeric, and Toor Dal), tracking INR 67.31 Crores in gross farmer payout liabilities against INR 68.94 Crores in corporate buyer invoice realizations.

---

## Repository Directory Structure

```text
fpo-cooperative-procurement-supply-chain/
│
├── README.md                            <-- Master project documentation & technical blueprint
├── EXECUTIVE_REPORT_FPO_PROCUREMENT.md  <-- Executive policy brief & operational recommendations
│
├── data/
│   ├── fpo_procurement_raw.csv          <-- Raw procurement receipts (1,001 uncleaned records)
│   ├── fpo_procurement_clean.csv        <-- Cleaned dataset with moisture deductions & grades
│   ├── collection_center_summary.csv    <-- Aggregated center-level KPI export for BI tools
│   └── fpo_procurement.db               # SQLite relational database warehouse
│
├── sql/
│   └── 02_fpo_payout_queries.sql        <-- Production SQL analytical queries & window functions
│
├── excel/
│   └── fpo_farmer_payout_reconciliation.xlsx <-- CFO-level audit reconciliation workbook
│
└── notebooks/
    └── 01_fpo_procurement_analysis.ipynb <-- Jupyter Notebook with Pandas EDA & feature pipeline
```

---

## Key Operational Metrics & Findings

| Operational Metric | Total Aggregate Value | Key Strategic Insight |
| :--- | :--- | :--- |
| **Total Procurement Batches** | **1,001 Batches** | Distributed across 15 primary village collection centers (VCCs) |
| **Gross Volume Ingested** | **83,534.39 Quintals** | Paddy (218), Red Chilli (200), Maize (197), Turmeric (195), Toor Dal (191) |
| **Net Delivered Volume** | **79,907.32 Quintals** | **3,627.07 Quintals physical shrinkage** due to moisture & refraction penalties |
| **Volume Shrinkage Rate** | **4.34% Total Volume** | Equivalent to **INR 2.89 Crores** in raw value deduction across collection hubs |
| **Gross Farmer Payout** | **INR 67,30,60,541.53** | Net payable amount to 1,000 smallholder farmers after quality deductions |
| **Logistics Freight Cost** | **INR 1,34,93,739.77** | Inter-hub transport cost from village centers to central processing warehouses |
| **Buyer Invoice Realization** | **INR 68,94,08,898.18** | Gross revenue collected from corporate off-takers and exporters |
| **Net FPO Operating Margin** | **INR 66,13,664.43** | Realized FPO operating margin (**0.96% net margin efficiency**) |
| **Financial Audit Variance** | **INR 0.00 Difference** | Perfect zero-variance reconciliation across all 1,001 transaction logs |

---

## Phase-by-Phase Technical Pipeline

### Phase 1: Python Data Hygiene & Feature Engineering (Pandas)
* **Hygiene & Formatting**: Trimmed string whitespace, standardized farmer casing, and eliminated duplicate receipt IDs.
* **Moisture & Refraction Deduction Engine**: Implemented non-linear deduction rules based on commodity moisture standards.
* **Quality Grade Assignment**: Categorized batches into **Grade A** (Score >= 88, 5% price premium), **Grade B** (Score 80-87, standard MSP), and **Grade C** (Score < 80, 8% price markdown). Result: **531 Grade A**, **441 Grade B**, and **29 Grade C** batches.

### Phase 2: Relational SQL Warehousing & Window Analytics (SQLite)
* **Database Architecture**: Constructed `fpo_procurement.db` containing `procurement_batches` and `collection_centers` tables.
* **SQL Analytical Queries (`02_fpo_payout_queries.sql`)**:
  * Utilized `RANK() OVER (ORDER BY avg_moisture_penalty_pct DESC)` to isolate high-moisture centers.
  * Isolated operational deficits: Identified **Tirupati Hill Depot** operating at a **net deficit of -INR 72,969.19** due to elevated transport rates (INR 183/Qtl) and high moisture penalties (2.09%).
  * Evaluated top margin contributors: **Kakinada Port Supply Depot** (INR 8.16 Lakhs margin) and **Srikakulam Farmer Point** (INR 7.68 Lakhs margin).

### Phase 3: CFO-Ready Excel Audit Reconciliation (openpyxl)
* **Workbook Construction**: Built `fpo_farmer_payout_reconciliation.xlsx` featuring dynamic `SUMIF`, `XLOOKUP`, and nested `IF` variance checks.
* **Zero-Variance Proof**: Cross-reconciled Buyer Invoices against Farmer Payouts, Freight, and FPO Margins (Buyer Invoices INR 68.94 Cr = Farmer Payout INR 67.31 Cr + Logistics INR 1.35 Cr + FPO Margin INR 0.66 Cr). **Reconciliation Variance = INR 0.00**.

### Phase 4: Executive Policy & Strategic Audit (`EXECUTIVE_REPORT_FPO_PROCUREMENT.md`)
* **Micro-Solar Drying Docks**: Recommend deploying solar dryers at high-penalty centers (Vizianagaram, Nandyal, Nellore) to recover **3,627 Quintals of moisture shrinkage**, capturing an estimated **INR 14.8 Lakhs/year** in retained value.
* **Dynamic Moisture Advance Payouts**: Adjust upfront farmer advances to prevent over-payment on high-moisture arrivals.

---

## How to Reproduce & Run

1. **Run Python EDA & Feature Pipeline**:
   ```bash
   jupyter notebook notebooks/01_fpo_procurement_analysis.ipynb
   ```
2. **Execute SQL Analytical Queries**:
   ```bash
   sqlite3 data/fpo_procurement.db < sql/02_fpo_payout_queries.sql
   ```
3. **Inspect Excel Audit Workbook**:
   Open `excel/fpo_farmer_payout_reconciliation.xlsx` to verify formulas, `SUMIF` functions, and the zero-variance check.
---

## 👤 Author & Contact
* **Author:** Somnath Banerjee
* **Role:** Aspiring Agri-Business Analyst & Geospatial BI Specialist
* **LinkedIn:** linkedin.com/in/somnath-banerjee-621720239
* **GitHub:** https://github.com/banerjeesomnath1154-dotcom
* **Gmail:** banerjeesomnath1154@gmail.com
