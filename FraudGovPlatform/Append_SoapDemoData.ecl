Import STD;
EXPORT Append_SoapDemoData := Module


Export Base_Clear	:= Sequential(
											STD.File.StartSuperFileTransaction()
											,STD.File.RemoveSuperFile(FraudGovPlatform.Filenames().Base.Ciid.qa,FraudGovPlatform.Filenames().Base.Ciid_Demo.qa)
											,STD.File.RemoveSuperFile(FraudGovPlatform.Filenames().Base.ciid.Built,FraudGovPlatform.Filenames().Base.Ciid_Demo.qa)
											,STD.File.RemoveSuperFile(FraudGovPlatform.Filenames().Base.crim.qa,FraudGovPlatform.Filenames().Base.crim_Demo.qa)
											,STD.File.RemoveSuperFile(FraudGovPlatform.Filenames().Base.crim.Built,FraudGovPlatform.Filenames().Base.crim_Demo.qa)
											,STD.File.RemoveSuperFile(FraudGovPlatform.Filenames().Base.death.qa,FraudGovPlatform.Filenames().Base.death_Demo.qa)
											,STD.File.RemoveSuperFile(FraudGovPlatform.Filenames().Base.death.Built,FraudGovPlatform.Filenames().Base.death_Demo.qa)
											,STD.File.RemoveSuperFile(FraudGovPlatform.Filenames().Base.FraudPoint.qa,FraudGovPlatform.Filenames().Base.FraudPoint_Demo.qa)
											,STD.File.RemoveSuperFile(FraudGovPlatform.Filenames().Base.FraudPoint.Built,FraudGovPlatform.Filenames().Base.FraudPoint_Demo.qa)
											,STD.File.RemoveSuperFile(FraudGovPlatform.Filenames().Base.IpMetaData.qa,FraudGovPlatform.Filenames().Base.IpMetaData_Demo.qa)
											,STD.File.RemoveSuperFile(FraudGovPlatform.Filenames().Base.IpMetaData.Built,FraudGovPlatform.Filenames().Base.IpMetaData_Demo.qa)
											,STD.File.FinishSuperFileTransaction()
											);

Export Base_Set	:= Sequential(
											STD.File.StartSuperFileTransaction()
											,STD.File.AddSuperFile(FraudGovPlatform.Filenames().Base.Ciid.qa,FraudGovPlatform.Filenames().Base.Ciid_Demo.qa)
											,STD.File.AddSuperFile(FraudGovPlatform.Filenames().Base.ciid.Built,FraudGovPlatform.Filenames().Base.Ciid_Demo.qa)
											,STD.File.AddSuperFile(FraudGovPlatform.Filenames().Base.crim.qa,FraudGovPlatform.Filenames().Base.crim_Demo.qa)
											,STD.File.AddSuperFile(FraudGovPlatform.Filenames().Base.crim.Built,FraudGovPlatform.Filenames().Base.crim_Demo.qa)
											,STD.File.AddSuperFile(FraudGovPlatform.Filenames().Base.death.qa,FraudGovPlatform.Filenames().Base.death_Demo.qa)
											,STD.File.AddSuperFile(FraudGovPlatform.Filenames().Base.death.Built,FraudGovPlatform.Filenames().Base.death_Demo.qa)
											,STD.File.AddSuperFile(FraudGovPlatform.Filenames().Base.FraudPoint.qa,FraudGovPlatform.Filenames().Base.FraudPoint_Demo.qa)
											,STD.File.AddSuperFile(FraudGovPlatform.Filenames().Base.FraudPoint.Built,FraudGovPlatform.Filenames().Base.FraudPoint_Demo.qa)
											,STD.File.AddSuperFile(FraudGovPlatform.Filenames().Base.IpMetaData.qa,FraudGovPlatform.Filenames().Base.IpMetaData_Demo.qa)
											,STD.File.AddSuperFile(FraudGovPlatform.Filenames().Base.IpMetaData.Built,FraudGovPlatform.Filenames().Base.IpMetaData_Demo.qa)
											,STD.File.FinishSuperFileTransaction()
											);
											
END;