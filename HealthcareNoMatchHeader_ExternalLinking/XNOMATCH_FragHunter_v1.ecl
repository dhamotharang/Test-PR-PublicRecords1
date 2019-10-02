// EXPORT XNOMATCH_FragHunter_v1 := 'todo';

IMPORT  STD, HealthcareNoMatchHeader_Ingest, HealthcareNoMatchHeader_InternalLinking, 
        HealthcareNoMatchHeader_ExternalLinking, SALT311;

EXPORT XNOMATCH_FragHunter_v1(    
    STRING	pSrc        = ''
    , STRING  pVersion  = (STRING)STD.Date.Today()
    , DATASET(HealthcareNoMatchHeader_InternalLinking.Layout_Header) pInfile = HealthcareNoMatchHeader_Ingest.Files(pSrc).AllRecords
    , DATASET({UNSIGNED8 nomatch_id}) pInputIds
  ) := FUNCTION

	dNoMatchKeys := PULL(HealthcareNoMatchHeader_ExternalLinking.Process_XNOMATCH_Layouts(pSrc,pVersion,pInfile).key);

	rInputIds := RECORD
		UNSIGNED6 uniqueid;
		UNSIGNED8 nomatch_id;
	END;

	rInputIds tInputIds(pInputIds L, UNSIGNED C) := TRANSFORM
		SELF.uniqueid := C;
		SELF:=L;
	END;	
	
	//Add uniqueid for tracking
	dInputIds := PROJECT(pInputIds,tInputIds(LEFT,COUNTER));
	
	//Pull header data for each nomatch_id
	x_NoMatchIDs := JOIN(DISTRIBUTE(dNoMatchKeys,nomatch_id),DISTRIBUTE(dInputIds,nomatch_id),LEFT.nomatch_id=RIGHT.nomatch_id,TRANSFORM({UNSIGNED6 uniqueid,RECORDOF(LEFT)},SELF.uniqueid:=RIGHT.uniqueid;SELF:=LEFT),LOCAL);
	
	//Propagate fields
	DSAfter_SUFFIX  :=  SALT311.MAC_Field_Prop_Do(x_NoMatchIDs,SUFFIX,NOMATCH_ID);
  DSAfter_MNAME   :=  SALT311.MAC_Field_Prop_Do(DSAfter_SUFFIX,MNAME,NOMATCH_ID);
  DSAfter_GENDER  :=  SALT311.MAC_Field_Prop_Do(DSAfter_MNAME,GENDER,NOMATCH_ID);
  DSAfter_SSN     :=  SALT311.MAC_Field_Prop_Do(DSAfter_GENDER,SSN,NOMATCH_ID);
  DSAfter_DOB     :=  SALT311.MAC_Field_Prop_Do(DSAfter_SSN,DOB,NOMATCH_ID);
  DSAfter_LEXID   :=  SALT311.MAC_Field_Prop_Do(DSAfter_DOB,LEXID,NOMATCH_ID);

	HealthcareNoMatchHeader_ExternalLinking.MAC_MEOW_XNOMATCH_Batch(
    pSrc,pVersion,pInfile,
    DSAfter_LEXID,uniqueid,,src,ssn,dob,lexid,suffix,fname,mname,lname,gender,
    prim_name,prim_range,sec_range,city_name,st,zip,DT_FIRST_SEEN,DT_LAST_SEEN,
    ,,,,,OutFile,FALSE
  );

	dOutputAppend := JOIN(DISTRIBUTE(dInputIds,uniqueid),DISTRIBUTE(Outfile,reference),LEFT.uniqueid=RIGHT.reference,TRANSFORM({recordof(right),unsigned8 NoMatchIdSource},SELF.NoMatchIdSource:=LEFT.nomatch_id;SELF:=RIGHT),LOCAL,LEFT OUTER);
	
	RETURN dOutputAppend;
	
END;