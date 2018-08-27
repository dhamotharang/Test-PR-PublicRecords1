/*--SOAP--
<message name="IDfunctions_Service">
  <part name="Search_Input" type="tns:XmlDataSet" cols="200" rows="20" />
</message>
*/
 
EXPORT IDfunctions_Service() := MACRO
  IMPORT BIPV2.IDfunctions AS IDF;
  IMPORT SALT37;
  IMPORT BizLinkFull.Process_Biz_Layouts AS PBL;
  
  dsIn    := DATASET([], IDF.rec_SearchInput) : STORED('Search_Input', FORMAT(SEQUENCE(1)));
  RR2 := IDF.fn_IndexedSearchForXLinkIDs(dsIn).Uid_results_w_acct;
  OUTPUT(dsIn,,NAMED('Input'));  
  
  rec := RECORD
    {SALT37.UIDType uniqueid, INTEGER2 weight, INTEGER2 score} OR RECORDOF(RR2) OR {STRING50 KeysUsed_Desc};
  END;
  
  inrec := RECORD
    DATASET(rec) results;
  END;
  
  inrec Rollem(DATASET(RECORDOF(RR2)) r) := TRANSFORM
    SELF.results := PROJECT(r,TRANSFORM(rec,SELF.score := 0, SELF.KeysUsed_Desc := PBL.KeysUsedToText(LEFT.keysused), SELF:= LEFT));
  END;
  
  RR3 := ROLLUP(GROUP(RR2,uniqueID),GROUP,Rollem(ROWS(LEFT)));
  
  SALT37.MAC_External_AddPcnt(RR3,RECORDOF(inrec.results),results,RECORDOF(inrec),27,RR4);
  
  RR5 := NORMALIZE(RR4,LEFT.results,TRANSFORM(RECORDOF(LEFT.results),SELF:=RIGHT;));
  
  OUTPUT(RR5,,NAMED('Uid_results_w_acct'));

ENDMACRO;

