/* ********************************************************************************************************************
From: Sivakumar, Viswanathan Kodumudi (RIS-ATL) 
Sent: Thursday, October 19, 2017 2:59 PM
To: ALP-Cust Test Technology <alp-cust.test.tech@risk.lexisnexis.com>
Subject: RE: Demo - Usage of Thor file comparator

Hi,

This is the documentation for file comparison , to compare between 2 files either base or key.


STRING __sFile1Name - File1 Name REQUIRED
STRING __sFile2Name - File2 Name REQUIRED
STRING __sUniqueIdentifierFields – Comma delimited field list that uniquely identifies the records in both the files REQUIRED
STRING __sComparisonFields OPTIONAL
•	Default Value: 'ALL'
•	Values:
1.	'ALL'- all the fields are included in the comparison report
2.	To include only some certain fields, provide a comma delimited list of fields
3.	To exclude only some certain fields, provide a comma delimited list of fields prefixed with '-'
STRING __sOutputReportName REQUIRED
•	Values:
1.	Can be a short handle which will then be appended to an aft report string. For eg. if vr_aftteststring is the short handle, ins::qa::aft::reports::vr_aftteststring is the name of the output file that is generated, along with corresponding secondary reports with a similar naming pattern
2.	A complete output path
STRING __sValidateInput OPTIONAL
•	Default Value: 'N'
•	Values:
1.	'N' - Input is not validated for uniqueness of __sUniqueIdentifierFields list
2.	'Y' or any other value - Input is validated, workunit fails with an exception saying: ‘Invalid Unique Key , kindly provide proper Unique Keys’
STRING __sIncludeSecondaryReports OPTIONAL
•	Default Value: 'N'
•	Values:
1.	'ALL' - All reports are included
2.	'StatsOnly' - Along with the complete comparison report, only the stats distribution report and related reports are included
3.	'VerticalComparison' - Along with the complete comparison report, only the vertical comparison report is included
STRING __sIPAddress OPTIONAL
•	Default Value: 'http://10.194.10.2:8010' (alpha dev)
STRING __sClusterName OPTIONAL
•	Default Value: 'thor50_42'
STRING __sQueue OPTIONAL
•	Default Value: ''
Example Call: 
	AFTv1.fCompareFiles('<File 1 >', '< File 2>','<Unique Fields>', '<Comparison Fields>','<Output Report Name>');


*/

IMPORT Data_Services;

// file1 := '~thor::base::ct::insheaddldeath::qa::alldata';   // File Name may be the dev one
// file2 := '~' + Data_Services.foreign_prod + 'thor::base::ct::insheaddldeath::qa::alldata'; // File 2 may be another file in prod or dev.

file1 := '~prte::in::prte2::watercraft::20180119a::alldataslim_alpha';
file2 := '~prte::in::prte2::watercraft::20180119::alldataslim_alpha'


key_fields := 'uniqueid,last_name,first_name,middle_name';
comparison_fields := 'all';  // the fields to compare , if we want to ignore few fields to compare we can specify as -<field list> like –field1,field2
ResultFile := 'vis_custtest_res';


AFTv1.fCompareFiles(  File1
											, File2
											, key_fields
											, comparison_fields
											, ResultFile 
											, 'N' 
											,  'ALL');

