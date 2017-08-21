IMPORT SALT37;
// This module is to the field values what the fields module is to the field itself
// It really exists to answer the question: does a token with these characters logically belong in this field?
// This module should be viewed as experimental
EXPORT Classify(DATASET(layout_Classify_PS) h) := MODULE
 
// Most of the data we need for the classification exists in the specificities module - collect and convert
SHARED TotalClusters := specificities(h).TotalClusters;
  NAME_SUFFIX_tokens := PROJECT(specificities(h).NAME_SUFFIX_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.NAME_SUFFIX; SELF.TokenType := 1; SELF.Spc := LEFT.field_Specificity ));
  FNAME_tokens := PROJECT(specificities(h).FNAME_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.FNAME; SELF.TokenType := 2; SELF.Spc := LEFT.field_Specificity ));
  MNAME_tokens := PROJECT(specificities(h).MNAME_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.MNAME; SELF.TokenType := 3; SELF.Spc := LEFT.field_Specificity ));
  LNAME_tokens := PROJECT(specificities(h).LNAME_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.LNAME; SELF.TokenType := 4; SELF.Spc := LEFT.field_Specificity ));
  PRIM_RANGE_tokens := PROJECT(specificities(h).PRIM_RANGE_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.PRIM_RANGE; SELF.TokenType := 5; SELF.Spc := LEFT.field_Specificity ));
  PRIM_NAME_tokens := PROJECT(specificities(h).PRIM_NAME_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.PRIM_NAME; SELF.TokenType := 6; SELF.Spc := LEFT.field_Specificity ));
  SEC_RANGE_tokens := PROJECT(specificities(h).SEC_RANGE_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.SEC_RANGE; SELF.TokenType := 7; SELF.Spc := LEFT.field_Specificity ));
  P_CITY_NAME_tokens := PROJECT(specificities(h).P_CITY_NAME_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.P_CITY_NAME; SELF.TokenType := 8; SELF.Spc := LEFT.field_Specificity ));
  ST_tokens := PROJECT(specificities(h).ST_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.ST; SELF.TokenType := 9; SELF.Spc := LEFT.field_Specificity ));
  ZIP_tokens := PROJECT(specificities(h).ZIP_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.ZIP; SELF.TokenType := 10; SELF.Spc := LEFT.field_Specificity ));
  PHONE_tokens := PROJECT(specificities(h).PHONE_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.PHONE; SELF.TokenType := 12; SELF.Spc := LEFT.field_Specificity ));
  DL_ST_tokens := PROJECT(specificities(h).DL_ST_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.DL_ST; SELF.TokenType := 13; SELF.Spc := LEFT.field_Specificity ));
  DL_tokens := PROJECT(specificities(h).DL_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.DL; SELF.TokenType := 14; SELF.Spc := LEFT.field_Specificity ));
  LEXID_tokens := PROJECT(specificities(h).LEXID_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.LEXID; SELF.TokenType := 15; SELF.Spc := LEFT.field_Specificity ));
  POSSIBLE_SSN_tokens := PROJECT(specificities(h).POSSIBLE_SSN_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.POSSIBLE_SSN; SELF.TokenType := 16; SELF.Spc := LEFT.field_Specificity ));
  CRIME_tokens := PROJECT(specificities(h).CRIME_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.CRIME; SELF.TokenType := 17; SELF.Spc := LEFT.field_Specificity ));
  NAME_TYPE_tokens := PROJECT(specificities(h).NAME_TYPE_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.NAME_TYPE; SELF.TokenType := 18; SELF.Spc := LEFT.field_Specificity ));
  CLEAN_GENDER_tokens := PROJECT(specificities(h).CLEAN_GENDER_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.CLEAN_GENDER; SELF.TokenType := 19; SELF.Spc := LEFT.field_Specificity ));
  CLASS_CODE_tokens := PROJECT(specificities(h).CLASS_CODE_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.CLASS_CODE; SELF.TokenType := 20; SELF.Spc := LEFT.field_Specificity ));
  DT_FIRST_SEEN_tokens := PROJECT(specificities(h).DT_FIRST_SEEN_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.DT_FIRST_SEEN; SELF.TokenType := 21; SELF.Spc := LEFT.field_Specificity ));
  DT_LAST_SEEN_tokens := PROJECT(specificities(h).DT_LAST_SEEN_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.DT_LAST_SEEN; SELF.TokenType := 22; SELF.Spc := LEFT.field_Specificity ));
  DATA_PROVIDER_ORI_tokens := PROJECT(specificities(h).DATA_PROVIDER_ORI_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.DATA_PROVIDER_ORI; SELF.TokenType := 23; SELF.Spc := LEFT.field_Specificity ));
  VIN_tokens := PROJECT(specificities(h).VIN_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.VIN; SELF.TokenType := 24; SELF.Spc := LEFT.field_Specificity ));
  PLATE_tokens := PROJECT(specificities(h).PLATE_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.PLATE; SELF.TokenType := 25; SELF.Spc := LEFT.field_Specificity ));
  LATITUDE_tokens := PROJECT(specificities(h).LATITUDE_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.LATITUDE; SELF.TokenType := 26; SELF.Spc := LEFT.field_Specificity ));
  LONGITUDE_tokens := PROJECT(specificities(h).LONGITUDE_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.LONGITUDE; SELF.TokenType := 27; SELF.Spc := LEFT.field_Specificity ));
  SEARCH_ADDR1_tokens := PROJECT(specificities(h).SEARCH_ADDR1_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.SEARCH_ADDR1; SELF.TokenType := 28; SELF.Spc := LEFT.field_Specificity ));
  SEARCH_ADDR2_tokens := PROJECT(specificities(h).SEARCH_ADDR2_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.SEARCH_ADDR2; SELF.TokenType := 29; SELF.Spc := LEFT.field_Specificity ));
  CLEAN_COMPANY_NAME_tokens := PROJECT(specificities(h).CLEAN_COMPANY_NAME_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.CLEAN_COMPANY_NAME; SELF.TokenType := 30; SELF.Spc := LEFT.field_Specificity ));
SHARED all_tokens0 := NAME_SUFFIX_tokens + FNAME_tokens + MNAME_tokens + LNAME_tokens + PRIM_RANGE_tokens + PRIM_NAME_tokens + SEC_RANGE_tokens + P_CITY_NAME_tokens + ST_tokens + ZIP_tokens + PHONE_tokens + DL_ST_tokens + DL_tokens + LEXID_tokens + POSSIBLE_SSN_tokens + CRIME_tokens + NAME_TYPE_tokens + CLEAN_GENDER_tokens + CLASS_CODE_tokens + DT_FIRST_SEEN_tokens + DT_LAST_SEEN_tokens + DATA_PROVIDER_ORI_tokens + VIN_tokens + PLATE_tokens + LATITUDE_tokens + LONGITUDE_tokens + SEARCH_ADDR1_tokens + SEARCH_ADDR2_tokens + CLEAN_COMPANY_NAME_tokens;
SHARED all_tokens := SALT37.fn_process_multitokens(all_tokens0);
 
EXPORT TokenKeyName := '~'+KeyPrefix+'::'+'key::Bair_ExternalLinkKeys_V2'+'::'+Config.KeyInfix+'::EID_HASH::Token::TokenKey';
 
EXPORT TokenKeyName_sf := '~'+KeyPrefix+'::'+'key::Bair_ExternalLinkKeys_V2'+'::'+KeySuperfile+'::EID_HASH::Token::TokenKey';
 
EXPORT TokenKey := INDEX(all_tokens,{UNSIGNED4 TokenHash := HASH32(TokenValue),TokenType},{all_tokens},TokenKeyName);
 
EXPORT MultiTokenKeyName := '~'+KeyPrefix+'::'+'key::Bair_ExternalLinkKeys_V2'+'::'+Config.KeyInfix+'::EID_HASH::Token::MultiTokenKey';
 
EXPORT MultiTokenKeyName_sf := '~'+KeyPrefix+'::'+'key::Bair_ExternalLinkKeys_V2'+'::'+KeySuperfile+'::EID_HASH::Token::MultiTokenKey';
 
EXPORT MultiTokenKey := INDEX(all_tokens0(SALT37.WordCount(TokenValue)>1),{UNSIGNED4 TokenHash := HASH32(TokenValue),TokenType},{all_tokens0},MultiTokenKeyName);
  MAINNAME_tokens := PROJECT(specificities(h).MAINNAME_values_persisted,TRANSFORM(SALT37.Layout_Classify_Concept,SELF.ConceptHash := LEFT.MAINNAME; SELF.TokenType := 31; SELF.Spc := LEFT.field_Specificity ));
  FULLNAME_tokens := PROJECT(specificities(h).FULLNAME_values_persisted,TRANSFORM(SALT37.Layout_Classify_Concept,SELF.ConceptHash := LEFT.FULLNAME; SELF.TokenType := 32; SELF.Spc := LEFT.field_Specificity ));
SHARED all_tokens1 := MAINNAME_tokens + FULLNAME_tokens;
 
EXPORT ConceptKeyName := '~'+KeyPrefix+'::'+'key::Bair_ExternalLinkKeys_V2'+'::'+Config.KeyInfix+'::EID_HASH::Token::ConceptKey';
 
EXPORT ConceptKeyName_sf := '~'+KeyPrefix+'::'+'key::Bair_ExternalLinkKeys_V2'+'::'+KeySuperfile+'::EID_HASH::Token::ConceptKey';
 
EXPORT ConceptKey := INDEX(all_tokens1,{ConceptHash,TokenType},{all_tokens1},ConceptKeyName);
// Now compute the patterns of filled in field values for the various concept fields
SHARED s := specificities(h).specificities;
SHARED ih := specificities(h).input_file;
SHARED Layout_ConceptTemplate := RECORD
    UNSIGNED2 TokenType;
    UNSIGNED2 FieldNumber1 := 0; // The field number occupying position 1 in this template
    UNSIGNED2 FieldNumber2 := 0; // The field number occupying position 2 in this template
    UNSIGNED2 FieldNumber3 := 0; // The field number occupying position 3 in this template
    REAL Field_Specificity;
    UNSIGNED Cnt;
  END;
  MAINNAME_filled_rec := RECORD
    boolean FNAME_filled :=(SALT37.StrType)ih.FNAME != '';
    boolean MNAME_filled :=(SALT37.StrType)ih.MNAME != '';
    boolean LNAME_filled :=(SALT37.StrType)ih.LNAME != '';
  END;
  t := table(ih,MAINNAME_filled_rec);
  MAINNAME_filled_rec_totals := RECORD
    UNSIGNED2 TokenType := 31;
    t.FNAME_filled;
    t.MNAME_filled;
    t.LNAME_filled;
    UNSIGNED Cnt := COUNT(GROUP);
  END;
  t_tot := table(t,MAINNAME_filled_rec_totals,FNAME_filled,MNAME_filled,LNAME_filled,few);
  SALT37.MAC_Field_Specificities(t_tot,o_tot);
shared MAINNAME_combinations := o_tot;
  Layout_ConceptTemplate Into(MAINNAME_combinations le) := TRANSFORM
    SELF.FieldNumber1 := MAP ( le.FNAME_filled => 2, le.MNAME_filled => 3, le.LNAME_filled => 4,0);
    SELF.FieldNumber2 := MAP ( le.MNAME_filled AND SELF.FieldNumber1 != 3 => 3, le.LNAME_filled AND SELF.FieldNumber1 != 4 => 4,0);
    SELF.FieldNumber3 := MAP ( le.LNAME_filled AND SELF.FieldNumber1 != 4 AND SELF.FieldNumber2 != 4 => 4,0);
    SELF := le;
  END;
shared MAINNAME_templates := project(MAINNAME_combinations,Into(LEFT));
  FULLNAME_filled_rec := RECORD
    boolean MAINNAME_filled :=~((SALT37.StrType)ih.FNAME = '' AND (SALT37.StrType)ih.MNAME = '' AND (SALT37.StrType)ih.LNAME = '');
    boolean NAME_SUFFIX_filled :=(SALT37.StrType)ih.NAME_SUFFIX != '';
  END;
  t := table(ih,FULLNAME_filled_rec);
  FULLNAME_filled_rec_totals := RECORD
    UNSIGNED2 TokenType := 32;
    t.MAINNAME_filled;
    t.NAME_SUFFIX_filled;
    UNSIGNED Cnt := COUNT(GROUP);
  END;
  t_tot := table(t,FULLNAME_filled_rec_totals,MAINNAME_filled,NAME_SUFFIX_filled,few);
  SALT37.MAC_Field_Specificities(t_tot,o_tot);
shared FULLNAME_combinations := o_tot;
  Layout_ConceptTemplate Into(FULLNAME_combinations le) := TRANSFORM
    SELF.FieldNumber1 := MAP ( le.MAINNAME_filled => 31, le.NAME_SUFFIX_filled => 1,0);
    SELF.FieldNumber2 := MAP ( le.NAME_SUFFIX_filled AND SELF.FieldNumber1 != 1 => 1,0);
    SELF := le;
  END;
shared FULLNAME_templates := project(FULLNAME_combinations,Into(LEFT));
SHARED all_templates := MAINNAME_templates + FULLNAME_templates;
 
EXPORT ConceptTemplatesKey := '~'+KeyPrefix+'::'+'key::Bair_ExternalLinkKeys_V2'+'::'+Config.KeyInfix+'::EID_HASH::Token::ConceptTemplatesKey';
 
EXPORT ConceptTemplatesKey_sf := '~'+KeyPrefix+'::'+'key::Bair_ExternalLinkKeys_V2'+'::'+KeySuperfile+'::EID_HASH::Token::ConceptTemplatesKey';
 
EXPORT ConceptTemplateKey := INDEX(all_templates,{FieldNumber1,TokenType},{all_templates},ConceptTemplatesKey);
 
EXPORT Build := PARALLEL(BUILDINDEX(TokenKey, OVERWRITE),BUILDINDEX(MultiTokenKey, OVERWRITE),BUILDINDEX(ConceptKey, OVERWRITE),BUILDINDEX(ConceptTemplateKey, OVERWRITE));
 
SHARED TokenClassify_Raw(SALT37.StrType s,SET OF UNSIGNED2 Poss=[]) := PROJECT( TokenKey(TokenHash=HASH32(s),TokenValue = s,Poss=[] OR TokenType IN Poss),TRANSFORM(SALT37.Layout_Classify_Token,SELF := LEFT) );
SHARED MultiTokenClassify_Raw(SALT37.StrType s) := PROJECT( MultiTokenKey(TokenHash=HASH32(s),TokenValue = s),TRANSFORM(SALT37.Layout_Classify_Token,SELF := LEFT) );
 
EXPORT TokenClassify(SALT37.StrType s) := SORT(TokenClassify_Raw(s),spc);
 
EXPORT FieldClassify(SALT37.StrType s,SET OF UNSIGNED2 Poss=[]) := FUNCTION
  NWords := SALT37.WordCount(s);
  AsData := DATASET([{s}],{SALT37.StrType s1;});
  SALT37.Layout_Classify_Working_Hypothesis FindParts(AsData le,UNSIGNED4 Posit) := TRANSFORM
    SELF.Cpos := Posit;
    SELF.Possibles := TokenClassify_Raw(SALT37.GetNthWord(le.s1,Posit),Poss)(TokenCount = NWords,Pos = Posit);
  END;
  RETURN SALT37.fn_combine_working_hypothesis( NORMALIZE(AsData,NWords,FindParts(LEFT,COUNTER)) );
END;
// Provide classification information for entire parse stream - ASAP
EXPORT ParseClassify(DATASET(SALT37.Layout_Parse_Raw) p) := FUNCTION
  sp := SALT37.fn_split_parsed(p); // Processing module for this parse stream
  cl := JOIN(sp.Words,TokenKey,HASH32(LEFT.tstring)=RIGHT.TokenHash AND LEFT.tstring=RIGHT.TokenValue,TRANSFORM(SALT37.layout_classify_token,SELF := RIGHT));
  rl := sp.Combine(cl); // Multi-tokens will now be together
  rl0 := rl(TokenCount=1);
  rl1 := rl(TokenCount>1);
  rl2 := JOIN(rl1,MultiTokenKey,RIGHT.TokenHash=HASH32(LEFT.TokenValue) AND RIGHT.TokenValue=LEFT.TokenValue AND LEFT.TokenType = RIGHT.TokenType,TRANSFORM(sp.r,SELF.Verified := LEFT.TokenValue=RIGHT.TokenValue,SELF := LEFT),LEFT OUTER);
  RETURN sp.JoinBack(rl0+rl2);
END;
 
EXPORT StreamVerify(SALT37.StrType s,DATASET(SALT37.Layout_Classify_Hypothesis) Classified) := FUNCTION
  // MORE - could try to get clever and combine fetches for different types of same multi-token
  SALT37.Layout_Classify_Hypothesis Confirm(Classified le) := TRANSFORM
    SELF.Confirmed := EXISTS ( MultiTokenClassify_Raw(SALT37.GetRangeOfWords(s,le.StartPos,le.Startpos+le.Len-1))(TokenType=le.TokenType));
    SELF := le;
  END;
  R := Classified(len=1) + PROJECT(Classified(len>1),Confirm(LEFT))(Confirmed);
  R0 := SALT37.fn_classify_dedup_hypothesis(R,TRUE);
  RETURN SORT(R,SPC,-Len);
END;
 
EXPORT StreamAnnotateConcepts(SALT37.StrType s,DATASET(SALT37.Layout_Classify_Hypothesis) Classified) := FUNCTION
// Now we need to look for concept-templates in the fields
  Layout_Template_Hypothesis := RECORD(SALT37.Layout_Classify_Hypothesis)
    UNSIGNED CPos; // Could be > StartPos+fieldno because of multi-token chars
    UNSIGNED2 FieldNumber1;
    UNSIGNED2 FieldNumber2;
    UNSIGNED2 FieldNumber3;
  SALT37.StrType Txt := '';
  END;
  Layout_Template_Hypothesis NotePossibles(Classified le,ConceptTemplateKey ri) := TRANSFORM
    SELF.Len := IF(ri.FieldNumber1=0,0,1)+IF(ri.FieldNumber2=0,0,1)+IF(ri.FieldNumber3=0,0,1);
    SELF.Spc := le.spc+ri.Field_Specificity;
    SELF.Confirmed := ri.FieldNumber2 = 0;
    SELF.CPos := le.StartPos+le.Len;
    SELF.Txt := SALT37.GetRangeOfWords(s,le.StartPos,le.StartPos+le.Len-1);
    SELF := ri;
    SELF := le;
  END;
  J1 := JOIN(Classified,ConceptTemplateKey,LEFT.TokenType=RIGHT.FieldNumber1,NotePossibles(LEFT,RIGHT))(Len>=2);
  Layout_Template_Hypothesis NextStep(Layout_Template_Hypothesis le,Classified ri,UNSIGNED1 step) := TRANSFORM
    SELF.Spc := le.spc+ri.spc;
    SELF.CPos := le.Cpos + ri.Len;
    SELF.Txt := le.Txt + SALT37.GetRangeOfWords(s,le.Cpos,le.Cpos+ri.len-1); // No spaces - to allow hashes to collide
    SELF.Confirmed := le.Len = step;
    SELF := le;
  END;
  J2 := JOIN(J1(~Confirmed),Classified,LEFT.FieldNumber2 = RIGHT.TokenType AND LEFT.Cpos = RIGHT.StartPos,NextStep(LEFT,RIGHT,2));
  J3 := JOIN(J2(~Confirmed),Classified,LEFT.FieldNumber3 = RIGHT.TokenType AND LEFT.Cpos = RIGHT.StartPos,NextStep(LEFT,RIGHT,3));
  AP0 := (J1+J2+J3)(Confirmed);
  AP := JOIN(AP0,ConceptKey,HASH32(LEFT.Txt)=RIGHT.ConceptHash AND LEFT.TokenType=RIGHT.TokenType,TRANSFORM(Layout_Template_Hypothesis, SELF.Spc := RIGHT.Spc; SELF := LEFT));
  RETURN PROJECT(AP,TRANSFORM(SALT37.Layout_Classify_Hypothesis,SELF.Len := LEFT.Cpos-LEFT.StartPos; SELF.Spc := LEFT.SPC / SELF.Len; SELF := LEFT));
END;
 
EXPORT StreamClassify(SALT37.StrType s) := FUNCTION
  NWords := SALT37.WordCount(s);
  EmptyStart := dataset([],SALT37.Layout_Classify_Hypothesis);
  AH := LOOP(EmptyStart,NWords,SALT37.fn_next_working_hypothesis( ROWS(LEFT),TokenClassify_Raw(SALT37.GetNthWord(s,COUNTER)),COUNTER,Nwords) );
  DD := StreamVerify(s,AH);
  WC := DD+StreamAnnotateConcepts(s,DD);
  DH := SALT37.fn_classify_dedup_hypothesis(WC,TRUE);
  RETURN SORT(DH,SPC,-Len);
END;
 
EXPORT PrettyStreamClassify(SALT37.StrType s) := SALT37.fn_pretty_hypothesis(s,StreamClassify(s),Fields.FieldName);
END;
