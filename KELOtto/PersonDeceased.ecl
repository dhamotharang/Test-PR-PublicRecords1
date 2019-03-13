IMPORT KELOtto, FraudGovPlatform;

PersonDeceasedFile := FraudGovPlatform.files(,KELOtto.Constants.useOtherEnvironmentDali).base.Death.built;

EXPORT PersonDeceased := PersonDeceasedFile;

