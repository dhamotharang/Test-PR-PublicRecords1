import ut, PromoteSupers, NID, Address, STD, MDR, AID, AID_Support, PRTE2, email_data, _control, tools;

//Uppercase, CleanSpaces, and remove unprintable characters
PRTE2.CleanFields(Files.INCOMING_BOCA, dsClnBocaEmailData);


//Split Boca records.  Alphretta records does not require recleaning
dExistingRecords := dsClnBocaEmailData(cust_name = '');
dNewRecords  := dsClnBocaEmailData(cust_name != '');

 //Address Cleaning																	
 dNewRecordsAddrClean := PRTE2.AddressCleaner(dNewRecords,   
                                              ['orig_address'],                                              
                                              ['dummy1'], 
                                              ['orig_city'],
                                              ['orig_state'],                                              
                                              ['orig_zip'],
                                              ['clean_address'],
                                              ['temp_rawaid']);


//layouts.incoming_boca  tCleanAddressAppended(dNewRecordsAddrClean pInput) := transform
layouts.incoming_base  tCleanAddressAppended(dNewRecordsAddrClean pInput) := transform
	self 									:= pInput.clean_address;
	self.county 	         	:= pInput.clean_address.fips_county;
	self.append_rawaid			:= pInput.temp_rawaid;
	
	CleanName					:= Address.CleanPersonFML73(std.str.cleanspaces(trim(pInput.orig_first_name) +' '+trim(pInput.orig_last_name)));
	self.title        := Address.CleanNameFields(CleanName).title; 
	self.fname				:= Address.CleanNameFields(CleanName).fname; 
  self.mname			  := Address.CleanNameFields(CleanName).mname; 
  self.lname			  := Address.CleanNameFields(CleanName).lname; 
  self.name_suffix 	:= Address.CleanNameFields(CleanName).name_suffix; 
	


 
 //Append DID
 self.did	 		:= prte2.fn_AppendFakeID.did(self.fname, self.lname, pInput.link_ssn, pInput.link_dob, pInput.cust_name);
 
 vLinkingIds := prte2.fn_AppendFakeID.LinkIds(pInput.companyname, (string9)pInput.link_fein, pInput.link_inc_date, pInput.clean_address.prim_range, pInput.clean_address.prim_name, 
                pInput.clean_address.sec_range, pInput.clean_address.v_city_name, pInput.clean_address.st, pInput.clean_address.zip, pInput.cust_name);
	
                                                                                 
                                       	
 SELF.powid	:= vLinkingIds.powid;
 SELF.proxid	:= vLinkingIds.proxid;
 SELF.seleid	:= vLinkingIds.seleid;
 SELF.orgid	:= vLinkingIds.orgid;
 SELF.ultid	:= vLinkingIds.ultid;	  
 self :=	pInput;
 self :=  [];
 
end;



dCleanAddressAppended	:=	project(dNewRecordsAddrClean,tCleanAddressAppended(left));	 
	


//Create email_key
dsEmailDataBoca := project(dCleanAddressAppended	+ dExistingRecords, 
									transform(Layouts.base, 
									self.clean_name 			:=  left;
									self.clean_address := left;
									v_append_email_username  := STD.Str.ToUpperCase(email_data.Fn_Clean_Email_Username(left.clean_email));
									v_append_domain 				 := left.clean_email[length(v_append_email_username)+2..];
									v_append_domain_root 	 	:= TRIM(v_append_domain[1..STD.Str.Find(v_append_domain, '.', 1) -1], right);	
									v_append_domain_ext			 := v_append_domain[length(v_append_domain_root)+1..];
									self.append_email_username 	 := if(left.append_email_username = '',v_append_email_username,left.append_email_username);
									self.append_domain 					 := if(left.append_domain = '',v_append_domain, left.append_domain);	
									self.append_domain_root 		 := if(left.append_domain_root = '',v_append_domain_root, left.append_domain_root);
									self.append_domain_ext 			 := if(left.append_domain_ext = '',v_append_domain_ext,left.append_domain_ext);
									self.orig_address 	:= STD.Str.CleanSpaces(left.orig_address);
									self.email_rec_key  := Email_Data.Email_rec_key(left.clean_email,left.prim_range,left.prim_name,left.sec_range,left.zip,left.lname,left.fname);
                  //
									self.best_dob:=(unsigned4)left.link_dob;
									self.best_ssn:=left.link_ssn;
									
									self := left;
									self := [];
									));


addGlobal_SID_Boca			:= MDR.macGetGlobalSid(dsEmailDataBoca, 'EmailDataV2', 'email_src', 'global_sid');	
PromoteSupers.Mac_SF_BuildProcess(addGlobal_SID_Boca,Constants.base_prefix_name+ 'boca'	,boca_base,,,true);	

export proc_build_boca := boca_base;	

