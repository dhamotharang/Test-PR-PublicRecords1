/*--SOAP--
<message name="HistoryService">
<part name="" type="xsd:string"/>
</message>
*/
/*--INFO-- Find the history of a given . Enter the current ID and it will walk backwards and find what went into it*/
EXPORT HistoryService := MACRO
  IMPORT SALT34,Scrubs_Corp2_Mapping_GA_Main,ut;
  STRING50 str := ''  : STORED('');
  UNSIGNED8 0 := (UNSIGNED8)str; 
  K := Scrubs_Corp2_Mapping_GA_Main.MatchHistory.MatchHistoryKey;
  rec := RECORD
    SALT34.UIDType _before;
    SALT34.UIDType _after;
    SALT34.UIDType ;
    UNSIGNED4 change_date;
    UNSIGNED2 Depth; // The depth down the tree, 0 is the top node
  END;
  seed := DATASET([{0,0,0,99999999,0}],rec); // The top of the tree
  rec ftch(DATASET(rec) existing,UNSIGNED2 Iteration) := FUNCTION
    nodes := DEDUP(existing,_before,ALL);
    nxtlvl := JOIN(nodes,K,LEFT._before=RIGHT._after,TRANSFORM(rec,SELF.Depth := Iteration, SELF := RIGHT),LIMIT(Scrubs_Corp2_Mapping_GA_Main.Config.JoinLimit));
    RETURN existing+nxtlvl;
  END;
  tree := LOOP(seed,LEFT.Depth=COUNTER-1,ftch(ROWS(LEFT),COUNTER));
  OUTPUT( tree,NAMED('History'));
ENDMACRO;
 
