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
        measure_type,
        value
    FROM base_data
    CROSS APPLY (VALUES 
        ('ABI TAM Units', abi_tam_units),
        ('TSR TAM Units', tsr_tam_units),
        ('Omdia TAM Units', omdia_tam_units),
        ('Omdia TAM ASP', omdia_tam_asp),
        ('Omdia TAM Rev', omdia_tam_rev),
        ('Seg Mgr TAM Units', seg_mgr_tam_units),
        ('Seg Mgr TAM ASP', seg_mgr_tam_asp),
        ('Seg Mgr TAM Rev', seg_mgr_tam_rev),
        ('Non-customer identified TAM Rev', non_customer_identified_tam_rev),
        ('TAM identified Rev %', tam_identified_rev_pct)
    ) AS unpvt(measure_type, value)
),

-- Create separate rows for SAM measures
sam_measures AS (
    SELECT 
        segment_lvl_2,
        segment_lvl_3,
        gmpl,
        technology,
        year,
        measure_type,
        value
    FROM base_data
    CROSS APPLY (VALUES 
        ('ABI SAM Units', abi_sam_units),
        ('TSR SAM Units', tsr_sam_units),
        ('Omdia SAM Units', omdia_sam_units),
        ('Omdia SAM ASP', omdia_sam_asp),
        ('Omdia SAM Rev', omdia_sam_rev),
        ('Seg Mgr SAM Units', seg_mgr_sam_units),
        ('Seg Mgr SAM ASP', seg_mgr_sam_asp),
        ('Seg Mgr SAM Rev', seg_mgr_sam_rev),
        ('SAM/TAM Ratio Rev', sam_tam_ratio_rev),
        ('SAM Comment', sam_comment)
    ) AS unpvt(measure_type, value)
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
