import Nid, Address;

boolean isGoodName(string lname) := LENGTH(TRIM(lname)) > 0 AND TRIM(stringlib.stringfilter(lname,'@.0123456789()"')) = '';
EXPORT File_Surnames := File_History_Full_Prepped_for_Keys(listing_type_res = 'R',current_record_flag='Y',isGoodName(name_last),
									listed_name not in Surname_overrides,NOT REGEXFIND('\\b(FOR|UNLISTED|UNPUBLISHED|BLOCKED|FAX)\\b',listed_name),
									nametype='P');

//Nid.Mac_CleanFullNames(f, f_clean, listed_name); 
//Nid.Mac_CleanParsedNames(f, f_clean, name_first,name_middle,name_last,name_suffix); 
//Nid.Mac_CleanFullNames(f, f_clean, listed_name, useV2 := true, includeInRepository := false); 

//EXPORT File_Surnames := f
//										: PERSIST('~thor::persist::neustar::gong_cleaned_surnames');
