import hygenics_crim, ut;

EXPORT sentence_in_Crim := project(hygenics_crim.file_in_sentence,transform(Scrubs_Crim.sentence_layout_Crim,
																																							self.vendor:=hygenics_crim._functions.fn_sourcename_to_vendor(left.sourcename,'');self:=left;));
																																						