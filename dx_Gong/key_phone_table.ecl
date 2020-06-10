//former: risk_indicators.Key_Phone_Table_v2
//        Gong_Neustar.Key_FCRA_Business_Header_Phone_Table_Filtered_V2

IMPORT data_services, _control;
IMPORT $;
#IF(_Control.Environment.onVault) IMPORT vault; #END;

rec := $.layouts.i_phone_table;

fname (integer data_category) := IF (data_category = data_services.data_env.iNonFCRA,
                                     $.names().i_phone_table,
                                     $.names().i_phone_table_ft_fcra);


EXPORT key_phone_table(integer data_category = 0) :=
#IF(_Control.Environment.onVault) // when running on vault cluster, we need to use the file pointer instead of the roxie key in boca
    vault.dx_Gong.key_phone_table(data_category);
#ELSE
    INDEX ({rec.phone10}, rec, fname(data_category));
#END;
