IMPORT dx_Gong, data_services, risk_indicators;

EXPORT data_key_phone_table(integer data_category = 0, boolean filtered = FALSE) := FUNCTION

  ds_file := risk_indicators.Phone_Table_v2 (data_category = data_services.data_env.iFCRA, filtered);

  RETURN PROJECT(ds_file, dx_Gong.layouts.i_phone_table);
END;

