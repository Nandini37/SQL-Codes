-- First, create a view or CTE for the base TAM/SAM data
WITH base_data AS (
    SELECT *
    FROM tamsam
),

-- Create separate rows for TAM measures
tam_measures AS (
    SELECT 
        segment_lvl_2,
        segment_lvl_3,
        gmpl,
        technology,
        year,
        pvt.measure_type,
        pvt.value
    FROM base_data
    CROSS APPLY (
        SELECT 'ABI TAM Units' as measure_type, abi_tam_units as value UNION ALL
        SELECT 'TSR TAM Units', tsr_tam_units UNION ALL
        SELECT 'Omdia TAM Units', omdia_tam_units UNION ALL
        SELECT 'Omdia TAM ASP', omdia_tam_asp UNION ALL
        SELECT 'Omdia TAM Rev', omdia_tam_rev UNION ALL
        SELECT 'Seg Mgr TAM Units', seg_mgr_tam_units UNION ALL
        SELECT 'Seg Mgr TAM ASP', seg_mgr_tam_asp UNION ALL
        SELECT 'Seg Mgr TAM Rev', seg_mgr_tam_rev UNION ALL
        SELECT 'Non-customer identified TAM Rev', non_customer_identified_tam_rev UNION ALL
        SELECT 'TAM identified Rev %', tam_identified_rev_pct
    ) pvt
),

-- Create separate rows for SAM measures
sam_measures AS (
    SELECT 
        segment_lvl_2,
        segment_lvl_3,
        gmpl,
        technology,
        year,
        pvt.measure_type,
        pvt.value
    FROM base_data
    CROSS APPLY (
        SELECT 'ABI SAM Units' as measure_type, abi_sam_units as value UNION ALL
        SELECT 'TSR SAM Units', tsr_sam_units UNION ALL
        SELECT 'Omdia SAM Units', omdia_sam_units UNION ALL
        SELECT 'Omdia SAM ASP', omdia_sam_asp UNION ALL
        SELECT 'Omdia SAM Rev', omdia_sam_rev UNION ALL
        SELECT 'Seg Mgr SAM Units', seg_mgr_sam_units UNION ALL
        SELECT 'Seg Mgr SAM ASP', seg_mgr_sam_asp UNION ALL
        SELECT 'Seg Mgr SAM Rev', seg_mgr_sam_rev UNION ALL
        SELECT 'SAM/TAM Ratio Rev', sam_tam_ratio_rev UNION ALL
        SELECT 'SAM Comment', sam_comment
    ) pvt
)

-- Final result combining TAM and SAM measures with mapping information
SELECT 
    u.*,
    m.Source,
    m.Type,
    m.Measure
FROM (
    SELECT * FROM tam_measures
    UNION ALL
    SELECT * FROM sam_measures
) u
LEFT JOIN explode_mapping m ON u.measure_type = m.Field_Name
ORDER BY 
    segment_lvl_2,
    segment_lvl_3,
    gmpl,
    technology,
    year,
    measure_type;
