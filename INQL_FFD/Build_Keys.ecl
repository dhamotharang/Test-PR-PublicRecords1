IMPORT roxiekeybuild, dx_InquiryHistory;

EXPORT Build_Keys (boolean isUpdate = true, boolean isFCRA = true, string pVersion = '' ) := Module

unsigned fcra := if(isFCRA,1,0);

//Lexid Keys
Roxiekeybuild.Mac_SK_BuildProcess_v3_local (
                                            dx_InquiryHistory.Key_Lexid(fcra), //index
																						$.Data_Keys(isUpdate,isFCRA,pVersion).lexid, //dataset
																						dx_InquiryHistory.names(fcra).i_lexid, //key superfile
																						$.Keynames(isfcra,pVersion).Lexid.New, //key logical file
																						bd_lexid_key
																						);

//Group_RID Keys
Roxiekeybuild.Mac_SK_BuildProcess_v3_local (
                                            dx_InquiryHistory.Key_Group_RID(fcra), 
																						$.Data_Keys(isUpdate,isfcra,pVersion).Group_RID, 
																						dx_InquiryHistory.names(fcra).i_GroupRID,
																						$.Keynames(isfcra,pVersion).Group_RID.New, 
																						bd_GroupRID_key
																						);

//Group_RID_Encrypted Keys
Roxiekeybuild.Mac_SK_BuildProcess_v3_local (
                                            dx_InquiryHistory.Key_Group_RID_Encrypted(fcra), 
																						$.Data_Keys(isUpdate,isfcra,pVersion).Group_RID_Encrypted, 
																						dx_InquiryHistory.names(fcra).i_GroupRID_Encrypted,
																						$.Keynames(isfcra,pVersion).Group_RID_Encrypted.New, 
																						bd_GroupRIDEncrypted_key
																						);


updateSF_Delta   := inql_ffd.move_files(,,pVersion).Delta_keys;
updateSF_Full    := sequential(inql_ffd.Promote(true, isFCRA, pversion).lexid.new2Built
															 ,inql_ffd.Promote(true, isFCRA, pversion).lexid.Built2QA
															 ,inql_ffd.Promote(true, isFCRA, pversion).group_rid.new2Built
															 ,inql_ffd.Promote(true, isFCRA, pversion).group_rid.Built2QA
															 ,inql_ffd.Promote(true, isFCRA, pversion).group_rid_encrypted.new2Built
															 ,inql_ffd.Promote(true, isFCRA, pversion).group_rid_encrypted.Built2QA);
															 
updateSF := if(isUpdate, updateSF_Delta,updateSF_Full );
                                

export All 			:= SEQUENTIAL (
															PARALLEL (bd_lexid_key
																			 ,bd_grouprid_key
																			 ,bd_GroupRIDEncrypted_key
																				)
															,updateSF	
															);

END;