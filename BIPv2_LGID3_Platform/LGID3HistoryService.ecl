/*--SOAP--
<message name="LGID3HistoryService">
<part name="LGID3" type="xsd:string"/>
</message>
*/
/*--INFO-- Find the history of a given LGID3. Enter the current ID and it will walk backwards and find what went into it*/
EXPORT LGID3HistoryService := MACRO
  IMPORT SALT30,BIPV2_LGID3_PlatForm,ut;
  STRING50 LGID3str := ''  : STORED('LGID3');
  UNSIGNED8 LGID30 := (UNSIGNED8)LGID3str; 
  BFile := BIPV2_LGID3_PlatForm.In_LGID3;
  K := BIPV2_LGID3_PlatForm.Keys(BFile).MatchHistoryKey;
  R := RECORD
    SALT30.UIDType LGID3_before;
    SALT30.UIDType LGID3_after;
    SALT30.UIDType rcid;
    UNSIGNED4 change_date;
    UNSIGNED2 Depth; // The depth down the tree, 0 is the top node
  END;
  seed := DATASET([{LGID30,0,0,99999999,0}],R); // The top of the tree
  R ftch(DATASET(R) existing,UNSIGNED2 Iteration) := FUNCTION
    nodes := DEDUP(existing,LGID3_before,ALL);
    nxtlvl := JOIN(nodes,K,LEFT.LGID3_before=RIGHT.LGID3_after,TRANSFORM(R,SELF.Depth := Iteration, SELF := RIGHT));
    RETURN existing+nxtlvl;
  END;
  tree := LOOP(seed,LEFT.Depth=COUNTER-1,ftch(ROWS(LEFT),COUNTER));
  OUTPUT( tree,NAMED('History'));
ENDMACRO;
 
