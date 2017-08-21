IMPORT ut, std, prte2;

EXPORT fSpray := FUNCTION
	RETURN prte2.SprayFiles.Spray_Raw_Data('MDV2Keys__base_','main_base','mar_div');
END;