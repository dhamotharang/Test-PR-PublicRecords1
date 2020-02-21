IMPORT ut, std, prte2;

EXPORT fnSpray := FUNCTION

RETURN PARALLEL(
                 prte2.SprayFiles.Spray_Raw_Data('prte__ThriveKeys__INS__base*.txt', 'INS', 'Thrive');
               );

END;