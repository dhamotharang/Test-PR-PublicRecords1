IMPORT ut, std, prte2;

EXPORT fSpray := FUNCTION
	RETURN prte2.SprayFiles.Spray_Raw_Data('prte__SBFE__base','denormalized','sbfe');
END;