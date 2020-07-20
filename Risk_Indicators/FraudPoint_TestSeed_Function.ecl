import Models, Risk_Indicators, Seed_Files, STD, UT;

export FraudPoint_TestSeed_Function(dataset(Risk_Indicators.Layout_Input) inData, string20 TestDataTableName, String20 ModelName) := FUNCTION

  Test_Data_Table_Name := STD.STR.ToUpperCase(TestDataTableName);
  in_Model_Name := STD.STR.ToUpperCase(ModelName);
	
  Models.Layouts.Enhanced_layout_fp1109 create_output(inData le, Seed_Files.Key_FraudPoint rt) := TRANSFORM
    reason_codes := dataset([
        {rt.hri,rt.hri_desc},
        {rt.hri2,rt.hri2_desc},
        {rt.hri3,rt.hri3_desc},
        {rt.hri4,rt.hri4_desc},
        {rt.hri5,rt.hri5_desc},
        {rt.hri6,rt.hri6_desc}
        ], Layout_Desc);

    self.score := rt.score;
    self.ri := reason_codes( hri!='00' );
    self.model_name := rt.model_name;
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
                                              )) and
                        ut.nneq(right.model_name, in_Model_Name),
                        create_output(LEFT,RIGHT), LEFT OUTER, KEEP(3)
                        );

  fp_rec := Project(fraudpoint_rec, transform(Models.Layouts.Enhanced_layout_fp1109,
                                                    //To be backwards compatible, if model name from the key is blank use the input model name so we can have a model description in the service
                                                    self.model_name := IF(left.model_name != '', left.model_name, in_Model_Name), 
                                                    self.score := left.score, 
                                                    self.ri := left.ri, 
                                                    self := left));

sorted_final_rec := sort(fp_rec,-model_name);
final_fp_rec := sorted_final_rec[1];  

return final_fp_rec;
END;