/*--SOAP--
<message name="ProxidHistoryService">
<part name="Proxid" type="xsd:string"/>
</message>
*/
/*--INFO-- Find the history of a given Proxid. Enter the current ID and it will walk backwards and find what went into it*/
EXPORT ProxidHistoryService := MACRO
  IMPORT SALT311,BIPV2_ProxID;
  STRING50 Proxidstr := ''  : STORED('Proxid');
  UNSIGNED8 Proxid0 := (UNSIGNED8)Proxidstr; 
  K := BIPV2_ProxID.MatchHistory.MatchHistoryKey;
  rec := RECORD
    SALT311.UIDType Proxid_before;
    SALT311.UIDType Proxid_after;
    SALT311.UIDType rcid;
    UNSIGNED6 change_date;
    UNSIGNED2 Depth; // The depth down the tree, 0 is the top node
  END;
  seed := DATASET([{Proxid0,0,0,99999999,0}],rec); // The top of the tree
  rec ftch(DATASET(rec) existing,UNSIGNED2 Iteration) := FUNCTION
    nodes := DEDUP(existing,Proxid_before,ALL);
    nxtlvl := JOIN(nodes,K,LEFT.Proxid_before=RIGHT.Proxid_after,TRANSFORM(rec,SELF.Depth := Iteration, SELF := RIGHT),LIMIT(BIPV2_ProxID.Config.JoinLimit));
    RETURN existing+nxtlvl;
  END;
  tree := LOOP(seed,LEFT.Depth=COUNTER-1,ftch(ROWS(LEFT),COUNTER));
  OUTPUT( tree,NAMED('History'));
ENDMACRO;
 
