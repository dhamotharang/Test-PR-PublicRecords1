import DNB_FEINv2, address, standard, ut, idl_header, aid;

export Mapping_as_base_main(string process_date) := function

file_in := DNB_FEINV2.File_DNB_FEIN_In;

clean_field(string s) := function
	 return if(trim(regexreplace('[0\\.\\,\\/\\}\\{\\\'\\"\\*\\|\\!\\-]+',s,''),left,right)='','',s);
end;
		
trimUpper(string s) := function
		return trim(stringlib.StringToUppercase(s),left,right);
end;

DNB_FEINV2.layout_DNB_fein_base_main_New treformat( DNB_FEINV2.layout_DNB_Fein_Raw_In L) := transform
		//clean fields used more than once
		cln_address            					 := StringLib.StringCleanSpaces(trimUpper(L.address));
		cln_city               					 := trimUpper(L.city);
		cln_zip                					 := clean_field(L.zip_code);
		cln_state 			   		 					 := if(trimUpper(L.state) = '', 
																					 if(cln_zip != '',
																							ziplib.ZipToState2(cln_zip),
																							''),
																					 trimUpper(L.state));
		//////////////////////////////////////////////////////////////////////////////////////
		// -- Prepare Addresses for Cleaning using macro
		//////////////////////////////////////////////////////////////////////////////////////
		address1 							 					 :=	Address.Addr1FromComponents(
																					 stringlib.stringtouppercase(cln_address	)
																					,''
																					,''
																					,''
																					,''
																					,''
																					,''
																				); 
		address2 							 					 :=	Address.Addr2FromComponents(
																					 stringlib.stringtouppercase(cln_city 	)	
																					,stringlib.stringtouppercase(cln_state	)	
																					,trim(cln_zip,left,right)
																				);

		cln_tax_id_number      					 := clean_field(L.tax_id_number);	
		cln_case_duns_number   					 := clean_field(L.case_duns_number);
		cln_source_duns_number 					 := clean_field(L.source_duns_number);
		cln_business_name      					 := StringLib.StringCleanSpaces(trimUpper(L.business_name));
		cln_top_contact_name   					 := StringLib.StringCleanSpaces(trimUpper(L.top_contact_name));				
		cln_date_input_data    					 := clean_field(L.date_input_data);
		string73 tempname 		 					 := if(cln_top_contact_name = '', '',Address.CleanPersonFML73(cln_top_contact_name));
		pname 							 	 					 := Address.CleanNameFields(tempName);
		self.title						 					 := pname.title;
		self.fname 						 					 := pname.fname;        
		self.mname 						 					 := pname.mname;
		self.lname 						 					 := pname.lname;		  
		self.name_suffix 			 					 := pname.name_suffix;
		self.name_score			   					 := pname.name_score;
		self.tmsid             					 := 'DF' + 
																				trim(cln_tax_id_number,left,right) +
																				trim(cln_source_duns_number,left,right) +
																				trim(cln_case_duns_number,left,right);
		self.orig_company_name 					 := cln_business_name ;
		self.clean_cname       					 := cln_business_name ; 
		self.orig_address1     					 := cln_address;
		self.orig_address2     					 :=  '';
		self.orig_city         					 :=  cln_city;
		self.orig_state        					 :=  cln_state;
		self.orig_zip5         					 :=  cln_zip;
		self.orig_zip4         					 :=  '';
		self.orig_county       					 :=  '';
		self.fein              					 :=  cln_tax_id_number ;
		self.SOURCE_DUNS_NUMBER					 :=  cln_source_duns_number ; 
		self.CASE_DUNS_NUMBER  					 :=  cln_case_duns_number ;
		self.duns_orig_source            := trimUpper(L.REFERENCE_NAME_SOURCE); 
		self.CONFIDENCE_CODE             := trim(L.CONFIDENCE_CODE,left,right);
		self.INDIRECT_DIRECT_SOURCE_IND  := trim(L.INDIRECT_DIRECT_SOURCE_IND,left,right);
		self.BEST_FEIN_Indicator         := trim(L.BEST_FEIN_Indicator,left,right);
		self.prep_addr_line1						 := address1;
		self.prep_addr_line_last				 := address2;
		self.date_first_seen             := cln_date_input_data;
		self.date_last_seen              := cln_date_input_data;
		self.date_vendor_first_reported  := process_date;
		self.date_vendor_last_reported   := process_date;
		self.company_name				 				 := trimUpper(L.company_name);
		self.trade_style			     			 := trimUpper(L.trade_style);
		self.sic_code					 					 := clean_field(L.sic_code);
		self.telephone_number	           := clean_field(L.telephone_number);
		self.top_contact_name			 			 := cln_top_contact_name;
		self.top_contact_title			 		 := trimUpper(L.top_contact_title);
		self.Hdqtr_Parent_Duns_Number	   := clean_field(L.Hdqtr_Parent_Duns_Number);
		self 														 := L;
		self 														 := [];
end;
pre_DB_norm := project(file_in, treformat(left));

//***********************************************************************************
//* Clean address using the AID maco
//////////////////////////////////////////////////////////////////////////////////////
HasAddress				:= trim(pre_DB_norm.prep_addr_line_last, left,right) != '';								
dWith_address			:= pre_DB_norm(HasAddress);
dWithout_address	:= pre_DB_norm(not(HasAddress));

unsigned4	lFlags 	:= AID.Common.eReturnValues.ACEAIDs | AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;	

AID.MacAppendFromRaw_2Line(dWith_address, prep_addr_line1, prep_addr_line_last, Raw_AID, dwithAID, lFlags);

//*** Transform the AID cleaned address records to get the clean address fields.
DNB_FEINV2.layout_DNB_fein_base_main_New	 tMapAidAddr(dwithAID l) := transform	
	self.raw_aid 					:= l.aidwork_rawaid;
	self.ace_aid 					:= l.aidwork_acecache.aid;
	self.prim_range				:= l.aidwork_acecache.prim_range;
	self.predir						:= l.aidwork_acecache.predir;
	self.prim_name				:= l.aidwork_acecache.prim_name;
	self.addr_suffix			:= l.aidwork_acecache.addr_suffix;
	self.postdir					:= l.aidwork_acecache.postdir;
	self.unit_desig				:= l.aidwork_acecache.unit_desig;
	self.sec_range				:= l.aidwork_acecache.sec_range;
	self.p_city_name			:= l.aidwork_acecache.p_city_name;
	self.v_city_name			:= l.aidwork_acecache.v_city_name;
	self.st								:= l.aidwork_acecache.st;
	self.zip							:= l.aidwork_acecache.zip5;
	self.zip4							:= l.aidwork_acecache.zip4;
	self.cart							:= l.aidwork_acecache.cart;
	self.cr_sort_sz				:= l.aidwork_acecache.cr_sort_sz;
	self.lot							:= l.aidwork_acecache.lot;
	self.lot_order				:= l.aidwork_acecache.lot_order;
	self.dbpc							:= l.aidwork_acecache.dbpc;
	self.chk_digit				:= l.aidwork_acecache.chk_digit;
	self.rec_type					:= l.aidwork_acecache.rec_type;	
	self.county						:= l.aidwork_acecache.county;
	self.geo_lat					:= l.aidwork_acecache.geo_lat;
	self.geo_long					:= l.aidwork_acecache.geo_long;
	self.msa							:= l.aidwork_acecache.msa;
	self.geo_blk					:= l.aidwork_acecache.geo_blk;
	self.geo_match				:= l.aidwork_acecache.geo_match;
	self.err_stat					:= l.aidwork_acecache.err_stat;
	self        					:= l;		 
end;

//** Adding back the filtered blank address records to the rest of the file.
dBase_AID_Cleaned_Addr := project(dwithAID, tMapAidAddr(left))
												  + project(dWithout_address,transform(DNB_FEINV2.layout_DNB_fein_base_main_New, self := left, self := []));
//***********************************************************************************

// Flip names that may have been wrongly parsed by the name cleaner.
ut.mac_flipnames(dBase_AID_Cleaned_Addr, fname, mname, lname, DB_norm);

//source_rec_id logic	
Update_Base		:= distribute(DB_norm,hash64(tmsid, company_name));  
Previous_Base	:= distribute(DNB_FEINV2.File_DNB_Fein_base_main_new,hash64(tmsid, company_name)); 

DNB_FEINV2.layout_DNB_fein_base_main_new	trans_recID(DNB_FEINV2.layout_DNB_fein_base_main_new l, DNB_FEINV2.layout_DNB_fein_base_main_new r):=transform
		self.source_rec_id := r.source_rec_id;
		self               := l;
end;

// Made changes to the "persistent_recID_join" and removed Raw_aid and Ace_aid fields and added all vendor Address fields!
// Ace_aid are not persistentID's from build to build and it was causing an error in retaining source_rec_id's .
// DNB_FEINV2 data source is a REPLACE EACH TIME & doesn’t maintain history!!
// We are ONLY* using Previous Base file in this join "persistent_recID_join"  to retain OLD Source Rec Id’s !  
persistent_recID_join  := join(Update_Base,Previous_Base,
															 trim(left.tmsid,left,right)         		             = trim(right.tmsid,left,right)and
															 stringlib.stringcleanspaces(left.company_name)   	 = stringlib.stringcleanspaces(right.company_name)and
															 stringlib.stringcleanspaces(left.trade_style)		 	 = trim(right.trade_style,left,right)and
															 stringlib.stringcleanspaces(left.orig_company_name) = stringlib.stringcleanspaces(right.orig_company_name) and  
															 trim(left.clean_cname ,left,right)  		           	 = trim(right.clean_cname,left,right) and
                               stringlib.stringcleanspaces(left.orig_address1)     = stringlib.stringcleanspaces(right.orig_address1) and
															 stringlib.stringcleanspaces(left.orig_address2)     = stringlib.stringcleanspaces(right.orig_address2) and    
															 trim(left.orig_CITY,left,right)  		               = trim(right.orig_CITY,left,right) and    
															 trim(left.orig_STATE,left,right)  		               = trim(right.orig_STATE,left,right) and    
															 trim(left.orig_ZIP5,left,right)  		               = trim(right.orig_ZIP5,left,right) and
															 trim(left.orig_ZIP4,left,right)  		       			   = trim(right.orig_ZIP4,left,right) and       
															 trim(left.orig_county,left,right)  		             = trim(right.orig_county,left,right) and     
															 trim(left.FEIN,left,right)  						      		   = trim(right.FEIN,left,right) and            
															 trim(left.SOURCE_DUNS_NUMBER,left,right)            = trim(right.SOURCE_DUNS_NUMBER,left,right) and 
															 trim(left.CASE_DUNS_NUMBER,left,right)              = trim(right.CASE_DUNS_NUMBER,left,right) and 
															 trim(left.duns_orig_source,left,right)              = trim(right.duns_orig_source,left,right) and 
															 trim(left.CONFIDENCE_CODE,left,right)               = trim(right.CONFIDENCE_CODE,left,right) and 
															 trim(left.INDIRECT_DIRECT_SOURCE_IND,left,right)    = trim(right.INDIRECT_DIRECT_SOURCE_IND,left,right) and 
															 trim(left.BEST_FEIN_Indicator,left,right)           = trim(right.BEST_FEIN_Indicator,left,right) and 
															 trim(left.sic_code,left,right)                      = trim(right.sic_code,left,right) and 
															 trim(left.Telephone_Number,left,right)              = trim(right.Telephone_Number,left,right) and 
															 stringlib.stringcleanspaces(left.Top_Contact_Name)  = stringlib.stringcleanspaces(right.Top_Contact_Name) and 
															 trim(left.Hdqtr_Parent_Duns_Number,left,right)      = trim(right.Hdqtr_Parent_Duns_Number,left,right),
													trans_recID(left,right),left outer,local);	
							
//Appending source_rec_id for new updates							
ut.MAC_Append_Rcid(persistent_recID_join,source_rec_id,Append_Rcid_file);
// End of Souce_rec_id logic					

DB_dist := distribute(Append_Rcid_file(orig_company_name <> ''), hash(tmsid));

DB_sort  := sort(DB_dist,record,EXCEPT Date_First_Seen, Date_Last_Seen,
								 Date_Vendor_First_Reported, Date_Vendor_Last_Reported,source_rec_id, local);

DNB_FEINV2.layout_DNB_fein_base_main_new  rollupXform(DNB_FEINV2.layout_DNB_fein_base_main_new l, DNB_FEINV2.layout_DNB_fein_base_main_new r) := transform
		self.Date_First_Seen 						:= if(l.Date_First_Seen > r.Date_First_Seen, r.Date_First_Seen, l.Date_First_Seen);
		self.Date_Last_Seen  						:= if(l.Date_Last_Seen  < r.Date_Last_Seen,  r.Date_Last_Seen,  l.Date_Last_Seen);
		self.Date_Vendor_First_Reported := if(l.Date_Vendor_First_Reported > r.Date_Vendor_First_Reported, r.Date_Vendor_First_Reported, l.Date_Vendor_First_Reported);
		self.Date_Vendor_Last_Reported  := if(l.Date_Vendor_Last_Reported  < r.Date_Vendor_Last_Reported,  r.Date_Vendor_Last_Reported, l.Date_Vendor_Last_Reported);
		self.source_rec_id							:= if(l.source_rec_id <> 0,l.source_rec_id,r.source_rec_id);
		self := l;
end;

retval := rollup(DB_sort,rollupXform(LEFT,RIGHT)
								,RECORD,EXCEPT Date_First_Seen, Date_Last_Seen,Date_Vendor_First_Reported
															,Date_Vendor_Last_Reported,source_rec_id,local);							
return retval;

end;



