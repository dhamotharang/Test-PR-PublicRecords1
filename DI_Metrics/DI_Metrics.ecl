//With automation, I'll have many ECL calls for different files. This attribute file will contain all the datasets. 
//when this is merged into git, I'll have to update the path where the file resides, i.e.,  DI_Metrics.FCRA_ASL_Students
//pHostname := 'uspr-edata12.risk.regn.net'
//pTarget := '/data/Builds/builds/DI_Metrics/'
//pContact := 'cleophus.johnson@lexisnexisrisk.com'

export DI_Metrics(string pHostname, string pTarget, string pContact ='\' \'') := function

SEQUENTIAL(

FCRA_ASL_Students(pHostname, pTarget, pContact)

,FCRA_Bankruptcy(pHostname, pTarget, pContact)

,FCRA_Criminal(pHostname, pTarget, pContact)

,FCRA_EDA_GONG(pHostname, pTarget, pContact)

//,FCRA_Emails(pHostname, pTarget, pContact) //FCRA_Emails is a completely different type of process at this point and does NOT need to be included (yet)

,FCRA_Criminal(pHostname, pTarget, pContact)

,FCRA_Liens_Judgments_Evictions(pHostname, pTarget, pContact)

,FCRA_PAW(pHostname, pTarget, pContact)

,FCRA_People_Header_and_Prof_Licenses(pHostname, pTarget, pContact)

,FCRA_Property_By_DocType(pHostname, pTarget, pContact)

,FCRA_Property_By_LandUse(pHostname, pTarget, pContact)

,FCRA_Watercraft(pHostname, pTarget, pContact)

);

end;