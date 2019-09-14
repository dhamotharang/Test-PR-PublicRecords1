import doxie, tools, $, Risk_Indicators;

export Keys(boolean isUpdate = false, isFCRA = false) := module

export nonFCRA_Address :=  INDEX($.Data_NonFCRA_keys(isUpdate).iAddress 
															 , {zip,person_q.prim_name ,person_q.prim_range,person_q.sec_range}
															 , {$.Data_NonFCRA_keys(isUpdate).iAddress}
															 , $.Keynames(isUpdate).Address.QA
																);

export nonFCRA_DID		 :=  INDEX($.Data_NonFCRA_keys(isUpdate).iDID 
															 , {unsigned6 s_did := person_q.appended_ADL}
															 , {$.Data_NonFCRA_keys(isUpdate).iDID}
															 , $.Keynames(isUpdate).DID.QA
																);

export nonFCRA_FEIN		 :=  INDEX($.Data_NonFCRA_keys(isUpdate).iFEIN 
															 , {string15 appended_ein := bus_q.appended_ein}
															 , {$.Data_NonFCRA_keys(isUpdate).iFEIN}
															 , $.Keynames(isUpdate).FEIN.QA
																);				
																
export nonFCRA_IPAddr	 :=  INDEX($.Data_NonFCRA_keys(isUpdate).iIPAddr 
																, {string20 IPaddr := person_q.IPaddr}
															  , {$.Data_NonFCRA_keys(isUpdate).iIPAddr}
															  , $.Keynames(isUpdate).IPAddr.QA
																);

export nonFCRA_Linkids	 :=  INDEX($.Data_NonFCRA_keys(isUpdate).iLinkids 
																, {ultid, orgid, seleid, proxid, powid, empid, dotid}
															  , {$.Data_NonFCRA_keys(isUpdate).iLinkids}
															  , $.Keynames(isUpdate).Linkids.QA
																);

export nonFCRA_name	 		:=  INDEX($.Data_NonFCRA_keys(isUpdate).iname 
																, {person_q.fname,person_q.mname,person_q.lname}
															  , {$.Data_NonFCRA_keys(isUpdate).iname}
															  , $.Keynames(isUpdate).name.QA
																);

export nonFCRA_phone	 		:=  INDEX($.Data_NonFCRA_keys(isUpdate).iphone 
																	, {string10 phone10 := person_q.personal_phone}
																  , {$.Data_NonFCRA_keys(isUpdate).iphone}
																  , $.Keynames(isUpdate).phone.QA
																	);	
																
export nonFCRA_email	 					:=  INDEX($.Data_NonFCRA_keys(isUpdate).iemail 
																			 , {string50 email_address := person_q.email_address}
																			 , {$.Data_NonFCRA_keys(isUpdate).iemail}
																			 , $.Keynames(isUpdate).email.QA
																				);																	

export nonFCRA_ssn 							:=  INDEX($.Data_NonFCRA_keys(isUpdate).issn 
																			 , {string9 ssn := person_q.SSN}
																			 , {$.Data_NonFCRA_keys(isUpdate).issn}
																			 , $.Keynames(isUpdate).ssn.QA
																				);	

export nonFCRA_transaction_id 	:=  INDEX($.Data_NonFCRA_keys(isUpdate).itransaction_id 
																			 , {string50 transaction_id := transaction_id}
																			 , {$.Data_NonFCRA_keys(isUpdate).itransaction_id}
																			 , $.Keynames(isUpdate).transaction_id.QA
																				);	

export nonFCRA_industry_use_vertical 	:=  INDEX($.Data_NonFCRA_keys(isUpdate).iIndustry_use_vertical 
																						 , {string20 s_company_id := company_id, string4 s_product_id := product_id,string20 s_gc_id := gc_id }
																						 , {$.Data_NonFCRA_keys(isUpdate).iIndustry_use_vertical}
																						 , $.Keynames(isUpdate).Industry_use_vertical.QA
																										);	
																										
export nonFCRA_industry_use_vertical_login 	:=  INDEX($.Data_NonFCRA_keys(isUpdate).iIndustry_use_vertical_login 
																									, {string20 s_company_id := company_id, string4 s_product_id := product_id,string20 s_gc_id := gc_id }
																									, {$.Data_NonFCRA_keys(isUpdate).iIndustry_use_vertical_login}
																									, $.Keynames(isUpdate).Industry_use_vertical_login.QA
																										);	

export nonFCRA_lookup_func_desc 	:=  INDEX($.Data_NonFCRA_keys(isUpdate).ilookup_func_desc 
																			 , {string4 s_product_id := product_id, string2 s_transaction_type := transaction_type, 
																				  string40 s_function_name := function_name}
																			 , {$.Data_NonFCRA_keys(isUpdate).ilookup_func_desc}
																			 , $.Keynames(isUpdate).Lookup_function_desc.QA
																				);	

export nonFCRA_DID_Risk          :=  Risk_Indicators.Key_Inquiry_Table_DID;	

export nonFCRA_Billgroups_DID  	:=  INDEX($.Data_NonFCRA_keys(isUpdate).iBillgroups_DID 
																			 , {did}
																			 , {$.Data_NonFCRA_keys(isUpdate).iBillgroups_DID}
																			 , $.Keynames(isUpdate).Billgroups_DID.QA
																				);	

end;