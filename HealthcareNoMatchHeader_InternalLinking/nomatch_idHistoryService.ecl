/*--SOAP--
<message name="nomatch_idHistoryService">
<part name="nomatch_id" type="xsd:string"/>
</message>
*/
/*--INFO-- Find the history of a given nomatch_id. Enter the current ID and it will walk backwards and find what went into it*/
EXPORT nomatch_idHistoryService := MACRO
  IMPORT SALT311,HealthcareNoMatchHeader_InternalLinking;
  STRING50 nomatch_idstr := ''  : STORED('nomatch_id');
  UNSIGNED8 nomatch_id0 := (UNSIGNED8)nomatch_idstr; 
  K := HealthcareNoMatchHeader_InternalLinking.MatchHistory.MatchHistoryKey;
  rec := RECORD
    SALT311.UIDType nomatch_id_before;
    SALT311.UIDType nomatch_id_after;
    SALT311.UIDType RID;
    UNSIGNED6 change_date;
    UNSIGNED2 Depth; // The depth down the tree, 0 is the top node
  END;
  seed := DATASET([{nomatch_id0,0,0,99999999,0}],rec); // The top of the tree
  rec ftch(DATASET(rec) existing,UNSIGNED2 Iteration) := FUNCTION
    nodes := DEDUP(existing,nomatch_id_before,ALL);
    nxtlvl := JOIN(nodes,K,LEFT.nomatch_id_before=RIGHT.nomatch_id_after,TRANSFORM(rec,SELF.Depth := Iteration, SELF := RIGHT),LIMIT(HealthcareNoMatchHeader_InternalLinking.Config.JoinLimit));
    RETURN existing+nxtlvl;
  END;
  tree := LOOP(seed,LEFT.Depth=COUNTER-1,ftch(ROWS(LEFT),COUNTER));
  OUTPUT( tree,NAMED('History'));
ENDMACRO;
 
