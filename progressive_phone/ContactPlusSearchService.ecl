/*--SOAP--
<message name="ContactPlusSearchService" wuTimeout="300000">
	<part name="DedupePhones" type="tns:XmlDataSet" cols="70" rows="25"/>
	<part name="DPPAPurpose" type="xsd:unsignedInt"/>
	<part name="GLBPurpose" type="xsd:unsignedInt"/>
	<part name="KeepSamePhoneInDiffLevels" type="xsd:boolean"/>
	<part name="DedupAgainstInputPhones" type="xsd:boolean"/>
	<part name="MaxPhoneCount" type="xsd:unsignedInt"/>
	<part name="CountType1_Es_EDASEARCH" type="xsd:unsignedInt"/>
	<part name="CountType2_Se_SKIPTRACESEARCH" type="xsd:unsignedInt"/>
	<part name="CountType3_Ap_PROGRESSIVEADDRESSSEARCH" type="xsd:unsignedInt"/>
	<part name="CountType4_Sp_POSSIBLESPOUSE" type="xsd:unsignedInt"/>
	<part name="CountType4_Md_POSSIBLEPARENTS" type="xsd:unsignedInt"/>
	<part name="CountType4_Cl_CLOSESTRELATIVE" type="xsd:unsignedInt"/>
	<part name="CountType4_Cr_CORESIDENT" type="xsd:unsignedInt"/>
	<part name="CountType5_Sx_EXPANDEDSKIPTRACESEARCH" type="xsd:unsignedInt"/>
	<part name="CountType6_Pp_PHONESPLUSSEARCH" type="xsd:unsignedInt"/>
	<part name="CountType7_UNVERIFIEDPHONE" type="xsd:unsignedInt"/>
	<part name="CountType_Ne_CLOSESTNEIGHBOR" type="xsd:unsignedInt"/>
	<part name="CountType_Wk_PEOPLEATWORK" type="xsd:unsignedInt"/>
	<part name="CountType_Rl_POSSIBLERELOCATION" type="xsd:unsignedInt"/>
	<part name="CountType_TH_TRYHARDER" type="xsd:unsignedInt"/>
	<part name="DynamicOrdering" type="xsd:boolean"/>
	<part name="OrderType1_Es_EDASEARCH" type="xsd:unsignedInt"/>
	<part name="OrderType2_Se_SKIPTRACESEARCH" type="xsd:unsignedInt"/>
	<part name="OrderType3_Ap_PROGRESSIVEADDRESSSEARCH" type="xsd:unsignedInt"/>
	<part name="OrderType4_Sp_POSSIBLESPOUSE" type="xsd:unsignedInt"/>
	<part name="OrderType4_Md_POSSIBLEPARENTS" type="xsd:unsignedInt"/>
	<part name="OrderType4_Cl_CLOSESTRELATIVE" type="xsd:unsignedInt"/>
	<part name="OrderType4_Cr_CORESIDENT" type="xsd:unsignedInt"/>
	<part name="OrderType5_Sx_EXPANDEDSKIPTRACESEARCH" type="xsd:unsignedInt"/>
	<part name="OrderType6_Pp_PHONESPLUSSEARCH" type="xsd:unsignedInt"/>
	<part name="OrderType7_UNVERIFIEDPHONE" type="xsd:unsignedInt"/>
	<part name="OrderType_Ne_CLOSESTNEIGHBOR" type="xsd:unsignedInt"/>
	<part name="OrderType_Wk_PEOPLEATWORK" type="xsd:unsignedInt"/>
	<part name="OrderType_Rl_POSSIBLERELOCATION" type="xsd:unsignedInt"/>
	<part name="OrderType_TH_TRYHARDER" type="xsd:unsignedInt"/>
	<part name="IncludeBusinessPhone" type="xsd:boolean"/>
	<part name="IncludeLandlordPhone" type="xsd:boolean"/>
 	<part name="IncludeRelativeCellPhones" type="xsd:boolean"/>
	<part name="IncludeLastResort" type="xsd:boolean"/>
	<part name="IncludePhonesFeedback" type="xsd:boolean"/>
	<part name="IncludeAddressFeedback" type="xsd:boolean"/>
 	<part name="UniqueIDConfidenceTreshold" type="xsd:unsignedInt"/>
	<part name="ExcludeNonCellPhonesPlusData" type="xsd:boolean"/>
	<part name="ExcludeDeadContacts" type="xsd:boolean"/>
	<part name="StrictAPSXMatch" type="xsd:boolean"/>
	<part name="DID" type="xsd:string"/>
	<part name="email" type="xsd:string"/>
  <part name="DataPermissionMask" type="xsd:string"/>
  <part name="DataRestrictionMask" type="xsd:string" default="00000000000"/>
  <part name="ReturnScore" type="xsd:boolean"/>
  <part name="UseMetronet" type="xsd:boolean"/>
  <part name="Confirmation_GoToGateway" type="xsd:boolean"/>
  <part name="MetronetLimit" type="xds:integer"/>
  <part name="UsePremiumSource_A" type="xsd:boolean"/>
  <part name="PremiumSource_A_limit" type="xds:integer"/>
	<part name="Gateways" type="tns:XmlDataSet" cols="110" rows="10"/>
  <part name="Phone_Score_Model" type="xsd:string"/>
  <part name="MaxNumAssociate" type="xsd:unsignedInt"/>
	<part name="MaxNumAssociateOther" type="xsd:unsignedInt"/>
  <part name="MaxNumFamilyOther" type="xsd:unsignedInt"/>
	<part name="MaxNumFamilyClose" type="xsd:unsignedInt"/>
  <part name="MaxNumParent" type="xsd:unsignedInt"/>
  <part name="MaxNumSpouse" type="xsd:unsignedInt"/>
  <part name="MaxNumSubject" type="xsd:unsignedInt"/>
  <part name="MaxNumNeighbor" type="xsd:unsignedInt"/>
  <part name="ContactPlusSearchRequest" type="tns:XmlDataSet" cols="80" rows="30" />
	</message>
*/
/*--INFO-- This service returns progressive phones with feedback.*/

IMPORT progressive_phone, addrbest,iesp,PhonesFeedback_Services,ut,
				doxie,PersonSearch_Services, AutoStandardi,EmailService,Suppress, Royalty;

EXPORT ContactPlusSearchService := MACRO
  #CONSTANT('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.LEGACY);
    #constant('IncludeFraudDefenseNetwork',false)
		rec_in := iesp.contactplus.t_ContactPlusSearchRequest;
    ds_in := DATASET ([], rec_in) : STORED ('ContactPlusSearchRequest', FEW);
		first_row := ds_in[1] : independent;
    //set options
		search_by := global (first_row.SearchBy);
		iesp.ECL2ESP.SetInputBaseRequest (first_row);
		iesp.ECL2ESP.Marshall.Mac_Set (first_row.options);
		iesp.ECL2ESP.SetInputName (search_by.Name);
    iesp.ECL2ESP.SetInputAddress (search_by.Address);
  	#stored ('SSN',search_by.SSN);
  	#stored ('Phone',search_by.Phone10);

    #stored('DID', search_by.UniqueId);
    #stored('EMAIL', search_by.email);
		#stored('DedupePhones', search_by.DedupeInfo.phones );
		#stored('ExcludeDeadContacts', ~first_row.options.IncludeDeadContacts );
		#stored('DedupAgainstInputPhones', first_row.options.DedupeAgainstInputPhones );
		#stored('KeepSamePhoneInDiffLevels', first_row.options.KeepSamePhoneInDiffLevels );
	
		#stored('IncludePhonesFeedback', first_row.options.IncludePhonesFeedback );
		#stored('IncludeAddressFeedback', first_row.options.IncludeAddressFeedback );
		#stored('IncludeLastResort', first_row.options.IncludeLastResort );
		#stored('UniqueIDConfidenceTreshold', first_row.options.UniqueIDConfidenceTreshold );
		#stored('BlankOutDuplicatePhones', first_row.options.BlankOutDuplicatePhones );
		#stored('MaxPhoneCount', first_row.options.MaxPhoneCount );
		#stored('CountType1_ES_EDASEARCH', first_row.options.EDACount );
		#stored('CountType2_SE_SKIPTRACESEARCH', first_row.options.SkipTraceCount );
		#stored('CountType3_AP_PROGRESSIVEADDRESSSEARCH', first_row.options.ProgressiveAddressCount );
		#stored('CountType4_SP_POSSIBLESPOUSE', first_row.options.SpouseCount );
		#stored('CountType4_MD_POSSIBLEPARENTS', first_row.options.ParentsCount );
		#stored('CountType4_CL_CLOSESTRELATIVE', first_row.options.ClosestRelativesCount );
		#stored('CountType4_CR_CORESIDENT', first_row.options.CoResidentCount );
		#stored('CountType5_SX_EXPANDEDSKIPTRACESEARCH', first_row.options.ExpandedSkipTraceCount );
		#stored('CountType6_PP_PHONESPLUSSEARCH', first_row.options.PhonesPlusCount);
		#stored('CountType7_UNVERIFIEDPHONE', first_row.options.UnverifiedCount );
		#stored('CountType_NE_CLOSESTNEIGHBOR', first_row.options.ClosestNeighborCount );
		#stored('CountType_WK_PEOPLEATWORK', first_row.options.PAWCount );
		#stored('CountType_RL_POSSIBLERELOCATION', first_row.options.PossibleRelocationCount );
		#stored('CountType_TH_TRYHARDER', first_row.options.TypeThTryHarderCount);
		#stored('DynamicOrdering', first_row.options.DynamicOrdering );
		#stored('OrderType1_ES_EDASEARCH', first_row.options.EDAOrder );
		#stored('OrderType2_SE_SKIPTRACESEARCH', first_row.options.SkipTraceOrder );
		#stored('OrderType3_AP_PROGRESSIVEADDRESSSEARCH', first_row.options.ProgressiveAddressOrder );
		#stored('OrderType4_SP_POSSIBLESPOUSE', first_row.options.SpouseOrder );
		#stored('OrderType4_MD_POSSIBLEPARENTS', first_row.options.ParentsOrder );
		#stored('OrderType4_CL_CLOSESTRELATIVE', first_row.options.ClosestRelativesOrder );
		#stored('OrderType4_CR_CORESIDENT', first_row.options.CoResidentOrder );
		#stored('OrderType5_SX_EXPANDEDSKIPTRACESEARCH', first_row.options.ExpandedSkipTraceOrder );
		#stored('OrderType6_PP_PHONESPLUSSEARCH', first_row.options.PhonesPlusOrder );
		#stored('OrderType7_UNVERIFIEDPHONE', first_row.options.UnverifiedOrder );
		#stored('OrderType_NE_CLOSESTNEIGHBOR', first_row.options.ClosestNeighborOrder );
		#stored('OrderType_WK_PEOPLEATWORK', first_row.options.PAWOrder );
		#stored('OrderType_RL_POSSIBLERELOCATION', first_row.options.PossibleRelocationOrder);
		#stored('OrderType_TH_TRYHARDER', first_row.options.TypeThTryHarderOrder);
				
		#stored('IncludeBusinessPhone', first_row.options.IncludeBusinessPhone );
		#stored('IncludeLandlordPhone', first_row.options.IncludeLandlordPhone );

		#stored('ExcludeNonCellPhonesPlusData', ~first_row.options.IncludeNonCellPhonesPlusData );
		#stored('StrictAPSXMatch', first_row.options.StrictAPSXMatch );
		#stored('ReturnScore', first_row.options.ReturnScore );
				
		#stored('UsePremiumSource_A', first_row.options.UsePremiumSourceA );
		#stored('PremiumSource_A_limit', first_row.options.PremiumSourceLimitA );
		
		#stored('SkipPhoneScoring', first_row.options.SkipPhoneScoring );
		#stored('Phone_Score_Model', first_row.options.ScoreModel);
    #stored('IncludeHRI',true);
		
		#stored('MaxNumAssociate', first_row.options.MaxNumAssociate);
		#stored('MaxNumAssociateOther', first_row.options.MaxNumAssociateOther);
		#stored('MaxNumFamilyOther', first_row.options.MaxNumFamilyOther);
		#stored('MaxNumFamilyClose', first_row.options.MaxNumFamilyClose);
		#stored('MaxNumParent', first_row.options.MaxNumParent);
		#stored('MaxNumSpouse', first_row.options.MaxNumSpouse);
		#stored('MaxNumSubject', first_row.options.MaxNumSubject);
		#stored('MaxNumNeighbor', first_row.options.MaxNumNeighbor);		
		
		boolean IncludePhonesFeedback := true : STORED('IncludePhonesFeedback');
		boolean IncludeAddressFeedback := false : STORED('IncludeAddressFeedback');
		boolean SkipPhonesScoring := false : STORED('SkipPhoneScoring');
		boolean ShowPhoneScore := false : STORED('ReturnScore');
		
		boolean IncludeLastResort := false : STORED('IncludeLastResort');
	 boolean ReturnAddressesSeenInLast24Mos := first_row.options.ReturnAddressesSeenInLast24Mos;

		
		boolean UsePremiumSource_A:= false : STORED ('UsePremiumSource_A'); //equifax
		integer PremiumSource_A_limit:= 0 : STORED ('PremiumSource_A_limit');

		STRING25 scoreModel		 				:= '' 	: STORED('Phone_Score_Model');
		
		UNSIGNED2 MaxNumAssociate := 0 : STORED('MaxNumAssociate');
		UNSIGNED2 MaxNumAssociateOther  := 0 : STORED('MaxNumAssociateOther');
		UNSIGNED2 MaxNumFamilyOther := 0 : STORED('MaxNumFamilyOther');
		UNSIGNED2 MaxNumFamilyClose := 0 : STORED('MaxNumFamilyClose');
		UNSIGNED2 MaxNumParent := 0 : STORED('MaxNumParent');
		UNSIGNED2 MaxNumSpouse := 0 : STORED('MaxNumSpouse');
		UNSIGNED2 MaxNumSubject := 0 : STORED('MaxNumSubject');
		UNSIGNED2 MaxNumNeighbor := 0: STORED('MaxNumNeighbor');
		
	
		Gateways := Gateway.Configuration.Get();
	
		g_mod := AutoStandardI.GlobalModule();
		
// stlf RQ-12930 - check the lines below that use this new attribute
		BOOLEAN isGLB_Ok := ut.glb_ok(g_mod.glbpurpose);
		
		app_type := AutoStandardI.InterfaceTranslator.application_type_val.val(project(g_mod,AutoStandardI.InterfaceTranslator.application_type_val.params));
		
		f_dedup_phones := IF(EXISTS(search_by.DedupeInfo.phones),search_by.DedupeInfo.phones,DATASET([],iesp.share.t_StringArrayItem));
		
		em_mod := module(project(g_mod,EmailService.EmailSearch.params,opt))
			export PenaltThreshold := g_mod.penalty_threshold;
			string120	email_raw0 := '' :stored('email');
			string120 email_raw := if(stringlib.stringfind(email_raw0,'@',1) = 0,
									trim(email_raw0) + '@',email_raw0);
			export email := trim(stringlib.stringtouppercase(email_raw),all);	
			export useGlobalScope := false;
			export mult_results := false;
			export string32 applicationType	:= app_type;
		end;
		email_dids := EmailService.EmailSearchService_IDs.val(em_mod).by_email_val;
		dids_fetched:= PROJECT (doxie.Get_Dids(), doxie.layout_references); // use pii to get dids		
  	best_pen_rec := record(doxie.layout_best)
	  	unsigned pen;
	  end;
	  
	  doxie.mac_best_records(dids_fetched, did, ds_phone_match, ut.dppa_ok(g_mod.DPPApurpose), isGLB_Ok, false, doxie.DataRestriction.fixed_DRM)	
	  best_pen_rec bp_tran(ds_phone_match l) := transform
	    self := l;
		  self.pen := 	doxie.FN_Tra_Penalty(l.fname,l.mname,l.lname,
                             '',(string)l.dob,'',
                             '','','','','','',
                              l.city_name,'',l.st,l.zip,
                              l.phone, allow_wildcard:=false);
	  end;
	  p_ds := project(ds_phone_match,bp_tran(left));
	  // if the phone number was provided and there was a name provided, then we are filtering down with hopes of getting just one did
  	pii_dids :=  if ( count(dids_fetched) > 1 and g_mod.phone <> '' and
										(g_mod.lastname<>'' or g_mod.firstName <>'') and
										(g_mod.addr = '' and g_mod.ssn = '' ),
										project(p_ds(pen < 10),doxie.layout_references),
										dids_fetched);
										
		total_dids := if (g_mod.did <> '' ,
											dataset([{g_mod.did}],doxie.layout_references),
											dedup(pii_dids + project(email_dids,doxie.layout_references),did,all));
		IF(count(total_dids) > 1,FAIL(203,doxie.ErrorCodes(203)));
		
		f_in_raw := project(total_dids,transform(progressive_phone.layout_progressive_batch_in,
											self.did := left.did,
											self := [])); 
    d := project(total_dids,doxie.layout_references_hh);
  	headerRecs := doxie.header_records_byDID(d, true,g_mod.allowwildcard, isrollup := true);
    rids := DEDUP(SORT(PROJECT(headerRecs,TRANSFORM(doxie.Layout_ref_rid,SELF:=LEFT)),rid),rid);
		presRecs_ready := PROJECT(headerRecs, doxie.layout_presentation);
		ta1_tmp := doxie.rollup_presentation(presRecs_ready)[1].Results;
		Suppress.MAC_Suppress(ta1_tmp,ta1_tmp_pulled,g_mod.applicationtype,Suppress.Constants.LinkTypes.DID,did,'','',false,'');

		iesp.contactplus.t_ContactPlusSource tran_sources(Doxie_Raw.Occurrence.l_ref L) := transform
			// 1.3.10	Requirement - ONLY 'Locator', 'Death' and 'Utility' sources
			//  Note: This is now filtered inside progressive_phone.SourceSummary below.
			self.Source:=L.src;
			self.Occurrences:=L.occurrences;
			self.DateFirstSeen:=iesp.ECL2ESP.toDate(L.dt_first_seen);
			self.DateLastSeen:=iesp.ECL2ESP.toDate(L.dt_last_seen);
		end;

		iesp.contactplus.t_ContactPlusSourceSummary tran_source(doxie_raw.occurrence.l_out L) := transform
			self.Name:=L.datum,
			self.Sources:=PROJECT(L.sources,tran_sources(left)),
			self.SourceCount:=COUNT(self.Sources);
		end;

		occurrences := progressive_phone.SourceSummary(rids,g_mod.DPPApurpose,g_mod.GLBpurpose,Gateways);
		loc_sources := choosen(project(occurrences,tran_source(left)),iesp.Constants.Contact_Plus.MaxCountSources);

		iesp.contactPlus.t_ContactPlusSearchRecord trans_hfr(ta1_tmp_pulled l) := transform
			iesp.share.t_NameWithGender tran_name(recordof(l.namerecs) lna) := transform
				self := iesp.ECL2ESP.setName(lna.fname, lna.mname, lna.lname, lna.name_suffix, lna.title);
				self.Gender := PersonSearch_Services.Functions.gender(lna.fname,lna.title);
			end;
			iesp.contactPlus.t_ContactPlusDOB tran_dob(recordof(l.dobrecs) ld) := transform
				self := iesp.ECL2ESP.toDate(ld.dob);
				self.age := ld.age;
			end;
			iesp.contactPlus.t_ContactPlusDOD tran_dod(recordof(l.dodrecs) ld) := transform
				self := iesp.ECL2ESP.toDate(ld.dod);
				self.deadage := ld.dead_age;
				self.deceased := ld.deceased;
				self.IsLimitedAccessDMF := ld.IsLimitedAccessDMF;
			end;
			
			iesp.contactplus.t_ContactPlusAddress tran_addr(progressive_phone.layout_addr_connect_date la) := transform
				 self := iesp.ECL2ESP.SetAddressEx(la.prim_name, la.prim_range, la.predir, la.postdir,
						 la.suffix, la.unit_desig, la.sec_range, la.city_name,
						 la.st, la.zip, la.zip4, la.county_name, 
						 HRIs := project(la.hri_address,transform(iesp.share.t_RiskIndicator,self.riskcode:=left.hri,self.description:=left.desc)));
						 
				 self.dateFirstSeen := iesp.ECL2ESP.toDateYM (la.first_seen);
				 self.dateLastSeen := iesp.ECL2ESP.toDateYM (la.last_seen);
				 self.UtilityConnectDate := iesp.ECL2ESP.toDate (la.connect_date);
				 self.UtilityType := la.util_type;
				 self.AddressFeedback.FeedbackCount := la.address_feedback[1].feedback_count;
				 self.AddressFeedback.LastFeedbackResult := la.address_feedback[1].Last_Feedback_Result;
				 self.AddressFeedback.LastFeedbackResultProvided := (string8) la.address_feedback[1].Last_Feedback_Result_Provided;
				 self.IsCurrent := la.tnt in iesp.Constants.TNT_CURRENT_SET;

			end;

			self.names := choosen(project(l.namerecs,tran_name(left)),iesp.Constants.Contact_Plus.MaxCountNameRecords);
			self.dobs := choosen(project(l.dobrecs,tran_dob(left)),iesp.Constants.Contact_Plus.MaxCountDobRecords);
			self.dods := choosen(project(l.dodrecs,tran_dod(left)),iesp.Constants.Contact_Plus.MaxCountDODRecords);
      addrsWithConnectDate := progressive_phone.UtilityConnect((unsigned)l.did,l.addrrecs, isGLB_Ok);
			addrsFiltered := choosen(addrsWithConnectDate((~ReturnAddressesSeenInLast24Mos) or ut.daysApart(ut.GetDate,(string8)(last_seen * 100)) < ut.DaysInNYears(2)),
															 iesp.Constants.Contact_Plus.MaxCountAddressRecords);
					
			AddressFeedback_Services.MAC_Append_Feedback(addrsFiltered,
																									 addrsFilteredWithFeedback,
																									 Address_Feedback);										
			
			self.addresses := project(if(IncludeAddressFeedback, addrsFilteredWithFeedback, addrsFiltered), tran_addr(left));
			self.ssns := choosen(project(l.ssnrecs,transform(iesp.share.t_StringArrayItem,self.value:=left.ssn)),iesp.Constants.Contact_Plus.MaxCountSSNRecords);

			self.alsoFound.Properties := l.prop_count ;
			self.alsoFound.Vehicles := l.veh_cnt ;
			self.alsoFound.ProfessionalLicenses := l.prof_count ;
			self.alsoFound.CorporateAffiliations := l.corp_affil_count ;
			self.alsoFound.Emails := l.email_count ;
			self.alsoFound.Accidents := l.accident_count ;
			self.alsoFound.DriverLicenses := l.dl_cnt ;
			self.alsoFound.Headers := l.head_cnt ;
			self.alsoFound.Criminals := l.crim_cnt ;
			self.alsoFound.SexualOffenses := l.sex_cnt ;
			self.alsoFound.ConcealedWeapons := l.ccw_cnt ;
			self.alsoFound.Relatives := l.rel_count ;
			self.alsoFound.Firearms := l.fire_count ;
			self.alsoFound.FAAPilots := l.faa_count ;
			self.alsoFound.MerchantVessels := l.vess_count ;
			self.alsoFound.Businesses := l.bus_count ;
			self.alsoFound.PeopleAtWork := l.paw_count ;
			self.alsoFound.BusinessContact := l.bc_count ;
			self.alsoFound.PropertyAssessment := l.prop_asses_count ;
			self.alsoFound.PropertyDeeds := l.prop_deeds_count ;
			self.alsoFound.Bankruptcies := l.bk_count ;
			self.alsoFound.CurrentlyOwnedProperties := l.comp_prop_count ;
			self.uniqueId := (string)l.did;
			self.sources := loc_sources;
		end;
		
		contactPlus := project(ta1_tmp_pulled,trans_hfr(left));
		
		f_out := PROJECT(UNGROUP(addrbest.Progressive_phone_common(	f_in_raw,																								 
																																,
																																f_dedup_phones,
																																Gateways,
																																,
																																,
																																,
																																,
																																scoreModel,
																																MaxNumAssociate,
																																MaxNumAssociateOther,
																																MaxNumFamilyOther,
																																MaxNumFamilyClose,
																																MaxNumParent,
																																MaxNumSpouse,
																																MaxNumSubject,
																																MaxNumNeighbor,
																																UsePremiumSource_A,
																																PremiumSource_A_limit)), progressive_phone.layout_progressive_online_out);
		
		//mainly to filter out results for CP_V3 to ensure that we track EQX and LR royalties on the final output only unlike metronet
		v_enum       := progressive_phone.Constants.Running_Version;
		version      := progressive_phone.HelperFunctions.FN_GetVersion(scoreModel, UsePremiumSource_A);
		tempresults1 := if(version = v_enum.CP_V3, ungroup(progressive_phone.HelperFunctions.FN_FilterPerScore(f_out)), f_out);
		
		Royalty.MAC_RoyaltyLastResort(tempresults1, lastresort_royalties, vendor, subj_phone10);
				
		Royalty.RoyaltyEFXDataMart.MAC_GetWebRoyalties(tempresults1, equifax_royalties, subj_phone_type_new, MDR.sourceTools.src_EQUIFAX);
		
		royalties := lastresort_royalties + equifax_royalties;
		output(royalties,named('RoyaltySet'));
		
		PhonesFeedback_Services.Mac_Append_Feedback(tempresults1,did,subj_phone10,f_out_w_fb);
 	  rslt := if(IncludePhonesFeedback,f_out_w_fb,tempresults1);
    ut.getTimeZone(rslt,subj_phone10,timeZone,finalout);
		// If we are skipping the phone scoring model sort by sort order, else sort by the phone score returned from the model
		sort_rslt := MAP(scoreModel <> '' => finalout,
										 SkipPhonesScoring => sort(finalout,sort_order,sort_order_internal), 
									   sort(finalout, -phone_score));

	  tempresults2 := iesp.transform_progressive_phones(sort_rslt, ShowPhoneScore, scoreModel, UsePremiumSource_A);
 
    iesp.ECL2ESP.Marshall.MAC_Marshall_Results(tempresults2, Results, iesp.contactPlus.t_ContactPlusSearchResponse, Records, false,,ContactPlus,contactPlus[1]);
		//output('WithNewPLSources');
		// output(presRecs_ready, named('presRecs_ready'));
		// output(ta1_tmp, named('ta1_tmp'));

		output(Results,named('Results'));
ENDMACRO;
// progressive_phone.ContactPlusSearchService();