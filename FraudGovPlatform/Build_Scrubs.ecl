import Scrubs_MBS, Scrubs_FraudGov,FraudGovPlatform_Validation;
export Build_Scrubs(
    string pversion, 
    dataset(Layouts.Flags.SkipModules) pSkipModules = FraudGovPlatform.Files().Flags.SkipModules,
    string emailList=FraudGovPlatform_Validation.Mailing_List().Alert
) := sequential(
    Scrubs_MBS.BuildSCRUBSReport(pversion, emailList),
    Scrubs_FraudGov.BuildSCRUBSReport(pversion, pSkipModules, emailList)
);