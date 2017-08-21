EXPORT fn_cleanup_spec_char(dataset(inquiry_acclogs.Layout.Common_ThorAdditions_non_FCRA) infile) := function 

spec_filter := '[^[:print:]]';

clean_f := project(infile, transform(inquiry_acclogs.Layout.Common_ThorAdditions_non_FCRA,
					self.search_info.transaction_id := StringLib.StringCleanSpaces(regexreplace(spec_filter, left.search_info.transaction_id, '', nocase)),
					self.search_info.datetime := if(regexfind(spec_filter,left.search_info.datetime),self.search_info.transaction_id, left.search_info.datetime),
					self.search_info.Function_Description := StringLib.StringCleanSpaces(regexreplace(spec_filter, left.search_info.Function_Description, '', nocase)),
          self := left));
																	
return clean_f;
end;

