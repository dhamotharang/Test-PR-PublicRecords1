IMPORT BairRx_PSS,BairRx_Common;

EXPORT Functions := MODULE

	EXPORT GetNormalizedScoresByEID(DATASET(BairRx_PSS.SALTLayout.LayoutOut) dRecsIn) := FUNCTION
		BairRx_PSS.Layouts.LayoutEIDRec NormScore(BairRx_PSS.SALTLayout.LayoutOut L, INTEGER c):= TRANSFORM
			SELF.eid_type := L.eid[1..3];
			SELF.field :=	BairRx_PSS.Constants.ScoreFields[c];
			
			_score := CHOOSE(c,L.Match_NAME_SUFFIX,L.Match_FNAME,L.Match_MNAME,L.Match_LNAME,L.Match_PRIM_RANGE,L.Match_PRIM_NAME,L.Match_SEC_RANGE,
													L.Match_P_CITY_NAME,L.Match_ST,L.Match_ZIP,L.Match_DOB,L.Match_PHONE,L.Match_DL_ST,L.Match_DL,L.Match_LEXID,L.Match_POSSIBLE_SSN,
													L.Match_CRIME,L.Match_NAME_TYPE,L.Match_CLEAN_GENDER,L.Match_CLASS_CODE,L.Match_DT_FIRST_SEEN,L.Match_DT_LAST_SEEN,L.Match_VIN,
													L.Match_PLATE,L.Match_LATITUDE,L.Match_LONGITUDE,L.Match_MAINNAME,L.Match_FULLNAME,L.Match_SEARCH_ADDR1,L.Match_SEARCH_ADDR2);
			SELF.score := IF(_score<>0,_score,SKIP);
			SELF	:= L ;
		END;				
		dNormedEIDs := NORMALIZE(dRecsIn(eid<>''),COUNT(BairRx_PSS.Constants.ScoreFields),NormScore(LEFT,COUNTER));	
		
		BairRx_PSS.Layouts.LayoutEIDScoreGroup xform(BairRx_PSS.Layouts.LayoutEIDRec l, DATASET(BairRx_PSS.Layouts.LayoutEIDRec) allrecs):= transform
			SELF.eid:= l.eid,
			SELF.scores := PROJECT(allrecs, TRANSFORM(BairRx_PSS.Layouts.LayoutScore,SELF:= LEFT)),
			SELF:= l
		END;

		RETURN ROLLUP(GROUP(SORT(dNormedEIDs,eid),eid),GROUP,xform(LEFT,ROWS(LEFT)));
	END;
	
END;