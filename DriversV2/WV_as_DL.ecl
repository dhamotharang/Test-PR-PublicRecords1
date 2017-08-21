import Ut, lib_stringlib, Drivers;

string lFullZipFromSeparate(string pZip5, string pZip4)
 :=	pZip5
 +	if(pZip4 in ['0000','    ','9999'],
       '',
	   '-' + pZip4[1..4]
	  )
 ;

string8 lFixDate(string10 pDateIn)
 := if(pDateIn[1..4] in ['    ','0000'],
	   '',
	   pDateIn[1..4] + pDateIn[6..7] + pDateIn[9..10]
	  );

bad_names  := ['UNKNOWN','UNK','UNKN','NONE','N/A','UNAVAILABLE'];
bad_mnames := ['NMN','NMI'];

DriversV2.Layout_DL_Extended lTransform_WV_To_Common(Drivers.File_WV_Full pInput)
 := transform
	self.orig_state 			  			:= 'WV';
	self.dt_first_seen 		     		:= (unsigned8)pInput.append_PROCESS_DATE div 100;
	self.dt_last_seen 		     	  := (unsigned8)pInput.append_PROCESS_DATE div 100;
	self.dt_vendor_first_reported := (unsigned8)pInput.append_PROCESS_DATE div 100;
	self.dt_vendor_last_reported  := (unsigned8)pInput.append_PROCESS_DATE div 100;
	self.dateReceived							:= (integer)pInput.append_PROCESS_DATE;	
  self.dl_number 					  		:= pInput.orig_DLNum;
	self.name					  					:= trim(pInput.orig_FName)
																		+ trim(' ' + pInput.orig_MNAME)
																		+ trim(' ' + pInput.orig_LNAME)
																		+ trim(' ' + pInput.orig_NAMESUF);	
	self.RawFullName	  					:= trim(pInput.orig_FName)
																		+ trim(' ' + pInput.orig_MNAME)
																		+ trim(' ' + pInput.orig_LNAME)
																		+ trim(' ' + pInput.orig_NAMESUF);
	self.dob 					  					:=(unsigned4)lFixDate(pInput.orig_DOB);
	self.sex_flag				  				:=pInput.orig_SEX;
	self.height					  				:=pInput.orig_HEIGHT;
	self.weight					  				:=pInput.orig_WEIGHT;
    self.eye_color				  		:=pInput.orig_EYES;
	self.addr1					  				:=trim(trim(if((integer5)pInput.orig_StreetNum=0,'',(string5)(integer5)pInput.orig_StreetNum))
																		+ trim(' ' + pInput.orig_Street),left,right);
	self.city 					  				:=pInput.orig_City;
	self.state					  				:=pInput.orig_State;
	self.zip 					  					:=lFullZipFromSeparate(pInput.orig_Zip,pInput.orig_Zip4);
	self.expiration_date	      	:=(unsigned4)lFixDate(pInput.orig_DLEXPIREDATE);
	self.lic_issue_date 	      	:=(unsigned4)lFixDate(pInput.orig_DLISSUEDATE);
	self.license_class 		      	:=pInput.orig_LICENSECLASS;
	self.license_type 		      	:=pInput.orig_DLTYPE;
	self.OrigLicenseClass	      	:=pInput.orig_LICENSECLASS;
	self.OrigLicenseType 		    	:=pInput.orig_DLTYPE;	
	self.moxie_license_type 			:=pInput.orig_DLTYPE;
	self.restrictions 		      	:=lib_stringlib.stringlib.StringFindReplace(pInput.orig_RESTRICTIONS,' ','');
	//appending license class to endorsements...  non duplicating except "F" and "X,"
	//self.lic_endorsement 	    	:=lib_stringlib.stringlib.StringFindReplace(pInput.orig_ENDORSEMENTS+lib_stringlib.stringlib.stringfilterout(pInput.orig_LICENSECLASS,'FX'),' ','');
	self.lic_endorsement 	      	:=pInput.orig_ENDORSEMENTS;
	self.ssn					  					:=pInput.orig_SSN;
	self.title 					  				:=pInput.clean_name_prefix;
	self.fname 					  				:=if (trim(pInput.clean_name_first,left,right) in bad_names,'',pInput.clean_name_first);		                             
	self.mname 					  				:=if (trim(pInput.clean_name_middle,left,right) in bad_names + bad_mnames,'',pInput.clean_name_middle);		                             
	self.lname 					  				:=if (trim(pInput.clean_name_last,left,right) in bad_names,'',pInput.clean_name_last);		                             
	self.name_suffix 			  			:=pInput.clean_name_suffix;		                             
	self.cleaning_score 	      	:=pInput.clean_name_score;		                             
	self.prim_range 			  			:=pInput.clean_prim_range;		                             
	self.predir 				  				:=pInput.clean_predir;		                             
	self.prim_name 				  			:=pInput.clean_prim_name;		                             
	self.suffix 				  				:=pInput.clean_addr_suffix;		                             
	self.postdir 				  				:=pInput.clean_postdir;		                             
	self.unit_desig 			  			:=pInput.clean_unit_desig;		                             
	self.sec_range 				  			:=pInput.clean_sec_range;		                             
	self.p_city_name 			  			:=pInput.clean_p_city_name;		                             
	self.v_city_name 			  			:=pInput.clean_v_city_name;		                             
	self.st 					  					:=pInput.clean_st;		                             
	self.zip5 					  				:=pInput.clean_zip;		                             
	self.zip4 					  				:=pInput.clean_zip4;		                             
	self.cart 					  				:=pInput.clean_cart;		                             
	self.cr_sort_sz 			  			:=pInput.clean_cr_sort_sz;		                             
	self.lot 					  					:=pInput.clean_lot;		                             
	self.lot_order 				  			:=pInput.clean_lot_order;		                             
	self.dpbc 					  				:=pInput.clean_dpbc;		                             
	self.chk_digit 				  			:=pInput.clean_chk_digit;		                             
	self.rec_type 				  			:=pInput.clean_record_type;		                             
	self.ace_fips_st 			  			:=pInput.clean_ace_fips_st;		                             
	self.county 				  				:=pInput.clean_fipscounty;		                             
	self.geo_lat 				  				:=pInput.clean_geo_lat;		                             
	self.geo_long 				  			:=pInput.clean_geo_long;		                             
	self.msa 					  					:=pInput.clean_msa;		                             
	self.geo_blk 				  				:=pInput.clean_geo_blk;		                             
	self.geo_match 				  			:=pInput.clean_geo_match;		                             
	self.err_stat 				  			:=pInput.clean_err_stat;		                             
	self.issuance 				  			:=''; // had to include explcitly because of...
	self.status                   :=pInput.orig_LicenseStatus;
	self.CDL_status               :=pInput.orig_CDLStatus;
    //self                      :=pInput; //no go
end;

export WV_as_DL := project(Drivers.File_WV_Full, lTransform_WV_To_Common(left));