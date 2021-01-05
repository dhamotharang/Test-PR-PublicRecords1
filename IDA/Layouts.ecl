IMPORT address,AID;

EXPORT Layouts := module
  
Export Input :=RECORD
  STRING20 firstname;
  STRING20 middlename;
  STRING25 lastname;
  STRING3 suffix;
  STRING50 addressline1;
  STRING20 addressline2;
  STRING35 city;
  STRING2 state;
  STRING5 zip;
  UNSIGNED4 dob;
  STRING12 ssn;
  STRING12 dl;
  STRING5 dlstate;
  STRING10 phone;
  UNSIGNED8 clientassigneduniquerecordid;
  STRING50 emailaddress;
  STRING15 ipaddress;
	STRING20 filecategory;
	end;
	

EXPORT Base := RECORD
	STRING15	persistent_record_id ;
	STRING2   src;			//				
	UNSIGNED6 Dt_first_seen;
	UNSIGNED6 Dt_last_seen;
	UNSIGNED6 Dt_vendor_first_reported;
	UNSIGNED6 Dt_vendor_last_reported;
	UNSIGNED6 did 			:= 0;
	UNSIGNED1 did_score 			:= 0;
	//Original fields
	string		orig_first_name; 
	string    orig_middle_name;
	string		orig_last_name; 
	STRING3   orig_suffix;
	string		orig_address1; 
	string		orig_address2; 
	string		orig_city; 
	string		orig_state_province; 
	string		orig_zip4; 
	string    orig_zip5;
	UNSIGNED4	orig_dob; 
	STRING12  orig_ssn;
	STRING12  orig_dl;
  STRING5   orig_dlstate;
	string		orig_phone; 
	UNSIGNED8 clientassigneduniquerecordid;
	string adl_ind;
	string		orig_email; 
  STRING15  orig_ipaddress;
  STRING20  orig_filecategory;
		
  address.Layout_Clean_Name.title;
  address.Layout_Clean_Name.fname;
  address.Layout_Clean_Name.mname;
  address.Layout_Clean_Name.lname;
  address.Layout_Clean_Name.name_suffix;
	unsigned8 nid;
  address.Layout_Clean182.prim_range;
  address.Layout_Clean182.predir;
  address.Layout_Clean182.prim_name;
	address.Layout_Clean182.addr_suffix;
	address.Layout_Clean182.postdir;
	address.Layout_Clean182.unit_desig;
	address.Layout_Clean182.sec_range;
	address.Layout_Clean182.p_city_name;
	address.Layout_Clean182.v_city_name;
	address.Layout_Clean182.st;
	address.Layout_Clean182.zip;
	address.Layout_Clean182.zip4;
	address.Layout_Clean182.cart;
	address.Layout_Clean182.cr_sort_sz;
	address.Layout_Clean182.lot;
	address.Layout_Clean182.lot_order;
	address.Layout_Clean182.dbpc;
	address.Layout_Clean182.chk_digit;
	address.Layout_Clean182.rec_type;
	string2		fips_st:='';
	string3		fips_county:='';
	address.Layout_Clean182.geo_lat;
	address.Layout_Clean182.geo_long;
	address.Layout_Clean182.msa;
	address.Layout_Clean182.geo_blk;
	address.Layout_Clean182.geo_match;
	address.Layout_Clean182.err_stat;
	AID.Common.xAID		RawAID;		
	AID.Common.xAID   ACEAID;
	string10 clean_Phone;
	string8 clean_DOB;	
	END;
	
EXPORT Despray := RECORD
	UNSIGNED6 did;
	UNSIGNED8 clientassigneduniquerecordid;
  STRING20  orig_filecategory;
end;

end;

