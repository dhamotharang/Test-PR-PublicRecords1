import Models, Seed_Files;

export FraudPoint_TestSeed_Function(dataset(Layout_Input) inData, string20 TestDataTableName) := FUNCTION

	Test_Data_Table_Name := stringlib.stringtouppercase(TestDataTableName);
	
	temp_layout := record
	Models.Layouts.layout_fp1109;
	string score_2;
	dataset(Risk_Indicators.Layout_Desc) ri_2;
 	end;
		
	temp_layout create_output(inData le, Seed_Files.Key_FraudPoint rt) := TRANSFORM
		reason_codes := dataset([
			{rt.hri,rt.hri_desc},
			{rt.hri2,rt.hri2_desc},
			{rt.hri3,rt.hri3_desc},
			{rt.hri4,rt.hri4_desc},
			{rt.hri5,rt.hri5_desc},
			{rt.hri6,rt.hri6_desc}
			], Layout_Desc);

		self.score := rt.score;
		self.score_2 := rt.score_2;
		reason_codes_2 := dataset([
			{rt.hri_2,rt.hri_desc_2},
			{rt.hri2_2,rt.hri2_desc_2},
			{rt.hri3_2,rt.hri3_desc_2},
			{rt.hri4_2,rt.hri4_desc_2},
			{rt.hri5_2,rt.hri5_desc_2},
			{rt.hri6_2,rt.hri6_desc_2}
			], Layout_Desc);
		self.ri := reason_codes( hri!='00' );
		self.ri_2 := reason_codes_2( hri!='00' );
		self.seq := le.seq;
		self := rt;
	END;		
	

	FraudPoint_rec := join(inData, Seed_Files.Key_FraudPoint,
														keyed(right.dataset_name=Test_Data_Table_Name) and 
														keyed(right.hashvalue=Seed_Files.Hash_InstantID(
															(string20)left.fname,
															(string20)left.lname,
															(string9)left.ssn,
															risk_indicators.nullstring,
															(string5)left.in_zipcode,
															(string10)left.phone10,
															risk_indicators.nullstring
														)),
														create_output(LEFT,RIGHT), LEFT OUTER, KEEP(1)
													);
	fp_rec := normalize(fraudpoint_rec, 2, transform(Models.Layouts.layout_fp1109, 
																										self.score := if(counter = 1, left.score, left.score_2), 
																										self.ri := if(counter = 1, left.ri, left.ri_2), 
																										self := left));

	final_fp_rec := fp_rec(score <> '');

	return final_fp_rec;
END;