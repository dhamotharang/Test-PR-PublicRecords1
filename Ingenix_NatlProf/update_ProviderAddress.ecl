import Ingenix_NatlProf,ut,Address;




Provider_Address			:= 	distribute(File_in_ProviderAddress.Allsrc ,hash(FILETYP, ProviderID,AddressID, Address, Address2, City, State, County, ZIP,ExtZip));
Provider_AddressType	:=	distribute(File_in_ProviderAddressType.Allsrc ,hash(FILETYP, ProviderID, AddressID, ProviderAddressTypeCode,AddressTypeCompanyCount,AddressTypeTierTypeID));

//append date and filter out junk data
string address_filter(string addressfield) := StringLib.stringfilter(addressfield, '0123456789');

prov_address_rec := record
	Ingenix_Natlprof.Layout_in_ProviderAddress.raw_srctype;
	string182 clean_address := '';
	string8	dt_first_seen;
	string8	dt_last_seen;
	string8	dt_vendor_first_reported;
	string8	dt_vendor_last_reported;    
end;

prov_address_rec tr_rollupXAddress(Provider_Address L) := transform

   self.dt_first_seen              := '';
	self.dt_last_seen               := '';
	self.dt_vendor_first_reported   := L.processdate;
	self.dt_vendor_last_reported    := L.processdate;
	self := l;
	end;
	
File_Provider_Address := project(Provider_Address,tr_rollupXAddress(LEFT));	
File_Provider_Address_sort := sort(File_Provider_Address,FILETYP, ProviderID,AddressID, Address, Address2, City, State, County, ZIP,ExtZip,-ProcessDate, local);

prov_address_rec  rollupXform(prov_address_rec l, prov_address_rec r) := transform
        
self.Processdate    := if(l.Processdate > r.Processdate, l.Processdate, r.Processdate);
self.dt_Vendor_First_Reported := if(l.dt_Vendor_First_Reported > r.dt_Vendor_First_Reported, r.dt_Vendor_First_Reported, l.dt_Vendor_First_Reported);
self.dt_Vendor_Last_Reported  := if(l.dt_Vendor_Last_Reported  < r.dt_Vendor_Last_Reported,  r.dt_Vendor_Last_Reported, l.dt_Vendor_Last_Reported);
self := l;
end;

rollup_ProviderAddress := rollup(File_Provider_Address_sort,rollupXform(LEFT,RIGHT),FILETYP, ProviderID, AddressID, Address, Address2, City, State, County, ZIP,ExtZip, local);


Provider_Addtype_rec := record
	Ingenix_NatlProf.Layout_in_ProviderAddressType.raw_srctype;
	string8	dt_first_seen;
	string8	dt_last_seen;
	string8	dt_vendor_first_reported;
	string8	dt_vendor_last_reported;   
end;

Provider_Addtype_rec tr_rollupXAddresstype(Provider_AddressType L) := transform

   self.dt_first_seen              := '';
	self.dt_last_seen               := '';
	self.dt_vendor_first_reported   := L.processdate;
	self.dt_vendor_last_reported    := L.processdate;
	self := l;
	end;
	
File_Provider_Addresstype := project(Provider_AddressType,tr_rollupXAddresstype(LEFT));	

File_Provider_Addresstype_sort := sort(File_Provider_Addresstype,FILETYP, ProviderID, AddressID, ProviderAddressTypeCode,AddressTypeCompanyCount,AddressTypeTierTypeID,-ProcessDate, local);


Provider_Addtype_rec  rollupYform(Provider_Addtype_rec l, Provider_Addtype_rec r) := transform
        
self.Processdate    := if(l.Processdate > r.Processdate, l.Processdate, r.Processdate);
self.dt_Vendor_First_Reported := if(l.dt_Vendor_First_Reported > r.dt_Vendor_First_Reported, r.dt_Vendor_First_Reported, l.dt_Vendor_First_Reported);
self.dt_Vendor_Last_Reported  := if(l.dt_Vendor_Last_Reported  < r.dt_Vendor_Last_Reported,  r.dt_Vendor_Last_Reported, l.dt_Vendor_Last_Reported);
self := l;
end;

rollup_ProviderAddresstype := rollup(File_Provider_Addresstype_sort,rollupYform(LEFT,RIGHT),FILETYP, ProviderID, AddressID, ProviderAddressTypeCode,AddressTypeCompanyCount,AddressTypeTierTypeID, local);

new_rec := record
	Ingenix_Natlprof.Layout_in_ProviderAddress.raw_srctype;
	string	ProviderAddressTypeCode;
	string182 clean_address := '';
	string8	dt_first_seen;
	string8	dt_last_seen;
	string8	dt_vendor_first_reported;
	string8	dt_vendor_last_reported;    
end;

dist_rollup_ProviderAddress := distribute(rollup_ProviderAddress,HASH(FILETYP, AddressID));
dist_rollup_ProviderAddresstype := distribute(rollup_ProviderAddresstype,HASH(FILETYP, AddressID));


new_rec Join_AddressType(rollup_ProviderAddress l,rollup_ProviderAddresstype R) := Transform
	self.zip 												:= address_filter(L.zip);
	self.extzip 										:= address_filter(L.extzip);
	self.dt_first_seen              := '';
	self.dt_last_seen               := '';
	self.dt_vendor_first_reported   := L.processdate;
	self.dt_vendor_last_reported    := L.processdate;
	self 														:= L;
	self 														:= R;
end;

Joined_AddressType := join(	dist_rollup_ProviderAddress,
														dist_rollup_ProviderAddresstype,
														left.FILETYP = right.FILETYP and 
														left.AddressId = right.AddressId,
														Join_AddressType(left,right), 
														left outer,
														local
													);	

file_dist := distribute(Joined_AddressType, hash(FILETYP, ProviderID));
file_sort := sort(file_dist,FILETYP, ProviderID,AddressID, Address, Address2, City, State, County, ZIP,ExtZip,-ProcessDate, local);

new_rec  rollupZform(new_rec l, new_rec r) := transform
        
self.Processdate    := if(l.Processdate > r.Processdate, l.Processdate, r.Processdate);
self.dt_First_Seen := if(l.dt_First_Seen > r.dt_First_Seen, r.dt_First_Seen, l.dt_First_Seen);
self.Dt_Last_Seen  := if(l.Dt_Last_Seen  < r.dt_Last_Seen,  r.dt_Last_Seen,  l.dt_Last_Seen);
self.dt_Vendor_First_Reported := if(l.dt_Vendor_First_Reported > r.dt_Vendor_First_Reported, r.dt_Vendor_First_Reported, l.dt_Vendor_First_Reported);
self.dt_Vendor_Last_Reported  := if(l.dt_Vendor_Last_Reported  < r.dt_Vendor_Last_Reported,  r.dt_Vendor_Last_Reported, l.dt_Vendor_Last_Reported);
self := l;
end;

rollup_ProviderAddress_final := rollup(file_sort,rollupZform(LEFT,RIGHT),FILETYP, ProviderID, AddressID, Address, Address2, City, State, County, ZIP,ExtZip, local);


//clean address

new_rec tcleaning(new_rec L) := transform

string add1_input := L.address + ' ' + L.address2;
string add2_input := L.city + ' '+ L.state + ' ' + address_filter(L.zip) + address_filter(L.extzip);
self.clean_address := if(l.clean_address <> '', l.clean_address, if(trim(add1_input,all) <> '' or trim(add2_input,all)<>'', 
                      Address.CleanAddress182(add1_input,add2_input), '') );
self := L;
end;

clean_ProviderAddress := project(rollup_ProviderAddress_final, tcleaning(left));

// Need to add specific clean address fields to use for comparison to help eliminate duplicate
// records that wouldn't normally be recognized as such because of vendor data.
new_rec_plus_clean := RECORD
  new_rec;
	STRING10 prov_Clean_prim_range;
	STRING2  prov_Clean_predir;
	STRING28 prov_Clean_prim_name;
	STRING4  prov_Clean_addr_suffix;
	STRING2  prov_Clean_postdir;
	STRING10 prov_Clean_unit_desig;
	STRING8  prov_Clean_sec_range;
	STRING25 prov_Clean_p_city_name;
	STRING25 prov_Clean_v_city_name;
	STRING2  prov_Clean_st;
	STRING5  prov_Clean_zip;
	STRING4  prov_Clean_zip4;	
END;

new_rec_plus_clean add_clean_fields(new_rec L) := TRANSFORM
	SELF.prov_Clean_prim_range  := L.clean_address[1..10];
	SELF.prov_Clean_predir     	:= L.clean_address[11..12];
	SELF.prov_Clean_prim_name		:= L.clean_address[13..40];
	SELF.prov_Clean_addr_suffix	:= L.clean_address[41..44];
	SELF.prov_Clean_postdir			:= L.clean_address[45..46];
	SELF.prov_Clean_unit_desig	:= L.clean_address[47..56];
	SELF.prov_Clean_sec_range		:= L.clean_address[57..64];
	SELF.prov_Clean_p_city_name	:= L.clean_address[65..89];
	SELF.prov_Clean_v_city_name	:= L.clean_address[90..114];
	SELF.prov_Clean_st					:= L.clean_address[115..116];
	SELF.prov_Clean_zip					:= L.clean_address[117..121];
	SELF.prov_Clean_zip4				:= L.clean_address[122..125];
	
	SELF := L;
END;

clean_ProviderAddress_plus := PROJECT(clean_ProviderAddress, add_clean_fields(LEFT));

// ProviderAddressTierTypeID is used as a tie-breaker and the IF portion is so that an id of 0 is
// pushed to the bottom of the sort pile.  Current IDs it could be are 0, 1, 2, 3, and 99.
clean_address_sort := SORT(clean_ProviderAddress_plus,
                           FILETYP, ProviderID, prov_Clean_prim_range, prov_Clean_predir, prov_Clean_prim_name,
													    prov_Clean_addr_suffix, prov_Clean_postdir, prov_Clean_unit_desig,
															prov_Clean_sec_range, prov_Clean_p_city_name, prov_Clean_v_city_name,
															prov_Clean_st, prov_Clean_zip, prov_Clean_zip4, -ProcessDate,
															ProviderAddressTypeCode, -ProviderAddressCompanyCount,
															IF(ProviderAddressTierTypeID = '0', 1, 0), ProviderAddressTierTypeID,
													 LOCAL);

// We're doing this to keep the earliest and latest date associated with the provider and their type,
// instead of just doing a DEDUP, which could give a misleading date... one that's associated with
// a specific address at one point in time vs. how long the specific address has been in the system.
// Since date first and last seen aren't used, not going to bother coding them in this transform.
new_rec_plus_clean rollup_dates(new_rec_plus_clean L, new_rec_plus_clean R) := TRANSFORM
  SELF.dt_Vendor_First_Reported := IF(L.dt_Vendor_First_Reported > R.dt_Vendor_First_Reported, R.dt_Vendor_First_Reported, L.dt_Vendor_First_Reported);
  SELF.dt_Vendor_Last_Reported := IF(L.dt_Vendor_Last_Reported < R.dt_Vendor_Last_Reported, R.dt_Vendor_Last_Reported, L.dt_Vendor_Last_Reported);

  SELF := L;
END;

export update_provideraddress :=
  ROLLUP(clean_address_sort,
         rollup_dates(LEFT, RIGHT),
				 FILETYP, ProviderID, prov_Clean_prim_range, prov_Clean_predir, prov_Clean_prim_name,
				    prov_Clean_addr_suffix, prov_Clean_postdir, prov_Clean_unit_desig, prov_Clean_sec_range,
						prov_Clean_p_city_name, prov_Clean_v_city_name, prov_Clean_st, prov_Clean_zip,
						prov_Clean_zip4,
				 LOCAL);