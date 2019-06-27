import STD, FraudShared;
export Append_DemoData(string pversion) := SEQUENTIAL(			
			STD.File.StartSuperFileTransaction(),
			//STD.File.RemoveSuperFile(FraudShared.Filenames().Base.Main.Father,	Filenames().Input.DemoData.Sprayed),
			STD.File.ClearSuperFile(FraudGovPlatform.Filenames().Base.Main_Orig.Built),
			STD.File.AddSuperFile(FraudGovPlatform.Filenames().Base.Main_Orig.Built,	FraudShared.Filenames(pversion).Base.Main.New),
			STD.File.ClearSuperFile(FraudShared.Filenames().Base.Main.Built),
			STD.File.AddSuperFile(FraudShared.Filenames().Base.Main.Built,	Filenames(pversion).Base.Main_Anon.New),
			if(_Flags.UseDemoData, 
				STD.File.AddSuperFile(FraudShared.Filenames().Base.Main.Built,	Filenames().Input.DemoData.Sprayed)),			
			STD.File.FinishSuperFileTransaction());