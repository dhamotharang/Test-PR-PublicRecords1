import BIPV2, AutoStandardI,BizLinkFull,BIPV2_Build,BIPv2_HRCHY,tools,BIPV2_Suppression, LocationID_Ingest,LocationID_xLink,doxie;

EXPORT Key_BH_Linking_Ids := 
MODULE

	// DEFINE THE INDEX
	//logical_name := '~thor_data400::key::BIPV2::Business_Header::20120828::linkIds';
	shared superfile_name         := BIPV2_Build.keynames(, pUseOtherEnvironment:= tools._Constants.IsDataland).linkids.qa        ;
	shared superfile_name_hidden  := BIPV2_Build.keynames(, pUseOtherEnvironment:= tools._Constants.IsDataland).linkids_hidden.qa ;
	
	shared infile         := BIPV2.CommonBase.DS_CLEAN;
  shared Infile_hidden  := join(BIPV2.CommonBase.DS_BUILT,infile, left.rcid=right.rcid  ,transform({BIPV2.CommonBase.DS_BASE}  ,self:=left), left only,hash); //Add hash because RHS skewed, based on distribution of LHS partition points
	
	shared infile_rec := record
		BIPV2.Files.business_header;
//		BIPV2.IDlayouts.l_xlink_ids.SELEID;
		BIPV2.IDlayouts.l_xlink_ids.SELEscore;
		BIPV2.IDlayouts.l_xlink_ids.SELEweight;
	end;	
	
	shared layout_key := record
   unsigned6            rcid                                                                        ;
   string2              source                                                                      ;
   string9              ingest_status                                                               ;
   unsigned6            dotid                                                                       ;
   unsigned6            empid                                                                       ;
   unsigned6            powid                                                                       ;
   unsigned6            proxid                                                                      ;
   unsigned6            seleid                                                                      ;
   unsigned6            lgid3                                                                       ;
   unsigned6            orgid                                                                       ;
   unsigned6            ultid                                                                       ;
   unsigned6            vanity_owner_did                                                            ;
   unsigned8            cnt_rcid_per_dotid                                                          ;
   unsigned8            cnt_dot_per_proxid                                                          ;
   unsigned8            cnt_prox_per_lgid3                                                          ;
   unsigned8            cnt_prox_per_powid                                                          ;
   unsigned8            cnt_dot_per_empid                                                           ;
   boolean              has_lgid                                                                    ;
   boolean              is_sele_level                                                               ;
   boolean              is_org_level                                                                ;
   boolean              is_ult_level                                                                ;
   unsigned6            parent_proxid                                                               ;
   unsigned6            sele_proxid                                                                 ;
   unsigned6            org_proxid                                                                  ;
   unsigned6            ultimate_proxid                                                             ;
   unsigned2            levels_from_top                                                             ;
   unsigned3            nodes_below                                                                 ;
   unsigned3            nodes_total                                                                 ;
   string1              sele_gold                                                                   ;
   string1              ult_seg                                                                     ;
   string1              org_seg                                                                     ;
   string1              sele_seg                                                                    ;
   string1              prox_seg                                                                    ;
   string1              pow_seg                                                                     ;
   string1              ult_prob                                                                    ;
   string1              org_prob                                                                    ;
   string1              sele_prob                                                                   ;
   string1              prox_prob                                                                   ;
   string1              pow_prob                                                                    ;
   string1              iscontact                                                                   ;
   string5              title                                                                       ;
   string20             fname                                                                       ;
   string20             mname                                                                       ;
   string20             lname                                                                       ;
   string5              name_suffix                                                                 ;
   string3              name_score                                                                  ;
   string1              iscorp                                                                      ;
   string120            company_name                                                                ;
   string50             company_name_type_raw                                                       ;
   string50             company_name_type_derived                                                   ;
   string1              cnp_hasnumber                                                               ;
   string250            cnp_name                                                                    ;
   string30             cnp_number                                                                  ;
   string10             cnp_store_number                                                            ;
   string10             cnp_btype                                                                   ;
   string1              cnp_component_code                                                          ;
   string20             cnp_lowv                                                                    ;
   boolean              cnp_translated                                                              ;
   integer4             cnp_classid                                                                 ;
   unsigned8            company_rawaid                                                              ;
   unsigned8            company_aceaid                                                              ;
   string10             prim_range                                                                  ;
   string10             prim_range_derived                                                          ;
   string2              predir                                                                      ;
   string28             prim_name                                                                   ;
   string28             prim_name_derived                                                           ;
   string4              addr_suffix                                                                 ;
   string2              postdir                                                                     ;
   string10             unit_desig                                                                  ;
   string8              sec_range                                                                   ;
   string25             p_city_name                                                                 ;
   string25             v_city_name                                                                 ;
   string2              st                                                                          ;
   string5              zip                                                                         ;
   string4              zip4                                                                        ;
   string4              cart                                                                        ;
   string1              cr_sort_sz                                                                  ;
   string4              lot                                                                         ;
   string1              lot_order                                                                   ;
   string2              dbpc                                                                        ;
   string1              chk_digit                                                                   ;
   string2              rec_type                                                                    ;
   string2              fips_state                                                                  ;
   string3              fips_county                                                                 ;
   string10             geo_lat                                                                     ;
   string11             geo_long                                                                    ;
   string4              msa                                                                         ;
   string7              geo_blk                                                                     ;
   string1              geo_match                                                                   ;
   string4              err_stat                                                                    ;
   string250            corp_legal_name                                                             ;
   string250            dba_name                                                                    ;
   string9              active_duns_number                                                          ;
   string9              hist_duns_number                                                            ;
   string9              deleted_key                                                                 ;
   string9              deleted_fein                                                                ;
   string9              active_enterprise_number                                                    ;
   string9              hist_enterprise_number                                                      ;
   string9              ebr_file_number                                                             ;
   string30             active_domestic_corp_key                                                    ;
   string30             hist_domestic_corp_key                                                      ;
   string30             foreign_corp_key                                                            ;
   string30             unk_corp_key                                                                ;
   unsigned4            dt_first_seen                                                               ;
   unsigned4            dt_last_seen                                                                ;
   unsigned4            dt_vendor_first_reported                                                    ;
   unsigned4            dt_vendor_last_reported                                                     ;
   unsigned6            company_bdid                                                                ;
   string50             company_address_type_raw                                                    ;
   string9              company_fein                                                                ;
   string1              best_fein_indicator                                                         ;
   string10             company_phone                                                               ;
   string1              phone_type                                                                  ;
   string60             company_org_structure_raw                                                   ;
   unsigned4            company_incorporation_date                                                  ;
   string8              company_sic_code1                                                           ;
   string8              company_sic_code2                                                           ;
   string8              company_sic_code3                                                           ;
   string8              company_sic_code4                                                           ;
   string8              company_sic_code5                                                           ;
   string6              company_naics_code1                                                         ;
   string6              company_naics_code2                                                         ;
   string6              company_naics_code3                                                         ;
   string6              company_naics_code4                                                         ;
   string6              company_naics_code5                                                         ;
   string6              company_ticker                                                              ;
   string6              company_ticker_exchange                                                     ;
   string1              company_foreign_domestic                                                    ;
   string80             company_url                                                                 ;
   string2              company_inc_state                                                           ;
   string32             company_charter_number                                                      ;
   unsigned4            company_filing_date                                                         ;
   unsigned4            company_status_date                                                         ;
   unsigned4            company_foreign_date                                                        ;
   unsigned4            event_filing_date                                                           ;
   string50             company_name_status_raw                                                     ;
   string50             company_status_raw                                                          ;
   unsigned4            dt_first_seen_company_name                                                  ;
   unsigned4            dt_last_seen_company_name                                                   ;
   unsigned4            dt_first_seen_company_address                                               ;
   unsigned4            dt_last_seen_company_address                                                ;
   string34             vl_id                                                                       ;
   boolean              current                                                                     ;
   unsigned8            source_record_id                                                            ;
   unsigned2            phone_score                                                                 ;
   string9              duns_number                                                                 ;
   string100            source_docid                                                                ;
   unsigned4            dt_first_seen_contact                                                       ;
   unsigned4            dt_last_seen_contact                                                        ;
   unsigned6            contact_did                                                                 ;
   string50             contact_type_raw                                                            ;
   string50             contact_job_title_raw                                                       ;
   string9              contact_ssn                                                                 ;
   unsigned4            contact_dob                                                                 ;
   string30             contact_status_raw                                                          ;
   string60             contact_email                                                               ;
   string30             contact_email_username                                                      ;
   string30             contact_email_domain                                                        ;
   string10             contact_phone                                                               ;
   string1              from_hdr                                                                    ;
   string35             company_department                                                          ;
   string50             company_address_type_derived                                                ;
   string60             company_org_structure_derived                                               ;
   string50             company_name_status_derived                                                 ;
   string50             company_status_derived                                                      ;
   string1              proxid_status_private                                                       ;
   string1              powid_status_private                                                        ;
   string1              seleid_status_private                                                       ;
   string1              orgid_status_private                                                        ;
   string1              ultid_status_private                                                        ;
   string1              proxid_status_public                                                        ;
   string1              powid_status_public                                                         ;
   string1              seleid_status_public                                                        ;
   string1              orgid_status_public                                                         ;
   string1              ultid_status_public                                                         ;
   string50             contact_type_derived                                                        ;
   string50             contact_job_title_derived                                                   ;
   string30             contact_status_derived                                                      ;
   string1              address_type_derived                                                        ;
   boolean              is_vanity_name_derived                                                      ;
   unsigned2            selescore                                                                   ;
   unsigned2            seleweight                                                                  ;
   unsigned2            dotscore                                                                    ;
   unsigned2            dotweight                                                                   ;
   unsigned2            empscore                                                                    ;
   unsigned2            empweight                                                                   ;
   unsigned2            powscore                                                                    ;
   unsigned2            powweight                                                                   ;
   unsigned2            proxscore                                                                   ;
   unsigned2            proxweight                                                                  ;
   unsigned2            orgscore                                                                    ;
   unsigned2            orgweight                                                                   ;
   unsigned2            ultscore                                                                    ;
   unsigned2            ultweight                                                                   ;
   unsigned4            global_sid                                                                  ;
   unsigned8            record_sid                                                                  ;
   unsigned6            locid                                                                       ;
   unsigned1            seleid_status_private_score                                                 ;
   unsigned1            seleid_status_public_score                                                  ;
end;

		    	
	shared infile_key := project(infile, transform(layout_key,  
																											self.DotScore   := 100,
																											self.DotWeight  := 100,
																											self.EmpScore   := 100,
																											self.EmpWeight  := 100,
																											self.POWScore   := 100,
																											self.POWWeight  := 100,
																											self.ProxScore  := 100,
																											self.ProxWeight := 100,
																											self.OrgScore   := 100,
																											self.OrgWeight  := 100,
																											self.UltScore   := 100,
																											self.UltWeight  := 100,
																											self.SELEscore	:= 100,
																											self.SELEweight	:= 100,
                                                      // self.global_sid := 0  ,
                                                      // self.record_sid := 0  ,
                                                      self 						:= left,
																											));
		    
	shared infile_hidden_key := project(infile_hidden, transform(layout_key,  
                                                self.DotScore   := 100,
                                                self.DotWeight  := 100,
                                                self.EmpScore   := 100,
                                                self.EmpWeight  := 100,
                                                self.POWScore   := 100,
                                                self.POWWeight  := 100,
                                                self.ProxScore  := 100,
                                                self.ProxWeight := 100,
                                                self.OrgScore   := 100,
                                                self.OrgWeight  := 100,
                                                self.UltScore   := 100,
                                                self.UltWeight  := 100,
                                                self.SELEscore  := 100,
                                                self.SELEweight := 100,
                                                // self.global_sid := 0  ,
                                                // self.record_sid := 0  ,
                                                // self.locid      := 0  ,
                                                self            := left,
                                                ));
		  
  BIPV2.IDmacros.mac_IndexWithXLinkIDs(infile_hidden_key, k1, superfile_name_hidden);																					
  Export Key_hidden := k1;

	BIPV2.IDmacros.mac_IndexWithXLinkIDs(infile_key, k, superfile_name);	
	export Key      := k;//withOUT ParentAbovSeleField (see comment below)
	export KeyPlus  := BIPV2.IDmacros.mac_AddParentAbovSeleField(Key); //with ParentAbovSeleField
  export keyversions(string pversion = 'qa',boolean pUseOtherEnvironment = false) := tools.macf_FilesIndex('Key',BIPV2_Build.keynames(pversion, pUseOtherEnvironment).linkids); //allow easy access to other versions(logical or super) of key

  //kfetch for CCPA - calls mac_check_access
   export kFetch2(
		 dataset(BIPV2.IDlayouts.l_xlink_ids2)  inputs 
		,string1                                Level                       = BIPV2.IDconstants.Fetch_Level_ProxID	//The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
                                                                                                                //Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
                                                                                                                //Should be enumerated or something?  at least need constants defined somewhere if you keep string1
		,unsigned2                              ScoreThreshold              = 0								                      //Applied at lowest leve of ID
		,BIPV2.mod_sources.iParams              in_mod                      = PROJECT(AutoStandardI.GlobalModule(),BIPV2.mod_sources.iParams,opt)
		,                                       JoinLimit                   = 25000
		,boolean                                dnbFullRemove               = false // optionally clobber all DNB data; by default we apply masking
		,boolean                                bypassContactSuppression    = false // Optionally skip BIPV2_Suppression.mac_contacts - only use this if you are 100% certain you aren't using contact information
		,unsigned1                              JoinType                    = BIPV2.IDconstants.JoinTypes.KeepJoin
        ,boolean                                pApplyMarketingSuppression  = false                                 // Apply marketing suppression?
        ,doxie.IDataAccess mod_access = MODULE (doxie.IDataAccess) END
        ,DATASET(BIPV2.IDlayouts.l_filter_record) dFilter                   = DATASET([],BIPV2.IDlayouts.l_filter_record)   
  ) :=
  function   
        BIPV2.IDmacros.mac_IndexFetch2(inputs, Key, ds_fetched , Level, JoinLimit, JoinType, dFilter);		    
		    
		ds_restricted := ds_fetched(BIPV2.mod_sources.isPermitted(in_mod,not dnbFullRemove).bySource(source,vl_id,dt_first_seen));
		ds_masked     := if(dnbFullRemove, ds_restricted, BIPV2.mod_sources.applyMasking(ds_restricted,in_mod));
    
		BIPV2_Suppression.mac_contacts(ds_masked, ds_suppressed, ds_dirty,,,fname, lname);
		
		//output(ds_dirty, named('ds_dirty'),all); // DEBUG
		// output(ds_fetched, named('ds_fetched'),all); // DEBUG
		// output(dedup(ds_fetched,record,all), named('ds_fetched_dedup'),all); // DEBUG
		ds_final := IF(bypassContactSuppression = TRUE, ds_masked, ds_suppressed);
		
		kFetched := BIPV2.IDmacros.mac_AddParentAbovSeleField(ds_final);		
		/*
			Parent Above Sele is a field derived from fields stored in the index.  it is defined within the macro.
			it was added to the fetch per bug 138559.  it was NOT added to "Key" because not all keyed operations are supported after a transform of the index.  
			"KeyPlus" was added as a helper
		*/																				

          // -- Apply Marketing Suppression -- 
		allowCodeBmap       := BIPV2.mod_Sources.code2bmap(BIPV2.mod_Sources.code.MARKETING_UNRESTRICTED);
		marketingSuppressed := kFetched(BIPV2.mod_sources.src2bmap(source) & allowCodeBmap <> 0);    

          BIPV2.mac_check_access(kFetched, out, mod_access);
          BIPV2.mac_check_access(marketingSuppressed, marketingOut, mod_access);
    
         // return  kFetched;						
         return  if(pApplyMarketingSuppression = true  ,marketingOut  ,out);						
  end;

	//DEPRECATED VERSION OF THE ABOVE KFETCH2
	export kFetch(
		 dataset(BIPV2.IDlayouts.l_xlink_ids )  inputs 
		,string1                                Level                     = BIPV2.IDconstants.Fetch_Level_ProxID	//The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
                                                                                                              //Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
                                                                                                              //Should be enumerated or something?  at least need constants defined somewhere if you keep string1
		,unsigned2                              ScoreThreshold            = 0								                      //Applied at lowest leve of ID
		,BIPV2.mod_sources.iParams              in_mod                    = PROJECT(AutoStandardI.GlobalModule(),BIPV2.mod_sources.iParams,opt)
		,                                       JoinLimit                 = 25000
		,boolean                                dnbFullRemove             = false // optionally clobber all DNB data; by default we apply masking
		,boolean                                bypassContactSuppression  = false // Optionally skip BIPV2_Suppression.mac_contacts - only use this if you are 100% certain you aren't using contact information
		,unsigned1                              JoinType                  = BIPV2.IDconstants.JoinTypes.KeepJoin
          ,doxie.IDataAccess mod_access = MODULE (doxie.IDataAccess) END
		) :=
	FUNCTION

		inputs_for2 := project(inputs, BIPV2.IDlayouts.l_xlink_ids2);
		f2 := kFetch2(inputs_for2, Level, ScoreThreshold, in_mod, JoinLimit, dnbFullRemove, bypassContactSuppression, mod_access := mod_access);		
		return project(f2, {recordof(f2) - UniqueID - Fetch_Error_Code - global_sid - record_sid}); // Need to remove the fields that were added to kFetch2 to ensure the output of kFetch remains the same

	END;


	export kFetchOutRec := recordof(kFetch(dataset([],BIPV2.IDlayouts.l_xlink_ids2)));

  // ------------------------ THOR KEY PULLS ---------------------------
  // -- interface to pull whole key on THOR minus suppressions and masking
  export kFetch2_thor(
     BIPV2.mod_sources.iParams  in_mod                      = PROJECT(AutoStandardI.GlobalModule(),BIPV2.mod_sources.iParams,opt)
    ,boolean                    dnbFullRemove               = false // optionally clobber all DNB data; by default we apply masking
    ,boolean                    bypassContactSuppression    = false // Optionally skip BIPV2_Suppression.mac_contacts - only use this if you are 100% certain you aren't using contact information
    ,boolean                    pApplyMarketingSuppression  = false // Apply Marketing suppression to the key
    ,boolean                    pReturnFullKey              = false // Return the Full Key unrestricted.  Overrides all other suppression parameters
    ,string                     pKeyversion                 = 'qa'  // which version of the key to pull?  makes it easy to test other key versions without sandboxing
    ,doxie.IDataAccess          mod_access                  = MODULE (doxie.IDataAccess) END 
    ,boolean                    pUseOtherEnvironment        = false
  ) :=
  function
    
          ds_fetched    := pull(keyversions(pKeyversion,pUseOtherEnvironment).logical);

          ds_restricted := BIPV2.mod_sources.isPermitted_Thor(in_mod, ds_fetched, not dnbFullRemove);
		ds_masked     := if(dnbFullRemove, ds_restricted, BIPV2.mod_sources.applyMasking(ds_restricted,in_mod));
    
		BIPV2_Suppression.mac_contacts(ds_masked, ds_suppressed, ds_dirty,,,fname, lname);
		
		//output(ds_dirty, named('ds_dirty'),all); // DEBUG
		// output(ds_fetched, named('ds_fetched'),all); // DEBUG
		// output(dedup(ds_fetched,record,all), named('ds_fetched_dedup'),all); // DEBUG
		ds_final := IF(bypassContactSuppression = TRUE, ds_masked, ds_suppressed);
		
		kFetched := BIPV2.IDmacros.mac_AddParentAbovSeleField(ds_final);		
    
		allowCodeBmap       := BIPV2.mod_Sources.code2bmap(BIPV2.mod_Sources.code.MARKETING_UNRESTRICTED);
		marketingSuppressed := kFetched(BIPV2.mod_sources.src2bmap(source) & allowCodeBmap <> 0);    
    
          ds_fetched_out := project(ds_fetched  ,transform(recordof(kFetched),self := left,self := []));

          BIPV2.mac_check_access(kFetched, kFetched_out, mod_access);
          BIPV2.mac_check_access(marketingSuppressed, marketing_Out, mod_access);
          BIPV2.mac_check_access(ds_fetched_out, ds_fetched_out2, mod_access);
    
          return  map(   pReturnFullKey             = true  =>  ds_fetched_out2           
                        ,pApplyMarketingSuppression = true  =>  marketing_out  
                        ,                                       kFetched_out
                     );	

  end;

END;
