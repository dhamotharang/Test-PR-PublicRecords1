IMPORT dops,std,PromoteSupers;
EXPORT proc_deploy_ikb(string emailList, string rpt_qa_email_list) := FUNCTION

// Get versions for packages from DOPS waiting to be deployed
ver_lab_TBD := Dops.GetBuildVersion('PersonLabKeys'//'PersonLABKeys' // DOPS package name  20190111
                    ,'B' // B - Boca, A - Alpharetta
                    ,'N' // N - Nonfcra, F - FCRA, S - Customer Supp, T - Customer Test, FS - FCRA Cust Support
                    ,'T' // C - Cert, P - Prod, T - Thor
                    ,dops.constants.dopsenvironment
                    );
ver_fcra_TBD := Dops.GetBuildVersion('FCRA_PersonHeaderKeys'//'PersonLABKeys' // DOPS package name  20190111
                    ,'B' // B - Boca, A - Alpharetta
                    ,'F' // N - Nonfcra, F - FCRA, S - Customer Supp, T - Customer Test, FS - FCRA Cust Support
                    ,'T' // C - Cert, P - Prod, T - Thor
                    ,dops.constants.dopsenvironment
                    );
ver_wkly_TBD := Dops.GetBuildVersion('PersonHeaderWeeklyKeys'//'PersonLABKeys' // DOPS package name  20190111
                    ,'B' // B - Boca, A - Alpharetta
                    ,'N' // N - Nonfcra, F - FCRA, S - Customer Supp, T - Customer Test, FS - FCRA Cust Support
                    ,'T' // C - Cert, P - Prod, T - Thor
                    ,dops.constants.dopsenvironment
                    );
                    
// Get versions for packages from DOPS
ver_lab_cert_ver := dops.GetBuildVersion('PersonLabKeys','B','N','C')[1..9];
ver_lab_prod_ver := dops.GetBuildVersion('PersonLabKeys','B','N','P')[1..9];
ver_fcra_cert_ver := dops.GetBuildVersion('FCRA_PersonHeaderKeys','B','F','C')[1..9];
ver_fcra_prod_ver := dops.GetBuildVersion('FCRA_PersonHeaderKeys','B','F','P')[1..9];
ver_wkly_cert_ver := dops.GetBuildVersion('PersonHeaderWeeklyKeys','B','N','C')[1..9];
ver_wkly_prod_ver := dops.GetBuildVersion('PersonHeaderWeeklyKeys','B','N','P')[1..9];

// Gets the version from the latest QA file on Thor
lastestIkbVersionOnThor  := header.Proc_Copy_From_Alpha_Incrementals().lastestIkbVersionOnThor;
lastestFCRAversionOnThor := header.Proc_Copy_From_Alpha_Incrementals().lastestFCRAversionOnThor;
lastestWklyversionOnThor := header.Proc_Copy_From_Alpha_Incrementals().lastestWklyversionOnThor;

// back door to skip deployments. Create a dummy file to hold off the deployment, and delete when all clear
dontskip_ikb:=~std.file.fileexists('~thor_data400::header::ikb::skip_dops_ikb');
dontskip_fcra:=~std.file.fileexists('~thor_data400::header::ikb::skip_dops_fcra');
dontskip_wkly:=~std.file.fileexists('~thor_data400::header::ikb::skip_dops_weekly');

// Check each package for skips or availability of CERT for deployment
ikbShouldUpdate := ( dontskip_ikb  AND lastestIkbVersionOnThor  > ver_lab_cert_ver  AND ver_lab_cert_ver  = ver_lab_prod_ver  AND lastestIkbVersionOnThor  <> ver_lab_TBD  AND ver_lab_TBD  = ver_lab_cert_ver);
fcraShouldUpdate:= ( dontskip_fcra AND lastestFCRAversionOnThor > ver_fcra_cert_ver AND ver_fcra_cert_ver = ver_fcra_prod_ver AND lastestFCRAversionOnThor <> ver_fcra_TBD AND ver_fcra_TBD = ver_fcra_cert_ver);
wklyShouldUpdate:= ( dontskip_wkly AND lastestWklyversionOnThor > ver_wkly_cert_ver AND ver_wkly_cert_ver = ver_wkly_prod_ver AND lastestWklyversionOnThor <> ver_wkly_TBD AND ver_wkly_TBD = ver_wkly_cert_ver);

// Generates a report prior to deployment
rpt := output(dataset([
    {'labKeys',ver_lab_cert_ver,ver_lab_prod_ver,lastestIkbVersionOnThor,ver_lab_TBD,dontskip_ikb,ikbShouldUpdate},
    {'fcraKeys',ver_fcra_cert_ver,ver_fcra_prod_ver,lastestFCRAversionOnThor,ver_fcra_TBD,dontskip_fcra,fcraShouldUpdate},
    {'wklyKeys',ver_wkly_cert_ver,ver_wkly_prod_ver,lastestWklyversionOnThor,ver_wkly_TBD,dontskip_wkly,wklyShouldUpdate}
],{string40 package, string10 cert, string10 prod_roxie, string10 latestThorVersion,string10 ver_TBD,Boolean dontskip,boolean dopsToUpdate}),named('decision_report'));

ikb_deploy_info_file:='~thor_data400::info::ikb::deployed_vesions';
deployedVersions:=dataset(ikb_deploy_info_file,{string9 version, UNSIGNED4 deploy_date},thor,OPT);
thorVersionDeployedBefore:=COUNT(deployedVersions(trim(version)=trim(lastestIkbVersionOnThor)))>0;

noSkip:='000';
skipPackage:= if(ikbShouldUpdate AND NOT thorVersionDeployedBefore  ,'0','1' )+  // 'skipPackage[1]'
              if(fcraShouldUpdate                                   ,'0','1' )+ // 'skipPackage[2]'
              if(wklyShouldUpdate                                   ,'0','1' ); // 'skipPackage[3]'

m1:=if(thorVersionDeployedBefore,'IKB version '+lastestIkbVersionOnThor+' has been deployed before. If needed, please deploy by other means.\n','');

// update deployment history file
newDeployedRecords:=dataset([{lastestIkbVersionOnThor, STD.Date.Today()}],{string9 version, UNSIGNED4 deploy_date})+deployedVersions;
PromoteSupers.MAC_SF_BuildProcess(newDeployedRecords,ikb_deploy_info_file, PostVer ,2,,true,thorlib.wuid());
updateIKBversionsDeployed:=PostVer;

PartialUpdateMsg:='Skip Deployment: lab,fcra,weekly='+skipPackage+' See:'+workunit+'\n\n'+m1;

// calls deployment with skip parameters
doIt :=   sequential(
           rpt
           ,if(skipPackage <> '000', std.system.Email.SendEmail(emailList,'SKIPPING SOME OR ALL IKB DEPLOYMENTS',PartialUpdateMsg))
           ,if(skipPackage = '111'
                ,output('No New Data Available for Deployment')
                ,sequential(
                     header.Proc_Copy_From_Alpha_Incrementals().deploy(emailList,rpt_qa_email_list,skipPackage)
                    ,updateIKBversionsDeployed)
              )
          );

return doIt;

END;