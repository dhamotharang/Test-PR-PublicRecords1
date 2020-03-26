/*--SOAP--
<message name="ProxidHistoryService">
<part name="Proxid" type="xsd:string"/>
</message>
*/
/*--INFO-- Find the history of a given Proxid. Enter the current ID and it will walk backwards and find what went into it*/
EXPORT ProxidHistoryService := MACRO
  IMPORT SALT30,BIPV2_Best_Proxid,ut;
  STRING50 Proxidstr := ''  : STORED('Proxid');
  UNSIGNED8 Proxid0 := (UNSIGNED8)Proxidstr; 
  BFile := BIPV2_Best_Proxid.In_Base;
  K := BIPV2_Best_Proxid.Keys(BFile).MatchHistoryKey;
  R := RECORD
    SALT30.UIDType Proxid_before;
    SALT30.UIDType Proxid_after;
    SALT30.UIDType rcid;
    UNSIGNED4 change_date;
    UNSIGNED2 Depth; // The depth down the tree, 0 is the top node
  END;
  seed := DATASET([{Proxid0,0,0,99999999,0}],R); // The top of the tree
  R ftch(DATASET(R) existing,UNSIGNED2 Iteration) := FUNCTION
    nodes := DEDUP(existing,Proxid_before,ALL);
    nxtlvl := JOIN(nodes,K,LEFT.Proxid_before=RIGHT.Proxid_after,TRANSFORM(R,SELF.Depth := Iteration, SELF := RIGHT));
    RETURN existing+nxtlvl;
  END;
  tree := LOOP(seed,LEFT.Depth=COUNTER-1,ftch(ROWS(LEFT),COUNTER));
  OUTPUT( tree,NAMED('History'));
ENDMACRO;
 
