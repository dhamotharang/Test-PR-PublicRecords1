/* *********************************************************************************************
Copying the details in PropertyCharacteristics.Key_PropChar_Address
********************************************************************************************* */
IMPORT doxie, PRTE_CSV;

// This was originally all in NEW_process_build_propertyinfo, so search history there to see older changes

EXPORT key_PropertyInfo_address(STRING Filedate, BOOLEAN foreignProd=FALSE)  := FUNCTION

		All_Expanded := Files.Alpha_PII_Final_Base_DS(prim_name	!=	''	and	prim_range	!=	''	and	zip	!=	'');
		// -----------------------------------------------------------------------------------------------------
		// If foreignProd not specified as true then just build the key name for whatever environment you are in.
		// -----------------------------------------------------------------------------------------------------
		STRING keyFileName := IF(foreignProd,Files.BuildKeyADDRNameProd(Filedate),Files.BuildKeyADDRName(Filedate));

		RETURN	index( All_Expanded,
									{prim_name,prim_range,zip,predir,postdir,addr_suffix,sec_range},
									{property_rid},
									keyFileName
								);


END;