import risk_indicators, models, business_risk;

export GetBusinessDefender(DATASET (business_risk.Layout_Input) input, string AccountNumber_value, string20 TestDataTableName) := 

FUNCTION

	Test_Data_Table_Name := stringlib.stringtouppercase(TestDataTableName);
	
	Models.Layout_Model make_models(input le, Key_BusinessDefender ri):=transform
		self.AccountNumber := AccountNumber_value;
		self.Description := ri.fd_model_description;
		
		reasoncodes1 := dataset([{ri.fd_Reason1,ri.fd_Desc1},{ri.fd_Reason2,ri.fd_Desc2},{ri.fd_Reason3,ri.fd_Desc3},{ri.fd_Reason4,ri.fd_Desc4}],models.Layout_Reason_Codes);
		reasoncodes2 := dataset([{ri.fd_Reason12,ri.fd_Desc12},{ri.fd_Reason22,ri.fd_Desc22},{ri.fd_Reason32,ri.fd_Desc32},{ri.fd_Reason42,ri.fd_Desc42}],models.Layout_Reason_Codes);
		reasoncodes3 := dataset([{ri.fd_Reason13,ri.fd_Desc13},{ri.fd_Reason23,ri.fd_Desc23},{ri.fd_Reason33,ri.fd_Desc33},{ri.fd_Reason43,ri.fd_Desc43}],models.Layout_Reason_Codes);
		
		risk_indicators.MAC_add_sequence(reasoncodes1, reasoncodes1_with_seq);
		risk_indicators.MAC_add_sequence(reasoncodes2, reasoncodes2_with_seq);
		risk_indicators.MAC_add_sequence(reasoncodes3, reasoncodes3_with_seq);
		
		self.Scores := dataset([{ri.fd_score1,ri.description1,ri.index1, reasoncodes1_with_seq(reason_code <>'')},
														{ri.fd_score2,ri.description2,ri.index2, reasoncodes2_with_seq(reason_code <>'')},
														{ri.fd_score3,ri.description3,ri.index3, reasoncodes3_with_seq(reason_code <>'')}],
										models.Layout_Score);
	END;	
	WithBusinessDefender := Join(input, Key_BusinessDefender,
																keyed(right.dataset_name=Test_Data_Table_Name) and 
																keyed(right.hashvalue=Seed_Files.Hash_InstantID((string20)left.rep_fname,(string20)left.rep_lname,
																			Risk_Indicators.nullstring,(string9)left.fein,(string5)left.z5,(string10)left.phone10,(string30)left.company_name)), 
													make_models(LEFT, RIGHT), LEFT OUTER, KEEP(1));	
												
													
	RETURN WithBusinessDefender;
	
END;