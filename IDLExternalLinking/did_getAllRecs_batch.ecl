/*
	Function returns all header records for DID specified in infile.
  in_DID : field name that contains DID
  in_Uniqueid : field name that contains an unique identifier.
		To have access to collapsed DIDs you have to join with the inputDID after 
	   the final results is returned
*/
import InsuranceHeader_xlink;

EXPORT did_getAllRecs_batch(infile, in_DID, in_Uniqueid ):= FUNCTIONMACRO
	asIndex := IF(thorlib.nodes() < 400 OR COUNT(infile) < 15000000, TRUE, FALSE);
	
	payloadKey := InsuranceHeader_xlink.key_InsuranceHeader_did;
	idHistKey := InsuranceHeader_xlink.Process_xIDL_Layouts().keyIDHistory;
	
  outLayout := RECORD
    infile.In_UniqueID;
    unsigned8 inputDID;
    RECORDOF(payloadKey);
  END;
  outLayout emptyResult(infile le) := TRANSFORM
    SELF.In_UniqueID := le.In_UniqueID;
    SELF.inputDID := le.In_DID;
    SELF := [];
  END;
 
  outLayout xJoinHist(outLayout le, idHistKey ri) := TRANSFORM
    SELF.In_UniqueID := le.In_UniqueID;
    SELF.inputDID := le.inputDID;
    SELF := ri;
    SELF := [];
  END;
 
  outLayout xJoinPayload(outLayout le, payloadKey ri) := TRANSFORM
    SELF.In_UniqueID := le.In_UniqueID;
    SELF.inputDID := le.inputDID;
		  // SELF.s_did := ri.s_did;
    SELF := ri;
  END;
 
  //keep all DIDs requested here
	 infile_emptyResult := PROJECT(infile, emptyResult(LEFT));
	
		// get data with incremental using key.  MAC_DatasetAsof does not return poisoned rec, so we need to add them at the end
  JEntKeyed0 := JOIN(infile_emptyResult, payloadKey, LEFT.inputDID = RIGHT.s_DID, xJoinPayload(LEFT,RIGHT), LEFT OUTER, KEEP(10000), LIMIT(0));
  JEntKeyed1 := SALT37.MAC_DatasetAsof(JEntKeyed0, RID, s_DID, In_UniqueID, DT_EFFECTIVE_FIRST, DT_EFFECTIVE_LAST, , 'YYYYMMDD', FALSE);
  JEntKeyed  := JEntKeyed1(s_DID > 0) & JOIN(infile_emptyResult, JEntKeyed1(s_DID > 0), LEFT.In_UniqueID = RIGHT.In_UniqueID AND LEFT.inputDID = RIGHT.s_DID, TRANSFORM(LEFT), LEFT ONLY);
	
	 // get data with incremental using pull key
  JEntPull0 := JOIN(infile_emptyResult, PULL(payloadKey), LEFT.inputDID = RIGHT.s_DID, xJoinPayload(LEFT,RIGHT), LEFT OUTER, HASH, KEEP(10000), LIMIT(0));
  JEntPull1 := SALT37.MAC_DatasetAsof(JEntPull0, RID, s_DID, In_UniqueID, DT_EFFECTIVE_FIRST, DT_EFFECTIVE_LAST, , 'YYYYMMDD', TRUE);
  JEntPull  := JEntPull1(s_DID > 0) & JOIN(infile_emptyResult, JEntPull1(s_DID > 0), LEFT.In_UniqueID = RIGHT.In_UniqueID AND LEFT.inputDID = RIGHT.s_DID, TRANSFORM(LEFT), LEFT ONLY, HASH);
 
  resultsEnt := IF(asIndex, JEntKeyed, JEntPull);
  resultsEnt_found := resultsEnt(s_DID > 0);
  resultsEnt_notfound := resultsEnt(s_DID = 0);
 
		// get history DIDs and apply incremental for index and pull file
  JRecKeyed_10 := JOIN(resultsEnt_notfound, idHistKey, LEFT.inputDID = RIGHT.RID, xJoinHist(LEFT,RIGHT), LEFT OUTER);
  JRecKeyed_11 := SALT37.MAC_DatasetAsof(JRecKeyed_10, RID, DID, In_UniqueID, DT_EFFECTIVE_FIRST, DT_EFFECTIVE_LAST, , 'YYYYMMDD', FALSE);
  JRecKeyed_1  := JRecKeyed_11(DID > 0) & JOIN(resultsEnt_notfound, JRecKeyed_11(DID > 0), LEFT.In_UniqueID = RIGHT.In_UniqueID AND LEFT.inputDID = RIGHT.RID, TRANSFORM(LEFT), LEFT ONLY);
  JRecPull_10 := JOIN(resultsEnt_notfound, PULL(idHistKey), LEFT.inputDID = RIGHT.RID, xJoinHist(LEFT,RIGHT), LEFT OUTER, HASH);
  JRecPull_11 := SALT37.MAC_DatasetAsof(JRecPull_10, RID, DID, In_UniqueID, DT_EFFECTIVE_FIRST, DT_EFFECTIVE_LAST, , 'YYYYMMDD', TRUE);
  JRecPull_1  := JRecPull_11(DID > 0) & JOIN(resultsEnt_notfound, JRecPull_11(DID > 0), LEFT.In_UniqueID = RIGHT.In_UniqueID AND LEFT.inputDID = RIGHT.RID, TRANSFORM(LEFT), LEFT ONLY, HASH);
 
  resultsIDHist := IF(asIndex, JRecKeyed_1, JRecPull_1);
  resultsIDHist_found := resultsIDHist(DID > 0);
  resultsIDHist_notfound := resultsIDHist(DID = 0);
 
		// get data for history DIDs with incremental
  JRecKeyed_20 := JOIN(resultsIDHist_found, payloadKey, LEFT.DID = RIGHT.s_DID, xJoinPayload(LEFT,RIGHT), LEFT OUTER, KEEP(10000), LIMIT(0));
  JRecKeyed_21 := SALT37.MAC_DatasetAsof(JRecKeyed_20, RID, s_DID, In_UniqueID, DT_EFFECTIVE_FIRST, DT_EFFECTIVE_LAST, , 'YYYYMMDD', FALSE);
  JRecKeyed_2  := JRecKeyed_21(s_DID > 0) & JOIN(resultsIDHist_found, JRecKeyed_21(s_DID > 0), LEFT.In_UniqueID = RIGHT.In_UniqueID AND LEFT.DID = RIGHT.s_DID, TRANSFORM(LEFT), LEFT ONLY);
  JRecPull_20 := JOIN(resultsIDHist_found, PULL(payloadKey), LEFT.DID = RIGHT.s_DID, xJoinPayload(LEFT,RIGHT), LEFT OUTER, HASH, KEEP(10000), LIMIT(0));
  JRecPull_21 := SALT37.MAC_DatasetAsof(JRecPull_20, RID, s_DID, In_UniqueID, DT_EFFECTIVE_FIRST, DT_EFFECTIVE_LAST, , 'YYYYMMDD', TRUE);
  JRecPull_2  := JRecPull_21(s_DID > 0) & JOIN(resultsIDHist_found, JRecPull_21(s_DID > 0), LEFT.In_UniqueID = RIGHT.In_UniqueID AND LEFT.DID = RIGHT.s_DID, TRANSFORM(LEFT), LEFT ONLY, HASH);
 
  resultsIDHistAll := IF(asIndex, JRecKeyed_2, JRecPull_2);
  resultsAll := resultsEnt_found & resultsIDHistAll & PROJECT(resultsIDHist_notfound, TRANSFORM(outLayout, SELF.inputDID := LEFT.inputDID, SELF.In_UniqueID := LEFT.In_UniqueID, SELF := []));
 
  // output(infile_emptyResult,named('infile_emptyResult'));
		// output(JEntKeyed0,named('JEntKeyed0'));
  // output(JEntKeyed1,named('JEntKeyed1'));
  // output(JEntKeyed,named('JEntKeyed'));  
  // output(resultsEnt,named('resultsEnt'));  
  // output(JRecKeyed_10,named('JRecKeyed_10'));  
  // output(JRecKeyed_11,named('JRecKeyed_11'));  
  // output(JRecKeyed_1,named('JRecKeyed_1'));  
  // output(resultsEnt,named('resultsEnt'));  
  // output(resultsIDHist,named('resultsIDHist'));  
  // output(resultsAll,named('resultsAll'));  
  RETURN resultsAll;	
ENDMACRO;

/* for testing
in1 := dataset([{1, 902377565},
		{2, 2399102698},
		{3, 191063834637}], {unsigned6 uid, unsigned8 did});
		
in1;

res := IDLExternalLinking.did_getAllRecs_batch(in1, did, uid);
res(uid=in1[1].uid);
res(uid=in1[2].uid);
res(uid=in1[3].uid);
*/
