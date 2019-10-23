IMPORT roxiekeybuild, dx_InquiryHistory;

prefix := '~thor_data::key::' + dx_InquiryHistory.Constants.dataset_name + '::';

EXPORT Proc_Build_Keys (boolean isUpdate = true, boolean isFCRA = true, string pVersion = '' ) := FUNCTION

unsigned fcra := if(isFCRA,1,0);


//Lexid Keys
Roxiekeybuild.Mac_SK_BuildProcess_v3_local (
                                            dx_InquiryHistory.Key_Lexid(fcra), //index
																						$.Data_Keys(isUpdate,isFCRA,pVersion).lexid, //dataset
																						dx_InquiryHistory.names(fcra).i_lexid, //key superfile
																						$.Keynames(isfcra,pVersion).Lexid.New, //key logical file
																						bd_lexid_key
																						);
Roxiekeybuild.Mac_SK_Move_to_Built_v2 ($.Keynames(isfcra).lLexidTemplate, $.Keynames(isfcra,pVersion).lexid.new,  mv_lexid_key);
RoxieKeyBuild.Mac_SK_Move_V2($.Keynames(isfcra).lLexidTemplate,'Q',mv2qa_lexid);


//Group_RID Keys
Roxiekeybuild.Mac_SK_BuildProcess_v3_local (
                                            dx_InquiryHistory.Key_Group_RID(fcra), 
																						$.Data_Keys(isUpdate,isfcra,pVersion).Group_RID, 
																						dx_InquiryHistory.names(fcra).i_GroupRID,
																						$.Keynames(isfcra,pVersion).GroupRID.New, 
																						bd_GroupRID_key
																						);
Roxiekeybuild.Mac_SK_Move_to_Built_v2 ($.Keynames(isfcra).lGroupRIDTemplate, $.Keynames(isfcra,pVersion).GroupRID.new,  mv_GroupRID_key);
RoxieKeyBuild.Mac_SK_Move_V2($.Keynames(isfcra).lGroupRIDTemplate,'Q',mv2qa_GroupRID);



build_keys := SEQUENTIAL (
										PARALLEL (bd_lexid_key
														 ,bd_grouprid_key
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

RETURN build_keys;

END;