import Ut, lib_stringlib, Drivers;

File_MA_in := Drivers.File_MA_Full;

string8 lValidDate(string8 pDateIn)
 := if((integer4)pDateIn < 19000000,
	   '',
	   pDateIn
	  );

string5 lFixZip(string9 pZipIn)
 := if((integer4)pZipIn = 0,
	   '',
	   pZipIn[1..5] + if(pZipIn[6..9] in ['    ','0000'],
						 '',
						 pZipIn[6..9]
						)
	  );
/*
boolean fFirstAddressBetter(string pPrimName1, string pState1, string pPrimName2, string pState2)
 := if(((pPrimName1[1..6] = 'PO BOX' or pPrimName1[1..3] = 'RR ') and pState2<>'')
	or (pState2='MA' and pState1 not in ['MA','']),
	   false,
	   true
	  );
*/		
bad_names  := ['UNKNOWN','UNK','UNKN','NONE','N/A','UNAVAILABLE'];
bad_mnames := ['NMN','NMI'];

layout_norm := record
  string1 addr_type := '';
  recordof(File_MA_in);
end;

layout_norm trfNormAddr(File_MA_in l, integer c) := transform
   self.addr_type             := '';
   self.orig_Address1_Street  := choose(c, l.orig_Address1_Street,  l.orig_Address2_Street);
   self.orig_Address1_Street2 := choose(c, l.orig_Address1_Street2, l.orig_Address2_Street2);
   self.orig_Address1_City    := choose(c, l.orig_Address1_City,    l.orig_Address2_City);
   self.orig_Address1_State   := choose(c, l.orig_Address1_State,   l.orig_Address2_State);
   self.orig_Address1_ZipAll  := choose(c, l.orig_Address1_ZipAll,  l.orig_Address2_ZipAll);   
   self.clean1_prim_range     := choose(C, l.clean1_prim_range,     l.clean2_prim_range);
   self.clean1_predir         := choose(C, l.clean1_predir,         l.clean2_predir);
   self.clean1_prim_name      := choose(C, l.clean1_prim_name,      l.clean2_prim_name);   
   self.clean1_addr_suffix    := choose(C, l.clean1_addr_suffix,    l.clean2_addr_suffix);
   self.clean1_postdir        := choose(C, l.clean1_postdir,        l.clean2_postdir);
   self.clean1_unit_desig     := choose(C, l.clean1_unit_desig,     l.clean2_unit_desig);
   self.clean1_sec_range      := choose(C, l.clean1_sec_range,      l.clean2_sec_range);
   self.clean1_p_city_name    := choose(C, l.clean1_p_city_name,    l.clean2_p_city_name);
   self.clean1_v_city_name    := choose(C, l.clean1_v_city_name,    l.clean2_v_city_name);   
   self.clean1_st             := choose(C, l.clean1_st,             l.clean2_st);   
   self.clean1_zip            := choose(C, l.clean1_zip,            l.clean2_zip);   
   self.clean1_zip4           := choose(C, l.clean1_zip4,           l.clean2_zip4);   
   self.clean1_cart           := choose(C, l.clean1_cart,           l.clean2_cart);   
   self.clean1_cr_sort_sz     := choose(C, l.clean1_cr_sort_sz,     l.clean2_cr_sort_sz);   
   self.clean1_lot            := choose(C, l.clean1_lot,            l.clean2_lot);   
   self.clean1_lot_order      := choose(C, l.clean1_lot_order,      l.clean2_lot_order);
   self.clean1_dpbc           := choose(C, l.clean1_dpbc,           l.clean2_dpbc);   
   self.clean1_chk_digit      := choose(C, l.clean1_chk_digit,      l.clean2_chk_digit);   
   self.clean1_record_type    := choose(C, l.clean1_record_type,    l.clean2_record_type);   
   self.clean1_ace_fips_st    := choose(C, l.clean1_ace_fips_st,    l.clean2_ace_fips_st);
   self.clean1_fipscounty     := choose(C, l.clean1_fipscounty,     l.clean2_fipscounty);
   self.clean1_geo_lat        := choose(C, l.clean1_geo_lat,        l.clean2_geo_lat);
   self.clean1_geo_long       := choose(C, l.clean1_geo_long,       l.clean2_geo_long);
   self.clean1_msa            := choose(C, l.clean1_msa,            l.clean2_msa);
   self.clean1_geo_blk        := choose(C, l.clean1_geo_blk,        l.clean2_geo_blk);
   self.clean1_geo_match      := choose(C, l.clean1_geo_match,      l.clean2_geo_match);
   self.clean1_err_stat       := choose(C, l.clean1_err_stat,       l.clean2_err_stat);   
   self                       := l;
end;

norm_file := normalize(File_MA_in, 
					   if(trim(left.clean1_prim_range,left,right)  <> trim(left.clean2_prim_range,left,right) and
					      trim(left.clean1_prim_name,left,right)   <> trim(left.clean2_prim_name,left,right) and
						  trim(left.clean1_predir,left,right)      <> trim(left.clean2_predir,left,right) and
						  trim(left.clean1_sec_range,left,right)   <> trim(left.clean2_sec_range,left,right) and
						  trim(left.clean1_p_city_name,left,right) <> trim(left.clean2_p_city_name,left,right) and
						  trim(left.clean1_st,left,right)          <> trim(left.clean2_st,left,right) and
						  trim(left.clean1_zip,left,right)         <> trim(left.clean2_zip,left,right) and
						  trim(left.orig_Address2_Street,left,right) + trim(left.orig_Address2_Street2,left,right) <> '' and 
						  trim(left.orig_Address2_ZipAll,left,right) <> '' ,2,1)
					   ,trfNormAddr(left,counter));


DriversV2.Layout_DL_Extended lTransform_MA_To_Common(norm_file pInput)
 := transform
	self.orig_state 							:= 'MA';
	self.dt_first_seen 						:= 0; 
	self.dt_last_seen 						:= 0; 
	self.dt_vendor_first_reported := (unsigned8)pInput.append_PROCESS_DATE div 100;
	self.dt_vendor_last_reported 	:= (unsigned8)pInput.append_PROCESS_DATE div 100;
	self.dateReceived							:= (integer)pInput.append_PROCESS_DATE;		

	self.dl_number 								:= pInput.orig_DLNumber;
	self.ssn											:= if(length(trim(lib_stringlib.stringlib.stringfilter(pInput.orig_DLNumber,'0123456789')))=9,pInput.orig_DLNumber,'');
	self.name											:= trim(pInput.orig_FirstName) + 
																	 trim(' ' + pInput.orig_MiddleName) +
																	 trim(' ' + pInput.orig_LastName);
	self.RawFullName							:= trim(pInput.orig_FirstName) + 
																	 trim(' ' + pInput.orig_MiddleName) +
																	 trim(' ' + pInput.orig_LastName);
	self.dob 											:= (unsigned4)lValidDate(pInput.orig_DOB);
	self.sex_flag									:= lib_stringlib.stringlib.stringfilter(pInput.orig_Sex,'MFU');
	self.height										:= if((integer2)(pInput.orig_Height)>=400,pInput.orig_Height,'');
	self.addr1										:= trim(pInput.orig_Address1_Street) + trim(' ' + pInput.orig_Address1_Street2);									   
	self.city 										:= pInput.orig_Address1_City;
	self.state										:= pInput.orig_Address1_State;
	self.zip 											:= pInput.orig_Address1_ZipAll[1..5];
	self.expiration_date          := (unsigned4)lValidDate(pInput.orig_ExpireDate);
	self.license_class 						:= lib_stringlib.stringlib.stringfilter(pInput.orig_DLClass[1],'ABCD');
	self.license_type 			    	:= '';
	self.OrigLicenseClass 				:= pInput.orig_DLClass;
	self.OrigLicenseType					:= '';	
	self.moxie_license_type 			:= lib_stringlib.stringlib.stringfilter(pInput.orig_DLClass[1],'ABCD');
	self.lic_endorsement					:= if(lib_stringlib.stringlib.stringfind(pInput.orig_DLClass,'M',1)<>0,'M','');
	self.title 										:= pInput.clean_name_prefix;
	self.fname 										:= if (trim(pInput.clean_name_first,left,right) in bad_names,'',pInput.clean_name_first);		                             
	self.mname 										:= if (trim(pInput.clean_name_middle,left,right) in bad_names + bad_mnames,'',pInput.clean_name_middle);		                             
	self.lname 										:= if (trim(pInput.clean_name_last,left,right) in bad_names,'',pInput.clean_name_last);	                             
	self.name_suffix 							:= pInput.clean_name_suffix;		                             
	self.cleaning_score 					:= pInput.clean_name_score;		                             
	self.prim_range 							:= pInput.clean1_prim_range;
	self.predir 				    			:= pInput.clean1_predir;
	self.prim_name 								:= pInput.clean1_prim_name;
	self.suffix 									:= pInput.clean1_addr_suffix;
	self.postdir 									:= pInput.clean1_postdir;
	self.unit_desig 							:= pInput.clean1_unit_desig;
	self.sec_range 								:= pInput.clean1_sec_range;
	self.p_city_name 							:= pInput.clean1_p_city_name;
	self.v_city_name 							:= pInput.clean1_v_city_name;
	self.st 											:= pInput.clean1_st;
  self.zip5		                  := pInput.clean1_zip;
	self.zip4 										:= pInput.clean1_zip4;
	self.cart 										:= pInput.clean1_cart;
	self.cr_sort_sz 							:= pInput.clean1_cr_sort_sz;
	self.lot 					    				:= pInput.clean1_lot;
	self.lot_order          			:= pInput.clean1_lot_order;
	self.dpbc 										:= pInput.clean1_dpbc;
	self.chk_digit 								:= pInput.clean1_chk_digit;
	self.rec_type 								:= pInput.clean1_record_type;
	self.ace_fips_st 							:= pInput.clean1_ace_fips_st;
	self.county 									:= pInput.clean1_fipscounty;
	self.geo_lat 									:= pInput.clean1_geo_lat;
	self.geo_long 								:= pInput.clean1_geo_long;
	self.msa 											:= pInput.clean1_msa;
	self.geo_blk 									:= pInput.clean1_geo_blk;
	self.geo_match 								:= pInput.clean1_geo_match;
	self.err_stat 								:= pInput.clean1_err_stat;
	self.issuance 								:= ''; // had to include explcitly because of...
end;

export MA_as_DL := project(norm_file, lTransform_MA_To_Common(left));