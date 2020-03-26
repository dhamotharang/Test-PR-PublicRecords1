IMPORT prte2;

EXPORT fSpray_CCPA_GlobalSid:= FUNCTION

RETURN prte2.SprayFiles.Spray_Raw_Data('prte_ccpa_global_sid','','ccpa_global');

END;