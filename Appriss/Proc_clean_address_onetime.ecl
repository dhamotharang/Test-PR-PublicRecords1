import ut,DID_Add;

#option('skipFileFormatCrcCheck', 1);

basename:=cluster_name+'::base::Appriss_';	

Layout_Base_Bookings cleanaddress ( Appriss.file_bookings_base L ) := transform

  ap_addr1 := MAP( stringlib.stringfind(l.ap_address1,'/',2) <> 0 => stringlib.stringfilterout(l.ap_address1,'/'),
	                 stringlib.stringfilterout(l.ap_address1,'0-.') = '' => '',
									 stringlib.stringfilterout(l.ap_address1,'0;/\\-.]\'') = '' => '',
									 regexfind('[\'"][a-zA-z][\'"]',l.ap_address1)=> stringlib.stringfilterout(l.ap_address1,'"\''),
	                 l.ap_address1);
									 
	ap_addr2 := MAP( stringlib.stringfind(ap_addr1,'.',2) <> 0 => stringlib.stringfilterout(ap_addr1,'.'),
	                 ap_addr1);
									 
	ap_addr3 := MAP( ap_addr2[1..1] in ['.','\''] => ap_addr2[2..],
									 ap_addr2);
									 									 
  ap_addr  := trim(stringlib.stringfilterout(ap_addr3,'!%\\*+$^~@'),left,right);
							 
	ap_city1  := MAP(regexfind('^N[ ]*/[ ;]*A$',trim(L.ap_city,left,right),0) <> '' => '',
	                 regexfind('[A-Za-z]',L.ap_city,0) ='' => '',
		 							 //regexfind('^#[0-9]+ [A-Za-z]+',L.ap_city) => stringlib.stringfilterout(L.ap_city,'0123456789#'),
	                 TRIM(L.ap_city)
									);
	ap_city   := 		trim(stringlib.stringfilterout(ap_city1,'.!%\\*+$^~@'),left,right);						
									
	ap_zip   := If ((integer)TRIM(L.ap_zipcode) =0 , '', TRIM(L.ap_zipcode));							

  vcleanaddress 						:= AddrCleanLib.CleanAddress182(TRIM(ap_addr)+TRIM(l.ap_address2),
                               ap_city+','+TRIM(L.ap_state)+','+ap_zip);
														 
  self.prim_range    				:= vCleanAddress[1..10];
	self.predir 	      			:= vCleanAddress[11..12];
	self.prim_name 	  				:= vCleanAddress[13..40];
	self.addr_suffix   				:= vCleanAddress[41..44];
	self.postdir 	    				:= vCleanAddress[45..46];
	self.unit_desig 	  			:= vCleanAddress[47..56];
	self.sec_range 	  				:= vCleanAddress[57..64];
	self.p_city_name	  			:= vCleanAddress[65..89];
	self.v_city_name	  			:= vCleanAddress[90..114];
	self.state			      		:= vCleanAddress[115..116];
	self.zip5		      				:= vCleanAddress[117..121];
	self.zip4 		      			:= vCleanAddress[122..125];
	self.cart 		      			:= vCleanAddress[126..129];
	self.cr_sort_sz 	 		 		:= vCleanAddress[130];
	self.lot 		      				:= vCleanAddress[131..134];
	self.lot_order 	  				:= vCleanAddress[135];
	self.dpbc 		      			:= vCleanAddress[136..137];
	self.chk_digit 	  				:= vCleanAddress[138];
	self.rec_type		  				:= vCleanAddress[139..140];
	self.ace_fips_st	  			:= vCleanAddress[141..142];
	self.ace_fips_county 	 		:= vCleanAddress[143..145];
	self.geo_lat 	    				:= vCleanAddress[146..155];
	self.geo_long 	    			:= vCleanAddress[156..166];
	self.msa 		      				:= vCleanAddress[167..170];
	self.geo_blk							:= vCleanAddress[171..177];
	self.geo_match 	  				:= vCleanAddress[178];
	self.err_stat 	    			:= vCleanAddress[179..182];
	self := L;
end;
dbookings              :=  distribute(Appriss.file_bookings_base,hash(booking_sid));
bookings               := PROJECT(dbookings,cleanaddress(left),local);

lMatchSet := ['S','A','D'];

did_Add.MAC_Match_Flex//_Sensitive  // NOTE <- removed sensitive macro 4/15/2008
	(bookings, lMatchSet,						
	 ap_ssn, dob, fname, mname, lname, name_suffix, 
	 prim_range, prim_name, sec_range, zip5, state, fake_phone_field, 
	 did,
	 Layout_Base_Bookings, //bookings_rec_norm,
	 false, fake_DID_Score_field,
	 75,						//dids with a score below here will be dropped
	 ds_bookings_with_did
	)

DID_Add.MAC_Add_SSN_By_DID(ds_bookings_with_did, did, ssn, ds_bookings_with_ssn)

ut.MAC_SF_BuildProcess(ds_bookings_with_ssn,basename+'bookings',outbookings,3,false,true);

export Proc_clean_address_onetime := sequential(outbookings);