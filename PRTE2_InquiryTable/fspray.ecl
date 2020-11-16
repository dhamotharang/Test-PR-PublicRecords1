IMPORT prte2;

EXPORT fSpray := FUNCTION

return  Parallel(prte2.SprayFiles.Spray_Raw_Data('inquiry__ins__', 'ins', 'inquiry'),
                 prte2.SprayFiles.Spray_Raw_Data('inquiry__base__', 'base', 'inquiry'),
								 prte2.SprayFiles.Spray_Raw_Data('inquiry__clone__', 'clone', 'inquiry')
						  	 );
								 
               
end;



