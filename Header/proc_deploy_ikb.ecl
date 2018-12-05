IMPORT dops,std;
EXPORT proc_deploy_ikb(string emailList, string rpt_qa_email_list) := FUNCTION

// Get versions for packages from DOPS
ver_lab_cert_ver := dops.GetBuildVersion('PersonLabKeys','B','N','C')[1..8];
ver_lab_prod_ver := dops.GetBuildVersion('PersonLabKeys','B','N','P')[1..8];
ver_fcra_cert_ver := dops.GetBuildVersion('FCRA_PersonHeaderKeys','B','F','C')[1..8];
ver_fcra_prod_ver := dops.GetBuildVersion('FCRA_PersonHeaderKeys','B','F','P')[1..8];
ver_wkly_cert_ver := dops.GetBuildVersion('PersonHeaderWeeklyKeys','B','N','C')[1..8];
ver_wkly_prod_ver := dops.GetBuildVersion('PersonHeaderWeeklyKeys','B','N','P')[1..8];

// These may change if the build process changes
lastUpdatedLabQA_SF:='~thor400_36::key::insuranceheader_xlink::qa::header';
lastUpdatesFCRAqa_SF:='~thor_data400::key::fcra::header::address_rank_qa';
lastUpdatesWklyQA_SF:='~thor_data400::key::header::qa::addr_unique_expanded';

// Gets the version from the latest QA file on Thor
lastestIkbVersionOnThor  := regexfind('[0-9]{8}', std.file.superfilecontents(lastUpdatedLabQA_SF)[1].name, 0);
lastestFCRAversionOnThor := regexfind('[0-9]{8}', std.file.superfilecontents(lastUpdatesFCRAqa_SF)[1].name, 0);
lastestWklyversionOnThor := regexfind('[0-9]{8}', std.file.superfilecontents(lastUpdatesWklyQA_SF)[1].name, 0);

// back door to skip deployments. Create a dummy file to hold off the deployment, and delete when all clear
dontskip_ikb:=~std.file.fileexists('~thor_data400::header::ikb::skip_dops_ikb');
dontskip_fcra:=~std.file.fileexists('~thor_data400::header::ikb::skip_dops_fcra');
dontskip_wkly:=~std.file.fileexists('~thor_data400::header::ikb::skip_dops_weekly');

// Check each package for skips or availability of CERT for deployment
ikbShouldUpdate := ( dontskip_ikb  AND lastestIkbVersionOnThor  > ver_lab_cert_ver  AND ver_lab_cert_ver  = ver_lab_prod_ver );
fcraShouldUpdate:= ( dontskip_fcra AND lastestFCRAversionOnThor > ver_fcra_cert_ver AND ver_fcra_cert_ver = ver_fcra_prod_ver);
wklyShouldUpdate:= ( dontskip_wkly AND lastestWklyversionOnThor > ver_wkly_cert_ver AND ver_wkly_cert_ver = ver_wkly_prod_ver);

// Generates a report prior to deployment
output(dataset([
    {'labKeys',ver_lab_cert_ver,ver_lab_prod_ver,lastestIkbVersionOnThor,ikbShouldUpdate},
    {'fcraKeys',ver_fcra_cert_ver,ver_fcra_prod_ver,lastestFCRAversionOnThor,fcraShouldUpdate},
    {'wklyKeys',ver_wkly_cert_ver,ver_wkly_prod_ver,lastestWklyversionOnThor,wklyShouldUpdate}
],{string package, string cert, string prod_roxie, string latestThorVersion,string dopsToUpdate}),named('decision_report'));

noSkip:='000';
skipPackage:= if(ikbShouldUpdate,'0','1')+  // 'skipPackage[1]'
              if(fcraShouldUpdate,'0','1')+ // 'skipPackage[2]'
              if(wklyShouldUpdate,'0','1'); // 'skipPackage[3]'

// calls deployment with skip parameters
RETURN header.Proc_Copy_From_Alpha_Incrementals().deploy(emailList,rpt_qa_email_list,skipPackage);

END;