/* ************************************************************************************************************************
**********************************************************************************************
***** MLS CONVERSION NOTES:
**********************************************************************************************
OLDER NOTES:
PRTE2_PropertyInfo_Ins_MLS.proc_build_propertyinfo 
APRIL 2017 - for now the Boca layout file is just in memory - eventually make it a real base file
that the Boca build process can read (whenever Boca creates an actual build process).
**************************************************************************************************
 		key_PropertyInfo_rid and key_PropertyInfo_address use Get_Payload 
    which combines old and new payloads and then here we build the indexes
    CORRECTION: We found Property Info only has Ins. payload
************************************************************************************************************************ */

IMPORT PRTE2_PropertyInfo_Ins_MLS, PromoteSupers, RoxieKeyBuild, PRTE2_Common;

EXPORT proc_build_propertyinfo (string	Filedate)	:= FUNCTION

		All_Expanded := Get_Payload.All_Expanded;		// no longer does record generation, just layout work.
		Key_Prefix := '~prte::key::propertyinfo';
		create_Addr_SFs := PRTE2_Common.SuperFiles.Create(Key_Prefix, 'address');
		create_RID_SFs := PRTE2_Common.SuperFiles.Create(Key_Prefix, 'rid');
		// MAC_SK_BuildProcess_v2_local(theindexprep, superkeyname, lkeyname, seq_name, one_node = 'false', diffing = 'false')
		RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(key_PropertyInfo_rid(Filedate,All_Expanded), 
											Files.BuildKeyRIDSimple,
											Files.BuildKeyRIDName(Filedate),
											bld_RID_key);
		RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(key_PropertyInfo_address(Filedate,All_Expanded), 
											Files.BuildKeyADDRSimple,
											Files.BuildKeyADDRName(Filedate),
											bld_Addr_key);

		//Move keys to built
		// Mac_SK_Move_to_Built_v2(superkeyname,lkeyname,seq_name,one_node = 'false',diffing = 'false',mbld = 'false')
		Roxiekeybuild.Mac_SK_Move_to_Built_v2(Files.BuildKeyRIDVName, Files.BuildKeyRIDName(Filedate),mv_rid_key);
		Roxiekeybuild.Mac_SK_Move_to_Built_v2(Files.BuildKeyADDRVName, Files.BuildKeyADDRName(Filedate),mv_addr_key);
		//Move keys to QA
		RoxieKeyBuild.Mac_SK_Move_V2(Files.BuildKeyRIDVName,'Q', mv_rid_QA);
		RoxieKeyBuild.Mac_SK_Move_V2(Files.BuildKeyADDRVName,'Q', mv_addr_QA);

		PromoteSupers.Mac_SF_BuildProcess(All_Expanded, Files.Alpha_PII_Final_Base_Name, buildFinalBase);
		
		// --------- NEW SECTION TO BEGIN SAVING A BASE FILE COMPATIBLE WITH MAPView needs ------------
		// early info indicated a different layout - did not happen but they have a different name in their code.
		MV_Base_Name := Files.ALPHA_MV_BASE_SF;
		PromoteSupers.Mac_SF_BuildProcess(All_Expanded, MV_Base_Name, build_MV_base);
		// --------- END: NEW SECTION TO BEGIN SAVING A BASE FILE COMPATIBLE WITH MAPView needs ------------



			RETURN SEQUENTIAL( buildFinalBase
												, build_MV_base
												, create_Addr_SFs, create_RID_SFs
												, PARALLEL(bld_RID_key,bld_Addr_key)
												, PARALLEL(mv_rid_key,mv_addr_key)
												, PARALLEL(mv_rid_QA,mv_addr_QA)
									);
													
END;
