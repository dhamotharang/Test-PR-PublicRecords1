/*--SOAP--
<message name="LocIdHistoryService">
<part name="LocId" type="xsd:string"/>
</message>
*/
/*--INFO-- Find the history of a given LocId. Enter the current ID and it will walk backwards and find what went into it*/
EXPORT LocIdHistoryService := MACRO
  IMPORT SALT37,LocationId_iLink;
  STRING50 LocIdstr := ''  : STORED('LocId');
  UNSIGNED8 LocId0 := (UNSIGNED8)LocIdstr; 
  K := LocationId_iLink.MatchHistory.MatchHistoryKey;
  rec := RECORD
    SALT37.UIDType LocId_before;
    SALT37.UIDType LocId_after;
    SALT37.UIDType rid;
    UNSIGNED6 change_date;
    UNSIGNED2 Depth; // The depth down the tree, 0 is the top node
  END;
  seed := DATASET([{LocId0,0,0,99999999,0}],rec); // The top of the tree
  rec ftch(DATASET(rec) existing,UNSIGNED2 Iteration) := FUNCTION
    nodes := DEDUP(existing,LocId_before,ALL);
    nxtlvl := JOIN(nodes,K,LEFT.LocId_before=RIGHT.LocId_after,TRANSFORM(rec,SELF.Depth := Iteration, SELF := RIGHT),LIMIT(LocationId_iLink.Config.JoinLimit));
    RETURN existing+nxtlvl;
  END;
  tree := LOOP(seed,LEFT.Depth=COUNTER-1,ftch(ROWS(LEFT),COUNTER));
  OUTPUT( tree,NAMED('History'));
ENDMACRO;
 
