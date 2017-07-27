import LN_property, LN_mortgage, LN_PropertyV2;

export replace_LN_searchAddlnames := module 

//******************** replace search ********************************************************

export replace_search(dataset(recordof(LN_PropertyV2.Layout_Deed_Mortgage_Property_Search)) inSearchRepl,
                      dataset(recordof(LN_PropertyV2.Layout_Deed_Mortgage_Property_Search)) inSearch,
					  dataset(recordof(LN_PropertyV2.Layout_Deed_Mortgage_Common_Model_BASE)) inDeedsRepl,
                      dataset(recordof(LN_PropertyV2.Layout_Deed_Mortgage_Common_Model_BASE)) inDeeds,
					  dataset(recordof(LN_PropertyV2.layout_property_common_model_base)) inAssessorRepl,
                      dataset(recordof(LN_PropertyV2.layout_property_common_model_base)) inAssessor
					  
					  ) := function

// concatenate search base, add and replace files
concat_search := inSearchrepl + inSearch;

//distribute the files

concat_search_dist    := distribute(concat_search, hash(ln_fares_id));
//concat_search_sort    := sort(concat_search_dist, ln_fares_id, local);

replace_assessor_dist := distribute(LN_PropertyV2.replace_LN_AssessorDeeds.replace_assessor(inAssessorRepl, inAssessor),hash(ln_fares_id));
//replace_assessor_sort := sort(replace_assessor_dist, ln_fares_id, local);

//temp_deeds            := dataset(LN_property.filenames.inDeeds, LN_Mortgage.Layout_Deed_Mortgage_Common_Model_BASE, thor);

replace_deeds_dist := distribute(LN_PropertyV2.replace_LN_AssessorDeeds.Replace_Deeds(inDeedsRepl,indeeds), hash(ln_fares_id));

//replace_deeds_dist    := distribute(inDeeds, hash(ln_fares_id));
//replace_deeds_sort    := sort(replace_deeds_dist, ln_fares_id, local);

//get the good records from assessor replace file
LN_PropertyV2.Layout_Deed_Mortgage_Property_Search tjoinassessor(concat_search_dist L, replace_assessor_dist R) := transform
  self := L;
end;

search_assessor_joined := join(concat_search_dist, replace_assessor_dist, left.ln_fares_id = right.ln_fares_id, tjoinassessor(left, right), local);

//get the good records from deed replace file
LN_PropertyV2.Layout_Deed_Mortgage_Property_Search tjoindeeds(concat_search_dist L, replace_deeds_dist R) := transform
  self := L;
end;

search_deeds_joined := join(concat_search_dist, replace_deeds_dist, left.ln_fares_id = right.ln_fares_id, tjoindeeds(left, right), local);

//concatenate search replace file
concat_search_replace := search_assessor_joined + search_deeds_joined;

// canUseSearchRepl := if(FileServices.GetSuperFileSubCount(ln_property.filenames.inSearchRepl) > 0 and
                       // FileServices.GetSuperFileSubCount(ln_property.filenames.inDeedsRepl) > 0, 
											 // true, false);
											 											 
Repl_Search := dedup(concat_search_replace, record);

return Repl_Search;

end;

//******************** replace addlnames ********************************************************
export Replace_Addl_Names(dataset(recordof(LN_PropertyV2.layout_addl_names)) inAddlNames,
                          dataset(recordof(LN_PropertyV2.Layout_Deed_Mortgage_Common_Model_BASE)) inDeedsRepl,
                          dataset(recordof(LN_PropertyV2.Layout_Deed_Mortgage_Common_Model_BASE)) inDeeds
						   
						   ) := function

//distribute the files
concat_addl_names_dist := distribute(inAddlNames, hash(ln_fares_id));
//concat_addl_names_sort := sort(concat_addl_names_dist, ln_fares_id, local);

deed_replace_dist := distribute(LN_PropertyV2.replace_LN_AssessorDeeds.Replace_Deeds(inDeedsRepl,indeeds), hash(ln_fares_id));
//deed_replace_sort := sort(deed_replace_dist, ln_fares_id, local);

//get the good records in supplemental files

LN_PropertyV2.layout_addl_names tformat(LN_PropertyV2.layout_addl_names L, LN_PropertyV2.Layout_Deed_Mortgage_Common_Model_Base R) := transform
  self := L;
end;

addl_names_joined       := join(concat_addl_names_dist, deed_replace_dist, left.ln_fares_id = right.ln_fares_id, tformat(left, right), local);
addl_names_joined_dedup := dedup(addl_names_joined, record);

// Check for deed repl data, don't use if not available
canUseAddlRepl := if(FileServices.GetSuperFileSubCount(ln_propertyV2.filenames.inDeedsRepl) > 0, 
										 true, false);

Repl_Addl_Names := if(canUseAddlRepl = true, addl_names_joined_dedup, inAddlNames);

return Repl_Addl_Names;

end;

end;