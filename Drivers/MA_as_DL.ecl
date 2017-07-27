import Ut, lib_stringlib;

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

boolean fFirstAddressBetter(string pPrimName1, string pState1, string pPrimName2, string pState2)
 := if(((pPrimName1[1..6] = 'PO BOX' or pPrimName1[1..3] = 'RR ') and pState2<>'')
	or (pState2='MA' and pState1 not in ['MA','']),
	   false,
	   true
	  );

Drivers.Layout_DL lTransform_MA_To_Common(Drivers.Layout_MA_Full pInput)
 := transform
    self.dt_first_seen 				:= (unsigned8)pInput.append_PROCESS_DATE div 100;
    self.dt_last_seen 				:= (unsigned8)pInput.append_PROCESS_DATE div 100;
    self.dt_vendor_first_reported 	:= (unsigned8)pInput.append_PROCESS_DATE div 100;
    self.dt_vendor_last_reported 	:= (unsigned8)pInput.append_PROCESS_DATE div 100;
    self.orig_state 				:= 'MA';

	self.dl_number 					:= pInput.orig_DLNumber;
	self.ssn						:= if(length(trim(lib_stringlib.stringlib.stringfilter(pInput.orig_DLNumber,'0123456789')))=9,pInput.orig_DLNumber,'');
	self.name						:= trim(pInput.orig_FirstName) + 
									   trim(' ' + pInput.orig_MiddleName) +
									   trim(' ' + pInput.orig_LastName)
									   ;
	self.dob 						:= (unsigned4)lValidDate(pInput.orig_DOB);
	self.sex_flag					:= lib_stringlib.stringlib.stringfilter(pInput.orig_Sex,'MFU');
	self.height						:= if((integer2)(pInput.orig_Height)>=400,pInput.orig_Height,'');
	self.addr1						:= if(fFirstAddressBetter(pInput.clean1_prim_name,pInput.clean1_St,pInput.clean2_prim_name,pInput.clean2_St),
										  trim(pInput.orig_Address1_Street) + trim(' ' + pInput.orig_Address1_Street2),
										  trim(pInput.orig_Address2_Street) + trim(' ' + pInput.orig_Address2_Street2)
										 );
	self.city 						:= if(fFirstAddressBetter(pInput.clean1_prim_name,pInput.clean1_St,pInput.clean2_prim_name,pInput.clean2_St),
										  pInput.orig_Address1_City,
										  pInput.orig_Address2_City
										 );
	self.state						:= if(fFirstAddressBetter(pInput.clean1_prim_name,pInput.clean1_St,pInput.clean2_prim_name,pInput.clean2_St),
										  pInput.orig_Address1_State,
										  pInput.orig_Address2_State
										 );
	self.zip 						:= if(fFirstAddressBetter(pInput.clean1_prim_name,pInput.clean1_St,pInput.clean2_prim_name,pInput.clean2_St),
										  pInput.orig_Address1_ZipAll[1..5],
										  pInput.orig_Address2_ZipAll[1..5]
										 );
	self.orig_expiration_date		:= (unsigned4)lValidDate(pInput.orig_ExpireDate);
	self.license_type 				:= lib_stringlib.stringlib.stringfilter(pInput.orig_DLClass[1],'ABCD');
	self.lic_endorsement			:= if(lib_stringlib.stringlib.stringfind(pInput.orig_DLClass,'M',1)<>0,'M','');
	self.title 						:= pInput.clean_name_prefix;
	self.fname 						:= pInput.clean_name_first;		                             
	self.mname 						:= pInput.clean_name_middle;		                             
	self.lname 						:= pInput.clean_name_last;		                             
	self.name_suffix 				:= pInput.clean_name_suffix;		                             
	self.cleaning_score 			:= pInput.clean_name_score;		                             
	self.prim_range 				:= if(fFirstAddressBetter(pInput.clean1_prim_name,pInput.clean1_St,pInput.clean2_prim_name,pInput.clean2_St),
										  pInput.clean1_prim_range,
										  pInput.clean2_prim_range
                                         );
	self.predir 					:= if(fFirstAddressBetter(pInput.clean1_prim_name,pInput.clean1_St,pInput.clean2_prim_name,pInput.clean2_St),
                                          pInput.clean1_predir,
                                          pInput.clean2_predir
										 );
	self.prim_name 					:= if(fFirstAddressBetter(pInput.clean1_prim_name,pInput.clean1_St,pInput.clean2_prim_name,pInput.clean2_St),
										  pInput.clean1_prim_name,
										  pInput.clean2_prim_name
										 );
	self.suffix 					:= if(fFirstAddressBetter(pInput.clean1_prim_name,pInput.clean1_St,pInput.clean2_prim_name,pInput.clean2_St),
										  pInput.clean1_addr_suffix,
										  pInput.clean2_addr_suffix
										 );
	self.postdir 					:= if(fFirstAddressBetter(pInput.clean1_prim_name,pInput.clean1_St,pInput.clean2_prim_name,pInput.clean2_St),
										  pInput.clean1_postdir,
										  pInput.clean2_postdir
										 );
	self.unit_desig 				:= if(fFirstAddressBetter(pInput.clean1_prim_name,pInput.clean1_St,pInput.clean2_prim_name,pInput.clean2_St),
										  pInput.clean1_unit_desig,
										  pInput.clean2_unit_desig
										 );
	self.sec_range 					:= if(fFirstAddressBetter(pInput.clean1_prim_name,pInput.clean1_St,pInput.clean2_prim_name,pInput.clean2_St),
										  pInput.clean1_sec_range,
										  pInput.clean2_sec_range
										 );
	self.p_city_name 				:= if(fFirstAddressBetter(pInput.clean1_prim_name,pInput.clean1_St,pInput.clean2_prim_name,pInput.clean2_St),
										  pInput.clean1_p_city_name,
										  pInput.clean2_p_city_name
										 );
	self.v_city_name 				:= if(fFirstAddressBetter(pInput.clean1_prim_name,pInput.clean1_St,pInput.clean2_prim_name,pInput.clean2_St),
										  pInput.clean1_v_city_name,
										  pInput.clean2_v_city_name
										 );
	self.st 						:= if(fFirstAddressBetter(pInput.clean1_prim_name,pInput.clean1_St,pInput.clean2_prim_name,pInput.clean2_St),
										  pInput.clean1_st,
        								  pInput.clean2_st
										 );
    self.zip5                       := if(fFirstAddressBetter(pInput.clean1_prim_name,pInput.clean1_St,pInput.clean2_prim_name,pInput.clean2_St),
										  pInput.clean1_zip,
										  pInput.clean2_zip
										 );
	self.zip4 						:= if(fFirstAddressBetter(pInput.clean1_prim_name,pInput.clean1_St,pInput.clean2_prim_name,pInput.clean2_St),
										  pInput.clean1_zip4,
										  pInput.clean2_zip4
										 );
	self.cart 						:= if(fFirstAddressBetter(pInput.clean1_prim_name,pInput.clean1_St,pInput.clean2_prim_name,pInput.clean2_St),
										  pInput.clean1_cart,
										  pInput.clean2_cart
										 );
	self.cr_sort_sz 				:= if(fFirstAddressBetter(pInput.clean1_prim_name,pInput.clean1_St,pInput.clean2_prim_name,pInput.clean2_St),
										  pInput.clean1_cr_sort_sz,
										  pInput.clean2_cr_sort_sz
										 );
	self.lot 						:= if(fFirstAddressBetter(pInput.clean1_prim_name,pInput.clean1_St,pInput.clean2_prim_name,pInput.clean2_St),
										  pInput.clean1_lot,
										  pInput.clean2_lot
										 );
	self.lot_order 					:= if(fFirstAddressBetter(pInput.clean1_prim_name,pInput.clean1_St,pInput.clean2_prim_name,pInput.clean2_St),
										  pInput.clean1_lot_order,
										  pInput.clean2_lot_order
										 );
	self.dpbc 						:= if(fFirstAddressBetter(pInput.clean1_prim_name,pInput.clean1_St,pInput.clean2_prim_name,pInput.clean2_St),
										  pInput.clean1_dpbc,
										  pInput.clean2_dpbc
										 );
	self.chk_digit 					:= if(fFirstAddressBetter(pInput.clean1_prim_name,pInput.clean1_St,pInput.clean2_prim_name,pInput.clean2_St),
										  pInput.clean1_chk_digit,
										  pInput.clean2_chk_digit
										 );
	self.rec_type 					:= if(fFirstAddressBetter(pInput.clean1_prim_name,pInput.clean1_St,pInput.clean2_prim_name,pInput.clean2_St),
										  pInput.clean1_record_type,
										  pInput.clean2_record_type
										 );
	self.ace_fips_st 				:= if(fFirstAddressBetter(pInput.clean1_prim_name,pInput.clean1_St,pInput.clean2_prim_name,pInput.clean2_St),
										  pInput.clean1_ace_fips_st,
										  pInput.clean2_ace_fips_st
										 );
	self.county 					:= if(fFirstAddressBetter(pInput.clean1_prim_name,pInput.clean1_St,pInput.clean2_prim_name,pInput.clean2_St),
										  pInput.clean1_fipscounty,
										  pInput.clean2_fipscounty
										 );
	self.geo_lat 					:= if(fFirstAddressBetter(pInput.clean1_prim_name,pInput.clean1_St,pInput.clean2_prim_name,pInput.clean2_St),
										  pInput.clean1_geo_lat,
										  pInput.clean2_geo_lat
										 );
	self.geo_long 					:= if(fFirstAddressBetter(pInput.clean1_prim_name,pInput.clean1_St,pInput.clean2_prim_name,pInput.clean2_St),
										  pInput.clean1_geo_long,
										  pInput.clean2_geo_long
										 );
	self.msa 						:= if(fFirstAddressBetter(pInput.clean1_prim_name,pInput.clean1_St,pInput.clean2_prim_name,pInput.clean2_St),
										  pInput.clean1_msa,
										  pInput.clean2_msa
										 );
	self.geo_blk 					:= if(fFirstAddressBetter(pInput.clean1_prim_name,pInput.clean1_St,pInput.clean2_prim_name,pInput.clean2_St),
										  pInput.clean1_geo_blk,
										  pInput.clean2_geo_blk
										 );
	self.geo_match 					:= if(fFirstAddressBetter(pInput.clean1_prim_name,pInput.clean1_St,pInput.clean2_prim_name,pInput.clean2_St),
										  pInput.clean1_geo_match,
										  pInput.clean2_geo_match
										 );
	self.err_stat 					:= if(fFirstAddressBetter(pInput.clean1_prim_name,pInput.clean1_St,pInput.clean2_prim_name,pInput.clean2_St),
										  pInput.clean1_err_stat,
										  pInput.clean2_err_stat
										 );
	self.issuance 					:= ''; // had to include explcitly because of...
end;

export MA_as_DL := project(Drivers.File_MA_Full, lTransform_MA_To_Common(left));