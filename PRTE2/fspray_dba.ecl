IMPORT prte2;

EXPORT fSpray_dba := FUNCTION

return prte2.SprayFiles.Spray_Raw_Data('lnpr__base__dba', 'dba', 'lnpr');

END;