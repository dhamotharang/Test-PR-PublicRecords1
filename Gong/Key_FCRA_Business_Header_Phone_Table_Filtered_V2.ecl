import doxie, gong, risk_indicators;

r := risk_indicators.Phone_Table_v2 (TRUE, TRUE); //fcra=true

export Key_FCRA_Business_Header_Phone_Table_Filtered_V2 := index(r, {phone10}, {r}, '~thor_data400::key::business_header::filtered::fcra::qa::hri::phone10_v2');