/*The following files have to be updated to point to prod version of files:
	BankruptcyV2.file_bankruptcy_search_v3_supp_bip
	BankruptcyV2.file_bankruptcy_main_v3_supplemented
	BankruptcyV2.file_bankruptcy_search
	Header.file_header_wa
*/
#workunit('name','KeyValidation - BK');
#option('AllowAutoSwitchQueue', true);
#option('allowedClusters', 'thor50_dev02,thor50_dev');
import keyValidation, advfiles;

buildVersion := advfiles.CurrentBuildVersions.File(datasetname='BankruptcyV2Keys' and envment='P' and location = 'B' and cluster = 'N')[1].buildversion;

keyValidation.DesprayAndEmailSummary('BK', keyvalidation.validateBankruptcyKeys(buildVersion, false), buildVersion, true);

 