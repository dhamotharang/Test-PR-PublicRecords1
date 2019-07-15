/* 
  make sure all DIDs have records where DID=RID 
  This function should only be used for full file build and not for incremental.
*/
EXPORT IdHistoryFull(DATASET(layout_InsuranceHeader) aHeader) := FUNCTION
  layout := {aHeader.DID, aHeader.RID, aHeader.DT_EFFECTIVE_FIRST, aHeader.DT_EFFECTIVE_LAST};
  sIDTable := TABLE(aHeader,{DID, RID, DT_EFFECTIVE_FIRST, DT_EFFECTIVE_LAST}, RID, DT_EFFECTIVE_FIRST, DT_EFFECTIVE_LAST, DID,MERGE);
    
  sameDidRid := DISTRIBUTE(sIDTable(did=rid), did);  // records where DID=RID
  allDidRecs := DEDUP(SORT(DISTRIBUTE(sIDTable, did), did, LOCAL), did, LOCAL);  // all records

  j2 := JOIN(allDidRecs, sameDidRid, // returns only DIDs that don't have records DID=RID
          LEFT.did=RIGHT.did, 
          TRANSFORM(layout, 
            SELF.did := LEFT.did, 
            SELF.rid :=  LEFT.did, 
            SELF := LEFT), LEFT ONLY, LOCAL);  
  allIdRecs := DEDUP(SORT(sIDTable + j2, rid, did, LOCAL), rid, did, LOCAL);
  RETURN allIdRecs;
END;