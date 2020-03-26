IMPORT STD AS pkgSTD;
EXPORT modGetSamples(DATASET(modLayouts.profileRec) dProfile, STRING sVersion, UNSIGNED iNumSamples, UNSIGNED iExpireTime = 30, STRING sSamplesFileName = '') := MODULE
  //You'll want to change these next couple of functions to match your data. -ZRS 4/8/2019
  SHARED modLayouts.lSampleLayout tHeaderSourcesToSample(RECORDOF(modFiles.dHeaderPayload) rIn, UNSIGNED iTimeStamp) := TRANSFORM
    SELF := rIn;
    SELF.timestamp := iTimeStamp;
    SELF.uniqueid := 0;//fill this in later
    SELF.hms_piid:='';
    SELF.mode:=0;
    SELF.comparemode:=0;
    SELF.description:='';
  END;
  SHARED modLayouts.lSampleLayout tSancSourcesToSample(RECORDOF(modFiles.dSanctionsData) rIn, UNSIGNED iTimeStamp) := TRANSFORM
    SELF.sname := rIn.name_suffix;
    SELF.city := rIn.p_city_name;
    SELF.classification := '';//Classification in this data set is something different
    SELF.npi_number := rIn.npi;
    SELF.lexid := rIn.did;
    SELF.src_category := 'SANCTIONS';
    SELF.timestamp := iTimeStamp;
    SELF.uniqueid := 0;//fill this in later
    SELF.hms_piid:='';
    SELF := rIn;
    SELF:=[];
  END;
  SHARED modLayouts.lSampleLayout tDeathSourcesToSample(RECORDOF(modFiles.dDeathData) rIn, UNSIGNED iTimeStamp) := TRANSFORM
    SELF.src_category  := 'DEATH';
    SELF.timestamp := iTimeStamp;
    SELF.uniqueid := 0;//fill this in later
    SELF.dob := (INTEGER)(rIn.dob8);
    SELF.st := rIn.state;
    SELF.zip := rIn.zip_lastres;
    SELF.lexid := (INTEGER)(rIn.did);
    SELF:=rIn;
    SELF:=[];
  END;
  
  SHARED modLayouts.lSampleLayout tAssociateSourcesToSample(RECORDOF(modFiles.dAssociateData) rIn, UNSIGNED iTimeStamp) := TRANSFORM
    SELF.src_category  := 'ASSOCIATE';
    SELF.timestamp := iTimeStamp;
    SELF.FNAME                := rIn.entityb_clean_fname;
    SELF.MNAME                := rIn.entityb_clean_mname;
    SELF.LNAME                := rIn.entityb_clean_lname;
    SELF.SNAME                := rIn.entityb_clean_name_suffix;
    SELF.TAXONOMY             := rIn.entityb_taxonomy;
    SELF.PRIM_RANGE           := rIn.entityb_prim_range;
    SELF.PRIM_NAME            := rIn.entityb_prim_name;
    SELF.SEC_RANGE            := rIn.entityb_sec_range;
    SELF.CITY                 := rIn.entityb_v_city_name;
    SELF.ST                   := rIn.entityb_st;
    SELF.ZIP                  := rIn.entityb_czip;
    SELF.PRAC_PHONE           := rIn.entityb_phone;
    SELF.NPI_NUMBER           := rIn.entityb_npi;
    SELF.DEA_NUMBER           := rIn.entityb_dea;
    SELF.TAX_ID               := rIn.entityb_tax_id;
    SELF.LNPID                := rIn.lnpid;
    SELF.uniqueid             := 0;//fill this in later
    SELF.hms_piid             := rIn.entityb_id;
    SELF.lexid                := (INTEGER)(rIn.did);
    SELF:=rIn;
    SELF:=[];
  END;
  
  SHARED modLayouts.lSampleLayout tCMSOrderSourcesToSample(RECORDOF(modFiles.dCMSOrderRefData) rIn, UNSIGNED iTimeStamp) := TRANSFORM
    SELF.src_category  := 'MEDICARE';
    SELF.timestamp := iTimeStamp;
    self.sname := rIn.name_suffix;
    SELF.npi_number := rIn.npi;
    SELF.lexid := (INTEGER)(rIn.did);
    SELF:=rIn;
    SELF:=[];
  END;
  SHARED modLayouts.lSampleLayout tHMSDataSourcesToSample(RECORDOF(modFiles.dHMSData) rIn, UNSIGNED iTimeStamp) := TRANSFORM
    SELF.src_category  := 'HMS';
    SELF.timestamp := iTimeStamp;
    SELF.fname := rIn.first_name;
    SELF.mname := rIn.middle_name;
    SELF.lname := rIn.last_name;
    SELF.sname := rIn.suffix;
    SELF.practitioner_type := rIn.Practitioner_type;
    //SELF.classification := rIn.hms_spec1; //Not sure which one is right here
    SELF.npi_number := rIn.npi;
    SELF.dea_number := rIn.dea_registration_number;
    SELF.lic_state := rIn.state_license_state;
    SELF.lic_nbr_num := rIn.state_license_number;//might need to clean
    SELF.lexid := (INTEGER)(rIn.did);
    addr := rIn.addresses[1];
    SELF.prac_phone := addr.phone1;
    SELF := addr;
    SELF := rIn;
    SELF:=[];
  END;
  
  SHARED modLayouts.lSampleLayout tSAMExclusionSourcesToSample(RECORDOF(modFiles.dSAMExclusionData) rIn, UNSIGNED iTimeStamp) := TRANSFORM
    SELF.src_category  := 'SAMExclusion';
    SELF.timestamp := iTimeStamp;  
    SELF.npi_number := rIn.npi;
    SELF.lexid := (INTEGER)(rIn.did);    
    SELF.classification := '';
    SELF := rIn;    
    SELF:=[];
  END;
  
  SHARED modLayouts.lSampleLayout tClientDataSourcesToSample(RECORDOF(modFiles.dClientData) rIn, UNSIGNED iTimeStamp) := TRANSFORM
    SELF.src_category         := (STRING)(rIn.gcid);
    SELF.FNAME                := rIn.Clean_first_name;
    SELF.MNAME                := rIn.Clean_middle_name;
    SELF.LNAME                := rIn.Clean_last_name;
    SELF.SNAME                := rIn.Clean_name_suffix;
    SELF.GENDER               := rIn.Clean_gender;
    SELF.TAXONOMY             := rIn.taxonomy;
    SELF.PRIM_RANGE           := rIn.Clean_prim_range;
    SELF.PRIM_NAME            := rIn.Clean_prim_name;
    SELF.SEC_RANGE            := rIn.Clean_sec_range;
    SELF.CITY                 := rIn.Clean_p_city_name;
    SELF.ST                   := rIn.Clean_st;
    SELF.ZIP                  := rIn.Clean_zip5;
    SELF.PRAC_PHONE           := rIn.Clean_phonenumber;
    SELF.NPI_NUMBER           := rIn.NPI;
    SELF.UPIN                 := rIn.UPIN;
    SELF.DEA_NUMBER           := rIn.DEA;
    SELF.LIC_STATE            := rIn.clean_stLicState;
    SELF.LIC_NBR_NUM          := rIn.STATE_LIC;
    SELF.CSR_STATE            := rIn.clean_csrState;
    SELF.CSR_NBR_NUM          := rIn.CSR;
    SELF.SSN                  := rIn.SSN;
    SELF.DOB                  := (INTEGER)(rIn.Clean_date_born);
    SELF.TAX_ID               := rIn.TID;
    SELF.BILLING_NPI          := rIn.BILL_NPI;
    SELF.MEDSCHOOL            := rIn.Clean_medschool;
    SELF.MEDSCHOOL_YEAR       := (INTEGER)(rIn.Clean_medschool_yr);
    SELF.VENDOR_ENTITY_ID     := rIn.CLIENTID;
    SELF.LNPID                := rIn.lnpid;
    SELF.timestamp            := iTimeStamp;
    SELF.uniqueid             := 0;//fill this in later
    SELF.hms_piid             := rIn.client_Legacy_ID;
    SELF:=[];
  END;
  SHARED modLayouts.lSampleLayout tFilter(modLayouts.lSampleLayout dRec, modLayouts.profileRec dProfile, UNSIGNED iRandomID) := TRANSFORM
  //Change Field names to match your data. -ZRS 4/8/2019    
    SET OF STRING ssFilter := dProfile.ssFilter;
    BOOLEAN bNoFilter := (COUNT(ssFilter) = 0);
    SELF.FNAME := IF('FNAME' IN ssFilter, IF(dRec.FNAME = '', SKIP, dRec.FNAME), IF(bNoFilter,dRec.fname,''));
    SELF.MNAME := IF('MNAME' IN ssFilter, IF(dRec.MNAME = '', SKIP, dRec.MNAME), IF(bNoFilter,dRec.MNAME,''));
    SELF.LNAME := IF('LNAME' IN ssFilter, IF(dRec.LNAME = '', SKIP, dRec.LNAME), IF(bNoFilter,dRec.LNAME,''));
    SELF.SNAME := IF('SNAME' IN ssFilter, IF(dRec.SNAME = '', SKIP, dRec.SNAME), IF(bNoFilter,dRec.SNAME,''));
    SELF.GENDER := IF('GENDER' IN ssFilter, IF(dRec.GENDER = '', SKIP, dRec.GENDER), IF(bNoFilter,dRec.GENDER,''));
    SELF.SSN := IF('SSN' IN ssFilter, IF(dRec.SSN = '', SKIP, dRec.SSN), IF(bNoFilter,dRec.SSN,''));
    SELF.DOB := IF('DOB' IN ssFilter, IF(dRec.DOB = 0, SKIP, dRec.DOB), IF(bNoFilter,dRec.DOB,0)); 
    SELF.TAXONOMY := IF('TAXONOMY' IN ssFilter, IF(dRec.TAXONOMY = '', SKIP, dRec.TAXONOMY), IF(bNoFilter,dRec.TAXONOMY,''));
    SELF.PRACTITIONER_TYPE := IF('PRACTITIONER_TYPE' IN ssFilter, IF(dRec.PRACTITIONER_TYPE = '', SKIP, dRec.PRACTITIONER_TYPE), IF(bNoFilter,dRec.PRACTITIONER_TYPE,''));
    SELF.CLASSIFICATION := IF('CLASSIFICATION' IN ssFilter, IF(dRec.CLASSIFICATION = '', SKIP, dRec.CLASSIFICATION), IF(bNoFilter,dRec.CLASSIFICATION,''));
    SELF.PRIM_RANGE := IF('PRIM_RANGE' IN ssFilter, IF(dRec.PRIM_RANGE = '', SKIP, dRec.PRIM_RANGE), IF(bNoFilter,dRec.PRIM_RANGE,''));
    SELF.PRIM_NAME := IF('PRIM_NAME' IN ssFilter, IF(dRec.PRIM_NAME = '', SKIP, dRec.PRIM_NAME), IF(bNoFilter,dRec.PRIM_NAME,''));
    SELF.SEC_RANGE := IF('SEC_RANGE' IN ssFilter, IF(dRec.SEC_RANGE = '', SKIP, dRec.SEC_RANGE), IF(bNoFilter,dRec.SEC_RANGE,''));
    SELF.CITY := IF('CITY' IN ssFilter, IF(dRec.CITY = '', SKIP, dRec.CITY), IF(bNoFilter,dRec.CITY,''));
    SELF.ST := IF('ST' IN ssFilter, IF(dRec.ST = '', SKIP, dRec.ST), IF(bNoFilter,dRec.ST,''));
    SELF.ZIP := IF('ZIP' IN ssFilter, IF(dRec.ZIP = '', SKIP, dRec.ZIP), IF(bNoFilter,dRec.ZIP,''));
    SELF.PRAC_PHONE := IF('PRAC_PHONE' IN ssFilter, IF(dRec.PRAC_PHONE = '', SKIP, dRec.PRAC_PHONE), IF(bNoFilter,dRec.PRAC_PHONE,''));
    SELF.NPI_NUMBER := IF('NPI_NUMBER' IN ssFilter, IF(dRec.NPI_NUMBER = '', SKIP, dRec.NPI_NUMBER), IF(bNoFilter,dRec.NPI_NUMBER,''));
    SELF.UPIN := IF('UPIN' IN ssFilter, IF(dRec.UPIN = '', SKIP, dRec.UPIN), IF(bNoFilter,dRec.UPIN,''));
    SELF.DEA_NUMBER := IF('DEA_NUMBER' IN ssFilter, IF(dRec.DEA_NUMBER = '', SKIP, dRec.DEA_NUMBER), IF(bNoFilter,dRec.DEA_NUMBER,''));
    SELF.LIC_STATE := IF('LIC_STATE' IN ssFilter, IF(dRec.LIC_STATE = '', SKIP, dRec.LIC_STATE), IF(bNoFilter,dRec.LIC_STATE,''));
    SELF.LIC_NBR_NUM := IF('LIC_NBR_NUM' IN ssFilter, IF(dRec.LIC_NBR_NUM = '', SKIP, dRec.LIC_NBR_NUM), IF(bNoFilter,dRec.LIC_NBR_NUM,''));
    SELF.CSR_STATE := IF('CSR_STATE' IN ssFilter, IF(dRec.CSR_STATE = '', SKIP, dRec.CSR_STATE), IF(bNoFilter,dRec.CSR_STATE,''));
    SELF.CSR_NBR_NUM := IF('CSR_NBR_NUM' IN ssFilter, IF(dRec.CSR_NBR_NUM = '', SKIP, dRec.CSR_NBR_NUM), IF(bNoFilter,dRec.CSR_NBR_NUM,''));
    SELF.MEDSCHOOL := IF('MEDSCHOOL' IN ssFilter, IF(dRec.MEDSCHOOL = '', SKIP, dRec.MEDSCHOOL), IF(bNoFilter,dRec.MEDSCHOOL,''));
    SELF.MEDSCHOOL_YEAR := IF('MEDSCHOOL_YEAR' IN ssFilter, IF(dRec.MEDSCHOOL_YEAR = 0, SKIP, dRec.MEDSCHOOL_YEAR), IF(bNoFilter,dRec.MEDSCHOOL_YEAR,0));
    SELF.LEXID := IF('LEXID' IN ssFilter, IF(dRec.LEXID = 0, SKIP, dRec.LEXID), IF(bNoFilter,dRec.LEXID,0));
    SELF.HMS_PIID := IF('HMS_PIID' IN ssFilter, IF(dRec.HMS_PIID = '', SKIP, dRec.HMS_PIID), IF(bNoFilter,dRec.HMS_PIID,''));
    SELF.VENDOR_ENTITY_ID := IF('VENDOR_ENTITY_ID' IN ssFilter, IF(dRec.VENDOR_ENTITY_ID = '', SKIP, dRec.VENDOR_ENTITY_ID), IF(bNoFilter,dRec.VENDOR_ENTITY_ID,''));
    SELF.TAX_ID := IF('TAX_ID' IN ssFilter, IF(dRec.TAX_ID = '', SKIP, dRec.TAX_ID), IF(bNoFilter,dRec.TAX_ID,''));
    SELF.BILLING_NPI := IF('BILLING_NPI' IN ssFilter, IF(dRec.BILLING_NPI = '', SKIP, dRec.BILLING_NPI), IF(bNoFilter,dRec.BILLING_NPI,''));
    SELF.mode := dProfile.macroCallOrig;
    SELF.compareMode := dProfile.macroCallNew;
    SELF.description := dProfile.description;
    SELF.uniqueid := iRandomID;
    SELF := dRec;
  END;
  EXPORT fGetSamples(DATASET(modLayouts.profileRec) dProfile, UNSIGNED iNumSamples, UNSIGNED iBuildDate=0) := FUNCTION
    iTimeStamp := IF(iBuildDate<>0,iBuildDate,(UNSIGNED)(StringLib.StringFilterOut(pkgSTD.Date.SecondsToString(pkgSTD.Date.CurrentSeconds(FALSE), '%F%H%M%S%u'), '-')[1..14])) : GLOBAL;
      
    //Expand here to match your data. -ZRS 4/8/2019    
    dHeaderSources := PROJECT(modFiles.dHeaderPayload,tHeaderSourcesToSample(LEFT,iTimeStamp));
    dSancSources := PROJECT(modFiles.dSanctionsData,tSancSourcesToSample(LEFT,iTimeStamp));
    dDeathSources := PROJECT(modFiles.dDeathData,tDeathSourcesToSample(LEFT,iTimeStamp));
    dClientDataSources := PROJECT(modFiles.dClientData,tClientDataSourcesToSample(LEFT,iTimeStamp));
    dAssociateSources := PROJECT(modFiles.dAssociateData,tAssociateSourcesToSample(LEFT,iTimeStamp));
    dCMSOrderSources := PROJECT(modFiles.dCMSOrderRefData,tCMSOrderSourcesToSample(LEFT,iTimeStamp));
    dHMSDataSources := PROJECT(modFiles.dHMSData,tHMSDataSourcesToSample(LEFT,iTimeStamp));
    dSAMExclusionDataSources := PROJECT(modFiles.dSAMExclusionData,tSAMExclusionSourcesToSample(LEFT,iTimeStamp));
    dCombine :=  dHeaderSources & 
                 dSancSources &                 
                 dDeathSources & 
                 dClientDataSources &
                 dAssociateSources &
                 dCMSOrderSources &
                 dHMSDataSources &
                 dSAMExclusionDataSources;
                
    dOutput := DEDUP(SORT(DISTRIBUTE(DEDUP(SORT(JOIN(dCombine,dProfile, LEFT.src_category IN RIGHT.srcFilter,tFilter(LEFT,RIGHT,RANDOM()),FEW,MANY LOOKUP,ALL),src_category,mode,compareMode,description,uniqueid,LOCAL),src_category,mode,compareMode,description,KEEP(iNumSamples),LOCAL),HASH32(src_category,mode,compareMode,description),merge(src_category,mode,compareMode,description)),src_category,mode,compareMode,description,uniqueid),src_category,mode,compareMode,description,KEEP(iNumSamples));
    
    RETURN PROJECT(SORT(dOutput,SRC_CATEGORY,LNPID,RID,MODE,COMPAREMODE,DESCRIPTION),TRANSFORM(modLayouts.lSampleLayout, SELF.uniqueID:=COUNTER,SELF:=LEFT));
  END;
  
  //Generate Sample Statistics and send as a CSV
  
  SHARED modLayouts.lSampleStatsRec tCntStats(modLayouts.lSampleLayout rRec) := TRANSFORM
    //Change Field names to match your data. -ZRS 4/8/2019    
    SELF.sSrcCategory := rRec.SRC_CATEGORY;
    SELF.iTimeStamp := rRec.TIMESTAMP;
    SELF.iMode := rRec.MODE;
    SELF.iCompareMode := rRec.COMPAREMODE;
    SELF.sDescription := rRec.DESCRIPTION;
    SELF.nTotalCnt := 1.0;
    SELF.nFnameCnt := IF(rRec.FNAME='',0,100.0);
    SELF.nMnameCnt := IF(rRec.MNAME='',0,100.0);
    SELF.nLnameCnt := IF(rRec.LNAME='',0,100.0);
    SELF.nSnameCnt := IF(rRec.SNAME='',0,100.0);
    SELF.nGenderCnt := IF(rRec.GENDER='',0,100.0);
    SELF.nSSNCnt := IF(rRec.SSN='',0,100.0);
    SELF.nDOBCnt := IF(rRec.DOB=0,0,100.0);    
    SELF.nTaxonomyCnt := IF(rRec.TAXONOMY='',0,100.0);
    SELF.nPractitionerTypeCnt := IF(rRec.PRACTITIONER_TYPE='',0,100.0);
    SELF.nClassificationCnt := IF(rRec.CLASSIFICATION='',0,100.0);
    SELF.nPrimRangeCnt := IF(rRec.PRIM_RANGE='',0,100.0);
    SELF.nPrimNameCnt := IF(rRec.PRIM_NAME='',0,100.0);
    SELF.nSecRangeCnt := IF(rRec.SEC_RANGE='',0,100.0);
    SELF.nCityCnt := IF(rRec.CITY='',0,100.0);
    SELF.nSTCnt := IF(rRec.ST='',0,100.0);
    SELF.nZipCnt := IF(rRec.ZIP='',0,100.0);
    SELF.nPracPhoneCnt := IF(rRec.PRAC_PHONE='',0,100.0);
    SELF.nNPINumberCnt := IF(rRec.NPI_NUMBER='',0,100.0);
    SELF.nUPINCnt := IF(rRec.UPIN='',0,100.0);
    SELF.nDEANumberCnt := IF(rRec.DEA_NUMBER='',0,100.0);
    SELF.nLICStateCnt := IF(rRec.LIC_STATE='',0,100.0);
    SELF.nLICNbrNumCnt := IF(rRec.LIC_NBR_NUM='',0,100.0);
    SELF.nCSRStateCnt := IF(rRec.CSR_STATE='',0,100.0);
    SELF.nCSRNbrNumCnt := IF(rRec.CSR_NBR_NUM='',0,100.0);
    SELF.nMedschoolCnt := IF(rRec.MEDSCHOOL='',0,100.0);
    SELF.nMedschoolYearCnt := IF(rRec.MEDSCHOOL_YEAR=0,0,100.0);
    SELF.nLexidCnt := IF(rRec.LEXID=0,0,100.0);
    SELF.nHMSPiidCnt := IF(rRec.HMS_PIID='',0,100.0);	
    SELF.nVendorEntitiyCnt := IF(rRec.VENDOR_ENTITY_ID='',0,100.0);
    SELF.nTaxIdCnt := IF(rRec.TAX_ID='',0,100.0);
    SELF.nBillingNPICnt := IF(rRec.BILLING_NPI='',0,100.0);
  END;
  SHARED modLayouts.lSampleStatsRec tRollStats(modLayouts.lSampleStatsRec rLRec, modLayouts.lSampleStatsRec rRRrec) := TRANSFORM
  //Change Field names to match your data. -ZRS 4/8/2019        
    SELF.sSrcCategory := rLRec.sSrcCategory;
    SELF.iTimeStamp := rLRec.iTimeStamp;
    SELF.iMode := rLRec.iMode;
    SELF.iCompareMode := rLRec.iCompareMode;
    SELF.sDescription := rLRec.sDescription;
    SELF.nTotalCnt := rLRec.nTotalCnt+rRRrec.nTotalCnt;
    SELF.nFnameCnt := ((((rLRec.nFnameCnt*rLRec.nTotalCnt)/100.0) + ((rRRrec.nFnameCnt*rRRrec.nTotalCnt)/100.0))/(rLRec.nTotalCnt+rRRrec.nTotalCnt))*100.0;
    SELF.nMnameCnt := ((((rLRec.nMnameCnt*rLRec.nTotalCnt)/100.0) + ((rRRrec.nMnameCnt*rRRrec.nTotalCnt)/100.0))/(rLRec.nTotalCnt+rRRrec.nTotalCnt))*100.0;
    SELF.nLnameCnt := ((((rLRec.nLnameCnt*rLRec.nTotalCnt)/100.0) + ((rRRrec.nLnameCnt*rRRrec.nTotalCnt)/100.0))/(rLRec.nTotalCnt+rRRrec.nTotalCnt))*100.0;
    SELF.nSnameCnt := ((((rLRec.nSnameCnt*rLRec.nTotalCnt)/100.0) + ((rRRrec.nSnameCnt*rRRrec.nTotalCnt)/100.0))/(rLRec.nTotalCnt+rRRrec.nTotalCnt))*100.0;
    SELF.nGenderCnt := ((((rLRec.nGenderCnt*rLRec.nTotalCnt)/100.0) + ((rRRrec.nGenderCnt*rRRrec.nTotalCnt)/100.0))/(rLRec.nTotalCnt+rRRrec.nTotalCnt))*100.0;
    SELF.nSSNCnt := ((((rLRec.nSSNCnt*rLRec.nTotalCnt)/100.0) + ((rRRrec.nSSNCnt*rRRrec.nTotalCnt)/100.0))/(rLRec.nTotalCnt+rRRrec.nTotalCnt))*100.0;
    SELF.nDOBCnt := ((((rLRec.nDOBCnt*rLRec.nTotalCnt)/100.0) + ((rRRrec.nDOBCnt*rRRrec.nTotalCnt)/100.0))/(rLRec.nTotalCnt+rRRrec.nTotalCnt))*100.0;
    SELF.nTaxonomyCnt := ((((rLRec.nTaxonomyCnt*rLRec.nTotalCnt)/100.0) + ((rRRrec.nTaxonomyCnt*rRRrec.nTotalCnt)/100.0))/(rLRec.nTotalCnt+rRRrec.nTotalCnt))*100.0;
    SELF.nPractitionerTypeCnt := ((((rLRec.nPractitionerTypeCnt*rLRec.nTotalCnt)/100.0) + ((rRRrec.nPractitionerTypeCnt*rRRrec.nTotalCnt)/100.0))/(rLRec.nTotalCnt+rRRrec.nTotalCnt))*100.0;
    SELF.nClassificationCnt := ((((rLRec.nClassificationCnt*rLRec.nTotalCnt)/100.0) + ((rRRrec.nClassificationCnt*rRRrec.nTotalCnt)/100.0))/(rLRec.nTotalCnt+rRRrec.nTotalCnt))*100.0;
    SELF.nPrimRangeCnt := ((((rLRec.nPrimRangeCnt*rLRec.nTotalCnt)/100.0) + ((rRRrec.nPrimRangeCnt*rRRrec.nTotalCnt)/100.0))/(rLRec.nTotalCnt+rRRrec.nTotalCnt))*100.0;
    SELF.nPrimNameCnt := ((((rLRec.nPrimNameCnt*rLRec.nTotalCnt)/100.0) + ((rRRrec.nPrimNameCnt*rRRrec.nTotalCnt)/100.0))/(rLRec.nTotalCnt+rRRrec.nTotalCnt))*100.0;
    SELF.nSecRangeCnt := ((((rLRec.nSecRangeCnt*rLRec.nTotalCnt)/100.0) + ((rRRrec.nSecRangeCnt*rRRrec.nTotalCnt)/100.0))/(rLRec.nTotalCnt+rRRrec.nTotalCnt))*100.0;
    SELF.nCityCnt := ((((rLRec.nCityCnt*rLRec.nTotalCnt)/100.0) + ((rRRrec.nCityCnt*rRRrec.nTotalCnt)/100.0))/(rLRec.nTotalCnt+rRRrec.nTotalCnt))*100.0;
    SELF.nSTCnt := ((((rLRec.nSTCnt*rLRec.nTotalCnt)/100.0) + ((rRRrec.nSTCnt*rRRrec.nTotalCnt)/100.0))/(rLRec.nTotalCnt+rRRrec.nTotalCnt))*100.0;
    SELF.nZipCnt := ((((rLRec.nZipCnt*rLRec.nTotalCnt)/100.0) + ((rRRrec.nZipCnt*rRRrec.nTotalCnt)/100.0))/(rLRec.nTotalCnt+rRRrec.nTotalCnt))*100.0;
    SELF.nPracPhoneCnt := ((((rLRec.nPracPhoneCnt*rLRec.nTotalCnt)/100.0) + ((rRRrec.nPracPhoneCnt*rRRrec.nTotalCnt)/100.0))/(rLRec.nTotalCnt+rRRrec.nTotalCnt))*100.0;
    SELF.nNPINumberCnt := ((((rLRec.nNPINumberCnt*rLRec.nTotalCnt)/100.0) + ((rRRrec.nNPINumberCnt*rRRrec.nTotalCnt)/100.0))/(rLRec.nTotalCnt+rRRrec.nTotalCnt))*100.0;
    SELF.nUPINCnt := ((((rLRec.nUPINCnt*rLRec.nTotalCnt)/100.0) + ((rRRrec.nUPINCnt*rRRrec.nTotalCnt)/100.0))/(rLRec.nTotalCnt+rRRrec.nTotalCnt))*100.0;
    SELF.nDEANumberCnt := ((((rLRec.nDEANumberCnt*rLRec.nTotalCnt)/100.0) + ((rRRrec.nDEANumberCnt*rRRrec.nTotalCnt)/100.0))/(rLRec.nTotalCnt+rRRrec.nTotalCnt))*100.0;
    SELF.nLICStateCnt := ((((rLRec.nLICStateCnt*rLRec.nTotalCnt)/100.0) + ((rRRrec.nLICStateCnt*rRRrec.nTotalCnt)/100.0))/(rLRec.nTotalCnt+rRRrec.nTotalCnt))*100.0;
    SELF.nLICNbrNumCnt := ((((rLRec.nLICNbrNumCnt*rLRec.nTotalCnt)/100.0) + ((rRRrec.nLICNbrNumCnt*rRRrec.nTotalCnt)/100.0))/(rLRec.nTotalCnt+rRRrec.nTotalCnt))*100.0;
    SELF.nCSRStateCnt := ((((rLRec.nCSRStateCnt*rLRec.nTotalCnt)/100.0) + ((rRRrec.nCSRStateCnt*rRRrec.nTotalCnt)/100.0))/(rLRec.nTotalCnt+rRRrec.nTotalCnt))*100.0;
    SELF.nCSRNbrNumCnt := ((((rLRec.nCSRNbrNumCnt*rLRec.nTotalCnt)/100.0) + ((rRRrec.nCSRNbrNumCnt*rRRrec.nTotalCnt)/100.0))/(rLRec.nTotalCnt+rRRrec.nTotalCnt))*100.0;
    SELF.nMedschoolCnt := ((((rLRec.nMedschoolCnt*rLRec.nTotalCnt)/100.0) + ((rRRrec.nMedschoolCnt*rRRrec.nTotalCnt)/100.0))/(rLRec.nTotalCnt+rRRrec.nTotalCnt))*100.0;
    SELF.nMedschoolYearCnt := ((((rLRec.nMedschoolYearCnt*rLRec.nTotalCnt)/100.0) + ((rRRrec.nMedschoolYearCnt*rRRrec.nTotalCnt)/100.0))/(rLRec.nTotalCnt+rRRrec.nTotalCnt))*100.0;
    SELF.nLexidCnt := ((((rLRec.nLexidCnt*rLRec.nTotalCnt)/100.0) + ((rRRrec.nLexidCnt*rRRrec.nTotalCnt)/100.0))/(rLRec.nTotalCnt+rRRrec.nTotalCnt))*100.0;
    SELF.nHMSPiidCnt := ((((rLRec.nHMSPiidCnt*rLRec.nTotalCnt)/100.0) + ((rRRrec.nHMSPiidCnt*rRRrec.nTotalCnt)/100.0))/(rLRec.nTotalCnt+rRRrec.nTotalCnt))*100.0;	
    SELF.nVendorEntitiyCnt := ((((rLRec.nVendorEntitiyCnt*rLRec.nTotalCnt)/100.0) + ((rRRrec.nVendorEntitiyCnt*rRRrec.nTotalCnt)/100.0))/(rLRec.nTotalCnt+rRRrec.nTotalCnt))*100.0;
    SELF.nTaxIdCnt := ((((rLRec.nTaxIdCnt*rLRec.nTotalCnt)/100.0) + ((rRRrec.nTaxIdCnt*rRRrec.nTotalCnt)/100.0))/(rLRec.nTotalCnt+rRRrec.nTotalCnt))*100.0;
    SELF.nBillingNPICnt := ((((rLRec.nBillingNPICnt*rLRec.nTotalCnt)/100.0) + ((rRRrec.nBillingNPICnt*rRRrec.nTotalCnt)/100.0))/(rLRec.nTotalCnt+rRRrec.nTotalCnt))*100.0;
  END;
      
    
  SHARED modLayouts.lSampleStatsRec fCreateCSVStats(DATASET(modLayouts.lSampleLayout) dInput) := FUNCTION
    dInputInterm := SORT(PROJECT(dInput,tCntStats(LEFT)),iTimestamp,sSrcCategory,iMode,iCompareMode,sDescription);
    RETURN ROLLUP(dInputInterm,LEFT.iTimestamp=RIGHT.iTimestamp AND LEFT.sSrcCategory=RIGHT.sSrcCategory AND LEFT.iMode=RIGHT.iMode AND LEFT.iCompareMode=RIGHT.iCompareMode AND LEFT.sDescription=RIGHT.sDescription,tRollStats(LEFT,RIGHT));   
  END;
    
  SHARED fBuildCSV(DATASET(modLayouts.lSampleLayout) dInput) := FUNCTION
    dStats := fCreateCSVStats(dInput);
    RETURN modCSV.macConvertToCSV(dStats,FALSE);
  END;
  
  SHARED fEmailAsCSV(dInput, sCSVName, sTo, sSubject, sBody) := FUNCTIONMACRO
    dOutCSV := fBuildCSV(dInput);
    RETURN pkgSTD.System.Email.SendEmailAttachData(sTo, sSubject, sBody, (DATA)modCSV.macAttachData(dOutCSV), 'text/csv', sCSVName+'.csv');
  ENDMACRO; 
  
  //Load a previously made set of samples, first check to see if there is a ~ or not
  sSampleStringCleaned := IF(sSamplesFileName[1] <> '~', '~' + sSamplesFileName, sSamplesFileName);
  dImportedSamples := DATASET(sSampleStringCleaned,HealthCare_Provider_Header_ELERT.modLayouts.lSampleLayout,THOR);
  EXPORT dGeneratedSamples := IF(sSamplesFileName = '', fGetSamples(dProfile, iNumSamples, (integer)sVersion), dImportedSamples);
  
  SHARED aOutput := OUTPUT(dGeneratedSamples,,modFilenames.kSamplesLF(sVersion),COMPRESSED,EXPIRE(iExpireTime));
  SHARED aPromoteSuperfile := modSuperfiles.macUpdateSF(modFilenames.kSamplesLF(sVersion),modFilenames.kSamplesSF);
  SHARED aEmailCSV := fEmailAsCSV(dGeneratedSamples,'Healthcare_Provider_Header_ELERT_Stats_'+sVersion+'',modConstants.sEmailNotify,'Healthcare Provider Header ELERT Sample Gathering For '+sVersion+' Has Finished','');
  EXPORT aBuildSamples := SEQUENTIAL(pkgSTD.File.StartSuperFileTransaction(),
                        aOutput,
                        aPromoteSuperfile,
                        pkgSTD.File.FinishSuperFileTransaction(),
                        aEmailCSV);
END;
