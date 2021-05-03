import ut, std, nid, doxie, prte2_vehicle, BIPv2, AutoStandardI, mdr;

EXPORT Keys := module

slim_party := table(files.Party_Clean_Sequence(append_did <> 0), {append_did, vehicle_key, iteration_key, sequence_key, orig_dob});
party_dedup := dedup(project(slim_party, transform(layouts.did_rec, 
																										age := ut.Age((UNSIGNED) left.orig_dob);
																										self.is_minor := if(age=0 or age>=18,FALSE,TRUE);
																										self := left)), 
																										all);

export did := index(party_dedup, {append_DID, is_minor}, {Vehicle_Key,Iteration_Key,Sequence_Key}, Constants.key_prefix + doxie.Version_SuperKey + '::did');


//BDID Key
slim_party_bdid := dedup(table(files.Party_Clean_Sequence(append_bdid <> 0), {append_bdid, vehicle_key, iteration_key, sequence_key}), all);
export bdid := index(slim_party_bdid, {Append_BDID}, {Vehicle_Key,Iteration_Key,Sequence_Key}, Constants.key_prefix + doxie.Version_SuperKey + '::bdid');


//Key DL Number
layouts.dl_rec dl_normalize(files.Party_Clean_Sequence L, integer cnt) := transform
self.DL_number := choose(cnt, L.orig_DL_number, L.Append_DL_number);

age := ut.Age((UNSIGNED) l.orig_dob);
self.is_minor := if(age=0 or age>=18,FALSE,TRUE);
self := L;
end;

party_norm  := normalize(files.Party_Clean_Sequence(Append_DL_number != '' or Orig_DL_number != ''), 2, dl_normalize(left, counter));
export dl_number := index(dedup(party_norm(dl_number <> ''), all), {DL_number, state_origin,is_minor}, {Vehicle_Key,Iteration_Key,Sequence_Key}, Constants.key_prefix + doxie.Version_SuperKey + '::dl_number');

// Lic Plate Key
dsLicPlate := dedup(project(files.party_dedup(license_plate <> ''), {Layouts.lic_plate_slim}- reverse_license_plate), record);
export Lic_plate := index(dsLicPlate, {license_plate, state_origin,dph_lname,pfname,is_minor}, {dsLicPlate},	
																				Constants.key_prefix + doxie.Version_SuperKey + '::lic_plate');
																	

//Reverse Lic
dsReverseLicPlate := dedup(project(files.party_dedup(reverse_license_plate <> ''), {Layouts.lic_plate_slim}- [license_plate, state_type]), record);
export reverse_Lic_plate := index(dsReverseLicPlate, {reverse_license_plate, state_origin,dph_lname,pfname,is_minor}, {dsReverseLicPlate},
																					Constants.key_prefix + doxie.Version_SuperKey + '::reverse_lic_plate');

//Main Key
export main := index(files.main_slim, {Vehicle_Key, iteration_key}, {files.main_slim}, Constants.key_prefix + doxie.Version_SuperKey + '::main_key');


//Vin Key
layouts.vin_rec tnormalize_vin(files.main_slim L, integer cnt) := transform
self.VIN := choose(cnt, L.orig_vin, L.vina_vin);
self := L;
end;

vin_norm  := normalize(files.main_slim(orig_vin != '' or vina_vin != ''), 2, tnormalize_vin(left, counter));
vin_dedup := dedup(vin_norm(vin <> ''), all);

export vin := index(vin_dedup, {VIN, state_origin}, {vin_dedup}, Constants.key_prefix + doxie.Version_SuperKey + '::vin');


//Party Key
party_prj := project(files.Party_Clean_Sequence, transform(Layouts.Key_Vehicle_Party, 
																													 self.std_lienholder_name := if(left.Orig_Name_Type = '7',left.Append_Clean_CName,'');
																													 self := left));
																													 
export	Party	:=	index(party_prj, {Vehicle_Key, iteration_key, sequence_key}, {party_prj}, Constants.key_prefix + doxie.Version_SuperKey + '::party_key');



//Title Number Key
Layouts.Title_Record 	ttl_normalize(files.Party_Clean_Sequence L, integer cnt) := transform
self.state_origin := choose(cnt, L.state_origin, L.append_clean_address.st);
self := L;
end;

ttl_norm 	:= normalize(files.Party_Clean_Sequence, 2, ttl_normalize(left, counter));
ttl_dedup := dedup(ttl_norm((ttl_number <> '' and ttl_number not in ['0','00000000']) and state_origin <> ''), all);

export title_number := index(ttl_dedup, {ttl_number, state_origin}, {Vehicle_Key,Iteration_Key,Sequence_Key}, Constants.key_prefix + doxie.Version_SuperKey + '::title_number');


//License Blur Key
ds_blur := project(Files.party_bip, transform(layouts.l_blur, self := left, self := []));
export lic_plate_blur := index(ds_blur(license_plate_blur <> ''), {license_plate_blur}, {ds_blur}, Constants.key_prefix + doxie.Version_SuperKey + '::lic_plate_blur');

export bocashell_vehicles := index(dedup(file_bocashell_vehicles,all), {did}, {file_bocashell_vehicles}, Constants.key_prefix + doxie.Version_SuperKey + '::bocashell_did');

//Source Rec Id
dsPartySeq := project(files.Party_Building, layouts.source_rec);
export Source_Rec_ID := index(dsPartySeq(source_rec_id <>0 ), {source_rec_id}, {dsPartySeq}, Constants.key_prefix + doxie.Version_SuperKey + '::source_rec_id');

																					
//Linkids 
export linkids := module
 BipParty := project(files.party_building, transform({recordof(Files.party_building)} -[SRC_FIRST_DATE, SRC_LAST_DATE], self := left));

  // DEFINE THE INDEX
	BIPV2.IDmacros.mac_IndexWithXLinkIDs(BipParty, k, Constants.key_prefix + doxie.Version_SuperKey+ '::linkids');
	export Key := k;

	//DEFINE THE INDEX ACCESS
	export kFetch(
		dataset(BIPV2.IDlayouts.l_xlink_ids) inputs, 
		string1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	//The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
																								//Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
																								//Should be enumerated or something?  at least need constants defined somewhere if you keep string1
		unsigned2 ScoreThreshold = 0								//Applied at lowest leve of ID
		,BIPV2.mod_sources.iParams in_mod=PROJECT(AutoStandardI.GlobalModule(),BIPV2.mod_sources.iParams,opt)
		) :=
	FUNCTION

		BIPV2.IDmacros.mac_IndexFetch(inputs, Key, out, Level)
		//the vl_id parameter is not applicable to DPPA sources
		ds_restricted := out(BIPV2.mod_sources.isPermitted(in_mod).bySource(MDR.sourceTools.fVehicles(state_origin,source_code),''));
		return ds_restricted;																					
		
	END;

END;


//Key MRD_Srch
layouts.mfd_rec tx(files.Party_Clean_Sequence L) := TRANSFORM
		SELF.zip5							:= L.Append_Clean_Address.zip5;
		SELF.prim_range				:= L.Append_Clean_Address.prim_range;
		SELF.prim_name				:= L.Append_Clean_Address.prim_name;
		SELF.predir						:= L.Append_Clean_Address.predir;
		SELF.postdir					:= L.Append_Clean_Address.postdir;
		SELF.suffix						:= L.Append_Clean_Address.addr_suffix;
		SELF.unit_desig				:= L.Append_Clean_Address.unit_desig;
		SELF.sec_range				:= L.Append_Clean_Address.sec_range;
		SELF.v_city_name			:= L.Append_Clean_Address.v_city_name;
		SELF.st								:= L.Append_Clean_Address.st;
		SELF.zip4							:= L.Append_Clean_Address.zip4;
		SELF.reg_expire_date 	:= (UNSIGNED6) L.reg_latest_expiration_date;
		age 									:= ut.Age((UNSIGNED) l.orig_dob);
		SELF.is_minor 				:= if(age=0 or age>=18,FALSE,TRUE);
		SELF 									:= l;
	END;	 
	
//Exclude party records marked as historical
	rec_slim 				:=  dedup(project(files.Party_Clean_Sequence(history<>'H' AND Append_Clean_Address.zip5 + Append_Clean_Address.prim_name<>''), tx(LEFT)), record);

// Excluded Advo join since the addresses are fake and not likely in the advo file. 
// The purpose of the join was to determine if the address is MFD or not in the DISTRIX environment
export MFD_Srch := INDEX(rec_slim, {zip5, prim_range,prim_name,suffix,predir,postdir}, {rec_slim}, Constants.KEY_PREFIX + doxie.Version_SuperKey + '::mfd_srch');

// Addr Key
//join main to addr
vehicle_addr 	:=  project(files.party_dedup, {files.party_dedup}- reverse_license_plate);

layouts.Address_Attributes_Vehicle	get_vehicles(vehicle_addr l, files.main_base r)	:=
transform
	//build geolink for neighborhood aggregation
	self.geolink			:=	l.state_origin	+	l.fips_county	+	l. geo_blk;
	self.suffix				:=	l.addr_suffix;
	self.p_city_name	:=	l.v_city_name;
	self.county				:=	l.fips_county;
	self.st						:=	l.state_origin;
	self							:=	l;
	self							:=	r;
	self							:=	[];
end;

vehicle_slim	:=	join(dedup(sort(vehicle_addr(is_current=true),vehicle_key,license_plate),vehicle_key,license_plate),
															sort(files.main_base,vehicle_key), 
												left.vehicle_key	=	right.vehicle_key,
												get_vehicles(left,right),
												left outer,
												local
											);

cleaned	:=	dedup(vehicle_slim(zip5 !=	'', prim_range	!=	'',	prim_name 	!=''), all);
export addr := index(cleaned,	{zip5,prim_range,prim_name,suffix,predir}, {cleaned},  Constants.KEY_PREFIX + doxie.Version_SuperKey + '::vehicles_address');

export modelindex_public			:=	index(files.keymodelindex_public,{str},{files.keymodelindex_public}, Constants.key_prefix_wc + doxie.Version_SuperKey + '::keymodelindex_public');
export nameindex_public				:=	index(files.keynameindex_public,{str},{files.keynameindex_public}, Constants.key_prefix_wc + doxie.Version_SuperKey + '::keynameindex_public');
export wc_vehicle_bodystyle		:=	index(files.ws_bodystyle,{body_style,i},{files.ws_bodystyle}, Constants.key_prefix_wc + doxie.Version_SuperKey + '::bodystyle');
export wc_vehicle_make				:=	index(files.wc_vehicle_make,{makecode},{files.wc_vehicle_make}, Constants.key_prefix_wc + doxie.Version_SuperKey + '::make');

end;
