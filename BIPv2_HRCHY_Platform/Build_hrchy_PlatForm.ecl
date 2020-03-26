
import BIPv2_HRCHY_PlatForm, BIPV2_Files, DCAV2, DNB_DMI, Frandx,tools,BIPV2,BIPV2_Testing;

// Preprocess
export Build_hrchy_PlatForm(

   string                                           pversion    = BIPV2.KeySuffix
  ,dataset(BIPV2.CommonBase.Layout) 				  			head        //= BIPV2_Files.files_proxid().DS_PROXID_BUILT
	,dataset(DCAV2.layouts.Base.companies) 					  lncad       = BIPV2_Files.files_hrchy.lnca							
	,dataset(recordof(BIPV2_Files.files_hrchy.duns))  dunsd       = BIPV2_Files.files_hrchy.duns					
	,dataset(Frandx.layouts.Base)										  frand       = BIPV2_Files.files_hrchy.fran
  ,boolean                                          pPromote2qa = true
  
) := module
	export Hrchy_Input_Rec:=RECORD
  unsigned6 rcid;
  string2 source;
  string9 ingest_status;
  unsigned6 dotid;
  unsigned6 empid;
  unsigned6 powid;
  unsigned6 proxid;
  unsigned6 seleid;
  unsigned6 lgid3;
  unsigned6 orgid;
  unsigned6 ultid;
  unsigned6 vanity_owner_did;
  unsigned8 cnt_rcid_per_dotid;
  unsigned8 cnt_dot_per_proxid;
  unsigned8 cnt_prox_per_lgid3;
  unsigned8 cnt_prox_per_powid;
  unsigned8 cnt_dot_per_empid;
  boolean has_lgid;
  boolean is_sele_level;
  boolean is_org_level;
  boolean is_ult_level;
  unsigned6 parent_proxid;
  unsigned6 sele_proxid;
  unsigned6 org_proxid;
  unsigned6 ultimate_proxid;
  unsigned2 levels_from_top;
  unsigned3 nodes_below;
  unsigned3 nodes_total;
  string1 sele_gold;
  string1 ult_seg;
  string1 org_seg;
  string1 sele_seg;
  string1 prox_seg;
  string1 pow_seg;
  string1 ult_prob;
  string1 org_prob;
  string1 sele_prob;
  string1 prox_prob;
  string1 pow_prob;
  string1 iscontact;
  string5 title;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 name_suffix;
  string3 name_score;
  string1 iscorp;
  string120 company_name;
  string50 company_name_type_raw;
  string50 company_name_type_derived;
  string1 cnp_hasnumber;
  string250 cnp_name;
  string30 cnp_number;
  string10 cnp_store_number;
  string10 cnp_btype;
  string1 cnp_component_code;
  string20 cnp_lowv;
  boolean cnp_translated;
  integer4 cnp_classid;
  unsigned8 company_rawaid;
  unsigned8 company_aceaid;
  string10 prim_range;
  string10 prim_range_derived;
  string2 predir;
  string28 prim_name;
  string28 prim_name_derived;
  string4 addr_suffix;
  string2 postdir;
  string10 unit_desig;
  string8 sec_range;
  string25 p_city_name;
  string25 v_city_name;
  string2 st;
  string5 zip;
  string4 zip4;
  string4 cart;
  string1 cr_sort_sz;
  string4 lot;
  string1 lot_order;
  string2 dbpc;
  string1 chk_digit;
  string2 rec_type;
  string2 fips_state;
  string3 fips_county;
  string10 geo_lat;
  string11 geo_long;
  string4 msa;
  string7 geo_blk;
  string1 geo_match;
  string4 err_stat;
  string250 corp_legal_name;
  string250 dba_name;
  string9 active_duns_number;
  string9 hist_duns_number;
  string9 active_enterprise_number;
  string9 hist_enterprise_number;
  string9 ebr_file_number;
  string30 active_domestic_corp_key;
  string30 hist_domestic_corp_key;
  string30 foreign_corp_key;
  string30 unk_corp_key;
  unsigned4 dt_first_seen;
  unsigned4 dt_last_seen;
  unsigned4 dt_vendor_first_reported;
  unsigned4 dt_vendor_last_reported;
  unsigned6 company_bdid;
  string50 company_address_type_raw;
  string9 company_fein;
  string1 best_fein_indicator;
  string10 company_phone;
  string1 phone_type;
  string60 company_org_structure_raw;
  unsigned4 company_incorporation_date;
  string8 company_sic_code1;
  string8 company_sic_code2;
  string8 company_sic_code3;
  string8 company_sic_code4;
  string8 company_sic_code5;
  string6 company_naics_code1;
  string6 company_naics_code2;
  string6 company_naics_code3;
  string6 company_naics_code4;
  string6 company_naics_code5;
  string6 company_ticker;
  string6 company_ticker_exchange;
  string1 company_foreign_domestic;
  string80 company_url;
  string2 company_inc_state;
  string32 company_charter_number;
  unsigned4 company_filing_date;
  unsigned4 company_status_date;
  unsigned4 company_foreign_date;
  unsigned4 event_filing_date;
  string50 company_name_status_raw;
  string50 company_status_raw;
  unsigned4 dt_first_seen_company_name;
  unsigned4 dt_last_seen_company_name;
  unsigned4 dt_first_seen_company_address;
  unsigned4 dt_last_seen_company_address;
  string34 vl_id;
  boolean current;
  unsigned8 source_record_id;
  unsigned2 phone_score;
  string9 duns_number;
  string100 source_docid;
  unsigned4 dt_first_seen_contact;
  unsigned4 dt_last_seen_contact;
  unsigned6 contact_did;
  string50 contact_type_raw;
  string50 contact_job_title_raw;
  string9 contact_ssn;
  unsigned4 contact_dob;
  string30 contact_status_raw;
  string60 contact_email;
  string30 contact_email_username;
  string30 contact_email_domain;
  string10 contact_phone;
  string1 from_hdr;
  string35 company_department;
  string50 company_address_type_derived;
  string60 company_org_structure_derived;
  string50 company_name_status_derived;
  string50 company_status_derived;
  string50 contact_type_derived;
  string50 contact_job_title_derived;
  string30 contact_status_derived;
  string1 address_type_derived;
  boolean is_vanity_name_derived;
 END;

		/* ---------------------- Linking --------------------------------*/
		shared _build			:= BIPv2_HRCHY_PlatForm.mod_Build(head, lncad, dunsd, frand);
		export Linking 		:= tools.macf_WriteFile(BIPv2_HRCHY_PlatForm.filenames(pversion).base.logical,_build.PatchedFile);
    
    shared kys        := BIPv2_HRCHY_PlatForm.Keys(pversion,pLgidTable := _build.lgidtable);
		export KeyProxID 	:= tools.macf_WriteIndex('kys.HrchyProxid.logical');
		export KeyLGID 	  := tools.macf_WriteIndex('kys.HrchyLgid.logical'  );

		
		/* ---------------------- Superfile --------------------------------*/
    export promote2built    := BIPv2_HRCHY_PlatForm.Promote(pversion).new2built;
    export lpromote2QA      := BIPv2_HRCHY_PlatForm.Promote(pversion).built2QA;

		
		/* ---------------------- Indexes?? --------------------------------*/

			
		/* ---------------------- Other?? --------------------------------*/
		
		
		/* ---------------------- Build All --------------------------------*/
		export DoBuild          := parallel(linking, KeyProxID, KeyLGID);
		export DoSuperFileMoves := parallel(promote2built);
		shared patched1_ddp     := dedup(_build.PatchedFile, proxid, all);
		export DoStats := 
		parallel(
			 output(count(_build.PatchedFile(has_lgid))                     , named('count_records_has_lgid'))
			,output(count(dedup(_build.PatchedFile(has_lgid), proxid, all)) , named('count_proxids_has_lgid'))
		
			,output(count(patched1_ddp(has_lgid))                           , named('count_hrchy_proxids_has_lgid'))
			,output(count(patched1_ddp(is_ult_level))                       , named('count_hrchy_proxids_is_ult_level'))

			,output(count(patched1_ddp(is_org_level))                       , named('count_hrchy_proxids_is_org_level'))
			,output(count(patched1_ddp(is_sele_level))                      , named('count_hrchy_proxids_is_sele_level'))
			,output(count(patched1_ddp(parent_proxid > 0))                  , named('count_hrchy_proxids_has_parent_proxid'))

			,output(sum(patched1_ddp(is_ult_level), nodes_total)            , named('sum_hrchy_total_nodes'))                 
			,output(choosen(patched1_ddp(is_sele_level and proxid <> sele_proxid), 100), named('sample_hrchy_sele_proxid_disagree_with_is_sele'))
			,output(count(patched1_ddp(is_sele_level and proxid <> sele_proxid)), named('count_hrchy_sele_proxid_disagree_with_is_sele'))

			,output(count(dedup(patched1_ddp, ultid, all))                      , named('count_hrchy_UltIDs'))
			,output(count(dedup(patched1_ddp, orgid, all))                      , named('count_hrchy_OrgIDs'))
			,output(count(dedup(patched1_ddp, SELEID, all))                     , named('count_hrchy_SELEIDs'))
			
			,output(count(dedup(patched1_ddp(ultid = orgid), ultid, all))       , named('count_hrchy_UltIDs_contain_matching_OrgID'))//should match 3 counts directly above
			,output(count(dedup(patched1_ddp(orgid = SELEID), orgid, all))      , named('count_hrchy_OrgIDs_contain_matching_SELEID'))
			,output(count(dedup(patched1_ddp(SELEID = proxid), SELEID, all))    , named('count_hrchy_SELEIDs_contain_matching_ProxID'))		      	
			
		);
		
    shared doQAPromotion := if(pPromote2qa = true  ,lpromote2QA);
    
    /* ---------------------- Strata Quick ID Check --------------------------------*/
    import BIPV2_Strata,strata;
    export dostrata_ID_Check(boolean pIsTesting = false) := BIPV2_Strata.mac_BIP_ID_Check(head,'Hrchy','Infile',pversion,pIsTesting);
    
		export runIter := 
			sequential(dostrata_ID_Check(),DoBuild, DoStats, DoSuperFileMoves,doQAPromotion) 
		: 
			SUCCESS(BIPV2_Build.mod_email.SendSuccessEmail(,'BIPv2', , 'HRCHY')), 
			FAILURE(BIPV2_Build.mod_email.SendFailureEmail(,'BIPv2', failmessage, 'HRCHY'));
end;