import data_services;


sentence  		:= dataset(data_services.foreign_prod+ 'thor_200::in::crim::hd::doc_sentence',
					         			 layout_in_sentence,
								         CSV(SEPARATOR('|'), TERMINATOR(['\n', '\r\n']), QUOTE('"'), MAXLENGTH(6000))) (stringlib.StringToUpperCase(recordid[1..8])<>'RECORDID');// and StateCode in _include_states);

sentence_cw   := dataset(data_services.foreign_prod+'thor_200::in::crim::HD::doc_sentence_cw',
								         layout_in_sentence,
								         CSV(SEPARATOR('|'), TERMINATOR(['\n', '\r\n']), QUOTE('"'), MAXLENGTH(6000)))  (stringlib.StringToUpperCase(recordid[1..8])<>'RECORDID');// and StateCode in _include_states);

proj_sent_cw  := Project(sentence_cw,transform(hygenics_crim.layout_in_sentence,self.sourcename := trim(left.sourcename)+'_CW'; self := left;));

sentence_ie   := dataset(data_services.foreign_prod+'thor_200::in::crim::HD::doc_sentence_ie',
								        layout_in_sentence,
								        CSV(SEPARATOR('|'), TERMINATOR(['\n', '\r\n']), QUOTE('"'), MAXLENGTH(6000)))  (stringlib.StringToUpperCase(recordid[1..8])<>'RECORDID');// and StateCode in _include_states);
sentence_ie_filtered := sentence_ie(
                                     trim(SentenceDate)+
                                     trim(SentenceBeginDate)+
                                     trim(SentenceEndDate)+
                                     trim(SentenceType)+
                                     trim(SentenceMaxYears)+
                                     trim(SentenceMaxMonths)+
                                     trim(SentenceMaxDays)+
                                     trim(SentenceMinYears)+
                                     trim(SentenceMinMonths)+
                                     trim(SentenceMinDays)+
                                     trim(ScheduledReleaseDate)+
                                     trim(ActualReleaseDate)+
                                     trim(SentenceStatus)+
                                     trim(TimeServedYears)+
                                     trim(TimeServedMonths)+
                                     trim(TimeServedDays)+
                                     trim(PublicServiceHours)+
                                     trim(SentenceAdditionalInfo)+
                                     trim(CommunitySupervisionCounty)+
                                     trim(CommunitySupervisionYears)+
                                     trim(CommunitySupervisionMonths)+
                                     trim(CommunitySupervisionDays)+
                                     trim(ParoleBeginDate)+
                                     trim(ParoleEndDate)+
                                     trim(ParoleEligibilityDate)+
                                     trim(ParoleHearingDate)+
                                     trim(ParoleMaxYears)+
                                     trim(ParoleMaxMonths)+
                                     trim(ParoleMaxDays)+
                                     trim(ParoleMinYears)+
                                     trim(ParoleMinMonths)+
                                     trim(ParoleMinDays)+
                                     trim(ParoleStatus)+
                                     trim(ParoleOfficer)+
                                     trim(ParoleOffcerPhone)+
                                     trim(ProbationBeginDate)+
                                     trim(ProbationEndDate)+
                                     trim(ProbationMaxYears)+
                                     trim(ProbationMaxMonths)+
                                     trim(ProbationMaxDays)+
                                     trim(ProbationMinYears)+
                                     trim(ProbationMinMonths)+
                                     trim(ProbationMinDays)+
                                     trim(ProbationStatus) <> ''
                                  );

proj_sent_ie  := Project(sentence_ie,transform(hygenics_crim.layout_in_sentence,self.sourcename := trim(left.sourcename)+'_IE'; self := left;));

export file_in_sentence_doc := sentence    +proj_sent_cw+proj_sent_ie;