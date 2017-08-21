/*--SOAP--
<message name="LNPIDHistoryService">
<part name="LNPID" type="xsd:string"/>
</message>
*/
/*--INFO-- Find the history of a given LNPID. Enter the current ID and it will walk backwards and find what went into it*/
EXPORT LNPIDHistoryService := MACRO
  IMPORT SALT29,HealthCareProviderHeader,ut;
  STRING50 LNPIDstr := ''  : STORED('LNPID');
  UNSIGNED8 LNPID0 := (UNSIGNED8)LNPIDstr; 
  BFile := HealthCareProviderHeader.In_HealthProvider;
  K := HealthCareProviderHeader.Keys(BFile).MatchHistoryKey;
  R := RECORD
    SALT29.UIDType LNPID_before;
    SALT29.UIDType LNPID_after;
    SALT29.UIDType RID;
    UNSIGNED4 change_date;
    UNSIGNED2 Depth; // The depth down the tree, 0 is the top node
  END;
  seed := DATASET([{LNPID0,0,0,99999999,0}],R); // The top of the tree
  R ftch(DATASET(R) existing,UNSIGNED2 Iteration) := FUNCTION
    nodes := DEDUP(existing,LNPID_before,ALL);
    nxtlvl := JOIN(nodes,K,LEFT.LNPID_before=RIGHT.LNPID_after,TRANSFORM(R,SELF.Depth := Iteration, SELF := RIGHT));
    RETURN existing+nxtlvl;
  END;
  tree := LOOP(seed,LEFT.Depth=COUNTER-1,ftch(ROWS(LEFT),COUNTER));
  OUTPUT( tree,NAMED('History'));
ENDMACRO;
