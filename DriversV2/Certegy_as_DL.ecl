infile:=File_certegy_in;
       reformatDate(string rDate) := function
	        valid_date:= if(trim(rDate,left,right)<>'2099-12-31',stringlib.stringfindreplace(trim(rdate,left,right),'-',''),'');
		   return valid_date;
			
	   end;
		
DriversV2.Layout_DL_Extended lTransform_CertegyTo_Common(infile l):= transform
    self.did                      := l.did;
	self.source_code              := 'CY';
	self.orig_state 			  := trim(l.orig_DL_State,left,right);
	self.dt_first_seen 			  := 0;
	self.dt_last_seen 			  := 0; 
	self.dt_vendor_first_reported := (unsigned8)l.date_vendor_first_reported div 100;
	self.dt_vendor_last_reported  := (unsigned8)l.date_vendor_last_reported div 100;
	self.name				      := trim(l.orig_First_Name,left,right) + ' ' + trim(l.orig_Mid_Name,left,right)+ ' ' + trim(l.orig_Last_Name,left,right) ;
	self.addr1					  := trim(l.orig_House_Bldg_Num)+' '+
									 trim(l.orig_Street_Pre_Dir)+' '+
									 trim(l.orig_Street_Name)+' '+
									 trim(l.orig_Street_Suffix)+' '+
									 trim(l.orig_Street_Post_Dir)+' '+
									 trim(l.orig_Unit_Desc)+' '+
									 trim(l.orig_Apt_Num);
	self.city 					  := trim(l.orig_City,left,right);		                             
	self.state					  := trim(l.orig_State,left,right);
	self.zip 					  := trim(l.orig_zip,left,right);		                             
	self.dob 					  := (unsigned4)l.clean_DOB;
	self.dod                      := reformatDate(l.orig_Deceased_Dte);
	self.ssn_safe                 := l.clean_ssn;
	self.expiration_date		  := (unsigned4)reformatDate(l.orig_DL_Expire_Dte);
	self.lic_issue_date 		  := (unsigned4)reformatDate(l.orig_DL_Issue_Dte);
	self.dl_number 				  := trim(l.orig_DL_Num,left,right);
	self.history				  := 'U';
	self.title 					  := l.title;
	self.fname 					  := l.fname;		                             
	self.mname 					  := l.mname;                             
	self.lname 					  := l.lname;	                             
	self.name_suffix 			  := l.name_suffix;	                             
	self.cleaning_score 		  := l.name_score;			                             
	self.prim_range 			  := l.prim_range;		                             
	self.predir 				  := l.predir;	                             
	self.prim_name 				  := l.prim_name;		                             
	self.suffix 				  := l.addr_suffix;		                             
	self.postdir 				  := l.postdir;	                             
	self.unit_desig 			  := l.unit_desig;		                             
	self.sec_range 				  := l.sec_range ;	                             
	self.p_city_name 			  := l.p_city_name;		                             
	self.v_city_name 			  := l.v_city_name;	                             
	self.st 				      := l.st;	                             
	self.zip5 					  := l.zip;		                             
	self.zip4 					  := l.zip4;	                             
	self.cart 					  := l.cart;	                             
	self.cr_sort_sz 			  := l.cr_sort_sz;		                             
	self.lot 				      := l.lot;		                             
	self.lot_order 			      := l.lot_order;		                             
	self.dpbc 					  := l.dbpc;	                             
	self.chk_digit 				  := l.chk_digit;	                             
	self.rec_type 				  := l.rec_type;	                             
	self.ace_fips_st 			  := l.fips_county;		                             
	self.county 				  := l.county;		                             
	self.geo_lat 				  := l.geo_lat;		                             
	self.geo_long 				  := l.geo_long;                           
	self.msa 				      := l.msa ;		                             
	self.geo_blk 				  := l.geo_blk;	                             
	self.geo_match 			  	  := l.geo_match;		                             
	self.err_stat 				  := l.err_stat;	
	self                          := l;
	self		  				  := [];
end;	

 export Certegy_as_DL := project(infile, lTransform_CertegyTo_Common(left)): persist(DriversV2.Constants.Cluster + 'Persist::DL2::DrvLic_Certegy_as_DL');