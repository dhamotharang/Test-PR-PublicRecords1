// EXPORT XNOMATCH_FragHunter_v1 := 'todo';

IMPORT  STD, HealthcareNoMatchHeader_Ingest, HealthcareNoMatchHeader_InternalLinking, 
        HealthcareNoMatchHeader_ExternalLinking, SALT311;

EXPORT XNOMATCH_FragHunter_v1(    
    STRING	pSrc        = ''
    , STRING  pVersion  = (STRING)STD.Date.Today()
    , DATASET(HealthcareNoMatchHeader_InternalLinking.Layout_Header) pInfile = HealthcareNoMatchHeader_Ingest.Files(pSrc).AllRecords
    , DATASET({UNSIGNED8 nomatch_id;UNSIGNED LexID}) pInputIds
  ) := FUNCTION

	dNoMatchKeys := PULL(HealthcareNoMatchHeader_ExternalLinking.Process_XNOMATCH_Layouts(pSrc,pVersion,pInfile).key);

	rInputIds := RECORD
		UNSIGNED6 uniqueid;
		UNSIGNED8 nomatch_id;
		UNSIGNED8 LexID;
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
  DSAfter_DOB := SALT311.MAC_Field_Prop_Do(x_NoMatchIDs,DOB,nomatch_id);
  DSAfter_LEXID := SALT311.MAC_Field_Prop_Do(DSAfter_DOB,LEXID,nomatch_id);
  DSAfter_SUFFIX := SALT311.MAC_Field_Prop_Do(DSAfter_LEXID,SUFFIX,nomatch_id);
  DSAfter_FNAME := SALT311.MAC_Field_Prop_Do(DSAfter_SUFFIX,FNAME,nomatch_id);
  DSAfter_MNAME := SALT311.MAC_Field_Prop_Do(DSAfter_FNAME,MNAME,nomatch_id);
  DSAfter_LNAME := SALT311.MAC_Field_Prop_Do(DSAfter_MNAME,LNAME,nomatch_id);

	HealthcareNoMatchHeader_ExternalLinking.MAC_MEOW_XNOMATCH_Batch(
    pSrc,pVersion,pInfile,
    DSAfter_LNAME,uniqueid,,src,ssn,dob,lexid,suffix,fname,mname,lname,gender,
    prim_name,prim_range,sec_range,city_name,st,zip,DT_FIRST_SEEN,DT_LAST_SEEN,
    ,,,,,OutFile,FALSE
  );

	dOutputAppend := JOIN(DISTRIBUTE(dInputIds,uniqueid),DISTRIBUTE(Outfile,reference),LEFT.uniqueid=RIGHT.reference,TRANSFORM({recordof(right),unsigned8 NoMatchIdSource,unsigned8 LexIDSource},SELF.NoMatchIdSource:=LEFT.nomatch_id;SELF.LexIDSource:=LEFT.LexID;SELF:=RIGHT),LOCAL,LEFT OUTER);
	
	RETURN dOutputAppend;
	
END;