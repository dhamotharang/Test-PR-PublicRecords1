import hygenics_crim, ut;

EXPORT priors_doc_in_Crim := project(hygenics_crim.file_in_priors_doc,transform(Scrubs_Crim.priors_doc_layout_Crim,
																																							self.vendor:=hygenics_crim._functions.fn_sourcename_to_vendor(left.sourcename,'');self:=left;));
																																						