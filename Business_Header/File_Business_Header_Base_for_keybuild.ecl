import ut, lib_fileservices, header_services,mdr;

//CNG W20070822-183241 dat//////////////////////////////////


Drop_Header_Layout := //REMOVE WHEN WE START TO RECEIVE FILES IN THE CORRECT LAYOUT
Record
 string15 rcid;
 string15 bdid; 
 string2 source; 
 string34 source_group; 
 string3 pflag; 
 string15 group1_id; 
 string34 vendor_id; 
 string10 dt_first_seen; 
 string10 dt_last_seen; 
 string10 dt_vendor_first_reported;
 string10 dt_vendor_last_reported;
 string120 company_name;
 string10 prim_range;
 string2 predir;
 string28 prim_name;
 string4 addr_suffix;
 string2 postdir;
 string5 unit_desig;
 string8 sec_range;
 string25 city;
 string2 state;
 string8 zip;
 string5 zip4;
 string3 county;
 string4 msa;
 string10 geo_lat;
 string11 geo_long;
 string15 phone;
 string5 phone_score; 
 string10 fein; 
 string1 current; 
 string1 dppa; 
 string81 match_company_name;
 string20 match_branch_unit;
 string25 match_geo_city := '';
 string2 eor := '';
end;

header_services.Supplemental_Data.mac_verify('file_business_header_inj.txt', Drop_Header_Layout, attr);

Base_File_Append_In := attr();

max_file_pos := max(Business_Header.files(,_Dataset().IsDataland).base.business_headers.keybuild,__filepos) : global;

Business_Header.Layout_Business_Header_Base_Plus_Orig reformat_header(Base_File_Append_In L, integer c) := //REMOVE WHEN WE START TO RECEIVE FILES IN THE CORRECT LAYOUT
 transform
	self.rcid := (unsigned6) L.rcid;
	self.bdid := (unsigned6) L.bdid;
	self.group1_id := (unsigned6) L.group1_id;
	self.dt_first_seen := (unsigned4) L.dt_first_seen;
	self.dt_last_seen := (unsigned4) L.dt_last_seen;
	self.dt_vendor_first_reported := (unsigned4) L.dt_vendor_first_reported;
	self.dt_vendor_last_reported := (unsigned4) L.dt_vendor_last_reported;	
	self.zip := (unsigned3) L.zip;
	self.zip4 := (unsigned2) L.zip4;
	self.phone := (unsigned6) L.phone;
	self.phone_score := (unsigned2) L.phone_score;
	self.fein := (unsigned4) L.fein;
	self.current := (boolean) L.current;
   	self.dppa := (boolean) L.dppa;
	self.__filepos := max_file_pos + c;
	self := L;
 end;
 
 
Base_File_Append := project(Base_File_Append_In, reformat_header(left,counter)); //REMOVE WHEN WE START TO RECEIVE FILES IN THE CORRECT LAYOUT

/////////////////////////////////////////////////////////////////////

export File_Business_Header_Base_for_keybuild :=
function

in_hdr := business_header.filters.keys.business_headers_keybuild(files(,_Dataset().IsDataland).base.business_headers.keybuild);// + header.transunion_did;
in_hdr_layout := recordof(in_hdr);

////////////////////////////////////////////////////////////////////////
// Get best address from the BH_Basic_match_clean for keys
////////////////////////////////////////////////////////////////////////
in_hdr_dist 		    := distribute(in_hdr, rcid);
	
bh_basic_matchClean := distribute(persists().BHBasicMatchClean, rcid);

//*** Getting the best addresses that got from the AID process and replacing the Orig addresses
//*** for key build.
in_hdr_layout getBestAddr(in_hdr_dist l, bh_basic_matchClean r) :=  transform
		self.prim_range		:=  r.prim_range;
		self.predir				:= 	r.predir;
		self.prim_name		:=	r.prim_name;
		self.addr_suffix	:=	r.addr_suffix;
		self.postdir			:=	r.postdir;
		self.unit_desig		:=	r.unit_desig;
		self.sec_range		:=	r.sec_range;
		self.city					:=	r.city;
		self.state				:=	r.state;
		self.zip					:=	r.zip;
		self.zip4					:=	r.zip4;		
	 self := l;
end;
	
in_hdr_with_bestAddr := join(in_hdr_dist, bh_basic_matchClean,
														 left.rcid = right.rcid,
														 getBestAddr(left,right), left outer, local
														);

// Start of code to suppress data based on an MD5 Hash of DID+Address
Suppression_Layout := header_services.Supplemental_Data.layout_in;

header_services.Supplemental_Data.mac_verify('didaddressbusiness_sup.txt',Suppression_Layout,supp_ds_func);
 
Suppression_In := supp_ds_func();

dSuppressedIn := project(Suppression_In, header_services.Supplemental_Data.in_to_out(left));

rHashDIDAddress := header_services.Supplemental_Data.layout_out;

rFullOut_HashDIDAddress := record
 Business_Header.Layout_Business_Header_Base_Plus;
 rHashDIDAddress;
end;

rFullOut_HashDIDAddress tHashDIDAddress(in_hdr_layout l) := transform                            
 self.hval := hashmd5(intformat((unsigned6)l.bdid,12,1),(string)l.state,(string)l.zip,(string)l.city,
									(string)l.prim_name,(string)l.prim_range,(string)l.predir,(string)l.addr_suffix,(string)l.postdir,(string)l.sec_range);
 self := l;
end;

dHeader_withMD5 := project(in_hdr_with_bestAddr, tHashDIDAddress(left));

Business_Header.Layout_Business_Header_Base_Plus_Orig tSuppress(dHeader_withMD5 l) := transform
 self := l;
end;

full_out_suppress := join(dHeader_withMD5,dSuppressedIn,
                          left.hval = right.hval,
						  tSuppress(left),
						  left only,lookup);


/////////////////////////////////////////////////////////////////////////


	dall := full_out_suppress + Base_File_Append;

	dreturndataset := dall;

	return dreturndataset;

end;