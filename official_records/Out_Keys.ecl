import RoxieKeyBuild,ut,roxiekeybuild;

// ***BEFORE RUNNING, Don't forget to update the Version Development attribute with the 
// new build date

//MAC_SK_BuildProcess_Local(theindexprep, keyname, superkeyname, seq_name, numgenerations = '3', one_node = 'false') := macro
RoxieKeyBuild.Mac_SK_BuildProcess_Local(official_records.Key_Document_ORID
 ,'~thor_200::key::official_records_document::' + official_records.Version_Development + '::orid'
 ,'~thor_200::key::official_records_document_orid',bk_doc,2);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(official_records.Key_Party_ORID
 ,'~thor_200::key::official_records_party::' + official_records.Version_Development + '::orid'
 ,'~thor_200::key::official_records_party_orid',bk_party,2);

// Move all the keys to Built
RoxieKeyBuild.Mac_SK_Move_To_Built(
  '~thor_200::key::official_records_document::' + official_records.Version_Development + '::orid'
 ,'~thor_200::key::official_records_document_orid',move1);
RoxieKeyBuild.Mac_SK_Move_To_Built(
  '~thor_200::key::official_records_party::' + official_records.Version_Development + '::orid'
 ,'~thor_200::key::official_records_party_orid',move2);

move_build_keys := parallel(move1,move2);

// Move all the keys to QA
roxiekeybuild.Mac_SK_Move('~thor_200::key::official_records_document_orid','Q', moveq1);
roxiekeybuild.Mac_SK_Move('~thor_200::key::official_records_party_orid','Q', moveq2);

move_qa_keys := parallel(moveq1,moveq2);
															 
export Out_Keys := sequential(
										   parallel(bk_doc,bk_party)
										   ,move_build_keys
										   ,move_qa_keys);
