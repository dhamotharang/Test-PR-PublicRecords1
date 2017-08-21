import doxie,Data_Services,BIPV2,AutoKeyB2;
EXPORT Keys := module;

//Foreclosure Keys
export key_fi_geo11 := index(files.FI_TABLE(geo11<>''),{geo11},{geo11, geo11_index, geo11_prop_count, geo11_fc_count},Data_Services.Data_location.prefix('foreclosure') + Constants.key_foreclosure_prefix + doxie.Version_SuperKey +'::index_geo11');
export key_fi_geo12	:= index(files.FI_TABLE(geo12<>''),{geo12},{geo12, geo12_index, geo12_prop_count, geo12_fc_count},Data_Services.Data_location.prefix('foreclosure') + Constants.key_foreclosure_prefix + doxie.Version_SuperKey +'::index_geo12'); 
export key_fi_fips	:= index(files.FI_TABLE(fips<>''),{fips},{fips, fips_index, fips_prop_count, fips_fc_count},Data_Services.Data_location.prefix('foreclosure') + Constants.key_foreclosure_prefix + doxie.Version_SuperKey +'::index_fips'); 

shared file_foreclosure_building_bdid 	:= dedup(sort(project(files.BASE, transform(layouts.fares_foreclosure, self := left)), foreclosure_id,local),record,all);
export key_foreclosures_fid 	:= index(file_foreclosure_building_bdid(trim(deed_category)='U'), {string70 fid := foreclosure_id}, {file_foreclosure_building_bdid}, Data_Services.Data_location.prefix('foreclosure') + Constants.key_foreclosure_prefix +doxie.Version_SuperKey+'::fid');

shared file_foreclosure_did :=  dedup(sort(project(files.foreclosure_autokey(did <> 0), {files.foreclosure_autokey.did, files.foreclosure_autokey.foreclosure_id}), record), record);
export key_foreclosures_did		:= index(file_foreclosure_did, {did},{string70 fid := foreclosure_id},Data_Services.Data_location.prefix('foreclosure') + Constants.key_foreclosure_prefix + doxie.Version_SuperKey +'::did');  

shared file_foreclosure_bdid :=  dedup(sort(project(files.foreclosure_autokey(bdid <> 0), {files.foreclosure_autokey.bdid, files.foreclosure_autokey.foreclosure_id}), record), record);
export key_foreclosures_bdid	:= index(file_foreclosure_bdid(bdid <> 0), {bdid},{string70 fid := foreclosure_id},Data_Services.Data_location.prefix('foreclosure') + Constants.key_foreclosure_prefix + doxie.Version_SuperKey +'::bdid');  

foreclosure_slim :=  project(files.base, transform(Layouts.Foreclosure_In_Slim, self := left)); 
foreclosure_slim_filter := dedup(sort(foreclosure_slim(situs1_zip <> '', situs1_prim_range <> '', situs1_prim_name <> ''), foreclosure_id, local), record,all);;
export key_foreclosures_addr	:= index(foreclosure_slim_filter, {situs1_zip,situs1_prim_range,situs1_prim_name,situs1_addr_suffix,situs1_predir},{foreclosure_slim_filter},Data_Services.Data_location.prefix('foreclosure') + Constants.key_foreclosure_prefix + doxie.Version_SuperKey+'::address');

rLayout := record
Layouts.Fares_Foreclosure; 
BIPV2.IDlayouts.l_xlink_ids name1;
BIPV2.IDlayouts.l_xlink_ids name2;
BIPV2.IDlayouts.l_xlink_ids name3;
BIPV2.IDlayouts.l_xlink_ids name4;
end;

shared file_linkids := dedup(sort(project(files.BASE, transform(rLayout,	self := left)), foreclosure_id, local), record,all); 
shared file_linkids_fid := file_linkids(name1.DotID+name1.EmpID+name1.POWID+name1.ProxID+name1.SELEID+name1.OrgID+name1.UltID > 0 or
																 name2.DotID+name2.EmpID+name2.POWID+name2.ProxID+name2.SELEID+name2.OrgID+name2.UltID > 0  or
																 name3.DotID+name3.EmpID+name3.POWID+name3.ProxID+name3.SELEID+name3.OrgID+name3.UltID > 0  or
																 name4.DotID+name4.EmpID+name4.POWID+name4.ProxID+name4.SELEID+name4.OrgID+name4.UltID > 0); 
export key_foreclosures_fid_linkids	:= index(file_linkids_fid(trim(deed_category)='U'), {string70 fid := foreclosure_id},{file_linkids_fid},Data_Services.Data_location.prefix('foreclosure') + Constants.key_foreclosure_prefix + doxie.Version_SuperKey+'::fid::linkids');

export key_foreclosures_linkids := MODULE
	shared Base							:= dedup(project(files.normalized_base(trim(deed_category)='U',site_prim_name<>'',site_zip<>''), layouts.BIP_layout), record); 
	shared superfile_name		:= Data_Services.Data_location.Prefix('foreclosure') + Constants.key_foreclosure_prefix + doxie.Version_SuperKey + '::linkids';
	
	BIPV2.IDmacros.mac_IndexWithXLinkIDs(Base, k, superfile_name)
	export Key := k;
	
	export kFetch2(
		dataset(BIPV2.IDlayouts.l_xlink_ids2) inputs, 
		string1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	//The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
																								//Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
																								//Should be enumerated or something?  at least need constants defined somewhere if you keep string1
		unsigned2 ScoreThreshold = 0,								//Applied at lowest leve of ID
		joinLimit = 25000,
		unsigned1 JoinType = BIPV2.IDconstants.JoinTypes.KeepJoin
		) :=
	FUNCTION

		BIPV2.IDmacros.mac_IndexFetch2(inputs, Key, out, Level, joinLimit, JoinType);
		return out;																					

	END;
	//DEFINE THE INDEX ACCESS
	export kFetch(
		dataset(BIPV2.IDlayouts.l_xlink_ids) inputs, 
		string1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	//The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
																								//Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
																								//Should be enumerated or something?  at least need constants defined somewhere if you keep string1
		unsigned2 ScoreThreshold = 0,								//Applied at lowest leve of ID
		Joinlimit = 25000
		) :=
	FUNCTION
	
	  inputs_for2 := project(inputs, BIPV2.IDlayouts.l_xlink_ids2);
		f2 := kFetch2(inputs_for2, Level, ScoreThreshold, JoinLimit);		
		return project(f2, recordof(Key));
	END;

END;


//NOD Keys
export key_NOD_FID			:= index(file_foreclosure_building_bdid(trim(deed_category)='N'), {string70 fid := foreclosure_id}, {file_foreclosure_building_bdid}, Data_Services.Data_location.prefix('foreclosure') + Constants.key_nod_prefix + doxie.Version_SuperKey+'::fid'); 

shared file_nod_did :=  dedup(sort(project(files.NOD_AUTOKEY(did <> 0), {files.NOD_AUTOKEY.did, files.NOD_AUTOKEY.foreclosure_id}), record), record);
export key_NOD_DID			:= index(file_nod_did(did != 0), {did},{string70 fid := foreclosure_id},Data_Services.Data_location.prefix('foreclosure') + Constants.key_nod_prefix + doxie.Version_SuperKey + '::did');

shared file_nod_bdid :=  dedup(sort(project(files.NOD_AUTOKEY(bdid <> 0), {files.NOD_AUTOKEY.bdid, files.NOD_AUTOKEY.foreclosure_id}), record), record);
export key_NOD_BDID			:= index(file_nod_bdid(bdid != 0), {bdid},{string70 fid := foreclosure_id},Data_Services.Data_location.prefix('foreclosure') + Constants.key_nod_prefix + doxie.Version_SuperKey + '::bdid');

export key_NOD_FID_Linkids	:= index(file_linkids_fid(trim(deed_category)='N'), {string70 fid := foreclosure_id},{file_linkids_fid},Data_Services.Data_location.prefix('foreclosure') + Constants.key_nod_prefix + doxie.Version_SuperKey + '::fid::linkids');

export key_NOD_Linkids	:= MODULE
	shared Base							:= dedup(project(files.normalized_base(trim(deed_category)='N',site_prim_name<>'',site_zip<>''),layouts.BIP_layout), record); 
	shared superfile_name		:= Data_Services.Data_location.Prefix('foreclosure')+ Constants.key_nod_prefix + doxie.Version_SuperKey+ '::linkids';
	
	BIPV2.IDmacros.mac_IndexWithXLinkIDs(Base, k, superfile_name)
	export Key := k;
	
	export kFetch2(
		dataset(BIPV2.IDlayouts.l_xlink_ids2) inputs, 
		string1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	//The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
																								//Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
																								//Should be enumerated or something?  at least need constants defined somewhere if you keep string1
		unsigned2 ScoreThreshold = 0,								//Applied at lowest leve of ID
		joinLimit = 25000,
		unsigned1 JoinType = BIPV2.IDconstants.JoinTypes.KeepJoin
		) :=
	FUNCTION

		BIPV2.IDmacros.mac_IndexFetch2(inputs, Key, out, Level, joinLimit, JoinType);
		return out;																					

	END;
	//DEFINE THE INDEX ACCESS
	export kFetch(
		dataset(BIPV2.IDlayouts.l_xlink_ids) inputs, 
		string1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	//The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
																								//Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
																								//Should be enumerated or something?  at least need constants defined somewhere if you keep string1
		unsigned2 ScoreThreshold = 0,								//Applied at lowest leve of ID
		Joinlimit = 25000
		) :=
	FUNCTION
	
	  inputs_for2 := project(inputs, BIPV2.IDlayouts.l_xlink_ids2);
		f2 := kFetch2(inputs_for2, Level, ScoreThreshold, JoinLimit);		
		return project(f2, recordof(Key));
	END;

END;


//CREATE AUTOKEYS
export foreclosure_autokeys(string indicator, string filedate):= function
		
		//produce autokeys for foreclosure
		ak_dataset				:= if(indicator = 'F',files.foreclosure_autokey, files.nod_autokey);
		ak_keyname				:= if(indicator = 'F',Constants.ak_keyname,Constants.ak_nod_keyname);
		ak_logical				:= if(indicator = 'F',Constants.ak_logical(filedate),Constants.ak_nod_logical(filedate));
		ak_skipSet				:= Constants.ak_skipSet;
		ak_typeStr				:= Constants.ak_typeStr;
		
		
		AutoKeyB2.MAC_Build (ak_dataset,name_first,name_middle,name_last,
												 ssn,
												 zero,   
												 blank,
												 site_prim_name,
												 site_prim_range,
												 site_st,
												 site_p_city_name,
												 site_zip,
												 site_sec_range,
												 zero,
												 zero,zero,zero,
												 zero,zero,zero,
												 zero,zero,zero,
												 zero,
												 did,
												 name_company,
												 zero,   
												 zero,   
												 site_prim_name,
												 site_prim_range,
												 site_st,
												 site_p_city_name,
												 site_zip,
												 site_sec_range,
												 bdid, 
											   ak_keyname,
												 ak_logical,
												 bld_auto_keys,false,
								         ak_skipSet,true,ak_typeStr,
												 true,,,zero); 

		

	AutoKeyB2.MAC_AcceptSK_to_QA(ak_keyname, mymove,,ak_skipSet) ; 

	retval := sequential(bld_auto_keys, mymove);

	return retval; 				
end;

auto_payload := RECORD
unsigned6 fakeid;
recordof(Files.Foreclosure_Autokey);
END;

shared dsPayload := dataset([],auto_payload);
export Key_Foreclosures_Payload := index(dsPayload,{fakeid}, {dsPayload},Data_Services.Data_location.Prefix('foreclosure')+ Constants.autokeyname + doxie.Version_SuperKey + '::payload');



auto_payload_nod := RECORD
unsigned6 fakeid;
recordof(Files.nod_Autokey);
END;

shared dsPayload_nod := dataset([],auto_payload_nod);
export Key_NOD_Payload := index(dsPayload_nod,{fakeid}, {dsPayload_nod},Data_Services.Data_location.Prefix('foreclosure')+ Constants.nod_autokeyname + doxie.Version_SuperKey + '::payload');


END;
