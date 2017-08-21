import RoxieKeyBuild, ut;
export proc_build_sna_keys(string filedate) := function

RoxieKeyBuild.Mac_SK_BuildProcess_Local(SNA.Key_Person_Cluster
									   ,'~thor_data400::key::sna::' +filedate+'::person_cluster'
					  			       ,'~thor_data400::key::sna::person_cluster',bk_pc,2);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(SNA.Key_Person_Cluster_Attributes
									   ,'~thor_data400::key::sna::' +filedate+'::person_cluster_attributes'
					                   ,'~thor_data400::key::sna::person_cluster_attributes',bk_pc_attr,2);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(SNA.Key_Prop_Cluster_Stats
									   ,'~thor_data400::key::sna::' +filedate+'::property_ownership_cluster_stats'
					                   ,'~thor_data400::key::sna::property_ownership_cluster_stats',bk_prop_own_stats,2);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(SNA.key_prop_transaction_base_did
									   ,'~thor_data400::key::sna::' +filedate+'::property_transaction_did'
					  			       ,'~thor_data400::key::sna::property_transaction_did',bk_prop_did,2);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(SNA.key_prop_transaction_stats
									   ,'~thor_data400::key::sna::' +filedate+'::property_transaction_stats'
					      			   ,'~thor_data400::key::sna::property_transaction_stats',bk_prop_tr_stats,2);

build_keys := parallel(bk_pc,bk_pc_attr,bk_prop_own_stats,bk_prop_did,bk_prop_tr_stats);

// move keys to built

RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::sna::' +filedate+'::person_cluster'
                                  ,'~thor_data400::key::sna::person_cluster'
								  ,move10);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::sna::' +filedate+'::person_cluster_attributes'
                                  ,'~thor_data400::key::sna::person_cluster_attributes'
								  ,move11);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::sna::' +filedate+'::property_ownership_cluster_stats'
                                  ,'~thor_data400::key::sna::property_ownership_cluster_stats'
								  ,move12);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::sna::' +filedate+'::property_transaction_did'
                                  ,'~thor_data400::key::sna::property_transaction_did'
								  ,move13);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::sna::' +filedate+'::property_transaction_stats'
                                  ,'~thor_data400::key::sna::property_transaction_stats'
								  ,move14);

move_build_keys := parallel(move10,move11,move12,move13,move14);

// Move keys to QA
ut.MAC_SK_Move('~thor_data400::key::sna::person_cluster', 'Q', moveq10);
ut.MAC_SK_Move('~thor_data400::key::sna::person_cluster_attributes','Q', moveq11);
ut.MAC_SK_Move('~thor_data400::key::sna::property_ownership_cluster_stats',  'Q', moveq12);
ut.MAC_SK_Move('~thor_data400::key::sna::property_transaction_did', 'Q', moveq13);
ut.MAC_SK_Move('~thor_data400::key::sna::property_transaction_stats','Q', moveq14);

move_qa_keys := parallel(moveq10
							,moveq11,moveq12,moveq13,moveq14);
							
updatedops := Roxiekeybuild.updateversion('SNAKeys',filedate,'skasavajjala@seisint.com ; Melanie.Jackson@lexisnexis.com',,'N');


do_all:= sequential(
					
					build_keys
					,move_build_keys
					,move_qa_keys
					,updatedops
					,Sample_QA.out
					); 
					//: success(send_succ_msg),failure(send_fail_msg);
return do_all;
												   
end;