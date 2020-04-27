import  inql_ffd, dops;

qa_version := inql_ffd.Fn_Get_Current_Version.fcra_full_keys_dops_certQA;
prod_version:= inql_ffd.Fn_Get_Current_Version.fcra_full_keys_dops_prod;

ds := dataset([{'inql_ffd.keys().lexid' 
                ,'~thor_data::key::inquiryhistory::fcra::qa::lexid' // superkey
								,'~thor_data::key::inquiryhistory::fcra::'+ qa_version +'::lexid' // new logical
								,'~thor_data::key::inquiryhistory::fcra::'+ prod_version +'::lexid' // previous logical
								},
								{'inql_ffd.keys().group_rid' 
                ,'~thor_data::key::inquiryhistory::fcra::qa::group_rid' // superkey
								,'~thor_data::key::inquiryhistory::fcra::'+ qa_version +'::group_rid' // new logical
								,'~thor_data::key::inquiryhistory::fcra::'+ prod_version + '::group_rid' // previous logical
								}
							],dops.modKeydiff().rListToProcess);
						
dops.modKeyDiff().fSpawnKeyDiffWrapper(ds,'FCRA_InquiryHistoryKeys');