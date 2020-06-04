/*--SOAP--
<message name="EmpIDHistoryService">
<part name="EmpID" type="xsd:string"/>
</message>
*/
/*--INFO-- Find the history of a given EmpID. Enter the current ID and it will walk backwards and find what went into it*/
EXPORT EmpIDHistoryService := MACRO
  IMPORT SALT30,BIPV2_EMPID_Platform,ut;
  STRING50 EmpIDstr := ''  : STORED('EmpID');
  UNSIGNED8 EmpID0 := (UNSIGNED8)EmpIDstr; 
  BFile := BIPV2_EMPID_Platform.In_EmpID;
  K := BIPV2_EMPID_Platform.Keys(BFile).MatchHistoryKey;
  R := RECORD
    SALT30.UIDType EmpID_before;
    SALT30.UIDType EmpID_after;
    SALT30.UIDType rcid;
    UNSIGNED4 change_date;
    UNSIGNED2 Depth; // The depth down the tree, 0 is the top node
  END;
  seed := DATASET([{EmpID0,0,0,99999999,0}],R); // The top of the tree
  R ftch(DATASET(R) existing,UNSIGNED2 Iteration) := FUNCTION
    nodes := DEDUP(existing,EmpID_before,ALL);
    nxtlvl := JOIN(nodes,K,LEFT.EmpID_before=RIGHT.EmpID_after,TRANSFORM(R,SELF.Depth := Iteration, SELF := RIGHT));
    RETURN existing+nxtlvl;
  END;
  tree := LOOP(seed,LEFT.Depth=COUNTER-1,ftch(ROWS(LEFT),COUNTER));
  OUTPUT( tree,NAMED('History'));
ENDMACRO;
 
