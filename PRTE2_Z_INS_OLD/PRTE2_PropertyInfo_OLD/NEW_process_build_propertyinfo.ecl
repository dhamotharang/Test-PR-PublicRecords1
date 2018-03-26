/* **************************************************************************************************
PRTE2_PropertyInfo.NEW_process_build_propertyinfo 
APRIL 2017 - for now the Boca layout file is just in memory - eventually make it a real base file
that the Boca build process can read (whenever Boca creates an actual build process).
**************************************************************************************************
 		key_PropertyInfo_rid and key_PropertyInfo_address use Get_Payload 
    which combines old and new payloads and then here we build the indexes
    CORRECTION: We found Property Info only has Ins. payload
************************************************************************************************** */

IMPORT PRTE2_PropertyInfo, PromoteSupers;

EXPORT NEW_process_build_propertyinfo (string	Filedate)	:= FUNCTION

			//TODO - for now the next 5 lines call get_payload over and over -make sure it only does the work 1 time
			keyPropInfo_rid := build(key_PropertyInfo_rid(Filedate), update);
			
			keyPropInfo_Address := build(key_PropertyInfo_address(Filedate), update);

			// These outputs were in the original code, so I'll just keep overwriting them for audit steps if needed.
			out1 := OUTPUT (Get_Payload.EXISTING_PROPERTYINFOV2,,Files.Build_Existing_PII_OutputName,OVERWRITE);
			out2 := OUTPUT (Get_payload.NEW_PROPERTYINFOV2,,Files.Build_New_PII_OutputName,OVERWRITE);
			out3 := OUTPUT (Get_Payload.All_Expanded,,Files.Build_ALL_PII_OutputName,OVERWRITE);													
			
			// --------- NEW SECTION TO BEGIN SAVING A BASE FILE COMPATIBLE WITH MAPView needs ------------
			build_MV_base := PRTE2_PropertyInfo.Save_MV_Base;
			// --------- END: NEW SECTION TO BEGIN SAVING A BASE FILE COMPATIBLE WITH MAPView needs ------------

			RETURN SEQUENTIAL( out1, out2, out3
												, build_MV_base
												, PARALLEL(keyPropInfo_rid,keyPropInfo_Address)
									);
													
END;