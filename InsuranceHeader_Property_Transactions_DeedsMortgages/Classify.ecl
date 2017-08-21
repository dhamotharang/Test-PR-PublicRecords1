IMPORT ut,SALT34;
// This module is to the field values what the fields module is to the field itself
// It really exists to answer the question: does a token with these characters logically belong in this field?
// This module should be viewed as experimental
EXPORT Classify(DATASET(layout_PROPERTY_TRANSACTION) h) := MODULE
// Most of the data we need for the classification exists in the specificities module - collect and convert
SHARED TotalClusters := specificities(h).TotalClusters;
  recording_date_tokens := PROJECT(specificities(h).recording_date_values_persisted,TRANSFORM(SALT34.Layout_Classify_Token,SELF.TokenValue := (SALT34.StrType)LEFT.recording_date; SELF.TokenType := 1; SELF.Spc := LEFT.field_Specificity ));
  SourceType_tokens := PROJECT(specificities(h).SourceType_values_persisted,TRANSFORM(SALT34.Layout_Classify_Token,SELF.TokenValue := (SALT34.StrType)LEFT.SourceType; SELF.TokenType := 2; SELF.Spc := LEFT.field_Specificity ));
  did_tokens := PROJECT(specificities(h).did_values_persisted,TRANSFORM(SALT34.Layout_Classify_Token,SELF.TokenValue := (SALT34.StrType)LEFT.did; SELF.TokenType := 3; SELF.Spc := LEFT.field_Specificity ));
  apnt_or_pin_number_tokens := PROJECT(specificities(h).apnt_or_pin_number_values_persisted,TRANSFORM(SALT34.Layout_Classify_Token,SELF.TokenValue := (SALT34.StrType)LEFT.apnt_or_pin_number; SELF.TokenType := 4; SELF.Spc := LEFT.field_Specificity ));
  recorder_book_number_tokens := PROJECT(specificities(h).recorder_book_number_values_persisted,TRANSFORM(SALT34.Layout_Classify_Token,SELF.TokenValue := (SALT34.StrType)LEFT.recorder_book_number; SELF.TokenType := 5; SELF.Spc := LEFT.field_Specificity ));
  zip_tokens := PROJECT(specificities(h).zip_values_persisted,TRANSFORM(SALT34.Layout_Classify_Token,SELF.TokenValue := (SALT34.StrType)LEFT.zip; SELF.TokenType := 7; SELF.Spc := LEFT.field_Specificity ));
  sales_price_tokens := PROJECT(specificities(h).sales_price_values_persisted,TRANSFORM(SALT34.Layout_Classify_Token,SELF.TokenValue := (SALT34.StrType)LEFT.sales_price; SELF.TokenType := 8; SELF.Spc := LEFT.field_Specificity ));
  first_td_loan_amount_tokens := PROJECT(specificities(h).first_td_loan_amount_values_persisted,TRANSFORM(SALT34.Layout_Classify_Token,SELF.TokenValue := (SALT34.StrType)LEFT.first_td_loan_amount; SELF.TokenType := 9; SELF.Spc := LEFT.field_Specificity ));
  contract_date_tokens := PROJECT(specificities(h).contract_date_values_persisted,TRANSFORM(SALT34.Layout_Classify_Token,SELF.TokenValue := (SALT34.StrType)LEFT.contract_date; SELF.TokenType := 12; SELF.Spc := LEFT.field_Specificity ));
  document_number_tokens := PROJECT(specificities(h).document_number_values_persisted,TRANSFORM(SALT34.Layout_Classify_Token,SELF.TokenValue := (SALT34.StrType)LEFT.document_number; SELF.TokenType := 13; SELF.Spc := LEFT.field_Specificity ));
  recorder_page_number_tokens := PROJECT(specificities(h).recorder_page_number_values_persisted,TRANSFORM(SALT34.Layout_Classify_Token,SELF.TokenValue := (SALT34.StrType)LEFT.recorder_page_number; SELF.TokenType := 14; SELF.Spc := LEFT.field_Specificity ));
  prim_range_alpha_tokens := PROJECT(specificities(h).prim_range_alpha_values_persisted,TRANSFORM(SALT34.Layout_Classify_Token,SELF.TokenValue := (SALT34.StrType)LEFT.prim_range_alpha; SELF.TokenType := 15; SELF.Spc := LEFT.field_Specificity ));
  sec_range_alpha_tokens := PROJECT(specificities(h).sec_range_alpha_values_persisted,TRANSFORM(SALT34.Layout_Classify_Token,SELF.TokenValue := (SALT34.StrType)LEFT.sec_range_alpha; SELF.TokenType := 16; SELF.Spc := LEFT.field_Specificity ));
  name_tokens := PROJECT(specificities(h).name_values_persisted,TRANSFORM(SALT34.Layout_Classify_Token,SELF.TokenValue := (SALT34.StrType)LEFT.name; SELF.TokenType := 17; SELF.Spc := LEFT.field_Specificity ));
  prim_name_num_tokens := PROJECT(specificities(h).prim_name_num_values_persisted,TRANSFORM(SALT34.Layout_Classify_Token,SELF.TokenValue := (SALT34.StrType)LEFT.prim_name_num; SELF.TokenType := 18; SELF.Spc := LEFT.field_Specificity ));
  prim_name_alpha_tokens := PROJECT(specificities(h).prim_name_alpha_values_persisted,TRANSFORM(SALT34.Layout_Classify_Token,SELF.TokenValue := (SALT34.StrType)LEFT.prim_name_alpha; SELF.TokenType := 19; SELF.Spc := LEFT.field_Specificity ));
  sec_range_num_tokens := PROJECT(specificities(h).sec_range_num_values_persisted,TRANSFORM(SALT34.Layout_Classify_Token,SELF.TokenValue := (SALT34.StrType)LEFT.sec_range_num; SELF.TokenType := 20; SELF.Spc := LEFT.field_Specificity ));
  fips_code_tokens := PROJECT(specificities(h).fips_code_values_persisted,TRANSFORM(SALT34.Layout_Classify_Token,SELF.TokenValue := (SALT34.StrType)LEFT.fips_code; SELF.TokenType := 21; SELF.Spc := LEFT.field_Specificity ));
  county_name_tokens := PROJECT(specificities(h).county_name_values_persisted,TRANSFORM(SALT34.Layout_Classify_Token,SELF.TokenValue := (SALT34.StrType)LEFT.county_name; SELF.TokenType := 22; SELF.Spc := LEFT.field_Specificity ));
  lender_name_tokens := PROJECT(specificities(h).lender_name_values_persisted,TRANSFORM(SALT34.Layout_Classify_Token,SELF.TokenValue := (SALT34.StrType)LEFT.lender_name; SELF.TokenType := 23; SELF.Spc := LEFT.field_Specificity ));
  prim_range_num_tokens := PROJECT(specificities(h).prim_range_num_values_persisted,TRANSFORM(SALT34.Layout_Classify_Token,SELF.TokenValue := (SALT34.StrType)LEFT.prim_range_num; SELF.TokenType := 24; SELF.Spc := LEFT.field_Specificity ));
  city_tokens := PROJECT(specificities(h).city_values_persisted,TRANSFORM(SALT34.Layout_Classify_Token,SELF.TokenValue := (SALT34.StrType)LEFT.city; SELF.TokenType := 25; SELF.Spc := LEFT.field_Specificity ));
  st_tokens := PROJECT(specificities(h).st_values_persisted,TRANSFORM(SALT34.Layout_Classify_Token,SELF.TokenValue := (SALT34.StrType)LEFT.st; SELF.TokenType := 26; SELF.Spc := LEFT.field_Specificity ));
SHARED all_tokens0 := recording_date_tokens + SourceType_tokens + did_tokens + apnt_or_pin_number_tokens + recorder_book_number_tokens + zip_tokens + sales_price_tokens + first_td_loan_amount_tokens + contract_date_tokens + document_number_tokens + recorder_page_number_tokens + prim_range_alpha_tokens + sec_range_alpha_tokens + name_tokens + prim_name_num_tokens + prim_name_alpha_tokens + sec_range_num_tokens + fips_code_tokens + county_name_tokens + lender_name_tokens + prim_range_num_tokens + city_tokens + st_tokens;
SHARED all_tokens := SALT34.fn_process_multitokens(all_tokens0);
EXPORT TokenKeyName := '~'+'key::InsuranceHeader_Property_Transactions_DeedsMortgages::DPROPTXID::Token::TokenKey';
EXPORT TokenKey := INDEX(all_tokens,{UNSIGNED4 TokenHash := HASH32(TokenValue),TokenType},{all_tokens},TokenKeyName);
EXPORT MultiTokenKeyName := '~'+'key::InsuranceHeader_Property_Transactions_DeedsMortgages::DPROPTXID::Token::MultiTokenKey';
EXPORT MultiTokenKey := INDEX(all_tokens0(SALT34.WordCount(TokenValue)>1),{UNSIGNED4 TokenHash := HASH32(TokenValue),TokenType},{all_tokens0},MultiTokenKeyName);
  primname_tokens := PROJECT(specificities(h).primname_values_persisted,TRANSFORM(SALT34.Layout_Classify_Concept,SELF.ConceptHash := LEFT.primname; SELF.TokenType := 6; SELF.Spc := LEFT.field_Specificity ));
  primrange_tokens := PROJECT(specificities(h).primrange_values_persisted,TRANSFORM(SALT34.Layout_Classify_Concept,SELF.ConceptHash := LEFT.primrange; SELF.TokenType := 10; SELF.Spc := LEFT.field_Specificity ));
  secrange_tokens := PROJECT(specificities(h).secrange_values_persisted,TRANSFORM(SALT34.Layout_Classify_Concept,SELF.ConceptHash := LEFT.secrange; SELF.TokenType := 11; SELF.Spc := LEFT.field_Specificity ));
  locale_tokens := PROJECT(specificities(h).locale_values_persisted,TRANSFORM(SALT34.Layout_Classify_Concept,SELF.ConceptHash := LEFT.locale; SELF.TokenType := 32; SELF.Spc := LEFT.field_Specificity ));
  address_tokens := PROJECT(specificities(h).address_values_persisted,TRANSFORM(SALT34.Layout_Classify_Concept,SELF.ConceptHash := LEFT.address; SELF.TokenType := 33; SELF.Spc := LEFT.field_Specificity ));
SHARED all_tokens1 := primname_tokens + primrange_tokens + secrange_tokens + locale_tokens + address_tokens;
EXPORT ConceptKeyName := '~'+'key::InsuranceHeader_Property_Transactions_DeedsMortgages::DPROPTXID::Token::ConceptKey';
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
  primname_filled_rec := RECORD
    boolean prim_name_alpha_filled :=(SALT34.StrType)ih.prim_name_alpha != '';
    boolean prim_name_num_filled :=(SALT34.StrType)ih.prim_name_num != '';
  END;
  t := table(ih,primname_filled_rec);
  primname_filled_rec_totals := RECORD
    UNSIGNED2 TokenType := 6;
    t.prim_name_alpha_filled;
    t.prim_name_num_filled;
    UNSIGNED Cnt := COUNT(GROUP);
  END;
  t_tot := table(t,primname_filled_rec_totals,prim_name_alpha_filled,prim_name_num_filled,few);
  SALT34.MAC_Field_Specificities(t_tot,o_tot);
shared primname_combinations := o_tot;
  Layout_ConceptTemplate Into(primname_combinations le) := TRANSFORM
    SELF.FieldNumber1 := MAP ( le.prim_name_alpha_filled => 19, le.prim_name_num_filled => 18,0);
    SELF.FieldNumber2 := MAP ( le.prim_name_num_filled AND SELF.FieldNumber1 != 18 => 18,0);
    SELF := le;
  END;
shared primname_templates := project(primname_combinations,Into(LEFT));
  primrange_filled_rec := RECORD
    boolean prim_range_alpha_filled :=(SALT34.StrType)ih.prim_range_alpha != '';
    boolean prim_range_num_filled :=(SALT34.StrType)ih.prim_range_num != '';
  END;
  t := table(ih,primrange_filled_rec);
  primrange_filled_rec_totals := RECORD
    UNSIGNED2 TokenType := 10;
    t.prim_range_alpha_filled;
    t.prim_range_num_filled;
    UNSIGNED Cnt := COUNT(GROUP);
  END;
  t_tot := table(t,primrange_filled_rec_totals,prim_range_alpha_filled,prim_range_num_filled,few);
  SALT34.MAC_Field_Specificities(t_tot,o_tot);
shared primrange_combinations := o_tot;
  Layout_ConceptTemplate Into(primrange_combinations le) := TRANSFORM
    SELF.FieldNumber1 := MAP ( le.prim_range_alpha_filled => 15, le.prim_range_num_filled => 24,0);
    SELF.FieldNumber2 := MAP ( le.prim_range_num_filled AND SELF.FieldNumber1 != 24 => 24,0);
    SELF := le;
  END;
shared primrange_templates := project(primrange_combinations,Into(LEFT));
  secrange_filled_rec := RECORD
    boolean sec_range_alpha_filled :=(SALT34.StrType)ih.sec_range_alpha != '';
    boolean sec_range_num_filled :=(SALT34.StrType)ih.sec_range_num != '';
  END;
  t := table(ih,secrange_filled_rec);
  secrange_filled_rec_totals := RECORD
    UNSIGNED2 TokenType := 11;
    t.sec_range_alpha_filled;
    t.sec_range_num_filled;
    UNSIGNED Cnt := COUNT(GROUP);
  END;
  t_tot := table(t,secrange_filled_rec_totals,sec_range_alpha_filled,sec_range_num_filled,few);
  SALT34.MAC_Field_Specificities(t_tot,o_tot);
shared secrange_combinations := o_tot;
  Layout_ConceptTemplate Into(secrange_combinations le) := TRANSFORM
    SELF.FieldNumber1 := MAP ( le.sec_range_alpha_filled => 16, le.sec_range_num_filled => 20,0);
    SELF.FieldNumber2 := MAP ( le.sec_range_num_filled AND SELF.FieldNumber1 != 20 => 20,0);
    SELF := le;
  END;
shared secrange_templates := project(secrange_combinations,Into(LEFT));
  locale_filled_rec := RECORD
    boolean city_filled :=(SALT34.StrType)ih.city != '';
    boolean st_filled :=(SALT34.StrType)ih.st != '';
    boolean zip_filled :=(SALT34.StrType)ih.zip != '';
  END;
  t := table(ih,locale_filled_rec);
  locale_filled_rec_totals := RECORD
    UNSIGNED2 TokenType := 32;
    t.city_filled;
    t.st_filled;
    t.zip_filled;
    UNSIGNED Cnt := COUNT(GROUP);
  END;
  t_tot := table(t,locale_filled_rec_totals,city_filled,st_filled,zip_filled,few);
  SALT34.MAC_Field_Specificities(t_tot,o_tot);
shared locale_combinations := o_tot;
  Layout_ConceptTemplate Into(locale_combinations le) := TRANSFORM
    SELF.FieldNumber1 := MAP ( le.city_filled => 25, le.st_filled => 26, le.zip_filled => 7,0);
    SELF.FieldNumber2 := MAP ( le.st_filled AND SELF.FieldNumber1 != 26 => 26, le.zip_filled AND SELF.FieldNumber1 != 7 => 7,0);
    SELF.FieldNumber3 := MAP ( le.zip_filled AND SELF.FieldNumber1 != 7 AND SELF.FieldNumber2 != 7 => 7,0);
    SELF := le;
  END;
shared locale_templates := project(locale_combinations,Into(LEFT));
  address_filled_rec := RECORD
    boolean primrange_filled :=~((SALT34.StrType)ih.prim_range_alpha = '' AND (SALT34.StrType)ih.prim_range_num = '');
    boolean primname_filled :=~((SALT34.StrType)ih.prim_name_alpha = '' AND (SALT34.StrType)ih.prim_name_num = '');
    boolean secrange_filled :=~((SALT34.StrType)ih.sec_range_alpha = '' AND (SALT34.StrType)ih.sec_range_num = '');
    boolean locale_filled :=~((SALT34.StrType)ih.city = '' AND (SALT34.StrType)ih.st = '' AND (SALT34.StrType)ih.zip = '');
  END;
  t := table(ih,address_filled_rec);
  address_filled_rec_totals := RECORD
    UNSIGNED2 TokenType := 33;
    t.primrange_filled;
    t.primname_filled;
    t.secrange_filled;
    t.locale_filled;
    UNSIGNED Cnt := COUNT(GROUP);
  END;
  t_tot := table(t,address_filled_rec_totals,primrange_filled,primname_filled,secrange_filled,locale_filled,few);
  SALT34.MAC_Field_Specificities(t_tot,o_tot);
shared address_combinations := o_tot;
  Layout_ConceptTemplate Into(address_combinations le) := TRANSFORM
    SELF.FieldNumber1 := MAP ( le.primrange_filled => 10, le.primname_filled => 6, le.secrange_filled => 11, le.locale_filled => 32,0);
    SELF.FieldNumber2 := MAP ( le.primname_filled AND SELF.FieldNumber1 != 6 => 6, le.secrange_filled AND SELF.FieldNumber1 != 11 => 11, le.locale_filled AND SELF.FieldNumber1 != 32 => 32,0);
    SELF.FieldNumber3 := MAP ( le.secrange_filled AND SELF.FieldNumber1 != 11 AND SELF.FieldNumber2 != 11 => 11, le.locale_filled AND SELF.FieldNumber1 != 32 AND SELF.FieldNumber2 != 32 => 32,0);
    SELF.FieldNumber4 := MAP ( le.locale_filled AND SELF.FieldNumber1 != 32 AND SELF.FieldNumber2 != 32 AND SELF.FieldNumber3 != 32 => 32,0);
    SELF := le;
  END;
shared address_templates := project(address_combinations,Into(LEFT));
SHARED all_templates := primname_templates + primrange_templates + secrange_templates + locale_templates + address_templates;
EXPORT ConceptTemplatesKey := '~'+'key::InsuranceHeader_Property_Transactions_DeedsMortgages::DPROPTXID::Token::ConceptTemplatesKey';
EXPORT ConceptTemplateKey := INDEX(all_templates,{FieldNumber1,TokenType},{all_templates},ConceptTemplatesKey);
EXPORT Build := PARALLEL(BUILDINDEX(TokenKey, OVERWRITE),BUILDINDEX(MultiTokenKey, OVERWRITE),BUILDINDEX(ConceptKey, OVERWRITE),BUILDINDEX(ConceptTemplateKey, OVERWRITE));
SHARED TokenClassify_Raw(SALT34.StrType s,SET OF UNSIGNED2 Poss=[]) := PROJECT( TokenKey(TokenHash=HASH32(s),TokenValue = s,Poss=[] OR TokenType IN Poss),TRANSFORM(SALT34.Layout_Classify_Token,SELF := LEFT) );
SHARED MultiTokenClassify_Raw(SALT34.StrType s) := PROJECT( MultiTokenKey(TokenHash=HASH32(s),TokenValue = s),TRANSFORM(SALT34.Layout_Classify_Token,SELF := LEFT) );
EXPORT TokenClassify(SALT34.StrType s) := SORT(TokenClassify_Raw(s),spc);
EXPORT FieldClassify(SALT34.StrType s,SET OF UNSIGNED2 Poss=[]) := FUNCTION
  NWords := SALT34.WordCount(s);
  AsData := DATASET([{s}],{SALT34.StrType s1;});
  SALT34.Layout_Classify_Working_Hypothesis FindParts(AsData le,UNSIGNED4 Posit) := TRANSFORM
    SELF.Cpos := Posit;
    SELF.Possibles := TokenClassify_Raw(SALT34.GetNthWord(le.s1,Posit),Poss)(TokenCount = NWords,Pos = Posit);
  END;
  RETURN SALT34.fn_combine_working_hypothesis( NORMALIZE(AsData,NWords,FindParts(LEFT,COUNTER)) );
END;
// Provide classification information for entire parse stream - ASAP
EXPORT ParseClassify(DATASET(SALT34.Layout_Parse_Raw) p) := FUNCTION
  sp := SALT34.fn_split_parsed(p); // Processing module for this parse stream
  cl := JOIN(sp.Words,TokenKey,HASH32(LEFT.tstring)=RIGHT.TokenHash AND LEFT.tstring=RIGHT.TokenValue,TRANSFORM(SALT34.layout_classify_token,SELF := RIGHT));
  rl := sp.Combine(cl); // Multi-tokens will now be together
  rl0 := rl(TokenCount=1);
  rl1 := rl(TokenCount>1);
  rl2 := JOIN(rl1,MultiTokenKey,RIGHT.TokenHash=HASH32(LEFT.TokenValue) AND RIGHT.TokenValue=LEFT.TokenValue AND LEFT.TokenType = RIGHT.TokenType,TRANSFORM(sp.r,SELF.Verified := LEFT.TokenValue=RIGHT.TokenValue,SELF := LEFT),LEFT OUTER);
  RETURN sp.JoinBack(rl0+rl2);
END;
EXPORT StreamVerify(SALT34.StrType s,DATASET(SALT34.Layout_Classify_Hypothesis) Classified) := FUNCTION
  // MORE - could try to get clever and combine fetches for different types of same multi-token
  SALT34.Layout_Classify_Hypothesis Confirm(Classified le) := TRANSFORM
    SELF.Confirmed := EXISTS ( MultiTokenClassify_Raw(SALT34.GetRangeOfWords(s,le.StartPos,le.Startpos+le.Len-1))(TokenType=le.TokenType));
    SELF := le;
  END;
  R := Classified(len=1) + PROJECT(Classified(len>1),Confirm(LEFT))(Confirmed);
  R0 := SALT34.fn_classify_dedup_hypothesis(R,TRUE);
  RETURN SORT(R,SPC,-Len);
END;
EXPORT StreamAnnotateConcepts(SALT34.StrType s,DATASET(SALT34.Layout_Classify_Hypothesis) Classified) := FUNCTION
// Now we need to look for concept-templates in the fields
  Layout_Template_Hypothesis := RECORD(SALT34.Layout_Classify_Hypothesis)
    UNSIGNED CPos; // Could be > StartPos+fieldno because of multi-token chars
    UNSIGNED2 FieldNumber1;
    UNSIGNED2 FieldNumber2;
    UNSIGNED2 FieldNumber3;
    UNSIGNED2 FieldNumber4;
  SALT34.StrType Txt := '';
  END;
  Layout_Template_Hypothesis NotePossibles(Classified le,ConceptTemplateKey ri) := TRANSFORM
    SELF.Len := IF(ri.FieldNumber1=0,0,1)+IF(ri.FieldNumber2=0,0,1)+IF(ri.FieldNumber3=0,0,1)+IF(ri.FieldNumber4=0,0,1);
    SELF.Spc := le.spc+ri.Field_Specificity;
    SELF.Confirmed := ri.FieldNumber2 = 0;
    SELF.CPos := le.StartPos+le.Len;
    SELF.Txt := SALT34.GetRangeOfWords(s,le.StartPos,le.StartPos+le.Len-1);
    SELF := ri;
    SELF := le;
  END;
  J1 := JOIN(Classified,ConceptTemplateKey,LEFT.TokenType=RIGHT.FieldNumber1,NotePossibles(LEFT,RIGHT))(Len>=2);
  Layout_Template_Hypothesis NextStep(Layout_Template_Hypothesis le,Classified ri,UNSIGNED1 step) := TRANSFORM
    SELF.Spc := le.spc+ri.spc;
    SELF.CPos := le.Cpos + ri.Len;
    SELF.Txt := le.Txt + SALT34.GetRangeOfWords(s,le.Cpos,le.Cpos+ri.len-1); // No spaces - to allow hashes to collide
    SELF.Confirmed := le.Len = step;
    SELF := le;
  END;
  J2 := JOIN(J1(~Confirmed),Classified,LEFT.FieldNumber2 = RIGHT.TokenType AND LEFT.Cpos = RIGHT.StartPos,NextStep(LEFT,RIGHT,2));
  J3 := JOIN(J2(~Confirmed),Classified,LEFT.FieldNumber3 = RIGHT.TokenType AND LEFT.Cpos = RIGHT.StartPos,NextStep(LEFT,RIGHT,3));
  J4 := JOIN(J3(~Confirmed),Classified,LEFT.FieldNumber4 = RIGHT.TokenType AND LEFT.Cpos = RIGHT.StartPos,NextStep(LEFT,RIGHT,4));
  AP0 := (J1+J2+J3+J4)(Confirmed);
  AP := JOIN(AP0,ConceptKey,HASH32(LEFT.Txt)=RIGHT.ConceptHash AND LEFT.TokenType=RIGHT.TokenType,TRANSFORM(Layout_Template_Hypothesis, SELF.Spc := RIGHT.Spc; SELF := LEFT));
  RETURN PROJECT(AP,TRANSFORM(SALT34.Layout_Classify_Hypothesis,SELF.Len := LEFT.Cpos-LEFT.StartPos; SELF.Spc := LEFT.SPC / SELF.Len; SELF := LEFT));
END;
EXPORT StreamClassify(SALT34.StrType s) := FUNCTION
  NWords := SALT34.WordCount(s);
  EmptyStart := dataset([],SALT34.Layout_Classify_Hypothesis);
  AH := LOOP(EmptyStart,NWords,SALT34.fn_next_working_hypothesis( ROWS(LEFT),TokenClassify_Raw(SALT34.GetNthWord(s,COUNTER)),COUNTER,Nwords) );
  DD := StreamVerify(s,AH);
  WC := DD+StreamAnnotateConcepts(s,DD);
  DH := SALT34.fn_classify_dedup_hypothesis(WC,TRUE);
  RETURN SORT(DH,SPC,-Len);
END;
EXPORT PrettyStreamClassify(SALT34.StrType s) := SALT34.fn_pretty_hypothesis(s,StreamClassify(s),Fields.FieldName);
END;
