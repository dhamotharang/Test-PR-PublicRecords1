/*--SOAP--
<message name="ADDRESS_GROUP_IDHistoryService">
<part name="ADDRESS_GROUP_ID" type="xsd:string"/>
</message>
*/
/*--INFO-- Find the history of a given ADDRESS_GROUP_ID. Enter the current ID and it will walk backwards and find what went into it*/
EXPORT ADDRESS_GROUP_IDHistoryService := MACRO
  IMPORT SALT311,InsuranceHeader_Address;
  STRING50 ADDRESS_GROUP_IDstr := ''  : STORED('ADDRESS_GROUP_ID');
  UNSIGNED8 ADDRESS_GROUP_ID0 := (UNSIGNED8)ADDRESS_GROUP_IDstr; 
  K := InsuranceHeader_Address.MatchHistory.MatchHistoryKey;
  rec := RECORD
    SALT311.UIDType ADDRESS_GROUP_ID_before;
    SALT311.UIDType ADDRESS_GROUP_ID_after;
    SALT311.UIDType RID;
    UNSIGNED6 change_date;
    UNSIGNED2 Depth; // The depth down the tree, 0 is the top node
  END;
  seed := DATASET([{ADDRESS_GROUP_ID0,0,0,99999999,0}],rec); // The top of the tree
  rec ftch(DATASET(rec) existing,UNSIGNED2 Iteration) := FUNCTION
    nodes := DEDUP(existing,ADDRESS_GROUP_ID_before,ALL);
    nxtlvl := JOIN(nodes,K,LEFT.ADDRESS_GROUP_ID_before=RIGHT.ADDRESS_GROUP_ID_after,TRANSFORM(rec,SELF.Depth := Iteration, SELF := RIGHT),LIMIT(InsuranceHeader_Address.Config.JoinLimit));
    RETURN existing+nxtlvl;
  END;
  tree := LOOP(seed,LEFT.Depth=COUNTER-1,ftch(ROWS(LEFT),COUNTER));
  OUTPUT( tree,NAMED('History'));
ENDMACRO;
 
