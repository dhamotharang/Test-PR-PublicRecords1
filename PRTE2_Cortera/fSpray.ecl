IMPORT ut, std, prte2;

EXPORT fSpray := FUNCTION

RETURN PARALLEL(
                 prte2.SprayFiles.Spray_Raw_Data('Cortera_base', 'Boca', 'Cortera');
                 prte2.SprayFiles.Spray_Raw_Data('Cortera_INS_base', 'Insurance', 'Cortera');
               );

END;