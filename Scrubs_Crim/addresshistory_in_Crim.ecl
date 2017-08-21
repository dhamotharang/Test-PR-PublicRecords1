import hygenics_crim, ut,Scrubs_Crim;

EXPORT addresshistory_in_Crim := project(hygenics_crim.file_in_addresshistory,transform(Scrubs_Crim.addresshistory_layout_Crim,
																																							self.vendor:=hygenics_crim._functions.fn_sourcename_to_vendor(left.sourcename,'');self:=left;));