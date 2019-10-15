IMPORT ut,SALT30;
// This module is to the field values what the fields module is to the field itself
// It really exists to answer the question: does a token with these characters logically belong in this field?
// This module should be viewed as experimental
EXPORT Classify(DATASET(layout_LGID3) h) := MODULE
 
// Most of the data we need for the classification exists in the specificities module - collect and convert
SHARED TotalClusters := specificities(h).TotalClusters;
  sbfe_id_tokens := PROJECT(specificities(h).sbfe_id_values_persisted,TRANSFORM(SALT30.Layout_Classify_Token,SELF.TokenValue := (SALT30.StrType)LEFT.sbfe_id; SELF.TokenType := 1; SELF.Spc := LEFT.field_Specificity ));
  Lgid3IfHrchy_tokens := PROJECT(specificities(h).Lgid3IfHrchy_values_persisted,TRANSFORM(SALT30.Layout_Classify_Token,SELF.TokenValue := (SALT30.StrType)LEFT.Lgid3IfHrchy; SELF.TokenType := 3; SELF.Spc := LEFT.field_Specificity ));
  company_name_tokens := PROJECT(specificities(h).company_name_values_persisted,TRANSFORM(SALT30.Layout_Classify_Token,SELF.TokenValue := (SALT30.StrType)LEFT.company_name; SELF.TokenType := 6; SELF.Spc := LEFT.field_Specificity ));
  cnp_number_tokens := PROJECT(specificities(h).cnp_number_values_persisted,TRANSFORM(SALT30.Layout_Classify_Token,SELF.TokenValue := (SALT30.StrType)LEFT.cnp_number; SELF.TokenType := 7; SELF.Spc := LEFT.field_Specificity ));
  active_duns_number_tokens := PROJECT(specificities(h).active_duns_number_values_persisted,TRANSFORM(SALT30.Layout_Classify_Token,SELF.TokenValue := (SALT30.StrType)LEFT.active_duns_number; SELF.TokenType := 8; SELF.Spc := LEFT.field_Specificity ));
  duns_number_tokens := PROJECT(specificities(h).duns_number_values_persisted,TRANSFORM(SALT30.Layout_Classify_Token,SELF.TokenValue := (SALT30.StrType)LEFT.duns_number; SELF.TokenType := 9; SELF.Spc := LEFT.field_Specificity ));
  company_fein_tokens := PROJECT(specificities(h).company_fein_values_persisted,TRANSFORM(SALT30.Layout_Classify_Token,SELF.TokenValue := (SALT30.StrType)LEFT.company_fein; SELF.TokenType := 11; SELF.Spc := LEFT.field_Specificity ));
  company_inc_state_tokens := PROJECT(specificities(h).company_inc_state_values_persisted,TRANSFORM(SALT30.Layout_Classify_Token,SELF.TokenValue := (SALT30.StrType)LEFT.company_inc_state; SELF.TokenType := 12; SELF.Spc := LEFT.field_Specificity ));
  company_charter_number_tokens := PROJECT(specificities(h).company_charter_number_values_persisted,TRANSFORM(SALT30.Layout_Classify_Token,SELF.TokenValue := (SALT30.StrType)LEFT.company_charter_number; SELF.TokenType := 13; SELF.Spc := LEFT.field_Specificity ));
  cnp_btype_tokens := PROJECT(specificities(h).cnp_btype_values_persisted,TRANSFORM(SALT30.Layout_Classify_Token,SELF.TokenValue := (SALT30.StrType)LEFT.cnp_btype; SELF.TokenType := 14; SELF.Spc := LEFT.field_Specificity ));
SHARED all_tokens0 := sbfe_id_tokens + Lgid3IfHrchy_tokens + company_name_tokens + cnp_number_tokens + active_duns_number_tokens + duns_number_tokens + company_fein_tokens + company_inc_state_tokens + company_charter_number_tokens + cnp_btype_tokens;
  all_tokens := SALT30.fn_process_multitokens(all_tokens0);
 
EXPORT TokenKeyName := '~'+'key::BIPV2_LGID3_PlatForm::LGID3::Token::TokenKey';
 
EXPORT TokenKey := INDEX(all_tokens,{UNSIGNED4 TokenHash := HASH32(TokenValue),TokenType},{all_tokens},TokenKeyName);
 
EXPORT MultiTokenKeyName := '~'+'key::BIPV2_LGID3_PlatForm::LGID3::Token::MultiTokenKey';
 
EXPORT MultiTokenKey := INDEX(all_tokens0(SALT30.WordCount(TokenValue)>1),{UNSIGNED4 TokenHash := HASH32(TokenValue),TokenType},{all_tokens0},MultiTokenKeyName);
  duns_number_concept_tokens := PROJECT(specificities(h).duns_number_concept_values_persisted,TRANSFORM(SALT30.Layout_Classify_Concept,SELF.ConceptHash := LEFT.duns_number_concept; SELF.TokenType := 10; SELF.Spc := LEFT.field_Specificity ));
all_tokens1 := duns_number_concept_tokens;
 
EXPORT ConceptKeyName := '~'+'key::BIPV2_LGID3_PlatForm::LGID3::Token::ConceptKey';
 
EXPORT ConceptKey := INDEX(all_tokens1,{ConceptHash,TokenType},{all_tokens1},ConceptKeyName);
// Now compute the patterns of filled in field values for the various concept fields
SHARED s := specificities(h).specificities;
SHARED ih := specificities(h).input_file;
SHARED Layout_ConceptTemplate := RECORD
    UNSIGNED2 TokenType;
    UNSIGNED2 FieldNumber1 := 0; // The field number occupying position 1 in this template
    UNSIGNED2 FieldNumber2 := 0; // The field number occupying position 2 in this template
    REAL Field_Specificity;
    UNSIGNED Cnt;
  END;
  duns_number_concept_filled_rec := RECORD
    boolean active_duns_number_filled :=(SALT30.StrType)ih.active_duns_number != '';
    boolean duns_number_filled :=(SALT30.StrType)ih.duns_number != '';
  END;
  t := table(ih,duns_number_concept_filled_rec);
  duns_number_concept_filled_rec_totals := RECORD
    UNSIGNED2 TokenType := 10;
    t.active_duns_number_filled;
    t.duns_number_filled;
    UNSIGNED Cnt := COUNT(GROUP);
  END;
  t_tot := table(t,duns_number_concept_filled_rec_totals,active_duns_number_filled,duns_number_filled,few);
  SALT30.MAC_Field_Specificities(t_tot,o_tot);
shared duns_number_concept_combinations := o_tot;
  Layout_ConceptTemplate Into(duns_number_concept_combinations le) := TRANSFORM
    SELF.FieldNumber1 := MAP ( le.active_duns_number_filled => 8, le.duns_number_filled => 9,0);
    SELF.FieldNumber2 := MAP ( le.duns_number_filled AND SELF.FieldNumber1 != 9 => 9,0);
    SELF := le;
  END;
shared duns_number_concept_templates := project(duns_number_concept_combinations,Into(LEFT));
all_templates := duns_number_concept_templates;
 
EXPORT ConceptTemplatesKey := '~'+'key::BIPV2_LGID3_PlatForm::LGID3::Token::ConceptKey';
 
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
  SALT30.StrType Txt := '';
  END;
  Layout_Template_Hypothesis NotePossibles(Classified le,ConceptTemplateKey ri) := TRANSFORM
    SELF.Len := IF(ri.FieldNumber1=0,0,1)+IF(ri.FieldNumber2=0,0,1);
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
  AP0 := (J1+J2)(Confirmed);
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
