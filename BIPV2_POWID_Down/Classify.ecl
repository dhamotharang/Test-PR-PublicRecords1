IMPORT ut,SALT35;
// This module is to the field values what the fields module is to the field itself
// It really exists to answer the question: does a token with these characters logically belong in this field?
// This module should be viewed as experimental
EXPORT Classify(DATASET(layout_POWID_Down) h) := MODULE
 
// Most of the data we need for the classification exists in the specificities module - collect and convert
SHARED TotalClusters := specificities(h).TotalClusters;
  orgid_tokens := PROJECT(specificities(h).orgid_values_persisted,TRANSFORM(SALT35.Layout_Classify_Token,SELF.TokenValue := (SALT35.StrType)LEFT.orgid; SELF.TokenType := 1; SELF.Spc := LEFT.field_Specificity ));
  prim_range_tokens := PROJECT(specificities(h).prim_range_values_persisted,TRANSFORM(SALT35.Layout_Classify_Token,SELF.TokenValue := (SALT35.StrType)LEFT.prim_range; SELF.TokenType := 2; SELF.Spc := LEFT.field_Specificity ));
  prim_name_tokens := PROJECT(specificities(h).prim_name_values_persisted,TRANSFORM(SALT35.Layout_Classify_Token,SELF.TokenValue := (SALT35.StrType)LEFT.prim_name; SELF.TokenType := 3; SELF.Spc := LEFT.field_Specificity ));
  st_tokens := PROJECT(specificities(h).st_values_persisted,TRANSFORM(SALT35.Layout_Classify_Token,SELF.TokenValue := (SALT35.StrType)LEFT.st; SELF.TokenType := 4; SELF.Spc := LEFT.field_Specificity ));
  zip_tokens := PROJECT(specificities(h).zip_values_persisted,TRANSFORM(SALT35.Layout_Classify_Token,SELF.TokenValue := (SALT35.StrType)LEFT.zip; SELF.TokenType := 5; SELF.Spc := LEFT.field_Specificity ));
  v_city_name_tokens := PROJECT(specificities(h).v_city_name_values_persisted,TRANSFORM(SALT35.Layout_Classify_Token,SELF.TokenValue := (SALT35.StrType)LEFT.v_city_name; SELF.TokenType := 7; SELF.Spc := LEFT.field_Specificity ));
SHARED all_tokens0 := orgid_tokens + prim_range_tokens + prim_name_tokens + st_tokens + zip_tokens + v_city_name_tokens;
SHARED all_tokens := SALT35.fn_process_multitokens(all_tokens0);
 
EXPORT TokenKeyName := '~'+'key::BIPV2_POWID_Down::POWID::Token::TokenKey';
 
EXPORT TokenKey := INDEX(all_tokens,{UNSIGNED4 TokenHash := HASH32(TokenValue),TokenType},{all_tokens},TokenKeyName);
 
EXPORT MultiTokenKeyName := '~'+'key::BIPV2_POWID_Down::POWID::Token::MultiTokenKey';
 
EXPORT MultiTokenKey := INDEX(all_tokens0(SALT35.WordCount(TokenValue)>1),{UNSIGNED4 TokenHash := HASH32(TokenValue),TokenType},{all_tokens0},MultiTokenKeyName);
  csz_tokens := PROJECT(specificities(h).csz_values_persisted,TRANSFORM(SALT35.Layout_Classify_Concept,SELF.ConceptHash := LEFT.csz; SELF.TokenType := 6; SELF.Spc := LEFT.field_Specificity ));
  addr1_tokens := PROJECT(specificities(h).addr1_values_persisted,TRANSFORM(SALT35.Layout_Classify_Concept,SELF.ConceptHash := LEFT.addr1; SELF.TokenType := 9; SELF.Spc := LEFT.field_Specificity ));
  address_tokens := PROJECT(specificities(h).address_values_persisted,TRANSFORM(SALT35.Layout_Classify_Concept,SELF.ConceptHash := LEFT.address; SELF.TokenType := 10; SELF.Spc := LEFT.field_Specificity ));
SHARED all_tokens1 := csz_tokens + addr1_tokens + address_tokens;
 
EXPORT ConceptKeyName := '~'+'key::BIPV2_POWID_Down::POWID::Token::ConceptKey';
 
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
  csz_filled_rec := RECORD
    boolean v_city_name_filled :=(SALT35.StrType)ih.v_city_name != '';
    boolean st_filled :=(SALT35.StrType)ih.st != '';
    boolean zip_filled :=(SALT35.StrType)ih.zip != '';
  END;
  t := table(ih,csz_filled_rec);
  csz_filled_rec_totals := RECORD
    UNSIGNED2 TokenType := 6;
    t.v_city_name_filled;
    t.st_filled;
    t.zip_filled;
    UNSIGNED Cnt := COUNT(GROUP);
  END;
  t_tot := table(t,csz_filled_rec_totals,v_city_name_filled,st_filled,zip_filled,few);
  SALT35.MAC_Field_Specificities(t_tot,o_tot);
shared csz_combinations := o_tot;
  Layout_ConceptTemplate Into(csz_combinations le) := TRANSFORM
    SELF.FieldNumber1 := MAP ( le.v_city_name_filled => 7, le.st_filled => 4, le.zip_filled => 5,0);
    SELF.FieldNumber2 := MAP ( le.st_filled AND SELF.FieldNumber1 != 4 => 4, le.zip_filled AND SELF.FieldNumber1 != 5 => 5,0);
    SELF.FieldNumber3 := MAP ( le.zip_filled AND SELF.FieldNumber1 != 5 AND SELF.FieldNumber2 != 5 => 5,0);
    SELF := le;
  END;
shared csz_templates := project(csz_combinations,Into(LEFT));
  addr1_filled_rec := RECORD
    boolean prim_range_filled :=(SALT35.StrType)ih.prim_range != '';
    boolean prim_name_filled :=(SALT35.StrType)ih.prim_name != '';
  END;
  t := table(ih,addr1_filled_rec);
  addr1_filled_rec_totals := RECORD
    UNSIGNED2 TokenType := 9;
    t.prim_range_filled;
    t.prim_name_filled;
    UNSIGNED Cnt := COUNT(GROUP);
  END;
  t_tot := table(t,addr1_filled_rec_totals,prim_range_filled,prim_name_filled,few);
  SALT35.MAC_Field_Specificities(t_tot,o_tot);
shared addr1_combinations := o_tot;
  Layout_ConceptTemplate Into(addr1_combinations le) := TRANSFORM
    SELF.FieldNumber1 := MAP ( le.prim_range_filled => 2, le.prim_name_filled => 3,0);
    SELF.FieldNumber2 := MAP ( le.prim_name_filled AND SELF.FieldNumber1 != 3 => 3,0);
    SELF := le;
  END;
shared addr1_templates := project(addr1_combinations,Into(LEFT));
  address_filled_rec := RECORD
    boolean addr1_filled :=~((SALT35.StrType)ih.prim_range = '' AND (SALT35.StrType)ih.prim_name = '');
    boolean csz_filled :=~((SALT35.StrType)ih.v_city_name = '' AND (SALT35.StrType)ih.st = '' AND (SALT35.StrType)ih.zip = '');
  END;
  t := table(ih,address_filled_rec);
  address_filled_rec_totals := RECORD
    UNSIGNED2 TokenType := 10;
    t.addr1_filled;
    t.csz_filled;
    UNSIGNED Cnt := COUNT(GROUP);
  END;
  t_tot := table(t,address_filled_rec_totals,addr1_filled,csz_filled,few);
  SALT35.MAC_Field_Specificities(t_tot,o_tot);
shared address_combinations := o_tot;
  Layout_ConceptTemplate Into(address_combinations le) := TRANSFORM
    SELF.FieldNumber1 := MAP ( le.addr1_filled => 9, le.csz_filled => 6,0);
    SELF.FieldNumber2 := MAP ( le.csz_filled AND SELF.FieldNumber1 != 6 => 6,0);
    SELF := le;
  END;
shared address_templates := project(address_combinations,Into(LEFT));
SHARED all_templates := csz_templates + addr1_templates + address_templates;
 
EXPORT ConceptTemplatesKey := '~'+'key::BIPV2_POWID_Down::POWID::Token::ConceptTemplatesKey';
 
EXPORT ConceptTemplateKey := INDEX(all_templates,{FieldNumber1,TokenType},{all_templates},ConceptTemplatesKey);
 
EXPORT Build := PARALLEL(BUILDINDEX(TokenKey, OVERWRITE),BUILDINDEX(MultiTokenKey, OVERWRITE),BUILDINDEX(ConceptKey, OVERWRITE),BUILDINDEX(ConceptTemplateKey, OVERWRITE));
 
SHARED TokenClassify_Raw(SALT35.StrType s,SET OF UNSIGNED2 Poss=[]) := PROJECT( TokenKey(TokenHash=HASH32(s),TokenValue = s,Poss=[] OR TokenType IN Poss),TRANSFORM(SALT35.Layout_Classify_Token,SELF := LEFT) );
SHARED MultiTokenClassify_Raw(SALT35.StrType s) := PROJECT( MultiTokenKey(TokenHash=HASH32(s),TokenValue = s),TRANSFORM(SALT35.Layout_Classify_Token,SELF := LEFT) );
 
EXPORT TokenClassify(SALT35.StrType s) := SORT(TokenClassify_Raw(s),spc);
 
EXPORT FieldClassify(SALT35.StrType s,SET OF UNSIGNED2 Poss=[]) := FUNCTION
  NWords := SALT35.WordCount(s);
  AsData := DATASET([{s}],{SALT35.StrType s1;});
  SALT35.Layout_Classify_Working_Hypothesis FindParts(AsData le,UNSIGNED4 Posit) := TRANSFORM
    SELF.Cpos := Posit;
    SELF.Possibles := TokenClassify_Raw(SALT35.GetNthWord(le.s1,Posit),Poss)(TokenCount = NWords,Pos = Posit);
  END;
  RETURN SALT35.fn_combine_working_hypothesis( NORMALIZE(AsData,NWords,FindParts(LEFT,COUNTER)) );
END;
// Provide classification information for entire parse stream - ASAP
EXPORT ParseClassify(DATASET(SALT35.Layout_Parse_Raw) p) := FUNCTION
  sp := SALT35.fn_split_parsed(p); // Processing module for this parse stream
  cl := JOIN(sp.Words,TokenKey,HASH32(LEFT.tstring)=RIGHT.TokenHash AND LEFT.tstring=RIGHT.TokenValue,TRANSFORM(SALT35.layout_classify_token,SELF := RIGHT));
  rl := sp.Combine(cl); // Multi-tokens will now be together
  rl0 := rl(TokenCount=1);
  rl1 := rl(TokenCount>1);
  rl2 := JOIN(rl1,MultiTokenKey,RIGHT.TokenHash=HASH32(LEFT.TokenValue) AND RIGHT.TokenValue=LEFT.TokenValue AND LEFT.TokenType = RIGHT.TokenType,TRANSFORM(sp.r,SELF.Verified := LEFT.TokenValue=RIGHT.TokenValue,SELF := LEFT),LEFT OUTER);
  RETURN sp.JoinBack(rl0+rl2);
END;
 
EXPORT StreamVerify(SALT35.StrType s,DATASET(SALT35.Layout_Classify_Hypothesis) Classified) := FUNCTION
  // MORE - could try to get clever and combine fetches for different types of same multi-token
  SALT35.Layout_Classify_Hypothesis Confirm(Classified le) := TRANSFORM
    SELF.Confirmed := EXISTS ( MultiTokenClassify_Raw(SALT35.GetRangeOfWords(s,le.StartPos,le.Startpos+le.Len-1))(TokenType=le.TokenType));
    SELF := le;
  END;
  R := Classified(len=1) + PROJECT(Classified(len>1),Confirm(LEFT))(Confirmed);
  R0 := SALT35.fn_classify_dedup_hypothesis(R,TRUE);
  RETURN SORT(R,SPC,-Len);
END;
 
EXPORT StreamAnnotateConcepts(SALT35.StrType s,DATASET(SALT35.Layout_Classify_Hypothesis) Classified) := FUNCTION
// Now we need to look for concept-templates in the fields
  Layout_Template_Hypothesis := RECORD(SALT35.Layout_Classify_Hypothesis)
    UNSIGNED CPos; // Could be > StartPos+fieldno because of multi-token chars
    UNSIGNED2 FieldNumber1;
    UNSIGNED2 FieldNumber2;
    UNSIGNED2 FieldNumber3;
  SALT35.StrType Txt := '';
  END;
  Layout_Template_Hypothesis NotePossibles(Classified le,ConceptTemplateKey ri) := TRANSFORM
    SELF.Len := IF(ri.FieldNumber1=0,0,1)+IF(ri.FieldNumber2=0,0,1)+IF(ri.FieldNumber3=0,0,1);
    SELF.Spc := le.spc+ri.Field_Specificity;
    SELF.Confirmed := ri.FieldNumber2 = 0;
    SELF.CPos := le.StartPos+le.Len;
    SELF.Txt := SALT35.GetRangeOfWords(s,le.StartPos,le.StartPos+le.Len-1);
    SELF := ri;
    SELF := le;
  END;
  J1 := JOIN(Classified,ConceptTemplateKey,LEFT.TokenType=RIGHT.FieldNumber1,NotePossibles(LEFT,RIGHT))(Len>=2);
  Layout_Template_Hypothesis NextStep(Layout_Template_Hypothesis le,Classified ri,UNSIGNED1 step) := TRANSFORM
    SELF.Spc := le.spc+ri.spc;
    SELF.CPos := le.Cpos + ri.Len;
    SELF.Txt := le.Txt + SALT35.GetRangeOfWords(s,le.Cpos,le.Cpos+ri.len-1); // No spaces - to allow hashes to collide
    SELF.Confirmed := le.Len = step;
    SELF := le;
  END;
  J2 := JOIN(J1(~Confirmed),Classified,LEFT.FieldNumber2 = RIGHT.TokenType AND LEFT.Cpos = RIGHT.StartPos,NextStep(LEFT,RIGHT,2));
  J3 := JOIN(J2(~Confirmed),Classified,LEFT.FieldNumber3 = RIGHT.TokenType AND LEFT.Cpos = RIGHT.StartPos,NextStep(LEFT,RIGHT,3));
  AP0 := (J1+J2+J3)(Confirmed);
  AP := JOIN(AP0,ConceptKey,HASH32(LEFT.Txt)=RIGHT.ConceptHash AND LEFT.TokenType=RIGHT.TokenType,TRANSFORM(Layout_Template_Hypothesis, SELF.Spc := RIGHT.Spc; SELF := LEFT));
  RETURN PROJECT(AP,TRANSFORM(SALT35.Layout_Classify_Hypothesis,SELF.Len := LEFT.Cpos-LEFT.StartPos; SELF.Spc := LEFT.SPC / SELF.Len; SELF := LEFT));
END;
 
EXPORT StreamClassify(SALT35.StrType s) := FUNCTION
  NWords := SALT35.WordCount(s);
  EmptyStart := dataset([],SALT35.Layout_Classify_Hypothesis);
  AH := LOOP(EmptyStart,NWords,SALT35.fn_next_working_hypothesis( ROWS(LEFT),TokenClassify_Raw(SALT35.GetNthWord(s,COUNTER)),COUNTER,Nwords) );
  DD := StreamVerify(s,AH);
  WC := DD+StreamAnnotateConcepts(s,DD);
  DH := SALT35.fn_classify_dedup_hypothesis(WC,TRUE);
  RETURN SORT(DH,SPC,-Len);
END;
 
EXPORT PrettyStreamClassify(SALT35.StrType s) := SALT35.fn_pretty_hypothesis(s,StreamClassify(s),Fields.FieldName);
END;
