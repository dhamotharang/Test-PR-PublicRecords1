/*--SOAP--
<message name="DIDHistoryService">
<part name="DID" type="xsd:string"/>
</message>
*/
/*--INFO-- Find the history of a given DID. Enter the current ID and it will walk backwards and find what went into it*/
EXPORT DIDHistoryService := MACRO
  IMPORT SALT37,InsuranceHeader_RemoteLinking;
  STRING50 DIDstr := ''  : STORED('DID');
  UNSIGNED8 DID0 := (UNSIGNED8)DIDstr; 
  K := InsuranceHeader_RemoteLinking.MatchHistory.MatchHistoryKey;
  rec := RECORD
    SALT37.UIDType DID_before;
    SALT37.UIDType DID_after;
    SALT37.UIDType RID;
    UNSIGNED6 change_date;
    UNSIGNED2 Depth; // The depth down the tree, 0 is the top node
  END;
  seed := DATASET([{DID0,0,0,99999999,0}],rec); // The top of the tree
  rec ftch(DATASET(rec) existing,UNSIGNED2 Iteration) := FUNCTION
    nodes := DEDUP(existing,DID_before,ALL);
    nxtlvl := JOIN(nodes,K,LEFT.DID_before=RIGHT.DID_after,TRANSFORM(rec,SELF.Depth := Iteration, SELF := RIGHT),LIMIT(InsuranceHeader_RemoteLinking.Config.JoinLimit));
    RETURN existing+nxtlvl;
  END;
  tree := LOOP(seed,LEFT.Depth=COUNTER-1,ftch(ROWS(LEFT),COUNTER));
  OUTPUT( tree,NAMED('History'));
ENDMACRO;
 
