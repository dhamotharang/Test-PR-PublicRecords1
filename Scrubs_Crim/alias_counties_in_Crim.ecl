import hygenics_crim, ut;

EXPORT alias_counties_in_Crim := project(hygenics_crim.file_in_alias_counties,transform(Scrubs_Crim.alias_counties_layout_Crim,
																																							self.vendor:=hygenics_crim._functions.fn_sourcename_to_vendor(left.sourcename,'');self:=left;));
																																						