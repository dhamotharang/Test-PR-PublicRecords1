import ut,LN_PropertyV2,property,LN_Property,PropertyScrubs;
#option ('multiplePersistInstances',false);

export	proc_build_base(string	versionDate)	:=
function
	// LN IN Files
	LN_PropertyV2.layout_property_common_model_base assessCmTran(LN_PropertyV2.Layouts.PreProcess_Assessor_Layout l):= transform
		self.ln_ownership_rights := '';
		self.ln_relationship_type := '';
		self.ln_property_name := '';
		self.ln_property_name_type := '';
		self.ln_land_use_category := '';
		self.ln_mailing_country_code := '';
		self.ln_lot := '';
		self.ln_block := '';
		self.ln_unit := '';
		self.ln_subfloor := '';
    self.ln_floor_cover := '';
		self.ln_mobile_home_indicator := '';
		self.ln_condo_indicator := '';
		self.ln_property_tax_exemption := '';
		self.ln_veteran_status := '';
		self.ln_old_apn_indicator := '';
		self := l;
	end;
	inLNAssessorRep	  :=	ln_propertyV2.Files.Prep.LNAssessmentRepl;
	inLNAssessorRepl	:= 	project(inLNAssessorRep, assessCmTran(left));
	
  inAssessorRepl		:=	inLNAssessorRepl(~(regexfind('^[Pp][1-9]$',new_record_type_code)));
	inLNAssess	      :=	ln_propertyV2.Files.Prep.LNAssessment;
  inLNAssessor		  :=  project(inLNAssess, assessCmTran(left));
	inAssessor				:=	inLNAssessor(~(regexfind('^[Pp][1-9]$',new_record_type_code)));

	LN_PropertyV2.layout_deed_mortgage_common_model_base deedCmTran(LN_PropertyV2.Layouts.PreProcess_Deed_Layout l):= transform
		self.ln_ownership_rights := '';
		self.ln_relationship_type := '';
		self.ln_buyer_mailing_country_code := '';
		self.ln_seller_mailing_country_code := '';
		self := l;
	end;
	
	inDeedsRep 			  :=	ln_propertyV2.Files.Prep.LNDeedRepl;
	inDeedsRepl 			:=	project(inDeedsRep, deedCmTran(left));
	inDeed     				:=  ln_propertyV2.Files.Prep.LNDeed;
	inDeeds     			:=	project(inDeed, deedCmTran(left));	
	
	inAddlNamesRepl		:=	ln_propertyV2.Files.Prep.LNAddlNamesRepl;
	inAddlNames 			:=	ln_propertyV2.Files.Prep.LNAddlNames;
	
	inAddllegalRepl		:=	ln_propertyV2.Files.Prep.LNAddlLegalRepl;
	inAddllegal 			:=	ln_propertyV2.Files.Prep.LNAddlLegal;

	LN_PropertyV2.layout_deed_mortgage_property_search_mod srchTran(LN_PropertyV2.layout_deed_mortgage_property_search l):= transform
		self.nid := 0;
		self := l;
	end;
	
	inSrch						:=	ln_propertyV2.Files.Prep.LNSearch;
	inSearch					:=  project(inSrch, srchTran(left));
	inSrchRepl				:=	ln_propertyV2.Files.Prep.LNSearchRepl;
	inSearchRepl			:=  project(inSrchRepl, srchTran(left));

	// Only Fares
	Addl_fares_tax   := LN_PropertyV2.Mapping_Fares_Base(LN_PropertyV2.File_Fares_deeds_in,LN_PropertyV2.File_Fares_assessor_in,LN_PropertyV2.File_Fares_Search_in).Addl_fares_taxWithC_layout ;
	Addl_fares_deed  := LN_PropertyV2.Mapping_Fares_Base(LN_PropertyV2.File_Fares_deeds_in,LN_PropertyV2.File_Fares_assessor_in,LN_PropertyV2.File_Fares_Search_in).Addl_fares_deedWithC_layout;

	//Only LN 
	addlNames        :=	LN_PropertyV2.replace_LN_searchAddlnames.Replace_Addl_Names(inAddlNamesRepl,inAddlNames,inDeedsRepl,inDeeds,inAssessorRepl,inAssessor);
	addlLegal        :=	LN_PropertyV2.replace_LN_searchAddlnames.Replace_Addl_Legal(inAddlLegalRepl,inAddlLegal,inDeedsRepl,inDeeds,inAssessorRepl,inAssessor);

	// LN + Fares + irs 

	combined_Addl_legal  := addlLegal+LN_PropertyV2.Mapping_Fares_Base(LN_PropertyV2.File_Fares_deeds_in,LN_PropertyV2.File_Fares_assessor_in,LN_PropertyV2.File_Fares_Search_in).Addl_legalWithC_layout;

	combined_Assesor     := LN_PropertyV2.replace_LN_AssessorDeeds.replace_assessor(inAssessorRepl,inAssessor) 
												 + LN_PropertyV2.Mapping_Fares_Base(LN_PropertyV2.File_Fares_deeds_in,LN_PropertyV2.File_Fares_assessor_in,LN_PropertyV2.File_Fares_Search_in).AssessorWithC_Layout 
												 + LN_PropertyV2.irs_dummy_recs_assessor;
												 
	combined_Deed        := LN_PropertyV2.replace_LN_AssessorDeeds.replace_deeds(inDeedsRepl,inDeeds) 
												 + LN_PropertyV2.Mapping_Fares_Base(LN_PropertyV2.File_Fares_deeds_in,LN_PropertyV2.File_Fares_assessor_in,LN_PropertyV2.File_Fares_Search_in).DeedWithC_layout 
												 +LN_PropertyV2.irs_dummy_recs_deed;
												 
	combined_search      := LN_PropertyV2.replace_LN_searchAddlnames.Replace_Search(inSearchRepl,inSearch,inDeedsRepl,inDeeds,inAssessorRepl,inAssessor)  
												 + LN_PropertyV2.File_Fares_Search_in;//LN_PropertyV2.Mapping_Fares_Base(LN_PropertyV2.File_Fares_deeds_in,LN_PropertyV2.File_Fares_assessor_in,LN_PropertyV2.File_Fares_Search_in).SearchWithC_layout;
	
	// Bug 145096 - Reverse the date format from MMDDYYYY to YYYYMMDD for valid dates
	dReformatAssesor 	:= LN_PropertyV2.fn_reformat_dates.assessor_dates(combined_Assesor);
	dReformatSearch		:= LN_PropertyV2.fn_reformat_dates.search_first_last_seen(combined_Assesor,combined_search);

	// Clean address and append aid
	ln_propertyv2.Append_AID(dReformatSearch,dSearchAIDTemp,true);
	
	dSearchAID	:=	dSearchAIDTemp	:	independent;
	
	// Add propagated address assessor,deed search records to combined search
	search_with_propagated_records	:=	dSearchAID
																			+LN_PropertyV2.Propagate_Property_Address_Deed(combined_Deed,dSearchAID).new_search_records
																			+LN_PropertyV2.Propagate_Property_Address_Assessor(dReformatAssesor,dSearchAID).new_search_records;
		
	// Bug 31994 - Remove previous search records which were improved by address propagation
	dRemovePropagatedRecs	:=	ln_propertyv2.fn_patch_search(search_with_propagated_records);
	
	Assessor_base := LN_PropertyV2.Propagate_Property_Address_Assessor(dReformatAssesor,search_with_propagated_records).Assess_resultWflag;
	
	AssesswBitmap := PropertyScrubs.fValidateAssesment.GetBitmap(Assessor_base);
	
	Deeds_base    := LN_PropertyV2.Propagate_Property_Address_Deed(combined_Deed,search_with_propagated_records).Deeds_resultWflag ;
	Deedswbitmap  := PropertyScrubs.fValidateDeeds.GetBitmap(Deeds_base);
	
	// flip bad names
	ut.mac_flipnames(dRemovePropagatedRecs,fname,mname,lname,dSearchFlipName);

	search_withdid := LN_PropertyV2.property_didAndbdid(dSearchFlipName) + LN_PropertyV2.irs_dummy_recs_search;

	ut.MAC_SF_BuildProcess(combined_Addl_legal,
												 '~thor_data400::base::ln_propertyv2::Addl::legal',bld_propertyv2_legal,2,,true,versionDate);

	ut.MAC_SF_BuildProcess(ln_propertyv2.fn_patch_fares_addl_tax(Addl_fares_tax),
												 '~thor_data400::base::ln_propertyv2::Addl::fares_tax',bld_propertyv2_fares_tax,2,,true,versionDate);

	ut.MAC_SF_BuildProcess(ln_propertyv2.fn_patch_fares_addl_deed(Addl_fares_deed),
												 '~thor_data400::base::ln_propertyv2::Addl::fares_deed',bld_propertyv2_fares_deed,2,,true,versionDate);

	ut.MAC_SF_BuildProcess(addlNames,
												 '~thor_data400::base::ln_propertyv2::Addl::ln_names',bld_propertyv2_ln_addl_names,2,,true,versionDate);

	ut.MAC_SF_BuildProcess(search_withdid,
												 '~thor_data400::base::ln_propertyv2::search',bld_propertyv2_search,2,,true,versionDate);

	ut.MAC_SF_BuildProcess(AssesswBitmap,
												 '~thor_data400::base::ln_propertyv2::Assesor',bld_propertyv2_Assesor,2,,true,versionDate);

	ut.MAC_SF_BuildProcess(Deedswbitmap,
												 '~thor_data400::base::ln_propertyv2::Deed',bld_propertyv2_Deed,2,,true,versionDate);										 

  ut.MAC_SF_BuildProcess(create_ppr_extract,'~thor_data400::out::ln_propertyv2::ppr_extract',ppr_extract,2,,true,versionDate);
												 
												ppr_extract1 := ppr_extract	: success(output('PPR Extract created successfully')), failure(output('PPR Extract for LN Property V2 failed'));

	return	sequential(
											bld_propertyv2_legal,bld_propertyv2_fares_tax,bld_propertyv2_fares_deed,
											bld_propertyv2_ln_addl_names,
											bld_propertyv2_search,bld_propertyv2_Assesor,bld_propertyv2_Deed,
											LN_PropertyV2.ProcPropertyScrubs(LN_PropertyV2.Files.base.Assessment,LN_PropertyV2.Files.base.DeedMortgage,versionDate),ppr_extract1
											);
end;