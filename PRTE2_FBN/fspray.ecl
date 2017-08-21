IMPORT prte2;

EXPORT fSpray := FUNCTION

RETURN PARALLEL(
                  prte2.SprayFiles.Spray_Raw_Data('FBN2Keys__Business', 'business', 'fbnv2');
                  prte2.SprayFiles.Spray_Raw_Data('FBN2Keys__Contact', 'contact', 'fbnv2'));
                 
END;