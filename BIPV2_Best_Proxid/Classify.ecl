IMPORT ut,SALT30;
// This module is to the field values what the fields module is to the field itself
// It really exists to answer the question: does a token with these characters logically belong in this field?
// This module should be viewed as experimental
EXPORT Classify(DATASET(layout_Base) h) := MODULE
// Most of the data we need for the classification exists in the specificities module - collect and convert
SHARED TotalClusters := specificities(h).TotalClusters;
  company_name_tokens := PROJECT(specificities(h).company_name_values_persisted,TRANSFORM(SALT30.Layout_Classify_Token,SELF.TokenValue := (SALT30.StrType)LEFT.company_name; SELF.TokenType := 4; SELF.Spc := LEFT.field_Specificity ));
  company_fein_tokens := PROJECT(specificities(h).company_fein_values_persisted,TRANSFORM(SALT30.Layout_Classify_Token,SELF.TokenValue := (SALT30.StrType)LEFT.company_fein; SELF.TokenType := 5; SELF.Spc := LEFT.field_Specificity ));
  company_phone_tokens := PROJECT(specificities(h).company_phone_values_persisted,TRANSFORM(SALT30.Layout_Classify_Token,SELF.TokenValue := (SALT30.StrType)LEFT.company_phone; SELF.TokenType := 6; SELF.Spc := LEFT.field_Specificity ));
  company_url_tokens := PROJECT(specificities(h).company_url_values_persisted,TRANSFORM(SALT30.Layout_Classify_Token,SELF.TokenValue := (SALT30.StrType)LEFT.company_url; SELF.TokenType := 7; SELF.Spc := LEFT.field_Specificity ));
  duns_number_tokens := PROJECT(specificities(h).duns_number_values_persisted,TRANSFORM(SALT30.Layout_Classify_Token,SELF.TokenValue := (SALT30.StrType)LEFT.duns_number; SELF.TokenType := 8; SELF.Spc := LEFT.field_Specificity ));
  company_sic_code1_tokens := PROJECT(specificities(h).company_sic_code1_values_persisted,TRANSFORM(SALT30.Layout_Classify_Token,SELF.TokenValue := (SALT30.StrType)LEFT.company_sic_code1; SELF.TokenType := 9; SELF.Spc := LEFT.field_Specificity ));
  company_naics_code1_tokens := PROJECT(specificities(h).company_naics_code1_values_persisted,TRANSFORM(SALT30.Layout_Classify_Token,SELF.TokenValue := (SALT30.StrType)LEFT.company_naics_code1; SELF.TokenType := 10; SELF.Spc := LEFT.field_Specificity ));
  prim_range_tokens := PROJECT(specificities(h).prim_range_values_persisted,TRANSFORM(SALT30.Layout_Classify_Token,SELF.TokenValue := (SALT30.StrType)LEFT.prim_range; SELF.TokenType := 11; SELF.Spc := LEFT.field_Specificity ));
  predir_tokens := PROJECT(specificities(h).predir_values_persisted,TRANSFORM(SALT30.Layout_Classify_Token,SELF.TokenValue := (SALT30.StrType)LEFT.predir; SELF.TokenType := 12; SELF.Spc := LEFT.field_Specificity ));
  prim_name_tokens := PROJECT(specificities(h).prim_name_values_persisted,TRANSFORM(SALT30.Layout_Classify_Token,SELF.TokenValue := (SALT30.StrType)LEFT.prim_name; SELF.TokenType := 13; SELF.Spc := LEFT.field_Specificity ));
  addr_suffix_tokens := PROJECT(specificities(h).addr_suffix_values_persisted,TRANSFORM(SALT30.Layout_Classify_Token,SELF.TokenValue := (SALT30.StrType)LEFT.addr_suffix; SELF.TokenType := 14; SELF.Spc := LEFT.field_Specificity ));
  postdir_tokens := PROJECT(specificities(h).postdir_values_persisted,TRANSFORM(SALT30.Layout_Classify_Token,SELF.TokenValue := (SALT30.StrType)LEFT.postdir; SELF.TokenType := 15; SELF.Spc := LEFT.field_Specificity ));
  unit_desig_tokens := PROJECT(specificities(h).unit_desig_values_persisted,TRANSFORM(SALT30.Layout_Classify_Token,SELF.TokenValue := (SALT30.StrType)LEFT.unit_desig; SELF.TokenType := 16; SELF.Spc := LEFT.field_Specificity ));
  sec_range_tokens := PROJECT(specificities(h).sec_range_values_persisted,TRANSFORM(SALT30.Layout_Classify_Token,SELF.TokenValue := (SALT30.StrType)LEFT.sec_range; SELF.TokenType := 17; SELF.Spc := LEFT.field_Specificity ));
  p_city_name_tokens := PROJECT(specificities(h).p_city_name_values_persisted,TRANSFORM(SALT30.Layout_Classify_Token,SELF.TokenValue := (SALT30.StrType)LEFT.p_city_name; SELF.TokenType := 18; SELF.Spc := LEFT.field_Specificity ));
  v_city_name_tokens := PROJECT(specificities(h).v_city_name_values_persisted,TRANSFORM(SALT30.Layout_Classify_Token,SELF.TokenValue := (SALT30.StrType)LEFT.v_city_name; SELF.TokenType := 19; SELF.Spc := LEFT.field_Specificity ));
  st_tokens := PROJECT(specificities(h).st_values_persisted,TRANSFORM(SALT30.Layout_Classify_Token,SELF.TokenValue := (SALT30.StrType)LEFT.st; SELF.TokenType := 20; SELF.Spc := LEFT.field_Specificity ));
  zip_tokens := PROJECT(specificities(h).zip_values_persisted,TRANSFORM(SALT30.Layout_Classify_Token,SELF.TokenValue := (SALT30.StrType)LEFT.zip; SELF.TokenType := 21; SELF.Spc := LEFT.field_Specificity ));
  zip4_tokens := PROJECT(specificities(h).zip4_values_persisted,TRANSFORM(SALT30.Layout_Classify_Token,SELF.TokenValue := (SALT30.StrType)LEFT.zip4; SELF.TokenType := 22; SELF.Spc := LEFT.field_Specificity ));
  fips_state_tokens := PROJECT(specificities(h).fips_state_values_persisted,TRANSFORM(SALT30.Layout_Classify_Token,SELF.TokenValue := (SALT30.StrType)LEFT.fips_state; SELF.TokenType := 23; SELF.Spc := LEFT.field_Specificity ));
  fips_county_tokens := PROJECT(specificities(h).fips_county_values_persisted,TRANSFORM(SALT30.Layout_Classify_Token,SELF.TokenValue := (SALT30.StrType)LEFT.fips_county; SELF.TokenType := 24; SELF.Spc := LEFT.field_Specificity ));
SHARED all_tokens0 := company_name_tokens + company_fein_tokens + company_phone_tokens + company_url_tokens + duns_number_tokens + company_sic_code1_tokens + company_naics_code1_tokens + prim_range_tokens + predir_tokens + prim_name_tokens + addr_suffix_tokens + postdir_tokens + unit_desig_tokens + sec_range_tokens + p_city_name_tokens + v_city_name_tokens + st_tokens + zip_tokens + zip4_tokens + fips_state_tokens + fips_county_tokens;
  all_tokens := SALT30.fn_process_multitokens(all_tokens0);
EXPORT TokenKeyName := '~'+'key::BIPV2_Best_Proxid::Proxid::Token::TokenKey';
EXPORT TokenKey := INDEX(all_tokens,{UNSIGNED4 TokenHash := HASH32(TokenValue),TokenType},{all_tokens},TokenKeyName);
EXPORT MultiTokenKeyName := '~'+'key::BIPV2_Best_Proxid::Proxid::Token::MultiTokenKey';
EXPORT MultiTokenKey := INDEX(all_tokens0(SALT30.WordCount(TokenValue)>1),{UNSIGNED4 TokenHash := HASH32(TokenValue),TokenType},{all_tokens0},MultiTokenKeyName);
  address_tokens := PROJECT(specificities(h).address_values_persisted,TRANSFORM(SALT30.Layout_Classify_Concept,SELF.ConceptHash := LEFT.address; SELF.TokenType := 25; SELF.Spc := LEFT.field_Specificity ));
all_tokens1 := address_tokens;
EXPORT ConceptKeyName := '~'+'key::BIPV2_Best_Proxid::Proxid::Token::ConceptKey';
EXPORT ConceptKey := INDEX(all_tokens1,{ConceptHash,TokenType},{all_tokens1},ConceptKeyName);
// Now compute the patterns of filled in field values for the various concept fields
SHARED s := specificities(h).specificities;
SHARED ih := specificities(h).input_file;
SHARED Layout_ConceptTemplate := RECORD
    UNSIGNED2 TokenType;
    UNSIGNED2 FieldNumber1 := 0; // The field number occupying position 1 in this template
    UNSIGNED2 FieldNumber2 := 0; // The field number occupying position 2 in this template
    UNSIGNED2 FieldNumber3 := 0; // The field number occupying position 3 in this template
    UNSIGNED2 FieldNumber4 := 0; // The field number occupying position 4 in this template
    UNSIGNED2 FieldNumber5 := 0; // The field number occupying position 5 in this template
    UNSIGNED2 FieldNumber6 := 0; // The field number occupying position 6 in this template
    UNSIGNED2 FieldNumber7 := 0; // The field number occupying position 7 in this template
    UNSIGNED2 FieldNumber8 := 0; // The field number occupying position 8 in this template
    UNSIGNED2 FieldNumber9 := 0; // The field number occupying position 9 in this template
    REAL Field_Specificity;
    UNSIGNED Cnt;
  END;
  address_filled_rec := RECORD
    boolean prim_range_filled :=(SALT30.StrType)ih.prim_range != '';
    boolean predir_filled :=(SALT30.StrType)ih.predir != '';
    boolean prim_name_filled :=(SALT30.StrType)ih.prim_name != '';
    boolean addr_suffix_filled :=(SALT30.StrType)ih.addr_suffix != '';
    boolean postdir_filled :=(SALT30.StrType)ih.postdir != '';
    boolean unit_desig_filled :=(SALT30.StrType)ih.unit_desig != '';
    boolean sec_range_filled :=(SALT30.StrType)ih.sec_range != '';
    boolean st_filled :=(SALT30.StrType)ih.st != '';
    boolean zip_filled :=(SALT30.StrType)ih.zip != '';
  END;
  t := table(ih,address_filled_rec);
  address_filled_rec_totals := RECORD
    UNSIGNED2 TokenType := 25;
    t.prim_range_filled;
    t.predir_filled;
    t.prim_name_filled;
    t.addr_suffix_filled;
    t.postdir_filled;
    t.unit_desig_filled;
    t.sec_range_filled;
    t.st_filled;
    t.zip_filled;
    UNSIGNED Cnt := COUNT(GROUP);
  END;
  t_tot := table(t,address_filled_rec_totals,prim_range_filled,predir_filled,prim_name_filled,addr_suffix_filled,postdir_filled,unit_desig_filled,sec_range_filled,st_filled,zip_filled,few);
  SALT30.MAC_Field_Specificities(t_tot,o_tot);
shared address_combinations := o_tot;
  Layout_ConceptTemplate Into(address_combinations le) := TRANSFORM
    SELF.FieldNumber1 := MAP ( le.prim_range_filled => 11, le.predir_filled => 12, le.prim_name_filled => 13, le.addr_suffix_filled => 14, le.postdir_filled => 15, le.unit_desig_filled => 16, le.sec_range_filled => 17, le.st_filled => 20, le.zip_filled => 21,0);
    SELF.FieldNumber2 := MAP ( le.predir_filled AND SELF.FieldNumber1 != 12 => 12, le.prim_name_filled AND SELF.FieldNumber1 != 13 => 13, le.addr_suffix_filled AND SELF.FieldNumber1 != 14 => 14, le.postdir_filled AND SELF.FieldNumber1 != 15 => 15, le.unit_desig_filled AND SELF.FieldNumber1 != 16 => 16, le.sec_range_filled AND SELF.FieldNumber1 != 17 => 17, le.st_filled AND SELF.FieldNumber1 != 20 => 20, le.zip_filled AND SELF.FieldNumber1 != 21 => 21,0);
    SELF.FieldNumber3 := MAP ( le.prim_name_filled AND SELF.FieldNumber1 != 13 AND SELF.FieldNumber2 != 13 => 13, le.addr_suffix_filled AND SELF.FieldNumber1 != 14 AND SELF.FieldNumber2 != 14 => 14, le.postdir_filled AND SELF.FieldNumber1 != 15 AND SELF.FieldNumber2 != 15 => 15, le.unit_desig_filled AND SELF.FieldNumber1 != 16 AND SELF.FieldNumber2 != 16 => 16, le.sec_range_filled AND SELF.FieldNumber1 != 17 AND SELF.FieldNumber2 != 17 => 17, le.st_filled AND SELF.FieldNumber1 != 20 AND SELF.FieldNumber2 != 20 => 20, le.zip_filled AND SELF.FieldNumber1 != 21 AND SELF.FieldNumber2 != 21 => 21,0);
    SELF.FieldNumber4 := MAP ( le.addr_suffix_filled AND SELF.FieldNumber1 != 14 AND SELF.FieldNumber2 != 14 AND SELF.FieldNumber3 != 14 => 14, le.postdir_filled AND SELF.FieldNumber1 != 15 AND SELF.FieldNumber2 != 15 AND SELF.FieldNumber3 != 15 => 15, le.unit_desig_filled AND SELF.FieldNumber1 != 16 AND SELF.FieldNumber2 != 16 AND SELF.FieldNumber3 != 16 => 16, le.sec_range_filled AND SELF.FieldNumber1 != 17 AND SELF.FieldNumber2 != 17 AND SELF.FieldNumber3 != 17 => 17, le.st_filled AND SELF.FieldNumber1 != 20 AND SELF.FieldNumber2 != 20 AND SELF.FieldNumber3 != 20 => 20, le.zip_filled AND SELF.FieldNumber1 != 21 AND SELF.FieldNumber2 != 21 AND SELF.FieldNumber3 != 21 => 21,0);
    SELF.FieldNumber5 := MAP ( le.postdir_filled AND SELF.FieldNumber1 != 15 AND SELF.FieldNumber2 != 15 AND SELF.FieldNumber3 != 15 AND SELF.FieldNumber4 != 15 => 15, le.unit_desig_filled AND SELF.FieldNumber1 != 16 AND SELF.FieldNumber2 != 16 AND SELF.FieldNumber3 != 16 AND SELF.FieldNumber4 != 16 => 16, le.sec_range_filled AND SELF.FieldNumber1 != 17 AND SELF.FieldNumber2 != 17 AND SELF.FieldNumber3 != 17 AND SELF.FieldNumber4 != 17 => 17, le.st_filled AND SELF.FieldNumber1 != 20 AND SELF.FieldNumber2 != 20 AND SELF.FieldNumber3 != 20 AND SELF.FieldNumber4 != 20 => 20, le.zip_filled AND SELF.FieldNumber1 != 21 AND SELF.FieldNumber2 != 21 AND SELF.FieldNumber3 != 21 AND SELF.FieldNumber4 != 21 => 21,0);
    SELF.FieldNumber6 := MAP ( le.unit_desig_filled AND SELF.FieldNumber1 != 16 AND SELF.FieldNumber2 != 16 AND SELF.FieldNumber3 != 16 AND SELF.FieldNumber4 != 16 AND SELF.FieldNumber5 != 16 => 16, le.sec_range_filled AND SELF.FieldNumber1 != 17 AND SELF.FieldNumber2 != 17 AND SELF.FieldNumber3 != 17 AND SELF.FieldNumber4 != 17 AND SELF.FieldNumber5 != 17 => 17, le.st_filled AND SELF.FieldNumber1 != 20 AND SELF.FieldNumber2 != 20 AND SELF.FieldNumber3 != 20 AND SELF.FieldNumber4 != 20 AND SELF.FieldNumber5 != 20 => 20, le.zip_filled AND SELF.FieldNumber1 != 21 AND SELF.FieldNumber2 != 21 AND SELF.FieldNumber3 != 21 AND SELF.FieldNumber4 != 21 AND SELF.FieldNumber5 != 21 => 21,0);
    SELF.FieldNumber7 := MAP ( le.sec_range_filled AND SELF.FieldNumber1 != 17 AND SELF.FieldNumber2 != 17 AND SELF.FieldNumber3 != 17 AND SELF.FieldNumber4 != 17 AND SELF.FieldNumber5 != 17 AND SELF.FieldNumber6 != 17 => 17, le.st_filled AND SELF.FieldNumber1 != 20 AND SELF.FieldNumber2 != 20 AND SELF.FieldNumber3 != 20 AND SELF.FieldNumber4 != 20 AND SELF.FieldNumber5 != 20 AND SELF.FieldNumber6 != 20 => 20, le.zip_filled AND SELF.FieldNumber1 != 21 AND SELF.FieldNumber2 != 21 AND SELF.FieldNumber3 != 21 AND SELF.FieldNumber4 != 21 AND SELF.FieldNumber5 != 21 AND SELF.FieldNumber6 != 21 => 21,0);
    SELF.FieldNumber8 := MAP ( le.st_filled AND SELF.FieldNumber1 != 20 AND SELF.FieldNumber2 != 20 AND SELF.FieldNumber3 != 20 AND SELF.FieldNumber4 != 20 AND SELF.FieldNumber5 != 20 AND SELF.FieldNumber6 != 20 AND SELF.FieldNumber7 != 20 => 20, le.zip_filled AND SELF.FieldNumber1 != 21 AND SELF.FieldNumber2 != 21 AND SELF.FieldNumber3 != 21 AND SELF.FieldNumber4 != 21 AND SELF.FieldNumber5 != 21 AND SELF.FieldNumber6 != 21 AND SELF.FieldNumber7 != 21 => 21,0);
    SELF.FieldNumber9 := MAP ( le.zip_filled AND SELF.FieldNumber1 != 21 AND SELF.FieldNumber2 != 21 AND SELF.FieldNumber3 != 21 AND SELF.FieldNumber4 != 21 AND SELF.FieldNumber5 != 21 AND SELF.FieldNumber6 != 21 AND SELF.FieldNumber7 != 21 AND SELF.FieldNumber8 != 21 => 21,0);
    SELF := le;
  END;
shared address_templates := project(address_combinations,Into(LEFT));
all_templates := address_templates;
EXPORT ConceptTemplatesKey := '~'+'key::BIPV2_Best_Proxid::Proxid::Token::ConceptKey';
EXPORT ConceptTemplateKey := INDEX(all_templates,{FieldNumber1,TokenType},{all_templates},ConceptTemplatesKey);
EXPORT Build := PARALLEL(BUILDINDEX(TokenKey, OVERWRITE),BUILDINDEX(MultiTokenKey, OVERWRITE),BUILDINDEX(ConceptKey, OVERWRITE),BUILDINDEX(ConceptTemplateKey, OVERWRITE));
SHARED TokenClassify_Raw(SALT30.StrType s,SET OF UNSIGNED2 Poss=[]) := PROJECT( TokenKey(TokenHash=HASH32(s),TokenValue = s,Poss=[] OR TokenType IN Poss),TRANSFORM(SALT30.Layout_Classify_Token,SELF := LEFT) );
SHARED MultiTokenClassify_Raw(SALT30.StrType s) := PROJECT( MultiTokenKey(TokenHash=HASH32(s),TokenValue = s),TRANSFORM(SALT30.Layout_Classify_Token,SELF := LEFT) );
EXPORT TokenClassify(SALT30.StrType s) := SORT(TokenClassify_Raw(s),spc);
EXPORT FieldClassify(SALT30.StrType s,SET OF UNSIGNED2 Poss=[]) := FUNCTION
  NWords := SALT30.WordCount(s);
  AsData := DATASET([{s}],{SALT30.StrType s1;});
  SALT30.Layout_Classify_Working_Hypothesis FindParts(AsData le,UNSIGNED4 Posit) := TRANSFORM
    SELF.Cpos := Posit;
    SELF.Possibles := TokenClassify_Raw(SALT30.GetNthWord(le.s1,Posit),Poss)(TokenCount = NWords,Pos = Posit);
  END;
  RETURN SALT30.fn_combine_working_hypothesis( NORMALIZE(AsData,NWords,FindParts(LEFT,COUNTER)) );
END;
// Provide classification information for entire parse stream - ASAP
EXPORT ParseClassify(DATASET(SALT30.Layout_Parse_Raw) p) := FUNCTION
  sp := SALT30.fn_split_parsed(p); // Processing module for this parse stream
  cl := JOIN(sp.Words,TokenKey,HASH32(LEFT.tstring)=RIGHT.TokenHash AND LEFT.tstring=RIGHT.TokenValue,TRANSFORM(SALT30.layout_classify_token,SELF := RIGHT));
  rl := sp.Combine(cl); // Multi-tokens will now be together
  rl0 := rl(TokenCount=1);
  rl1 := rl(TokenCount>1);
  rl2 := JOIN(rl1,MultiTokenKey,RIGHT.TokenHash=HASH32(LEFT.TokenValue) AND RIGHT.TokenValue=LEFT.TokenValue AND LEFT.TokenType = RIGHT.TokenType,TRANSFORM(sp.r,SELF.Verified := LEFT.TokenValue=RIGHT.TokenValue,SELF := LEFT),LEFT OUTER);
  RETURN sp.JoinBack(rl0+rl2);
END;
EXPORT StreamVerify(SALT30.StrType s,DATASET(SALT30.Layout_Classify_Hypothesis) Classified) := FUNCTION
  // MORE - could try to get clever and combine fetches for different types of same multi-token
  SALT30.Layout_Classify_Hypothesis Confirm(Classified le) := TRANSFORM
    SELF.Confirmed := EXISTS ( MultiTokenClassify_Raw(SALT30.GetRangeOfWords(s,le.StartPos,le.Startpos+le.Len-1))(TokenType=le.TokenType));
    SELF := le;
  END;
  R := Classified(len=1) + PROJECT(Classified(len>1),Confirm(LEFT))(Confirmed);
  R0 := SALT30.fn_classify_dedup_hypothesis(R,TRUE);
  RETURN SORT(R,SPC,-Len);
END;
EXPORT StreamAnnotateConcepts(SALT30.StrType s,DATASET(SALT30.Layout_Classify_Hypothesis) Classified) := FUNCTION
// Now we need to look for concept-templates in the fields
  Layout_Template_Hypothesis := RECORD(SALT30.Layout_Classify_Hypothesis)
    UNSIGNED CPos; // Could be > StartPos+fieldno because of multi-token chars
    UNSIGNED2 FieldNumber1;
    UNSIGNED2 FieldNumber2;
    UNSIGNED2 FieldNumber3;
    UNSIGNED2 FieldNumber4;
    UNSIGNED2 FieldNumber5;
    UNSIGNED2 FieldNumber6;
    UNSIGNED2 FieldNumber7;
    UNSIGNED2 FieldNumber8;
    UNSIGNED2 FieldNumber9;
  SALT30.StrType Txt := '';
  END;
  Layout_Template_Hypothesis NotePossibles(Classified le,ConceptTemplateKey ri) := TRANSFORM
    SELF.Len := IF(ri.FieldNumber1=0,0,1)+IF(ri.FieldNumber2=0,0,1)+IF(ri.FieldNumber3=0,0,1)+IF(ri.FieldNumber4=0,0,1)+IF(ri.FieldNumber5=0,0,1)+IF(ri.FieldNumber6=0,0,1)+IF(ri.FieldNumber7=0,0,1)+IF(ri.FieldNumber8=0,0,1)+IF(ri.FieldNumber9=0,0,1);
    SELF.Spc := le.spc+ri.Field_Specificity;
    SELF.Confirmed := ri.FieldNumber2 = 0;
    SELF.CPos := le.StartPos+le.Len;
    SELF.Txt := SALT30.GetRangeOfWords(s,le.StartPos,le.StartPos+le.Len-1);
    SELF := ri;
    SELF := le;
  END;
  J1 := JOIN(Classified,ConceptTemplateKey,LEFT.TokenType=RIGHT.FieldNumber1,NotePossibles(LEFT,RIGHT))(Len>=2);
  Layout_Template_Hypothesis NextStep(Layout_Template_Hypothesis le,Classified ri,UNSIGNED1 step) := TRANSFORM
    SELF.Spc := le.spc+ri.spc;
    SELF.CPos := le.Cpos + ri.Len;
    SELF.Txt := le.Txt + SALT30.GetRangeOfWords(s,le.Cpos,le.Cpos+ri.len-1); // No spaces - to allow hashes to collide
    SELF.Confirmed := le.Len = step;
    SELF := le;
  END;
  J2 := JOIN(J1(~Confirmed),Classified,LEFT.FieldNumber2 = RIGHT.TokenType AND LEFT.Cpos = RIGHT.StartPos,NextStep(LEFT,RIGHT,2));
  J3 := JOIN(J2(~Confirmed),Classified,LEFT.FieldNumber3 = RIGHT.TokenType AND LEFT.Cpos = RIGHT.StartPos,NextStep(LEFT,RIGHT,3));
  J4 := JOIN(J3(~Confirmed),Classified,LEFT.FieldNumber4 = RIGHT.TokenType AND LEFT.Cpos = RIGHT.StartPos,NextStep(LEFT,RIGHT,4));
  J5 := JOIN(J4(~Confirmed),Classified,LEFT.FieldNumber5 = RIGHT.TokenType AND LEFT.Cpos = RIGHT.StartPos,NextStep(LEFT,RIGHT,5));
  J6 := JOIN(J5(~Confirmed),Classified,LEFT.FieldNumber6 = RIGHT.TokenType AND LEFT.Cpos = RIGHT.StartPos,NextStep(LEFT,RIGHT,6));
  J7 := JOIN(J6(~Confirmed),Classified,LEFT.FieldNumber7 = RIGHT.TokenType AND LEFT.Cpos = RIGHT.StartPos,NextStep(LEFT,RIGHT,7));
  J8 := JOIN(J7(~Confirmed),Classified,LEFT.FieldNumber8 = RIGHT.TokenType AND LEFT.Cpos = RIGHT.StartPos,NextStep(LEFT,RIGHT,8));
  J9 := JOIN(J8(~Confirmed),Classified,LEFT.FieldNumber9 = RIGHT.TokenType AND LEFT.Cpos = RIGHT.StartPos,NextStep(LEFT,RIGHT,9));
  AP0 := (J1+J2+J3+J4+J5+J6+J7+J8+J9)(Confirmed);
  AP := JOIN(AP0,ConceptKey,HASH32(LEFT.Txt)=RIGHT.ConceptHash AND LEFT.TokenType=RIGHT.TokenType,TRANSFORM(Layout_Template_Hypothesis, SELF.Spc := RIGHT.Spc; SELF := LEFT));
  RETURN PROJECT(AP,TRANSFORM(SALT30.Layout_Classify_Hypothesis,SELF.Len := LEFT.Cpos-LEFT.StartPos; SELF.Spc := LEFT.SPC / SELF.Len; SELF := LEFT));
END;
EXPORT StreamClassify(SALT30.StrType s) := FUNCTION
  NWords := SALT30.WordCount(s);
  EmptyStart := dataset([],SALT30.Layout_Classify_Hypothesis);
  AH := LOOP(EmptyStart,NWords,SALT30.fn_next_working_hypothesis( ROWS(LEFT),TokenClassify_Raw(SALT30.GetNthWord(s,COUNTER)),COUNTER,Nwords) );
  DD := StreamVerify(s,AH);
  WC := DD+StreamAnnotateConcepts(s,DD);
  DH := SALT30.fn_classify_dedup_hypothesis(WC,TRUE);
  RETURN SORT(DH,SPC,-Len);
END;
EXPORT PrettyStreamClassify(SALT30.StrType s) := SALT30.fn_pretty_hypothesis(s,StreamClassify(s),Fields.FieldName);
END;