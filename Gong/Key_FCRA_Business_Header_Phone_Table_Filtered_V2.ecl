import doxie, gong, risk_indicators, data_services, vault, _control;

r := risk_indicators.Phone_Table_v2 (TRUE, TRUE); //fcra=true


#IF(_Control.Environment.onVault) // when running on vault cluster, we need to use the file pointer instead of the roxie key in boca
export Key_FCRA_Business_Header_Phone_Table_Filtered_V2 := vault.Gong.Key_FCRA_Business_Header_Phone_Table_Filtered_V2;
#ELSE
export Key_FCRA_Business_Header_Phone_Table_Filtered_V2 := index(r, {phone10}, {r}, data_services.data_location.prefix() + 'thor_data400::key::business_header::filtered::fcra::qa::hri::phone10_v2');
#END;

