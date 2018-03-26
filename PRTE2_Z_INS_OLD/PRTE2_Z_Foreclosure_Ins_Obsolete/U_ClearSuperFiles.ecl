IMPORT PRTE2_Common;

EXPORT U_ClearSuperFiles := FUNCTION
	basePrefix		:= 
	keyPrefix			:= Files.Key_Prefix_Name + '::';
	autoKeyPrefix	:= Files.Suffix_Name_AutoKey + '::';
	
	clear1			:= PRTE2_Common.SuperFiles.Clear(autoKeyPrefix + CustomerTest_CLDA.Files.Suffix_Name_Address + '_qa');
						
	sequentialSteps := SEQUENTIAL(
													clear1,
											);	
											
	RETURN sequentialSteps;
END;