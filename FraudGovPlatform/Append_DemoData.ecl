import STD, FraudShared;
export Append_DemoData(string pversion) 
	:= if(_Flags.UseDemoData, 
			SEQUENTIAL(			
			STD.File.StartSuperFileTransaction(),
			STD.File.AddSuperFile(FraudShared.Filenames().Base.Main.Built,	Filenames().Input.DemoData.Sprayed)),			
			STD.File.FinishSuperFileTransaction()
	);