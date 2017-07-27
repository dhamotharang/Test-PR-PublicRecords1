/*--SOAP--
<message name="SeleidHistoryService">
<part name="Seleid" type="xsd:string"/>
</message>
*/
/*--INFO-- Find the history of a given Seleid. Enter the current ID and it will walk backwards and find what went into it*/
EXPORT SeleidHistoryService := MACRO
  IMPORT SALT30,BIPV2_Best_Seleid,ut;
  STRING50 Seleidstr := ''  : STORED('Seleid');
  UNSIGNED8 Seleid0 := (UNSIGNED8)Seleidstr; 
  BFile := BIPV2_Best_Seleid.In_Base;
  K := BIPV2_Best_Seleid.Keys(BFile).MatchHistoryKey;
  R := RECORD
    SALT30.UIDType Seleid_before;
    SALT30.UIDType Seleid_after;
    SALT30.UIDType rcid;
    UNSIGNED4 change_date;
    UNSIGNED2 Depth; // The depth down the tree, 0 is the top node
  END;
  seed := DATASET([{Seleid0,0,0,99999999,0}],R); // The top of the tree
  R ftch(DATASET(R) existing,UNSIGNED2 Iteration) := FUNCTION
    nodes := DEDUP(existing,Seleid_before,ALL);
    nxtlvl := JOIN(nodes,K,LEFT.Seleid_before=RIGHT.Seleid_after,TRANSFORM(R,SELF.Depth := Iteration, SELF := RIGHT));
    RETURN existing+nxtlvl;
  END;
  tree := LOOP(seed,LEFT.Depth=COUNTER-1,ftch(ROWS(LEFT),COUNTER));
  OUTPUT( tree,NAMED('History'));
ENDMACRO;
