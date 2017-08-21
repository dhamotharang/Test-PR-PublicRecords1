/*--SOAP--
<message name="POWIDHistoryService">
<part name="POWID" type="xsd:string"/>
</message>
*/
/*--INFO-- Find the history of a given POWID. Enter the current ID and it will walk backwards and find what went into it*/
EXPORT POWIDHistoryService := MACRO
  IMPORT SALT35,BIPV2_POWID_Down,ut;
  STRING50 POWIDstr := ''  : STORED('POWID');
  UNSIGNED8 POWID0 := (UNSIGNED8)POWIDstr; 
  K := BIPV2_POWID_Down.MatchHistory.MatchHistoryKey;
  rec := RECORD
    SALT35.UIDType POWID_before;
    SALT35.UIDType POWID_after;
    SALT35.UIDType rcid;
    UNSIGNED4 change_date;
    UNSIGNED2 Depth; // The depth down the tree, 0 is the top node
  END;
  seed := DATASET([{POWID0,0,0,99999999,0}],rec); // The top of the tree
  rec ftch(DATASET(rec) existing,UNSIGNED2 Iteration) := FUNCTION
    nodes := DEDUP(existing,POWID_before,ALL);
    nxtlvl := JOIN(nodes,K,LEFT.POWID_before=RIGHT.POWID_after,TRANSFORM(rec,SELF.Depth := Iteration, SELF := RIGHT),LIMIT(BIPV2_POWID_Down.Config.JoinLimit));
    RETURN existing+nxtlvl;
  END;
  tree := LOOP(seed,LEFT.Depth=COUNTER-1,ftch(ROWS(LEFT),COUNTER));
  OUTPUT( tree,NAMED('History'));
ENDMACRO;
 
