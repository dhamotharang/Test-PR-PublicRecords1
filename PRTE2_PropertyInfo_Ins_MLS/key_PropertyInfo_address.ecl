/* ************************************************************************************************************************
**********************************************************************************************
***** MLS CONVERSION NOTES:
**********************************************************************************************
OLDER NOTES:
Copying the main details in PropertyCharacteristics.Key_PropChar_Address
************************************************************************************************************************ */

IMPORT doxie, PRTE_CSV;

EXPORT key_PropertyInfo_address(STRING Filedate, DATASET(Layouts.Boca_Official_Layout) InData, BOOLEAN foreignProd=FALSE)  := FUNCTION

		All_Expanded := InData(prim_name	!=	''	and	prim_range	!=	''	and	zip	!=	'');
		// -----------------------------------------------------------------------------------------------------
		// If foreignProd not specified as true then just build the key name for whatever environment you are in.
		// only used for reading the foreign key
		// -----------------------------------------------------------------------------------------------------
		STRING keyFileName := IF(foreignProd,Files.BuildKeyADDRNameProd(Filedate),Files.BuildKeyADDRName(Filedate));

		RETURN	index( All_Expanded,
									{prim_name,prim_range,zip,predir,postdir,addr_suffix,sec_range},
									{property_rid},
									keyFileName
								);


END;