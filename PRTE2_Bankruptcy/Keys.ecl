IMPORT doxie, bipv2, ut, Data_Services, PRTE2_Bankruptcy, BankruptcyV2, PRTE, AutoKeyB2, autokey, AutoKeyI;

EXPORT Keys := MODULE

//BankruptcyV2 keys
	dKeybankruptcyv2_bdid				 := TABLE(Files.Search_Base((unsigned6)bdid != 0),
																													{Files.Search_Base.bdid,
																													Files.Search_Base.tmsid,
																													Files.Search_Base.court_code,
																													Files.Search_Base.case_number});
	EXPORT key_bankruptcyv2_bdid := INDEX(dKeybankruptcyv2_bdid, {unsigned6 p_bdid := (unsigned6)bdid}, {TMSID,court_code,case_number},
																				PRTE2_Bankruptcy.Constants.KEY_PREFIX + 'bankruptcyv2::'+ doxie.Version_SuperKey + '::bdid');
																				
	dKeybankruptcyv2_case_number				:= 	TABLE(Files.Main_Base(trim(case_number) <> ''),
																																{Files.Main_Base.tmsid,
																																Files.Main_Base.case_number,
																																Files.Main_Base.filing_jurisdiction});
	EXPORT key_bankruptcyv2_case_number := INDEX(dKeybankruptcyv2_case_number, {case_number, string2 filing_state := filing_jurisdiction}, {TMSID},
																								PRTE2_Bankruptcy.Constants.KEY_PREFIX + 'bankruptcyv2::'+ doxie.Version_SuperKey + '::case_number'); 
	
	dKeybankruptcyv2_did				:= 	TABLE(Files.Search_Base((unsigned6)did != 0),
																													{Files.Search_Base.did,
																													Files.Search_Base.tmsid,
																													Files.Search_Base.court_code,
																													Files.Search_Base.case_number});
	EXPORT key_bankruptcyv2_did	:=	INDEX(dKeybankruptcyv2_did, {unsigned6 did := (unsigned6)did}, {TMSID,court_code,case_number},
																				PRTE2_Bankruptcy.Constants.KEY_PREFIX + 'bankruptcyv2::'+ doxie.Version_SuperKey + '::did');
	
	EXPORT key_bankruptcyv2_main_tmsid		:=	INDEX(Files.Main_BaseV2, {tmsid}, {Files.Main_BaseV2},
																									PRTE2_Bankruptcy.Constants.KEY_PREFIX + 'bankruptcyv2::'+ doxie.Version_SuperKey + '::main::tmsid');
																									
	dKeybankruptcyv2_search_tmsid					:= 	PROJECT(Files.Search_Base, TRANSFORM(Layouts.lkey_bankruptcyv2_search_tmsid, SELF := LEFT));
	EXPORT key_bankruptcyv2_search_tmsid	:=	INDEX(dKeybankruptcyv2_search_tmsid, {tmsid}, {dKeybankruptcyv2_search_tmsid},
																									PRTE2_Bankruptcy.Constants.KEY_PREFIX + 'bankruptcyv2::'+ doxie.Version_SuperKey + '::search::tmsid');
																									
	EXPORT key_bankruptcyv2_search_linkids := MODULE
  // DEFINE THE INDEX
	shared superfile_name		:= PRTE2_Bankruptcy.Constants.KEY_PREFIX + 'bankruptcyv2::'+ doxie.Version_SuperKey + '::search_v3::linkids';
	layout_slim             := {BankruptcyV2.layout_bankruptcy_search_v3_supp_bip -ScrubsBits1}; 
	shared Base							:= PROJECT(Files.Search_Base,TRANSFORM(layout_slim, SELF := LEFT));
	
	BIPV2.IDmacros.mac_IndexWithXLinkIDs(Base, k, superfile_name)
	EXPORT Key := k;

	//DEFINE THE INDEX ACCESS
	EXPORT kFetch(
		dataset(BIPV2.IDlayouts.l_xlink_ids) inputs, 
		string1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	//The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
																								//Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
																								//Should be enumerated or something?  at least need constants defined somewhere if you keep string1
		unsigned2 ScoreThreshold = 0								//Applied at lowest leve of ID
		) := FUNCTION
		BIPV2.IDmacros.mac_IndexFetch(inputs, Key, out, Level)
		RETURN out;																					
		END;
	END;

	dKeybankruptcyv2_ssn					:= 	PROJECT(Files.Search_Base, TRANSFORM(Layouts.lkey_bankruptcyv2_ssn,
																																					SELF.ssn := if((unsigned6)LEFT.ssn <> 0,LEFT.ssn, LEFT.app_ssn); SELF:=LEFT));
	EXPORT key_bankruptcyv2_ssn		:=	INDEX(dKeybankruptcyv2_ssn, {ssn}, {tmsid},
																					PRTE2_Bankruptcy.Constants.KEY_PREFIX + 'bankruptcyv2::'+ doxie.Version_SuperKey + '::ssn');
	
//BankruptcyV3 keys
	EXPORT key_bankruptcyv3_search_tmsid (BOOLEAN IsFCRA = FALSE) := FUNCTION
		dKeybankruptcyv3_search_tmsid		:= 	PROJECT(Files.Search_Base, TRANSFORM(BankruptcyV2.layout_bankruptcy_search_v3_supp, SELF := LEFT));
		
	ut.MAC_CLEAR_FIELDS(dKeybankruptcyv3_search_tmsid, search_tmsid_cleared, prte2_bankruptcy.constants.search_tmsid_linkids);
	dsSearchTMSID_final := IF(isFCRA, search_tmsid_cleared, dKeybankruptcyv3_search_tmsid);
	
	RETURN	INDEX(dsSearchTMSID_final, {tmsid}, {dsSearchTMSID_final},
								IF(IsFCRA,
										PRTE2_Bankruptcy.Constants.KEY_PREFIX + 'bankruptcyv3::fcra::'+ doxie.Version_SuperKey + '::search::tmsid',
										PRTE2_Bankruptcy.Constants.KEY_PREFIX + 'bankruptcyv3::'+ doxie.Version_SuperKey + '::search::tmsid'));
	END;
	
	EXPORT key_bankruptcyv3_main_tmsid (BOOLEAN IsFCRA = FALSE) := FUNCTION
		//dKeybankruptcyv3_main_tmsid	:= PROJECT(Files.Main_Base, Layouts.Main_BaseV3);
		
	ut.MAC_CLEAR_FIELDS(prte2_bankruptcy.Files.Main_Base, main_based_cleared, prte2_bankruptcy.Constants.main_tmsid);
	ds_cleared_proj := project(main_based_cleared,recordof(prte2_bankruptcy.Files.Main_Base));
	ds_final := IF(isFCRA,ds_cleared_proj,prte2_bankruptcy.Files.Main_Base);
	
	RETURN	INDEX(ds_final, {tmsid}, {ds_final},
								IF(IsFCRA,
										PRTE2_Bankruptcy.Constants.KEY_PREFIX + 'bankruptcyv3::fcra::'+ doxie.Version_SuperKey + '::main::tmsid',
										PRTE2_Bankruptcy.Constants.KEY_PREFIX + 'bankruptcyv3::'+ doxie.Version_SuperKey + '::main::tmsid'));
	END;
	
	EXPORT key_main_supplement (BOOLEAN IsFCRA = FALSE) := FUNCTION
		dKeybankruptcyv3_main_supplement 	:= TABLE(Files.Main_Base, {Files.Main_Base.tmsid,
																																Files.Main_Base.method_dismiss;
																																Files.Main_Base.case_status});
	RETURN	INDEX(Files.Main_Base_supp, {tmsid}, {method_dismiss, case_status},
								IF(IsFCRA,
										PRTE2_Bankruptcy.Constants.KEY_PREFIX + 'bankruptcyv3::fcra::'+ doxie.Version_SuperKey + '::main::supplemental',
										PRTE2_Bankruptcy.Constants.KEY_PREFIX + 'bankruptcyv3::'+ doxie.Version_SuperKey + '::main::supplemental'));
	END;
										
	EXPORT key_ssn4st (BOOLEAN IsFCRA = FALSE) := FUNCTION
		dKeybankruptcyv3_ssn4st := PROJECT(Files.Search_Base((unsigned6)ssn <> 0),TRANSFORM(Layouts.lkey_ssn4st,SELF.ssnlast4:=LEFT.ssn[5..9];SELF.state:=LEFT.st;SELF:=LEFT));
	RETURN	INDEX(dKeybankruptcyv3_ssn4st,{ssnlast4, state, lname, fname}, {TMSID},
								IF(IsFCRA,
										PRTE2_Bankruptcy.Constants.KEY_PREFIX + 'bankruptcyv3::fcra::'+ doxie.Version_SuperKey + '::ssn4st',
										PRTE2_Bankruptcy.Constants.KEY_PREFIX + 'bankruptcyv3::'+ doxie.Version_SuperKey + '::ssn4st'));
	END;
										
	EXPORT key_ssnmatch (BOOLEAN IsFCRA = FALSE) := FUNCTION
		dKeybankruptcyv3_ssnmatch := PROJECT(Files.Search_Base,
																					TRANSFORM(Layouts.lkey_ssnmatch,SELF.ssnmatch:=LEFT.ssn;SELF:=LEFT));
	RETURN	INDEX(dKeybankruptcyv3_ssnmatch(trim(ssnmatch,left,right) <> ''), {ssnmatch}, {tmsid},
								IF(IsFCRA,
										PRTE2_Bankruptcy.Constants.KEY_PREFIX + 'bankruptcyv3::fcra::'+ doxie.Version_SuperKey + '::ssnmatch',
										PRTE2_Bankruptcy.Constants.KEY_PREFIX + 'bankruptcyv3::'+ doxie.Version_SuperKey + '::ssnmatch'));
	END;
	
	EXPORT key_trusteeidname (BOOLEAN IsFCRA = FALSE) := FUNCTION
		dKeybankruptcyv3_trusteeidname := TABLE(Files.Main_Base(trim(trusteeID,left,right) <> ''),{Files.Main_Base.trusteeid,Files.Main_Base.TMSID});
	RETURN	INDEX(dKeybankruptcyv3_trusteeidname, {trusteeid}, {tmsid},
								IF(IsFCRA,
										PRTE2_Bankruptcy.Constants.KEY_PREFIX + 'bankruptcyv3::fcra::'+ doxie.Version_SuperKey + '::trusteeidname',
										PRTE2_Bankruptcy.Constants.KEY_PREFIX + 'bankruptcyv3::'+ doxie.Version_SuperKey + '::trusteeidname'));
	END;
	
	EXPORT key_bankruptcyv2_search_v3_linkids (BOOLEAN IsFCRA = FALSE) := MODULE
		 // DEFINE THE INDEX
	shared superfile_nameV3		:= IF(IsFCRA, PRTE2_Bankruptcy.Constants.KEY_PREFIX + 'bankruptcyv3::fcra::'+ doxie.Version_SuperKey + '::search_v3::linkids',
																				PRTE2_Bankruptcy.Constants.KEY_PREFIX + 'bankruptcyv3::'+ doxie.Version_SuperKey + '::search_v3::linkids');
	layout_slim             := {BankruptcyV2.layout_bankruptcy_search_v3_supp_bip -ScrubsBits1}; 
	shared BaseV3							:= PROJECT(Files.Search_Base,layout_slim);
	
	BIPV2.IDmacros.mac_IndexWithXLinkIDs(BaseV3, kv3, superfile_nameV3)
	EXPORT KeyV3 := kv3;

	//DEFINE THE INDEX ACCESS
	EXPORT kFetch2(
		dataset(BIPV2.IDlayouts.l_xlink_ids2) inputs, 
		string1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	//The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
																								//Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
																								//Should be enumerated or something?  at least need constants defined somewhere if you keep string1
		unsigned2 ScoreThreshold = 0,								//Applied at lowest leve of ID
		joinLimit = 25000,
		unsigned1 JoinType = BIPV2.IDconstants.JoinTypes.KeepJoin
		) := FUNCTION

		BIPV2.IDmacros.mac_IndexFetch2(inputs, KeyV3, out, Level, joinLimit, JoinType);
		RETURN out;																																						
		END;
	END;
		
	EXPORT key_bankruptcyv3_search_tmsid_linkids (BOOLEAN IsFCRA = FALSE) := FUNCTION
		//dKeybankruptcyv3_search_tmsid_linkids := project(Files.Search_Base, BankruptcyV2.layout_bankruptcy_search_v3_supp_bip);
	ut.MAC_CLEAR_FIELDS(prte2_bankruptcy.Files.Search_Base, search_base_cleared, prte2_bankruptcy.constants.search_tmsid_linkids);
	search_final := IF(isFCRA, search_base_cleared, Files.Search_Base);
		
	RETURN INDEX(search_final, {tmsid}, {search_final},
							IF(IsFCRA,
										PRTE2_Bankruptcy.Constants.KEY_PREFIX + 'bankruptcyv3::fcra::'+ doxie.Version_SuperKey + '::search::tmsid_linkids',
										PRTE2_Bankruptcy.Constants.KEY_PREFIX + 'bankruptcyv3::'+ doxie.Version_SuperKey + '::search::tmsid_linkids'));
	END;
	
	EXPORT key_bankruptcyv3_bdid (BOOLEAN IsFCRA = FALSE) := FUNCTION
			dKeybankruptcyv3_bdid	:= 	TABLE(Files.Search_Base((unsigned6)bdid != 0),
																													{Files.Search_Base.bdid,
																													Files.Search_Base.tmsid,
																													Files.Search_Base.court_code,
																													Files.Search_Base.case_number});		
	RETURN INDEX(dKeybankruptcyv3_bdid, {unsigned6 p_bdid := (unsigned6)bdid}, {TMSID,court_code,case_number},
               IF(IsFCRA, 
										PRTE2_Bankruptcy.Constants.KEY_PREFIX + 'bankruptcyv3::fcra::' + doxie.Version_SuperKey + '::bdid',
										PRTE2_Bankruptcy.Constants.KEY_PREFIX + 'bankruptcyv3::' + doxie.Version_SuperKey + '::bdid'));
	END;
	
	EXPORT key_bankruptcyv3_did (BOOLEAN IsFCRA = FALSE) := FUNCTION
		dKeybankruptcyv3_did			:= 	TABLE(Files.Search_Base((unsigned6)did != 0),
																													{Files.Search_Base.did,
																													Files.Search_Base.tmsid,
																													Files.Search_Base.court_code,
																													Files.Search_Base.case_number});
	RETURN INDEX(dKeybankruptcyv3_did, {unsigned6 did := (unsigned6)did}, {TMSID,court_code,case_number},
																				IF(IsFCRA,
																						PRTE2_Bankruptcy.Constants.KEY_PREFIX + 'bankruptcyv3::fcra::'+ doxie.Version_SuperKey + '::did',
																						PRTE2_Bankruptcy.Constants.KEY_PREFIX + 'bankruptcyv3::'+ doxie.Version_SuperKey + '::did'));
	END;
	
	EXPORT key_bankruptcyv3_case_number (BOOLEAN IsFCRA = FALSE) := FUNCTION
		dKeybankruptcyv3_case_number				:= 	TABLE(Files.Main_Base(trim(case_number) <> ''),
																																	{Files.Main_Base.tmsid,
																																	Files.Main_Base.case_number,
																																	Files.Main_Base.filing_jurisdiction});
	RETURN INDEX(dKeybankruptcyv3_case_number, {case_number, string2 filing_state := filing_jurisdiction}, {TMSID},
																								IF(IsFCRA,
																										PRTE2_Bankruptcy.Constants.KEY_PREFIX + 'bankruptcyv3::fcra::'+ doxie.Version_SuperKey + '::case_number',
																										PRTE2_Bankruptcy.Constants.KEY_PREFIX + 'bankruptcyv3::'+ doxie.Version_SuperKey + '::case_number'));
	END;
	
	EXPORT key_bankruptcyv3_ssn (BOOLEAN IsFCRA = FALSE) := FUNCTION
		dKeybankruptcyv3_ssn			:= PROJECT(Files.Search_Base, TRANSFORM(Layouts.lkey_bankruptcyv2_ssn,
																																		SELF.ssn := if((unsigned6)LEFT.ssn <> 0,LEFT.ssn, LEFT.app_ssn); SELF:=LEFT));
		fKeybankruptcyv3_ssn			:= dKeybankruptcyv3_ssn((unsigned6)ssn <> 0);
	RETURN INDEX(fKeybankruptcyv3_ssn, {ssn}, {tmsid},
																		IF(IsFCRA,
																					PRTE2_Bankruptcy.Constants.KEY_PREFIX + 'bankruptcyv3::fcra::'+ doxie.Version_SuperKey + '::ssn',
																					PRTE2_Bankruptcy.Constants.KEY_PREFIX + 'bankruptcyv3::'+ doxie.Version_SuperKey + '::ssn'));
	END;
	
	//Autokeys
	EXPORT bld_autokeys(string filedate, boolean isFCRA = false) := FUNCTION

	//b := PRTE2_Bankruptcy.Files.Bankruptcy_file_autokey;
		 
// Constants
	ak_keyname := if(isFCRA,
													PRTE2_Bankruptcy.Constants.KEY_PREFIX + 'bankruptcy::autokey::fcra::',
													PRTE2_Bankruptcy.Constants.KEY_PREFIX + 'bankruptcy::autokey::');
	ak_logical := if(isFCRA,
													PRTE2_Bankruptcy.Constants.KEY_PREFIX + 'bankruptcy::' + filedate + '::autokey::fcra::',
													PRTE2_Bankruptcy.Constants.KEY_PREFIX + 'bankruptcy::' + filedate + '::autokey::');

autokey.mac_useFakeIDs 
	(PRTE2_Bankruptcy.Files.Bankruptcy_file_autokey, 
	ds_withFakeID_AKB,  
	proc_build_payload_key_AKB, 
	ak_keyname, 
	ak_logical, 
	intDID, 
	intbdid, 
	true, 
	'AK', 
	unsigned6, 
	false, 
	false, 
	zero,
	false) 
	 
ds_forLayoutMaster_AKB := ds_withFakeID_AKB; 
	 
ds_inLayoutMaster_AKB :=  
	project( 
		ds_forLayoutMaster_AKB, 
		transform( 
			autokey.layouts.master, 
			self.inp.fname := left.person_name.fname; 
			self.inp.mname := left.person_name.mname; 
			self.inp.lname := left.person_name.lname; 
			self.inp.ssn := if((integer)left.ssn=0,'',(string9)left.ssn); 
			self.inp.dob := (integer)left.zero; 
			self.inp.phone := (string10)left.zero; 
			self.inp.prim_name := left.person_addr.prim_name; 
			self.inp.prim_range := left.person_addr.prim_range; 
			self.inp.st := left.person_addr.st; 
			self.inp.city_name := left.person_addr.v_city_name; 
			self.inp.zip := (string6)left.person_addr.zip5; 
			self.inp.sec_range := left.person_addr.sec_range; 
			self.inp.states := left.zero; 
			self.inp.lname1 := left.zero; 
			self.inp.lname2 := left.zero; 
			self.inp.lname3 := left.zero; 
			self.inp.city1 := left.zero; 
			self.inp.city2 := left.zero; 
			self.inp.city3 := left.zero; 
			self.inp.rel_fname1 := left.zero; 
			self.inp.rel_fname2 := left.zero; 
			self.inp.rel_fname3 := left.zero; 
			self.inp.lookups := left.party_bits; 
			self.inp.DID := (unsigned6)left.intDID; 
			self.inp.bname := left.cname; 
			self.inp.fein := if((integer)left.tax_id=0,'',(string9)left.tax_id); 
			self.inp.bphone := (string10)left.zero; 
			self.inp.bprim_name := left.company_addr.prim_name; 
			self.inp.bprim_range := left.company_addr.prim_range; 
			self.inp.bst := left.company_addr.st; 
			self.inp.bcity_name := left.company_addr.v_city_name; 
			self.inp.bzip := (string5)left.company_addr.zip5; 
			self.inp.bsec_range := left.company_addr.sec_range; 
			self.inp.BDID := (unsigned6)left.intbdid; 
			self.FakeID := left.FakeID;
			self.p := [];
			self.b := []; 
			) 
	 ); 
	  
	 
 mod_AKB := module(AutokeyB2.Fn_Build.params) 
	export dataset(autokey.layouts.master) L_indata := ds_inLayoutMaster_AKB; 
	export string L_inkeyname := ak_keyname; 
	export string L_inlogical := ak_logical; 
	export boolean L_diffing := false; 
	export boolean L_Biz_useAllLookups := true; 
	export boolean L_Indv_useAllLookups := true; 
	export boolean L_by_lookup := true; 
	export boolean L_skipaddrnorm := false; 
	export boolean L_skipB2behavior := false; 
	export boolean L_useOnlyRecordIDs := true; 
	export boolean L_useFakeIDs := true; 
	export boolean L_AddCities := true; 
	export integer L_Biz_favor_lookup := 0; 
	export integer L_Indv_favor_lookup := 0; 
	export integer L_Rep_addr := 4; 
	export set of string1 L_build_skip_set  := []; 
	export boolean L_UseNewPreferredFirst:= true;
	export boolean L_processCompoundNames:= true;
	end; 
	 
	
build_custom_ak := MODULE (AutoKeyI.BuildI_Indv.ibuild)
	export BuildI_Indv_Custom1_keybuild(autokeyi.InterfaceForBuild in_mod)	:= PRTE.BK_MCustomAutokeyBuild.RedactedSSNName.keybuild(in_mod);
	export BuildI_Indv_Custom1_keymove(autokeyi.InterfaceForBuild in_mod)		:= PRTE.BK_MCustomAutokeyBuild.RedactedSSNName.keymove(in_mod);
	export BuildI_Indv_Custom1_keymoveQA(autokeyi.InterfaceForBuild in_mod)	:= PRTE.BK_MCustomAutokeyBuild.RedactedSSNName.keymoveQA(in_mod);
end;	

	
outaction :=  
	parallel(
		proc_build_payload_key_AKB, 
		AutokeyB2.Fn_Build.Do(mod_AKB, build_custom_ak, AutoKeyI.BuildI_Biz.DoBuild)
		); 
	
AutoKeyB2.MAC_AcceptSK_to_QA(ak_keyname, mymove)

retval := 
	sequential(
		outaction,
		mymove,
		PRTE.BK_MCustomAutokeyBuild.RedactedSSNName.keymoveQA(mod_AKB)
	);

 
RETURN retval;
END;

//Jira ticket: DF-18516
dStatusSlim	:=	PROJECT(files.Withdrawal_Base, Layouts.Key_WithdrawnStatus);
export Key_BankruptcyV3_WithdrawnStatus(boolean isFCRA = false)	:=	FUNCTION
	RETURN	INDEX(dStatusSlim(WithdrawnID <>''),{TMSID,CaseID,DefendantID},{dStatusSlim},
								IF(IsFCRA, constants.KEY_PREFIX +  'bankruptcyv3::fcra::', constants.KEY_PREFIX+ 'bankruptcyv3::') + doxie.Version_SuperKey + '::withdrawnstatus');
END;								

END;
	
	