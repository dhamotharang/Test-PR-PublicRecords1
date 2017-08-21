import hygenics_crim, ut;

EXPORT alias_in_Crim := project(hygenics_crim.file_in_alias,transform(Scrubs_Crim.alias_layout_Crim,
																																							self.vendor:=hygenics_crim._functions.fn_sourcename_to_vendor(left.sourcename,'');self:=left;));
																																						