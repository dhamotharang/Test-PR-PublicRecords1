import STD, FraudShared;
export Append_DemoData(string pversion) 
	:= STD.File.AddSuperFile(FraudShared.Filenames().Base.Main.Built,	$.Filenames().Input.DemoData.Sprayed);