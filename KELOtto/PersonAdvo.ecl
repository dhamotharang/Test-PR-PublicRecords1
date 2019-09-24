IMPORT KELOtto, FraudGovPlatform;
RunKelDemo :=false:stored('RunKelDemo');

/*
FileIn := If(RunKelDemo=false,FraudGovPlatform.files(,False).base.Advo.built
									,FraudGovPlatform.files(,False).base.Advo_Demo.built); 
*/
FileIn := If(RunKelDemo=false,FraudGovPlatform.files(,KELOtto.Constants.useOtherEnvironmentDali).base.Advo.built
									,FraudGovPlatform.files(,KELOtto.Constants.useOtherEnvironmentDali).base.Advo_Demo.built); 
									
EXPORT PersonAdvo := FileIn;