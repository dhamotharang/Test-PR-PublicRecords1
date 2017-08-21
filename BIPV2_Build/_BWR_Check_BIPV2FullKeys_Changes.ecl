/*
  check all keys in bipv2fullkeys package for any layout discrepancies.
  look into the workunits dataset result to find all the workunits and any errors that may occur
  the ones that fail are the ones that need their layouts updated in prte.
*/
import wk_ut,tools,_control;

pversion := '20151014';

ecl		  := '#workunit(\'name\',\'BIPV2_Build.BIPV2FullKeys_Package @version@-@iteration@\');\n' 
         + 'BIPV2_Build.BIPV2FullKeys_Package(\'@version@\',,@iteration@).outputpackage;\n';

kickBuild := wk_ut.mac_ChainWuids(ecl,1,46,pversion,,wk_ut._Constants.LocalHthor,pOutputEcl := false,pNotifyEmails := _control.MyInfo.EmailAddressNotify,pPollingFrequency := '1'
,pForceSkip := true);

kickBuild;