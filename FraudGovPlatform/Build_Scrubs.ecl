import Scrubs_MBS, Scrubs_FraudGov,FraudGovPlatform_Validation;
export Build_Scrubs(
    string pversion 
) := sequential(
    Scrubs_MBS.BuildSCRUBSReport(pversion),
    Scrubs_FraudGov.BuildSCRUBSReport(pversion)
);