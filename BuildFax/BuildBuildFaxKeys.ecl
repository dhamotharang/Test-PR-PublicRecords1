EXPORT BuildBuildFaxKeys (STRING buildDate) := FUNCTION
CustomerTestVal     := 'N':STORED('CustomerTestEnv');
isCust							:= CustomerTestVal = 'Y';
x1 := IF (~isCust, BuildFax.BuildExports(buildDate, Constants().contractor).SprayBuild_Base, OUTPUT('contractorCT Not Implemented'));
x2 := IF (~isCust, BuildFax.BuildExports(buildDate, Constants().correction).SprayBuild_Base, OUTPUT('correctionsForCT Not Implemented'));
x3 := IF (~isCust, BuildFax.BuildExports(buildDate, Constants().inspection).SprayBuild_Base, OUTPUT('inspectionForCT Not Implemented'));
x4 := IF (~isCust, BuildFax.BuildExports(buildDate, Constants().permit).SprayBuild_Base, OUTPUT('permitForCT Not Implemented'));
x5 := IF (~isCust, BuildFax.BuildExports(buildDate, Constants().property).SprayBuild_Base, OUTPUT('propertyForCT Not Implemented'));
x6 := IF (~isCust, BuildFax.BuildExports(buildDate, Constants().permitcontractor).SprayBuild_Base, OUTPUT('permitcontractorForCT Not Implemented'));
x7 := IF (~isCust, BuildFax.BuildExports(buildDate, Constants().jurisdiction).SprayBuild_Base, OUTPUT('jurisdictionForCT Not Implemented'));
x8 := IF (~isCust, BuildFax.BuildExports(buildDate, Constants().StreetLookup).SprayBuild_Base, OUTPUT('StreetLookupForCT Not Implemented'));
SlimBase						:= BuildFax.BuildSlimBase(buildDate);
keyCreation					:= BuildFax.BuildKeys(buildDate);
finalRes						:= SEQUENTIAL(x1, x2, x3, x4, x5, x6, x7, x8, SlimBase, keyCreation) : SUCCESS(Send_EMail(Constants().QC_email_target, buildDate).BuildSuccess), 
                                                                                           FAILURE(Send_EMail(Constants().QC_email_target, buildDate).BuildError);

RETURN finalRes;
END;