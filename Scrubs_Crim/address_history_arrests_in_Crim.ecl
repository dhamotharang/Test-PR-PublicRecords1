import hygenics_crim, ut,Scrubs_Crim;

EXPORT address_history_arrests_in_Crim := project(hygenics_crim.file_in_address_history_arrests,transform(Scrubs_Crim.address_history_arrests_layout_Crim,
																																							self.vendor:=hygenics_crim._functions.fn_sourcename_to_vendor(left.sourcename,'');self:=left;));