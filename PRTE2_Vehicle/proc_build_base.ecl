import PromoteSupers, prte2, BIPV2,prte_bip,std,ut, AID, Address, AID_Support;
 
prte2.CleanFields(Files.in_main,Vehicle_Main_Clean);
prte2.CleanFields(Files.in_party,Vehicle_Party_Clean);

dsMainFile := project(Vehicle_Main_Clean, transform(Layouts.Base_Main, self := left;	self := []));

//Populated Vina Fields
MainVinaPopulate := fn_PopulateVinaInfo(dsMainFile);
																			
//Splitting New & Exisitng Records
dExistingRecords := project(Vehicle_Party_Clean(cust_name = ''), transform(Layouts.Base_Party_BIP, self := left, self := []));
dNewRecords			 := Vehicle_Party_Clean(cust_name <> '');
												
AddressDataSet := PRTE2.AddressCleaner(dNewRecords,
	 ['orig_address'],
   ['orig_address2'],
   ['orig_city'],
   ['orig_state'],
   ['orig_zip'],
   ['address_1'],
   ['rawaid_1']) ;
	 
dPartyFileFinal:=project(AddressDataSet,	
Transform(Layouts.Base_Party_BIP,

  CleanName:= Address.CleanPersonFML73_fields(STD.Str.CleanSpaces(trim(Left.Orig_Name)));
	self.fname:=if(left.orig_party_type = 'I', CleanName.fname,'');
	self.mname:=if(left.orig_party_type = 'I', CleanName.mname,'');
	self.lname:=if(left.orig_party_type = 'I', CleanName.lname,'');
	self.name_suffix:=if(left.orig_party_type = 'I', CleanName.name_suffix,'');
	self.name_score:=if(left.orig_party_type = 'I', CleanName.name_score,'');
  self.Orig_Name		:= STD.Str.CleanSpaces(trim(Left.orig_name));        
	self.Append_Clean_CName := if(Left.Orig_Party_Type = 'B', STD.Str.CleanSpaces(trim(Left.Orig_Name)),STD.Str.CleanSpaces(trim(Left.append_clean_cname)));
	
  self.Append_Ace1_RawAID	:= left.rawaid_1;	
	self.prim_range     		:= left.address_1.prim_range;
  self.predir         		:= left.address_1.predir;
  self.prim_name      		:= left.address_1.prim_name;
  self.addr_suffix    		:= left.address_1.addr_suffix;
  self.postdir        		:= left.address_1.postdir;
  self.unit_desig	   			:= left.address_1.unit_desig;
  self.sec_range      		:= left.address_1.sec_range;
  self.v_city_name    		:= left.address_1.v_city_name;
  self.st             		:= left.address_1.st;
  self.zip5           		:= left.address_1.zip;
  self.zip4          			:= left.address_1.zip4;
  self.fips_state					:= left.address_1.fips_state;
  self.fips_county				:= left.address_1.fips_county;
  self.geo_lat		   			:= left.address_1.geo_lat;
  self.geo_long		   			:= left.address_1.geo_long;
  self.geo_blk		   			:= left.address_1.geo_blk;
  self.geo_match		  		:= left.address_1.geo_match;
  self.err_stat		   			:= left.address_1.err_stat;
  self.orig_ssn						:= left.orig_ssn;
  self.orig_dob						:= left.orig_dob;
  self.orig_fein					:= left.orig_fein;
  self.Append_DL_Number		:= if(Left.Append_DL_Number <> '', Left.append_dl_number, Left.orig_dl_number);
  self.Append_SSN					:= if(Left.Append_SSN <> '', Left.append_ssn, self.orig_ssn);
  self.Append_FEIN				:= if(Left.Append_FEIN <> '', Left.append_fein, self.orig_fein);
  self.Append_DOB					:= if(Left.Append_DOB <> '', Left.append_dob, self.orig_dob);

  self.Append_bdid 				:= prte2.fn_AppendFakeID.bdid(self.Append_Clean_CName, self.prim_range, self.prim_name, self.v_city_name, self.st, self.zip5, Left.cust_name);

  self.Append_did	 				:= prte2.fn_AppendFakeID.did(self.fname, self.lname, left.link_ssn, left.link_dob, Left.cust_name);

vLinkingIds := prte2.fn_AppendFakeID.LinkIds(self.Append_Clean_CName, left.link_fein, Left.link_incorp_date, self.prim_range, self.prim_name, self.sec_range, self.v_city_name, self.st, self.zip5, Left.cust_name);

self.powid	:= vLinkingIds.powid;
self.proxid	:= vLinkingIds.proxid;
self.seleid	:= vLinkingIds.seleid;
self.orgid	:= vLinkingIds.orgid;
self.ultid	:= vLinkingIds.ultid;
	
self := Left;
self := [];
 ));
  
 dsPartyFile := project(dPartyFileFinal + dExistingRecords, transform(Layouts.Base_Party_BIP,
																																		//Existing records populate either/or not both
																																		vfein := if(left.orig_fein <> '', left.orig_fein, left.append_fein);
																																		vssn 	:= if(left.orig_ssn <> '', left.orig_ssn, left.append_ssn);
																																		vdob  := if(left.orig_dob <> '', left.orig_dob, left.append_dob);
																																		self.source_rec_id  := hash64(left.vehicle_key + ',' +
																																																	left.iteration_key + ',' +
																																																	left.sequence_key + ',' +
																																																	left.state_origin + ','+
																																																	left.reg_license_plate + ','+
																																																	left.reg_true_license_plate + ','+
																																																	left.reg_license_state + ','+
																																																	left.registration_expiration_date + ','+
																																																	left.reg_previous_license_state + ','+
																																																	left.reg_previous_license_plate + ','+
																																																	left.reg_license_plate_type_code + ','+
																																																	left.reg_decal_number + ','+
																																																	left.reg_first_date + ','+
																																																	left.registration_effective_date + ','+
																																																	left.reg_status_code + ','+
																																																	left.ttl_number + ','+
																																																	left.title_issue_date + ','+
																																																	left.ttl_previous_issue_date + ','+
																																																	left.orig_name_type + ','+
																																																	left.orig_party_type + ','+
																																																	left.prim_range + ','+
																																																	left.predir + ','+
																																																	left.prim_name + ','+
																																																	left.addr_suffix + ','+
																																																	left.postdir + ','+
																																																	left.unit_desig + ','+
																																																	left.sec_range + ','+
																																																	left.v_city_name + ','+
																																																	left.st + ','+
																																																	left.zip5 + ','+
																																																	vssn + ','+
																																																	vfein + ','+
																																																	vdob + ','+
																																																	left.fname + ','+
																																																	left.mname + ','+
																																																	left.lname + ','+
																																																	left.name_suffix + ','+
																																																	left.append_clean_cname
																																																	);
																																			self := left;
																																			self := []));


PromoteSupers.MAC_SF_BuildProcess(MainVinaPopulate,	Constants.base_prefix_name + 'main', bld_main,,,true);
PromoteSupers.MAC_SF_BuildProcess(dsPartyFile, Constants.base_prefix_name + 'party', bld_party,,,true);


EXPORT proc_build_base := sequential(bld_main,bld_party);

