IMPORT ut,SALT30;
// This module is to the field values what the fields module is to the field itself
// It really exists to answer the question: does a token with these characters logically belong in this field?
// This module should be viewed as experimental
EXPORT Classify(DATASET(layout_HealthFacility) h) := MODULE
// Most of the data we need for the classification exists in the specificities module - collect and convert
SHARED TotalClusters := specificities(h).TotalClusters;
  NPI_NUMBER_tokens := PROJECT(specificities(h).NPI_NUMBER_values_persisted,TRANSFORM(SALT30.Layout_Classify_Token,SELF.TokenValue := (SALT30.StrType)LEFT.NPI_NUMBER; SELF.TokenType := 2; SELF.Spc := LEFT.field_Specificity ));
  DEA_NUMBER_tokens := PROJECT(specificities(h).DEA_NUMBER_values_persisted,TRANSFORM(SALT30.Layout_Classify_Token,SELF.TokenValue := (SALT30.StrType)LEFT.DEA_NUMBER; SELF.TokenType := 3; SELF.Spc := LEFT.field_Specificity ));
  CLIA_NUMBER_tokens := PROJECT(specificities(h).CLIA_NUMBER_values_persisted,TRANSFORM(SALT30.Layout_Classify_Token,SELF.TokenValue := (SALT30.StrType)LEFT.CLIA_NUMBER; SELF.TokenType := 4; SELF.Spc := LEFT.field_Specificity ));
  MEDICARE_FACILITY_NUMBER_tokens := PROJECT(specificities(h).MEDICARE_FACILITY_NUMBER_values_persisted,TRANSFORM(SALT30.Layout_Classify_Token,SELF.TokenValue := (SALT30.StrType)LEFT.MEDICARE_FACILITY_NUMBER; SELF.TokenType := 5; SELF.Spc := LEFT.field_Specificity ));
  NCPDP_NUMBER_tokens := PROJECT(specificities(h).NCPDP_NUMBER_values_persisted,TRANSFORM(SALT30.Layout_Classify_Token,SELF.TokenValue := (SALT30.StrType)LEFT.NCPDP_NUMBER; SELF.TokenType := 6; SELF.Spc := LEFT.field_Specificity ));
  TAX_ID_tokens := PROJECT(specificities(h).TAX_ID_values_persisted,TRANSFORM(SALT30.Layout_Classify_Token,SELF.TokenValue := (SALT30.StrType)LEFT.TAX_ID; SELF.TokenType := 7; SELF.Spc := LEFT.field_Specificity ));
  FEIN_tokens := PROJECT(specificities(h).FEIN_values_persisted,TRANSFORM(SALT30.Layout_Classify_Token,SELF.TokenValue := (SALT30.StrType)LEFT.FEIN; SELF.TokenType := 8; SELF.Spc := LEFT.field_Specificity ));
  C_LIC_NBR_tokens := PROJECT(specificities(h).C_LIC_NBR_values_persisted,TRANSFORM(SALT30.Layout_Classify_Token,SELF.TokenValue := (SALT30.StrType)LEFT.C_LIC_NBR; SELF.TokenType := 9; SELF.Spc := LEFT.field_Specificity ));
  CNP_NAME_tokens := PROJECT(specificities(h).CNP_NAME_values_persisted,TRANSFORM(SALT30.Layout_Classify_Token,SELF.TokenValue := (SALT30.StrType)LEFT.CNP_NAME; SELF.TokenType := 12; SELF.Spc := LEFT.field_Specificity ));
  CNP_NUMBER_tokens := PROJECT(specificities(h).CNP_NUMBER_values_persisted,TRANSFORM(SALT30.Layout_Classify_Token,SELF.TokenValue := (SALT30.StrType)LEFT.CNP_NUMBER; SELF.TokenType := 13; SELF.Spc := LEFT.field_Specificity ));
  CNP_STORE_NUMBER_tokens := PROJECT(specificities(h).CNP_STORE_NUMBER_values_persisted,TRANSFORM(SALT30.Layout_Classify_Token,SELF.TokenValue := (SALT30.StrType)LEFT.CNP_STORE_NUMBER; SELF.TokenType := 14; SELF.Spc := LEFT.field_Specificity ));
  CNP_BTYPE_tokens := PROJECT(specificities(h).CNP_BTYPE_values_persisted,TRANSFORM(SALT30.Layout_Classify_Token,SELF.TokenValue := (SALT30.StrType)LEFT.CNP_BTYPE; SELF.TokenType := 15; SELF.Spc := LEFT.field_Specificity ));
  PRIM_RANGE_tokens := PROJECT(specificities(h).PRIM_RANGE_values_persisted,TRANSFORM(SALT30.Layout_Classify_Token,SELF.TokenValue := (SALT30.StrType)LEFT.PRIM_RANGE; SELF.TokenType := 21; SELF.Spc := LEFT.field_Specificity ));
  PRIM_NAME_tokens := PROJECT(specificities(h).PRIM_NAME_values_persisted,TRANSFORM(SALT30.Layout_Classify_Token,SELF.TokenValue := (SALT30.StrType)LEFT.PRIM_NAME; SELF.TokenType := 22; SELF.Spc := LEFT.field_Specificity ));
  SEC_RANGE_tokens := PROJECT(specificities(h).SEC_RANGE_values_persisted,TRANSFORM(SALT30.Layout_Classify_Token,SELF.TokenValue := (SALT30.StrType)LEFT.SEC_RANGE; SELF.TokenType := 23; SELF.Spc := LEFT.field_Specificity ));
  ST_tokens := PROJECT(specificities(h).ST_values_persisted,TRANSFORM(SALT30.Layout_Classify_Token,SELF.TokenValue := (SALT30.StrType)LEFT.ST; SELF.TokenType := 24; SELF.Spc := LEFT.field_Specificity ));
  V_CITY_NAME_tokens := PROJECT(specificities(h).V_CITY_NAME_values_persisted,TRANSFORM(SALT30.Layout_Classify_Token,SELF.TokenValue := (SALT30.StrType)LEFT.V_CITY_NAME; SELF.TokenType := 25; SELF.Spc := LEFT.field_Specificity ));
  ZIP_tokens := PROJECT(specificities(h).ZIP_values_persisted,TRANSFORM(SALT30.Layout_Classify_Token,SELF.TokenValue := (SALT30.StrType)LEFT.ZIP; SELF.TokenType := 26; SELF.Spc := LEFT.field_Specificity ));
  PHONE_tokens := PROJECT(specificities(h).PHONE_values_persisted,TRANSFORM(SALT30.Layout_Classify_Token,SELF.TokenValue := (SALT30.StrType)LEFT.PHONE; SELF.TokenType := 27; SELF.Spc := LEFT.field_Specificity ));
  FAX_tokens := PROJECT(specificities(h).FAX_values_persisted,TRANSFORM(SALT30.Layout_Classify_Token,SELF.TokenValue := (SALT30.StrType)LEFT.FAX; SELF.TokenType := 28; SELF.Spc := LEFT.field_Specificity ));
  TAXONOMY_tokens := PROJECT(specificities(h).TAXONOMY_values_persisted,TRANSFORM(SALT30.Layout_Classify_Token,SELF.TokenValue := (SALT30.StrType)LEFT.TAXONOMY; SELF.TokenType := 29; SELF.Spc := LEFT.field_Specificity ));
  TAXONOMY_CODE_tokens := PROJECT(specificities(h).TAXONOMY_CODE_values_persisted,TRANSFORM(SALT30.Layout_Classify_Token,SELF.TokenValue := (SALT30.StrType)LEFT.TAXONOMY_CODE; SELF.TokenType := 30; SELF.Spc := LEFT.field_Specificity ));
  MEDICAID_NUMBER_tokens := PROJECT(specificities(h).MEDICAID_NUMBER_values_persisted,TRANSFORM(SALT30.Layout_Classify_Token,SELF.TokenValue := (SALT30.StrType)LEFT.MEDICAID_NUMBER; SELF.TokenType := 31; SELF.Spc := LEFT.field_Specificity ));
  VENDOR_ID_tokens := PROJECT(specificities(h).VENDOR_ID_values_persisted,TRANSFORM(SALT30.Layout_Classify_Token,SELF.TokenValue := (SALT30.StrType)LEFT.VENDOR_ID; SELF.TokenType := 32; SELF.Spc := LEFT.field_Specificity ));
SHARED all_tokens0 := NPI_NUMBER_tokens + DEA_NUMBER_tokens + CLIA_NUMBER_tokens + MEDICARE_FACILITY_NUMBER_tokens + NCPDP_NUMBER_tokens + TAX_ID_tokens + FEIN_tokens + C_LIC_NBR_tokens + CNP_NAME_tokens + CNP_NUMBER_tokens + CNP_STORE_NUMBER_tokens + CNP_BTYPE_tokens + PRIM_RANGE_tokens + PRIM_NAME_tokens + SEC_RANGE_tokens + ST_tokens + V_CITY_NAME_tokens + ZIP_tokens + PHONE_tokens + FAX_tokens + TAXONOMY_tokens + TAXONOMY_CODE_tokens + MEDICAID_NUMBER_tokens + VENDOR_ID_tokens;
  all_tokens := SALT30.fn_process_multitokens(all_tokens0);
EXPORT TokenKeyName := '~'+'key::HealthCareFacilityHeader::LNPID::Token::TokenKey';
EXPORT TokenKey := INDEX(all_tokens,{UNSIGNED4 TokenHash := HASH32(TokenValue),TokenType},{all_tokens},TokenKeyName);
EXPORT MultiTokenKeyName := '~'+'key::HealthCareFacilityHeader::LNPID::Token::MultiTokenKey';
EXPORT MultiTokenKey := INDEX(all_tokens0(SALT30.WordCount(TokenValue)>1),{UNSIGNED4 TokenHash := HASH32(TokenValue),TokenType},{all_tokens0},MultiTokenKeyName);
  FAC_NAME_tokens := PROJECT(specificities(h).FAC_NAME_values_persisted,TRANSFORM(SALT30.Layout_Classify_Concept,SELF.ConceptHash := LEFT.FAC_NAME; SELF.TokenType := 33; SELF.Spc := LEFT.field_Specificity ));
  ADDR1_tokens := PROJECT(specificities(h).ADDR1_values_persisted,TRANSFORM(SALT30.Layout_Classify_Concept,SELF.ConceptHash := LEFT.ADDR1; SELF.TokenType := 34; SELF.Spc := LEFT.field_Specificity ));
  LOCALE_tokens := PROJECT(specificities(h).LOCALE_values_persisted,TRANSFORM(SALT30.Layout_Classify_Concept,SELF.ConceptHash := LEFT.LOCALE; SELF.TokenType := 35; SELF.Spc := LEFT.field_Specificity ));
  ADDRESS_tokens := PROJECT(specificities(h).ADDRESS_values_persisted,TRANSFORM(SALT30.Layout_Classify_Concept,SELF.ConceptHash := LEFT.ADDRESS; SELF.TokenType := 36; SELF.Spc := LEFT.field_Specificity ));
all_tokens1 := FAC_NAME_tokens + ADDR1_tokens + LOCALE_tokens + ADDRESS_tokens;
EXPORT ConceptKeyName := '~'+'key::HealthCareFacilityHeader::LNPID::Token::ConceptKey';
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
    REAL Field_Specificity;
    UNSIGNED Cnt;
  END;
  FAC_NAME_filled_rec := RECORD
    boolean CNP_NAME_filled :=(SALT30.StrType)ih.CNP_NAME != '';
    boolean CNP_NUMBER_filled :=(SALT30.StrType)ih.CNP_NUMBER != '';
    boolean CNP_STORE_NUMBER_filled :=(SALT30.StrType)ih.CNP_STORE_NUMBER != '';
    boolean CNP_BTYPE_filled :=(SALT30.StrType)ih.CNP_BTYPE != '';
  END;
  t := table(ih,FAC_NAME_filled_rec);
  FAC_NAME_filled_rec_totals := RECORD
    UNSIGNED2 TokenType := 33;
    t.CNP_NAME_filled;
    t.CNP_NUMBER_filled;
    t.CNP_STORE_NUMBER_filled;
    t.CNP_BTYPE_filled;
    UNSIGNED Cnt := COUNT(GROUP);
  END;
  t_tot := table(t,FAC_NAME_filled_rec_totals,CNP_NAME_filled,CNP_NUMBER_filled,CNP_STORE_NUMBER_filled,CNP_BTYPE_filled,few);
  SALT30.MAC_Field_Specificities(t_tot,o_tot);
shared FAC_NAME_combinations := o_tot;
  Layout_ConceptTemplate Into(FAC_NAME_combinations le) := TRANSFORM
    SELF.FieldNumber1 := MAP ( le.CNP_NAME_filled => 12, le.CNP_NUMBER_filled => 13, le.CNP_STORE_NUMBER_filled => 14, le.CNP_BTYPE_filled => 15,0);
    SELF.FieldNumber2 := MAP ( le.CNP_NUMBER_filled AND SELF.FieldNumber1 != 13 => 13, le.CNP_STORE_NUMBER_filled AND SELF.FieldNumber1 != 14 => 14, le.CNP_BTYPE_filled AND SELF.FieldNumber1 != 15 => 15,0);
    SELF.FieldNumber3 := MAP ( le.CNP_STORE_NUMBER_filled AND SELF.FieldNumber1 != 14 AND SELF.FieldNumber2 != 14 => 14, le.CNP_BTYPE_filled AND SELF.FieldNumber1 != 15 AND SELF.FieldNumber2 != 15 => 15,0);
    SELF.FieldNumber4 := MAP ( le.CNP_BTYPE_filled AND SELF.FieldNumber1 != 15 AND SELF.FieldNumber2 != 15 AND SELF.FieldNumber3 != 15 => 15,0);
    SELF := le;
  END;
shared FAC_NAME_templates := project(FAC_NAME_combinations,Into(LEFT));
  ADDR1_filled_rec := RECORD
    boolean PRIM_RANGE_filled :=(SALT30.StrType)ih.PRIM_RANGE != '';
    boolean PRIM_NAME_filled :=(SALT30.StrType)ih.PRIM_NAME != '';
    boolean SEC_RANGE_filled :=(SALT30.StrType)ih.SEC_RANGE != '';
  END;
  t := table(ih,ADDR1_filled_rec);
  ADDR1_filled_rec_totals := RECORD
    UNSIGNED2 TokenType := 34;
    t.PRIM_RANGE_filled;
    t.PRIM_NAME_filled;
    t.SEC_RANGE_filled;
    UNSIGNED Cnt := COUNT(GROUP);
  END;
  t_tot := table(t,ADDR1_filled_rec_totals,PRIM_RANGE_filled,PRIM_NAME_filled,SEC_RANGE_filled,few);
  SALT30.MAC_Field_Specificities(t_tot,o_tot);
shared ADDR1_combinations := o_tot;
  Layout_ConceptTemplate Into(ADDR1_combinations le) := TRANSFORM
    SELF.FieldNumber1 := MAP ( le.PRIM_RANGE_filled => 21, le.PRIM_NAME_filled => 22, le.SEC_RANGE_filled => 23,0);
    SELF.FieldNumber2 := MAP ( le.PRIM_NAME_filled AND SELF.FieldNumber1 != 22 => 22, le.SEC_RANGE_filled AND SELF.FieldNumber1 != 23 => 23,0);
    SELF.FieldNumber3 := MAP ( le.SEC_RANGE_filled AND SELF.FieldNumber1 != 23 AND SELF.FieldNumber2 != 23 => 23,0);
    SELF := le;
  END;
shared ADDR1_templates := project(ADDR1_combinations,Into(LEFT));
  LOCALE_filled_rec := RECORD
    boolean V_CITY_NAME_filled :=(SALT30.StrType)ih.V_CITY_NAME != '';
    boolean ST_filled :=(SALT30.StrType)ih.ST != '';
    boolean ZIP_filled :=(SALT30.StrType)ih.ZIP != '';
  END;
  t := table(ih,LOCALE_filled_rec);
  LOCALE_filled_rec_totals := RECORD
    UNSIGNED2 TokenType := 35;
    t.V_CITY_NAME_filled;
    t.ST_filled;
    t.ZIP_filled;
    UNSIGNED Cnt := COUNT(GROUP);
  END;
  t_tot := table(t,LOCALE_filled_rec_totals,V_CITY_NAME_filled,ST_filled,ZIP_filled,few);
  SALT30.MAC_Field_Specificities(t_tot,o_tot);
shared LOCALE_combinations := o_tot;
  Layout_ConceptTemplate Into(LOCALE_combinations le) := TRANSFORM
    SELF.FieldNumber1 := MAP ( le.V_CITY_NAME_filled => 25, le.ST_filled => 24, le.ZIP_filled => 26,0);
    SELF.FieldNumber2 := MAP ( le.ST_filled AND SELF.FieldNumber1 != 24 => 24, le.ZIP_filled AND SELF.FieldNumber1 != 26 => 26,0);
    SELF.FieldNumber3 := MAP ( le.ZIP_filled AND SELF.FieldNumber1 != 26 AND SELF.FieldNumber2 != 26 => 26,0);
    SELF := le;
  END;
shared LOCALE_templates := project(LOCALE_combinations,Into(LEFT));
  ADDRESS_filled_rec := RECORD
    boolean ADDR1_filled :=~((SALT30.StrType)ih.PRIM_RANGE = '' AND (SALT30.StrType)ih.PRIM_NAME = '' AND (SALT30.StrType)ih.SEC_RANGE = '');
    boolean LOCALE_filled :=~((SALT30.StrType)ih.V_CITY_NAME = '' AND (SALT30.StrType)ih.ST = '' AND (SALT30.StrType)ih.ZIP = '');
  END;
  t := table(ih,ADDRESS_filled_rec);
  ADDRESS_filled_rec_totals := RECORD
    UNSIGNED2 TokenType := 36;
    t.ADDR1_filled;
    t.LOCALE_filled;
    UNSIGNED Cnt := COUNT(GROUP);
  END;
  t_tot := table(t,ADDRESS_filled_rec_totals,ADDR1_filled,LOCALE_filled,few);
  SALT30.MAC_Field_Specificities(t_tot,o_tot);
shared ADDRESS_combinations := o_tot;
  Layout_ConceptTemplate Into(ADDRESS_combinations le) := TRANSFORM
    SELF.FieldNumber1 := MAP ( le.ADDR1_filled => 34, le.LOCALE_filled => 35,0);
    SELF.FieldNumber2 := MAP ( le.LOCALE_filled AND SELF.FieldNumber1 != 35 => 35,0);
    SELF := le;
  END;
shared ADDRESS_templates := project(ADDRESS_combinations,Into(LEFT));
all_templates := FAC_NAME_templates + ADDR1_templates + LOCALE_templates + ADDRESS_templates;
EXPORT ConceptTemplatesKey := '~'+'key::HealthCareFacilityHeader::LNPID::Token::ConceptKey';
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
  SALT30.StrType Txt := '';
  END;
  Layout_Template_Hypothesis NotePossibles(Classified le,ConceptTemplateKey ri) := TRANSFORM
    SELF.Len := IF(ri.FieldNumber1=0,0,1)+IF(ri.FieldNumber2=0,0,1)+IF(ri.FieldNumber3=0,0,1)+IF(ri.FieldNumber4=0,0,1);
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
  AP0 := (J1+J2+J3+J4)(Confirmed);
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
