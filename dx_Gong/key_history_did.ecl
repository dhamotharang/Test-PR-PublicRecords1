//former: Gong_Neustar.Key_History_Did, Gong_Neustar.Key_FCRA_History_Did
IMPORT $, data_services, _control;
#IF(_Control.Environment.onVault) IMPORT vault; #END;

rec := $.layouts.i_history_did;

keyed_fields := RECORD
  rec.l_did;
  rec.current_flag;
  rec.business_flag;
END;

fname (integer data_category) := IF (data_category = data_services.data_env.iFCRA,
                                     $.names().i_history_did_fcra,
                                     $.names().i_history_did);

EXPORT key_history_did (integer data_category = 0) :=
#IF(_Control.Environment.onVault) // when running on vault cluster, we need to use the file pointer instead of the roxie key in boca
    vault.dx_Gong.key_history_did(data_category);
#ELSE
    INDEX (keyed_fields, {rec - keyed_fields}, fname(data_category));
#END;
