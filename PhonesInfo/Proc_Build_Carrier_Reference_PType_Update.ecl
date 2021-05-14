IMPORT _control, DeltabaseGateway, PromoteSupers, RoxieKeyBuild, Std;

EXPORT Proc_Build_Carrier_Reference_PType_Update(string version, string emailTarget):= FUNCTION
		
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	//Create LIDB PType CR Append Base File//////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////
	buildLIDBBase			:= output(PhonesInfo.Map_LIDB_Carrier_Reference_PType_Update,,'~thor_data400::base::phones::lidb_reference_cr_append_ptype_'+version, overwrite, __compressed__);

	//Clear Ported Metadata Base Delete Superfile
	clearLIDBDelete 	:= nothor(fileservices.clearsuperfile('~thor_data400::base::phones::lidb_reference_cr_append_ptype_delete', true));		

	//Move Ported Metadata Base Logical File to Appropriate Superfile
	moveLIDBBase			:= STD.File.PromoteSuperFileList(['~thor_data400::base::phones::lidb_reference_cr_append_ptype',
																											'~thor_data400::base::phones::lidb_reference_cr_append_ptype_father',
																											'~thor_data400::base::phones::lidb_reference_cr_append_ptype_delete'], '~thor_data400::base::phones::lidb_reference_cr_append_ptype_' + version, true);																						

	/////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	//Create Deltabase Gateway LIDB PType CR Append Base File////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////
	buildDGLBase			:= output(PhonesInfo.Map_Deltabase_LIDB_Carrier_Reference_PType_Update,,'~thor_data400::base::deltabase_gateway::lidb_historic_results_cr_append_ptype_' + version, overwrite, __compressed__);

	//Clear Ported Metadata Base Delete Superfile
	clearDGLDelete 		:= nothor(fileservices.clearsuperfile('~thor_data400::base::deltabase_gateway::lidb_historic_results_cr_append_ptype_delete', true));		

	//Move Ported Metadata Base Logical File to Appropriate Superfile
	moveDGLBase				:= STD.File.PromoteSuperFileList(['~thor_data400::base::deltabase_gateway::lidb_historic_results_cr_append_ptype',
																											'~thor_data400::base::deltabase_gateway::lidb_historic_results_cr_append_ptype_father',
																											'~thor_data400::base::deltabase_gateway::lidb_historic_results_cr_append_ptype_delete'], '~thor_data400::base::deltabase_gateway::lidb_historic_results_cr_append_ptype_' + version, true);																	
	
	////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	//Generate CR PMT Update Status Email///////////////////////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////////////////////////////////////////////////

	emailBuildNotice 	:= if(count(DeltabaseGateway.File_Deltabase_Gateway.Historic_LIDB_Results_CR_Append_PType(phone<>'')) > 0
																,fileservices.SendEmail(emailTarget, 'Phones Info: Carrier Reference Phone Type Update', 'Phones Info: Carrier Reference Phone Type Update Files Are Now Available.  Please see: ' + 'http://uspr-prod-thor-esp.risk.regn.net:8010/WsWorkunits/WUInfo?Wuid='+ workunit + '&Widget=WUDetailsWidget#/stub/Results-DL/Grid')
																,fileservices.SendEmail(emailTarget, 'Phones Info: Carrier Reference Phone Type Update', 'There Were No Updated Records In This Build')
													);		
	
	//Run Actions
	RETURN sequential(buildLIDBBase,
										clearLIDBDelete,
										moveLIDBBase,									
										buildDGLBase,
										clearDGLDelete,
										moveDGLBase,			
										emailBuildNotice
										);	
END;