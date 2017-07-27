/*--SOAP--
<message name="GongDaily">
</message>
*/

export Gong_Daily := MACRO


output(choosen(gong.key_did_add,10));
output(choosen(gong.key_hhid_add,10));
output(choosen(gong.key_address_add,10));
output(choosen(gong.key_remove,10));

output(choosen(DayBatchEda.Key_gong_add_phone,10));
output(choosen(DayBatchEda.key_gong_add_batch_czsslf,10));
output(choosen(DayBatchEda.key_gong_add_batch_lczf,10));

output(choosen(EDA_VIA_XML.Key_npa_nxx_line_add,10));
output(choosen(EDA_VIA_XML.Key_st_bizword_city_add,10));
output(choosen(EDA_VIA_XML.Key_st_city_prim_name_prim_range_add,10));
output(choosen(EDA_VIA_XML.Key_st_lname_city_add,10));
output(choosen(EDA_VIA_XML.Key_st_lname_fname_city_add,10));
output(choosen(gong.Key_daily_History_Phone,10));

output(choosen(gong.key_daily_history_address,10));
output(choosen(gong.Key_daily_History_Phone,10));
output(choosen(gong.Key_daily_History_Name,10));
output(choosen(gong.Key_daily_History_Zip_Name,10));

ENDMACRO;