// IMPORT HealthCare_Provider_Header AS pkgHeader;
// IMPORT Healthcare_Shared AS pkgHeaderShared;
IMPORT _Control AS pkgControl;
IMPORT wk_ut AS pkgWKUT;
EXPORT modConstants := MODULE
  //Change All of this to match your data. -ZRS 4/8/2019    
  EXPORT DATASET(modLayouts.lSampleLayout) fPrototypeThorCall(DATASET(modLayouts.lSampleLayout) dInData,INTEGER iScore=75,INTEGER iDistance=0,BOOLEAN bSegmentation=FALSE,INTEGER iWeight=0,BOOLEAN bDisableForce=TRUE, BOOLEAN isFuzzy=FALSE, BOOLEAN zipRadius=FALSE, STRING inUrl='', STRING inSvcName='') := DATASET(modLayouts.lSampleLayout);
  EXPORT DATASET(modLayouts.lSampleLayout) fPrototypeRoxieCall(DATASET(modLayouts.lSampleLayout) dInData,INTEGER iScore=75,INTEGER iDistance=0,BOOLEAN bSegmentation=FALSE,INTEGER iWeight=0,BOOLEAN bDisableForce=FALSE, BOOLEAN isFuzzy=TRUE, BOOLEAN zipRadius=TRUE, STRING inUrl='', STRING inSvcName='') := DATASET(modLayouts.lSampleLayout);
  EXPORT DATASET(modLayouts.lSampleLayout) fPrototypeIDFunctionsCall(DATASET(modLayouts.lSampleLayout) dInData,INTEGER iScore=75,INTEGER iDistance=0,BOOLEAN bSegmentation=FALSE,INTEGER iWeight=0,BOOLEAN bDisableForce=FALSE, BOOLEAN isFuzzy=TRUE, BOOLEAN zipRadius=TRUE, STRING inUrl='', STRING inSvcName='') := DATASET(modLayouts.lSampleLayout);
  EXPORT DATASET(modLayouts.lSampleLayout) fPrototypeMMFCall(DATASET(modLayouts.lSampleLayout) dInData,INTEGER iScore=75,INTEGER iDistance=0,BOOLEAN bSegmentation=FALSE,INTEGER iWeight=0,BOOLEAN bDisableForce=FALSE, BOOLEAN isFuzzy=TRUE, BOOLEAN zipRadius=TRUE, STRING inUrl='', STRING inSvcName='') := DATASET(modLayouts.lSampleLayout);


  EXPORT STRING fPrototypeHyperlinkCreator(modLayouts.lSampleLayout dRec) := '';
	/*
  EXPORT modInFields := MODULE(pkgHeader.IxLinkInput)
    EXPORT Input_UniqueID					:= 'UniqueID';
    EXPORT Input_FNAME						:= 'fname';
    EXPORT Input_MNAME						:= 'mname';
    EXPORT Input_LNAME						:= 'lname';
    EXPORT Input_SNAME						:= 'sname';
    EXPORT Input_GENDER						:= 'gender';
    EXPORT Input_TAXONOMY					:= 'taxonomy';
    EXPORT Input_PRIM_RANGE				:= 'prim_range';
    EXPORT Input_PRIM_NAME				:= 'prim_name';
    EXPORT Input_SEC_RANGE				:= 'sec_range';
    EXPORT Input_CITY							:= 'city';
    EXPORT Input_ST								:= 'st';
    EXPORT Input_ZIP							:= 'zip';
    EXPORT Input_ZIPRADIUS				:= '';
    EXPORT Input_PHONE						:= 'prac_phone';
    EXPORT Input_NPI_NUMBER				:= 'npi_number';
    EXPORT Input_UPIN							:= 'upin';
    EXPORT Input_DEA_NUMBER				:= 'dea_number';
    EXPORT Input_LIC_STATE				:= 'lic_state';
    EXPORT Input_LIC_NBR					:= 'lic_nbr_num';
    EXPORT Input_CSR_STATE				:= 'csr_state';
    EXPORT Input_CSR_NBR					:= 'csr_nbr_num';
    EXPORT Input_SSN							:= 'ssn';
    EXPORT Input_DOB							:= 'dob';
    EXPORT Input_MEDSCHOOL				:= 'medschool';
    EXPORT Input_MEDSCHOOL_YEAR		:= 'medschool_year';
    EXPORT Input_LEXID						:= 'lexid';
    //EXPORT Input_HMS_PIID 				:= 'HMS_PIID';	         //Removed on 12/5/2018 because not in use -ZRS
    //EXPORT Input_SRC_CATEGORY     := 'src_category';       //Removed on 12/5/2018 because not in use -ZRS
    //EXPORT Input_VENDOR_ID_SEARCH := 'VENDOR_ENTITY_ID';   //Removed on 12/5/2018 because not in use -ZRS
    EXPORT Input_Tax_ID           := 'tax_id';
    //EXPORT Input_LNPID            := 'lnpid';               //Removed on 12/5/2018 because not in use -ZRS
    //EXPORT Input_RID              := 'rid';                 //Removed on 12/5/2018 because not in use -ZRS
    EXPORT Input_BILLING_NPI      := 'billing_npi';
  END;
		*/
/*
  SHARED pkgHeaderShared.Layouts_Restrictions.DataRights tXRestriction() := TRANSFORM
    SELF.hasABMS := true;
    SELF.hasAHA := true;
    SELF.hasAHAFull := true;
    SELF.hasAMA := true;
    SELF.hasCSR := true;
    SELF.hasDNB := true;
    SELF.hasDefinitiveHealthcare := true;
    SELF.hasDMD := true;
    SELF.hasDMDEmail := true;
    SELF.hasEmdeonClaims := true;
    SELF.hasHealthLinkDimensions := true;
    SELF.hasHIBCC := true;
    SELF.hasMedAvant := true;
    SELF.hasMedicaidID := true;
    SELF.hasNCPDP := true;
    SELF.hasNCPDPFull := true;
    SELF.hasShaID := true;
    SELF.hasStateLicenses := true;
    SELF.hasStateLicenseAddress := true;
    SELF.hasStateLicenseLicNbr := true;
    SELF.hasStrenuus := true;
    SELF.hasStrenuusHIX := true;
    SELF.hasSurescripts := true;
    SELF.hasSKA := true;
    SELF.useSSADeathMasterUpdates := true;    
    SELF := [];
  END;
  */

  EXPORT sRoxieDev157SoapcallURL := 'dev157vip.hpcc.risk.regn.net:9876';
  EXPORT sRoxieDev154SoapcallURL := 'dev154vip.hpcc.risk.regn.net:9876';
  EXPORT sRoxieDev155SoapcallURL := 'dev155vip.hpcc.risk.regn.net:9876';
  EXPORT sRoxieDevSoapcallURL := sRoxieDev154SoapcallURL; // DEFAULT

  EXPORT sRoxieDev1Way1SoapcallURL := 'http://10.173.3.1:9876';
  EXPORT sRoxieDev1Way5SoapcallURL := 'http://10.173.3.5:9876';
  EXPORT sRoxieDev1Way6SoapcallURL := 'http://10.173.3.6:9876';
  EXPORT sRoxieCertVIPSoapcallURL := 'http://roxiestaging.br.seisint.com:9876';
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
  EXPORT sPollingFreq      := '1';
  EXPORT bOutECL           := false;
  EXPORT sEmailNotify      := IF(bIsProd, 
		'jeremy.bowden@lexisnexis.com, alex.livingston@lexisnexisrisk.com'
       ,'jeremy.bowden@lexisnexis.com, alex.livingston@lexisnexisrisk.com');
  EXPORT sEmailNotifyQA    := '';
  EXPORT sEmailNotifyAll   := sEmailNotify + ',' + sEmailNotifyQA;
  EXPORT sESP := pkgWKUT._Constants.LocalEsp;
END;