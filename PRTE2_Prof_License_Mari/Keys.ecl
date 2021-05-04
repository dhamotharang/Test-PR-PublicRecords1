import doxie_files, doxie, ut, Data_Services, fcra,PRTE2_Prof_License_Mari, BIPV2,autokey,AutoKeyB2,AutoKeyI,fcra;

EXPORT Keys:= module

export key_disciplinary		:= index(files.dsDisciplinary,{INDIVIDUAL_NMLS_ID},{files.dsDisciplinary},Data_Services.Data_location.Prefix('mari')+ constants.KEY_PREFIX + doxie.Version_SuperKey+'::disciplinary_actions');
export key_indv_detail		:= index(files.dsDetail,{INDIVIDUAL_NMLS_ID}, {files.dsDetail}, Data_Services.Data_location.Prefix('mari')+ constants.KEY_PREFIX + doxie.Version_SuperKey+'::individual_detail');
export key_regulatory			:= index(files.dsRegulatory, {NMLS_ID,AFFIL_TYPE_CD}, {files.dsRegulatory}, Data_Services.Data_location.Prefix('mari')+ constants.KEY_PREFIX + doxie.Version_SuperKey+'::regulatory_actions');


export key_bdid      	:= index(dedup(files.dsSearch(bdid != 0),all),{unsigned6 bdid := (unsigned6)files.dsSearch.bdid}	,{files.dsSearch}, Data_Services.Data_location.Prefix('mari')+ constants.KEY_PREFIX + doxie.Version_SuperKey+'::bdid');
export key_cmc_slpk	 	:= index(files.dsSearch, {CMC_SLPK,AFFIL_TYPE_CD,STD_SOURCE_UPD}, {files.dsSearch},Data_Services.Data_location.Prefix('mari')+ constants.KEY_PREFIX + doxie.Version_SuperKey+'::cmc_slpk');


export did_file   := dedup(files.dsSearch_did(did !=0), all);		

EXPORT key_did(boolean IsFCRA = false) := function
ut.MAC_CLEAR_FIELDS(did_file, ds_search_cleared,Constants.fields_to_clear);
key_file := if(isFCRA, ds_search_cleared,did_file);

return INDEX(key_file,{unsigned6 s_did := (unsigned6)key_file.did},{key_file}, 
						 Data_services.Data_location.Prefix('mari') + if(isFCRA, constants.KEY_PREFIX + 'fcra::', constants.KEY_PREFIX) + doxie.Version_SuperKey + '::did');
								
end;

export key_nmls_id		:= index(files.dsSearch(nmls_id != 0), {nmls_id}, {files.dsSearch}, Data_Services.Data_location.Prefix('mari')+ constants.KEY_PREFIX + doxie.Version_SuperKey+'::nmls_id');
export key_mari_payload   := index(files.dsSearch, {mari_rid}, {files.dsSearch}, Data_Services.Data_location.Prefix('mari')+ constants.KEY_PREFIX + doxie.Version_SuperKey+'::rid');

//Create LICENSE KEY
export key_license_nbr		:= index(dedup(files.dsSearch(cln_license_nbr != ''), record), {cln_license_nbr, license_state},{files.dsSearch}, Data_Services.Data_location.Prefix('mari')+ constants.KEY_PREFIX + doxie.Version_SuperKey+'::license_nbr');
			
export key_ssn_taxid		:= index(files.dsTaxidSsn_dedup, {ssn_taxid, tax_type}, {files.dsTaxidSsn_dedup}, Data_Services.Data_location.Prefix('mari')+ constants.KEY_PREFIX +doxie.Version_SuperKey+'::ssn_taxid');


// DEFINE THE LINKIDS INDEX
EXPORT key_Linkids := MODULE 
shared superfile_name	:= constants.KEY_PREFIX +'qa::linkids';

BIPV2.IDmacros.mac_IndexWithXLinkIDs(files.dsSearch, k, superfile_name)
export Key := k;

	//DEFINE THE INDEX ACCESS
	export kFetch(
		dataset(BIPV2.IDlayouts.l_xlink_ids) inputs, 
		string1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	// The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
																													// Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
																													// Should be enumerated or something?  at least need constants defined somewhere if you keep string1
		unsigned2 ScoreThreshold = 0													// Applied at lowest leve of ID
		) :=
	FUNCTION

		BIPV2.IDmacros.mac_IndexFetch(inputs, Key, out, Level)
		return out;																					

	END;

END;


//CREATE AUTOKEYS
export autokeys(string filedate) := function

ak_dataset := project(build_aid.ak_dataset,layouts.slimrec);

ak_keyname	:= Constants.ak_keyname;
ak_logical	:= Constants.ak_logical(filedate);
ak_setSkip	:= Constants.set_skip;

autokey.mac_useFakeIDs (ak_dataset, 
												ds_withFakeID_AKB,
												proc_build_payload_key_AKB,
												ak_keyname,
												ak_logical,
												did,
												bdid)


outdataset := 
			project(
						ds_withFakeID_AKB,
								transform(autokey.layouts.master,
												self.inp.fname := left.fname;
												self.inp.mname := left.mname;
												self.inp.lname := left.lname;
												self.inp.ssn := if(left.tax_type = 'S',left.ssn_taxid,'');
												self.inp.dob := (integer)left.party_birth;
												self.inp.phone := if(left.type_cd = 'MD' or left.type_cd = '',left.party_phone,
																								if(left.type_cd = 'GR' and left.lname <> '', left.party_phone, ''));
												self.inp.prim_name := if(left.type_cd = 'MD' or left.type_cd = '',left.prim_name,
																									if(left.type_cd = 'GR' and left.lname <> '', left.prim_name, ''));
												self.inp.prim_range := if(left.type_cd = 'MD' or left.type_cd = '',left.prim_range,
																									if(left.type_cd = 'GR' and left.lname <> '', left.prim_range, ''));
												self.inp.st := if(left.type_cd = 'MD' or left.type_cd = '',left.st,
																						if(left.type_cd = 'GR' and left.lname <> '', left.st, ''));
												self.inp.city_name := if(left.type_cd = 'MD' or left.type_cd = '',left.city_name,
																									if(left.type_cd = 'GR' and left.lname <> '', left.city_name, ''));
												self.inp.zip := if(left.type_cd = 'MD' or left.type_cd = '',(string6)left.zip5,
																						if(left.type_cd = 'GR' and left.lname <> '', (string6)left.zip5, ''));
												self.inp.sec_range := if(left.type_cd = 'MD' or left.type_cd = '',left.sec_range,
																									if(left.type_cd = 'GR' and left.lname <> '', left.sec_range, ''));
												self.inp.states := 0;
												self.inp.lname1 := 0;
												self.inp.lname2 := 0;
												self.inp.lname3 := 0;
												self.inp.city1 := 0;
												self.inp.city2 := 0;
												self.inp.city3 := 0;
												self.inp.rel_fname1 := 0;
												self.inp.rel_fname2 := 0;
												self.inp.rel_fname3 := 0;
												self.inp.lookups := 0;
												self.inp.DID := (unsigned6)left.did;
												self.inp.bname := left.company;
												self.inp.fein := if(left.tax_type = 'E',left.ssn_taxid,'');
												self.inp.bphone := if(left.type_cd = 'GR' or left.company <> '',left.party_phone, '');
												self.inp.bprim_name := if(left.type_cd = 'GR' or left.company <> '',left.prim_name,'');
												self.inp.bprim_range := if(left.type_cd = 'GR' or left.company <> '',left.prim_range,'');
												self.inp.bst := if(left.type_cd = 'GR' or left.company <> '',left.st,'');
												self.inp.bcity_name := if(left.type_cd = 'GR' or left.company <> '',left.city_name,'');
												self.inp.bzip := if(left.type_cd = 'GR' or left.company <> '',(string5)left.zip5,'');
												self.inp.bsec_range := if(left.type_cd = 'GR' or left.company <> '',left.sec_range,'');
												self.inp.BDID := (unsigned6)left.bdid;
												self.FakeID := left.FakeID;
												self.p := [];
												self.b := [];		
												));


akmod := module(AutokeyB2.Fn_Build.params)
		export dataset(autokey.layouts.master) L_indata := outdataset;
		export string L_inkeyname := ak_keyname;
		export string L_inlogical := ak_logical;
		export set of string1 L_build_skip_set  := ak_setSkip;
end;


bld_auto_keys := parallel(proc_build_payload_key_AKB,
													AutokeyB2.Fn_Build.Do(akmod,
																								AutoKeyI.BuildI_Indv.DoBuild,
																								AutoKeyI.BuildI_Biz.DoBuild
																								)
													);
														
AutoKeyB2.MAC_AcceptSK_to_QA(ak_keyname,moveToQA);

retval := sequential(bld_auto_keys,moveToQA);
																	 
return retval;														
end;

export key_autokey_payload := index(files.dsPayload,{fakeid}, {files.dsPayload},Data_Services.Data_location.Prefix('mari')+ Constants.autokeyname + doxie.Version_SuperKey + '::payload');

end;
