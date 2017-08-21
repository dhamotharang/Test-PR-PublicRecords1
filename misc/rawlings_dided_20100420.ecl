import DID_Add, address,Header_Slimsort, ut, Lib_Stringlib, WatchDog, didville;

format_date(string indate) := function
    DateFinder := '^([0-9]{1,2})/([0-9]{1,2})/([0-9]{4})$';	
	in_Date := trim(indate, left,right);
	outDate := if(regexfind(DateFinder,in_Date),
				  intformat((integer)regexfind(DateFinder,in_Date,3),4,1) +
				  intformat((integer)regexfind(DateFinder,in_Date,1),2,1) +
				  intformat((integer)regexfind(DateFinder,in_Date,2),2,1),
				  '');						  
	return (outDate);
end;

layout_in := record
	string FIRST_NAME;
	string LAST_NAME;
	string orig_SSN;
	string orig_DOB;
	string orig_CITY;
	string orig_STATE_ABBR;
	string orig_ZIP;
	string orig_DATE_OF_LOSS;
	string RAWLINGS_KEY;
	end;
in := dataset('~thor::temp::rawlings_file_ii_20100420',layout_in,csv(separator('\t')));


layout_clean := record
	layout_in;
	//
	string9 ssn;
	string4 ssn4;
	//
	string8 DOB;
	string8 DOL;
	//
	string5 title;
	string20 fname;
	string20 mname;
	string20 lname;
	string5	name_suffix;
	//
	string10  prim_range;
	string2   predir;
	string28  prim_name;
	string4   addr_suffix;
	string2   postdir;
	string10  unit_desig;
	string8   sec_range;
	string25  p_city_name;
	string25  v_city_name;
	string2   state;
	string5   zip5;
	string4   zip4;
	string4   cart;
	string1   cr_sort_sz;
	string4   lot;
	string1   lot_order;
	string2   dpbc;
	string1   chk_digit;
	string2   rec_type;
	string2   ace_fips_st;
	string3   county;
	string10  geo_lat;
	string11  geo_long;
	string4   msa;
	string7   geo_blk;
	string1   geo_match;
	string4   err_stat;
	//
	unsigned6 did := 0;
	end;
layout_clean to_clean(in l) := transform
    string182 vclean_address := Address.CleanAddress182('', trim(l.orig_city)+', '+trim(l.orig_state_abbr)+ ' '+trim(l.orig_zip));
	 //
	self.ssn := '     '+l.orig_ssn;
	self.ssn4 := l.orig_ssn;
	
	self.dob := format_date(l.orig_dob);
	self.dol := format_date(l.orig_date_of_loss);
	//
	self.title := '';
	self.fname := l.first_name;
	self.mname := '';
	self.lname := l.last_name;
	self.name_suffix := '';
	//
	self.prim_range    			:= vclean_address[1..10];
	self.predir 	      		:= vclean_address[11..12];
	self.prim_name 	  			:= vclean_address[13..40];
	self.addr_suffix   			:= vclean_address[41..44];
	self.postdir 	    		:= vclean_address[45..46];
	self.unit_desig 	  		:= vclean_address[47..56];
	self.sec_range 	  			:= vclean_address[57..64];
	self.p_city_name	  		:= vclean_address[65..89];
	self.v_city_name	  		:= vclean_address[90..114];
	self.state 			    	:= vclean_address[115..116];
	self.zip5 		      		:= vclean_address[117..121];
	self.zip4 		      		:= vclean_address[122..125];
	self.cart 		      		:= vclean_address[126..129];
	self.cr_sort_sz 	 		:= vclean_address[130];
	self.lot 		      		:= vclean_address[131..134];
	self.lot_order 	  			:= vclean_address[135];
	self.dpbc 		      		:= vclean_address[136..137];
	self.chk_digit 	  			:= vclean_address[138];
	self.rec_type		  		:= vclean_address[139..140];
	self.ace_fips_st	  		:= vclean_address[141..142];
	self.county 	  			:= vclean_address[143..145];
	self.geo_lat 	    		:= vclean_address[146..155];
	self.geo_long 	    		:= vclean_address[156..166];
	self.msa 		      		:= vclean_address[167..170];
	self.geo_blk				:= vclean_address[171..177];
	self.geo_match 	  			:= vclean_address[178];
	self.err_stat 	    		:= vclean_address[179..182];	
	self := l;
	end;
clean := project(in,to_clean(left));


lMatchSet := ['4','A','D'];

did_Add.MAC_Match_Flex//_Sensitive  // NOTE <- removed sensitive macro 4/15/2008
	(clean, lMatchSet,						
	 ssn, dob, fname, mname, lname, name_suffix, 
	 prim_range, prim_name, sec_range, zip5, state, fake_phone_field, 
	 did,
	 layout_clean,
	 false, fake_DID_Score_field,
	 75,						//dids with a score below here will be dropped
	 with_did
	);

export rawlings_dided_20100420 := with_did : persist('~thor::persist::rawlings_dided_20100420');
