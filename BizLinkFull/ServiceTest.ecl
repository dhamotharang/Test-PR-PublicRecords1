/*--SOAP--
<message name="Biz_Header_Service">
<part name="company_name" type="xsd:string"/>
</message>
*/
EXPORT ServiceTest := MACRO
  IMPORT lib_stringlib;
  STRING Input_company_name := '' : STORED('company_name');

  // Stripped down key containing only the rows we care about for the test
  layout:={unsigned4 gss_hash;  string2 st;  unsigned6 proxid;  string5 zip; string28 prim_name;  string25 p_city_name;  string8 company_sic_code1;  string10 cnp_number;  string10 cnp_btype;  string20 cnp_lowv;  string10 prim_range;  string8 sec_range;  unsigned6 seleid;  unsigned6 orgid;  unsigned6 ultid;  unsigned2 gss_word_weight;  string240 cnp_name;  integer2 zip_weight100;  integer2 prim_name_weight100;  unsigned2 prim_name_e1_weight100;  integer2 p_city_name_weight100;  integer2 p_city_name_e1_weight100;  integer2 st_weight100;  integer2 company_sic_code1_weight100;  integer2 cnp_number_weight100;  integer2 cnp_btype_weight100;  integer2 cnp_lowv_weight100;  integer2 prim_range_weight100;  unsigned2 prim_range_e1_weight100;  integer2 sec_range_weight100;  unsigned2 sec_range_e1_weight100;  integer2 seleid_weight100;  integer2 orgid_weight100;  integer2 ultid_weight100;};
  d:=DATASET('~temp::bug9031::testdata',layout,THOR);
  dRowCounts:=TABLE(d,{gss_hash;UNSIGNED c:=COUNT(GROUP);},gss_hash,MERGE);
  Key:=INDEX(d,,'~temp::bug9031::testkey');
  indexOutputRecord := RECORDOF(Key);

  // Derive the dataset used as input to the graph
  sName:=stringlib.StringToUpperCase(Input_company_name);
  wds:=SORT(NORMALIZE(DATASET([{sName}],{STRING s;}),stringlib.StringWordCount(LEFT.s),TRANSFORM({UNSIGNED4 hsh;UNSIGNED spec;},SELF.hsh:=HASH32(stringlib.StringGetNthWord(LEFT.s,COUNTER));SELF.spec:=dRowCounts(gss_hash=SELF.hsh)[1].c;)),spec);
   
  // The actual GRAPH call and supporting functions
  doJoin(SET OF DATASET(indexOutputRecord) inputs) := FUNCTION
    indexOutputRecord createMatchRecord(indexOutputRecord firstMatch, DATASET(indexOutputRecord) allMatches) := TRANSFORM
        SELF.gss_word_weight := SUM(allmatches,gss_word_weight);
        SELF := firstMatch;
    END;
    RETURN JOIN(inputs, STEPPED(LEFT.proxid = RIGHT.proxid), createMatchRecord(LEFT, ROWS(LEFT)), SORTED(proxid));
  END;
  r := RECORDOF(wds);
  doAction(SET OF DATASET(indexOutputRecord) allInputs, DATASET(r) words, INTEGER stage) := FUNCTION
    numWords := COUNT(words);
    sillyIntegerDs := NORMALIZE(DATASET([0],{INTEGER x}), numWords, TRANSFORM({INTEGER x}, SELF.x := COUNTER));
    sillyIntegerSet := SET(sillyIntegerDs, x);
    wordInputs := RANGE(allInputs, sillyIntegerSet);
    result := IF (stage <= numWords,
      STEPPED(KEY(GSS_hash=words[noboundcheck stage].hsh),proxid,PRIORITY(40-words[noboundcheck stage].spec)),
      doJoin(RANGE(allInputs, sillyIntegerSet)));
    RETURN result;
  END;
  nullInput := DATASET([], indexOutputRecord);
  steppedMatches := GRAPH(nullInput, count(wds)+1, doAction(rowset(LEFT), wds, COUNTER), PARALLEL);   
    
  RawData := steppedmatches;
  OUTPUT(RawData,named('Header_Data'));
endmacro;

