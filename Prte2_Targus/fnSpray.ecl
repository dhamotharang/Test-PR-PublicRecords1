IMPORT ut, std, prte2;

EXPORT fnSpray := FUNCTION

RETURN SEQUENTIAL(
                   prte2.SprayFiles.Spray_Raw_Data('prte__TargusKeys__base__boca__*', 'Boca', 'Targus');
                   prte2.SprayFiles.Spray_Raw_Data('prte__TargusKeys__base__ins__*', 'INS', 'Targus');
                   
                 );
END;