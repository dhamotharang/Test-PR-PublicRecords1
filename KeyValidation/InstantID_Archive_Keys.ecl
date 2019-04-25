#workunit('name','KeyValidation - InstantID Archives');
#option('AllowAutoSwitchQueue', true);
#option('allowedClusters', 'thor50_dev02,thor50_dev');
import keyValidation, advfiles;

buildVersion := ADVFiles.CurrentBuildVersions.File(datasetname='InstantIDArchiveKeys' and envment='Q' and location = 'B' and cluster = 'N')[1].buildversion;
keyValidation.DesprayAndEmailSummary('IID', keyvalidation.ValidateInstantIDKeys(buildVersion, false), buildVersion, true);
