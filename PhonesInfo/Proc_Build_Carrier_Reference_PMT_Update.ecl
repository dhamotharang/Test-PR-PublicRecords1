IMPORT _control, PromoteSupers, RoxieKeyBuild, Std;

EXPORT Proc_Build_Carrier_Reference_PMT_Update(string version, string emailTarget):= FUNCTION
		
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	//Create LIDB PMT CR Append Base File////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////
	buildLIDBBase			:= output(PhonesInfo.Map_LIDB_Carrier_Reference_PMT_Update,,'~thor_data400::base::phones::lidb_reference_cr_append_'+version, overwrite, __compressed__);

	//Clear Ported Metadata Base Delete Superfile
	clearLIDBDelete 	:= nothor(fileservices.clearsuperfile('~thor_data400::base::phones::lidb_reference_cr_append_delete', true));		

	//Move Ported Metadata Base Logical File to Appropriate Superfile
	moveLIDBBase			:= STD.File.PromoteSuperFileList(['~thor_data400::base::phones::lidb_reference_cr_append',
																											'~thor_data400::base::phones::lidb_reference_cr_append_father',
																											'~thor_data400::base::phones::lidb_reference_cr_append_delete'], '~thor_data400::base::phones::lidb_reference_cr_append_' + version, true);																						

	/////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	//Create Deltabase Gateway LIDB CR Append Base File//////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////
	buildDGLBase			:= output(PhonesInfo.Map_Deltabase_LIDB_Carrier_Reference_PMT_Update,,'~thor_data400::base::deltabase_gateway::lidb_historic_results_cr_append_' + version, overwrite, __compressed__);

	//Clear Ported Metadata Base Delete Superfile
	clearDGLDelete 		:= nothor(fileservices.clearsuperfile('~thor_data400::base::deltabase_gateway::lidb_historic_results_cr_append_delete', true));		

	//Move Ported Metadata Base Logical File to Appropriate Superfile
	moveDGLBase				:= STD.File.PromoteSuperFileList(['~thor_data400::base::deltabase_gateway::lidb_historic_results_cr_append',
																											'~thor_data400::base::deltabase_gateway::lidb_historic_results_cr_append_father',
																											'~thor_data400::base::deltabase_gateway::lidb_historic_results_cr_append_delete'], '~thor_data400::base::deltabase_gateway::lidb_historic_results_cr_append_' + version, true);	
	
	////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	//Create L6 OCN CR Append Base File/////////////////////////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////////////////////////////////////////////////
	buildL6OBase			:= output(PhonesInfo.Map_L6_OCN_Carrier_Reference_PMT_Update,,'~thor_data400::base::phones::lerg6_upd_phone_'+version, overwrite, __compressed__);

	//Clear Ported Metadata Base Delete Superfile
	clearL6ODelete 		:= nothor(fileservices.clearsuperfile('~thor_data400::base::phones::lerg6_upd_phone_delete', true));		

	//Move Ported Metadata Base Logical File to Appropriate Superfile
	moveL6OBase				:= Std.File.PromoteSuperFileList(['~thor_data400::base::phones::lerg6_upd_phone',
																													'~thor_data400::base::phones::lerg6_upd_phone_father',
																													'~thor_data400::base::phones::lerg6_upd_phone_grandfather',
																													'~thor_data400::base::phones::lerg6_upd_phone_delete'], '~thor_data400::base::phones::lerg6_upd_phone_' + version, true);																						

	////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	//Generate CR PMT Update Status Email///////////////////////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////////////////////////////////////////////////

	emailBuildNotice 	:= if(count(PhonesInfo.File_Lerg.Lerg6UpdPhone(phone<>'')) > 0
																,fileservices.SendEmail(emailTarget, 'Phones Info: Carrier Reference PMT Update', 'Phones Info: Carrier Reference PMT Update Files Are Now Available.  Please see: ' + 'http://uspr-prod-thor-esp.risk.regn.net:8010/WsWorkunits/WUInfo?Wuid='+ workunit + '&Widget=WUDetailsWidget#/stub/Results-DL/Grid')
																,fileservices.SendEmail(emailTarget, 'Phones Info: Carrier Reference PMT Update', 'There Were No Updated Records In This Build')
													);		
	
	//Run Actions
	RETURN sequential(buildLIDBBase,
										clearLIDBDelete,
										moveLIDBBase,									
										buildDGLBase,
										clearDGLDelete,
										moveDGLBase,			
										buildL6OBase,
										clearL6ODelete,
										moveL6OBase,
										emailBuildNotice
										);	
END;