//Copied from Gong_Neustar.Key_History_Phone, Gong_Neustar.Key_FCRA_History_Phone
IMPORT $, data_services, _control;
#IF(_Control.Environment.onVault) IMPORT vault; #END;


rec := $.layouts.i_history_phone;

keyed_fields := RECORD
  rec.p7;
  rec.p3;
  rec.st;
  rec.current_flag;
  rec.business_flag;
END;

fname (integer data_category) := IF (data_category = data_services.data_env.iFCRA,
                                     $.names().i_history_phone_fcra,
                                     $.names().i_history_phone);

EXPORT key_history_phone (integer data_category = 0) :=
#IF(_Control.Environment.onVault) // when running on vault cluster, we need to use the file pointer instead of the roxie key in boca
    vault.dx_Gong.key_history_phone(data_category);
#ELSE
    INDEX (keyed_fields, {rec - keyed_fields}, fname(data_category));
#END;
