IMPORT SALT311;
// This module is to the field values what the fields module is to the field itself
// It really exists to answer the question: does a token with these characters logically belong in this field?
// This module should be viewed as experimental
EXPORT Classify(DATASET(layout_Address_Link) h) := MODULE
 
// Most of the data we need for the classification exists in the specificities module - collect and convert
SHARED TotalClusters := Specificities(h).TotalClusters;
  DID_tokens := PROJECT(Specificities(h).DID_values_persisted,TRANSFORM(SALT311.Layout_Classify_Token,SELF.TokenValue := (SALT311.StrType)LEFT.DID; SELF.TokenType := 1; SELF.Spc := LEFT.field_Specificity ));
  zip_tokens := PROJECT(Specificities(h).zip_values_persisted,TRANSFORM(SALT311.Layout_Classify_Token,SELF.TokenValue := (SALT311.StrType)LEFT.zip; SELF.TokenType := 4; SELF.Spc := LEFT.field_Specificity ));
  prim_range_num_tokens := PROJECT(Specificities(h).prim_range_num_values_persisted,TRANSFORM(SALT311.Layout_Classify_Token,SELF.TokenValue := (SALT311.StrType)LEFT.prim_range_num; SELF.TokenType := 5; SELF.Spc := LEFT.field_Specificity ));
  prim_name_num_tokens := PROJECT(Specificities(h).prim_name_num_values_persisted,TRANSFORM(SALT311.Layout_Classify_Token,SELF.TokenValue := (SALT311.StrType)LEFT.prim_name_num; SELF.TokenType := 6; SELF.Spc := LEFT.field_Specificity ));
  prim_range_alpha_tokens := PROJECT(Specificities(h).prim_range_alpha_values_persisted,TRANSFORM(SALT311.Layout_Classify_Token,SELF.TokenValue := (SALT311.StrType)LEFT.prim_range_alpha; SELF.TokenType := 7; SELF.Spc := LEFT.field_Specificity ));
  prim_name_alpha_tokens := PROJECT(Specificities(h).prim_name_alpha_values_persisted,TRANSFORM(SALT311.Layout_Classify_Token,SELF.TokenValue := (SALT311.StrType)LEFT.prim_name_alpha; SELF.TokenType := 8; SELF.Spc := LEFT.field_Specificity ));
  prim_range_fract_tokens := PROJECT(Specificities(h).prim_range_fract_values_persisted,TRANSFORM(SALT311.Layout_Classify_Token,SELF.TokenValue := (SALT311.StrType)LEFT.prim_range_fract; SELF.TokenType := 9; SELF.Spc := LEFT.field_Specificity ));
  sec_range_alpha_tokens := PROJECT(Specificities(h).sec_range_alpha_values_persisted,TRANSFORM(SALT311.Layout_Classify_Token,SELF.TokenValue := (SALT311.StrType)LEFT.sec_range_alpha; SELF.TokenType := 10; SELF.Spc := LEFT.field_Specificity ));
  sec_range_num_tokens := PROJECT(Specificities(h).sec_range_num_values_persisted,TRANSFORM(SALT311.Layout_Classify_Token,SELF.TokenValue := (SALT311.StrType)LEFT.sec_range_num; SELF.TokenType := 11; SELF.Spc := LEFT.field_Specificity ));
  city_tokens := PROJECT(Specificities(h).city_values_persisted,TRANSFORM(SALT311.Layout_Classify_Token,SELF.TokenValue := (SALT311.StrType)LEFT.city; SELF.TokenType := 12; SELF.Spc := LEFT.field_Specificity ));
  st_tokens := PROJECT(Specificities(h).st_values_persisted,TRANSFORM(SALT311.Layout_Classify_Token,SELF.TokenValue := (SALT311.StrType)LEFT.st; SELF.TokenType := 13; SELF.Spc := LEFT.field_Specificity ));
SHARED all_tokens0 := DID_tokens + zip_tokens + prim_range_num_tokens + prim_name_num_tokens + prim_range_alpha_tokens + prim_name_alpha_tokens + prim_range_fract_tokens + sec_range_alpha_tokens + sec_range_num_tokens + city_tokens + st_tokens;
SHARED all_tokens := SALT311.fn_process_multitokens(all_tokens0);
 
EXPORT TokenKeyName := '~'+'key::InsuranceHeader_Address::ADDRESS_GROUP_ID::Token::TokenKey';
 
EXPORT TokenKey := INDEX(all_tokens,{UNSIGNED4 TokenHash := HASH32(TokenValue),TokenType},{all_tokens},TokenKeyName);
 
EXPORT MultiTokenKeyName := '~'+'key::InsuranceHeader_Address::ADDRESS_GROUP_ID::Token::MultiTokenKey';
 
EXPORT MultiTokenKey := INDEX(all_tokens0(SALT311.WordCount(TokenValue)>1),{UNSIGNED4 TokenHash := HASH32(TokenValue),TokenType},{all_tokens0},MultiTokenKeyName);
  addr_tokens := PROJECT(Specificities(h).addr_values_persisted,TRANSFORM(SALT311.Layout_Classify_Concept,SELF.ConceptHash := LEFT.addr; SELF.TokenType := 2; SELF.Spc := LEFT.field_Specificity ));
  locale_tokens := PROJECT(Specificities(h).locale_values_persisted,TRANSFORM(SALT311.Layout_Classify_Concept,SELF.ConceptHash := LEFT.locale; SELF.TokenType := 3; SELF.Spc := LEFT.field_Specificity ));
SHARED all_tokens1 := addr_tokens + locale_tokens;
 
EXPORT ConceptKeyName := '~'+'key::InsuranceHeader_Address::ADDRESS_GROUP_ID::Token::ConceptKey';
 
EXPORT ConceptKey := INDEX(all_tokens1,{ConceptHash,TokenType},{all_tokens1},ConceptKeyName);
// Now compute the patterns of filled in field values for the various concept fields
SHARED s := Specificities(h).specificities;
SHARED ih := Specificities(h).input_file;
SHARED Layout_ConceptTemplate := RECORD
    UNSIGNED2 TokenType;
    UNSIGNED2 FieldNumber1 := 0; // The field number occupying position 1 in this template
    UNSIGNED2 FieldNumber2 := 0; // The field number occupying position 2 in this template
    UNSIGNED2 FieldNumber3 := 0; // The field number occupying position 3 in this template
    UNSIGNED2 FieldNumber4 := 0; // The field number occupying position 4 in this template
    UNSIGNED2 FieldNumber5 := 0; // The field number occupying position 5 in this template
    UNSIGNED2 FieldNumber6 := 0; // The field number occupying position 6 in this template
    UNSIGNED2 FieldNumber7 := 0; // The field number occupying position 7 in this template
    REAL Field_Specificity;
    UNSIGNED Cnt;
  END;
  addr_filled_rec := RECORD
    boolean prim_range_num_filled :=(TYPEOF(ih.prim_range_num))ih.prim_range_num != (TYPEOF(ih.prim_range_num))'';
    boolean prim_range_alpha_filled :=(TYPEOF(ih.prim_range_alpha))ih.prim_range_alpha != (TYPEOF(ih.prim_range_alpha))'';
    boolean prim_range_fract_filled :=(TYPEOF(ih.prim_range_fract))ih.prim_range_fract != (TYPEOF(ih.prim_range_fract))'';
    boolean prim_name_num_filled :=(TYPEOF(ih.prim_name_num))ih.prim_name_num != (TYPEOF(ih.prim_name_num))'';
    boolean prim_name_alpha_filled :=(TYPEOF(ih.prim_name_alpha))ih.prim_name_alpha != (TYPEOF(ih.prim_name_alpha))'';
    boolean sec_range_num_filled :=(TYPEOF(ih.sec_range_num))ih.sec_range_num != (TYPEOF(ih.sec_range_num))'';
    boolean sec_range_alpha_filled :=(TYPEOF(ih.sec_range_alpha))ih.sec_range_alpha != (TYPEOF(ih.sec_range_alpha))'';
  END;
  t := table(ih,addr_filled_rec);
  addr_filled_rec_totals := RECORD
    UNSIGNED2 TokenType := 2;
    t.prim_range_num_filled;
    t.prim_range_alpha_filled;
    t.prim_range_fract_filled;
    t.prim_name_num_filled;
    t.prim_name_alpha_filled;
    t.sec_range_num_filled;
    t.sec_range_alpha_filled;
    UNSIGNED Cnt := COUNT(GROUP);
  END;
  t_tot := table(t,addr_filled_rec_totals,prim_range_num_filled,prim_range_alpha_filled,prim_range_fract_filled,prim_name_num_filled,prim_name_alpha_filled,sec_range_num_filled,sec_range_alpha_filled,few);
  SALT311.MAC_Field_Specificities(t_tot,o_tot);
shared addr_combinations := o_tot;
  Layout_ConceptTemplate Into(addr_combinations le) := TRANSFORM
    SELF.FieldNumber1 := MAP ( le.prim_range_num_filled => 5, le.prim_range_alpha_filled => 7, le.prim_range_fract_filled => 9, le.prim_name_num_filled => 6, le.prim_name_alpha_filled => 8, le.sec_range_num_filled => 11, le.sec_range_alpha_filled => 10,0);
    SELF.FieldNumber2 := MAP ( le.prim_range_alpha_filled AND SELF.FieldNumber1 != 7 => 7, le.prim_range_fract_filled AND SELF.FieldNumber1 != 9 => 9, le.prim_name_num_filled AND SELF.FieldNumber1 != 6 => 6, le.prim_name_alpha_filled AND SELF.FieldNumber1 != 8 => 8, le.sec_range_num_filled AND SELF.FieldNumber1 != 11 => 11, le.sec_range_alpha_filled AND SELF.FieldNumber1 != 10 => 10,0);
    SELF.FieldNumber3 := MAP ( le.prim_range_fract_filled AND SELF.FieldNumber1 != 9 AND SELF.FieldNumber2 != 9 => 9, le.prim_name_num_filled AND SELF.FieldNumber1 != 6 AND SELF.FieldNumber2 != 6 => 6, le.prim_name_alpha_filled AND SELF.FieldNumber1 != 8 AND SELF.FieldNumber2 != 8 => 8, le.sec_range_num_filled AND SELF.FieldNumber1 != 11 AND SELF.FieldNumber2 != 11 => 11, le.sec_range_alpha_filled AND SELF.FieldNumber1 != 10 AND SELF.FieldNumber2 != 10 => 10,0);
    SELF.FieldNumber4 := MAP ( le.prim_name_num_filled AND SELF.FieldNumber1 != 6 AND SELF.FieldNumber2 != 6 AND SELF.FieldNumber3 != 6 => 6, le.prim_name_alpha_filled AND SELF.FieldNumber1 != 8 AND SELF.FieldNumber2 != 8 AND SELF.FieldNumber3 != 8 => 8, le.sec_range_num_filled AND SELF.FieldNumber1 != 11 AND SELF.FieldNumber2 != 11 AND SELF.FieldNumber3 != 11 => 11, le.sec_range_alpha_filled AND SELF.FieldNumber1 != 10 AND SELF.FieldNumber2 != 10 AND SELF.FieldNumber3 != 10 => 10,0);
    SELF.FieldNumber5 := MAP ( le.prim_name_alpha_filled AND SELF.FieldNumber1 != 8 AND SELF.FieldNumber2 != 8 AND SELF.FieldNumber3 != 8 AND SELF.FieldNumber4 != 8 => 8, le.sec_range_num_filled AND SELF.FieldNumber1 != 11 AND SELF.FieldNumber2 != 11 AND SELF.FieldNumber3 != 11 AND SELF.FieldNumber4 != 11 => 11, le.sec_range_alpha_filled AND SELF.FieldNumber1 != 10 AND SELF.FieldNumber2 != 10 AND SELF.FieldNumber3 != 10 AND SELF.FieldNumber4 != 10 => 10,0);
    SELF.FieldNumber6 := MAP ( le.sec_range_num_filled AND SELF.FieldNumber1 != 11 AND SELF.FieldNumber2 != 11 AND SELF.FieldNumber3 != 11 AND SELF.FieldNumber4 != 11 AND SELF.FieldNumber5 != 11 => 11, le.sec_range_alpha_filled AND SELF.FieldNumber1 != 10 AND SELF.FieldNumber2 != 10 AND SELF.FieldNumber3 != 10 AND SELF.FieldNumber4 != 10 AND SELF.FieldNumber5 != 10 => 10,0);
    SELF.FieldNumber7 := MAP ( le.sec_range_alpha_filled AND SELF.FieldNumber1 != 10 AND SELF.FieldNumber2 != 10 AND SELF.FieldNumber3 != 10 AND SELF.FieldNumber4 != 10 AND SELF.FieldNumber5 != 10 AND SELF.FieldNumber6 != 10 => 10,0);
    SELF := le;
  END;
shared addr_templates := project(addr_combinations,Into(LEFT));
  locale_filled_rec := RECORD
    boolean city_filled :=(TYPEOF(ih.city))ih.city != (TYPEOF(ih.city))'';
    boolean st_filled :=(TYPEOF(ih.st))ih.st != (TYPEOF(ih.st))'';
    boolean zip_filled :=(TYPEOF(ih.zip))ih.zip != (TYPEOF(ih.zip))'';
  END;
  t := table(ih,locale_filled_rec);
  locale_filled_rec_totals := RECORD
    UNSIGNED2 TokenType := 3;
    t.city_filled;
    t.st_filled;
    t.zip_filled;
    UNSIGNED Cnt := COUNT(GROUP);
  END;
  t_tot := table(t,locale_filled_rec_totals,city_filled,st_filled,zip_filled,few);
  SALT311.MAC_Field_Specificities(t_tot,o_tot);
shared locale_combinations := o_tot;
  Layout_ConceptTemplate Into(locale_combinations le) := TRANSFORM
    SELF.FieldNumber1 := MAP ( le.city_filled => 12, le.st_filled => 13, le.zip_filled => 4,0);
    SELF.FieldNumber2 := MAP ( le.st_filled AND SELF.FieldNumber1 != 13 => 13, le.zip_filled AND SELF.FieldNumber1 != 4 => 4,0);
    SELF.FieldNumber3 := MAP ( le.zip_filled AND SELF.FieldNumber1 != 4 AND SELF.FieldNumber2 != 4 => 4,0);
    SELF := le;
  END;
shared locale_templates := project(locale_combinations,Into(LEFT));
SHARED all_templates := addr_templates + locale_templates;
 
EXPORT ConceptTemplatesKey := '~'+'key::InsuranceHeader_Address::ADDRESS_GROUP_ID::Token::ConceptTemplatesKey';
 
EXPORT ConceptTemplateKey := INDEX(all_templates,{FieldNumber1,TokenType},{all_templates},ConceptTemplatesKey);
 
EXPORT Build := PARALLEL(BUILDINDEX(TokenKey, OVERWRITE),BUILDINDEX(MultiTokenKey, OVERWRITE),BUILDINDEX(ConceptKey, OVERWRITE),BUILDINDEX(ConceptTemplateKey, OVERWRITE));
 
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
    UNSIGNED2 FieldNumber4;
    UNSIGNED2 FieldNumber5;
    UNSIGNED2 FieldNumber6;
    UNSIGNED2 FieldNumber7;
  SALT311.StrType Txt := '';
  END;
  Layout_Template_Hypothesis NotePossibles(Classified le,ConceptTemplateKey ri) := TRANSFORM
    SELF.Len := IF(ri.FieldNumber1=0,0,1)+IF(ri.FieldNumber2=0,0,1)+IF(ri.FieldNumber3=0,0,1)+IF(ri.FieldNumber4=0,0,1)+IF(ri.FieldNumber5=0,0,1)+IF(ri.FieldNumber6=0,0,1)+IF(ri.FieldNumber7=0,0,1);
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
  J4 := JOIN(J3(~Confirmed),Classified,LEFT.FieldNumber4 = RIGHT.TokenType AND LEFT.Cpos = RIGHT.StartPos,NextStep(LEFT,RIGHT,4));
  J5 := JOIN(J4(~Confirmed),Classified,LEFT.FieldNumber5 = RIGHT.TokenType AND LEFT.Cpos = RIGHT.StartPos,NextStep(LEFT,RIGHT,5));
  J6 := JOIN(J5(~Confirmed),Classified,LEFT.FieldNumber6 = RIGHT.TokenType AND LEFT.Cpos = RIGHT.StartPos,NextStep(LEFT,RIGHT,6));
  J7 := JOIN(J6(~Confirmed),Classified,LEFT.FieldNumber7 = RIGHT.TokenType AND LEFT.Cpos = RIGHT.StartPos,NextStep(LEFT,RIGHT,7));
  AP0 := (J1+J2+J3+J4+J5+J6+J7)(Confirmed);
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
