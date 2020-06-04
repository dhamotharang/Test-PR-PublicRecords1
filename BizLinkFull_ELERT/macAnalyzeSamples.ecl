
EXPORT macAnalyzeSamples(dSamples, dProfile, sVersion, csvFormat=true) := macro

Import SALT311;

//Generate Sample Statistics and send as a CSV
  setFieldBucket(inField, outField) := macro
		SELF.outField := IF(rRec.inField='',0,100.0);
	endmacro;
	setFieldBucketInt(inField, outField) := macro
		SELF.outField := IF(rRec.inField=0,0,100.0);
	endmacro;
	
  BizLinkFull_ELERT.modLayouts.lSampleStatsRec tCntStats(BizLinkFull_ELERT.modLayouts.lSampleLayout rRec) := TRANSFORM
    //Change Field names to match your data. -ZRS 4/8/2019    
    SELF.sProfileBucket := rRec.PROFILE_BUCKET;
    SELF.iTimeStamp := (STRING) rRec.TIMESTAMP;
    SELF.iMode := (STRING) rRec.MODE;
    SELF.iCompareMode := (STRING) rRec.COMPAREMODE;
    SELF.sDescription := rRec.DESCRIPTION;
    SELF.nTotalCnt := 1.0;
    setFieldBucket(company_name,ncompany_nameCnt);
	  setFieldBucket(prim_range,nprim_rangeCnt);
	  setFieldBucket(prim_name,nprim_nameCnt);
	  setFieldBucket(sec_range,nsec_rangeCnt);
	  setFieldBucket(city, ncityCnt);
	  setFieldBucket(state, nstateCnt);
	  setFieldBucket(zip5,nzip5Cnt);
	  setFieldBucketInt(zip_radius_miles,nzip_radius_milesCnt);
		setFieldBucket(phone10,nphone10Cnt);
	  setFieldBucket(fein, nfeinCnt);
	  setFieldBucket(url, nurlCnt);
	  setFieldBucket(email, nemailCnt);
	  setFieldBucket(contact_fname, ncontact_fnameCnt);
	  setFieldBucket(contact_mname, ncontact_mnameCnt);
	  setFieldBucket(contact_lname, ncontact_lnameCnt);
	  setFieldBucket(contact_ssn, ncontact_ssnCnt);
	  setFieldBucketInt(contact_did, ncontact_didCnt);
	  setFieldBucket(sic_code, nsic_codeCnt);
  END;
	
	mac_tRollStats(infield) := macro
	    SELF.inField := ((((rLRec.inField*rLRec.nTotalCnt)/100.0) + ((rRRrec.inField*rRRrec.nTotalCnt)/100.0))/(rLRec.nTotalCnt+rRRrec.nTotalCnt))*100.0;
  endmacro;
	
  BizLinkFull_ELERT.modLayouts.lSampleStatsRec tRollStats(BizLinkFull_ELERT.modLayouts.lSampleStatsRec rLRec, BizLinkFull_ELERT.modLayouts.lSampleStatsRec rRRrec) := TRANSFORM
    SELF.sProfileBucket := rLRec.sProfileBucket;
    SELF.iTimeStamp := rLRec.iTimeStamp;
    SELF.iMode := rLRec.iMode;
    SELF.iCompareMode := rLRec.iCompareMode;
    SELF.sDescription := rLRec.sDescription;
    SELF.nTotalCnt := rLRec.nTotalCnt+rRRrec.nTotalCnt;
		//specific fields for header
    mac_tRollStats(ncompany_nameCnt);
	  mac_tRollStats(nprim_rangeCnt);
	  mac_tRollStats(nprim_nameCnt);
	  mac_tRollStats(nsec_rangeCnt);
	  mac_tRollStats(ncityCnt);
	  mac_tRollStats(nstateCnt);
	  mac_tRollStats(nzip5Cnt);
	  mac_tRollStats(nzip_radius_milesCnt);
		mac_tRollStats(nphone10Cnt);
	  mac_tRollStats(nfeinCnt);
	  mac_tRollStats(nurlCnt);
	  mac_tRollStats(nemailCnt);
	  mac_tRollStats(ncontact_fnameCnt);
	  mac_tRollStats(ncontact_mnameCnt);
	  mac_tRollStats(ncontact_lnameCnt);
	  mac_tRollStats(ncontact_ssnCnt);
	  mac_tRollStats(ncontact_didCnt);
	  mac_tRollStats(nsic_codeCnt);
  END;
  

 
MAC_PopulationStatistics(infile,input_source='',Ref='',Input_name = true , Input_company_name = true) := functionmacro
  #uniquename(of)
  %of% := RECORD
    #IF (#TEXT(input_source)<>'')
    SALT311.StrType source;
    #END
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    tmp := regexreplace(' ', IF(le.company_name!='','company:','')
         +MAP((le.state !='') and (le.city != '') => 'stcity:',
               le.state !='' => 'st:',
               '')
         +IF(le.zip5!='','zip:','')
         +IF(le.prim_range!='','primrange:','')
         +IF(le.prim_name!='','primname:','')
         +IF(le.fein!='','fein:','')
         +IF(le.sic_code!='','sic:','')
         +IF(le.phone10!='','phone:','')
         +IF(le.url!='' or le.email!='','url/email:','')
         +IF(le.contact_did>0,'did:','')
         +IF(le.contact_ssn!='','ssn:','')
         +IF(le.contact_lname!='','lname:','')
         +IF(le.source_record_id>0,'sourcerid:','')
         +IF(le.proxid>0 or le.seleid>0,'bipid:',''), '');

    SELF.fields := tmp[1.. length(tmp)-1];
;
  #IF (#TEXT(input_source)<>'')
    self.source := le.source;
    #END
    
  END;
  #uniquename(op)
  %op% := PROJECT(infile,%ot%(LEFT));
  #uniquename(ort)
  %ort% := RECORD
    #IF (#TEXT(input_source)<>'')
    %op%.source;
    #END
    %op%.fields;
    UNSIGNED cnt := COUNT(GROUP);
		REAL pct := round(COUNT(GROUP)/COUNT(%op%)*100, 2);
  END;
	return 
	   dataset([{input_source,'',0,0}],%ort%)+
	   TOPN( TABLE( %op%, %ort%, fields, FEW ), 1000, -cnt );
ENDMACRO;

statsPerSource(bucketLabel, sampleFile) := FUNCTIONMACRO
  filteredBySource := sampleFile(profile_bucket = bucketLabel); 
  return MAC_PopulationStatistics(filteredBySource, bucketLabel);
ENDMACRO;

generateRecordStats(profile, sampleFile) := FUNCTIONMACRO
  #DECLARE(sCodeStr);
  #DECLARE(sCodeOuputStr);
  #DECLARE(iIndex);
  #DECLARE(iSizeOfData);

  #SET(sCodeStr,'');
  #SET(sCodeOuputStr,'');
  #SET(iIndex,1);
  #SET(iSizeOfData,COUNT(profile));
  #LOOP
    #IF(%iIndex% <= %iSizeOfData%) 
		  #IF(%iIndex% > 1) 
        #APPEND(sCodeStr, ' & ')
      #END
      #APPEND(sCodeStr,'statsPerSource('+#TEXT(profile)+'['+%iIndex%+'].srcCategory,'+#TEXT(sampleFile)+')')

      #SET(iIndex,%iIndex%+1)
			
    #ELSE
       #BREAK
    #END
  #END
  // output(%'sCodeStr'%);  //Debug
	return %sCodeStr%;
ENDMACRO;

  generateFieldStats(dInput) := FUNCTIONMACRO
    dInputInterm := SORT(PROJECT(dInput,tCntStats(LEFT)),iTimestamp,sProfileBucket,iMode,iCompareMode,sDescription);
    RETURN ROLLUP(dInputInterm,LEFT.iTimestamp=RIGHT.iTimestamp AND LEFT.sProfileBucket=RIGHT.sProfileBucket AND LEFT.iMode=RIGHT.iMode AND LEFT.iCompareMode=RIGHT.iCompareMode AND LEFT.sDescription=RIGHT.sDescription,tRollStats(LEFT,RIGHT));   
  ENDMACRO;

 recordStats := generateRecordStats(dProfile, dSamples);
 fieldStats  := generateFieldStats(dSamples);
 csvStats    := project(sort(
                     project(BizLinkFull_ELERT.modCSV.macConvertToCSV(fieldStats,FALSE), transform({recordof(left); unsigned ctr},
                                                                                    self.ctr := counter;
																																										self := left))
																																										&
                     project(BizLinkFull_ELERT.modCSV.macConvertToCSV(recordStats,TRUE), transform({recordof(left); unsigned ctr},
                                                                                    self.ctr := counter + 10000;
																																										self := left)),
										ctr), recordof(left) - ctr);
  
ENDMACRO;

