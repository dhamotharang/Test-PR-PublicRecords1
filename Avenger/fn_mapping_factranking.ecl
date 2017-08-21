export fn_mapping_factranking(dataset(avenger.layout_in.factranking) pInFile) := function

avenger.layout_common tmap_factranking(pInFile le) := transform

self.FactRank_TransactionID	:=	trim(le.TRANSACTION_ID,left,right)             	;
self.FactRank_Grade	:=	le.GRADE                      	;
self.FactRank_ID	:=	le.ID	;
self.FactRank_ClientID	:=	le.ACCOUNT_NAME               	;
self.FactRank_Quiz_Date_Created	:=	Avenger.fncleanfunctions.tTimeAdded(Avenger.fncleanfunctions.tDateAdded(le.CREATEDDATE));
self.FactRank_Quiz_Date_LastUpdated	:=	Avenger.fncleanfunctions.tTimeAdded(Avenger.fncleanfunctions.tDateAdded(le.LAST_UPDATE_DATE))          	;
self.FactRank_Data_Source	:=	le.DATASOURCE_NAME            	;
self.FactRank_Question_Set_ID	:=	le.QUESTION_SET_ID            	;
self.FactRank_Question_ID	:=	le.QUESTION_ID                	;
self.FactRank_Question_Type	:=	le.QUESTION_TYPE              	;
self.FactRank_Question_Outcome	:=	le.ANSWER_CORRECT             	;
self.FactRank_Question_Pres_Position	:=	le.PRESENTATION_POSITION      	;
self.FactRank_Question_Presented_Flag	:=	le.WAS_PRESENTED              	;
self.FactRank_Fraud_Marking	:=	le.FRAUD_MARKING              	;
self.FactRank_Raw_Question	:=	le.QUESTION_TEXT              	;
self.FactRank_Raw_CorrectAnswer 	:=	le.CORRECT_ANSWER             	;
self.FactRank_Raw_CorrectAnswer_Position	:=	le.CORRECT_ANSWER_INDEX       	;
self.FactRank_Fake	:=	le.FAKE                       	;
self.FactRank_Type_1	:=	le.VALUE_NAME1                	;
self.FactRank_Value_1	:=	le.VALUE1                     	;
self.FactRank_Description_1	:=	le.DESCRIPTION1               	;
self.FactRank_Raw_Answer_1	:=	le.ANSWER1                    	;
self.FactRank_Type_2	:=	le.VALUE_NAME2                	;
self.FactRank_Value_2	:=	le.VALUE2                     	;
self.FactRank_Description_2	:=	le.DESCRIPTION2               	;
self.FactRank_Raw_Answer_2	:=	le.ANSWER2                    	;
self.FactRank_Type_3	:=	le.VALUE_NAME3                	;
self.FactRank_Value_3	:=	le.VALUE3                     	;
self.FactRank_Description_3	:=	le.DESCRIPTION3               	;
self.FactRank_Raw_Answer_3	:=	le.ANSWER3                    	;
self.FactRank_Type_4	:=	le.VALUE_NAME4                	;
self.FactRank_Value_4	:=	le.VALUE4                     	;
self.FactRank_Description_4	:=	le.DESCRIPTION4               	;
self.FactRank_Raw_Answer_4	:=	le.ANSWER4                    	;
self.FactRank_Type_5	:=	le.VALUE_NAME5                	;
self.FactRank_Value_5	:=	le.VALUE5                     	;
self.FactRank_Description_5	:=	le.DESCRIPTION5               	;
self.FactRank_Raw_Answer_5	:=	le.ANSWER5                    	;
self.FactRank_Type_6	:=	le.VALUE_NAME6                	;
self.FactRank_Value_6	:=	le.VALUE6                     	;
self.FactRank_Description_6	:=	le.DESCRIPTION6               	;
self.FactRank_Raw_Answer_6	:=	le.ANSWER6                    	;
self.FactRank_Type_7	:=	le.VALUE_NAME7                	;
self.FactRank_Value_7	:=	le.VALUE7                     	;
self.FactRank_Description_7	:=	le.DESCRIPTION7               	;
self.FactRank_Raw_Answer_7	:=	le.ANSWER7                    	;
self.FactRank_Type_8	:=	le.VALUE_NAME8                	;
self.FactRank_Value_8	:=	le.VALUE8                     	;
self.FactRank_Description_8	:=	le.DESCRIPTION8               	;
self.FactRank_Raw_Answer_8	:=	le.ANSWER8                    	;
self.FactRank_Type_9	:=	le.VALUE_NAME9                	;
self.FactRank_Value_9	:=	le.VALUE9                     	;
self.FactRank_Description_9	:=	le.DESCRIPTION9               	;
self.FactRank_Raw_Answer_9	:=	le.ANSWER9                    	;
self.FactRank_Type_10	:=	le.VALUE_NAME10               	;
self.FactRank_Value_10	:=	le.VALUE10                    	;
self.FactRank_Description_10	:=	le.DESCRIPTION10              	;
self.FactRank_Raw_Answer_10	:=	le.ANSWER10                   	;
self.FactRank_Type_11	:=	le.VALUE_NAME11               	;
self.FactRank_Value_11	:=	le.VALUE11                    	;
self.FactRank_Description_11	:=	le.DESCRIPTION11              	;
self.FactRank_Raw_Answer_11	:=	le.ANSWER11                   	;
self.FactRank_Type_12	:=	le.VALUE_NAME12               	;
self.FactRank_Value_12	:=	le.VALUE12                    	;
self.FactRank_Description_12	:=	le.DESCRIPTION12              	;
self.FactRank_Raw_Answer_12	:=	le.ANSWER12                   	;
self.FactRank_Type_13	:=	le.VALUE_NAME13               	;
self.FactRank_Value_13	:=	le.VALUE13                    	;
self.FactRank_Description_13	:=	le.DESCRIPTION13              	;
self.FactRank_Raw_Answer_13	:=	le.ANSWER13                   	;
self.FactRank_Type_14	:=	le.VALUE_NAME14               	;
self.FactRank_Value_14	:=	le.VALUE14                    	;
self.FactRank_Description_14	:=	le.DESCRIPTION14              	;
self.FactRank_Raw_Answer_14	:=	le.ANSWER14                   	;
self.FactRank_Type_15	:=	le.VALUE_NAME15               	;
self.FactRank_Value_15	:=	le.VALUE15                    	;
self.FactRank_Description_15	:=	le.DESCRIPTION15              	;
self.FactRank_Raw_Answer_15	:=	le.ANSWER15                   	;
self.FactRank_Type_16	:=	le.VALUE_NAME16               	;
self.FactRank_Value_16	:=	le.VALUE16                    	;
self.FactRank_Description_16	:=	le.DESCRIPTION16              	;
self.FactRank_Raw_Answer_16	:=	le.ANSWER16                   	;
self.FactRank_Type_17	:=	le.VALUE_NAME17               	;
self.FactRank_Value_17	:=	le.VALUE17                    	;
self.FactRank_Description_17	:=	le.DESCRIPTION17              	;
self.FactRank_Raw_Answer_17	:=	le.ANSWER17                   	;
self.FactRank_Type_18	:=	le.VALUE_NAME18               	;
self.FactRank_Value_18	:=	le.VALUE18                    	;
self.FactRank_Description_18	:=	le.DESCRIPTION18              	;
self.FactRank_Raw_Answer_18	:=	le.ANSWER18                   	;
self.FactRank_Type_19	:=	le.VALUE_NAME19               	;
self.FactRank_Value_19	:=	le.VALUE19                    	;
self.FactRank_Description_19	:=	le.DESCRIPTION19              	;
self.FactRank_Raw_Answer_19	:=	le.ANSWER19                   	;
self.FactRank_Type_20	:=	le.VALUE_NAME20               	;
self.FactRank_Value_20	:=	le.VALUE20                    	;
self.FactRank_Description_20	:=	le.DESCRIPTION20              	;
self.FactRank_Raw_Answer_20	:=	le.ANSWER20     	;
self.FactRank_Type_21	:=	le.VALUE_NAME21               	;
self.FactRank_Value_21	:=	le.VALUE21                    	;
self.FactRank_Description_21	:=	le.DESCRIPTION21              	;
self.FactRank_Type_22	:=	le.VALUE_NAME22               	;
self.FactRank_Value_22	:=	le.VALUE22                    	;
self.FactRank_Description_22	:=	le.DESCRIPTION22              	;
self.FactRank_Type_23	:=	le.VALUE_NAME23               	;
self.FactRank_Value_23	:=	le.VALUE23                    	;
self.FactRank_Description_23	:=	le.DESCRIPTION23              	;
self.FactRank_Type_24	:=	le.VALUE_NAME24               	;
self.FactRank_Value_24	:=	le.VALUE24                    	;
self.FactRank_Description_24	:=	le.DESCRIPTION24              	;
self.FactRank_Type_25	:=	le.VALUE_NAME25               	;
self.FactRank_Value_25	:=	le.VALUE25                    	;
self.FactRank_Description_25	:=	le.DESCRIPTION25              	;
self.FactRank_Type_26	:=	le.VALUE_NAME26               	;
self.FactRank_Value_26	:=	le.VALUE26                    	;
self.FactRank_Description_26	:=	le.DESCRIPTION26              	;
self.FactRank_Type_27	:=	le.VALUE_NAME27               	;
self.FactRank_Value_27	:=	le.VALUE27                    	;
self.FactRank_Description_27	:=	le.DESCRIPTION27              	;
self.FactRank_Type_28	:=	le.VALUE_NAME28               	;
self.FactRank_Value_28	:=	le.VALUE28                    	;
self.FactRank_Description_28	:=	le.DESCRIPTION28              	;
self.FactRank_Type_29	:=	le.VALUE_NAME29               	;
self.FactRank_Value_29	:=	le.VALUE29                    	;
self.FactRank_Description_29	:=	le.DESCRIPTION29              	;
self.FactRank_Type_30	:=	le.VALUE_NAME30               	;
self.FactRank_Value_30	:=	le.VALUE30                    	;
self.FactRank_Description_30	:=	le.DESCRIPTION30              	;
self.Question_Num_Answers := if(le.ANSWER1 <> '', '1', '0') + 
                             if(le.ANSWER2 <> '', '1', '0') +
														 if(le.ANSWER3 <> '', '1', '0') +
														 if(le.ANSWER4 <> '', '1', '0') +
                             if(le.ANSWER5 <> '', '1', '0') + 
                             if(le.ANSWER6 <> '', '1', '0') +
														 if(le.ANSWER7 <> '', '1', '0') +
														 if(le.ANSWER8 <> '', '1', '0') +
                             if(le.ANSWER9 <> '', '1', '0') + 
                             if(le.ANSWER10 <> '', '1', '0') +
														 if(le.ANSWER11 <> '', '1', '0') +
														 if(le.ANSWER12 <> '', '1', '0') +
                             if(le.ANSWER13 <> '', '1', '0') + 
                             if(le.ANSWER14 <> '', '1', '0') +
														 if(le.ANSWER15 <> '', '1', '0') +
														 if(le.ANSWER16 <> '', '1', '0') +
														 if(le.ANSWER17 <> '', '1', '0') + 
                             if(le.ANSWER18 <> '', '1', '0') +
														 if(le.ANSWER19 <> '', '1', '0') +
														 if(le.ANSWER20 <> '', '1', '0');
							
self.Question_Type_Diversionary := if(regexfind('None of the above', le.CORRECT_ANSWER),'YES', 'NO');
self.Question_AnswerInclude_NOA := if(regexfind('None of the above', le.answer1) or
                                      regexfind('None of the above', le.answer2) or
                                      regexfind('None of the above', le.answer3) or
                                      regexfind('None of the above', le.answer4) or																			
			                                regexfind('None of the above', le.answer5) or
                                      regexfind('None of the above', le.answer6) or
                                      regexfind('None of the above', le.answer7) or
                                      regexfind('None of the above', le.answer8) or																
																			regexfind('None of the above', le.answer9) or
                                      regexfind('None of the above', le.answer10) or
                                      regexfind('None of the above', le.answer11) or
                                      regexfind('None of the above', le.answer12) or
																			regexfind('None of the above', le.answer13) or
                                      regexfind('None of the above', le.answer14) or
                                      regexfind('None of the above', le.answer15) or
                                      regexfind('None of the above', le.answer16) or
																			regexfind('None of the above', le.answer17) or
                                      regexfind('None of the above', le.answer18) or
                                      regexfind('None of the above', le.answer19) or
                                      regexfind('None of the above', le.answer20), 'YES', 'NO');
self.Question_AnswerReal_NOA := if(regexfind('None of the above', le.CORRECT_ANSWER),'YES', 'NO');

self.Question_AnswerInclude_AOA := if(regexfind('All of the above', le.answer1) or
                                      regexfind('All of the above', le.answer2) or
                                      regexfind('All of the above', le.answer3) or
                                      regexfind('All of the above', le.answer4) or																			
			                                regexfind('All of the above', le.answer5) or
                                      regexfind('All of the above', le.answer6) or
                                      regexfind('All of the above', le.answer7) or
                                      regexfind('All of the above', le.answer8) or																
																			regexfind('All of the above', le.answer9) or
                                      regexfind('All of the above', le.answer10) or
                                      regexfind('All of the above', le.answer11) or
                                      regexfind('All of the above', le.answer12) or
																			regexfind('All of the above', le.answer13) or
                                      regexfind('All of the above', le.answer14) or
                                      regexfind('All of the above', le.answer15) or
                                      regexfind('All of the above', le.answer16) or
																			regexfind('All of the above', le.answer17) or
                                      regexfind('All of the above', le.answer18) or
                                      regexfind('All of the above', le.answer19) or
                                      regexfind('All of the above', le.answer20), 'YES', 'NO');
																			
self.Question_AnswerReal_AOA  :=  if(regexfind('All of the above', le.CORRECT_ANSWER),'YES', 'NO');

self := [];
            
end;

common_factranking := dedup(project(pInFile, tmap_factranking(left)),all);

return common_factranking;

end;