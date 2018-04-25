EXPORT BWR_VendorSrc_BuildAll(version) := MACRO

#WORKUNIT('name','VendorSrc load ' + version);

DoBuild := Misc.fBuild_All_VendorSrc(version);

SampleRecs :=	SAMPLE(Misc.Files_VendorSrc(version).Combined_Base,50,1);
					
SEQUENTIAL(
			DoBuild,
	OUTPUT(SampleRecs));

 ENDMACRO;
// ***Note about orbit report:
// 			RBecker Reports
// 			Riskview and FFD Report
// 			export - csv
// 			REMOVE:
// 				source_sourceCodes2
// 				fcra1
// 				fcra_comments1
// 				Comments
// 				MarketingRestrictionsComments2
// 				ContactCat_Name
// 				Contact_Name
// 				Contact_Phone
// 				Contact_Email
// 				Finally, remove the label line.
// This HAS to be done or else the record layout won't match.
 