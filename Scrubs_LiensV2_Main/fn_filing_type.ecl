EXPORT fn_filing_type (string filing_desc, string filing_type = ''):= function
codes := Scrubs_LiensV2_Main.file_filing_type;
string to_find := filing_type + '|' + filing_desc;
my_dict := project(codes, transform({string search_str},
																	 self.search_str:= trim(left.filing_type, left, right) + '|' + 
																										 trim(left.filing_desc, left, right)));

dict := DICTIONARY(my_dict);
return if(filing_desc = '',1,
						if(dict[to_find].search_str <> '', 1, 0));
end;
