import PromoteSupers, prte2, BIPV2,prte_bip,std,ut, AID, Address, AID_Support;
// #constant(AID_Support.Constants.StoredWhichAIDCache, AID_Support.Constants.eCache.ForNonHeader);
 
prte2.CleanFields(Files.in_main,Vehicle_Main_Clean);
prte2.CleanFields(Files.in_party,Vehicle_Party_Clean);

dsMainFile := project(Vehicle_Main_Clean, transform(Layouts.Base_Main, self := left;	self := []));

//Populated Vina Fields
MainVinaPopulate := fn_PopulateVinaInfo(dsMainFile);
																			
//Splitting New & Exisitng Records
dExistingRecords := project(Vehicle_Party_Clean(cust_name = ''), transform(Layouts.Base_Party_BIP, self := left, self := []));
dNewRecords			 := Vehicle_Party_Clean(cust_name <> '');


//Prepping Raw Addresses for New Records
PrepAddrLayout := record
layouts.in_party;
string150	Append_Ace1_PrepAddr1;
string100	Append_Ace1_PrepAddr2;
AID.Common.xAID	Append_Ace1_RawAID	:=	0;
end;


PrepAddrLayout		tAppendPrepAddr(dNewRecords l) := transform
self.Append_Ace1_PrepAddr1	:= std.str.cleanspaces(STD.Str.ToUpperCase(L.Orig_Address));        
self.Append_Ace1_PrepAddr2	:= Address.Addr2FromComponents(L.Orig_City, L.Orig_State, L.Orig_Zip);
self := L;
self := [];
end;
dAddressPrep	:= PROJECT(dNewRecords, tAppendPrepAddr(LEFT)); 

//New Records- Aderess Cleaning
unsigned4 lAIDAppendFlags := AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords|AID.Common.eReturnValues.NoNewCacheFiles;

AID.MacAppendFromRaw_2Line(dAddressPrep, Append_Ace1_PrepAddr1, Append_Ace1_PrepAddr2, Append_Ace1_RawAID, dAddressCleaned, lAIDAppendFlags);																			

//Transforming Name & Address 																			
Layouts.Base_Party_BIP	tPartyCleanFields(dAddressCleaned	l) := transform																	

//Name Cleaning
v_clean_name		:= if(L.Orig_Party_Type = 'I',Address.CleanPersonFML73(STD.Str.CleanSpaces(trim(L.Orig_Name))),''); 
self.fname							:= v_clean_name[6..25];
self.mname							:= v_clean_name[26..45];	
self.lname							:= v_clean_name[46..65];
self.name_suffix				:= v_clean_name[66..70];
self.name_score					:= v_clean_name[71..73];
self.Orig_Name					:= STD.Str.CleanSpaces(trim(L.orig_name));
self.Append_Clean_CName := if(L.Orig_Party_Type = 'B', STD.Str.CleanSpaces(trim(L.Orig_Name)),STD.Str.CleanSpaces(trim(L.append_clean_cname)));

self.Append_Ace1_RawAID	:= l.AIDWork_RawAID;
self.prim_range     		:= l.AIDWork_ACECache.prim_range;
self.predir         		:= l.AIDWork_ACECache.predir;
self.prim_name      		:= l.aidwork_acecache.prim_name;;
self.addr_suffix    		:= l.AIDWork_ACECache.addr_suffix;
self.postdir        		:= l.AIDWork_ACECache.postdir;
self.unit_desig	   			:= l.AIDWork_AceCache.unit_desig;
self.sec_range      		:= l.AIDWork_ACECache.sec_range;
self.v_city_name    		:= l.AIDWork_ACECache.v_city_name;
self.st             		:= l.AIDWork_ACECache.st;
self.zip5           		:= l.aidwork_acecache.zip5;
self.zip4          			:= l.aidwork_acecache.zip4;
self.fips_state					:= l.AIDWork_AceCache.county[1..2];
self.fips_county				:= l.AIDWork_AceCache.county[3..5];
self.geo_lat		   			:= l.AIDWork_AceCache.geo_lat;
self.geo_long		   			:= l.AIDWork_AceCache.geo_long;
self.geo_blk		   			:= l.AIDWork_AceCache.geo_blk;
self.geo_match		  		:= l.AIDWork_AceCache.geo_match;
self.err_stat		   			:= l.AIDWork_AceCache.err_stat;
self.orig_ssn						:= l.orig_ssn;
self.orig_dob						:= l.orig_dob;
self.orig_fein					:= l.orig_fein;
self.Append_DL_Number		:= if(L.Append_DL_Number <> '', L.append_dl_number, L.orig_dl_number);
self.Append_SSN					:= if(L.Append_SSN <> '', L.append_ssn, self.orig_ssn);
self.Append_FEIN				:= if(L.Append_FEIN <> '', L.append_fein, self.orig_fein);
self.Append_DOB					:= if(L.Append_DOB <> '', L.append_dob, self.orig_dob);
self := l;
self := [];
end;

ClnPartyFile := project(dAddressCleaned, tPartyCleanFields(left));

//Append ID(s)
Layouts.Base_Party_BIP	xformPartyID(ClnPartyFile	l) := transform	
self.Append_bdid 				:= prte2.fn_AppendFakeID.bdid(l.Append_Clean_CName, l.prim_range, l.prim_name, l.v_city_name, l.st, l.zip5, L.cust_name);
self.Append_did	 				:= prte2.fn_AppendFakeID.did(l.fname, l.lname, l.link_ssn, l.link_dob, L.cust_name);

vLinkingIds := prte2.fn_AppendFakeID.LinkIds(l.Append_Clean_CName, l.link_fein, L.link_incorp_date, l.prim_range, l.prim_name, l.sec_range, l.v_city_name, l.st, l.zip5, L.cust_name);
self.powid	:= vLinkingIds.powid;
self.proxid	:= vLinkingIds.proxid;
self.seleid	:= vLinkingIds.seleid;
self.orgid	:= vLinkingIds.orgid;
self.ultid	:= vLinkingIds.ultid;
self := L;
self := [];
end;

dPartyFileFinal:= project(ClnPartyFile, xformPartyID(left));
														

//Append Source Record Id
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
