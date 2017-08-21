import hygenics_crim, ut;

EXPORT charge_in_Crim := project(hygenics_crim.file_in_charge,transform(Scrubs_Crim.charge_layout_Crim,
																																							self.vendor:=hygenics_crim._functions.fn_sourcename_to_vendor(left.sourcename,'');self:=left;));
																																						