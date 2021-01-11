IMPORT $, Data_Services;

rec := $.Layout.i_tcpa_phone_history;

EXPORT Key_TCPA_Phone_History(UNSIGNED1 data_env = Data_Services.data_env.iNonFCRA):= INDEX({rec.phone}, 
																																														rec,
																																														$.Names(data_env).i_tcpa_phone_history);