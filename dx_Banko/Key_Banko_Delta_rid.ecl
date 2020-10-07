IMPORT $, Data_Services,dx_common;

rec := dx_common.layout_ridkey;

Keyfields := record
rec.record_sid;
end;

EXPORT Key_Banko_Delta_rid (UNSIGNED1 data_env = Data_Services.data_env.iNonFCRA) := 
                                       INDEX(Keyfields, rec - Keyfields, $.names(data_env).i_DeltaRID);
																			 