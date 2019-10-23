/*
	Function returns all header records for a specific DID
*/
import InsuranceHeader_xLink, salt37;

EXPORT did_getAllRecs  (unsigned8 inDid):= FUNCTION	
	key := InsuranceHeader_xLink.Key_InsuranceHeader_DID;
	inLayout := InsuranceHeader_xLink.Process_xIDL_Layouts().InputLayout;
	outLayout := RECORDOF(key);	
	temLayout := {inLayout.uniqueid, inLayout.entered_did, outlayout};
	
	inLayout xtrans(UNSIGNED8 aIDL) := TRANSFORM
		SELF.Entered_DID := aIDL,
		SELF := []			
	END; 
	
	inData := DATASET([xtrans(inDid)]);
	
	// get records with incremental too.
	recs := JOIN(inData, key, LEFT.Entered_DID=RIGHT.s_did, 
			TRANSFORM(temLayout, SELF.uniqueid := LEFT.uniqueid, SELF.entered_did := LEFT.entered_did, SELF := RIGHT), LEFT OUTER, KEEP(10000), LIMIT(0));
	recsDate := SALT37.MAC_DatasetAsOf(recs, RID, DID, Uniqueid, DT_EFFECTIVE_FIRST, DT_EFFECTIVE_LAST, , 'YYYYMMDD', FALSE);	
 recsAll := recsDate(s_did>0) & join(inData, recsDate(s_did>0), left.entered_did = right.s_did, TRANSFORM(temLayout, self := left, self := []), left only);
 // get history for DIDs not found with incremental
	KeyIDHistory := InsuranceHeader_xlink.Process_xIDL_Layouts().KeyIDHistory;
	notfound := recsAll(s_did=0) ;
	didsNotFound := JOIN(notfound, keyIdHistory, left.entered_did = right.rid, 
		TRANSFORM({inLayout.uniqueid, RECORDOF(keyIdHistory)}, SELF.uniqueid := LEFT.uniqueid, SELF := RIGHT), LEFT OUTER, LIMIT(10000));
	didsNotFoundDate := 	SALT37.MAC_DatasetAsOf(didsNotFound, RID, DID, Uniqueid, DT_EFFECTIVE_FIRST, DT_EFFECTIVE_LAST, , 'YYYYMMDD', FALSE);	
	// get data for DIDs found in history and apply incremental
	recsNotFound := JOIN(didsNotFoundDate, key, LEFT.did = RIGHT.s_did, 
					TRANSFORM(temLayout, SELF.uniqueid := LEFT.uniqueid, SELF.entered_did := LEFT.did,
							SELF := RIGHT), LEFT OUTER, KEEP(10000), LIMIT(0));	
	recsNotFoundDate := SALT37.MAC_DatasetAsOf(recsNotFound, RID, DID, Uniqueid, DT_EFFECTIVE_FIRST, DT_EFFECTIVE_LAST, , 'YYYYMMDD', FALSE);	
	
	finalRecords := PROJECT(recsDate(s_did>0) + recsNotFoundDate, TRANSFORM(outlayout, SELF := LEFT));
	// output(inData, named('inData'));
	// output(recs, named('recs'));
	// output(recsDate, named('recsDate'));
	// output(recsAll, named('recsAll'));
	// output(notfound, named('notfound'));
	// output(didsNotFound, named('didsNotFound'));
	// output(didsNotFoundDate, named('didsNotFoundDate'));
	// output(recsNotFound, named('recsNotFound'));
	// output(recsNotFoundDate, named('recsNotFoundDate'));
	
	RETURN finalRecords;
END;

/*
for testing 

unsigned8 aDid := 400;
IDLExternalLinking.did_getAllRecs(aDid);
*/