/* **************************************************************************************************
PRTE2_PropertyInfo_Ins.NEW_process_build_propertyinfo 
APRIL 2017 - for now the Boca layout file is just in memory - eventually make it a real base file
that the Boca build process can read (whenever Boca creates an actual build process).
**************************************************************************************************
 		key_PropertyInfo_rid and key_PropertyInfo_address use Get_Payload 
    which combines old and new payloads and then here we build the indexes
    CORRECTION: We found Property Info only has Ins. payload
************************************************************************************************** */

IMPORT PRTE2_PropertyInfo_Ins, PromoteSupers;

EXPORT NEW_process_build_propertyinfo (string	Filedate)	:= FUNCTION

			//TODO - for now the next 5 lines call get_payload over and over -make sure it only does the work 1 time
			keyPropInfo_rid := build(key_PropertyInfo_rid(Filedate), update);
			
			keyPropInfo_Address := build(key_PropertyInfo_address(Filedate), update);
			All_Expanded := Get_Payload.All_Expanded;
			PromoteSupers.Mac_SF_BuildProcess(All_Expanded, Files.Alpha_PII_Final_Base_Name, buildFinalBase);
			
			// --------- NEW SECTION TO BEGIN SAVING A BASE FILE COMPATIBLE WITH MAPView needs ------------
			// early info indicated a different layout - did not happen but they have a different name in their code.
			MV_Base_Name := Files.ALPHA_MV_BASE_SF;
			PromoteSupers.Mac_SF_BuildProcess(All_Expanded, MV_Base_Name, build_MV_base);
			// --------- END: NEW SECTION TO BEGIN SAVING A BASE FILE COMPATIBLE WITH MAPView needs ------------

			RETURN SEQUENTIAL( buildFinalBase
												, build_MV_base
												, PARALLEL(keyPropInfo_rid,keyPropInfo_Address)
									);
													
END;