﻿IMPORT dops,std;
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
ver_lab_cert_ver := dops.GetBuildVersion('PersonLabKeys','B','N','C');
ver_lab_prod_ver := dops.GetBuildVersion('PersonLabKeys','B','N','P');
ver_fcra_cert_ver := dops.GetBuildVersion('FCRA_PersonHeaderKeys','B','F','C');
ver_fcra_prod_ver := dops.GetBuildVersion('FCRA_PersonHeaderKeys','B','F','P');
ver_wkly_cert_ver := dops.GetBuildVersion('PersonHeaderWeeklyKeys','B','N','C');
ver_wkly_prod_ver := dops.GetBuildVersion('PersonHeaderWeeklyKeys','B','N','P');

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

noSkip:='000';
skipPackage:= if(ikbShouldUpdate,'0','1')+  // 'skipPackage[1]'
              if(fcraShouldUpdate,'0','1')+ // 'skipPackage[2]'
              if(wklyShouldUpdate,'0','1'); // 'skipPackage[3]'

// calls deployment with skip parameters
doIt :=   sequential(
           rpt
          ,if(skipPackage <> '000', std.system.Email.SendEmail(emailList,'SKIPPING SOME OR ALL IKB DEPLOYMENTS',
                                                                         'Skip Deployment: lab,fcra,weekly='+skipPackage+' See:'+workunit))
          ,if(skipPackage = '111'
           ,output('No New Data Available for Deployment')
           ,header.Proc_Copy_From_Alpha_Incrementals().deploy(emailList,rpt_qa_email_list,skipPackage)
           )
          );

return doIt;

END;