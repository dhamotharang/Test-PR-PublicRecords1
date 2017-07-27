/*--SOAP--
<message name="GongWeekly">
</message>
*/

export GongKeys := MACRO

output(choosen(gong.key_did,10));
output(choosen(gong.key_hhid,10));
//output(choosen(gong.key_address,10));
output(choosen(doxie_cbrs.key_phone_gong,10));

output(choosen(DayBatchEda.Key_gong_phone,10));
output(choosen(DayBatchEda.key_gong_batch_czsslf,10));
output(choosen(DayBatchEda.key_gong_batch_lczf,10));

output(choosen(EDA_VIA_XML.Key_npa_nxx_line,10));
output(choosen(EDA_VIA_XML.Key_st_bizword_city,10));
output(choosen(EDA_VIA_XML.Key_st_city_prim_name_prim_range,10));
output(choosen(EDA_VIA_XML.Key_st_lname_city,10));
output(choosen(EDA_VIA_XML.Key_st_lname_fname_city,10));

output(choosen(gong.Key_History_Address,10));
output(choosen(gong.Key_History_Phone,10));
output(choosen(gong.Key_History_Did,10));
output(choosen(gong.Key_History_Hhid,10));
output(choosen(gong.Key_History_BDID,10));
output(choosen(gong.Key_History_Name,10));
output(choosen(gong.key_history_zip_name,10));
output(choosen(gong.key_history_npa_nxx_line,10));
output(choosen(gong.key_history_companyname,10));

output(choosen(risk_indicators.key_phone_table,10));
output(choosen(Risk_Indicators.key_phone_table_filtered,10));
//output(choosen(risk_indicators.key_phone_table_fcra,10));

output(choosen(gong.Key_History_Surname,10));

output(choosen(Relocations.key_wdtgGong,10));
output(choosen(Risk_Indicators.Key_Phone_Table_FCRA_v2,10));
output(choosen(Risk_Indicators.Key_Phone_Table_v2,10));
output(choosen(Gong.key_bdid,10));
output(choosen(gong.key_history_city_st_name,10));
output(choosen(Gong.key_history_wild_name_zip,10));
output(choosen(gong.key_cn,10));
output(choosen(gong.key_cn_to_company,10));
output(choosen(gong.key_address_current,10));
output(choosen(gong.Key_SurnameCount,10));

output(choosen(Gong.Key_Npa,10));
output(choosen(Gong.Key_Zip,10));


ENDMACRO;