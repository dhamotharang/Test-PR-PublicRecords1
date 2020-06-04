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
		infile_rec - global_sid        - record_sid            - employee_count_org_raw   - employee_count_org_derived
		           - revenue_org_raw   - revenue_org_derived   - employee_count_local_raw - employee_count_local_derived 
							 - revenue_local_raw - revenue_local_derived - locid;
		BIPV2.IDlayouts.l_xlink_ids.DotScore;
		BIPV2.IDlayouts.l_xlink_ids.DotWeight;
		BIPV2.IDlayouts.l_xlink_ids.EmpScore;
		BIPV2.IDlayouts.l_xlink_ids.EmpWeight;
		BIPV2.IDlayouts.l_xlink_ids.POWScore;
		BIPV2.IDlayouts.l_xlink_ids.POWWeight;
		BIPV2.IDlayouts.l_xlink_ids.ProxScore;
		BIPV2.IDlayouts.l_xlink_ids.ProxWeight;
		BIPV2.IDlayouts.l_xlink_ids.OrgScore;
		BIPV2.IDlayouts.l_xlink_ids.OrgWeight;
		BIPV2.IDlayouts.l_xlink_ids.UltScore;
		BIPV2.IDlayouts.l_xlink_ids.UltWeight;
    unsigned4 global_sid;
    unsigned8 record_sid;
		unsigned6 locid;
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
  ) :=
  function   
		BIPV2.IDmacros.mac_IndexFetch2     (inputs, Key, ds_fetched , Level, JoinLimit, JoinType);
		    
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
    ,doxie.IDataAccess mod_access = MODULE (doxie.IDataAccess) END 
  ) :=
  function
    
          ds_fetched    := pull(keyversions(pKeyversion).logical);

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
