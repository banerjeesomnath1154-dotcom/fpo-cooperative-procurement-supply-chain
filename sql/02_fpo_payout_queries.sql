-- PROJECT 4: FPO & COOPERATIVE PROCUREMENT & SUPPLY CHAIN DIAGNOSTIC
-- SQL Window Function Query Suite

-- Query 1: Collection Center Performance & Moisture Penalty Ranking
SELECT 
    center_name,
    COUNT(batch_id) AS total_procurement_batches,
    ROUND(SUM(gross_weight_quintals), 2) AS total_gross_quintals,
    ROUND(SUM(net_weight_quintals), 2) AS total_net_quintals,
    ROUND(AVG(measured_moisture_pct), 2) AS avg_moisture_pct,
    ROUND(SUM(gross_farmer_payable_inr), 2) AS total_farmer_payout_inr,
    RANK() OVER (ORDER BY AVG(measured_moisture_pct) DESC) AS moisture_penalty_rank
FROM procurement_batches
GROUP BY center_name
ORDER BY moisture_penalty_rank ASC;

-- Query 2: Quality Grade Distribution & Buyer Realization Variance
SELECT 
    crop_name,
    quality_grade,
    COUNT(batch_id) AS batch_count,
    ROUND(SUM(net_weight_quintals), 2) AS total_net_quintals,
    ROUND(AVG(base_msp_per_quintal), 2) AS avg_base_msp,
    ROUND(AVG(realized_price_per_qtl), 2) AS avg_realized_price,
    ROUND(SUM(buyer_invoice_value_inr), 2) AS total_buyer_revenue_inr
FROM procurement_batches
GROUP BY crop_name, quality_grade
ORDER BY crop_name, quality_grade ASC;

-- Query 3: Logistics Transport Efficiency & Cost per Quintal
SELECT 
    center_name,
    ROUND(AVG(logistics_cost_inr / gross_weight_quintals), 2) AS avg_logistics_cost_per_qtl,
    ROUND(SUM(logistics_cost_inr), 2) AS total_logistics_spend_inr,
    ROUND(SUM(gross_weight_quintals), 2) AS total_volume_qtl,
    DENSE_RANK() OVER (ORDER BY AVG(logistics_cost_inr / gross_weight_quintals) DESC) AS transport_cost_rank
FROM procurement_batches
GROUP BY center_name
HAVING total_volume_qtl > 500.0
ORDER BY transport_cost_rank ASC;

-- Query 4: Financial Reconciliation Audit Query
SELECT 
    procurement_date,
    ROUND(SUM(buyer_invoice_value_inr), 2) AS total_buyer_invoices,
    ROUND(SUM(gross_farmer_payable_inr), 2) AS total_farmer_payables,
    ROUND(SUM(logistics_cost_inr), 2) AS total_logistics_costs,
    ROUND(SUM(fpo_handling_fee_inr), 2) AS total_handling_fees,
    ROUND(SUM(net_fpo_margin_inr), 2) AS calculated_net_fpo_margin,
    ROUND(SUM(buyer_invoice_value_inr - gross_farmer_payable_inr - logistics_cost_inr + fpo_handling_fee_inr - net_fpo_margin_inr), 2) AS audit_variance_inr
FROM procurement_batches
GROUP BY procurement_date
ORDER BY procurement_date ASC;
