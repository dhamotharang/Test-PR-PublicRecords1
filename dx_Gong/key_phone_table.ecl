//former: risk_indicators.Key_Phone_Table_v2
//        Gong_Neustar.Key_FCRA_Business_Header_Phone_Table_Filtered_V2

IMPORT data_services;
IMPORT $;

rec := $.layouts.i_phone_table;

fname (integer data_category) := IF (data_category = data_services.data_env.iNonFCRA, 
                                     $.names().i_phone_table, 
                                     $.names().i_phone_table_ft_fcra);


EXPORT key_phone_table(integer data_category = 0) := INDEX ({rec.phone10}, rec, fname(data_category));
