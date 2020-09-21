IMPORT SALT311;
// This module is to the field values what the fields module is to the field itself
// It really exists to answer the question: does a token with these characters logically belong in this field?
// This module should be viewed as experimental
EXPORT Classify(DATASET(layout_InsuranceHeader) h) := MODULE
 
// Most of the data we need for the classification exists in the specificities module - collect and convert
SHARED TotalClusters := Specificities(h).TotalClusters;
  SNAME_tokens := PROJECT(Specificities(h).SNAME_values_persisted,TRANSFORM(SALT311.Layout_Classify_Token,SELF.TokenValue := (SALT311.StrType)LEFT.SNAME; SELF.TokenType := 1; SELF.Spc := LEFT.field_Specificity ));
  FNAME_tokens := PROJECT(Specificities(h).FNAME_values_persisted,TRANSFORM(SALT311.Layout_Classify_Token,SELF.TokenValue := (SALT311.StrType)LEFT.FNAME; SELF.TokenType := 2; SELF.Spc := LEFT.field_Specificity ));
  MNAME_tokens := PROJECT(Specificities(h).MNAME_values_persisted,TRANSFORM(SALT311.Layout_Classify_Token,SELF.TokenValue := (SALT311.StrType)LEFT.MNAME; SELF.TokenType := 3; SELF.Spc := LEFT.field_Specificity ));
  LNAME_tokens := PROJECT(Specificities(h).LNAME_values_persisted,TRANSFORM(SALT311.Layout_Classify_Token,SELF.TokenValue := (SALT311.StrType)LEFT.LNAME; SELF.TokenType := 4; SELF.Spc := LEFT.field_Specificity ));
  DERIVED_GENDER_tokens := PROJECT(Specificities(h).DERIVED_GENDER_values_persisted,TRANSFORM(SALT311.Layout_Classify_Token,SELF.TokenValue := (SALT311.StrType)LEFT.DERIVED_GENDER; SELF.TokenType := 5; SELF.Spc := LEFT.field_Specificity ));
  PRIM_RANGE_tokens := PROJECT(Specificities(h).PRIM_RANGE_values_persisted,TRANSFORM(SALT311.Layout_Classify_Token,SELF.TokenValue := (SALT311.StrType)LEFT.PRIM_RANGE; SELF.TokenType := 6; SELF.Spc := LEFT.field_Specificity ));
  PRIM_NAME_tokens := PROJECT(Specificities(h).PRIM_NAME_values_persisted,TRANSFORM(SALT311.Layout_Classify_Token,SELF.TokenValue := (SALT311.StrType)LEFT.PRIM_NAME; SELF.TokenType := 7; SELF.Spc := LEFT.field_Specificity ));
  SEC_RANGE_tokens := PROJECT(Specificities(h).SEC_RANGE_values_persisted,TRANSFORM(SALT311.Layout_Classify_Token,SELF.TokenValue := (SALT311.StrType)LEFT.SEC_RANGE; SELF.TokenType := 8; SELF.Spc := LEFT.field_Specificity ));
  CITY_tokens := PROJECT(Specificities(h).CITY_values_persisted,TRANSFORM(SALT311.Layout_Classify_Token,SELF.TokenValue := (SALT311.StrType)LEFT.CITY; SELF.TokenType := 9; SELF.Spc := LEFT.field_Specificity ));
  ST_tokens := PROJECT(Specificities(h).ST_values_persisted,TRANSFORM(SALT311.Layout_Classify_Token,SELF.TokenValue := (SALT311.StrType)LEFT.ST; SELF.TokenType := 10; SELF.Spc := LEFT.field_Specificity ));
  ZIP_tokens := PROJECT(Specificities(h).ZIP_values_persisted,TRANSFORM(SALT311.Layout_Classify_Token,SELF.TokenValue := (SALT311.StrType)LEFT.ZIP; SELF.TokenType := 11; SELF.Spc := LEFT.field_Specificity ));
  SSN5_tokens := PROJECT(Specificities(h).SSN5_values_persisted,TRANSFORM(SALT311.Layout_Classify_Token,SELF.TokenValue := (SALT311.StrType)LEFT.SSN5; SELF.TokenType := 12; SELF.Spc := LEFT.field_Specificity ));
  SSN4_tokens := PROJECT(Specificities(h).SSN4_values_persisted,TRANSFORM(SALT311.Layout_Classify_Token,SELF.TokenValue := (SALT311.StrType)LEFT.SSN4; SELF.TokenType := 13; SELF.Spc := LEFT.field_Specificity ));
  PHONE_tokens := PROJECT(Specificities(h).PHONE_values_persisted,TRANSFORM(SALT311.Layout_Classify_Token,SELF.TokenValue := (SALT311.StrType)LEFT.PHONE; SELF.TokenType := 15; SELF.Spc := LEFT.field_Specificity ));
  DL_STATE_tokens := PROJECT(Specificities(h).DL_STATE_values_persisted,TRANSFORM(SALT311.Layout_Classify_Token,SELF.TokenValue := (SALT311.StrType)LEFT.DL_STATE; SELF.TokenType := 16; SELF.Spc := LEFT.field_Specificity ));
  DL_NBR_tokens := PROJECT(Specificities(h).DL_NBR_values_persisted,TRANSFORM(SALT311.Layout_Classify_Token,SELF.TokenValue := (SALT311.StrType)LEFT.DL_NBR; SELF.TokenType := 17; SELF.Spc := LEFT.field_Specificity ));
  SRC_tokens := PROJECT(Specificities(h).SRC_values_persisted,TRANSFORM(SALT311.Layout_Classify_Token,SELF.TokenValue := (SALT311.StrType)LEFT.SRC; SELF.TokenType := 18; SELF.Spc := LEFT.field_Specificity ));
  SOURCE_RID_tokens := PROJECT(Specificities(h).SOURCE_RID_values_persisted,TRANSFORM(SALT311.Layout_Classify_Token,SELF.TokenValue := (SALT311.StrType)LEFT.SOURCE_RID; SELF.TokenType := 19; SELF.Spc := LEFT.field_Specificity ));
SHARED all_tokens0 := SNAME_tokens + FNAME_tokens + MNAME_tokens + LNAME_tokens + DERIVED_GENDER_tokens + PRIM_RANGE_tokens + PRIM_NAME_tokens + SEC_RANGE_tokens + CITY_tokens + ST_tokens + ZIP_tokens + SSN5_tokens + SSN4_tokens + PHONE_tokens + DL_STATE_tokens + DL_NBR_tokens + SRC_tokens + SOURCE_RID_tokens;
SHARED all_tokens := SALT311.fn_process_multitokens(all_tokens0);
 
EXPORT TokenKeyName := '~'+KeyPrefix+'::'+'key::InsuranceHeader_xLink'+'::'+Config.KeyInfix+'::DID::Token::TokenKey';
 
EXPORT TokenKeyName_sf := '~'+KeyPrefix+'::'+'key::InsuranceHeader_xLink'+'::'+Config.KeySuperfile+'::DID::Token::TokenKey';
 
EXPORT TokenKey := INDEX(all_tokens,{UNSIGNED4 TokenHash := HASH32(TokenValue),TokenType},{all_tokens},TokenKeyName_sf);
 
EXPORT MultiTokenKeyName := '~'+KeyPrefix+'::'+'key::InsuranceHeader_xLink'+'::'+Config.KeyInfix+'::DID::Token::MultiTokenKey';
 
EXPORT MultiTokenKeyName_sf := '~'+KeyPrefix+'::'+'key::InsuranceHeader_xLink'+'::'+Config.KeySuperfile+'::DID::Token::MultiTokenKey';
 
EXPORT MultiTokenKey := INDEX(all_tokens0(SALT311.WordCount(TokenValue)>1),{UNSIGNED4 TokenHash := HASH32(TokenValue),TokenType},{all_tokens0},MultiTokenKeyName_sf);
  MAINNAME_tokens := PROJECT(Specificities(h).MAINNAME_values_persisted,TRANSFORM(SALT311.Layout_Classify_Concept,SELF.ConceptHash := LEFT.MAINNAME; SELF.TokenType := 24; SELF.Spc := LEFT.field_Specificity ));
  FULLNAME_tokens := PROJECT(Specificities(h).FULLNAME_values_persisted,TRANSFORM(SALT311.Layout_Classify_Concept,SELF.ConceptHash := LEFT.FULLNAME; SELF.TokenType := 25; SELF.Spc := LEFT.field_Specificity ));
  ADDR1_tokens := PROJECT(Specificities(h).ADDR1_values_persisted,TRANSFORM(SALT311.Layout_Classify_Concept,SELF.ConceptHash := LEFT.ADDR1; SELF.TokenType := 26; SELF.Spc := LEFT.field_Specificity ));
  LOCALE_tokens := PROJECT(Specificities(h).LOCALE_values_persisted,TRANSFORM(SALT311.Layout_Classify_Concept,SELF.ConceptHash := LEFT.LOCALE; SELF.TokenType := 27; SELF.Spc := LEFT.field_Specificity ));
  ADDRESS_tokens := PROJECT(Specificities(h).ADDRESS_values_persisted,TRANSFORM(SALT311.Layout_Classify_Concept,SELF.ConceptHash := LEFT.ADDRESS; SELF.TokenType := 28; SELF.Spc := LEFT.field_Specificity ));
SHARED all_tokens1 := MAINNAME_tokens + FULLNAME_tokens + ADDR1_tokens + LOCALE_tokens + ADDRESS_tokens;
 
EXPORT ConceptKeyName := '~'+KeyPrefix+'::'+'key::InsuranceHeader_xLink'+'::'+Config.KeyInfix+'::DID::Token::ConceptKey';
 
EXPORT ConceptKeyName_sf := '~'+KeyPrefix+'::'+'key::InsuranceHeader_xLink'+'::'+Config.KeySuperfile+'::DID::Token::ConceptKey';
 
EXPORT ConceptKey := INDEX(all_tokens1,{ConceptHash,TokenType},{all_tokens1},ConceptKeyName_sf);
// Now compute the patterns of filled in field values for the various concept fields
SHARED s := Specificities(h).specificities;
SHARED ih := Specificities(h).input_file;
SHARED Layout_ConceptTemplate := RECORD
    UNSIGNED2 TokenType;
    UNSIGNED2 FieldNumber1 := 0; // The field number occupying position 1 in this template
    UNSIGNED2 FieldNumber2 := 0; // The field number occupying position 2 in this template
    UNSIGNED2 FieldNumber3 := 0; // The field number occupying position 3 in this template
    REAL Field_Specificity;
    UNSIGNED Cnt;
  END;
  MAINNAME_filled_rec := RECORD
    boolean FNAME_filled :=(TYPEOF(ih.FNAME))ih.FNAME != (TYPEOF(ih.FNAME))'';
    boolean MNAME_filled :=(TYPEOF(ih.MNAME))ih.MNAME != (TYPEOF(ih.MNAME))'';
    boolean LNAME_filled :=(TYPEOF(ih.LNAME))ih.LNAME != (TYPEOF(ih.LNAME))'';
  END;
  t := table(ih,MAINNAME_filled_rec);
  MAINNAME_filled_rec_totals := RECORD
    UNSIGNED2 TokenType := 24;
    t.FNAME_filled;
    t.MNAME_filled;
    t.LNAME_filled;
    UNSIGNED Cnt := COUNT(GROUP);
  END;
  t_tot := table(t,MAINNAME_filled_rec_totals,FNAME_filled,MNAME_filled,LNAME_filled,few);
  SALT311.MAC_Field_Specificities(t_tot,o_tot);
shared MAINNAME_combinations := o_tot;
  Layout_ConceptTemplate Into(MAINNAME_combinations le) := TRANSFORM
    SELF.FieldNumber1 := MAP ( le.FNAME_filled => 2, le.MNAME_filled => 3, le.LNAME_filled => 4,0);
    SELF.FieldNumber2 := MAP ( le.MNAME_filled AND SELF.FieldNumber1 != 3 => 3, le.LNAME_filled AND SELF.FieldNumber1 != 4 => 4,0);
    SELF.FieldNumber3 := MAP ( le.LNAME_filled AND SELF.FieldNumber1 != 4 AND SELF.FieldNumber2 != 4 => 4,0);
    SELF := le;
  END;
shared MAINNAME_templates := project(MAINNAME_combinations,Into(LEFT));
  FULLNAME_filled_rec := RECORD
    boolean MAINNAME_filled :=~((TYPEOF(ih.FNAME))ih.FNAME = (TYPEOF(ih.FNAME))'' AND (TYPEOF(ih.MNAME))ih.MNAME = (TYPEOF(ih.MNAME))'' AND (TYPEOF(ih.LNAME))ih.LNAME = (TYPEOF(ih.LNAME))'');
    boolean SNAME_filled :=(TYPEOF(ih.SNAME))ih.SNAME != (TYPEOF(ih.SNAME))'';
  END;
  t := table(ih,FULLNAME_filled_rec);
  FULLNAME_filled_rec_totals := RECORD
    UNSIGNED2 TokenType := 25;
    t.MAINNAME_filled;
    t.SNAME_filled;
    UNSIGNED Cnt := COUNT(GROUP);
  END;
  t_tot := table(t,FULLNAME_filled_rec_totals,MAINNAME_filled,SNAME_filled,few);
  SALT311.MAC_Field_Specificities(t_tot,o_tot);
shared FULLNAME_combinations := o_tot;
  Layout_ConceptTemplate Into(FULLNAME_combinations le) := TRANSFORM
    SELF.FieldNumber1 := MAP ( le.MAINNAME_filled => 24, le.SNAME_filled => 1,0);
    SELF.FieldNumber2 := MAP ( le.SNAME_filled AND SELF.FieldNumber1 != 1 => 1,0);
    SELF := le;
  END;
shared FULLNAME_templates := project(FULLNAME_combinations,Into(LEFT));
  ADDR1_filled_rec := RECORD
    boolean PRIM_RANGE_filled :=(TYPEOF(ih.PRIM_RANGE))ih.PRIM_RANGE != (TYPEOF(ih.PRIM_RANGE))'';
    boolean SEC_RANGE_filled :=(TYPEOF(ih.SEC_RANGE))ih.SEC_RANGE != (TYPEOF(ih.SEC_RANGE))'';
    boolean PRIM_NAME_filled :=(TYPEOF(ih.PRIM_NAME))ih.PRIM_NAME != (TYPEOF(ih.PRIM_NAME))'';
  END;
  t := table(ih,ADDR1_filled_rec);
  ADDR1_filled_rec_totals := RECORD
    UNSIGNED2 TokenType := 26;
    t.PRIM_RANGE_filled;
    t.SEC_RANGE_filled;
    t.PRIM_NAME_filled;
    UNSIGNED Cnt := COUNT(GROUP);
  END;
  t_tot := table(t,ADDR1_filled_rec_totals,PRIM_RANGE_filled,SEC_RANGE_filled,PRIM_NAME_filled,few);
  SALT311.MAC_Field_Specificities(t_tot,o_tot);
shared ADDR1_combinations := o_tot;
  Layout_ConceptTemplate Into(ADDR1_combinations le) := TRANSFORM
    SELF.FieldNumber1 := MAP ( le.PRIM_RANGE_filled => 6, le.SEC_RANGE_filled => 8, le.PRIM_NAME_filled => 7,0);
    SELF.FieldNumber2 := MAP ( le.SEC_RANGE_filled AND SELF.FieldNumber1 != 8 => 8, le.PRIM_NAME_filled AND SELF.FieldNumber1 != 7 => 7,0);
    SELF.FieldNumber3 := MAP ( le.PRIM_NAME_filled AND SELF.FieldNumber1 != 7 AND SELF.FieldNumber2 != 7 => 7,0);
    SELF := le;
  END;
shared ADDR1_templates := project(ADDR1_combinations,Into(LEFT));
  LOCALE_filled_rec := RECORD
    boolean CITY_filled :=(TYPEOF(ih.CITY))ih.CITY != (TYPEOF(ih.CITY))'';
    boolean ST_filled :=(TYPEOF(ih.ST))ih.ST != (TYPEOF(ih.ST))'';
    boolean ZIP_filled :=(TYPEOF(ih.ZIP))ih.ZIP != (TYPEOF(ih.ZIP))'';
  END;
  t := table(ih,LOCALE_filled_rec);
  LOCALE_filled_rec_totals := RECORD
    UNSIGNED2 TokenType := 27;
    t.CITY_filled;
    t.ST_filled;
    t.ZIP_filled;
    UNSIGNED Cnt := COUNT(GROUP);
  END;
  t_tot := table(t,LOCALE_filled_rec_totals,CITY_filled,ST_filled,ZIP_filled,few);
  SALT311.MAC_Field_Specificities(t_tot,o_tot);
shared LOCALE_combinations := o_tot;
  Layout_ConceptTemplate Into(LOCALE_combinations le) := TRANSFORM
    SELF.FieldNumber1 := MAP ( le.CITY_filled => 9, le.ST_filled => 10, le.ZIP_filled => 11,0);
    SELF.FieldNumber2 := MAP ( le.ST_filled AND SELF.FieldNumber1 != 10 => 10, le.ZIP_filled AND SELF.FieldNumber1 != 11 => 11,0);
    SELF.FieldNumber3 := MAP ( le.ZIP_filled AND SELF.FieldNumber1 != 11 AND SELF.FieldNumber2 != 11 => 11,0);
    SELF := le;
  END;
shared LOCALE_templates := project(LOCALE_combinations,Into(LEFT));
  ADDRESS_filled_rec := RECORD
    boolean ADDR1_filled :=~((TYPEOF(ih.PRIM_RANGE))ih.PRIM_RANGE = (TYPEOF(ih.PRIM_RANGE))'' AND (TYPEOF(ih.SEC_RANGE))ih.SEC_RANGE = (TYPEOF(ih.SEC_RANGE))'' AND (TYPEOF(ih.PRIM_NAME))ih.PRIM_NAME = (TYPEOF(ih.PRIM_NAME))'');
    boolean LOCALE_filled :=~((TYPEOF(ih.CITY))ih.CITY = (TYPEOF(ih.CITY))'' AND (TYPEOF(ih.ST))ih.ST = (TYPEOF(ih.ST))'' AND (TYPEOF(ih.ZIP))ih.ZIP = (TYPEOF(ih.ZIP))'');
  END;
  t := table(ih,ADDRESS_filled_rec);
  ADDRESS_filled_rec_totals := RECORD
    UNSIGNED2 TokenType := 28;
    t.ADDR1_filled;
    t.LOCALE_filled;
    UNSIGNED Cnt := COUNT(GROUP);
  END;
  t_tot := table(t,ADDRESS_filled_rec_totals,ADDR1_filled,LOCALE_filled,few);
  SALT311.MAC_Field_Specificities(t_tot,o_tot);
shared ADDRESS_combinations := o_tot;
  Layout_ConceptTemplate Into(ADDRESS_combinations le) := TRANSFORM
    SELF.FieldNumber1 := MAP ( le.ADDR1_filled => 26, le.LOCALE_filled => 27,0);
    SELF.FieldNumber2 := MAP ( le.LOCALE_filled AND SELF.FieldNumber1 != 27 => 27,0);
    SELF := le;
  END;
shared ADDRESS_templates := project(ADDRESS_combinations,Into(LEFT));
SHARED all_templates := MAINNAME_templates + FULLNAME_templates + ADDR1_templates + LOCALE_templates + ADDRESS_templates;
 
EXPORT ConceptTemplatesKey := '~'+KeyPrefix+'::'+'key::InsuranceHeader_xLink'+'::'+Config.KeyInfix+'::DID::Token::ConceptTemplatesKey';
 
EXPORT ConceptTemplatesKey_sf := '~'+KeyPrefix+'::'+'key::InsuranceHeader_xLink'+'::'+Config.KeySuperfile+'::DID::Token::ConceptTemplatesKey';
 
EXPORT ConceptTemplateKey := INDEX(all_templates,{FieldNumber1,TokenType},{all_templates},ConceptTemplatesKey_sf);
 
EXPORT Build := PARALLEL(BUILDINDEX(TokenKey, TokenKeyName, OVERWRITE),BUILDINDEX(MultiTokenKey, MultiTokenKeyName, OVERWRITE),BUILDINDEX(ConceptKey, ConceptKeyName, OVERWRITE),BUILDINDEX(ConceptTemplateKey, ConceptTemplatesKey, OVERWRITE));
 
SHARED TokenClassify_Raw(SALT311.StrType s,SET OF UNSIGNED2 Poss=[]) := PROJECT( TokenKey(TokenHash=HASH32(s),TokenValue = s,Poss=[] OR TokenType IN Poss),TRANSFORM(SALT311.Layout_Classify_Token,SELF := LEFT) );
SHARED MultiTokenClassify_Raw(SALT311.StrType s) := PROJECT( MultiTokenKey(TokenHash=HASH32(s),TokenValue = s),TRANSFORM(SALT311.Layout_Classify_Token,SELF := LEFT) );
 
EXPORT TokenClassify(SALT311.StrType s) := SORT(TokenClassify_Raw(s),spc);
 
EXPORT FieldClassify(SALT311.StrType s,SET OF UNSIGNED2 Poss=[]) := FUNCTION
  NWords := SALT311.WordCount(s);
  AsData := DATASET([{s}],{SALT311.StrType s1;});
  SALT311.Layout_Classify_Working_Hypothesis FindParts(AsData le,UNSIGNED4 Posit) := TRANSFORM
    SELF.Cpos := Posit;
    SELF.Possibles := TokenClassify_Raw(SALT311.GetNthWord(le.s1,Posit),Poss)(TokenCount = NWords,Pos = Posit);
  END;
  RETURN SALT311.fn_combine_working_hypothesis( NORMALIZE(AsData,NWords,FindParts(LEFT,COUNTER)) );
END;
// Provide classification information for entire parse stream - ASAP
EXPORT ParseClassify(DATASET(SALT311.Layout_Parse_Raw) p) := FUNCTION
  sp := SALT311.fn_split_parsed(p); // Processing module for this parse stream
  cl := JOIN(sp.Words,TokenKey,HASH32(LEFT.tstring)=RIGHT.TokenHash AND LEFT.tstring=RIGHT.TokenValue,TRANSFORM(SALT311.layout_classify_token,SELF := RIGHT));
  rl := sp.Combine(cl); // Multi-tokens will now be together
  rl0 := rl(TokenCount=1);
  rl1 := rl(TokenCount>1);
  rl2 := JOIN(rl1,MultiTokenKey,RIGHT.TokenHash=HASH32(LEFT.TokenValue) AND RIGHT.TokenValue=LEFT.TokenValue AND LEFT.TokenType = RIGHT.TokenType,TRANSFORM(sp.r,SELF.Verified := LEFT.TokenValue=RIGHT.TokenValue,SELF := LEFT),LEFT OUTER);
  RETURN sp.JoinBack(rl0+rl2);
END;
 
EXPORT StreamVerify(SALT311.StrType s,DATASET(SALT311.Layout_Classify_Hypothesis) Classified) := FUNCTION
  // MORE - could try to get clever and combine fetches for different types of same multi-token
  SALT311.Layout_Classify_Hypothesis Confirm(Classified le) := TRANSFORM
    SELF.Confirmed := EXISTS ( MultiTokenClassify_Raw(SALT311.GetRangeOfWords(s,le.StartPos,le.Startpos+le.Len-1))(TokenType=le.TokenType));
    SELF := le;
  END;
  R := Classified(len=1) + PROJECT(Classified(len>1),Confirm(LEFT))(Confirmed);
  R0 := SALT311.fn_classify_dedup_hypothesis(R,TRUE);
  RETURN SORT(R,SPC,-Len);
END;
 
EXPORT StreamAnnotateConcepts(SALT311.StrType s,DATASET(SALT311.Layout_Classify_Hypothesis) Classified) := FUNCTION
// Now we need to look for concept-templates in the fields
  Layout_Template_Hypothesis := RECORD(SALT311.Layout_Classify_Hypothesis)
    UNSIGNED CPos; // Could be > StartPos+fieldno because of multi-token chars
    UNSIGNED2 FieldNumber1;
    UNSIGNED2 FieldNumber2;
    UNSIGNED2 FieldNumber3;
  SALT311.StrType Txt := '';
  END;
  Layout_Template_Hypothesis NotePossibles(Classified le,ConceptTemplateKey ri) := TRANSFORM
    SELF.Len := IF(ri.FieldNumber1=0,0,1)+IF(ri.FieldNumber2=0,0,1)+IF(ri.FieldNumber3=0,0,1);
    SELF.Spc := le.spc+ri.Field_Specificity;
    SELF.Confirmed := ri.FieldNumber2 = 0;
    SELF.CPos := le.StartPos+le.Len;
    SELF.Txt := SALT311.GetRangeOfWords(s,le.StartPos,le.StartPos+le.Len-1);
    SELF := ri;
    SELF := le;
  END;
  J1 := JOIN(Classified,ConceptTemplateKey,LEFT.TokenType=RIGHT.FieldNumber1,NotePossibles(LEFT,RIGHT))(Len>=2);
  Layout_Template_Hypothesis NextStep(Layout_Template_Hypothesis le,Classified ri,UNSIGNED1 step) := TRANSFORM
    SELF.Spc := le.spc+ri.spc;
    SELF.CPos := le.Cpos + ri.Len;
    SELF.Txt := le.Txt + SALT311.GetRangeOfWords(s,le.Cpos,le.Cpos+ri.len-1); // No spaces - to allow hashes to collide
    SELF.Confirmed := le.Len = step;
    SELF := le;
  END;
  J2 := JOIN(J1(~Confirmed),Classified,LEFT.FieldNumber2 = RIGHT.TokenType AND LEFT.Cpos = RIGHT.StartPos,NextStep(LEFT,RIGHT,2));
  J3 := JOIN(J2(~Confirmed),Classified,LEFT.FieldNumber3 = RIGHT.TokenType AND LEFT.Cpos = RIGHT.StartPos,NextStep(LEFT,RIGHT,3));
  AP0 := (J1+J2+J3)(Confirmed);
  AP := JOIN(AP0,ConceptKey,HASH32(LEFT.Txt)=RIGHT.ConceptHash AND LEFT.TokenType=RIGHT.TokenType,TRANSFORM(Layout_Template_Hypothesis, SELF.Spc := RIGHT.Spc; SELF := LEFT));
  RETURN PROJECT(AP,TRANSFORM(SALT311.Layout_Classify_Hypothesis,SELF.Len := LEFT.Cpos-LEFT.StartPos; SELF.Spc := LEFT.SPC / SELF.Len; SELF := LEFT));
END;
 
EXPORT StreamClassify(SALT311.StrType s) := FUNCTION
  NWords := SALT311.WordCount(s);
  EmptyStart := dataset([],SALT311.Layout_Classify_Hypothesis);
  AH := LOOP(EmptyStart,NWords,SALT311.fn_next_working_hypothesis( ROWS(LEFT),TokenClassify_Raw(SALT311.GetNthWord(s,COUNTER)),COUNTER,Nwords) );
  DD := StreamVerify(s,AH);
  WC := DD+StreamAnnotateConcepts(s,DD);
  DH := SALT311.fn_classify_dedup_hypothesis(WC,TRUE);
  RETURN SORT(DH,SPC,-Len);
END;
 
EXPORT PrettyStreamClassify(SALT311.StrType s) := SALT311.fn_pretty_hypothesis(s,StreamClassify(s),Fields.FieldName);
END;
