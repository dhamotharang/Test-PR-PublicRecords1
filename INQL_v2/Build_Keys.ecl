import _control, versioncontrol, std, Data_Services, ut, INQL_v2, RoxieKeyBuild, Risk_Indicators;

export Build_Keys(string pVersion = '', boolean isUpdate = true, boolean isFCRA = false) := module	


//--------------------------BUILD NONFCRA KEYS--------------------------------//
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(INQL_v2.Keys(isUpdate).NonFCRA_Address
																					,Inql_v2.Keynames(isUpdate,false).AddressSFTemplate
																					,Inql_v2.Keynames(isUpdate,false,pVersion).Address.New , bk_addr);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(INQL_v2.Keys(isUpdate).NonFCRA_DID
																					,Inql_v2.Keynames(isUpdate,false).didSFTemplate
																					,Inql_v2.Keynames(isUpdate,false,pVersion).did.New , bk_did);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(INQL_v2.Keys(isUpdate).NonFCRA_FEIN
																					,Inql_v2.Keynames(isUpdate,false).feinSFTemplate
																					,Inql_v2.Keynames(isUpdate,false,pVersion).fein.New , bk_fein);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(INQL_v2.Keys(isUpdate).NonFCRA_IPAddr
																					,Inql_v2.Keynames(isUpdate,false).ipaddrSFTemplate
																					,Inql_v2.Keynames(isUpdate,false,pVersion).ipaddr.New , bk_ipaddr);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(INQL_v2.Keys(isUpdate).NonFCRA_Linkids
																					,Inql_v2.Keynames(isUpdate,false).linkidsSFTemplate
																					,Inql_v2.Keynames(isUpdate,false,pVersion).linkids.New , bk_linkids);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(INQL_v2.Keys(isUpdate).NonFCRA_Name
																					,Inql_v2.Keynames(isUpdate,false).nameSFTemplate
																					,Inql_v2.Keynames(isUpdate,false,pVersion).name.New , bk_name);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(INQL_v2.Keys(isUpdate).NonFCRA_phone
																					,Inql_v2.Keynames(isUpdate,false).phoneSFTemplate
																					,Inql_v2.Keynames(isUpdate,false,pVersion).phone.New , bk_phone);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(INQL_v2.Keys(isUpdate).NonFCRA_email
																					,Inql_v2.Keynames(isUpdate,false).emailSFTemplate
																					,Inql_v2.Keynames(isUpdate,false,pVersion).email.New , bk_email);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(INQL_v2.Keys(isUpdate).NonFCRA_ssn
																					,Inql_v2.Keynames(isUpdate,false).ssnSFTemplate
																					,Inql_v2.Keynames(isUpdate,false,pVersion).ssn.New , bk_ssn);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(INQL_v2.Keys(isUpdate).NonFCRA_transaction_id
																					,Inql_v2.Keynames(isUpdate,false).transactionidSFTemplate
																					,Inql_v2.Keynames(isUpdate,false,pVersion).transaction_id.New , bk_trans);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(INQL_v2.Keys(isUpdate).NonFCRA_industry_use_vertical_login
																					,Inql_v2.Keynames(isUpdate,false).induseverticallogSFTemplate
																					,Inql_v2.Keynames(isUpdate,false,pVersion).Industry_use_vertical_login.New , bk_indlg);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(INQL_v2.Keys(isUpdate).NonFCRA_industry_use_vertical
																					,Inql_v2.Keynames(isUpdate,false).induseverticalSFTemplate
																					,Inql_v2.Keynames(isUpdate,false,pVersion).Industry_use_vertical.New , bk_ind);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(INQL_v2.Keys(isUpdate).NonFCRA_lookup_func_desc
																					,Inql_v2.Keynames(isUpdate,false).lookupfuncdescSFTemplate
																					,Inql_v2.Keynames(isUpdate,false,pVersion).lookup_function_desc.New , bk_lookup);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Risk_Indicators.Key_Inquiry_Table_DID
																					,Inql_v2.Keynames(isUpdate,false).didRiskSFTemplate
																					,Inql_v2.Keynames(isUpdate,false,pVersion).did_Risk.New , bk_didRisk);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(INQL_v2.Keys(isUpdate).NonFCRA_Billgroups_DID
																					,Inql_v2.Keynames(isUpdate,false).billgroupsSFTemplate
																					,Inql_v2.Keynames(isUpdate,false,pVersion).Billgroups_did.New , bk_billgrp);
																					
// --------------------------MOVE NONFCRA KEYS to BUILT--------------------------------//
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(Inql_v2.Keynames(isUpdate,false).AddressSFTemplate
																		,	Inql_v2.Keynames(isUpdate,false).AddressLGTemplate , mv_addr,3);
																		
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(Inql_v2.Keynames(isUpdate,false).didSFTemplate
																		, Inql_v2.Keynames(isUpdate,false).didLGTemplate , mv_did,3);

RoxieKeyBuild.Mac_SK_Move_to_Built_v2(Inql_v2.Keynames(isUpdate,false).feinSFTemplate
																		, Inql_v2.Keynames(isUpdate,false).feinLGTemplate , mv_fein,3);

RoxieKeyBuild.Mac_SK_Move_to_Built_v2(Inql_v2.Keynames(isUpdate,false).ipaddrSFTemplate
																		, Inql_v2.Keynames(isUpdate,false).ipaddrLGTemplate , mv_ipaddr,3);

RoxieKeyBuild.Mac_SK_Move_to_Built_v2(Inql_v2.Keynames(isUpdate,false).linkidsSFTemplate
																		, Inql_v2.Keynames(isUpdate,false).linkidsLGTemplate , mv_linkids,3);

RoxieKeyBuild.Mac_SK_Move_to_Built_v2(Inql_v2.Keynames(isUpdate,false).nameSFTemplate
																		, Inql_v2.Keynames(isUpdate,false).nameLGTemplate , mv_name,3);

RoxieKeyBuild.Mac_SK_Move_to_Built_v2(Inql_v2.Keynames(isUpdate,false).phoneSFTemplate
																		, Inql_v2.Keynames(isUpdate,false).phoneLGTemplate,mv_phone,3);

RoxieKeyBuild.Mac_SK_Move_to_Built_v2(Inql_v2.Keynames(isUpdate,false).emailSFTemplate
																		, Inql_v2.Keynames(isUpdate,false).emailLGTemplate , mv_email,3);

RoxieKeyBuild.Mac_SK_Move_to_Built_v2(Inql_v2.Keynames(isUpdate,false).ssnSFTemplate
																		, Inql_v2.Keynames(isUpdate,false).ssnLGTemplate , mv_ssn,3);

RoxieKeyBuild.Mac_SK_Move_to_Built_v2(Inql_v2.Keynames(isUpdate,false).transactionidSFTemplate
																		, Inql_v2.Keynames(isUpdate,false).transactionidLGTemplate,mv_trans,3);

RoxieKeyBuild.Mac_SK_Move_to_Built_v2(Inql_v2.Keynames(isUpdate,false).induseverticallogSFTemplate
																		, Inql_v2.Keynames(isUpdate,false).induseverticallogLGTemplate , mv_indlg,3);

RoxieKeyBuild.Mac_SK_Move_to_Built_v2(Inql_v2.Keynames(isUpdate,false).induseverticalSFTemplate
																		, Inql_v2.Keynames(isUpdate,false).induseverticalLGTemplate , mv_ind,3);

RoxieKeyBuild.Mac_SK_Move_to_Built_v2(Inql_v2.Keynames(isUpdate,false).lookupfuncdescSFTemplate
																		, Inql_v2.Keynames(isUpdate,false).lookupfuncdescLGTemplate , mv_lookup,3);

RoxieKeyBuild.Mac_SK_Move_to_Built_v2(Inql_v2.Keynames(isUpdate,false).didRiskSFTemplate
																		, Inql_v2.Keynames(isUpdate,false).didRiskLGTemplate , mv_didRisk,3);

RoxieKeyBuild.Mac_SK_Move_to_Built_v2(Inql_v2.Keynames(isUpdate,false).billgroupsSFTemplate
																		, Inql_v2.Keynames(isUpdate,false).billgroupsLGTemplate , mv_billgrp,3);

//--------------------------MOVE NONFCRA KEYS to QA--------------------------------//
RoxieKeyBuild.Mac_SK_Move_V2(Inql_v2.Keynames(isUpdate,false).AddressSFTemplate,'Q', mv2qa_addr);

RoxieKeyBuild.Mac_SK_Move_V2(Inql_v2.Keynames(isUpdate,false).didSFTemplate,'Q', mv2qa_did);

RoxieKeyBuild.Mac_SK_Move_V2(Inql_v2.Keynames(isUpdate,false).feinSFTemplate,'Q', mv2qa_fein);

RoxieKeyBuild.Mac_SK_Move_V2(Inql_v2.Keynames(isUpdate,false).ipaddrSFTemplate,'Q', mv2qa_ipaddr);

RoxieKeyBuild.Mac_SK_Move_V2(Inql_v2.Keynames(isUpdate,false).linkidsSFTemplate,'Q', mv2qa_linkids);

RoxieKeyBuild.Mac_SK_Move_V2(Inql_v2.Keynames(isUpdate,false).nameSFTemplate,'Q', mv2qa_name);

RoxieKeyBuild.Mac_SK_Move_V2(Inql_v2.Keynames(isUpdate,false).phoneSFTemplate,'Q', mv2qa_phone);

RoxieKeyBuild.Mac_SK_Move_V2(Inql_v2.Keynames(isUpdate,false).emailSFTemplate,'Q', mv2qa_email);

RoxieKeyBuild.Mac_SK_Move_V2(Inql_v2.Keynames(isUpdate,false).ssnSFTemplate,'Q', mv2qa_ssn);

RoxieKeyBuild.Mac_SK_Move_V2(Inql_v2.Keynames(isUpdate,false).transactionidSFTemplate,'Q', mv2qa_trans);

RoxieKeyBuild.Mac_SK_Move_V2(Inql_v2.Keynames(isUpdate,false).induseverticallogSFTemplate,'Q', mv2qa_indlg);

RoxieKeyBuild.Mac_SK_Move_V2(Inql_v2.Keynames(isUpdate,false).induseverticalSFTemplate,'Q', mv2qa_ind);

RoxieKeyBuild.Mac_SK_Move_V2(Inql_v2.Keynames(isUpdate,false).lookupfuncdescSFTemplate,'Q', mv2qa_lookup);

RoxieKeyBuild.Mac_SK_Move_V2(Inql_v2.Keynames(isUpdate,false).didRiskSFTemplate,'Q', mv2qa_didRisk);

RoxieKeyBuild.Mac_SK_Move_V2(Inql_v2.Keynames(isUpdate,false).billgroupsSFTemplate,'Q', mv2qa_billgrp);


nonfcra_build 							:= sequential(
																					//if(~isupdate,sequential(fn_Build_History_slim, fn_reappend_history)) ,
																			   parallel ( /*bk_addr, bk_did,   bk_fein, bk_ipaddr, bk_linkids
																										, bk_name, bk_phone, bk_email, bk_ssn, bk_trans
																										, if(isUpdate, bk_indlg)
																										, if(isUpdate, bk_ind)
																										, if(isUpdate, bk_lookup)*/
																										//, 
																										if(isUpdate, bk_didRisk)
																										//, if(~isUpdate, bk_billgrp)
																										)
																					);

nonfcra_move2build 					:= parallel ( mv_addr, mv_did, mv_fein, mv_ipaddr, mv_linkids
																				, mv_name, mv_phone, mv_email, mv_ssn, mv_trans
																				, if(isUpdate, mv_indlg)
																				, if(isUpdate, mv_ind)
																				, if(isUpdate, mv_lookup)
																				, if(isUpdate, mv_didRisk)
																				, if(~isUpdate, mv_billgrp)
																				);

nonfcra_move2QA 						:= parallel ( mv2qa_addr, mv2qa_did, mv2qa_fein, mv2qa_ipaddr, mv2qa_linkids
																				, mv2qa_name, mv2qa_phone, mv2qa_email, mv2qa_ssn, mv2qa_trans
																				, if(isUpdate, mv2qa_indlg)
																				, if(isUpdate, mv2qa_ind)
																				, if(isUpdate, mv2qa_lookup)
																				, if(isUpdate, mv2qa_didRisk)
																				, if(~isUpdate, mv2qa_billgrp)
																				);
    
nonfcra_Keys								:= sequential(	nonfcra_build
                                          , INQL_v2.FN_Update_Keys_SF(pversion).run
																					// , nonfcra_move2build
																					// , nonfcra_move2QA
																				// , RoxieKeybuild.updateversion('InquiryTableUpdateKeys',pVersion,INQL_v2.email_notification_lists.BuildSuccess,,'N')
																				, output(choosen(sort(choosen(INQL_v2.Data_NonFcra_Keys(isupdate).base_icommon(person_q.appended_adl > 0 and bus_intel.industry not in ['UNASSIGNED','BLANK','']), 1000000), -search_info.datetime), 100), named('Sample_Update_Records'))
																				, output(choosen(INQL_v2.Data_NonFcra_Keys(isupdate).base_icommon(person_q.email_address <> ''), 5), named('Sample_Update_Email_Records'))
																				, INQL_v2.STRATA_Inquiry_Daily_Tracking(pVersion)
																				);		

fcra_keys                := output('to be implemented');


export all                 := if (isFCRA,
                                         fcra_keys,
																				 nonfcra_keys);
																				 
																				      

end;
