IMPORT KELOtto, FraudGovPlatform, FraudShared;

//to switch dali environment go to KELOtto.Constants and change useProdData 

#constant('Platform','FraudGov'); 

output(KELOtto.Constants.useOtherEnvironmentDali, named('useOtherEnvironment'));

output(FraudGovPlatform.filenames(,KELOtto.Constants.useOtherEnvironmentDali).base.CIID.built, named('CIIDFilename'));
output(FraudShared.filenames(,KELOtto.Constants.useOtherEnvironmentDali).base.Main.built, named('FraudgovFilename'));
output(FraudGovPlatform.filenames(,KELOtto.Constants.useOtherEnvironmentDali).base.Crim.built, named('CrimFilename'));
output(FraudGovPlatform.filenames(,KELOtto.Constants.useOtherEnvironmentDali).base.Death.built, named('DeceasedFilename'));
output(FraudGovPlatform.filenames(,KELOtto.Constants.useOtherEnvironmentDali).base.FraudPoint.built, named('FraudPointFilename'));


output(FraudGovPlatform.files(,KELOtto.Constants.useOtherEnvironmentDali).base.CIID.built, named('CIID'));
output(FraudShared.files(,KELOtto.Constants.useOtherEnvironmentDali).base.Main.built, named('Fraudgov'));
output(FraudGovPlatform.files(,KELOtto.Constants.useOtherEnvironmentDali).base.Crim.built, named('Crim'));
output(FraudGovPlatform.files(,KELOtto.Constants.useOtherEnvironmentDali).base.Death.built, named('Deceased'));
output(FraudGovPlatform.files(,KELOtto.Constants.useOtherEnvironmentDali).base.FraudPoint.built, named('FraudPoint'));