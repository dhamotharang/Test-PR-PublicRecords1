import ut, roxiekeybuild, _control;

// Set the file date you require below, 
// otherwise it will try dca.version, if that is empty, it will use thorlib.wuid()[2..9] 

export proc_build_dca_keys_bid(string filedate) := function

// Build Roxie Keys

roxiekeybuild.MAC_SK_BuildProcess_v2_local(DCA.Key_DCA_BID, '', 
                                           '~thor_data400::key::dca::'+filedate+'::bid', a1);
roxiekeybuild.MAC_SK_BuildProcess_v2_local(DCA.Key_DCA_Root_Sub_bid, '', 
                                           '~thor_data400::key::dca::'+filedate+'::root_sub_bid', a2);
roxiekeybuild.MAC_SK_BuildProcess_v2_local(DCA.Key_DCA_Hierarchy_BID, '', 
                                           '~thor_data400::key::dca::'+filedate+'::hierarchy_bid', a3);
roxiekeybuild.MAC_SK_BuildProcess_v2_local(DCA.Key_DCA_Hierarchy_Root_Sub_bid, '', 
                                           '~thor_data400::key::dca::'+filedate+'::hierarchy_root_sub_bid', a4);

//Move the new roxie keys to built superfile

roxiekeybuild.mac_sk_move_to_built_v2('~thor_data400::key::dca_bid',
                                      '~thor_data400::key::dca::'+filedate+'::bid', b1);
roxiekeybuild.mac_sk_move_to_built_v2('~thor_data400::key::dca_root_sub_bid',
                                      '~thor_data400::key::dca::'+filedate+'::root_sub_bid', b2);
roxiekeybuild.mac_sk_move_to_built_v2('~thor_data400::key::dca_hierarchy_bid',
                                      '~thor_data400::key::dca::'+filedate+'::hierarchy_bid', b3);
roxiekeybuild.mac_sk_move_to_built_v2('~thor_data400::key::dca_hierarchy_root_sub_bid',
                                      '~thor_data400::key::dca::'+filedate+'::hierarchy_root_sub_bid', b4);

// Move the new roxie keys from built to QA superfile

ut.mac_sk_move_v2('~thor_data400::key::dca_bid','Q',c1,2);
ut.mac_sk_move_v2('~thor_data400::key::dca_root_sub_bid','Q',c2,2);
ut.mac_sk_move_v2('~thor_data400::key::dca_hierarchy_bid','Q',c3,2);
ut.mac_sk_move_v2('~thor_data400::key::dca_hierarchy_root_sub_bid','Q',c4,2);


// Build Autokeys

build_autokeys := dca.proc_build_autokey_bid (filedate);

// return value (action)

retval := sequential(parallel(a1,a2,a3,a4),
                     parallel(b1,b2,b3,b4),
                     parallel(c1,c2,c3,c4),
                     build_autokeys);

return retval;																																										 
end;
