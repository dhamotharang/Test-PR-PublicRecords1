import STD, FraudShared;
export Append_DemoData(string pversion) := SEQUENTIAL(			
        STD.File.StartSuperFileTransaction(),
	   
			STD.File.RemoveSuperFile(FraudShared.Filenames().Base.Main.Father,Filenames().Input.DemoData.Sprayed),

        STD.File.ClearSuperFile(FraudGovPlatform.Filenames().Base.Main_Orig.Built),
        STD.File.ClearSuperFile(FraudGovPlatform.Filenames().Base.Main_Orig.QA),

        STD.File.AddSuperFile(FraudGovPlatform.Filenames().Base.Main_Orig.Built,	FraudShared.Filenames(pversion).Base.Main.New),
        STD.File.AddSuperFile(FraudGovPlatform.Filenames().Base.Main_Orig.QA,			FraudShared.Filenames(pversion).Base.Main.New),	
        
        STD.File.ClearSuperFile(FraudShared.Filenames().Base.Main.Built),
        STD.File.ClearSuperFile(FraudShared.Filenames().Base.Main.QA),			

        STD.File.AddSuperFile(FraudShared.Filenames().Base.Main.Built,	Filenames(pversion).Base.Main_Anon.New),
        STD.File.AddSuperFile(FraudShared.Filenames().Base.Main.QA,			Filenames(pversion).Base.Main_Anon.New),
		if(_Flags.UseDemoData, 
				STD.File.AddSuperFile(FraudShared.Filenames().Base.Main.Built,	Filenames().Input.DemoData.Sprayed),
				STD.File.AddSuperFile(FraudShared.Filenames().Base.Main.QA,		Filenames().Input.DemoData.Sprayed)        		
		),
        
        

		STD.File.RemoveSuperFile(FraudShared.Filenames().Base.Main.Father,	Filenames().Input.DemoData.Sprayed);

        STD.File.FinishSuperFileTransaction());