IMPORT prte2;

EXPORT fSpray := FUNCTION
		
prte2.SprayFiles.Spray_Raw_Data('ln_propertyV2__base__tax', 'tax', 'ln_propertyv2',true);
	
prte2.SprayFiles.Spray_Raw_Data('ln_propertyV2__base__deed', 'deed', 'ln_propertyv2',true);

prte2.SprayFiles.Spray_Raw_Data('ln_propertyV2__base__search', 'search', 'ln_propertyv2',true);

return 'success';

END;