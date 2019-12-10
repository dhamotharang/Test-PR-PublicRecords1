IMPORT prte2;

EXPORT fspray := FUNCTION

RETURN Sequential(
       prte2.SprayFiles.Spray_Raw_Data('irskeys__boca__', 'boca', 'irskeys'),

       prte2.SprayFiles.Spray_Raw_Data('irskeys__alpha__', 'alpha', 'irskeys')
       ); 
					
END;


