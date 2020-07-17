import vehicleV2, did_add, business_header, business_header_ss;

party_in := VehicleV2.Mapping_Experian_Updating_Party + VehicleV2.mapping_NC_party;

//append DID

preDID		:=	party_in(append_clean_cname =  '');
preBDID  	:=	party_in(append_clean_cname <> '');

matchset := ['A','D'];

did_Add.MAC_Match_Flex(preDID, matchset,
	 Orig_SSN, orig_dob, fname,mname, lname, name_suffix,
	 prim_range, prim_name, sec_range, zip5, st,foo,
	 append_DID,
	 recordof(preDID),
	 false, DID_Score_field,	//these should default to zero in definition
	 75,
	 postDID)		//try the dedup DIDing

postdid_dist := distribute(postDID, random()) : persist('~thor_data400::persist::vehreg_postdid');

business_header.MAC_Source_Match(preBDID,postsourcematch,
							false,append_bdid,
							false,'MV',//motor vehicles is 'MV' everywhere else
							false,foo,
							append_clean_cname,
							prim_range,prim_name,sec_range,zip5,
							false,foo,
							true, orig_fein);

dwithBDID := postsourcematch(append_bdid != 0);
dwithnoBDID := postsourcematch(append_bdid = 0);

bmatch := ['A'];

business_header_ss.MAC_Match_Flex(dwithnoBDID,bmatch,
						append_clean_cname,
						prim_range, prim_name, zip5,
						sec_range, st,
						foo,orig_fein,
						append_bdid,
						recordof(dwithnoBDID),
						false,foo,
						postBDID);

postbdid_dist := distribute(postBDID, random()) : persist('~thor_data400::persist::vehreg_postbdid', '400way');
post_DID_BDID := postdid_dist +  dwithBDID + postbdid_dist;

//****** Get SSN and FEIN from headers where we don't have it
//append SSN by DID

did_add.MAC_Add_SSN_By_DID(post_DID_BDID, append_did, append_ssn, postSSN)

//append FEIN by bdid
Business_Header_SS.MAC_Add_FEIN_By_BDID(postSSN, append_bdid, append_fein, vehicle_party_out)

//append DL by DID

VehicleV2.Mac_Add_DL_By_DID(postSSN, append_DID, append_DL_number,postDLnumber)

//append DOB

VehicleV2.Mac_Add_DOB_By_DID(postDLnumber, append_DOB, postDOB)


VehicleV2.Layout_Base_Party tSetupMatrixSearchFields(VehicleV2.Layout_Experian_Updating_temp_module.layout_temp_party L)
 :=
  transform
	self.append_clean_name.title 		 :=      L.title;
    self.append_clean_name.fname 		 :=      L.fname;
    self.append_clean_name.mname 		 :=      L.mname;
    self.append_clean_name.lname 		 :=      L.lname;
    self.append_clean_name.name_suffix   :=      L.name_suffix;
    self.append_clean_name.name_score	 :=      L.name_score;
    self.append_clean_address.prim_range :=      L.prim_range;
    self.append_clean_address.predir	 :=      L.predir;
    self.append_clean_address.prim_name	 :=      L.prim_name;
    self.append_clean_address.addr_suffix:=      L.addr_suffix;
    self.append_clean_address.postdir	 :=      L.postdir;
    self.append_clean_address.unit_desig :=      L.unit_desig;
    self.append_clean_address.sec_range	 :=      L.sec_range;
    self.append_clean_address.v_city_name :=	 L.v_city_name;
    self.append_clean_address.st		  :=	 L.st;
    self.append_clean_address.zip5		 :=	     L.zip5;
    self.append_clean_address.zip4		 :=	     L.zip4;
    self.append_clean_address.fips_state  :=	 L.fips_state;
    self.append_clean_address.fips_county :=	 L.fips_county;
    self.append_clean_address.geo_lat	 :=	     L.geo_lat;
    self.append_clean_address.geo_long	 :=	     L.geo_long;
    self.append_clean_address.cbsa		 :=	     L.cbsa;
    self.append_clean_address.geo_blk	 :=	     L.geo_blk;
    self.append_clean_address.geo_match	 :=	     L.geo_match;
    self.append_clean_address.err_stat	 :=	     L.err_stat;
	self := L;
  end
 ;

lMatrixSearchPatched := project(vehicle_party_out,tSetupMatrixSearchFields(left));

export experian_updating_did := lMatrixSearchPatched;
