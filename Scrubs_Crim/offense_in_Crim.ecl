import hygenics_crim, ut;

EXPORT offense_in_Crim := project(hygenics_crim.file_in_offense,transform(Scrubs_Crim.offense_layout_Crim,
																																							self.vendor:=hygenics_crim._functions.fn_sourcename_to_vendor(left.sourcename,'');self:=left;));
																																						