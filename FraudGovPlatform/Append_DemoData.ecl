import STD, FraudShared;
export Append_DemoData(string pversion) := SEQUENTIAL(			
			STD.File.StartSuperFileTransaction(),
			if(_Flags.UseDemoData, 
				STD.File.AddSuperFile(FraudShared.Filenames().Base.Main.Built,	Filenames().Input.DemoData.Sprayed)),			
			STD.File.FinishSuperFileTransaction());