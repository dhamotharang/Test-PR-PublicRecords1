IMPORT  STD, HealthcareNoMatchHeader_InternalLinking,HealthcareNoMatchHeader_Ingest,
        HealthcareNoMatchHeader_ExternalLinking;

EXPORT fragHunter(    
    STRING	pSrc        = ''
    , STRING  pVersion  = (STRING)STD.Date.Today()
    , DATASET(HealthcareNoMatchHeader_InternalLinking.Layout_Header) pInfile = HealthcareNoMatchHeader_Ingest.Files(pSrc).AllRecords
    , UNSIGNED fragThreshold
  ) := MODULE

	//Input data
	dInfileDedup := DEDUP(SORT(DISTRIBUTE(pInfile,nomatch_id),nomatch_id,LOCAL),nomatch_id,LOCAL);
	dNoMatchIDIn := PROJECT(dInfileDedup,{unsigned8 nomatch_id,unsigned8 LexID});

	//Fraghunter thor function
	SHARED dNoMatchIDOut := HealthcareNoMatchHeader_ExternalLinking.XNOMATCH_FragHunter_v1(pSrc,pVersion,pInfile,dNoMatchIDIn) :
    PERSIST(HealthcareNoMatchHeader_Ingest.Filenames(pSrc).lPersistTemplate + 'underlinks::fraghunter::dNoMatchIDOut',EXPIRE(10));
	
	//Normalize data
	SHARED Layout_Scoring := RECORD
		UNSIGNED6 uniqueid;
		UNSIGNED8 NoMatchIDSource;
		UNSIGNED8 LexIDSource;
		UNSIGNED8 nomatch_id;
		UNSIGNED8 LexID;
		INTEGER2 	weight;
	END;
	
	SHARED ChildRec := HealthcareNoMatchHeader_ExternalLinking.Process_XNOMATCH_Layouts(pSrc,pVersion,pInfile).LayoutScoredFetch;
	
	Layout_Scoring normFrags(dNoMatchIDOut L, ChildRec R) := TRANSFORM
    SELF.uniqueid   :=  L.reference;
    SELF.nomatch_id :=  R.nomatch_id;
    SELF.LexID      :=  R.LexID;
    SELF.weight     :=  R.weight;
    SELF            :=  L;
	END;
	
	EXPORT pFrags := NORMALIZE(dNoMatchIDOut, LEFT.results,normFrags(LEFT,RIGHT)) : PERSIST(HealthcareNoMatchHeader_Ingest.Filenames(pSrc).lPersistTemplate + 'underlinks::fragHunter::pFrags',EXPIRE(10));
	
	//Filter any fragments that are below the weight threshold
	EXPORT vFrags     :=  pFrags(nomatch_id <> NoMatchIDSource AND LexID <> LexIDSource AND weight > fragThreshold);
	SHARED vFragsDist :=  DISTRIBUTE(vFrags,nomatch_id) : PERSIST(HealthcareNoMatchHeader_Ingest.Filenames(pSrc).lPersistTemplate + 'underlinks::fragHunter::onlyFrags',EXPIRE(10));
   
	EXPORT onlyFrags:= vFragsDist;
END;