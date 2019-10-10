import doxie, gong, risk_indicators;

r := risk_indicators.Phone_Table_v2 (TRUE, TRUE); //fcra=true
//CCPA-22 exlcude ccpa fields in this FCRA key to reduce the impact of layout change
layout_key := RECORDOF(r) - [did,global_sid,record_sid];
r_final := project(r,layout_key);

export Key_FCRA_Business_Header_Phone_Table_Filtered_V2 := index(r_final, {phone10}, {r_final}, '~thor_data400::key::business_header::filtered::fcra::qa::hri::phone10_v2');