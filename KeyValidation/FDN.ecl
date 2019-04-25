#workunit('name','KeyValidation - FDN');
#option('AllowAutoSwitchQueue', true);
#option('allowedClusters', 'thor50_dev02,thor50_dev');
import keyValidation, advfiles;

buildVersion := advFiles.FDN.buildVersion;

keyValidation.DesprayAndEmailSummary('FDN', keyvalidation.validateFDNKeys(buildVersion, false), buildVersion, true);


 