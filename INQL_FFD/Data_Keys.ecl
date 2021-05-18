IMPORT Inql_FFD, Doxie, ut, dx_InquiryHistory, std, data_services, MDR, _control;

EXPORT Data_Keys (boolean pDaily = true, boolean pFCRA = true, string pVersion = '') := Module

shared get_recs_pre_remediaton := INQL_FFD.Files(pDaily, pFCRA, pVersion).Base.Built(Appended_DID != 0);

shared get_recs                := INQL_FFD.FN_Apply_FCRA_SAFECO_Remediation(get_recs_pre_remediaton);

shared appd_group_rid := project(get_recs,  
															Transform(recordof(get_recs),
															          self.inquiry_date  :=  Std.Date.ConvertDateFormat(left.inquiry_date,'%Y-%m-%d','%Y%m%d');	
																				,self := left
																				,self := []
																			));

shared dd_appd_group_rid := dedup(sort(appd_group_rid,transaction_id,filedate,local),record,local, except filedate, version);

shared group_rid_ 	:= project(dd_appd_group_rid,
                                Transform(dx_InquiryHistory.Layouts.i_grouprid
																				 ,self := left
																				 ,self := []
																			));
																			
EXPORT group_rid 		:= MDR.macGetGlobalSid(group_rid_,'InquiryTracking_Virtual','', 'global_sid');

EXPORT lexid 				:= project(dd_appd_group_rid,
                                Transform(dx_InquiryHistory.Layouts.i_lexid
																				 ,self := left
																				 ,self := []
																			));
																			
group_rid_encrypted_no_sid 	:= project(INQL_FFD.Files(pDaily, pFCRA, pVersion).Base_Encrypted.Built(group_rid != 0),
                                           transform(dx_inquiryHistory.layouts.i_grouprid_encrypted,
																					           self.key_version:=(integer)left.key_version,
																										 self.query_encrypted:= left.text;
																										 self:=left;
																										 self:=[]));

export group_rid_encrypted:=MDR.macGetGlobalSid(group_rid_encrypted_no_sid,'InquiryTracking_Virtual','', 'global_sid');


end;