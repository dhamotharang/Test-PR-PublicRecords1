import ut,bipv2,wk_ut,BIPV2_Findlinks,BIPV2_Postprocess,std;
thecurrentdate  := (STRING8)Std.Date.Today();         
highwuid        := 'W' + thecurrentdate + '-999999';

EXPORT Build_Datacard(
   string   pversion  = bipv2.KeySuffix
  ,string20 TheSprint = 'Sprint ' + BIPV2.KeySuffix_mod2.SprintNumber(pversion) //'Sprint 26'
  ,string   the_WU    = trim(sort(wk_ut.get_Running_Workunits('W' + trim(STD.Str.Filter(pversion,'0123456789')) + '-000001',highwuid,'completed')(job = 'BIPV2_PostProcess.proc_segmentation ' + pversion),-wuid)[1].wuid)//'W20150217-055342'

) := Module

		shared formatDate(string date) := function
					M := STD.Date.Month((unsigned) date[1..8]);
					monthStr := trim(case (M, 
																									1 => 'Jan',
																									2 => 'Feb',
																									3 => 'Mar',
																									4 => 'Apr',
																									5 => 'May',
																									6 => 'June',
																									7 => 'July',
																									8 => 'Aug',
																									9 => 'Sept',
																									10 => 'Oct',
																									11 => 'Nov',
																									12 => 'Dec',
																									'UNK'));
							return trim(monthStr + '_' + date[1..4] + ' ' + STD.Str.ToUpperCase(date[9]));				
			end;

	//------------------------ID_Segmentation---------------------------------------------
	 Shared ProxSegmentationStatsV2_rec :={string20 segType, string20 segSubType, unsigned4 total};
	 Shared Entity_Count_Rec :={string10 UniqueID, unsigned6 cnt};
	 Shared TotalRecordCount_rec :={integer TotalRecordCount};

	 Shared TotalRecordCount:=Dataset(WorkUnit(the_WU,'TotalRecordCount'),TotalRecordCount_rec);
	 Shared ProxSegmentationStatsV2:=Dataset(WorkUnit(the_WU,'ProxSegmentationStatsV2'),ProxSegmentationStatsV2_rec);
	 Shared PowSegmentationStatsV2:=Dataset(WorkUnit(the_WU,'PowSegmentationStatsV2'),ProxSegmentationStatsV2_rec);
	 Shared SeleSegmentationStatsV2:=Dataset(WorkUnit(the_WU,'SeleSegmentationStatsV2'),ProxSegmentationStatsV2_rec);
	 Shared OrgSegmentationStatsV2:=Dataset(WorkUnit(the_WU,'OrgSegmentationStatsV2'),ProxSegmentationStatsV2_rec);
	 Shared Entity_Count:=Dataset(WorkUnit(the_WU,'EntityCount'),Entity_Count_Rec);

	 Shared ProxSegmentationStatsV2Prob :=Dataset(WorkUnit(the_WU,'ProxSegmentationStatsV2Probation'),ProxSegmentationStatsV2_rec);
	 Shared PowSegmentationStatsV2Prob  :=Dataset(WorkUnit(the_WU,'PowSegmentationStatsV2Probation'),ProxSegmentationStatsV2_rec);
	 Shared SeleSegmentationStatsV2Prob :=Dataset(WorkUnit(the_WU,'SeleSegmentationStatsV2Probation'),ProxSegmentationStatsV2_rec);
	 Shared OrgSegmentationStatsV2Prob  :=Dataset(WorkUnit(the_WU,'OrgSegmentationStatsV2Probation'),ProxSegmentationStatsV2_rec);

	 Shared Segmentation_Rec :={string1000 description, string40 cnt};
	 
		ProbProxMult	    := ProxSegmentationStatsV2Prob(segtype='CORE',         segsubtype='TrustedSource')[1].total + 
																	     ProxSegmentationStatsV2Prob(segtype='EMERGINGCORE', segsubtype='TrustedSrcSingleton')[1].total;  //TrustedSource + TrustedSrcSingleton
		ProbProxSingle	  := ProxSegmentationStatsV2Prob(segtype='CORE',         segsubtype='SingleSource')[1].total;         //SingleSource
		ProbProxInactive	:= ProxSegmentationStatsV2Prob(segtype='INACTIVE',     segsubtype='NoActivity')[1].total;	          //NoActivity

		ProbSeleMult	    := SeleSegmentationStatsV2Prob(segtype='CORE',         segsubtype='TrustedSource')[1].total + 
																	     SeleSegmentationStatsV2Prob(segtype='EMERGINGCORE', segsubtype='TrustedSrcSingleton')[1].total;  //TrustedSource + TrustedSrcSingleton
		ProbSeleSingle	  := SeleSegmentationStatsV2Prob(segtype='CORE',         segsubtype='SingleSource')[1].total;         //SingleSource
		ProbSeleInactive	:= SeleSegmentationStatsV2Prob(segtype='INACTIVE',     segsubtype='NoActivity')[1].total;	          //NoActivity
		ProbSeleLegd3  	 := Entity_Count(uniqueid='LGID3')[1].cnt;		//Total SELEs from LGID3 Processing

		ProbOrgMult	     := OrgSegmentationStatsV2Prob(segtype='CORE',         segsubtype='TrustedSource')[1].total + 
																	     OrgSegmentationStatsV2Prob(segtype='EMERGINGCORE', segsubtype='TrustedSrcSingleton')[1].total;  //TrustedSource + TrustedSrcSingleton
		ProbOrgSingle	   := OrgSegmentationStatsV2Prob(segtype='CORE',         segsubtype='SingleSource')[1].total;         //SingleSource
		ProbOrgInactive	 := OrgSegmentationStatsV2Prob(segtype='INACTIVE',     segsubtype='NoActivity')[1].total;	          //NoActivity

		ProbPowMult	     := PowSegmentationStatsV2Prob(segtype='CORE',         segsubtype='TrustedSource')[1].total + 
																	     PowSegmentationStatsV2Prob(segtype='EMERGINGCORE', segsubtype='TrustedSrcSingleton')[1].total;  //TrustedSource + TrustedSrcSingleton
		ProbPowSingle	   := PowSegmentationStatsV2Prob(segtype='CORE',         segsubtype='SingleSource')[1].total;         //SingleSource
		ProbPowInactive	 := PowSegmentationStatsV2Prob(segtype='INACTIVE',     segsubtype='NoActivity')[1].total;	          //NoActivity

		Shared SegmentationdsProb :=dataset([
													{'Segmentation Profile',formatDate(pVersion)},
													{'',TheSprint},
													{'Total Records',(string) TotalRecordCount[1].TotalRecordCount},
													{'',''},
													{'PROXID',(String) (ProbProxMult + ProbProxSingle + ProbProxInactive)},
													{'Active',(String) (ProbProxMult + ProbProxSingle)},
													{'Single Major and/or Single Source w/multiple records',(String) ProbProxMult},
													{'Single Source w/single record',(String) ProbProxSingle},
													{'Inactive',(String) ProbProxInactive},
													{'',''},
													{'SELEID',(String) (ProbSeleMult + ProbSeleSingle + ProbSeleInactive)},
													{'Active',(String) (ProbSeleMult + ProbSeleSingle)},
													{'Single Major and/or Single Source w/multiple records',(String) ProbSeleMult},
													{'Single Source w/single record',(String) ProbSeleSingle},
													{'Inactive',(String) ProbSeleInactive},
													{'Total SELEs from LGID3 Processing',(String) ProbSeleLegd3},
													{'',''},
													{'ORGID',(String) (ProbOrgMult + ProbOrgSingle + ProbOrgInactive)},
													{'Active',(String) (ProbOrgMult + ProbOrgSingle)},
													{'Single Major and/or Single Source w/multiple records',(String) ProbOrgMult},
													{'Single Source w/single record',(String) ProbOrgSingle},
													{'Inactive',(String) ProbOrgInactive},
													{'',''},
													{'POWID',(String) (ProbPowMult + ProbPowSingle + ProbPowInactive)},
													{'Active',(String) (ProbPowMult + ProbPowSingle)},
													{'Single Major and/or Single Source w/multiple records',(String) ProbPowMult},
													{'Single Source w/single record',(String) ProbPowSingle},
													{'Inactive',(String) ProbPowInactive}
													],Segmentation_Rec);




				
		
		//------------------------ID_Probation---------------------------------------------
		ProxTri         := ProxSegmentationStatsV2(segtype='CORE', segsubtype='TriCore')[1].total;
		ProxDual        := ProxSegmentationStatsV2(segtype='CORE', segsubtype='DualCore')[1].total;
		ProxSingleMajor := ProxSegmentationStatsV2(segtype='CORE', segsubtype='TrustedSource')[1].total + 
												         ProxSegmentationStatsV2(segtype='EMERGINGCORE', segsubtype='TrustedSrcSingleton')[1].total;
		ProxSingle      := ProxSegmentationStatsV2(segtype='CORE', segsubtype='SingleSource')[1].total;
		ProxInact       := ProxSegmentationStatsV2(segtype='INACTIVE', segsubtype='NoActivity')[1].total;
		ProxDefunct     := ProxSegmentationStatsV2(segtype='INACTIVE', segsubtype='ReportedInactive')[1].total;

		SeleTri         := SeleSegmentationStatsV2(segtype='CORE', segsubtype='TriCore')[1].total;
		SeleDual        := SeleSegmentationStatsV2(segtype='CORE', segsubtype='DualCore')[1].total;
		SeleSingleMajor := SeleSegmentationStatsV2(segtype='CORE', segsubtype='TrustedSource')[1].total + 
												         SeleSegmentationStatsV2(segtype='EMERGINGCORE', segsubtype='TrustedSrcSingleton')[1].total;
		SeleSingle      := SeleSegmentationStatsV2(segtype='CORE', segsubtype='SingleSource')[1].total;
		SeleInact       := SeleSegmentationStatsV2(segtype='INACTIVE', segsubtype='NoActivity')[1].total;
		SeleDefunct     := SeleSegmentationStatsV2(segtype='INACTIVE', segsubtype='ReportedInactive')[1].total;
		SeleLgid3	      := Entity_Count(uniqueid='LGID3')[1].cnt;		//Total SELEs from LGID3 Processing

		OrgTri          := OrgSegmentationStatsV2(segtype='CORE', segsubtype='TriCore')[1].total;
		OrgDual         := OrgSegmentationStatsV2(segtype='CORE', segsubtype='DualCore')[1].total;
		OrgSingleMajor  := OrgSegmentationStatsV2(segtype='CORE', segsubtype='TrustedSource')[1].total + 
												         OrgSegmentationStatsV2(segtype='EMERGINGCORE', segsubtype='TrustedSrcSingleton')[1].total;
		OrgSingle       := OrgSegmentationStatsV2(segtype='CORE', segsubtype='SingleSource')[1].total;
		OrgInact        := OrgSegmentationStatsV2(segtype='INACTIVE', segsubtype='NoActivity')[1].total;
		OrgDefunct      := OrgSegmentationStatsV2(segtype='INACTIVE', segsubtype='ReportedInactive')[1].total;

		PowTri          := PowSegmentationStatsV2(segtype='CORE', segsubtype='TriCore')[1].total;
		PowDual         := PowSegmentationStatsV2(segtype='CORE', segsubtype='DualCore')[1].total;
		PowSingleMajor  := PowSegmentationStatsV2(segtype='CORE', segsubtype='TrustedSource')[1].total + 
											         	PowSegmentationStatsV2(segtype='EMERGINGCORE', segsubtype='TrustedSrcSingleton')[1].total;
		PowSingle       := PowSegmentationStatsV2(segtype='CORE', segsubtype='SingleSource')[1].total;
		PowInact        := PowSegmentationStatsV2(segtype='INACTIVE', segsubtype='NoActivity')[1].total;
		PowDefunct      := PowSegmentationStatsV2(segtype='INACTIVE', segsubtype='ReportedInactive')[1].total;
			 
		Shared Segmentation_ds :=dataset([
													{'Segmentation Profile',formatDate(pVersion)},
													{'',TheSprint},
													{'Total Records',(string) TotalRecordCount[1].TotalRecordCount;},
													{'',''},
													{'PROXID',(String) (ProxTri + ProxDual + ProxSingleMajor + ProxSingle + ProxInact + ProxDefunct)},
													{'Active',(String) (ProxTri + ProxDual + ProxSingleMajor + ProxSingle)},
													{'Tri-Major Sources',                                   (String) ProxTri},
													{'Dual-Major Sources',                                  (String) ProxDual},
													{'Single Major and/or Single Source w/multiple records',(String) ProxSingleMajor},
													{'Single Source w/single record',                       (String) ProxSingle},
													{'Inactive',                                            (String) ProxInact},
													{'Defunct',                                             (String) ProxDefunct},
													{'',''},
													{'SELEID',(String) (SeleTri + SeleDual + SeleSingleMajor + SeleSingle + SeleInact + SeleDefunct)},
													{'Active',(String) (SeleTri + SeleDual + SeleSingleMajor + SeleSingle)},
													{'Tri-Major Sources',                                   (String) SeleTri},
													{'Dual-Major Sources',                                  (String) SeleDual},
													{'Single Major and/or Single Source w/multiple records',(String) SeleSingleMajor},
													{'Single Source w/single record',                       (String) SeleSingle},
													{'Inactive',                                            (String) SeleInact},
													{'Defunct',                                             (String) SeleDefunct},
													{'Total SELEs from LGID3 Processing',(String) SeleLgid3},
													{'',''},
													{'ORGID',(String) (OrgTri + OrgDual + OrgSingleMajor + OrgSingle + OrgInact + OrgDefunct)},
													{'Active',(String) (OrgTri + OrgDual + OrgSingleMajor + OrgSingle)},
													{'Tri-Major Sources',                                   (String) OrgTri},
													{'Dual-Major Sources',                                  (String) OrgDual},
													{'Single Major and/or Single Source w/multiple records',(String) OrgSingleMajor},
													{'Single Source w/single record',                       (String) OrgSingle},
													{'Inactive',                                            (String) OrgInact},
													{'Defunct',                                             (String) OrgDefunct},
													{'',''},
													{'POWID',(String) (PowTri + PowDual + PowSingleMajor + PowSingle + PowInact + PowDefunct)},
													{'Active',(String) (PowTri + PowDual + PowSingleMajor + PowSingle)},
													{'Tri-Major Sources',                                   (String) PowTri},
													{'Dual-Major Sources',                                  (String) PowDual},
													{'Single Major and/or Single Source w/multiple records',(String) PowSingleMajor},
													{'Single Source w/single record',                       (String) PowSingle},
													{'Inactive',                                            (String) PowInact},
													{'Defunct',                                             (String) PowDefunct}
													],Segmentation_Rec);
			 
			 
			 
	 
	
		// ----------------------Data Fill Rates Below-------------------------------------------------

		Shared Rec :={Unsigned8 countgroup,Unsigned1 nogrouping,Unsigned8 proxid,Unsigned8 rcid,Unsigned8 source,Unsigned8 ingest_status,Unsigned8 dotid,
		Unsigned8 empid,Unsigned8 powid,Unsigned8 seleid,Unsigned8 lgid3,Unsigned8 orgid,Unsigned8  ultid,Unsigned8 vanity_owner_did, 
		Unsigned8 cnt_rcid_per_dotid, Unsigned8 cnt_dot_per_proxid, Unsigned8  cnt_prox_per_lgid3, Unsigned8 cnt_prox_per_powid, 
		Unsigned8 cnt_dot_per_empid, Unsigned8 has_lgid,
		Unsigned8 is_sele_level, Unsigned8 is_org_level, Unsigned8 is_ult_level, Unsigned8 parent_proxid,Unsigned8 sele_proxid, Unsigned8 org_proxid, 
		Unsigned8 ultimate_proxid,Unsigned8 levels_from_top, Unsigned8 nodes_below, Unsigned8 nodes_total, Unsigned8 sele_gold, Unsigned8 ult_seg,
		Unsigned8 org_seg, Unsigned8 sele_seg, Unsigned8 prox_seg,Unsigned8 pow_seg, Unsigned8 ult_prob,Unsigned8 org_prob, Unsigned8 sele_prob,
		Unsigned8 prox_prob, Unsigned8 pow_prob, Unsigned8 iscontact, Unsigned8 title, Unsigned8 fname, Unsigned8 mname, Unsigned8 lname, 
		Unsigned8 name_suffix,Unsigned8 name_score, Unsigned8 iscorp, Unsigned8 company_name, Unsigned8 company_name_type_raw, 
		Unsigned8 company_name_type_derived, Unsigned8 cnp_hasnumber, Unsigned8 cnp_name,Unsigned8 cnp_number, Unsigned8 cnp_store_number, 
		Unsigned8 cnp_btype, Unsigned8 cnp_component_code,Unsigned8 cnp_lowv, Unsigned8 cnp_translated, Unsigned8 cnp_classid,Unsigned8 company_rawaid, 
		Unsigned8 company_aceaid,Unsigned8 prim_range,Unsigned8 prim_range_derived, Unsigned8 predir, Unsigned8 prim_name, Unsigned8 prim_name_derived,Unsigned8 addr_suffix, 
		Unsigned8 postdir, Unsigned8 unit_desig,Unsigned8 sec_range,Unsigned8 p_city_name, Unsigned8 v_city_name,Unsigned8 st,Unsigned8 zip, 
		Unsigned8 zip4,Unsigned8 cart,Unsigned8 cr_sort_sz, Unsigned8 lot, Unsigned8 lot_order,Unsigned8 dbpc,Unsigned8 chk_digit, Unsigned8 rec_type, 
		Unsigned8 fips_state,Unsigned8 fips_county,Unsigned8 geo_lat, Unsigned8 geo_long, Unsigned8 msa, Unsigned8 geo_blk, Unsigned8 geo_match, 
		Unsigned8 err_stat,Unsigned8 corp_legal_name,Unsigned8 dba_name, Unsigned8 active_duns_number, Unsigned8 hist_duns_number,
		Unsigned8 deleted_key, Unsigned8 deleted_fein, /*Newly added ????????? !!!!!!!!!!!!!!!  W20160503-114312 */
		Unsigned8 active_enterprise_number, Unsigned8 hist_enterprise_number,Unsigned8 ebr_file_number, Unsigned8 active_domestic_corp_key,
		Unsigned8 hist_domestic_corp_key, Unsigned8 foreign_corp_key, Unsigned8 unk_corp_key,Unsigned8 dt_first_seen, Unsigned8 dt_last_seen, 
		Unsigned8 dt_vendor_first_reported,Unsigned8 dt_vendor_last_reported, Unsigned8 company_bdid, Unsigned8 company_address_type_raw, 
		Unsigned8 company_fein, Unsigned8 best_fein_indicator, Unsigned8 company_phone, Unsigned8 phone_type, Unsigned8 company_org_structure_raw, 
		Unsigned8 company_incorporation_date, Unsigned8 company_sic_code1, Unsigned8 company_sic_code2, Unsigned8 company_sic_code3, 
		Unsigned8 company_sic_code4, Unsigned8 company_sic_code5, Unsigned8 company_naics_code1, Unsigned8 company_naics_code2, Unsigned8 company_naics_code3, 
		Unsigned8 company_naics_code4, Unsigned8 company_naics_code5, Unsigned8 company_ticker, Unsigned8 company_ticker_exchange, 
		Unsigned8 company_foreign_domestic, Unsigned8 company_url, Unsigned8 company_inc_state, Unsigned8 company_charter_number, 
		Unsigned8 company_filing_date, Unsigned8 company_status_date, Unsigned8 company_foreign_date, Unsigned8 event_filing_date, 
		Unsigned8 company_name_status_raw, Unsigned8 company_status_raw, Unsigned8 dt_first_seen_company_name, Unsigned8 dt_last_seen_company_name, 
		Unsigned8 dt_first_seen_company_address,Unsigned8 dt_last_seen_company_address, Unsigned8 vl_id, Unsigned8 current, Unsigned8 source_record_id, 
		Unsigned8 phone_score, Unsigned8 duns_number, Unsigned8 source_docid, Unsigned8 dt_first_seen_contact, Unsigned8 dt_last_seen_contact, 
		Unsigned8 contact_did, Unsigned8 contact_type_raw, Unsigned8 contact_job_title_raw, Unsigned8 contact_ssn, Unsigned8 contact_dob, 
		Unsigned8 contact_status_raw, Unsigned8 contact_email, Unsigned8 contact_email_username, Unsigned8 contact_email_domain, Unsigned8 contact_phone, 
		Unsigned8 from_hdr, Unsigned8 company_department, Unsigned8 company_address_type_derived,Unsigned8 company_org_structure_derived, 
		Unsigned8 company_name_status_derived, Unsigned8 company_status_derived, 

		Unsigned8 proxid_status_private,
		Unsigned8 powid_status_private,
		Unsigned8 seleid_status_private,
		Unsigned8 orgid_status_private,
		Unsigned8 ultid_status_private,
		Unsigned8 proxid_status_public,
		Unsigned8 powid_status_public,
		Unsigned8 seleid_status_public,
		Unsigned8 orgid_status_public,
		Unsigned8 ultid_status_public,

		Unsigned8 contact_type_derived, Unsigned8 contact_job_title_derived, 
		Unsigned8 contact_status_derived, Unsigned8 address_type_derived,	Unsigned8 is_vanity_name_derived
		};

		Shared  V2FieldStatsActivePROX	 :=Dataset(WorkUnit(the_WU,'V2_FieldStats_Active_PROX'),Rec); 
		Shared  V2FieldStatsInactivePROX :=Dataset(WorkUnit(the_WU,'V2_FieldStats_Inactive_PROX'),Rec); 

		Shared  V2FieldStatsActivePOW	 :=Dataset(WorkUnit(the_WU,'V2_FieldStats_Active_POW'),Rec); 
		Shared  V2FieldStatsInactivePOW	 :=Dataset(WorkUnit(the_WU,'V2_FieldStats_Inactive_POW'),Rec); 

		Shared  V2FieldStatsActiveSELE	 :=Dataset(WorkUnit(the_WU,'V2_FieldStats_Active_SELE'),Rec); 
		Shared  V2FieldStatsInactiveSELE :=Dataset(WorkUnit(the_WU,'V2_FieldStats_Inactive_SELE'),Rec); 
		Shared  V2FieldStatsActiveSELEGold:=Dataset(WorkUnit(the_WU,'V2_FieldStats_Active_SELE_GOLD'),Rec);

		Shared  V2FieldStatsActiveORG	 :=Dataset(WorkUnit(the_WU,'V2_FieldStats_Active_ORG'),Rec); 
		Shared  V2FieldStatsInactiveORG	 :=Dataset(WorkUnit(the_WU,'V2_FieldStats_Inactive_ORG'),Rec); 

		Shared  PA	:=V2FieldStatsActivePROX[1];
		Shared  PI :=V2FieldStatsInactivePROX[1];

		Shared  WA	:=V2FieldStatsActivePOW[1];
		Shared  WI	:=V2FieldStatsInactivePOW[1];

		Shared  SA	:=V2FieldStatsActiveSELE[1];
		Shared  SI :=V2FieldStatsInactiveSELE[1];
		Shared  SG :=V2FieldStatsActiveSELEGold[1];

		Shared  OA	:=V2FieldStatsActiveORG[1];
		Shared  OI	:=V2FieldStatsInactiveORG[1];

		Shared real PAT := (real) PA.countgroup;
		Shared real PIT := (real) PI.countgroup;
		Shared real WAT := (real) WA.countgroup;
		Shared real WIT := (real) WI.countgroup;
		Shared real SAT := (real) SA.countgroup;
		Shared real SIT := (real) SI.countgroup;
		Shared real SGT := (real) SG.countgroup;
		Shared real OAT := (real) OA.countgroup;
		Shared real OIT := (real) OI.countgroup;

		Shared Data_Fill_Rates_Rec :={string100 t1, string40 t2, string40 t3, string40 t4, string40 t5, string40 t6, string40 t7, 
								 string40 t8, string40 t9, string40 t10, string40 t11, string40 t12, string40 t13, string40 t14, 
								 string40 t15, string40 t16, string40 t17, string40 t18, string40 t19, string40 t20, string40 t21};
		Shared Data_Fill_Rates :=dataset([
													{'Current Build Fill Rates','','','','','','','','','','','','','','','','','','','',''},
													{formatDate(pVersion),'PROXID','','SELEID','','','ORGID','','POWID','','',                                         '','PROXID','','SELEID','','','ORGID','','POWID',''},
													{'','Active','Inactive','Active','Inactive','Act Gold','Active','Inactive','Active','Inactive','',      '','Active','Inactive','Active','Inactive','Act Gold','Active','Inactive','Active','Inactive'},
													{'Address','','','','','','','','','','',                                                               'Address','','','','','','','','',''},
													{'Street', PA.prim_name/PAT, PI.prim_name/PIT, SA.prim_name/SAT, SI.prim_name/SIT, SG.prim_name/SGT, OA.prim_name/OAT, OI.prim_name/OIT, WA.prim_name/WAT, WI.prim_name/WIT,'','Street',PA.prim_name, PI.prim_name, SA.prim_name, SI.prim_name, SG.prim_name, OA.prim_name, OI.prim_name, WA.prim_name, WI.prim_name},
													{'City',   PA.v_city_name/PAT, PI.v_city_name/PIT, SA.v_city_name/SAT, SI.v_city_name/SIT, SG.v_city_name/SGT, OA.v_city_name/OAT, OI.v_city_name/OIT, WA.v_city_name/WAT, WI.v_city_name/WIT,'','City',PA.v_city_name, PI.v_city_name, SA.v_city_name, SI.v_city_name, SG.v_city_name, OA.v_city_name, OI.v_city_name, WA.v_city_name, WI.v_city_name},
													{'State',   PA.st/PAT, PI.st/PIT, SA.st/SAT, SI.st/SIT, SG.st/SGT, OA.st/OAT, OI.st/OIT, WA.st/WAT, WI.st/WIT,'','State',PA.st, PI.st, SA.st, SI.st, SG.st, OA.st, OI.st, WA.st, WI.st},
													{'ZIP',   PA.zip/PAT, PI.zip/PIT, SA.zip/SAT, SI.zip/SIT, SG.zip/SGT, OA.zip/OAT, OI.zip/OIT, WA.zip/WAT, WI.zip/WIT,'','ZIP',PA.zip, PI.zip, SA.zip, SI.zip, SG.zip, OA.zip, OI.zip, WA.zip, WI.zip},
													{'Phone',   PA.company_phone/PAT, PI.company_phone/PIT, SA.company_phone/SAT, SI.company_phone/SIT, SG.company_phone/SGT, OA.company_phone/OAT, OI.company_phone/OIT, WA.company_phone/WAT, WI.company_phone/WIT,'','Phone',PA.company_phone, PI.company_phone, SA.company_phone, SI.company_phone, SG.company_phone, OA.company_phone, OI.company_phone, WA.company_phone, WI.company_phone},
													{'DBA',   PA.dba_name/PAT, PI.dba_name/PIT, SA.dba_name/SAT, SI.dba_name/SIT, SG.dba_name/SGT, OA.dba_name/OAT, OI.dba_name/OIT, WA.dba_name/WAT, WI.dba_name/WIT,'','DBA',PA.dba_name, PI.dba_name, SA.dba_name, SI.dba_name, SG.dba_name, OA.dba_name, OI.dba_name, WA.dba_name, WI.dba_name},
													{'Industry','','','','','','','','','','',                                                               'Industry','','','','','','','','',''},
													{'SIC Primary',   PA.company_sic_code1/PAT, PI.company_sic_code1/PIT, SA.company_sic_code1/SAT, SI.company_sic_code1/SIT, SG.company_sic_code1/SGT, OA.company_sic_code1/OAT, OI.company_sic_code1/OIT, WA.company_sic_code1/WAT, WI.company_sic_code1/WIT,'','SIC Primary',PA.company_sic_code1, PI.company_sic_code1, SA.company_sic_code1, SI.company_sic_code1, SG.company_sic_code1, OA.company_sic_code1, OI.company_sic_code1, WA.company_sic_code1, WI.company_sic_code1},
													{'NAICS Primary',   PA.company_naics_code1/PAT, PI.company_naics_code1/PIT, SA.company_naics_code1/SAT, SI.company_naics_code1/SIT, SG.company_naics_code1/SGT, OA.company_naics_code1/OAT, OI.company_naics_code1/OIT, WA.company_naics_code1/WAT, WI.company_naics_code1/WIT,'','NAICS Primary',PA.company_naics_code1, PI.company_naics_code1, SA.company_naics_code1, SI.company_naics_code1, SG.company_naics_code1, OA.company_naics_code1, OI.company_naics_code1, WA.company_naics_code1, WI.company_naics_code1},
													{'Contact','','','','','','','','','','',                                                               'Contact','','','','','','','','',''},
													{'Name',   PA.lname/PAT, PI.lname/PIT, SA.lname/SAT, SI.lname/SIT, SG.lname/SGT, OA.lname/OAT, OI.lname/OIT, WA.lname/WAT, WI.lname/WIT,'','Name',PA.lname, PI.lname, SA.lname, SI.lname, SG.lname, OA.lname, OI.lname, WA.lname, WI.lname},
													{'Email',   PA.contact_email/PAT, PI.contact_email/PIT, SA.contact_email/SAT, SI.contact_email/SIT, SG.contact_email/SGT, OA.contact_email/OAT, OI.contact_email/OIT, WA.contact_email/WAT, WI.contact_email/WIT,'','Email',PA.contact_email, PI.contact_email, SA.contact_email, SI.contact_email, SG.contact_email, OA.contact_email, OI.contact_email, WA.contact_email, WI.contact_email},
													{'Phone',   PA.contact_phone/PAT, PI.contact_phone/PIT, SA.contact_phone/SAT, SI.contact_phone/SIT, SG.contact_phone/SGT, OA.contact_phone/OAT, OI.contact_phone/OIT, WA.contact_phone/WAT, WI.contact_phone/WIT,'','Phone',PA.contact_phone, PI.contact_phone, SA.contact_phone, SI.contact_phone, SG.contact_phone, OA.contact_phone, OI.contact_phone, WA.contact_phone, WI.contact_phone},
													{'Other Content','','','','','','','','','','',                                                               'Other Content','','','','','','','','',''},
													{'FEIN',   PA.company_fein/PAT, PI.company_fein/PIT, SA.company_fein/SAT, SI.company_fein/SIT, SG.company_fein/SGT, OA.company_fein/OAT, OI.company_fein/OIT, WA.company_fein/WAT, WI.company_fein/WIT,'','FEIN',PA.company_fein, PI.company_fein, SA.company_fein, SI.company_fein, SG.company_fein, OA.company_fein, OI.company_fein, WA.company_fein, WI.company_fein},
													{'Ticker',   PA.company_ticker/PAT, PI.company_ticker/PIT, SA.company_ticker/SAT, SI.company_ticker/SIT, SG.company_ticker/SGT, OA.company_ticker/OAT, OI.company_ticker/OIT, WA.company_ticker/WAT, WI.company_ticker/WIT,'','Ticker',PA.company_ticker, PI.company_ticker, SA.company_ticker, SI.company_ticker, SG.company_ticker, OA.company_ticker, OI.company_ticker, WA.company_ticker, WI.company_ticker},
													{'URL',   PA.company_url/PAT, PI.company_url/PIT, SA.company_url/SAT, SI.company_url/SIT, SG.company_url/SGT, OA.company_url/OAT, OI.company_url/OIT, WA.company_url/WAT, WI.company_url/WIT,'','URL',PA.company_url, PI.company_url, SA.company_url, SI.company_url, SG.company_url, OA.company_url, OI.company_url, WA.company_url, WI.company_url},
													{'WU: ' + the_WU,'','','','','','','','','','','Totals:',PAT, PIT, SAT, SIT, SGT, OAT, OIT, WAT, WIT},
													{TheSprint,'','','','','','','','','','','','','','','','','','','',''},
													{'Build: ' + pVersion,'','','','','','','','','','','','','','','','','','','',''}
													],Data_Fill_Rates_Rec);



			 

			 
			 // ------------------------------------------GOLD Below-----------------------------
			 

		 Shared Attribute_Table_SELEID_V2_rec:=record
			 boolean              isgold                                                                      ;
			 boolean              isactive                                                                    ;
			 boolean              hassupercoresrc                                                             ;
			 boolean              hasothercoresrc                                                             ;
			 boolean              has2tsrc                                                                    ;
			 boolean              hasmultiplesources                                                          ;
			 boolean              hasbizaddr                                                                  ;
			 boolean              isnotjustpobox                                                              ;
			 integer8             cnt                                                                         ;
			 integer8             pct_of_all                                                                  ;
			 integer8             pct_of_gold                                                                 ;
			 integer8             pct_of_not_gold                                                             ;
			 string               description                                                                 ;
		end;

		Shared Attribute_Table_SELEID_V2:=Dataset(WorkUnit(the_WU,'Attribute_Table_SELEID V2'),Attribute_Table_SELEID_V2_rec);
		 
		Shared string s1:='LexisNexis Risk Solutions - Business Data Profile';
		Shared string s2:='Date: ' + the_WU[2..5] + ' ' + TheSprint;
		Shared string s3:='SELE--LexIDÃ‚Â® Business Legal Entity';
		Shared string s4:='GOLD';
		Shared string s5:='Multiple Sources at a Business Address';
		Shared string s6:='Gold: Active, No LNCA, Has 1 or more of DMI/EBR, Has 1 or more second tier source, Has 2 or more total sources, At Business Address';
		Shared string s7:='Gold: Active, No LNCA, No DMI/EBR, Has 1 or more second tier source, Has 2 or more total sources, At Business Address';
		Shared string s8:='Gold: Active, No LNCA, Has 1 or more of DMI/EBR, No second tier source, Has 2 or more total sources, At Business Address';
		Shared string s9:='Gold: Active, Has LNCA, Has 1 or more of DMI/EBR, Has 1 or more second tier source, Has 2 or more total sources, At Business Address';
		Shared string s10:='Gold: Active, Has LNCA, Has 1 or more of DMI/EBR, No second tier source, Has 2 or more total sources, At Business Address';
		Shared string s11:='Gold: Active, Has LNCA, No DMI/EBR, Has 1 or more second tier source, Has 2 or more total sources, At Business Address';
		Shared string s12:='Gold: Active, Has LNCA, No DMI/EBR, No second tier source, Has 2 or more total sources, At Business Address';
		Shared string s13:='';
		Shared string s14:='Mutliple Sources at an Unknown or Residential Address';
		Shared string s15:='Gold: Active, No LNCA, Has 1 or more of DMI/EBR, Has 1 or more second tier source, Has 2 or more total sources, At Residential or Unknown Address';
		Shared string s16:='Gold: Active, No LNCA, No DMI/EBR, Has 1 or more second tier source, Has 2 or more total sources, At Residential or Unknown Address';
		Shared string s17:='Gold: Active, No LNCA, Has 1 or more of DMI/EBR, No second tier source, Has 2 or more total sources, At Residential or Unknown Address';
		Shared string s18:='Gold: Active, Has LNCA, Has 1 or more of DMI/EBR, Has 1 or more second tier source, Has 2 or more total sources, At Residential or Unknown Address';
		Shared string s19:='Gold: Active, Has LNCA, Has 1 or more of DMI/EBR, No second tier source, Has 2 or more total sources, At Residential or Unknown Address';
		Shared string s20:='Gold: Active, Has LNCA, No DMI/EBR, Has 1 or more second tier source, Has 2 or more total sources, At Residential or Unknown Address';
		Shared string s21:='Gold: Active, Has LNCA, No DMI/EBR, No second tier source, Has 2 or more total sources, At Residential or Unknown Address';
		Shared string s22:='';
		Shared string s23:='Single Source at a Business Address';
		Shared string s24:='Gold: Active, No LNCA, No DMI/EBR, Has 1 or more second tier source, Has 1 total source, At Business Address';
		Shared string s25:='Gold: Active, No LNCA, Has 1 or more of DMI/EBR, No second tier source, Has 1 total source, At Business Address';
		Shared string s26:='Gold: Active, Has LNCA, No DMI/EBR, No second tier source, Has 1 total source, At Business Address';
		Shared string s27:='';
		Shared string s28:='Single Source at an Unknown or Residential Address';
		Shared string s29:='Gold: Active, Has LNCA, No DMI/EBR, No second tier source, Has 1 total source, At Residential or Unknown Address';
		Shared string s30:='';
		Shared string s31:='NON-GOLD';
		Shared string s32:='Single Source at a Business';
		Shared string s33:='Not Gold: Active, No LNCA, No DMI/EBR, No second tier source, Has 1 total source, At Business Address';
		Shared string s34:='Not Gold: Active, Has HV Source, Has 1 total source, At Business Address';
		Shared string s34b:='';
		Shared string s35:='Single Source at an Unknown or Residental Address';
		Shared string s36:='Not Gold: Active, No LNCA, No DMI/EBR, Has 1 or more second tier source, Has 1 total source, At Residential or Unknown Address';
		Shared string s37:='Not Gold: Active, No LNCA, Has 1 or more of DMI/EBR, No second tier source, Has 1 total source, At Residential or Unknown Address';
		Shared string s38:='Not Gold: Active, No LNCA, No DMI/EBR, No second tier source, Has 1 total source, At Residential or Unknown Address';
		Shared string s39 := 'Not Gold: Active, Has LNCA, Has 1 total source, At Residential or Unknown Address';
		Shared string s39b := '';
		Shared string s40:='Multiple Sources at an Unknown or Residential Address';
		Shared string s41:='Not Gold: Active, No LNCA, No DMI/EBR, No second tier source, Has 2 or more total sources, At Residential or Unknown Address';
		Shared string s42:='Not Gold: Active, has HV Source, Has 2 or more total sources, At Residential or Unknown Address';
		Shared string s42b:='';
		Shared string s43:='Multiple Sources at a Business Address';
		Shared string s44:='Non HV Sources'; 
		Shared string _s44 :='Not Gold: Active, No LNCA, No DMI/EBR, No second tier source, Has 2 or more total sources, At Business Address';

		Shared string s45:='Has HV Sources';
		Shared string s45b:='';
		Shared string s46:='Single Source at PO Box';
		Shared string s47:='Not Gold: Active, Has 1 total source, Only has PO Box';
		Shared string s48:='';
		Shared string s49:='Multiple Sources at PO Box';
		Shared string s50:='Not Gold: Active, Has 2 or more total sources, Only has PO Box';
		Shared string s51:='';
		Shared string s52:='Inactive';
		Shared string s53:='';
		Shared string s54:='Total Header SELEs';


	  Shared gold_layout :={string n1, string n2, string n3, string n4,  string val};

   g6  := Attribute_Table_SELEID_V2(description=s6)[1].cnt;
   g7  := Attribute_Table_SELEID_V2(description=s7)[1].cnt;
   g8  := Attribute_Table_SELEID_V2(description=s8)[1].cnt;
   g9  := Attribute_Table_SELEID_V2(description=s9)[1].cnt;
   g10 := Attribute_Table_SELEID_V2(description=s10)[1].cnt;
   g11 := Attribute_Table_SELEID_V2(description=s11)[1].cnt;
   g12 := Attribute_Table_SELEID_V2(description=s12)[1].cnt;
   g6_12 := g6+g7+g8+g9+g10+g11+g12;
	 
	  g15 := Attribute_Table_SELEID_V2(description=s15)[1].cnt;
   g16 := Attribute_Table_SELEID_V2(description=s16)[1].cnt;
   g17 := Attribute_Table_SELEID_V2(description=s17)[1].cnt;
   g18 := Attribute_Table_SELEID_V2(description=s18)[1].cnt;
   g19 := Attribute_Table_SELEID_V2(description=s19)[1].cnt;
   g20 := Attribute_Table_SELEID_V2(description=s20)[1].cnt;
   g21 := Attribute_Table_SELEID_V2(description=s21)[1].cnt;
	  g15_21 := g15+g16+g17+g18+g19+g20+g21;

   g24 := Attribute_Table_SELEID_V2(description=s24)[1].cnt;
   g25 := Attribute_Table_SELEID_V2(description=s25)[1].cnt;
   g26 := Attribute_Table_SELEID_V2(description=s26)[1].cnt;
	  g24_26 := g24+g25+g26;
	 
	  g29 := Attribute_Table_SELEID_V2(description=s29)[1].cnt;  

	  g33	:= sum(Attribute_Table_SELEID_V2(not isgold, isactive, not hasSuperCoreSrc, not hasOtherCoreSrc, not has2TSrc, not hasMultipleSources, hasBizAddr, isNotJustPoBox), cnt);
   g34	:= sum(Attribute_Table_SELEID_V2(not isgold, isactive, hasSuperCoreSrc or hasOtherCoreSrc or has2TSrc, not hasMultipleSources, hasBizAddr, isNotJustPoBox), cnt);
   g33_34 := g33+g34;
	 
   g36	:= Attribute_Table_SELEID_V2(description=s36)[1].cnt;
   g37	:= Attribute_Table_SELEID_V2(description=s37)[1].cnt;
   g38	:= Attribute_Table_SELEID_V2(description=s38)[1].cnt;
   g39	:= sum(Attribute_Table_SELEID_V2(not isgold, isactive, hasSuperCoreSrc, not hasMultipleSources, not hasBizAddr, isNotJustPoBox), cnt);
	  g36_39 := g36+g37+g38+g39;

   g41	:= Attribute_Table_SELEID_V2(description=s41)[1].cnt;
   g42	:= sum(Attribute_Table_SELEID_V2(not isgold, isactive, hasSuperCoreSrc or hasOtherCoreSrc or has2TSrc, hasMultipleSources, not hasBizAddr, isNotJustPoBox), cnt);
   g41_42 := g41+g42;
	 
   g44	:= Attribute_Table_SELEID_V2(description=_s44)[1].cnt; //Note We use _s44
   g45	:= sum(Attribute_Table_SELEID_V2(not isgold, isactive, hasSuperCoreSrc or hasOtherCoreSrc or has2TSrc, hasMultipleSources, hasBizAddr, isNotJustPoBox), cnt);
   g44_45 := g44+g45;
	 
   g47	:= sum(Attribute_Table_SELEID_V2(isgold=FALSE, isactive=TRUE, hasmultiplesources=FALSE,isnotjustpobox=FALSE),cnt);
   
   g50	:= sum(Attribute_Table_SELEID_V2(isgold=FALSE, isactive=TRUE, hasmultiplesources=TRUE,isnotjustpobox=FALSE),cnt);
   
   g52	:= SUM(Attribute_Table_SELEID_V2(isactive=FALSE),cnt); //Sum of the Not Gold Inactive Part. ?????
  
	  export GOLD_ds :=dataset([
												{'GOLD/Non-GOLD Profile', '', '', '',           formatDate(pVersion)},
												{'GOLD (Active)', '', '', '',                   (String) (g6_12 + g15_21 + g24_26 + g29)},
												
												{'Business Address -Mult. Sources', '', '', '', (String) g6_12},
												{'',     'DMI/EBR', '2nd Tier', '',             (String) g6},
												{'',     '',        '2nd Tier', '',             (String) g7},
												{'',     'DMI/EBR', '',         '',             (String) g8},
												{'LNCA', 'DMI/EBR', '2nd Tier', '',             (String) g9},
												{'LNCA', 'DMI/EBR', '',         '',             (String) g10},
												{'LNCA', '',        '2nd Tier', '',             (String) g11},
												{'LNCA', '',        '',         '',             (String) g12},
												
												{'Residential or Unk - Mult. Sources','','','', (String) g15_21},
												{'',     'DMI/EBR', '2nd Tier', '',             (String) g15},
												{'',     '',        '2nd Tier', '',             (String) g16},
												{'',     'DMI/EBR', '',         '',             (String) g17},
												{'LNCA', 'DMI/EBR', '2nd Tier', '',             (String) g18},
												{'LNCA', 'DMI/EBR', '',         '',             (String) g19},
												{'LNCA', '',        '2nd Tier', '',             (String) g20},
												{'LNCA', '',        '',         '',             (String) g21},
												
												{'Business Address - 1 Source','','','',        (String) g24_26},
												{'',     'DMI/EBR', '2nd Tier', '',             (String) g24},
												{'',     'DMI/EBR', '',         '',             (String) g25},
												{'LNCA', '',        '',         '',             (String) g26},
		 
												{'Residential or Unk - 1 Source','','','',      (String) g29},
												{'LNCA', '',        '',         '',             (String) g29},
												{' ',     '',        '',         '',            ' '},
			 
											{'NON-GOLD (Active)','','',     '',             (String) (g33_34 + g36_39 + g41_42 + g44_45 + g47 + g50)},
												{'Business Address -1 Sources','','','',        (String) g33_34},
												{'',     '',        '',         '',             (String) g33},
												{'',     '',        '',         'HV Source',    (String) g34},
			 
												{'Residential or Unk - 1 Source','','','',      (String) g36_39},
												{'',     '',        '2nd Tier', '',             (String) g36},
												{'',     'DMI/EBR', '',         '',             (String) g37},
											{'',     '',        '',         '',             (String) g38},
												{'LNCA', '',        '',         '',             (String) g39},
			 
												{'Residential or Unk - Mult. Sources','','','', (String) g41_42},
												{'',     '',        '',         '',             (String) g41},
												{'',     '',        '',         'HV Source',    (String) g42},

												{'Business Address -Mult. Sources','','','',    (String) g44_45},
												{'',     '',        '',         '',             (String) g44},
												{'',     '',        '',         'HV Source',    (String) g45},

												{'Single Source at PO Box','','','',            (String) g47},
												{'Multiple Sources at PO Box','','','',         (String) g50},
												{' ',     '',        '',         '',            ' '},
												
												{'Inactive','',     '',         '',             (String) g52},
												{' ',     '',        '',         '',            ' '},
												
												{'Total Header SELEs','','',    '',    									(String) (g6_12 + g15_21 + g24_26 + g29 + g33_34 + g36_39 + g41_42 + g44_45 + g47 + g50 + g52)} 
							],gold_layout);
	 
		 
	 
	 shared path1:='~' + BIPV2_postProcess.DataCollector().superfile_version_wuid;
	 shared xx :=dataset(path1,BIPV2_postProcess.DataCollector().version_wuid_rec,flat);
	 shared wu :=(string)xx(version=pversion)[1].wuid;
	 shared rr :=wk_ut.Restore_Workunit(wu);

  shared Prox:=BIPV2_postProcess.Data_GetProxConfStat(pVersion);
	 shared Lgid:=BIPV2_postProcess.Data_GetLgidConfStat(pVersion);

  export run :=sequential(
													output(the_WU ,named('the_WU')),
													output(rr),
													output(Prox,named('ProxConf')),
													output(Lgid,named('LgidConf')),		
													BIPV2_Findlinks.DS_Version_IterNumber.UpdateProxVersionIterNumber(),
													BIPV2_Findlinks.DS_Version_IterNumber.UpdateLgid3VersionIterNumber(), 												
													output(Data_Fill_Rates, named('Data_Fill_Rates'));
													output(Segmentation_ds, named('ID_Segmentation'));
													output(SegmentationdsProb, named('ID_Probation'));
													output(GOLD_ds, named('GOLD')),
												);
end;

								