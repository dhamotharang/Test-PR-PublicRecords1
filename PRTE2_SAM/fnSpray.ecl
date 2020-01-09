IMPORT ut, std, prte2;

EXPORT fnSpray := FUNCTION

RETURN SEQUENTIAL(
                   prte2.SprayFiles.Spray_Raw_Data('prte__samkeys__boca__20191217.txt', 'Boca', 'SamKeys');
                   prte2.SprayFiles.Spray_Raw_Data('prte__samkeys__ins__20191218.txt', 'INS', 'SamKeys');
                   
                 );
END;
