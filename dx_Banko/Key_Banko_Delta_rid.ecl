IMPORT $, Data_Services,dx_common;

rec := dx_common.layout_ridkey;

Keyfields := RECORD
rec.record_sid;
END;

EXPORT Key_Banko_Delta_rid (UNSIGNED1 data_env = Data_Services.data_env.iNonFCRA) := 
                                       INDEX(Keyfields, rec - Keyfields, $.names(data_env).i_DeltaRID);
																			 