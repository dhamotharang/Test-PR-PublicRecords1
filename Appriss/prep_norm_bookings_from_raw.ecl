
/*
This will 
 1. Separate the bookings from the raw parent child structure
 2. Format the dates and timestamps into standard format
 3. Clean Names and Addresses

*/

layout_prep_booking_rec normBookings(layout_in_bookings_raw_xml L):= TRANSFORM

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

vcleanname 								:= AddrCleanLib.CleanPersonLFM73(L.ap_full_name);

vcleanaddress 						:= AddrCleanLib.CleanAddress182(TRIM(ap_addr)+TRIM(l.ap_address2),
                               ap_city+','+TRIM(L.ap_state)+','+ap_zip);

self.creation_ts					:=fnDateTime(L.creation_ts);
self.last_change_ts				:=fnDateTime(L.last_change_ts);
self.arrest_ts						:=fnDateTime(L.arrest_ts);
self.booking_ts						:=fnDateTime(L.booking_ts);
self.booking_ts_raw				:=fnDateTime(L.booking_ts_raw);
self.release_ts						:=fnDateTime(L.release_ts);
self.offense_ts						:=fnDateTime(L.offense_ts);
//
self.arrest_date      		:=fnDateTime(L.arrest_date);
self.booking_date      		:=fnDateTime(L.booking_date);
self.release_date     		:=fnDateTime(L.release_date);
self.offense_date      		:=fnDateTime(L.offense_date);
self.scheduled_release_date      :=fnDateTime(L.scheduled_release_date);
self.sentence_exp_date           :=fnDateTime(L.sentence_exp_date);
self.date_of_birth     		:=fnDateTime(L.date_of_birth);
self.dob     					 		:=fnDateTime(L.dob);
////////////////////////////////////////////////////////////// Added 20101029
 self.dlnumber :=  MAP (trim(l.dlnumber) IN ['REVOKED','SUSPENDED'] =>trim(l.dlnumber),
                        regexfind('[a-zA-Z]*[1-9][a-zA-Z]*',trim(l.dlnumber),0) = '' =>'',
												trim(l.dlnumber) <> '' and regexfind('[a-zA-Z]*[0-9][a-zA-Z]*',trim(l.dlnumber)) => trim(l.dlnumber),
												//(integer)l.dlnumber = 0 => '',
												''  );

 self.fbi_nbr  :=  MAP (regexfind('[a-zA-Z]*[1-9][a-zA-Z]*',trim(l.fbi_nbr),0) = '' =>'',
                        l.fbi_nbr <> '' and regexfind('[a-zA-Z]*[0-9][a-zA-Z]*',trim(l.fbi_nbr)) =>trim(l.fbi_nbr),
												//(integer)l.fbi_nbr = 0 => '',
												'');  
												
 self.state_id :=  MAP (regexfind('[a-zA-Z]*[1-9][a-zA-Z]*',trim(l.state_id),0) = '' =>'',
                        l.state_id <> '' and regexfind('[a-zA-Z]*[0-9]*[a-zA-Z]*',trim(l.state_id)) =>trim(l.state_id),
                        //(integer)l.state_id = 0 => '',
												''); 		
												
 self.ap_ssn   :=  MAP (trim(l.ap_ssn) = 'EXPUNGED' => trim(l.ap_ssn),
                        regexfind('[a-zA-Z]*[1-9][a-zA-Z]*',trim(l.ap_ssn),0) = '' =>'',
												l.ap_ssn <> '' and regexfind('([0-9])',l.ap_ssn) => trim(l.ap_ssn),
												//(integer)l.ap_ssn = 0 => '',
												'');	
												
self.HOME_PHONE := If(length(stringlib.stringfilterout(l.home_phone,'()+- ')) < 10 ,'',stringlib.stringfilterout(l.home_phone,'()- '));
self.WORK_PHONE := If(length(stringlib.stringfilterout(l.work_phone,'()+- ')) < 10 ,'',stringlib.stringfilterout(l.work_phone,'()- '));
												
//////////////////////////////////////////////////////////////
	self.title			      		:= vCleanName[1..5];
	self.fname			      		:= vCleanName[6..25];
	self.mname			      		:= vCleanName[26..45];
	self.lname			      		:= vCleanName[46..65];
	self.name_suffix	    		:= vCleanName[66..70];
	self.name_score					  := vCleanName[71..73];
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
	self.ssn					    		:= ''; // These will be filled in by the macro
	self.did              		:= 0;  //   "
// The rest of the fields
	self:=L;
END;

export prep_norm_bookings_from_raw :=PROJECT(file_in_bookings_raw_xml,normBookings(LEFT));