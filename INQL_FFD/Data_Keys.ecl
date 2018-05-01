IMPORT Inql_FFD, Doxie, ut, dx_InquiryHistory;

EXPORT Data_Keys (boolean pDaily = true, boolean pFCRA = true, string pVersion = '') := Module

shared fn_hash(pDs):=functionmacro

	return hash64(hashmd5(trim(pDs.title) + ','  // to be completed
											+	trim(pDs.fname) + ','  
											+	trim(pDs.mname) + ',' 
											+	trim(pDs.lname) + ',' 
											+	trim(pDs.name_suffix)
																											));	

endMacro;

shared get_recs := INQL_FFD.Files(pDaily, pFCRA, pVersion).Base.Built(Appended_DID != 0);

shared appd_group_rid := project(get_recs,  
															Transform({recordof(get_recs),unsigned group_rid},
																					self.group_rid := fn_hash(left)
																				 ,self := left
																				 ,self := []
																			));

EXPORT group_rid := project(appd_group_rid,
                                Transform(dx_InquiryHistory.Layouts.i_grouprid
																				 ,self := left
																				 ,self := []
																			));
																			
EXPORT lexid := project(appd_group_rid,
                                Transform(dx_InquiryHistory.Layouts.i_lexid
																				 ,self := left
																				 ,self := []
																			));

end;