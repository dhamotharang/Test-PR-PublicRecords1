import doxie_files, doxie, ut, Data_Services, fcra,PRTE2_Prof_License_Mari, BIPV2,autokey,AutoKeyB2,AutoKeyI;

EXPORT Keys := module

shared layout_disciplinary	:= RECORD, MAXLENGTH(8000)
Layouts.disp_action - [cust_name,bug_name];
END;

shared dsDisciplinary := project(files.base_disp_actions, layout_disciplinary);
shared dsDetail 			:= project(files.base_indiv_detail, {files.base_indiv_detail} - [cust_name,bug_name]);
shared dsRegulatory 	:= project(files.base_reg_actions, {files.base_reg_actions} - [cust_name,bug_name]);

export key_disciplinary		:= index(dsDisciplinary,{INDIVIDUAL_NMLS_ID},{dsDisciplinary},Data_Services.Data_location.Prefix('mari')+ constants.KEY_PREFIX + doxie.Version_SuperKey+'::disciplinary_actions');
export key_indv_detail		:= index(dsDetail,{INDIVIDUAL_NMLS_ID}, {dsDetail}, Data_Services.Data_location.Prefix('mari')+ constants.KEY_PREFIX + doxie.Version_SuperKey+'::individual_detail');
export key_regulatory			:= index(dsRegulatory, {NMLS_ID,AFFIL_TYPE_CD}, {dsRegulatory}, Data_Services.Data_location.Prefix('mari')+ constants.KEY_PREFIX + doxie.Version_SuperKey+'::regulatory_actions');


//--Main Base Keys--//
shared dsSearch 			:= project(files.base_search, {files.base_search} - [enh_did_src,cust_name,bug_name]);
export key_bdid      	:= index(dedup(dsSearch(bdid != 0),all),{unsigned6 bdid := (unsigned6)dsSearch.bdid}	,{dsSearch}, Data_Services.Data_location.Prefix('mari')+ constants.KEY_PREFIX + doxie.Version_SuperKey+'::bdid');
export key_cmc_slpk	 	:= index(dsSearch, {CMC_SLPK,AFFIL_TYPE_CD,STD_SOURCE_UPD}, {dsSearch},Data_Services.Data_location.Prefix('mari')+ constants.KEY_PREFIX + doxie.Version_SuperKey+'::cmc_slpk');
export key_did(boolean IsFCRA = false) := index(dedup(dsSearch(did != 0), all),		
																											{unsigned6 s_did := (unsigned6)dsSearch.did},{dsSearch}, 
																											Data_services.Data_location.Prefix('mari') + if(isFCRA, constants.KEY_PREFIX + 'fcra::', constants.KEY_PREFIX) + doxie.Version_SuperKey + '::did');

export key_nmls_id		:= index(dsSearch(nmls_id != 0), {nmls_id}, {dsSearch}, Data_Services.Data_location.Prefix('mari')+ constants.KEY_PREFIX + doxie.Version_SuperKey+'::nmls_id');
export key_mari_payload   := index(dsSearch, {mari_rid}, {dsSearch}, Data_Services.Data_location.Prefix('mari')+ constants.KEY_PREFIX + doxie.Version_SuperKey+'::rid');

//Create LICENSE KEY
export key_license_nbr		:= index(dedup(dsSearch(cln_license_nbr != ''), record), {cln_license_nbr, license_state},{dsSearch}, Data_Services.Data_location.Prefix('mari')+ constants.KEY_PREFIX + doxie.Version_SuperKey+'::license_nbr');


// Create TAXID_SSN Key
slim_ssn := record
unsigned6 mari_rid;
string2		tax_type;
string9		ssn_taxid;
unsigned8 MLTRECKEY;
unsigned8 CMC_SLPK;
unsigned8 PCMC_SLPK;
end;

				
slim_ssn  	xformTIN(recordof(dsSearch) L, integer cnt) := transform
self.tax_type					:= 	choose(cnt,L.tax_type_1,L.tax_type_2);
self.ssn_taxid				:= 	choose(cnt,L.ssn_taxid_1,L.ssn_taxid_2);
self.mari_rid					:= L.mari_rid;
self.mltreckey				:= L.mltreckey;
self.cmc_slpk					:= L.cmc_slpk;		
self.pcmc_slpk				:= L.pcmc_slpk;
self	:=L;
end;
shared NormTIN_SSN := normalize(dsSearch(ssn_taxid_1 != '' or ssn_taxid_2 != ''),2,xformTIN(LEFT,COUNTER));

shared dsSSN4	:=	project(NormTIN_SSN(tax_type = 'S' and ssn_taxid != ''),TRANSFORM(recordof(NormTIN_SSN), 
																																											self.tax_type := 'S4', 
																																											self.ssn_taxid := if(left.ssn_taxid != '' and left.ssn_taxid[6..9] != '0000', left.ssn_taxid[6..9],'');
																																											self := left));
TIN_SSN_comb := NormTIN_SSN(tax_type != 'S') + dsSSN4;
shared dsTaxidSsn_dedup := dedup(TIN_SSN_comb(tax_type != '' and ssn_taxid != ''), record,all);
export key_ssn_taxid		:= index(dsTaxidSsn_dedup, {ssn_taxid, tax_type}, {dsTaxidSsn_dedup}, Data_Services.Data_location.Prefix('mari')+ constants.KEY_PREFIX +doxie.Version_SuperKey+'::ssn_taxid');


// DEFINE THE LINKIDS INDEX
EXPORT key_Linkids := MODULE 
shared superfile_name	:= constants.KEY_PREFIX +'qa::linkids';

BIPV2.IDmacros.mac_IndexWithXLinkIDs(dsSearch, k, superfile_name)
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

tempSlimRec := record
Layouts.SlimRec;
integer cnt;
end;

tempSlimRec  	xformSearch(recordof(dsSearch) L, integer cnt) := transform
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
NormNameAddr := dedup(sort(normalize(dsSearch,4,xformSearch(LEFT,COUNTER)), cnt), EXCEPT cnt, all, local);

//filter out 2nd record if address is blank
dsBusAddr := NormNameAddr(cnt = 1 or (cnt = 3 and company <> ''));
dsMailAddr := NormNameAddr((cnt = 2 or cnt = 4) and (prim_range + predir + prim_name + addr_suffix + postdir + unit_desig + sec_range + city_name + st + zip5 + party_phone +tax_type ) <> '');
comb_recs := project(dsBusAddr + dsMailAddr, transform(Layouts.SlimRec, self := left)):persist('~prte::temp::proflic_mari::normalized_recs');
ak_dataset := dedup(comb_recs,record,all,local);

ak_keyname	:= Constants.ak_keyname;
ak_logical	:= Constants.ak_logical(filedate);
ak_setSkip	:= Constants.set_skip;
// ak_typeStr	:= Constants.ak_typeStr;

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


auto_payload := RECORD
unsigned6 fakeid;
Layouts.SlimRec
END;


shared dsPayload := dataset([],auto_payload);
export key_autokey_payload := index(dsPayload,{fakeid}, {dsPayload},Data_Services.Data_location.Prefix('mari')+ Constants.autokeyname + doxie.Version_SuperKey + '::payload');

end;
