/*--SOAP--
<message name="DPROPTXIDHistoryService">
<part name="DPROPTXID" type="xsd:string"/>
</message>
*/
/*--INFO-- Find the history of a given DPROPTXID. Enter the current ID and it will walk backwards and find what went into it*/
EXPORT DPROPTXIDHistoryService := MACRO
  IMPORT SALT34,InsuranceHeader_Property_Transactions_DeedsMortgages,ut;
  STRING50 DPROPTXIDstr := ''  : STORED('DPROPTXID');
  UNSIGNED8 DPROPTXID0 := (UNSIGNED8)DPROPTXIDstr; 
  K := InsuranceHeader_Property_Transactions_DeedsMortgages.MatchHistory.MatchHistoryKey;
  rec := RECORD
    SALT34.UIDType DPROPTXID_before;
    SALT34.UIDType DPROPTXID_after;
    SALT34.UIDType rid;
    UNSIGNED4 change_date;
    UNSIGNED2 Depth; // The depth down the tree, 0 is the top node
  END;
  seed := DATASET([{DPROPTXID0,0,0,99999999,0}],rec); // The top of the tree
  rec ftch(DATASET(rec) existing,UNSIGNED2 Iteration) := FUNCTION
    nodes := DEDUP(existing,DPROPTXID_before,ALL);
    nxtlvl := JOIN(nodes,K,LEFT.DPROPTXID_before=RIGHT.DPROPTXID_after,TRANSFORM(rec,SELF.Depth := Iteration, SELF := RIGHT),LIMIT(InsuranceHeader_Property_Transactions_DeedsMortgages.Config.JoinLimit));
    RETURN existing+nxtlvl;
  END;
  tree := LOOP(seed,LEFT.Depth=COUNTER-1,ftch(ROWS(LEFT),COUNTER));
  OUTPUT( tree,NAMED('History'));
ENDMACRO;
