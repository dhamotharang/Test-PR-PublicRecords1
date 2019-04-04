/*--SOAP--
<message name="didHistoryService">
<part name="did" type="xsd:string"/>
</message>
*/
/*--INFO-- Find the history of a given did. Enter the current ID and it will walk backwards and find what went into it*/
EXPORT didHistoryService := MACRO
  IMPORT SALT311,Watchdog_best;
  STRING50 didstr := ''  : STORED('did');
  UNSIGNED8 did0 := (UNSIGNED8)didstr; 
  K := Watchdog_best.MatchHistory.MatchHistoryKey;
  rec := RECORD
    SALT311.UIDType did_before;
    SALT311.UIDType did_after;
    SALT311.UIDType rid;
    UNSIGNED6 change_date;
    UNSIGNED2 Depth; // The depth down the tree, 0 is the top node
  END;
  seed := DATASET([{did0,0,0,99999999,0}],rec); // The top of the tree
  rec ftch(DATASET(rec) existing,UNSIGNED2 Iteration) := FUNCTION
    nodes := DEDUP(existing,did_before,ALL);
    nxtlvl := JOIN(nodes,K,LEFT.did_before=RIGHT.did_after,TRANSFORM(rec,SELF.Depth := Iteration, SELF := RIGHT),LIMIT(Watchdog_best.Config.JoinLimit));
    RETURN existing+nxtlvl;
  END;
  tree := LOOP(seed,LEFT.Depth=COUNTER-1,ftch(ROWS(LEFT),COUNTER));
  OUTPUT( tree,NAMED('History'));
ENDMACRO;

