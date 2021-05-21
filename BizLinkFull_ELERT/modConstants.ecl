// IMPORT HealthCare_Provider_Header AS pkgHeader;
// IMPORT Healthcare_Shared AS pkgHeaderShared;
IMPORT _Control AS pkgControl;
IMPORT wk_ut AS pkgWKUT;
EXPORT modConstants := MODULE
  //Change All of this to match your data. -ZRS 4/8/2019    
  EXPORT DATASET(modLayouts.lSampleLayout) fPrototypeThorCall(DATASET(modLayouts.lSampleLayout) dInData,INTEGER iScore=75,INTEGER iDistance=0,BOOLEAN bSegmentation=FALSE,INTEGER iWeight=0,BOOLEAN bDisableForce=TRUE, BOOLEAN isFuzzy=FALSE, BOOLEAN zipRadius=FALSE, STRING inUrl='', STRING inSvcName='', BOOLEAN bUseSourceRid=FALSE) := DATASET(modLayouts.lSampleLayout);
  EXPORT DATASET(modLayouts.lSampleLayout) fPrototypeRoxieCall(DATASET(modLayouts.lSampleLayout) dInData,INTEGER iScore=75,INTEGER iDistance=0,BOOLEAN bSegmentation=FALSE,INTEGER iWeight=0,BOOLEAN bDisableForce=FALSE, BOOLEAN isFuzzy=TRUE, BOOLEAN zipRadius=TRUE, STRING inUrl='', STRING inSvcName='', BOOLEAN bUseSourceRid=FALSE) := DATASET(modLayouts.lSampleLayout);
  EXPORT DATASET(modLayouts.lSampleLayout) fPrototypeIDFunctionsCall(DATASET(modLayouts.lSampleLayout) dInData,INTEGER iScore=75,INTEGER iDistance=0,BOOLEAN bSegmentation=FALSE,INTEGER iWeight=0,BOOLEAN bDisableForce=FALSE, BOOLEAN isFuzzy=TRUE, BOOLEAN zipRadius=TRUE, STRING inUrl='', STRING inSvcName='', BOOLEAN bUseSourceRid=FALSE) := DATASET(modLayouts.lSampleLayout);
  EXPORT DATASET(modLayouts.lSampleLayout) fPrototypeMMFCall(DATASET(modLayouts.lSampleLayout) dInData,INTEGER iScore=75,INTEGER iDistance=0,BOOLEAN bSegmentation=FALSE,INTEGER iWeight=0,BOOLEAN bDisableForce=FALSE, BOOLEAN isFuzzy=TRUE, BOOLEAN zipRadius=TRUE, STRING inUrl='', STRING inSvcName='', BOOLEAN bUseSourceRid=FALSE) := DATASET(modLayouts.lSampleLayout);
  
  EXPORT STRING fPrototypeHyperlinkCreator(modLayouts.lSampleLayout dRec) := '';

  EXPORT sRoxieDev157SoapcallURL := 'dev157vip.hpcc.risk.regn.net:9876';
  EXPORT sRoxieDev154SoapcallURL := 'dev154vip.hpcc.risk.regn.net:9876';
  EXPORT sRoxieDev155SoapcallURL := 'dev155vip.hpcc.risk.regn.net:9876';
  EXPORT sRoxieDevSoapcallURL := sRoxieDev154SoapcallURL; // DEFAULT

  EXPORT sRoxieDev1Way1SoapcallURL := 'http://10.173.3.1:9876';
  EXPORT sRoxieDev1Way5SoapcallURL := 'http://10.173.3.5:9876';
  EXPORT sRoxieDev1Way6SoapcallURL := 'http://10.173.3.6:9876';
  EXPORT sRoxieCertVIPSoapcallURL := 'http://certstagingvip.hpcc.risk.regn.net:9876';
  EXPORT sRoxieCertSoapcallURL := 'http://10.176.68.135:9876';
  // EXPORT dBasicRestrictions := DATASET([tXRestriction()]);
  EXPORT sHeaderServiceRoxieIP := 'http://10.173.149.1:9876';//'http://10.176.68.135:9876';
  EXPORT sHeaderServiceOrigName := 'BizLinkFull_ELERT.svcappendorigservice';
  EXPORT sHeaderServiceNewName := 'BizLinkFull_ELERT.svcappendnewservice';
  EXPORT uZip_radius_miles := 15;
  //If we have multiple modes that use roxie, add the mode number here to allow for stats to take in failed returns into account
  EXPORT siRoxieModes := [3];
//Taken from PROC_Constants, might just reference that code...
  SHARED ssProdEnvs         := ['10.173.14.204'];
  EXPORT bIsProd           := pkgControl.ThisEnvironment.ESP_IPAddress IN ssProdEnvs;
  EXPORT bMPIFlag          := IF(bIsProd, FALSE, TRUE);
  EXPORT bUseForeignFiles  := FALSE;
  EXPORT iDefaultSamples4External := 50000;
  // EXPORT sPrimaryQueue     := IF(bIsProd, '<fillIn>', 'thor400_dev_eclcc');
  EXPORT sPrimaryQueue     := IF(bIsProd, '<fillIn>', 'thor400_dev_eclcc');
  EXPORT sSecondaryQueue   := IF(bIsProd, '<fillIn>', 'hthor_dev_eclcc');
  EXPORT sHthorQueue       := IF(bIsProd, '<fillIn>', 'hthor_dev_eclcc');
  EXPORT sPollingFreq      := '1';
  EXPORT bOutECL           := false;
  EXPORT sEmailNotify      := IF(bIsProd, 
		'jeremy.bowden@lexisnexis.com, alex.livingston@lexisnexisrisk.com'
       ,'jeremy.bowden@lexisnexis.com, alex.livingston@lexisnexisrisk.com');
  EXPORT sEmailNotifyQA    := '';
  EXPORT sEmailNotifyAll   := sEmailNotify + ',' + sEmailNotifyQA;
  EXPORT sESP := pkgWKUT._Constants.LocalEsp;
  EXPORT bUseSrcRid := FALSE;
END;