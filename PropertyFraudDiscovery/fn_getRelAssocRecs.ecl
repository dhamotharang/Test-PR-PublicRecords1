IMPORT Relationship,watchdog,Header,PAW,STD,ut,dx_BestRecords;

EXPORT fn_getRelAssocRecs(DATASET(Layouts.batch_working) ds_work_recs,
													IParams.BatchParams in_mod) := FUNCTION

	tmpRelRec := RECORD
		STRING20 acctno;
		UNSIGNED6 did1;
		UNSIGNED6 did2;
		UNSIGNED1 title;
		BOOLEAN is_business_affiliate:=FALSE;
	END;

	acctDidRec := RECORD
		STRING20 acctno;
		UNSIGNED6 did;
		BOOLEAN is_subject:=FALSE;
	END;

	acctDidSeleidRec := RECORD
		acctDidRec;
		UNSIGNED6 seleid;
		BOOLEAN is_business_affiliate:=TRUE;
	END;

	#IF(CONSTANTS.DEBUG_RELATIONSHIPS)
	getRelativeName(UNSIGNED6 did) := FUNCTION
		didRecs:=DATASET([{did}],{UNSIGNED6 did});
		wdRecs:=dx_BestRecords.get(didRecs, did, dx_BestRecords.Constants.perm_type.glb);
		RETURN STD.Str.CleanSpaces(wdRecs[1]._best.fname+' '+wdRecs[1]._best.lname+' '+wdRecs[1]._best.name_suffix);
	END;
	#END

	Layouts.batch_working addRelationships(Layouts.batch_working L,DATASET(tmpRelRec) R) := TRANSFORM
		SELF.relationships:=PROJECT(R,TRANSFORM(Layouts.relationship,
			SELF.did:=LEFT.did2,
			#IF(CONSTANTS.DEBUG_RELATIONSHIPS)
			SELF.title:=Header.relative_titles.fn_get_str_title(LEFT.title),
			SELF.name:=getRelativeName(LEFT.did2),
			#END
			SELF.is_business_affiliate:=LEFT.is_business_affiliate,
			SELF:=[]));
		SELF:=L;
	END;

	// REFERENCE: Header.relative_titles
	txMask := Relationship.Functions.getTransAssocFlgs(in_mod.relationship_transassocmask);
	dids := PROJECT(ds_work_recs,TRANSFORM(Relationship.layout_GetRelationship.DIDs_layout,SELF:=LEFT));
	RelationshipRecs := Relationship.proc_GetRelationship(dids,txflag:=txMask).result;
	ds_relationship1_recs := JOIN(ds_work_recs,RelationshipRecs,
		LEFT.did=RIGHT.did1,TRANSFORM(tmpRelRec,SELF.acctno:=LEFT.acctno,SELF:=RIGHT));

	did1Recs:=DEDUP(SORT(PROJECT(ds_relationship1_recs,TRANSFORM(acctDidRec,
		SELF.did:=LEFT.did1,
		SELF.is_subject:=TRUE,
		SELF:=LEFT)),acctno,did),acctno,did);

	did2Recs:=PROJECT(ds_relationship1_recs,TRANSFORM(acctDidRec,
		SELF.did:=LEFT.did2,
		SELF:=LEFT));

	pawDidRecs:=JOIN(did1Recs+did2Recs,PAW.Key_Did,
		KEYED(LEFT.did=RIGHT.did),
		LIMIT(1000,SKIP));

	pawDidSeleidRecs:=DEDUP(SORT(JOIN(pawDidRecs,PAW.Key_contactID,
		KEYED(LEFT.contact_id=RIGHT.contact_id) AND RIGHT.seleid!=0,
		TRANSFORM(acctDidSeleidRec,SELF:=LEFT,SELF:=RIGHT),
		LIMIT(0),KEEP(1)),RECORD),RECORD);

	pawCommonSeleidRecs:=JOIN(pawDidSeleidRecs(is_subject),pawDidSeleidRecs(~is_subject),
		LEFT.acctno=RIGHT.acctno AND LEFT.seleid=RIGHT.seleid,
		TRANSFORM(acctDidSeleidRec,SELF:=RIGHT),
		LIMIT(100,SKIP));

	ds_relationship2_recs:=JOIN(ds_relationship1_recs,pawCommonSeleidRecs,
		LEFT.acctno=RIGHT.acctno AND LEFT.did2=RIGHT.did,
		TRANSFORM(tmpRelRec,SELF.is_business_affiliate:=RIGHT.is_business_affiliate,SELF:=LEFT),
		LEFT OUTER,KEEP(1));

	ds_working_recs := DENORMALIZE(ds_work_recs,ds_relationship2_recs,
		LEFT.acctno=RIGHT.acctno,GROUP,addRelationships(LEFT,ROWS(RIGHT)));

	RETURN ds_working_recs;
END;
