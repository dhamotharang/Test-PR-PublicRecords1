/*******************************************************************************************************************
 Spray 48 test seed data files onto THOR from bctlpedata12 /data/hds_2/credit_report_test_seed/filedate
 This is for the TestseedKeys Non-FCRA DOPs dataset
********************************************************************************************************************/
IMPORT Versioncontrol, _Control, tools, STD;
EXPORT Proc_InstantID_Spray(
   STRING   filedate
  ,BOOLEAN  pIsTesting = false
  ,STRING   pServer = _Control.IPAddress.bctlpedata12
  ,STRING   pDir = '/data/hds_2/InstantIdAndAnalyticsTestSeed/'    
  ,STRING   pGroupName = STD.System.Thorlib.Group()
) :=
FUNCTION

  setupSuperFiles(STRING keyname) := FUNCTION

    sfile := '~thor_data400::base::testseed_'+keyname;
    RETURN SEQUENTIAL(
              FileServices.StartSuperFileTransaction(),
              IF(FileServices.FileExists(sfile),FileServices.ClearSuperFile(sfile,true),FileServices.CreateSuperFile(sfile)),
              FileServices.FinishSuperFileTransaction()
              );
  END;
  
  // flfile(string pkeyword) := '~thor_data400::in::testseed::'+filedate+pkeyword;
  flfile(string pkeyword) := '~thor_data400::in::testseed::'+pkeyword;
  fsfile(string pkeyword) := '~thor_data400::base::testseed_'+pkeyword;
  
  spry_raw:=DATASET([
     {pServer,pDir,'amlriskattributesbusn.csv',0 ,flfile('amlriskattributesbusn'),[{fsfile('amlriskattributesbusn')}],pGroupName,filedate,'','VARIABLE'}
    ,{pServer,pDir,'amlriskattributes.csv',0 ,flfile('amlriskattributes'),[{fsfile('amlriskattributes')}],pGroupName,filedate,'','VARIABLE'}
    ,{pServer,pDir,'amlriskattributesbusnv2.csv',0 ,flfile('amlriskattributesbusnv2'),[{fsfile('amlriskattributesbusnv2')}],pGroupName,filedate,'','VARIABLE'}
    ,{pServer,pDir,'amlriskattributesv2.csv',0 ,flfile('amlriskattributesv2'),[{fsfile('amlriskattributesv2')}],pGroupName,filedate,'','VARIABLE'}
    ,{pServer,pDir,'binstantid.csv',0 ,flfile('binstantid'),[{fsfile('binstantid')}],pGroupName,filedate,'','VARIABLE'}
    ,{pServer,pDir,'boca_shell.csv',0 ,flfile('boca_shell'),[{fsfile('boca_shell')}],pGroupName,filedate,'','VARIABLE'}
    ,{pServer,pDir,'boca_shell4.csv',0 ,flfile('boca_shell4'),[{fsfile('boca_shell4')}],pGroupName,filedate,'','VARIABLE'}
    ,{pServer,pDir,'bs_services_iid_address_history.csv',0 ,flfile('bs_services_iid_address_history'),[{fsfile('bs_services_iid_address_history')}],pGroupName,filedate,'','VARIABLE'}
    ,{pServer,pDir,'businessdefender.csv' ,0 ,flfile('businessdefender'),[{fsfile('businessdefender')}],pGroupName,filedate,'','VARIABLE'}
    ,{pServer,pDir,'cbd.csv',0 ,flfile('cbd'),[{fsfile('cbd')}],pGroupName,filedate,'','VARIABLE'}
    ,{pServer,pDir,'cbdattributes.csv',0 ,flfile('cbdattributes'),[{fsfile('cbdattributes')}],pGroupName,filedate,'','VARIABLE'}
    ,{pServer,pDir,'flexid.csv',0 ,flfile('flexid'),[{fsfile('flexid')}],pGroupName,filedate,'','VARIABLE'}
    ,{pServer,pDir,'FOV_Interactive.csv',0 ,flfile('FOV_Interactive'),[{fsfile('FOV_Interactive')}],pGroupName,filedate,'','VARIABLE'}
    ,{pServer,pDir,'FOV_Renewal.csv',0 ,flfile('fov_Renewal'),[{fsfile('FOV_Renewal')}],pGroupName,filedate,'','VARIABLE'}
    ,{pServer,pDir,'frauddefender.csv',0 ,flfile('frauddefender'),[{fsfile('frauddefender')}],pGroupName,filedate,'','VARIABLE'}
    ,{pServer,pDir,'healthcareattributes.csv',0 ,flfile('healthcareattributes'),[{fsfile('healthcareattributes')}],pGroupName,filedate,'','VARIABLE'}
    ,{pServer,pDir,'identifier2.csv',0 ,flfile('identifier2'),[{fsfile('identifier2')}],pGroupName,filedate,'','VARIABLE'}
    ,{pServer,pDir,'identityfraudnetwork_address.csv',0 ,flfile('identityfraudnetwork_address'),[{fsfile('identityfraudnetwork_address')}],pGroupName,filedate,'','VARIABLE'}
    ,{pServer,pDir,'identityfraudnetwork_combination.csv',0 ,flfile('identityfraudnetwork_combination'),[{fsfile('identityfraudnetwork_combination')}],pGroupName,filedate,'','VARIABLE'}
    ,{pServer,pDir,'identityfraudnetwork_email.csv',0 ,flfile('identityfraudnetwork_email'),[{fsfile('identityfraudnetwork_email')}],pGroupName,filedate,'','VARIABLE'}
    ,{pServer,pDir,'identityfraudnetwork_ipaddress.csv',0 ,flfile('identityfraudnetwork_ipaddress'),[{fsfile('identityfraudnetwork_ipaddress')}],pGroupName,filedate,'','VARIABLE'}
    ,{pServer,pDir,'identityfraudnetwork_name.csv',0 ,flfile('identityfraudnetwork_name'),[{fsfile('identityfraudnetwork_name')}],pGroupName,filedate,'','VARIABLE'}
    ,{pServer,pDir,'identityfraudnetwork_phone.csv',0 ,flfile('identityfraudnetwork_phone'),[{fsfile('identityfraudnetwork_phone')}],pGroupName,filedate,'','VARIABLE'}
    ,{pServer,pDir,'identityfraudnetwork_ssn.csv',0 ,flfile('identityfraudnetwork_ssn'),[{fsfile('identityfraudnetwork_ssn')}],pGroupName,filedate,'','VARIABLE'}
    ,{pServer,pDir,'identityreport.csv',0 ,flfile('identityreport'),[{fsfile('identityreport')}],pGroupName,filedate,'','VARIABLE'}
    ,{pServer,pDir,'instantid.csv',0 ,flfile('instantid'),[{fsfile('instantid')}],pGroupName,filedate,'','VARIABLE'}
    ,{pServer,pDir,'intliid_gg2.csv',0 ,flfile('intliid_gg2'),[{fsfile('intliid_gg2')}],pGroupName,filedate,'','VARIABLE'}
    ,{pServer,pDir,'leadintegrityattributes.csv',0 ,flfile('leadintegrityattributes'),[{fsfile('leadintegrityattributes')}],pGroupName,filedate,'','VARIABLE'}
    ,{pServer,pDir,'lnsmallbusiness.csv',0 ,flfile('lnsmallbusiness'),[{fsfile('lnsmallbusiness')}],pGroupName,filedate,'','VARIABLE'}
    ,{pServer,pDir,'os.csv',0 ,flfile('os'),[{fsfile('os')}],pGroupName,filedate,'','VARIABLE'}
    ,{pServer,pDir,'osattributes.csv',0 ,flfile('osattributes'),[{fsfile('osattributes')}],pGroupName,filedate,'','VARIABLE'}
    ,{pServer,pDir,'part1_biid_v2.csv',0 ,flfile('part1_biid_v2'),[{fsfile('part1_biid_v2' )}],pGroupName,filedate,'','VARIABLE'}
    ,{pServer,pDir,'part2_biid_v2.csv',0 ,flfile('part2_biid_v2'),[{fsfile('part2_biid_v2')}],pGroupName,filedate,'','VARIABLE'}
    ,{pServer,pDir,'part3_biid_v2.csv',0 ,flfile('part3_biid_v2'),[{fsfile('part3_biid_v2')}],pGroupName,filedate,'','VARIABLE'}
    ,{pServer,pDir,'profilebooster.csv',0 ,flfile('profilebooster'),[{fsfile('profilebooster' )}],pGroupName,filedate,'','VARIABLE'}
    ,{pServer,pDir,'redflags.csv',0 ,flfile('redflags'),[{fsfile('redflags')}],pGroupName,filedate,'','VARIABLE'}
    ,{pServer,pDir,'smallbusfinancialexchange.csv',0 ,flfile('smallbusfinancialexchange'),[{fsfile('smallbusfinancialexchange')}],pGroupName,filedate,'','VARIABLE'}
    ,{pServer,pDir,'smallbusinessanalytics.csv',0 ,flfile('smallbusinessanalytics'),[{fsfile('smallbusinessanalytics')}],pGroupName,filedate,'','VARIABLE'}
    ,{pServer,pDir,'smallbusinessanalyticsv20.csv',0 ,flfile('smallbusinessanalyticsv20'),[{fsfile('smallbusinessanalyticsv20')}],pGroupName,filedate,'','VARIABLE'}
    ,{pServer,pDir,'smallbusmodels.csv',0 ,flfile('smallbusmodels'),[{fsfile('smallbusmodels')}],pGroupName,filedate,'','VARIABLE'}                                                                                          
    ,{pServer,pDir,'verificationofoccupancy.csv',0 ,flfile('verificationofoccupancy'),[{fsfile('verificationofoccupancy')}],pGroupName,filedate,'','VARIABLE'}
    ,{pServer,pDir,'vooreport_associatedidentities.csv',0 ,flfile('vooreport_associatedidentities'),[{fsfile('vooreport_associatedidentities')}],pGroupName,filedate,'','VARIABLE'}
    ,{pServer,pDir,'vooreport_ownedproperties.csv',0 ,flfile('vooreport_ownedproperties'),[{fsfile('vooreport_ownedproperties')}],pGroupName,filedate,'','VARIABLE'}
    ,{pServer,pDir,'vooreport_ownedpropertiesasof.csv',0 ,flfile('vooreport_ownedpropertiesasof'),[{fsfile('vooreport_ownedpropertiesasof')}],pGroupName,filedate,'','VARIABLE'}
    ,{pServer,pDir,'vooreport_phoneandutility.csv',0 ,flfile('vooreport_phoneandutility'),[{fsfile('vooreport_phoneandutility')}],pGroupName,filedate,'','VARIABLE'}
    ,{pServer,pDir,'vooreport_sources.csv',0 ,flfile('vooreport_sources'),[{fsfile('vooreport_sources')}],pGroupName,filedate,'','VARIABLE'}
    ,{pServer,pDir,'vooreport_summary.csv',0 ,flfile('vooreport_summary'),[{fsfile('vooreport_summary')}],pGroupName,filedate,'','VARIABLE'}
    ,{pServer,pDir,'vooreport_targetsummary.csv',0 ,flfile('vooreport_targetsummary'),[{fsfile('vooreport_targetsummary')}],pGroupName,filedate,'','VARIABLE'}
  ], VersionControl.Layout_Sprays.Info);
    
    RETURN SEQUENTIAL( 
        setupSuperFiles('amlriskattributes'),
        setupSuperFiles('amlriskattributesbusn'),
        setupSuperFiles('amlriskattributesbusnv2'),
        setupSuperFiles('amlriskattributesv2'),
        setupSuperFiles('binstantid'),
        setupSuperFiles('boca_shell'),
        setupSuperFiles('boca_shell4'),
        setupSuperFiles('bs_services_iid_address_history'),
        setupSuperFiles('businessdefender'),
        setupSuperFiles('cbd'),
        setupSuperFiles('cbdattributes'),
        setupSuperFiles('flexid'),
        setupSuperFiles('fov_interactive'),
        setupSuperFiles('fov_renewal'),
        setupSuperFiles('frauddefender'),
        setupSuperFiles('healthcareattributes'),
        setupSuperFiles('identifier2'),
        setupSuperFiles('identityfraudnetwork_address'),
        setupSuperFiles('identityfraudnetwork_combination'),
        setupSuperFiles('identityfraudnetwork_email'),
        setupSuperFiles('identityfraudnetwork_ipaddress'),
        setupSuperFiles('identityfraudnetwork_name'),
        setupSuperFiles('identityfraudnetwork_phone'),
        setupSuperFiles('identityfraudnetwork_ssn'),
        setupSuperFiles('identityreport'),
        setupSuperFiles('instantid'),
        setupSuperFiles('intliid_gg2'),
        setupSuperFiles('leadintegrityattributes'),
        setupSuperFiles('lnsmallbusiness'),
        setupSuperFiles('os'),
        setupSuperFiles('osattributes'),
        setupSuperFiles('part1_biid_v2'),
        setupSuperFiles('part2_biid_v2'),
        setupSuperFiles('part3_biid_v2'),
        setupSuperFiles('profilebooster'),
        setupSuperFiles('redflags'),
        setupSuperFiles('smallbusfinancialexchange'),
        setupSuperFiles('smallbusinessanalytics'),
        setupSuperFiles('smallbusinessanalyticsv20'),
        setupSuperFiles('smallbusmodels'),
        setupSuperFiles('verificationofoccupancy'),
        setupSuperFiles('vooreport_associatedidentities'),
        setupSuperFiles('vooreport_ownedproperties'),
        setupSuperFiles('vooreport_ownedpropertiesasof'),
        setupSuperFiles('vooreport_phoneandutility'),
        setupSuperFiles('vooreport_sources'),
        setupSuperFiles('vooreport_summary'),
        setupSuperFiles('vooreport_targetsummary'),
        tools.fun_Spray
            ( 
              spry_raw,                                // pSprayInformation
              ,                                        // pSprayInfoSuperfile
              ,                                        // pSprayInfoLogicalfile
              TRUE,                                    // pOverwrite
              ,                                        // pReplicate
              TRUE,                                    // pAddCounter
              pIsTesting,                              // pIsTesting
              ,                                        // pEmailNotificationList
              'InstantIdAndAnalyticsTestSeed' + filedate,      // pEmailSubjectDataset
              'InstantIdAndAnalyticsTestSeed Spray Info',      // pOutputName
              FALSE,                                   // pShouldClearSuperfileFirst
              FALSE,                                   // pSplitEmails
              FALSE,                                   // pShouldSprayZeroByteFiles
              FALSE                                    // pShouldSprayMultipleFilesAs1
            ));

  
END;

/*

hor_data400::key::testseed::20201120082016::amlriskattributes
thor_data400::key::testseed::20201120082016::amlriskattributesbusn
thor_data400::key::testseed::20201120082016::amlriskattributesbusnv2
thor_data400::key::testseed::20201120082016::amlriskattributesv2
thor_data400::key::testseed::20201120082016::binstantid
thor_data400::key::testseed::20201120082016::boca_shell
thor_data400::key::testseed::20201120082016::boca_shell4
thor_data400::key::testseed::20201120082016::bs_services_iid_address_history
thor_data400::key::testseed::20201120082016::businessdefender
thor_data400::key::testseed::20201120082016::cbd
thor_data400::key::testseed::20201120082016::cbdattributes
thor_data400::key::testseed::20201120082016::flexid
thor_data400::key::testseed::20201120082016::fov_interactive
thor_data400::key::testseed::20201120082016::fov_renewal
thor_data400::key::testseed::20201120082016::frauddefender
thor_data400::key::testseed::20201120082016::healthcareattributes
thor_data400::key::testseed::20201120082016::identifier2
thor_data400::key::testseed::20201120082016::identityfraudnetwork_address
thor_data400::key::testseed::20201120082016::identityfraudnetwork_combination
thor_data400::key::testseed::20201120082016::identityfraudnetwork_email
thor_data400::key::testseed::20201120082016::identityfraudnetwork_ipaddress
thor_data400::key::testseed::20201120082016::identityfraudnetwork_name
thor_data400::key::testseed::20201120082016::identityfraudnetwork_phone
thor_data400::key::testseed::20201120082016::identityfraudnetwork_ssn
thor_data400::key::testseed::20201120082016::identityreport
thor_data400::key::testseed::20201120082016::instantid
thor_data400::key::testseed::20201120082016::intliid_gg2
thor_data400::key::testseed::20201120082016::leadintegrityattributes
thor_data400::key::testseed::20201120082016::lnsmallbusiness
thor_data400::key::testseed::20201120082016::os
thor_data400::key::testseed::20201120082016::osattributes
thor_data400::key::testseed::20201120082016::part1::biid_v2
thor_data400::key::testseed::20201120082016::part2::biid_v2
thor_data400::key::testseed::20201120082016::part3::biid_v2
thor_data400::key::testseed::20201120082016::profilebooster
thor_data400::key::testseed::20201120082016::redflags
thor_data400::key::testseed::20201120082016::smallbusfinancialexchange
thor_data400::key::testseed::20201120082016::smallbusinessanalytics
thor_data400::key::testseed::20201120082016::smallbusinessanalyticsv20
thor_data400::key::testseed::20201120082016::smallbusmodels
thor_data400::key::testseed::20201120082016::verificationofoccupancy
thor_data400::key::testseed::20201120082016::vooreport::associatedidentities
thor_data400::key::testseed::20201120082016::vooreport::ownedproperties
thor_data400::key::testseed::20201120082016::vooreport::ownedpropertiesasof
thor_data400::key::testseed::20201120082016::vooreport::phoneandutility
thor_data400::key::testseed::20201120082016::vooreport::sources
thor_data400::key::testseed::20201120082016::vooreport::summary
thor_data400::key::testseed::20201120082016::vooreport::targetsummary

*/