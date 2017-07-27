import risk_indicators, models;

export GetFraudDefender(DATASET (risk_indicators.layout_input) input, string account_value, string20 TestDataTableName) := 

FUNCTION

	Test_Data_Table_Name := stringlib.stringtouppercase(TestDataTableName);
	
	// Add Fraud Defender data
	Models.layouts.FP_Layout_Model Add_FraudDefender(input Le, Key_frauddefender ri) :=Transform	
	
		self.AccountNumber := account_value;	
		self.description := ri.fd_model_description;
		rcs1 := dataset( [{ri.rc1,ri.rcdesc1},{ri.rc2,ri.rcdesc2},{ri.rc3,ri.rcdesc3},{ri.rc4,ri.rcdesc4}], Models.Layout_Reason_Codes );
		rcs2 := dataset( [{ri.rc1_2,ri.rcdesc1_2},{ri.rc2_2,ri.rcdesc2_2},{ri.rc3_2,ri.rcdesc3_2},{ri.rc4_2,ri.rcdesc4_2}], Models.Layout_Reason_Codes );
		rcs3 := dataset( [{ri.rc1_3,ri.rcdesc1_3},{ri.rc2_3,ri.rcdesc2_3},{ri.rc3_3,ri.rcdesc3_3},{ri.rc4_3,ri.rcdesc4_3}], Models.Layout_Reason_Codes );

		risk_indicators.MAC_add_sequence(rcs1, rcs1_with_seq);
		risk_indicators.MAC_add_sequence(rcs2, rcs2_with_seq);
		risk_indicators.MAC_add_sequence(rcs3, rcs3_with_seq);
	
		scores_temp := dataset( [{ri.score1, ri.Description1, ri.index1, rcs1_with_seq(reason_code <>'')},
															{ri.score2, ri.Description2, ri.index2, rcs2_with_seq(reason_code <>'')},
															{ri.score3, ri.Description3, ri.index3, rcs3_with_seq(reason_code <>'')}
														], Models.Layout_Score );	
		
		// todo:  when the testseeds are updated to include the FraudIndices, map those values from the key	in the inline datasets and remove this extra project
		self.scores := project(scores_temp, transform(Models.Layouts.Layout_Score_FP , self := left, self := []));  
	
		self := ri;	
		self := [];	
	END;
	// Join the input data to the fraud defender key
	WithFraudDefender := Join(input, Key_frauddefender, 
														keyed(right.dataset_name=Test_Data_Table_Name) and 
														keyed(right.hashvalue=Seed_Files.Hash_InstantID((string20)left.fname,(string20)left.lname,(string9)left.ssn,Risk_Indicators.nullstring,
																																		(string5)left.in_zipCode,(string10)left.phone10,Risk_Indicators.nullstring)), 
												Add_FraudDefender(LEFT, RIGHT), LEFT OUTER, KEEP(1));	
												
											
						
	RETURN WithFraudDefender;
	
END;