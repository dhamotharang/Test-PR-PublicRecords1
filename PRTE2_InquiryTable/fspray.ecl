IMPORT prte2;

EXPORT fSpray := FUNCTION

RETURN PARALLEL(
       prte2.SprayFiles.Spray_Raw_Data('inquiry__persons_1__', 'persons_1', 'inquiry'),
       prte2.SprayFiles.Spray_Raw_Data('inquiry__business_1__', 'business_1', 'inquiry'),
			 prte2.SprayFiles.Spray_Raw_Data('inquiry__business_2__', 'business_2', 'inquiry')
			);

end;



