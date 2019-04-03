import doxie_files, doxie, ut, Data_Services, fcra,PRTE2_Prof_License_Mari, BIPV2,autokey,AutoKeyB2,AutoKeyI,fcra;

EXPORT Keys := module

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

layouts.tempSlimRec  	xformSearch(recordof(files.dsSearch) L, integer cnt) := transform
self.cnt := cnt;
self.mari_rid							:= L.mari_rid;
self.create_dte						:= L.create_dte;                  
self.last_upd_dte  				:= L.last_upd_dte; 
self.stamp_dte  					:= L.stamp_dte;
self.date_vendor_first_reported		:= L.date_vendor_first_reported;
self.date_vendor_last_reported		:= L.date_vendor_last_reported;
self.date_first_seen			:= L.date_first_seen;
self.date_last_seen				:= L.date_last_seen;
self.did									:= L.did;
self.bdid									:= L.bdid;
self.std_prof_cd					:= L.std_prof_cd;
self.std_source_upd				:= L.std_source_upd;
self.type_cd							:= L.type_cd;
self.fname								:= L.fname;
self.mname								:= L.mname;
self.lname								:= L.lname;
self.name_suffix					:= L.name_suffix;
self.party_birth					:= L.birth_dte;
self.license_nbr					:= L.license_nbr;	
self.cln_license_nbr			:= L.cln_license_nbr;
self.off_license_nbr			:= L.off_license_nbr;
self.license_state				:= L.license_state;
self.cmc_slpk							:= L.cmc_slpk;		
self.pcmc_slpk						:= L.pcmc_slpk;
self.tax_type							:= 	choose(cnt,L.tax_type_1,L.tax_type_2,L.tax_type_1,L.tax_type_2);
self.ssn_taxid						:= 	choose(cnt,L.ssn_taxid_1,L.ssn_taxid_2,L.ssn_taxid_1,L.ssn_taxid_2);

//Each company name should be associated to 2 addreasses(Bussines/Mailing)
self.company							:= 	choose(cnt,L.name_company,L.name_company,L.name_company_dba,L.name_company_dba);
self.party_phone 					:= 	choose(cnt,L.phn_mari_1,L.phn_mari_2,L.phn_mari_1,L.phn_mari_2);
self.addr_ind							:=  choose(cnt,L.addr_bus_ind,L.addr_mail_ind,L.addr_bus_ind,L.addr_mail_ind);
self.prim_range 					:= 	choose(cnt,l.Bus_prim_range,l.Mail_prim_range);
self.predir								:=  choose(cnt,l.Bus_predir,l.Mail_predir,l.Bus_predir,l.Mail_predir);
self.prim_name 						:= 	choose(cnt,l.Bus_prim_name,l.Mail_prim_name,l.Bus_prim_name,l.Mail_prim_name);
self.addr_suffix					:=  choose(cnt,l.Bus_addr_suffix,l.Mail_addr_suffix,l.Bus_addr_suffix,l.Mail_addr_suffix);
self.postdir							:= 	choose(cnt,l.Bus_postdir,l.Mail_postdir,l.Bus_postdir,l.Mail_postdir);
self.unit_desig						:=	choose(cnt,l.Bus_unit_desig,l.Mail_unit_desig,l.Bus_unit_desig,l.Mail_unit_desig);
self.sec_range 						:=  choose(cnt,l.Bus_sec_range,l.Mail_sec_range,l.Bus_sec_range,l.Mail_sec_range);
self.p_city_name					:=	choose(cnt,l.Bus_p_city_name,l.Mail_p_city_name,l.Bus_p_city_name,l.Mail_p_city_name);
self.city_name						:= 	choose(cnt,l.Bus_v_city_name,l.Mail_v_city_name,l.Bus_v_city_name,l.Mail_v_city_name);
self.st 									:= 	choose(cnt,l.Bus_state,l.Mail_state,l.Bus_state,l.Mail_state);
self.zip5									:= 	choose(cnt,l.Bus_zip5,l.Mail_zip5,l.Bus_zip5,l.Mail_zip5);
self.zip4									:=  choose(cnt,l.Bus_zip4,l.Mail_zip4,l.Bus_zip4,l.Mail_zip4);
self.brkr_license_nbr			:= L.brkr_license_nbr;
self.nmls_id							:= L.nmls_id;
self.foreign_nmls_id			:= L.foreign_nmls_id;
self.federal_regulator		:= L.federal_regulator;
self	:=L;
end;
NormNameAddr := dedup(sort(normalize(files.dsSearch,4,xformSearch(LEFT,COUNTER)), cnt), EXCEPT cnt, all, local);

//filter out 2nd record if address is blank
dsBusAddr := NormNameAddr(cnt = 1 or (cnt = 3 and company <> ''));
dsMailAddr := NormNameAddr((cnt = 2 or cnt = 4) and (prim_range + predir + prim_name + addr_suffix + postdir + unit_desig + sec_range + city_name + st + zip5 + party_phone +tax_type ) <> '');
comb_recs := project(dsBusAddr + dsMailAddr, transform(Layouts.SlimRec, self := left)):persist('~prte::temp::proflic_mari::normalized_recs');
ak_dataset := dedup(comb_recs,record,all,local);

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
