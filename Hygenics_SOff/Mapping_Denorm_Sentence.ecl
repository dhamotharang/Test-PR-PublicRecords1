
DSentence       := DISTRIBUTE(hygenics_soff.file_in_so_sentence,  HASH32(RecordID));
DSortedSentence := SORT(DSentence, RecordID, caseid, LOCAL);

IdTable        := table(DSortedSentence, Hygenics_SOff.Layout_Denorm_Sentence, RecordID, LOCAL);
 
	Hygenics_SOff.Layout_Denorm_Sentence DeNormSentence(Hygenics_SOff.Layout_Denorm_Sentence L, Hygenics_soff.Layout_in_SO_sentence R, INTEGER C) := TRANSFORM				
				
			sentence_desc		:= r.sentenceadditionalinfo[1..100];
				
			sentence_desc_2		:= '';
			
			sched_rel_dt		:= if(length(trim(r.scheduledreleasedate, left, right))=8 and trim(r.scheduledreleasedate, left, right)[1] in ['1','2'],
										trim(r.scheduledreleasedate, left, right),
										'');	
				
				
				SELF.sentence_description_1		:=  IF(C=1, 
															sentence_desc, 
															L.sentence_description_1);
				SELF.sentence_description_1_2	:=  IF(C=1, 
															sentence_desc_2,
															L.sentence_description_1_2); 	
				SELF.scheduled_release_dt_1		:= 	IF(C=1, 
															sched_rel_dt,
															L.scheduled_release_dt_1); 	
				SELF.sentence_description_2		:=  IF(C=2, 
															sentence_desc, 
															L.sentence_description_2);
				SELF.sentence_description_2_2	:=  IF(C=2, 
															sentence_desc_2,
															L.sentence_description_2_2); 
				SELF.scheduled_release_dt_2		:= 	IF(C=2, 
															sched_rel_dt,
															L.scheduled_release_dt_2); 	
				SELF.sentence_description_3		:=  IF(C=3, 
															sentence_desc, 
															L.sentence_description_3);
				SELF.sentence_description_3_2	:=  IF(C=3, 
															sentence_desc_2,
															L.sentence_description_3_2); 
				SELF.scheduled_release_dt_3		:= 	IF(C=3, 
															sched_rel_dt,
															L.scheduled_release_dt_3); 	
				SELF.sentence_description_4		:=  IF(C=4, 
															sentence_desc, 
															L.sentence_description_4);
				SELF.sentence_description_4_2	:=  IF(C=4, 
															sentence_desc_2,
															L.sentence_description_4_2); 
				SELF.scheduled_release_dt_4		:= 	IF(C=4, 
															sched_rel_dt,
															L.scheduled_release_dt_4); 	
 				SELF.sentence_description_5		:=  IF(C=5, 
															sentence_desc, 
															L.sentence_description_5);
				SELF.sentence_description_5_2	:=  IF(C=5, 
															sentence_desc_2,
															L.sentence_description_5_2);
				SELF.scheduled_release_dt_5		:= 	IF(C=5, 
															sched_rel_dt,
															L.scheduled_release_dt_5); 	
				SELF := L;
	end;
	 
denorm_sentence := DENORMALIZE(IdTable, DSortedSentence,
									LEFT.recordid = RIGHT.recordid,
									DeNormSentence(LEFT,RIGHT,COUNTER),LOCAL):persist('~thor_200::persist::soff_sentence');

export Mapping_Denorm_Sentence := denorm_sentence;