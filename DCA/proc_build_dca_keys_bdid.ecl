import ut, roxiekeybuild, _control;

// Set the file date you require below, 
// otherwise it will try dca.version, if that is empty, it will use thorlib.wuid()[2..9] 

export proc_build_dca_keys_bdid(string filedate) := function

// Build Roxie Keys

roxiekeybuild.MAC_SK_BuildProcess_v2_local(DCA.Key_DCA_BDID, '', 
                                           '~thor_data400::key::dca::'+filedate+'::bdid', a1);
roxiekeybuild.MAC_SK_BuildProcess_v2_local(DCA.Key_DCA_Root_Sub, '', 
                                           '~thor_data400::key::dca::'+filedate+'::root_sub', a2);
roxiekeybuild.MAC_SK_BuildProcess_v2_local(DCA.Key_DCA_Hierarchy_BDID, '', 
                                           '~thor_data400::key::dca::'+filedate+'::hierarchy_bdid', a3);
roxiekeybuild.MAC_SK_BuildProcess_v2_local(DCA.Key_DCA_Hierarchy_Root_Sub, '', 
                                           '~thor_data400::key::dca::'+filedate+'::hierarchy_root_sub', a4);
roxiekeybuild.MAC_SK_BuildProcess_v2_local(DCA.Key_DCA_Hierarchy_Parent_to_Child_Root_Sub, '', 
																					 '~thor_data400::key::dca::'+filedate+'::hierarchy_parent_to_child_root_sub', a5);

//Move the new roxie keys to built superfile

roxiekeybuild.mac_sk_move_to_built_v2('~thor_data400::key::dca_bdid',
                                      '~thor_data400::key::dca::'+filedate+'::bdid', b1);
roxiekeybuild.mac_sk_move_to_built_v2('~thor_data400::key::dca_root_sub',
                                      '~thor_data400::key::dca::'+filedate+'::root_sub', b2);
roxiekeybuild.mac_sk_move_to_built_v2('~thor_data400::key::dca_hierarchy_bdid',
                                      '~thor_data400::key::dca::'+filedate+'::hierarchy_bdid', b3);
roxiekeybuild.mac_sk_move_to_built_v2('~thor_data400::key::dca_hierarchy_root_sub',
                                      '~thor_data400::key::dca::'+filedate+'::hierarchy_root_sub', b4);
roxiekeybuild.mac_sk_move_to_built_v2('~thor_data400::key::dca_hierarchy_parent_to_child_root_sub',
                                      '~thor_data400::key::dca::'+filedate+'::hierarchy_parent_to_child_root_sub', b5);

// Move the new roxie keys from built to QA superfile

ut.mac_sk_move_v2('~thor_data400::key::dca_bdid','Q',c1,2);
ut.mac_sk_move_v2('~thor_data400::key::dca_root_sub','Q',c2,2);
ut.mac_sk_move_v2('~thor_data400::key::dca_hierarchy_bdid','Q',c3,2);
ut.mac_sk_move_v2('~thor_data400::key::dca_hierarchy_root_sub','Q',c4,2);
ut.mac_sk_move_v2('~thor_data400::key::dca_hierarchy_parent_to_child_root_sub','Q',c5,2);


// Build Autokeys

build_autokeys := dca.proc_build_autokey (filedate);

// Email notification 

jobComplete := FileServices.sendemail('roxiebuilds@seisint.com,'+_control.MyInfo.EmailAddressNotify, ' DCA Roxie Key Build Succeeded - ' + filedate,
               'Keys: 1) thor_data400::key::dca_bdid_qa(thor_data400::key::dca::'+filedate+'::bdid),\n' + 
					     '      2) thor_data400::key::dca_root_sub_qa(thor_data400::key::dca::'+filedate+'::root_sub),\n' + 
					     '      3) thor_data400::key::dca_hierarchy_bdid_qa(thor_data400::key::dca::'+filedate+'::hierarchy_bdid),\n' + 
					     '      4) thor_data400::key::dca_hierarchy_root_sub_qa(thor_data400::key::dca::'+filedate+'::hierarchy_root_sub),\n' + 
					     '      5) thor_data400::key::dca_hierarchy_parent_to_child_root_sub_qa(thor_data400::key::dca::'+filedate+'::hierarchy_parent_to_child_root_sub),\n' + 
					     '      6) thor_data400::key::dca::autokey(thor_data400::key::dca::'+filedate+'::autokey),\n' + 
		           '         have been built and moved to QA.');
							 
jobFailed := FileServices.sendemail(_control.MyInfo.EmailAddressNotify, ' DCA Roxie Key Build Failed - ' + filedate, failmessage);

//Update Roxie Page
UpdateRoxiePage := RoxieKeybuild.updateversion('DCAKeys', filedate, _control.MyInfo.EmailAddressNotify,,'N');

// return value (action)

retval := sequential(parallel(a1,a2,a3,a4,a5),
                     parallel(b1,b2,b3,b4,b5),
                     parallel(c1,c2,c3,c4,c5),
                     build_autokeys);

return retval;																																										 
end;
