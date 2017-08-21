/*--SOAP--
<message name="proxidHistoryService">
<part name="proxid" type="xsd:string"/>
</message>
*/
/*--INFO-- Find the history of a given proxid. Enter the current ID and it will walk backwards and find what went into it*/
EXPORT proxidHistoryService := MACRO
  IMPORT SALT33,BizLinkFull_HS,ut;
  STRING50 proxidstr := ''  : STORED('proxid');
  UNSIGNED8 proxid0 := (UNSIGNED8)proxidstr; 
  BFile := BizLinkFull_HS.In_BizHead;
  K := BizLinkFull_HS.Keys(BFile).MatchHistoryKey;
  R := RECORD
    SALT33.UIDType proxid_before;
    SALT33.UIDType proxid_after;
    SALT33.UIDType rcid;
    UNSIGNED4 change_date;
    UNSIGNED2 Depth; // The depth down the tree, 0 is the top node
  END;
  seed := DATASET([{proxid0,0,0,99999999,0}],R); // The top of the tree
  R ftch(DATASET(R) existing,UNSIGNED2 Iteration) := FUNCTION
    nodes := DEDUP(existing,proxid_before,ALL);
    nxtlvl := JOIN(nodes,K,LEFT.proxid_before=RIGHT.proxid_after,TRANSFORM(R,SELF.Depth := Iteration, SELF := RIGHT));
    RETURN existing+nxtlvl;
  END;
  tree := LOOP(seed,LEFT.Depth=COUNTER-1,ftch(ROWS(LEFT),COUNTER));
  OUTPUT( tree,NAMED('History'));
ENDMACRO;
 
