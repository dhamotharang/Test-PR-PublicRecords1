/*
  check all prte keys in bipv2fullkeys package for any layout discrepancies.
  look into the workunits dataset result to find all the workunits and any errors that may occur
  if anything fails, tell it to skip it.  I am working on a parameter to the mac_chainwuids macro that will force it to skip all failures
  that would make this faster and less time intensive.
*/
import wk_ut,tools,_control;

pversion := '20150626';

ecl		  := '#workunit(\'name\',\'BIPV2_Build.PRTE_BIPV2FullKeys_Package @version@-@iteration@\');\n' 
         + 'BIPV2_Build.PRTE_BIPV2FullKeys_Package(\'@version@\',,@iteration@).outputpackage;\n';

kickBuild := wk_ut.mac_ChainWuids(ecl,1,46,pversion,,wk_ut._Constants.LocalHthor,pOutputEcl := false,pNotifyEmails := _control.MyInfo.EmailAddressSender,pPollingFrequency := '1'
);

kickBuild;