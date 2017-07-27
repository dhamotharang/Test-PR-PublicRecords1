import ut,LN_PropertyV2,property,LN_Property;

// LN IN Files 
inAssessorRepl := dataset(ln_propertyV2.filenames.inAssessorRepl, LN_PropertyV2.Layout_Property_Common_Model_BASE, thor); 
inAssessor     := dataset(ln_propertyV2.filenames.inAssessor, LN_PropertyV2.Layout_Property_Common_Model_BASE, thor); 

inDeedsRepl := dataset(ln_propertyV2.filenames.inDeedsRepl, LN_PropertyV2.Layout_Deed_Mortgage_Common_Model_BASE, thor); 
inDeeds     := dataset(ln_propertyV2.filenames.inDeeds, LN_PropertyV2.Layout_Deed_Mortgage_Common_Model_BASE, thor); 

inAddlNames := dataset(ln_propertyV2.filenames.inAddlNames, LN_PropertyV2.Layout_Addl_Names, thor);

inAddllegal := dataset(ln_propertyV2.filenames.inAddllegal, LN_PropertyV2.Layout_Addl_legal, thor);


inSearch     := dataset(ln_propertyV2.filenames.inSearch, LN_PropertyV2.Layout_Deed_Mortgage_Property_Search, thor); 
inSearchRepl := dataset(ln_propertyV2.filenames.inSearchRepl, LN_PropertyV2.Layout_Deed_Mortgage_Property_Search, thor); 

// Only Fares

Addl_fares_tax   := LN_PropertyV2.Mapping_Fares_Base(LN_PropertyV2.File_Fares_deeds_in,LN_PropertyV2.File_Fares_assessor_in,LN_PropertyV2.File_Fares_Search_in).Addl_fares_taxWithC_layout ;
Addl_fares_deed  := LN_PropertyV2.Mapping_Fares_Base(LN_PropertyV2.File_Fares_deeds_in,LN_PropertyV2.File_Fares_assessor_in,LN_PropertyV2.File_Fares_Search_in).Addl_fares_deedWithC_layout;

//Only LN 


addlNames        := LN_PropertyV2.replace_LN_searchAddlnames.Replace_Addl_Names(inAddlNames,inDeedsRepl,inDeeds); 

// LN + Fares + irs 

combined_Addl_legal  := inAddllegal+LN_PropertyV2.Mapping_Fares_Base(LN_PropertyV2.File_Fares_deeds_in,LN_PropertyV2.File_Fares_assessor_in,LN_PropertyV2.File_Fares_Search_in).Addl_legalWithC_layout ; 
combined_Assesor     := LN_PropertyV2.replace_LN_AssessorDeeds.replace_assessor(inAssessorRepl, inAssessor) 
                       + LN_PropertyV2.Mapping_Fares_Base(LN_PropertyV2.File_Fares_deeds_in,LN_PropertyV2.File_Fares_assessor_in,LN_PropertyV2.File_Fares_Search_in).AssessorWithC_Layout ;
combined_Deed        := LN_PropertyV2.replace_LN_AssessorDeeds.replace_deeds(inDeedsRepl, inDeeds) 
                       + LN_PropertyV2.Mapping_Fares_Base(LN_PropertyV2.File_Fares_deeds_in,LN_PropertyV2.File_Fares_assessor_in,LN_PropertyV2.File_Fares_Search_in).DeedWithC_layout ;         
combined_search      := LN_PropertyV2.replace_LN_searchAddlnames.Replace_Search(inSearchRepl, inSearch, inDeedsRepl,inDeeds, inAssessorRepl, inAssessor)  
                       + LN_PropertyV2.Mapping_Fares_Base(LN_PropertyV2.File_Fares_deeds_in,LN_PropertyV2.File_Fares_assessor_in,LN_PropertyV2.File_Fares_Search_in).SearchWithC_layout; 



// Add propagated address assessor,deed search records to combined search. 

search_with_propagated_records := combined_search + LN_PropertyV2.Propagate_Property_Address_Deed(combined_Deed,combined_search).new_search_records
                                  +LN_PropertyV2.Propagate_Property_Address_Assessor(combined_Assesor,combined_search).new_search_records;

          
search_withdid := LN_PropertyV2.property_didAndbdid(search_with_propagated_records);
 
ut.MAC_SF_BuildProcess(combined_Addl_legal,
                       '~thor_data400::base::ln_propertyv2::Addl::legal',bld_propertyv2_legal, 2,,true);
				   
ut.MAC_SF_BuildProcess(Addl_fares_tax,
                       '~thor_data400::base::ln_propertyv2::Addl::fares_tax', bld_propertyv2_fares_tax,2,,true);
					   
ut.MAC_SF_BuildProcess(Addl_fares_deed ,
                       '~thor_data400::base::ln_propertyv2::Addl::fares_deed', bld_propertyv2_fares_deed,2,,true);
					   					   
ut.MAC_SF_BuildProcess(addlNames,
                       '~thor_data400::base::ln_propertyv2::Addl::ln_names',bld_propertyv2_ln_addl_names, 2,,true);

ut.MAC_SF_BuildProcess(search_withdid,
                       '~thor_data400::base::ln_propertyv2::search',bld_propertyv2_search,2,,true);


ut.MAC_SF_BuildProcess(LN_PropertyV2.Propagate_Property_Address_Assessor(combined_Assesor,combined_search).Assess_resultWflag,
                       '~thor_data400::base::ln_propertyv2::Assesor',bld_propertyv2_Assesor,2,,true);

ut.MAC_SF_BuildProcess(LN_PropertyV2.Propagate_Property_Address_Deed(combined_Deed,combined_search).Deeds_resultWflag ,
                       '~thor_data400::base::ln_propertyv2::Deed',bld_propertyv2_Deed,2,,true);


  					 
export proc_build_base := sequential(bld_propertyv2_legal, bld_propertyv2_fares_tax,bld_propertyv2_fares_deed,bld_propertyv2_ln_addl_names,
                                      bld_propertyv2_search,bld_propertyv2_Assesor,bld_propertyv2_Deed);


