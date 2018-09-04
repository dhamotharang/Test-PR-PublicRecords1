IMPORT SALT37;
// This module is to the field values what the fields module is to the field itself
// It really exists to answer the question: does a token with these characters logically belong in this field?
// This module should be viewed as experimental
EXPORT Classify(DATASET(layout_DOT_Base) h) := MODULE
 
// Most of the data we need for the classification exists in the specificities module - collect and convert
SHARED TotalClusters := specificities(h).TotalClusters;
  cnp_number_tokens := PROJECT(specificities(h).cnp_number_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.cnp_number; SELF.TokenType := 1; SELF.Spc := LEFT.field_Specificity ));
  st_tokens := PROJECT(specificities(h).st_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.st; SELF.TokenType := 2; SELF.Spc := LEFT.field_Specificity ));
  prim_range_derived_tokens := PROJECT(specificities(h).prim_range_derived_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.prim_range_derived; SELF.TokenType := 3; SELF.Spc := LEFT.field_Specificity ));
  hist_duns_number_tokens := PROJECT(specificities(h).hist_duns_number_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.hist_duns_number; SELF.TokenType := 4; SELF.Spc := LEFT.field_Specificity ));
  ebr_file_number_tokens := PROJECT(specificities(h).ebr_file_number_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.ebr_file_number; SELF.TokenType := 5; SELF.Spc := LEFT.field_Specificity ));
  active_duns_number_tokens := PROJECT(specificities(h).active_duns_number_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.active_duns_number; SELF.TokenType := 6; SELF.Spc := LEFT.field_Specificity ));
  hist_enterprise_number_tokens := PROJECT(specificities(h).hist_enterprise_number_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.hist_enterprise_number; SELF.TokenType := 7; SELF.Spc := LEFT.field_Specificity ));
  hist_domestic_corp_key_tokens := PROJECT(specificities(h).hist_domestic_corp_key_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.hist_domestic_corp_key; SELF.TokenType := 8; SELF.Spc := LEFT.field_Specificity ));
  foreign_corp_key_tokens := PROJECT(specificities(h).foreign_corp_key_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.foreign_corp_key; SELF.TokenType := 9; SELF.Spc := LEFT.field_Specificity ));
  unk_corp_key_tokens := PROJECT(specificities(h).unk_corp_key_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.unk_corp_key; SELF.TokenType := 10; SELF.Spc := LEFT.field_Specificity ));
  company_fein_tokens := PROJECT(specificities(h).company_fein_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.company_fein; SELF.TokenType := 11; SELF.Spc := LEFT.field_Specificity ));
  company_phone_tokens := PROJECT(specificities(h).company_phone_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.company_phone; SELF.TokenType := 12; SELF.Spc := LEFT.field_Specificity ));
  active_enterprise_number_tokens := PROJECT(specificities(h).active_enterprise_number_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.active_enterprise_number; SELF.TokenType := 13; SELF.Spc := LEFT.field_Specificity ));
  active_domestic_corp_key_tokens := PROJECT(specificities(h).active_domestic_corp_key_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.active_domestic_corp_key; SELF.TokenType := 14; SELF.Spc := LEFT.field_Specificity ));
  cnp_name_tokens := PROJECT(specificities(h).cnp_name_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.cnp_name; SELF.TokenType := 16; SELF.Spc := LEFT.field_Specificity ));
  zip_tokens := PROJECT(specificities(h).zip_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.zip; SELF.TokenType := 17; SELF.Spc := LEFT.field_Specificity ));
  prim_name_derived_tokens := PROJECT(specificities(h).prim_name_derived_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.prim_name_derived; SELF.TokenType := 19; SELF.Spc := LEFT.field_Specificity ));
  sec_range_tokens := PROJECT(specificities(h).sec_range_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.sec_range; SELF.TokenType := 20; SELF.Spc := LEFT.field_Specificity ));
  v_city_name_tokens := PROJECT(specificities(h).v_city_name_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.v_city_name; SELF.TokenType := 21; SELF.Spc := LEFT.field_Specificity ));
  cnp_btype_tokens := PROJECT(specificities(h).cnp_btype_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.cnp_btype; SELF.TokenType := 22; SELF.Spc := LEFT.field_Specificity ));
  company_name_type_derived_tokens := PROJECT(specificities(h).company_name_type_derived_values_persisted,TRANSFORM(SALT37.Layout_Classify_Token,SELF.TokenValue := (SALT37.StrType)LEFT.company_name_type_derived; SELF.TokenType := 23; SELF.Spc := LEFT.field_Specificity ));
SHARED all_tokens0 := cnp_number_tokens + st_tokens + prim_range_derived_tokens + hist_duns_number_tokens + ebr_file_number_tokens + active_duns_number_tokens + hist_enterprise_number_tokens + hist_domestic_corp_key_tokens + foreign_corp_key_tokens + unk_corp_key_tokens + company_fein_tokens + company_phone_tokens + active_enterprise_number_tokens + active_domestic_corp_key_tokens + cnp_name_tokens + zip_tokens + prim_name_derived_tokens + sec_range_tokens + v_city_name_tokens + cnp_btype_tokens + company_name_type_derived_tokens;
SHARED all_tokens := SALT37.fn_process_multitokens(all_tokens0);
 
EXPORT TokenKeyName := '~'+'key::BIPV2_ProxID::Proxid::Token::TokenKey';
 
EXPORT TokenKey := INDEX(all_tokens,{UNSIGNED4 TokenHash := HASH32(TokenValue),TokenType},{all_tokens},TokenKeyName);
 
EXPORT MultiTokenKeyName := '~'+'key::BIPV2_ProxID::Proxid::Token::MultiTokenKey';
 
EXPORT MultiTokenKey := INDEX(all_tokens0(SALT37.WordCount(TokenValue)>1),{UNSIGNED4 TokenHash := HASH32(TokenValue),TokenType},{all_tokens0},MultiTokenKeyName);
  company_addr1_tokens := PROJECT(specificities(h).company_addr1_values_persisted,TRANSFORM(SALT37.Layout_Classify_Concept,SELF.ConceptHash := LEFT.company_addr1; SELF.TokenType := 15; SELF.Spc := LEFT.field_Specificity ));
  company_csz_tokens := PROJECT(specificities(h).company_csz_values_persisted,TRANSFORM(SALT37.Layout_Classify_Concept,SELF.ConceptHash := LEFT.company_csz; SELF.TokenType := 18; SELF.Spc := LEFT.field_Specificity ));
  company_address_tokens := PROJECT(specificities(h).company_address_values_persisted,TRANSFORM(SALT37.Layout_Classify_Concept,SELF.ConceptHash := LEFT.company_address; SELF.TokenType := 34; SELF.Spc := LEFT.field_Specificity ));
SHARED all_tokens1 := company_addr1_tokens + company_csz_tokens + company_address_tokens;
 
EXPORT ConceptKeyName := '~'+'key::BIPV2_ProxID::Proxid::Token::ConceptKey';
 
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
  company_addr1_filled_rec := RECORD
    boolean prim_range_derived_filled :=(SALT37.StrType)ih.prim_range_derived != '';
    boolean prim_name_derived_filled :=(SALT37.StrType)ih.prim_name_derived != '';
    boolean sec_range_filled :=(SALT37.StrType)ih.sec_range != '';
  END;
  t := table(ih,company_addr1_filled_rec);
  company_addr1_filled_rec_totals := RECORD
    UNSIGNED2 TokenType := 15;
    t.prim_range_derived_filled;
    t.prim_name_derived_filled;
    t.sec_range_filled;
    UNSIGNED Cnt := COUNT(GROUP);
  END;
  t_tot := table(t,company_addr1_filled_rec_totals,prim_range_derived_filled,prim_name_derived_filled,sec_range_filled,few);
  SALT37.MAC_Field_Specificities(t_tot,o_tot);
shared company_addr1_combinations := o_tot;
  Layout_ConceptTemplate Into(company_addr1_combinations le) := TRANSFORM
    SELF.FieldNumber1 := MAP ( le.prim_range_derived_filled => 3, le.prim_name_derived_filled => 19, le.sec_range_filled => 20,0);
    SELF.FieldNumber2 := MAP ( le.prim_name_derived_filled AND SELF.FieldNumber1 != 19 => 19, le.sec_range_filled AND SELF.FieldNumber1 != 20 => 20,0);
    SELF.FieldNumber3 := MAP ( le.sec_range_filled AND SELF.FieldNumber1 != 20 AND SELF.FieldNumber2 != 20 => 20,0);
    SELF := le;
  END;
shared company_addr1_templates := project(company_addr1_combinations,Into(LEFT));
  company_csz_filled_rec := RECORD
    boolean v_city_name_filled :=(SALT37.StrType)ih.v_city_name != '';
    boolean st_filled :=(SALT37.StrType)ih.st != '';
    boolean zip_filled :=(SALT37.StrType)ih.zip != '';
  END;
  t := table(ih,company_csz_filled_rec);
  company_csz_filled_rec_totals := RECORD
    UNSIGNED2 TokenType := 18;
    t.v_city_name_filled;
    t.st_filled;
    t.zip_filled;
    UNSIGNED Cnt := COUNT(GROUP);
  END;
  t_tot := table(t,company_csz_filled_rec_totals,v_city_name_filled,st_filled,zip_filled,few);
  SALT37.MAC_Field_Specificities(t_tot,o_tot);
shared company_csz_combinations := o_tot;
  Layout_ConceptTemplate Into(company_csz_combinations le) := TRANSFORM
    SELF.FieldNumber1 := MAP ( le.v_city_name_filled => 21, le.st_filled => 2, le.zip_filled => 17,0);
    SELF.FieldNumber2 := MAP ( le.st_filled AND SELF.FieldNumber1 != 2 => 2, le.zip_filled AND SELF.FieldNumber1 != 17 => 17,0);
    SELF.FieldNumber3 := MAP ( le.zip_filled AND SELF.FieldNumber1 != 17 AND SELF.FieldNumber2 != 17 => 17,0);
    SELF := le;
  END;
shared company_csz_templates := project(company_csz_combinations,Into(LEFT));
  company_address_filled_rec := RECORD
    boolean company_addr1_filled :=~((SALT37.StrType)ih.prim_range_derived = '' AND (SALT37.StrType)ih.prim_name_derived = '' AND (SALT37.StrType)ih.sec_range = '');
    boolean company_csz_filled :=~((SALT37.StrType)ih.v_city_name = '' AND (SALT37.StrType)ih.st = '' AND (SALT37.StrType)ih.zip = '');
  END;
  t := table(ih,company_address_filled_rec);
  company_address_filled_rec_totals := RECORD
    UNSIGNED2 TokenType := 34;
    t.company_addr1_filled;
    t.company_csz_filled;
    UNSIGNED Cnt := COUNT(GROUP);
  END;
  t_tot := table(t,company_address_filled_rec_totals,company_addr1_filled,company_csz_filled,few);
  SALT37.MAC_Field_Specificities(t_tot,o_tot);
shared company_address_combinations := o_tot;
  Layout_ConceptTemplate Into(company_address_combinations le) := TRANSFORM
    SELF.FieldNumber1 := MAP ( le.company_addr1_filled => 15, le.company_csz_filled => 18,0);
    SELF.FieldNumber2 := MAP ( le.company_csz_filled AND SELF.FieldNumber1 != 18 => 18,0);
    SELF := le;
  END;
shared company_address_templates := project(company_address_combinations,Into(LEFT));
SHARED all_templates := company_addr1_templates + company_csz_templates + company_address_templates;
 
EXPORT ConceptTemplatesKey := '~'+'key::BIPV2_ProxID::Proxid::Token::ConceptTemplatesKey';
 
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
