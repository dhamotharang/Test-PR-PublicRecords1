// PRTE2_PropertyInfo.NEW_process_build_propertyinfo
// key_PropertyInfo_rid and key_PropertyInfo_address use Get_Payload 
//     which combines old and new payloads and then here we build the indexes

IMPORT PRTE2_PropertyInfo, PRTE2, PRTE_CSV, PropertyCharacteristics, ut, _control;

EXPORT NEW_process_build_propertyinfo (string	Filedate)	:= FUNCTION

			keyPropInfo_rid := build(key_PropertyInfo_rid(Filedate), update);
			
			keyPropInfo_Address := build(key_PropertyInfo_address(Filedate), update);

			// Not certain if these OUTPUTs are base files or just "persist" files for debugging?
			//  I think more just debugging
			RETURN SEQUENTIAL(
									OUTPUT (Get_Payload.EXISTING_PROPERTYINFOV2,,Files.Build_Existing_PII_OutputName,OVERWRITE),
									OUTPUT (Get_payload.NEW_PROPERTYINFOV2,,Files.Build_New_PII_OutputName,OVERWRITE),
									OUTPUT (Get_Payload.All_Expanded,,Files.Build_ALL_PII_OutputName,OVERWRITE),																
									PARALLEL(keyPropInfo_rid,keyPropInfo_Address)
									);
													
END;