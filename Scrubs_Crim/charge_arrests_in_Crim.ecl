import hygenics_crim, ut;

EXPORT charge_arrests_in_Crim := project(hygenics_crim.file_in_charge_arrests,transform(Scrubs_Crim.charge_arrests_layout_Crim,
																																							self.vendor:=hygenics_crim._functions.fn_sourcename_to_vendor(left.sourcename,'');self:=left;));
																																						