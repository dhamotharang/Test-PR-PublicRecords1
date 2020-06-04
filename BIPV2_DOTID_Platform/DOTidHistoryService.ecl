/*--SOAP--
<message name="DOTidHistoryService">
<part name="DOTid" type="xsd:string"/>
</message>
*/
/*--INFO-- Find the history of a given DOTid. Enter the current ID and it will walk backwards and find what went into it*/
EXPORT DOTidHistoryService := MACRO
  IMPORT SALT32,BIPV2_DOTID_PLATFORM,ut;
  STRING50 DOTidstr := ''  : STORED('DOTid');
  UNSIGNED8 DOTid0 := (UNSIGNED8)DOTidstr; 
  BFile := BIPV2_DOTID_PLATFORM.In_DOT;
  K := BIPV2_DOTID_PLATFORM.Keys(BFile).MatchHistoryKey;
  R := RECORD
    SALT32.UIDType DOTid_before;
    SALT32.UIDType DOTid_after;
    SALT32.UIDType rcid;
    UNSIGNED4 change_date;
    UNSIGNED2 Depth; // The depth down the tree, 0 is the top node
  END;
  seed := DATASET([{DOTid0,0,0,99999999,0}],R); // The top of the tree
  R ftch(DATASET(R) existing,UNSIGNED2 Iteration) := FUNCTION
    nodes := DEDUP(existing,DOTid_before,ALL);
    nxtlvl := JOIN(nodes,K,LEFT.DOTid_before=RIGHT.DOTid_after,TRANSFORM(R,SELF.Depth := Iteration, SELF := RIGHT));
    RETURN existing+nxtlvl;
  END;
  tree := LOOP(seed,LEFT.Depth=COUNTER-1,ftch(ROWS(LEFT),COUNTER));
  OUTPUT( tree,NAMED('History'));
ENDMACRO;
 
