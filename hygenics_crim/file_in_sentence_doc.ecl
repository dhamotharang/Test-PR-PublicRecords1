import data_services;


sentence  		:= dataset(data_services.foreign_prod+ 'thor_200::in::crim::hd::doc_sentence',
					         			 layout_in_sentence,
								         CSV(SEPARATOR('|'), TERMINATOR(['\n', '\r\n']), QUOTE('"'), MAXLENGTH(6000))) (stringlib.StringToUpperCase(recordid[1..8])<>'RECORDID');// and StateCode in _include_states);

sentence_cw   := dataset(data_services.foreign_prod+'thor_200::in::crim::HD::county_sentence_cw',
								         layout_in_sentence,
								         CSV(SEPARATOR('|'), TERMINATOR(['\n', '\r\n']), QUOTE('"'), MAXLENGTH(6000)))  (stringlib.StringToUpperCase(recordid[1..8])<>'RECORDID');// and StateCode in _include_states);

proj_sent_cw  := Project(sentence_cw,transform(hygenics_crim.layout_in_sentence,self.sourcename := trim(left.sourcename)+'_CW'; self := left;));
export file_in_sentence_doc := sentence    +proj_sent_cw;