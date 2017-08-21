import LN_property,LN_mortgage,LN_PropertyV2;

export replace_LN_searchAddlnames := module 

//******************** replace search ********************************************************

export replace_search(dataset(recordof(LN_PropertyV2.layout_deed_mortgage_property_search_mod)) inSearchRepl,
                      dataset(recordof(LN_PropertyV2.layout_deed_mortgage_property_search_mod)) inSearch,
											dataset(recordof(LN_PropertyV2.Layout_Deed_Mortgage_Common_Model_BASE)) inDeedsRepl,
                      dataset(recordof(LN_PropertyV2.Layout_Deed_Mortgage_Common_Model_BASE)) inDeeds,
											dataset(recordof(LN_PropertyV2.layout_property_common_model_base)) inAssessorRepl,
                      dataset(recordof(LN_PropertyV2.layout_property_common_model_base)) inAssessor
					  ) := function

// concatenate search base,add and replace files
concat_search := inSearchrepl + inSearch;

//distribute the files

concat_search_dist    := distribute(concat_search,hash(ln_fares_id));

replace_assessor_dist := distribute(LN_PropertyV2.replace_LN_AssessorDeeds.replace_assessor(inAssessorRepl,inAssessor),hash(ln_fares_id));

replace_deeds_dist := distribute(LN_PropertyV2.replace_LN_AssessorDeeds.Replace_Deeds(inDeedsRepl,indeeds),hash(ln_fares_id));

//get the good records from assessor replace file
LN_PropertyV2.layout_deed_mortgage_property_search_mod tjoinassessor(concat_search_dist L,replace_assessor_dist R) := transform
  self := L;
end;

search_assessor_joined := join(concat_search_dist,replace_assessor_dist,left.ln_fares_id = right.ln_fares_id,tjoinassessor(left,right),local);

//get the good records from deed replace file
LN_PropertyV2.layout_deed_mortgage_property_search_mod tjoindeeds(concat_search_dist L,replace_deeds_dist R) := transform
  self := L;
end;

search_deeds_joined := join(concat_search_dist,replace_deeds_dist,left.ln_fares_id = right.ln_fares_id,tjoindeeds(left,right),local);

//concatenate search replace file
concat_search_replace := search_assessor_joined + search_deeds_joined;
											 											 
Repl_Search := dedup(concat_search_replace,record);

return Repl_Search;

end;

//******************** replace addlnames ********************************************************
export Replace_Addl_Names(dataset(recordof(LN_PropertyV2.layout_addl_names)) inAddlNamesRepl,
													dataset(recordof(LN_PropertyV2.layout_addl_names)) inAddlNames,
                          dataset(recordof(LN_PropertyV2.Layout_Deed_Mortgage_Common_Model_BASE)) inDeedsRepl,
                          dataset(recordof(LN_PropertyV2.Layout_Deed_Mortgage_Common_Model_BASE)) inDeeds,
													dataset(recordof(LN_PropertyV2.layout_property_common_model_base)) inAssessorRepl,
													dataset(recordof(LN_PropertyV2.layout_property_common_model_base)) inAssessor
						   ) := function

//distribute the files
concat_addl_names_dist := distribute(inAddlNames	+	inAddlNamesRepl,hash(ln_fares_id));

assessor_replace_dist := distribute(LN_PropertyV2.replace_LN_AssessorDeeds.replace_assessor(inAssessorRepl,inAssessor),hash(ln_fares_id));

deed_replace_dist := distribute(LN_PropertyV2.replace_LN_AssessorDeeds.Replace_Deeds(inDeedsRepl,indeeds),hash(ln_fares_id));

//get the good records in supplemental files

LN_PropertyV2.layout_addl_names tAssessorformat(LN_PropertyV2.layout_addl_names L,LN_PropertyV2.layout_property_common_model_base R) := transform
  self := L;
end;

addl_names_assessor_joined := join(concat_addl_names_dist,assessor_replace_dist,left.ln_fares_id = right.ln_fares_id,tAssessorformat(left,right),local);

LN_PropertyV2.layout_addl_names tDeedformat(LN_PropertyV2.layout_addl_names L,LN_PropertyV2.Layout_Deed_Mortgage_Common_Model_Base R) := transform
  self := L;
end;

addl_names_deeds_joined    := join(concat_addl_names_dist,deed_replace_dist,left.ln_fares_id = right.ln_fares_id,tDeedformat(left,right),local);

//concatenate additional names replace file
concat_addl_names_replace := addl_names_assessor_joined + addl_names_deeds_joined;

Repl_Addl_Names := dedup(concat_addl_names_replace,record);

return Repl_Addl_Names;

end;

//******************** replace addllegal ********************************************************
export Replace_Addl_Legal(dataset(recordof(LN_PropertyV2.Layout_Addl_legal)) inAddlLegalRepl,
													dataset(recordof(LN_PropertyV2.Layout_Addl_legal)) inAddlLegal,
                          dataset(recordof(LN_PropertyV2.Layout_Deed_Mortgage_Common_Model_BASE)) inDeedsRepl,
                          dataset(recordof(LN_PropertyV2.Layout_Deed_Mortgage_Common_Model_BASE)) inDeeds,
													dataset(recordof(LN_PropertyV2.layout_property_common_model_base)) inAssessorRepl,
													dataset(recordof(LN_PropertyV2.layout_property_common_model_base)) inAssessor
						   ) := function

//distribute the files
concat_addl_legal_dist := distribute(inAddlLegal	+	inAddlLegalRepl,hash(ln_fares_id));

assessor_replace_dist := distribute(LN_PropertyV2.replace_LN_AssessorDeeds.replace_assessor(inAssessorRepl,inAssessor),hash(ln_fares_id));

deed_replace_dist := distribute(LN_PropertyV2.replace_LN_AssessorDeeds.Replace_Deeds(inDeedsRepl,indeeds),hash(ln_fares_id));

//get the good records in supplemental files

LN_PropertyV2.Layout_Addl_legal tAssessorformat(LN_PropertyV2.Layout_Addl_legal L,LN_PropertyV2.layout_property_common_model_base R) := transform
  self := L;
end;

addl_legal_assessor_joined := join(concat_addl_legal_dist,assessor_replace_dist,left.ln_fares_id = right.ln_fares_id,tAssessorformat(left,right),local);

LN_PropertyV2.Layout_Addl_legal tDeedformat(LN_PropertyV2.Layout_Addl_legal L,LN_PropertyV2.Layout_Deed_Mortgage_Common_Model_Base R) := transform
  self := L;
end;

addl_legal_deeds_joined    := join(concat_addl_legal_dist,deed_replace_dist,left.ln_fares_id = right.ln_fares_id,tDeedformat(left,right),local);

//concatenate additional names replace file
concat_addl_names_replace := addl_legal_assessor_joined + addl_legal_deeds_joined;

Repl_Addl_Names := dedup(concat_addl_names_replace,record);

return Repl_Addl_Names;

end;
end;