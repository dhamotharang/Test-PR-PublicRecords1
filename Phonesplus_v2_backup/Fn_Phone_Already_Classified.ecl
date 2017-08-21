//****************Function to determine if a phone10 has alredy been included/excluded for someone else********************
export Fn_Phone_Already_Classified (dataset(recordof(Layout_In_Phonesplus.layout_in_common)) phplus_in) := function

already_classified 	   := phplus_in(in_flag or 
									Translation_Codes.fFlagIsOn(rules, Translation_Codes.rules_bitmap_code('Non-pub-for-someone-else')) or
									Translation_Codes.fFlagIsOn(rules, Translation_Codes.rules_bitmap_code('Included-for-someone-else')) 
									);
									
									
									
already_classified_ded := dedup(sort(distribute(already_classified, hash(npa+phone7)), npa+phone7, local),npa+phone7, local);

return already_classified_ded ;
end;
