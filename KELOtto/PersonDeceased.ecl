﻿IMPORT KELOtto, FraudGovPlatform;
RunKelDemo :=false:stored('RunKelDemo');

PersonDeceasedFile := If(RunKelDemo=false,FraudGovPlatform.files(,KELOtto.Constants.useOtherEnvironmentDali).base.Death.built
												,FraudGovPlatform.files(,KELOtto.Constants.useOtherEnvironmentDali).base.Death_Demo.built);
								
EXPORT PersonDeceased := PersonDeceasedFile;


