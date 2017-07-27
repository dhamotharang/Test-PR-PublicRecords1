import Models, Seed_Files;

export RVTelecom_TestSeed_Function(dataset(Layout_Input) inData, string30 account_value, string20 TestDataTableName) := 
				
FUNCTION
	
	Test_Data_Table_Name := stringlib.stringtouppercase(TestDataTableName);
	
	layout_rvTelecomSeq := RECORD
		unsigned4 seq;
		Models.Layout_Model;
	END;
	
	layout_rvTelecomSeq create_output(inData le, Seed_Files.Key_RVTelecom ri) := TRANSFORM
		reason_codes := dataset([{ri.hri,ri.hri_desc},{ri.hri2,ri.hri2_desc},{ri.hri3,ri.hri3_desc},{ri.hri4,ri.hri4_desc}], Models.Layout_Reason_Codes);
		scores := dataset([{ri.score,ri.model_name,'3',reason_codes}], Models.Layout_Score);
		
		self.accountnumber := account_value;
		self.description := ri.service_name;
		self.scores := scores;
		self.seq := le.seq;
	END;
	RiskView_rec := join(inData, Seed_Files.Key_RVTelecom,keyed(right.dataset_name=Test_Data_Table_Name) and 
												  keyed(right.hashvalue=Seed_Files.Hash_InstantID((string15)left.fname,(string20)left.lname,
														(string9)left.ssn,'',(string9)(left.z5+left.zip4),(string10)left.phone10,'')),
												create_output(LEFT,RIGHT), LEFT OUTER, KEEP(1));
	
	
	
	return RiskView_rec;
END;