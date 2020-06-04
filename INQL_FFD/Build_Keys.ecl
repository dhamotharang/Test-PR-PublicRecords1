IMPORT roxiekeybuild, dx_InquiryHistory;

EXPORT Build_Keys (boolean isUpdate = true, boolean isFCRA = true, string pVersion = '' ) := Module

unsigned fcra := if(isFCRA,1,0);

keyname_lLexidTemplate  		:= if(isUpdate, $.Keynames(isfcra).lLexidTemplateDelta, $.Keynames(isfcra).lLexidTemplateFull);
keyname_lGroupdRIDTemplate  := if(isUpdate, $.Keynames(isfcra).lGroupRIDTemplateDelta, $.Keynames(isfcra).lGroupRIDTemplateFull);

//Lexid Keys
Roxiekeybuild.Mac_SK_BuildProcess_v3_local (
                                            dx_InquiryHistory.Key_Lexid(fcra), //index
																						$.Data_Keys(isUpdate,isFCRA,pVersion).lexid, //dataset
																						dx_InquiryHistory.names(fcra).i_lexid, //key superfile
																						$.Keynames(isfcra,pVersion).Lexid.New, //key logical file
																						bd_lexid_key
																						);
mv_lexid_key_certSF 				:= inql_ffd.move_files(isUpdate, isFCRA, pVersion).Lexid;																						
Roxiekeybuild.Mac_SK_Move_to_Built_v2 (keyname_lLexidTemplate, $.Keynames(isfcra,pVersion).lexid.new,  mv_lexid_key);
RoxieKeyBuild.Mac_SK_Move_V2(keyname_lLexidTemplate,'Q',mv2qa_lexid,3);


//Group_RID Keys
Roxiekeybuild.Mac_SK_BuildProcess_v3_local (
                                            dx_InquiryHistory.Key_Group_RID(fcra), 
																						$.Data_Keys(isUpdate,isfcra,pVersion).Group_RID, 
																						dx_InquiryHistory.names(fcra).i_GroupRID,
																						$.Keynames(isfcra,pVersion).GroupRID.New, 
																						bd_GroupRID_key
																						);
mv_grouprid_key_certSF 			:= inql_ffd.move_files(isUpdate, isFCRA, pVersion).GroupRID;																																												
Roxiekeybuild.Mac_SK_Move_to_Built_v2 (keyname_lGroupdRIDTemplate, $.Keynames(isfcra,pVersion).GroupRID.new,  mv_GroupRID_key);
RoxieKeyBuild.Mac_SK_Move_V2(keyname_lGroupdRIDTemplate,'Q',mv2qa_GroupRID,3);


export All 			:= SEQUENTIAL (
															PARALLEL (bd_lexid_key
																			 ,bd_grouprid_key
																				)
																				, 		
															PARALLEL (mv_lexid_key_certSF
																			 ,mv_grouprid_key_certSF
																			 )
																				, 		
															PARALLEL (mv_lexid_key
																			 ,mv_grouprid_key
																			 )
																			 ,
															PARALLEL (mv2qa_lexid
																			 ,mv2qa_grouprid
																			 )
															);

END;