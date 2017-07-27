import emerges;

//Old_base := emerges.file_voters_base(trim(source_state,left,right) not in bad_st_code);
valid_state := ['AK','AR','CO','CT','DE',
								'DC','FL','LA','MA','MI',
								'NV','NJ','NY','NC','NM',
								'OH','OK','RI','SC','TX',
								'UT','WI'];
								
Old_base := emerges.file_voters_base(trim(source_state,left,right) in valid_state or
																	   trim(st,left,right) in valid_state or
																		 trim(mail_st,left,right) in valid_state);

export File_Voters_Old_Base := Old_base; //: persist(VotersV2.Cluster + 'persist::voters_old_base');