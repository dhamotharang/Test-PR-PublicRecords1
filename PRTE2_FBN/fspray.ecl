IMPORT prte2;

EXPORT fSpray := FUNCTION

RETURN PARALLEL(
                  prte2.SprayFiles.Spray_Raw_Data('FBN2Keys__Business', 'business', 'fbnv2'),
                  prte2.SprayFiles.Spray_Raw_Data('FBN2Keys__Contact', 'contact', 'fbnv2'),
									prte2.SprayFiles.Spray_Raw_Data('FBN2KeysIns__Business', 'business::ins', 'fbnv2'),
                  prte2.SprayFiles.Spray_Raw_Data('FBN2KeysIns__Contact', 'contact::ins', 'fbnv2')
									);
									
                 
END;