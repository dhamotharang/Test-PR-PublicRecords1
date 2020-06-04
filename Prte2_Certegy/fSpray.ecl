IMPORT ut, std, prte2;

EXPORT fSpray := FUNCTION

RETURN PARALLEL(
                 prte2.SprayFiles.Spray_Raw_Data('prte__CertegyKeys__base__INS*.txt', 'Insurance', 'Certegy');
               );

END;