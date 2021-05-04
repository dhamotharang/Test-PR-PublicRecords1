#OPTION('multiplePersistInstances',FALSE);
#OPTION('remoteKeyedLookup', FALSE);

IMPORT ut,LN_PropertyV2,LN_PropertyV2_Fast,PropertyScrubs, nid,ln_propertyv2_addressenhancements, InsuranceHeader_Property_Transactions_DeedsMortgages, PromoteSupers, STD, codes, LocationID_xLink;

//combine, clean and enrich
EXPORT proc3Enhance( string versionDate, boolean isFast = FALSE, string8 forceDeltaStartDate = '' ) := FUNCTION
	
	// Determine start process_date for delta
	
	startProcessDate := if (isFast,
													if(forceDeltaStartDate <> '',
														 forceDeltaStartDate,
// To implement true delta (Jira DF-11862) get max process_date from base fast plus full base, not just full base.
													 MAX(MAX(LN_PropertyV2.File_Assessment+LN_PropertyV2_fast.files.base.assessment,process_date), 
															 MAX(LN_PropertyV2.File_deed+LN_PropertyV2_fast.files.base.deed_mortg,process_date))
//													   MAX(MAX(LN_PropertyV2.File_Assessment,process_date), MAX(LN_PropertyV2.File_deed,process_date))
														 ),
													'');

	// LOAD ALL NEW PREP FILES
	prepAssessment := if(isFast,LN_PropertyV2_Fast.Files.prep.assessment(process_date>startProcessDate),
															LN_PropertyV2_Fast.Files.prep.assessment(process_date<=versionDate[1..8])); //(Jira DF-18820)
	prepDeedMortga := if(isFast,LN_PropertyV2_Fast.Files.prep.deed_mortg(process_date>startProcessDate),
															LN_PropertyV2_Fast.Files.prep.deed_mortg(process_date<=versionDate[1..8])); //(Jira DF-18820)
	prepSearchProp := if(isFast,LN_PropertyV2_Fast.Files.prep.search_prp(process_date>startProcessDate),
															LN_PropertyV2_Fast.Files.prep.search_prp(process_date<=versionDate[1..8])); //(Jira DF-18820)

	ln_fares_ids_a := table(prepAssessment,{ln_fares_id});
	ln_fares_ids_d := table(prepDeedMortga,{ln_fares_id});
	ln_fares_ids 	 := distribute(ln_fares_ids_a + ln_fares_ids_d,hash32(ln_fares_id));
		
	prepFrsAddlAst := if(isFast,JOIN(distribute(LN_PropertyV2_Fast.Files.prep.addl_frs_a,hash32(ln_fares_id)),distribute(ln_fares_ids_a,hash32(ln_fares_id)), LEFT.ln_fares_id = RIGHT.ln_fares_id, TRANSFORM(LEFT),local)	,
															     LN_PropertyV2_Fast.Files.prep.addl_frs_a);
	prepFrsAddlDdM := if(isFast,JOIN(distribute(LN_PropertyV2_Fast.Files.prep.addl_frs_d,hash32(ln_fares_id)),distribute(ln_fares_ids_d,hash32(ln_fares_id)), LEFT.ln_fares_id = RIGHT.ln_fares_id, TRANSFORM(LEFT),local),
																	 LN_PropertyV2_Fast.Files.prep.addl_frs_d);
		
	prepAddlLegal  := if(isFast,JOIN(distribute(LN_PropertyV2_Fast.Files.prep.addl_legal,hash32(ln_fares_id)),ln_fares_ids, LEFT.ln_fares_id = RIGHT.ln_fares_id, TRANSFORM(LEFT),local),
                                   LN_PropertyV2_Fast.Files.prep.addl_legal);
	prepAddlNames  := if(isFast,JOIN(distribute(LN_PropertyV2_Fast.Files.prep.addl_names,hash32(ln_fares_id)),ln_fares_ids, LEFT.ln_fares_id = RIGHT.ln_fares_id, TRANSFORM(LEFT),local),
                                   LN_PropertyV2_Fast.Files.prep.addl_names);
	prepAddlNameInfo  := if(isFast,JOIN(distribute(LN_PropertyV2_Fast.Files.prep.addl_name_info,hash32(ln_fares_id)),ln_fares_ids, LEFT.ln_fares_id = RIGHT.ln_fares_id, TRANSFORM(LEFT),local),
                                   LN_PropertyV2_Fast.Files.prep.addl_name_info);
	
// *** BELOW code will drop when we retire old "in files"	*** // ****************************************************//
	// LOAD OKC OLD "IN" FILES
	
	oldOkcAssmntNd:= if(isFast,LN_PropertyV2_Fast.Files.oldIn.LNAssessment(process_date>startProcessDate),
														 LN_PropertyV2_Fast.Files.oldIn.LNAssessment)(~(regexfind('^[Pp][1-9]$',new_record_type_code)));//bug 169557
	oldOkcAssmntN := dedup(distribute(oldOkcAssmntNd),all,local); // Jira DF-18076
	oldOkcAssmntR	:= if(isFast,LN_PropertyV2_Fast.Files.oldIn.LNAssessmentRepl(process_date>startProcessDate),
														 LN_PropertyV2_Fast.Files.oldIn.LNAssessmentRepl)(~(regexfind('^[Pp][1-9]$',new_record_type_code)));//bug 169557
	oldOkcDeedMrN1:= if(isFast,LN_PropertyV2_Fast.Files.oldIn.LNDeed(process_date>startProcessDate),
														 LN_PropertyV2_Fast.Files.oldIn.LNDeed);
	oldOkcDeedMrN2:= dedup(distribute(oldOkcDeedMrN1),all,local); // Jira DF-18076
	oldOkcDeedMrN := dedup(distribute(oldOkcDeedMrN2,hash(ln_fares_id)),ln_fares_id,local); // Jira DF-18076
	oldOkcDeedMrR	:= if(isFast,LN_PropertyV2_Fast.Files.oldIn.LNDeedRepl(process_date>startProcessDate),
														 LN_PropertyV2_Fast.Files.oldIn.LNDeedRepl);

	old_ln_fares_ids_a := table(oldOkcAssmntN+oldOkcAssmntR,{ln_fares_id}) ;
	old_ln_fares_ids_d := table(oldOkcDeedMrN+oldOkcDeedMrR,{ln_fares_id});
	old_ln_fares_ids 	 := distribute(old_ln_fares_ids_a + old_ln_fares_ids_d,hash32(ln_fares_id));
														 
														 
	oldAddlNamesN := if(isFast,JOIN(distribute(LN_PropertyV2_Fast.Files.oldIn.LNAddlNames,hash32(ln_fares_id)),old_ln_fares_ids, LEFT.ln_fares_id = RIGHT.ln_fares_id, TRANSFORM(LEFT),local),
                                  LN_PropertyV2_Fast.Files.oldIn.LNAddlNames);
	oldAddlNamesR := if(isFast,JOIN(distribute(LN_PropertyV2_Fast.Files.oldIn.LNAddlNamesRepl,hash32(ln_fares_id)),old_ln_fares_ids, LEFT.ln_fares_id = RIGHT.ln_fares_id, TRANSFORM(LEFT),local),
                                  LN_PropertyV2_Fast.Files.oldIn.LNAddlNamesRepl);								
	oldAddlLegalN	:= if(isFast,JOIN(distribute(LN_PropertyV2_Fast.Files.oldIn.LNAddlLegal,hash32(ln_fares_id)),old_ln_fares_ids, LEFT.ln_fares_id = RIGHT.ln_fares_id, TRANSFORM(LEFT),local),
                                  LN_PropertyV2_Fast.Files.oldIn.LNAddlLegal);
	oldAddlLegalR := if(isFast,JOIN(distribute(LN_PropertyV2_Fast.Files.oldIn.LNAddlLegalRepl,hash32(ln_fares_id)),old_ln_fares_ids, LEFT.ln_fares_id = RIGHT.ln_fares_id, TRANSFORM(LEFT),local),
                                  LN_PropertyV2_Fast.Files.oldIn.LNAddlLegalRepl);	
	//oldOkcSearchN	:= if(isFast,JOIN(distribute(LN_PropertyV2_Fast.Files.oldIn.LNSearch,hash32(ln_fares_id)),old_ln_fares_ids, LEFT.ln_fares_id = RIGHT.ln_fares_id, TRANSFORM(LEFT),local),
  //                                LN_PropertyV2_Fast.Files.oldIn.LNSearch);
	//oldOkcSearchR	:= if(isFast,JOIN(distribute(LN_PropertyV2_Fast.Files.oldIn.LNSearchRepl,hash32(ln_fares_id)),old_ln_fares_ids, LEFT.ln_fares_id = RIGHT.ln_fares_id, TRANSFORM(LEFT),local),
  //                                LN_PropertyV2_Fast.Files.oldIn.LNSearchRepl);
	
	// replace okc records if applicable
	oldOkcAssmnt  := LN_PropertyV2_Fast.replace_LN_AssessorDeeds.replace_assessor(oldOkcAssmntR,oldOkcAssmntN);
	oldOkcDeedMr	:= LN_PropertyV2_fast.replace_LN_AssessorDeeds.replace_deeds(oldOkcDeedMrR,oldOkcDeedMrN);
	oldAddlNames  := LN_PropertyV2_Fast.replace_LN_searchAddlnames.Replace_Addl_Names(
				 oldAddlNamesR,oldAddlNamesN,oldOkcDeedMr,oldOkcAssmnt);
	oldAddlLegal  := LN_PropertyV2_Fast.replace_LN_searchAddlnames.Replace_Addl_Legal(
				 oldAddlLegalR,oldAddlLegalN,oldOkcDeedMr,oldOkcAssmnt);
	//oldOkcSearch	:= LN_PropertyV2_Fast.replace_LN_searchAddlnames.Replace_Search(
	//			 oldOkcSearchR,oldOkcSearchN,oldOkcDeedMr,oldOkcAssmnt);
	
	// LOAD FARES OLD "IN" FILES
	aFrA := if(isFast,		 LN_PropertyV2.File_Fares_assessor_in(process_date>startProcessDate),
												 LN_PropertyV2.File_Fares_assessor_in(process_date<=versionDate)); //(Jira DF-18820)
	aFrD := if(isFast,		 LN_PropertyV2.File_Fares_deeds_in(process_date>startProcessDate),
												 LN_PropertyV2.File_Fares_deeds_in(process_date<=versionDate)); //(Jira DF-18820)

  ln_fares_idf_a := table(aFrA,{fares_id});
	ln_fares_idf_d := table(aFrD,{fares_id});
	ln_fares_idf 	 := distribute(ln_fares_idf_a + ln_fares_idf_d,hash32(fares_id));
													 												 
	oFrS := if(isFast,JOIN(distribute(LN_PropertyV2.File_Fares_Search_in,hash32(ln_fares_id)),ln_fares_idf, LEFT.ln_fares_id[2..] = RIGHT.fares_id[2..], TRANSFORM(LEFT),local),
												 LN_PropertyV2.File_Fares_Search_in);

	// Fix old layouts
	LN_PropertyV2_Fast.Layout_Fares_Deeds mapOldFrsDeed(aFrD L) := TRANSFORM
	  SELF.ln_buyer_mailing_country_code	:= '';
	  SELF.ln_seller_mailing_country_code := '';
	  SELF.raw_file_name 									:= '';
		SELF 																:= L;
	END;
	oFrD := project(aFrD,mapOldFrsDeed(LEFT));
	//oFrD := project(aFrD,LN_PropertyV2_Fast.Layout_Fares_Deeds);
	
	// adjust layout for update_type
	LN_PropertyV2_Fast.Layout_Fares_Assessor mapOldFrsAssessment(aFrA L) := TRANSFORM
	  SELF.update_type										:= '';
	  SELF.ln_mailing_country_code 				:= '';
		SELF.raw_file_name									:= 'old_fares_input';
	  SELF 																:= L;
	END;
	oFrA := project(aFrA,mapOldFrsAssessment(LEFT));
	
	// MAP FARES to prep format
	oldAddlFaresTax 	:= LN_PropertyV2_Fast.Mapping_Fares_Base(oFrD,oFrA,oFrS).Addl_fares_taxWithC_layout;
	oldAddlFaresDeed	:= LN_PropertyV2_Fast.Mapping_Fares_Base(oFrD,oFrA,oFrS).Addl_fares_deedWithC_layout;
	oldFrsAssessment	:= project(
											 LN_PropertyV2_Fast.Mapping_Fares_Base(oFrD,oFrA,oFrS).AssessorWithC_Layout
															 ,LN_Propertyv2.layout_property_common_model_base);
	oldFrsDeedMortga	:= LN_PropertyV2_Fast.Mapping_Fares_Base(oFrD,oFrA,oFrS).DeedWithC_layout;
	oldFrsAddlLegal		:= LN_PropertyV2_Fast.Mapping_Fares_Base(oFrD,oFrA,oFrS).Addl_legalWithC_layout;
	
	//oldFrsSearch := project(oFrS,LN_PropertyV2.Layout_DID_Out);

// *** ABOVE code will drop when we retire old "in files"	*** //****************************************************//

	prepAssessmentR := LN_PropertyV2_Fast.ReplaceRecords(prepAssessment,prepDeedMortga,prepAddlNames,prepAddlLegal,prepSearchProp,prepAddlNameInfo).assessmnt;
	prepDeedMortgaR	:= LN_PropertyV2_Fast.ReplaceRecords(prepAssessment,prepDeedMortga,prepAddlNames,prepAddlLegal,prepSearchProp,prepAddlNameInfo).deedMortg;
	prepAddlNamesR	:= LN_PropertyV2_Fast.ReplaceRecords(prepAssessment,prepDeedMortga,prepAddlNames,prepAddlLegal,prepSearchProp,prepAddlNameInfo).addlNames;
	prepAddlLegalR	:= LN_PropertyV2_Fast.ReplaceRecords(prepAssessment,prepDeedMortga,prepAddlNames,prepAddlLegal,prepSearchProp,prepAddlNameInfo).addlLegal;
	prepAddlNmInfoR	:= LN_PropertyV2_Fast.ReplaceRecords(prepAssessment,prepDeedMortga,prepAddlNames,prepAddlLegal,prepSearchProp,prepAddlNameInfo).addlNameInfo;
	prepSearchPrpR	:= LN_PropertyV2_Fast.ReplaceRecords(prepAssessment+project(oldOkcAssmnt + oldFrsAssessment
																																							,TRANSFORM(LN_PropertyV2_Fast.Layout_prep_assessment
																																												 ,SELF.update_type := ''
																																												 ,SELF.raw_file_name := 'old_in_files'
																																												 ,SELF := LEFT
																																												 )
																																												 
																																			)
																											 ,prepDeedMortga+project(oldOkcDeedMr + project(oldFrsDeedMortga
																																																			,recordof(oldOkcDeedMr)
																																															)
																																							 ,TRANSFORM(LN_PropertyV2_Fast.Layout_prep_deed_mortg
																																												 ,SELF.raw_file_name := 'old_in_files'
																																												 ,SELF := LEFT
																																												 )
																																							 )
																											                              ,prepAddlNames,prepAddlLegal,prepSearchProp,prepAddlNameInfo).searchPrp;
		
	// -- COMBINE NEW PREP AND OLD "IN" FILES -- //
	irs_a := LN_PropertyV2.irs_dummy_recs_assessor;
	irs_d := LN_PropertyV2.irs_dummy_recs_deed;
																										// **** REMOVE "OLD" BELOW **** // *****************************//
	cmbindAssesEmtpyLnFields:= prepAssessmentR + irs_a	+ oldOkcAssmnt + oldFrsAssessment;
	cmbindDeedEmtpyLnFields := prepDeedMortgaR + irs_d	+ oldOkcDeedMr + project(oldFrsDeedMortga,recordof(oldOkcDeedMr));
	combined_search 			  := prepSearchPrpR;						//+ oldOkcSearch + oldFrsSearch; // NB : history re-clean added to the prep search file
	
	addl_fares_tax 					:= prepFrsAddlAst  					+ oldAddlFaresTax;
	addl_fares_deed 				:= prepFrsAddlDdM 					+ oldAddlFaresDeed;
	combined_addl_legal 		:= prepAddlLegalR						+ oldAddlLegal +oldFrsAddlLegal;
	addlNames 							:= prepAddlNamesR						+ oldAddlNames;
																										// **** REMOVE "OLD" ABOVE **** // *****************************//
	// -- PROCEED WITH BUILD --- //
  // populate ln_derived fields


  recordof(cmbindAssesEmtpyLnFields) tPopulateLnFields(cmbindAssesEmtpyLnFields L) := TRANSFORM
		SELF.ln_block										:= if(l.legal_block='',LN_PropertyV2_Fast.Functions_LN_Fields.ExtractBlock(L.legal_brief_description),'');
		SELF.ln_lot											:= if(l.legal_lot_number='',LN_PropertyV2_Fast.Functions_LN_Fields.ExtractLot(L.legal_brief_description),'');
		SELF.ln_unit										:= if(l.property_unit_number='',LN_PropertyV2_Fast.Functions_LN_Fields.ExtractUnit(L),'');
		SELF.ln_property_tax_exemption	:= LN_PropertyV2_Fast.Functions_LN_Fields.ExtractExempt(L);
		SELF.ln_veteran_status 					:= LN_PropertyV2_Fast.Functions_LN_Fields.ExtractVeteran(L);
		SELF.ln_condo_indicator					:= LN_PropertyV2_Fast.Functions_LN_Fields.ExtractCondo(L);
		SELF.ln_mobile_home_indicator		:= LN_PropertyV2_Fast.Functions_LN_Fields.ExtractMH(L);
		SELF.ln_land_use_category 			:= LN_PropertyV2_Fast.Functions_LN_Fields.ExtractLuseCat(L);
    SELF.ln_subfloor                := LN_PropertyV2.fn_codesv3_desc(
                                      'FLOOR2SUB', L.floor_cover_code,'PROPERTY_ASSESSMENT',
                                       if(L.vendor_source_flag in ['F','S'], 'F',''));
		
		//
		self.ln_ownership_rights 				:= LN_PropertyV2_Fast.Functions_LN_Owner_Fields.ExtractAssesOwnRghts(L);
		self.ln_relationship_type 			:= LN_PropertyV2_Fast.Functions_LN_Owner_Fields.ExtractAssesRelatType(L);
		self.ln_property_name 					:= if(trim(l.legal_subdivision_name)='',
																				LN_PropertyV2_Fast.Functions_LN_Fields.ExtractPropName(L),'');
		self.ln_property_name_type 			:= 'S';

		SELF := L;
	END;
	
	// Jira DF-11862 - added isfast to persist name file in order to run continuous delta
	combined_assessment := PROJECT(cmbindAssesEmtpyLnFields,tPopulateLnFields(LEFT));// : persist('~persist::property::combined_assessment'+if(isFast,'_d','f'));
			//dataset('~persist::property::combined_assessment'+if(isFast,'_d','f'),recordof(cmbindAssesEmtpyLnFields),thor)(process_date<=versionDate);
	
	recordof(cmbindDeedEmtpyLnFields) tPopulateDeedLnFields(cmbindDeedEmtpyLnFields L) := TRANSFORM
		self.ln_ownership_rights 				:=	LN_PropertyV2_Fast.Functions_LN_Owner_Fields.ExtractDeedOwnRghts(L);
		self.ln_relationship_type 			:=	LN_PropertyV2_Fast.Functions_LN_Owner_Fields.ExtractDeedRelatType(L);
		SELF := L;
	END;
	combined_deed_mortgage := PROJECT(cmbindDeedEmtpyLnFields,tPopulateDeedLnFields(LEFT));
	
	// Bug 145096 - Reverse the date format from MMDDYYYY to YYYYMMDD for valid dates
	dReformatAssesor 	:= LN_PropertyV2_Fast.fn_reformat_dates.assessor_dates(combined_assessment);
	dReformatSearch		:= LN_PropertyV2_Fast.fn_reformat_dates.search_first_last_seen(combined_assessment,combined_search);

	// Clean address and append aid
	ln_propertyv2.Append_AID(dReformatSearch,dSearchAIDTemp,true);
	
	dSearchAID	:=	dSearchAIDTemp :	independent;
	
	// Add propagated address assessor,deed search records to combined search
	search_with_propagated_records	:=	dSearchAID	
																			+LN_PropertyV2_Fast.Propagate_Property_Address_Deed(
																													combined_deed_mortgage,dSearchAID,isFast).new_search_records
																			+LN_PropertyV2_Fast.Propagate_Property_Address_Assessment(
																													dReformatAssesor,dSearchAID,isFast).new_search_records;
	
	// Bug 31994 - Remove previous search records which were improved by address propagation
	dRemovePropagatedRecs	:=	ln_propertyv2_Fast.fn_patch_search(search_with_propagated_records);
	
	addlFaresAssessorPatched 	:=	ln_propertyv2.fn_patch_fares_addl_tax(addl_fares_tax);
	addlFaresDeedsPathced			:=	ln_propertyv2.fn_patch_fares_addl_deed(addl_fares_deed);

	assessor_base :=	LN_PropertyV2_Fast.Propagate_Property_Address_Assessment(
											dReformatAssesor,search_with_propagated_records,isFast).Assess_resultWflag;
	
	deeds_base    :=	LN_PropertyV2_Fast.Propagate_Property_Address_Deed(
											combined_deed_mortgage,search_with_propagated_records,isFast).Deeds_resultWflag(addlFaresDeedsPathced);

	// address improvements (EPIC)
	// Jira DF-11862 - added isfast to persist name file in order to run continuous delta
	address_improvement_prep_file := ln_propertyv2_addressenhancements.PrepFile(dRemovePropagatedRecs,assessor_base,deeds_base,isFast);// : persist('~thor400_data::persist::epic_prep_file'+if(isFast,'_d','f'));
															//dataset('~thor400_data::persist::epic_prep_file'+if(isFast,'_d','f'),ln_propertyv2_addressenhancements.layouts.prep_rec,thor);
	by_name_street_attempt   := ln_propertyv2_addressenhancements.fnJoinOnNameStreetCounty(address_improvement_prep_file,isFast);//  : persist('~thor400_data::persist::epic_by_name_street'+if(isFast,'_d','f'));
															//dataset('~thor40_241::persist::epic_by_name_street'+if(isFast,'_d','f'),ln_propertyv2_addressenhancements.layouts.prep_rec,thor);
  by_street_attempt        := ln_propertyv2_addressenhancements.fnJoinOnStreetCounty(by_name_street_attempt,isFast);//             : persist('~thor400_data::persist::epic_by_street'+if(isFast,'_d','f'));
															//dataset('~thor400_data::persist::epic_by_street'+if(isFast,'_d','f'),ln_propertyv2_addressenhancements.layouts.prep_rec,thor);
	by_name_primname_attempt := ln_propertyv2_addressenhancements.fnJoinOnNamePrimNameCounty(by_street_attempt,isFast);//            : persist('~thor400_data::persist::epic_by_name_primname'+if(isFast,'_d','f'));
															//dataset('~thor400_data::persist::epic_by_name_primname'+if(isFast,'_d','f'),ln_propertyv2_addressenhancements.layouts.prep_rec,thor);
	reclean                  := ln_propertyv2_addressenhancements.fnRecleanAndReapplyToSearch(by_name_primname_attempt,dRemovePropagatedRecs,Assessor_base,Deeds_base,isFast);

	
	search_withdid_ := LN_PropertyV2_Fast.property_didAndbdid(reclean.enhanced_search_recs,isFast) 
										//dataset('~thor_data400::persist::ln_propertyv2::property_didf',LN_PropertyV2.Layout_DID_Out,thor)(process_date<=versionDate)
									 + if(NOT(isFast),LN_PropertyV2_fast.irs_dummy_recs_search); // DF-19080, records were being added on every build creating duplicates

	searchwithlocidTemp := project(search_withdid_,{unsigned6 locid := 0, LN_PropertyV2.Layout_DID_Out});
  LocationID_xLink.Append(searchwithlocidTemp, prim_range, predir, prim_name, suffix, postdir, sec_range, v_city_name, st, zip, dSearchAIDwLocID);
	dSearchwithall	:=	project(dSearchAIDwLocID,transform(LN_PropertyV2.Layout_DID_Out, self.location_id := left.locid, self := left));

	assesswBitmap 	:= project(reclean.j_tax(process_date<=versionDate),ln_propertyV2.layouts.layout_property_common_model_base_scrubs); //(Jira DF-18820)
	deedswbitmap  	:= project(reclean.j_deed(process_date<=versionDate),ln_propertyV2.layouts.layout_deed_mortgage_common_model_base_scrubs); //(Jira DF-18820)

	// write base files	
	alg := if (isFast,LN_PropertyV2_Fast.FileNames.base.addl_legal,
										LN_PropertyV2_Fast.FileNames.baseFull.addl_legal);
	afa := if (isFast,LN_PropertyV2_Fast.FileNames.base.addl_frs_a,
										LN_PropertyV2_Fast.FileNames.baseFull.addl_frs_a);
	afd := if (isFast,LN_PropertyV2_Fast.FileNames.base.addl_frs_d,
										LN_PropertyV2_Fast.FileNames.baseFull.addl_frs_d);
	aln := if (isFast,LN_PropertyV2_Fast.FileNames.base.addl_names,
										LN_PropertyV2_Fast.FileNames.baseFull.addl_names);
	asr := if (isFast,LN_PropertyV2_Fast.FileNames.base.search_prp,
										LN_PropertyV2_Fast.FileNames.baseFull.search_prp);
	asm := if (isFast,LN_PropertyV2_Fast.FileNames.base.assessment,
										LN_PropertyV2_Fast.FileNames.baseFull.assessment);
	ade := if (isFast,LN_PropertyV2_Fast.FileNames.base.deed_mortg,
										LN_PropertyV2_Fast.FileNames.baseFull.deed_mortg);
	ani := if (isFast,LN_PropertyV2_Fast.FileNames.base.addl_name_info,
										LN_PropertyV2_Fast.FileNames.baseFull.addl_name_info);
	
	// Deed property linking (Jira SLP-1)
	
	set_addr_tx_id	:= InsuranceHeader_Property_Transactions_DeedsMortgages.proc_dproptx(,,dSearchwithall,deedswbitmap);
	search_withdid	:= if(not(isfast),InsuranceHeader_Property_Transactions_DeedsMortgages.AppendID(dSearchwithall),dSearchwithall);
	
	// To implement true delta (Jira DF-11862), need to concatenate base logical files before sending to build macro

	fast_base_assessment				:= dataset(LN_PropertyV2_Fast.FileNames.base.assessment,
																				 LN_PropertyV2.Layouts.layout_property_common_model_base_scrubs,flat,opt);
	fast_base_deed_mortg				:= dataset(LN_PropertyV2_Fast.FileNames.base.deed_mortg,
																				 LN_PropertyV2.Layouts.layout_deed_mortgage_common_model_base_scrubs,flat,opt);

  // To avoid duplicate records on the delta in case forceDeltaStartDate is informed instead of max process_date calculated (Jira DF-18820)
	// DF-27847 to include only current delta and append logical file to superfle
  combined_addl_legal_d				:= dedup(/*LN_PropertyV2_fast.files.base.addl_legal+*/combined_addl_legal,all);
	addlFaresAssessorPatched_d	:= dedup(/*LN_PropertyV2_fast.files.base.addl_frs_a+*/addlFaresAssessorPatched,all);
	addlFaresDeedsPathced_d			:= dedup(/*LN_PropertyV2_fast.files.base.addl_frs_d+*/addlFaresDeedsPathced,all);
	addlNames_d									:= dedup(/*LN_PropertyV2_fast.files.base.addl_names+*/addlNames,all);
	search_withdid_d						:= dedup(/*LN_PropertyV2_fast.files.base.search_prp+*/search_withdid,all);
	assesswBitmap_d							:= dedup(/*fast_base_assessment+*/assesswBitmap,all);
	deedswbitmap_d							:= dedup(/*fast_base_deed_mortg+*/deedswbitmap,all);
	addlNameInfo_d							:= dedup(/*LN_PropertyV2_fast.files.base.addl_name_info + */prepAddlNmInfoR,all);

	combined_addl_legal_c				:= if(isfast,combined_addl_legal_d,combined_addl_legal);
	addlFaresAssessorPatched_c	:= if(isfast,addlFaresAssessorPatched_d,addlFaresAssessorPatched);
	addlFaresDeedsPathced_c			:= if(isfast,addlFaresDeedsPathced_d,addlFaresDeedsPathced);
	addlNames_c									:= if(isfast,addlNames_d,addlNames);
	search_withdid_c						:= if(isfast,search_withdid_d,search_withdid);
	assesswBitmap_c							:= if(isfast,assesswBitmap_d,assesswBitmap);
	deedswbitmap_c							:= if(isfast,deedswbitmap_d,deedswbitmap);
	addlNameInfo_c							:= if(isfast,addlNameInfo_d,prepAddlNmInfoR);

// DF-27847 to include only current delta and append logical file to superfle
	addToSuperFiles(string superFileName, string subFileName) := FUNCTION
			RETURN SEQUENTIAL(
									if (not fileservices.SuperFileExists(superFileName), fileservices.CreateSuperFile(superFileName)),
									fileservices.StartSuperFileTransaction(),
									fileservices.AddSuperFile(superFileName,subFileName),
									fileservices.ClearSuperFile(superFileName+'::delta'),
									fileservices.AddSuperFile(superFileName+'::delta',subFileName),
									fileservices.FinishSuperFileTransaction()
							);
	END;	

	bld_propertyv2_legal_f 				:= sequential(output(combined_addl_legal,,alg+'_'+versionDate,compressed,overwrite),
	                               addToSuperFiles(alg,alg+'_'+versionDate));
	bld_propertyv2_fares_tax_f 		:= sequential(output(addlFaresAssessorPatched,,afa+'_'+versionDate,compressed,overwrite),
		                        		 addToSuperFiles(afa,afa+'_'+versionDate));
	bld_propertyv2_fares_deed_f 	:= sequential(output(addlFaresDeedsPathced,,afd+'_'+versionDate,compressed,overwrite),
		                        		 addToSuperFiles(afd,afd+'_'+versionDate));
	bld_propertyv2_ln_addl_names_f:= sequential(output(addlNames,,aln+'_'+versionDate,compressed,overwrite),
		                        		 addToSuperFiles(aln,aln+'_'+versionDate));
	bld_propertyv2_search_f 			:= sequential(output(search_withdid,,asr+'_'+versionDate,compressed,overwrite),
		                        		 addToSuperFiles(asr,asr+'_'+versionDate));
	bld_propertyv2_Assesor_f 			:= sequential(output(assesswBitmap,,asm+'_'+versionDate,compressed,overwrite),
		                        		 addToSuperFiles(asm,asm+'_'+versionDate));
	bld_propertyv2_Deed_f 				:= sequential(output(deedswbitmap,,ade+'_'+versionDate,compressed,overwrite),
		                        		 addToSuperFiles(ade,ade+'_'+versionDate));

	PromoteSupers.MAC_SF_BuildProcess(combined_addl_legal_c,		 alg,bld_propertyv2_legal,2,,true,versionDate);
	PromoteSupers.MAC_SF_BuildProcess(addlFaresAssessorPatched_c,afa,bld_propertyv2_fares_tax,2,,true,versionDate);
	PromoteSupers.MAC_SF_BuildProcess(addlFaresDeedsPathced_c,	 afd,bld_propertyv2_fares_deed,2,,true,versionDate);
	PromoteSupers.MAC_SF_BuildProcess(addlNames_c,							 aln,bld_propertyv2_ln_addl_names,2,,true,versionDate);
	PromoteSupers.MAC_SF_BuildProcess(search_withdid_c,					 asr,bld_propertyv2_search,2,,true,versionDate);
	PromoteSupers.MAC_SF_BuildProcess(assesswBitmap_c,					 asm,bld_propertyv2_Assesor,2,,true,versionDate);
	PromoteSupers.MAC_SF_BuildProcess(deedswbitmap_c,						 ade,bld_propertyv2_Deed,2,,true,versionDate);
	PromoteSupers.MAC_SF_BuildProcess(addlNameInfo_c,						 ani,bld_propertyv2_addl_name_info,2,,true,versionDate);

	PromoteBaseDelta := FUNCTION
		bdalg := LN_PropertyV2_Fast.FileNames.base.addl_legal;
	  bdafa := LN_PropertyV2_Fast.FileNames.base.addl_frs_a;
  	bdafd := LN_PropertyV2_Fast.FileNames.base.addl_frs_d;
	  bdaln := LN_PropertyV2_Fast.FileNames.base.addl_names;
    bdasr := LN_PropertyV2_Fast.FileNames.base.search_prp;
    bdasm := LN_PropertyV2_Fast.FileNames.base.assessment;
    bdade := LN_PropertyV2_Fast.FileNames.base.deed_mortg;
		bdani := LN_PropertyV2_Fast.FileNames.base.addl_name_info;
		a := STD.File.PromoteSuperFileList([bdalg,bdalg+'_father'],deltail:=true);
		b := STD.File.PromoteSuperFileList([bdafa,bdafa+'_father'],deltail:=true);
		c := STD.File.PromoteSuperFileList([bdafd,bdafd+'_father'],deltail:=true);
		d := STD.File.PromoteSuperFileList([bdaln,bdaln+'_father'],deltail:=true);
		e := STD.File.PromoteSuperFileList([bdasr,bdasr+'_father'],deltail:=true);
		f := STD.File.PromoteSuperFileList([bdasm,bdasm+'_father'],deltail:=true);
		g := STD.File.PromoteSuperFileList([bdade,bdade+'_father'],deltail:=true);
		h := STD.File.PromoteSuperFileList([bdani,bdani+'_father'],deltail:=true);
		return sequential(a,b,c,d,e,f,g,h);
	END;

// ** End lines to implement true delta **

/* 
	bld_propertyv2_legal 				:= output(combined_addl_legal,,alg+'_'+versionDate,compressed,overwrite);
	bld_propertyv2_fares_tax 		:= output(addlFaresAssessorPatched,,afa+'_'+versionDate,compressed,overwrite);
	bld_propertyv2_fares_deed 	:= output(addlFaresDeedsPathced,,afd+'_'+versionDate,compressed,overwrite);
	bld_propertyv2_ln_addl_names:= output(addlNames,,aln+'_'+versionDate,compressed,overwrite);
	bld_propertyv2_search 			:= output(search_withdid,,asr+'_'+versionDate,compressed,overwrite);
	bld_propertyv2_Assesor 			:= output(assesswBitmap,,asm+'_f_'+versionDate,compressed,overwrite);
	bld_propertyv2_Deed 				:= output(deedswbitmap,,ade+'_'+versionDate,compressed,overwrite);
	bld_propertyv2_addl_name_info	:= output(prepAddlNmInfoR,,ani+'_'+versionDate,compressed,overwrite);
	
	PromoteSupers.MAC_SF_BuildProcess(combined_addl_legal, 			alg,bld_propertyv2_legal,2,,true,versionDate);
  PromoteSupers.MAC_SF_BuildProcess(addlFaresAssessorPatched, 	afa,bld_propertyv2_fares_tax,2,,true,versionDate);
  PromoteSupers.MAC_SF_BuildProcess(addlFaresDeedsPathced, 		afd,bld_propertyv2_fares_deed,2,,true,versionDate);
  PromoteSupers.MAC_SF_BuildProcess(addlNames, 								aln,bld_propertyv2_ln_addl_names,2,,true,versionDate);
  PromoteSupers.MAC_SF_BuildProcess(search_withdid, 						asr,bld_propertyv2_search,2,,true,versionDate);
  PromoteSupers.MAC_SF_BuildProcess(assesswBitmap, 						asm,bld_propertyv2_Assesor,2,,true,versionDate);
	PromoteSupers.MAC_SF_BuildProcess(deedswbitmap, 							ade,bld_propertyv2_Deed,2,,true,versionDate);										 
	PromoteSupers.MAC_SF_BuildProcess(prepAddlNmInfoR, 							ani,bld_propertyv2_addl_name_info,2,,true,versionDate);	
*/ 	

	return	sequential(	
											LN_PropertyV2_Fast.BuildLogger.update(versionDate,'base_build_start_date',(STRING8)Std.Date.Today()),
											LN_PropertyV2_Fast.BuildLogger.update(versionDate,'update_type',if(isFast,'DELTA','FULL')),
											if(isFast,bld_propertyv2_legal_f,bld_propertyv2_legal),
											if(isFast,bld_propertyv2_fares_tax_f,bld_propertyv2_fares_tax),
											if(isFast,bld_propertyv2_fares_deed_f,bld_propertyv2_fares_deed),
											if(isFast,bld_propertyv2_ln_addl_names_f,bld_propertyv2_ln_addl_names),
											if(not(isfast),set_addr_tx_id),
											if(isFast,bld_propertyv2_search_f,bld_propertyv2_search),
											if(isFast,bld_propertyv2_Assesor_f,bld_propertyv2_Assesor),
											if(isFast,bld_propertyv2_Deed_f,bld_propertyv2_Deed),
											if(not(isfast),PromoteBaseDelta),
											LN_PropertyV2_Fast.BuildLogger.update(versionDate,'base_build_end_date',(STRING8)Std.Date.Today()),
											);	
END;
