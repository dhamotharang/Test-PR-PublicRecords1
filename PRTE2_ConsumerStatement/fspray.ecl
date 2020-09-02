IMPORT ut, std, prte2;

EXPORT fSpray := FUNCTION

RETURN PARALLEL(
                 prte2.SprayFiles.Spray_Raw_Data('prte__PersonContext_Base_Prod*.txt', 'Insurance', 'ConsumerStatement');
               );

END;