IMPORT $, Data_Services, _Control;
#IF(_Control.Environment.onVault) IMPORT vault; #END;

keyed_fields := $.layouts.keyed_fields;
payload := $.layouts.payload;

fname (integer data_category) := IF (data_category = data_services.data_env.iFCRA,
                                     $.names().i_suppression_fcra,
                                     $.names().i_suppression); 
			   
EXPORT key_suppression(integer data_category = 0) :=
#IF(_Control.Environment.onVault) // when running on vault cluster, we need to use the file pointer instead of the roxie key in boca
    vault.Suppress.Key_New_Suppression(true);
#ELSE
    INDEX (keyed_fields, payload, fname(data_category));
#END;
