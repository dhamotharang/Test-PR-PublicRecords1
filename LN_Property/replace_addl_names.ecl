
import LN_property, LN_mortgage;

//retrieve base and files
concat_addl_names := dataset(filenames.inAddlNames, LN_Mortgage.Layout_Addl_Names, thor);

//distribute the files
concat_addl_names_dist := distribute(concat_addl_names, hash(ln_fares_id));
concat_addl_names_sort := sort(concat_addl_names_dist, ln_fares_id, local);

deed_replace_dist := distribute(LN_property.Replace_deeds, hash(ln_fares_id));
deed_replace_sort := sort(deed_replace_dist, ln_fares_id, local);

//get the good records in supplemental files

LN_Mortgage.Layout_Addl_Names tformat(LN_Mortgage.Layout_Addl_Names L, LN_Mortgage.Layout_Deed_Mortgage_Common_Model_Base R) := transform
  self := L;
end;

addl_names_joined       := join(concat_addl_names_sort, deed_replace_sort, left.ln_fares_id = right.ln_fares_id, tformat(left, right), local);
addl_names_joined_dedup := dedup(addl_names_joined, record);

// Check for deed repl data, don't use if not available
canUseAddlRepl := if(FileServices.GetSuperFileSubCount(ln_property.filenames.inDeedsRepl) > 0, 
										 true, false);
											 											 
export Replace_Addl_Names := if(canUseAddlRepl = true, addl_names_joined_dedup, concat_addl_names);