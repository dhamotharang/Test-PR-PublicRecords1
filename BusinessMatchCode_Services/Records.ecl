import AutoStandardI,BusinessMatchCode_Services,MDR,STD, BIPV2, TopBusiness_Services,
       Suppress, Doxie;

EXPORT Records( DATASET(BusinessMatchCode_Services.Layouts.Input_Processed) ds_BatchIn,
                BusinessMatchCode_services.iParam.BatchParams               inMod
							) :=
FUNCTION
// disclaimer this is a work in progress.  Used by product to figure out things for future.
//
// General algoritmic flow is :
//
// 1.	Read the filter input values (match code values and score values) 
//    and input search criteria (cname/address etc)
// 2.	Obtain the the bip salt search results based on input 
// 3.	Apply the postfilter on the match_codes results
// 4.	Output results.

mod_access := Project(inMod, Doxie.IDataAccess);

in_mod2 := module(AutoStandardI.DataRestrictionI.params)  
	  export boolean AllowAll := false;
		export boolean AllowDPPA := false;
		export boolean AllowGLB := false;
		export string DataRestrictionMask := inmod.datarestrictionmask;
		export unsigned1 DPPAPurpose := inmod.dppa;
		export unsigned1 GLBPurpose := inmod.glb;
		export boolean ignoreFares := false;
		export boolean ignoreFidelity := false;
		export boolean includeMinors := false;	
	end;
	
	// cap this input param at 5 max.
	maxResultsPerAcctno := if (inmod.MaxResultsPerAcct > 5, 5, inmod.MaxResultsPerAcct);

   InputSearch := PROJECT(ds_BatchIn, TRANSFORM( BIPV2.IDFunctions.rec_SearchInput,                       																	 
			self.zip_radius_miles := IF ((INTEGER)LEFT.mileradius > 10, 10, (UNSIGNED3)LEFT.mileradius); 
			self.company_name := trim(Std.Str.ToUpperCase(LEFT.comp_name), LEFT, RIGHT); // cleaned by linking inside function call.
			self.prim_range :=  trim(Std.Str.ToUpperCase(LEFT.prim_range),  LEFT, RIGHT);
			self.prim_name :=  trim(Std.Str.ToUpperCase(LEFT.prim_name),  LEFT, RIGHT);			
			self.zip5      :=  LEFT.z5;
			self.sec_range := LEFT.sec_range;;
			self.city    := trim(Std.Str.ToUpperCase(LEFT.City_name), LEFT, RIGHT);
			self.state   := std.str.toUpperCase(LEFT.st);
	    self.phone10 := trim(std.str.Filter(LEFT.workphone,'0123456789'),  LEFT, RIGHT);
	    self.fein    := std.str.Filter(LEFT.fein,'0123456789'),
	    self.url     := trim(Std.Str.ToUpperCase(LEFT.URL), LEFT, RIGHT); 
	    self.email   := trim(Std.Str.ToUpperCase(LEFT.email),  LEFT, RIGHT);
			self.contact_fname := trim(Std.Str.ToUpperCase(LEFT.name_first), LEFT, RIGHT);
			self.contact_mname := trim(Std.Str.ToUpperCase(LEFT.name_middle),  LEFT, RIGHT);
			self.contact_lname := trim(Std.Str.ToUpperCase(LEFT.name_last),  LEFT, RIGHT);
			self.sic_Code := LEFT.siccode;
			self.results_limit := 0; // this is the standard default for returning proxid info.
			self.contact_SSN := LEFT.contact_SSN;
			self.contact_did := LEFT.contact_did;
			self.inSeleID := std.str.filter(LEFT.seleid,'0123456789'),		
			self.HSort := TRUE; // always true
			self.acctno := LEFT.acctno;
			self := [];
		));  

	proxidLevelResults := BIPV2.IDfunctions.fn_IndexedSearchForXLinkIDs(InputSearch).SearchKeyData(mod_access);
	
	//
	// takes care of GLB restrictions
	//
	TopBusiness_Services.functions.MAC_IsRestricted(proxidLevelResults, // in DS name
															 proxidLevelResultsRestricted, // out DS name 															
	                             source, // field name
															 vl_id, // field name
															 in_mod2, 
															 FALSE,															 
															 FALSE, // //in_options.internal_testing, default to false for internal_testing
															 dt_first_seen // this is field name only.. no value
															 );
   //  this effectively excludes source = D  (DNB_DMI) for which legally we can't display data															 
   ProxIdLevelResultsRestrictedBySource := proxidLevelResultsRestricted(source <> mdr.sourcetools.src_Dunn_Bradstreet);														 
	 // and same with excluding experian sources.
	 
   // this removes the sources in the set:  BusinessMatchCode_Services.Constants.ExperianRestrictedSources
	 // if the boolean ExcludeExperian is set to true.	 
				
   ProxIdLevelResultsRestrictedBySource2 := ProxIdLevelResultsRestrictedBySource( ~inMod.ExcludeExperian 
	       OR source NOT IN (BusinessMatchCode_Services.Constants.ExperianRestrictedSources));												
					
	// dedup by rcid here due to this...
  //	If a raw record has a p_city_name 'abc' AND a v_city_name 'cba' i.e. with different values
	//  linking duplicates the record and puts 'cba' into p_city_name and 'abc' into v_city_name
	//  keeping other values in the row the same.
  // In SALT this is fine, because all the keys are deduped before they're constructed
		// and this export is based on score results not a key		
	ProxidLevelResultsDedup := SORT(DEDUP(SORT(ProxIdLevelResultsRestrictedBySource2, acctno, rcid),
																																					     acctno, rcid), acctno,-proxweight,-record_score);
 	
	// do suppression of did/ssn masking here
	
	string6 ssnMaskVal := inmod.ssn_mask;
	
	application_type_value := inmod.application_type;
	
	// suppress by ssn
	Suppress.MAC_Suppress(ProxidLevelResultsDedup, 
			  ProxidLevelResultsDedup_pulled,application_type_value,Suppress.Constants.LinkTypes.SSN,contact_SSN);
				
	// suppress by DID 
	Suppress.MAC_Suppress(ProxidLevelResultsDedup_pulled,
		  ProxidLevelResultsDedup_pulled2,application_type_value,Suppress.Constants.LinkTypes.DID,contact_DID);
				
	// mask ssn if needed
	Suppress.MAC_Mask(ProxidLevelResultsDedup_pulled2, ProxidLevelResultsDedup_Suppress, 
	                  contact_SSN, blank, true, false, maskVal := ssnMaskVal);
										
  resultsSetSlimScore := ProxidLevelResultsDedup_Suppress(proxweight >= inMod.InMatchCode_score);

   resultSetSlimMatchcode := resultsSetSlimScore(
                                        match_cnp_Name            >= inMod.InMatchCode_cname
																			 AND match_company_fein        >= inMod.InMatchCode_company_fein
																			 AND match_company_phone       >= inMod.InMatchCode_company_phone
																			 AND match_company_sic_code1   >= inMod.InMatchCode_company_sic_code1
	                                     AND match_st                  >= inMod.InMatchCode_st
																			 AND match_city                >= inMod.InMatchCode_city
	                                     AND match_zip                 >= inMod.InMatchCode_zip5 																			
																			 AND match_prim_range          >= inMod.InMatchCode_prim_range
																			 AND match_prim_name           >= inMod.InMatchCode_prim_name
																			 AND match_sec_range           >= inMod.InMatchCode_sec_range																			
																			 
																			 AND match_contact_DID         >= inMod.InMatchCode_Contact_DID
																			 AND match_Contact_SSN         >= inMod.InMatchCode_Contact_SSN
																			 AND match_Contact_Email       >= inMod.InMatchCode_Contact_email
																			 AND match_fname               >= inMod.InMatchCode_fname
																			 AND match_mname               >= inMod.InMatchCode_mname
																			 AND match_lname               >= inMod.InMatchCode_lname);														
		 																	 		 
  // slim the return to one rec per acctno																	 
	MatchCodeRecs := UNGROUP(TOPN(GROUP(SORT(resultSetSlimMatchcode,acctno, -proxweight, 
	                   -record_score,RECORD),acctno),maxResultsPerAcctno,acctno));										                                																	 
	// project to final return layout
  MatchCodeRecsFinal := PROJECT(matchCodeRecs, 
	                         TRANSFORM(BusinessMatchCode_Services.Layouts.proxidBipSearchFinal, 
													 SELF := LEFT));
	   																	 																													 
//output(proxidLevelResults, named('proxidLevelResults'));
//output(proxidLevelResultsRestricted, named('proxidLevelResultsRestricted'));
//output(count(proxidLevelResults), named('count_proxidLevelResults'));
//output(count(proxidLevelResultsRestricted), named('count_proxidLevelResultsRestricted'));
//output(ProxidLevelResultsDedup, named('ProxidLevelResultsDedup'));
// output(choosen(resultsSetSlimScore,2500), named('resultsSetSlimScore'));
// output(choosen(resultSetSlimMatchcode,1000), named('resultSetSlimMatchcode'));


RETURN(MatchCodeRecsFinal);
END;
