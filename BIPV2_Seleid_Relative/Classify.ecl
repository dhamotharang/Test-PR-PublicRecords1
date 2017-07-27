IMPORT ut,SALT30;
// This module is to the field values what the fields module is to the field itself
// It really exists to answer the question: does a token with these characters logically belong in this field?
// This module should be viewed as experimental
EXPORT Classify(DATASET(layout_Base) h) := MODULE
 
// Most of the data we need for the classification exists in the specificities module - collect and convert
SHARED TotalClusters := specificities(h).TotalClusters;
  cnp_name_tokens := PROJECT(specificities(h).cnp_name_values_persisted,TRANSFORM(SALT30.Layout_Classify_Token,SELF.TokenValue := (SALT30.StrType)LEFT.cnp_name; SELF.TokenType := 1; SELF.Spc := LEFT.field_Specificity ));
  company_inc_state_tokens := PROJECT(specificities(h).company_inc_state_values_persisted,TRANSFORM(SALT30.Layout_Classify_Token,SELF.TokenValue := (SALT30.StrType)LEFT.company_inc_state; SELF.TokenType := 2; SELF.Spc := LEFT.field_Specificity ));
  company_charter_number_tokens := PROJECT(specificities(h).company_charter_number_values_persisted,TRANSFORM(SALT30.Layout_Classify_Token,SELF.TokenValue := (SALT30.StrType)LEFT.company_charter_number; SELF.TokenType := 3; SELF.Spc := LEFT.field_Specificity ));
  company_fein_tokens := PROJECT(specificities(h).company_fein_values_persisted,TRANSFORM(SALT30.Layout_Classify_Token,SELF.TokenValue := (SALT30.StrType)LEFT.company_fein; SELF.TokenType := 4; SELF.Spc := LEFT.field_Specificity ));
  prim_range_tokens := PROJECT(specificities(h).prim_range_values_persisted,TRANSFORM(SALT30.Layout_Classify_Token,SELF.TokenValue := (SALT30.StrType)LEFT.prim_range; SELF.TokenType := 5; SELF.Spc := LEFT.field_Specificity ));
  prim_name_tokens := PROJECT(specificities(h).prim_name_values_persisted,TRANSFORM(SALT30.Layout_Classify_Token,SELF.TokenValue := (SALT30.StrType)LEFT.prim_name; SELF.TokenType := 6; SELF.Spc := LEFT.field_Specificity ));
  postdir_tokens := PROJECT(specificities(h).postdir_values_persisted,TRANSFORM(SALT30.Layout_Classify_Token,SELF.TokenValue := (SALT30.StrType)LEFT.postdir; SELF.TokenType := 7; SELF.Spc := LEFT.field_Specificity ));
  sec_range_tokens := PROJECT(specificities(h).sec_range_values_persisted,TRANSFORM(SALT30.Layout_Classify_Token,SELF.TokenValue := (SALT30.StrType)LEFT.sec_range; SELF.TokenType := 9; SELF.Spc := LEFT.field_Specificity ));
  v_city_name_tokens := PROJECT(specificities(h).v_city_name_values_persisted,TRANSFORM(SALT30.Layout_Classify_Token,SELF.TokenValue := (SALT30.StrType)LEFT.v_city_name; SELF.TokenType := 10; SELF.Spc := LEFT.field_Specificity ));
  st_tokens := PROJECT(specificities(h).st_values_persisted,TRANSFORM(SALT30.Layout_Classify_Token,SELF.TokenValue := (SALT30.StrType)LEFT.st; SELF.TokenType := 11; SELF.Spc := LEFT.field_Specificity ));
  active_duns_number_tokens := PROJECT(specificities(h).active_duns_number_values_persisted,TRANSFORM(SALT30.Layout_Classify_Token,SELF.TokenValue := (SALT30.StrType)LEFT.active_duns_number; SELF.TokenType := 12; SELF.Spc := LEFT.field_Specificity ));
  active_enterprise_number_tokens := PROJECT(specificities(h).active_enterprise_number_values_persisted,TRANSFORM(SALT30.Layout_Classify_Token,SELF.TokenValue := (SALT30.StrType)LEFT.active_enterprise_number; SELF.TokenType := 13; SELF.Spc := LEFT.field_Specificity ));
  source_tokens := PROJECT(specificities(h).source_values_persisted,TRANSFORM(SALT30.Layout_Classify_Token,SELF.TokenValue := (SALT30.StrType)LEFT.source; SELF.TokenType := 14; SELF.Spc := LEFT.field_Specificity ));
  source_record_id_tokens := PROJECT(specificities(h).source_record_id_values_persisted,TRANSFORM(SALT30.Layout_Classify_Token,SELF.TokenValue := (SALT30.StrType)LEFT.source_record_id; SELF.TokenType := 15; SELF.Spc := LEFT.field_Specificity ));
  fname_tokens := PROJECT(specificities(h).fname_values_persisted,TRANSFORM(SALT30.Layout_Classify_Token,SELF.TokenValue := (SALT30.StrType)LEFT.fname; SELF.TokenType := 16; SELF.Spc := LEFT.field_Specificity ));
  mname_tokens := PROJECT(specificities(h).mname_values_persisted,TRANSFORM(SALT30.Layout_Classify_Token,SELF.TokenValue := (SALT30.StrType)LEFT.mname; SELF.TokenType := 17; SELF.Spc := LEFT.field_Specificity ));
  lname_tokens := PROJECT(specificities(h).lname_values_persisted,TRANSFORM(SALT30.Layout_Classify_Token,SELF.TokenValue := (SALT30.StrType)LEFT.lname; SELF.TokenType := 18; SELF.Spc := LEFT.field_Specificity ));
  contact_ssn_tokens := PROJECT(specificities(h).contact_ssn_values_persisted,TRANSFORM(SALT30.Layout_Classify_Token,SELF.TokenValue := (SALT30.StrType)LEFT.contact_ssn; SELF.TokenType := 19; SELF.Spc := LEFT.field_Specificity ));
  contact_phone_tokens := PROJECT(specificities(h).contact_phone_values_persisted,TRANSFORM(SALT30.Layout_Classify_Token,SELF.TokenValue := (SALT30.StrType)LEFT.contact_phone; SELF.TokenType := 20; SELF.Spc := LEFT.field_Specificity ));
  contact_email_username_tokens := PROJECT(specificities(h).contact_email_username_values_persisted,TRANSFORM(SALT30.Layout_Classify_Token,SELF.TokenValue := (SALT30.StrType)LEFT.contact_email_username; SELF.TokenType := 22; SELF.Spc := LEFT.field_Specificity ));
SHARED all_tokens0 := cnp_name_tokens + company_inc_state_tokens + company_charter_number_tokens + company_fein_tokens + prim_range_tokens + prim_name_tokens + postdir_tokens + sec_range_tokens + v_city_name_tokens + st_tokens + active_duns_number_tokens + active_enterprise_number_tokens + source_tokens + source_record_id_tokens + fname_tokens + mname_tokens + lname_tokens + contact_ssn_tokens + contact_phone_tokens + contact_email_username_tokens;
  all_tokens := SALT30.fn_process_multitokens(all_tokens0);
 
EXPORT TokenKeyName := '~'+'key::BIPV2_Seleid_Relative::Seleid::Token::TokenKey';
 
EXPORT TokenKey := INDEX(all_tokens,{UNSIGNED4 TokenHash := HASH32(TokenValue),TokenType},{all_tokens},TokenKeyName);
 
EXPORT MultiTokenKeyName := '~'+'key::BIPV2_Seleid_Relative::Seleid::Token::MultiTokenKey';
 
EXPORT MultiTokenKey := INDEX(all_tokens0(SALT30.WordCount(TokenValue)>1),{UNSIGNED4 TokenHash := HASH32(TokenValue),TokenType},{all_tokens0},MultiTokenKeyName);
// Now compute the patterns of filled in field values for the various concept fields
SHARED s := specificities(h).specificities;
SHARED ih := specificities(h).input_file;
 
EXPORT Build := PARALLEL(BUILDINDEX(ASSOC, OVERWRITE),BUILDINDEX(TokenKey, OVERWRITE),BUILDINDEX(MultiTokenKey, OVERWRITE));
 
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
 
EXPORT StreamClassify(SALT30.StrType s) := FUNCTION
  NWords := SALT30.WordCount(s);
  EmptyStart := dataset([],SALT30.Layout_Classify_Hypothesis);
  AH := LOOP(EmptyStart,NWords,SALT30.fn_next_working_hypothesis( ROWS(LEFT),TokenClassify_Raw(SALT30.GetNthWord(s,COUNTER)),COUNTER,Nwords) );
  DD := StreamVerify(s,AH);
  DH := SALT30.fn_classify_dedup_hypothesis(DD,TRUE);
  RETURN SORT(DH,SPC,-Len);
END;
 
EXPORT PrettyStreamClassify(SALT30.StrType s) := SALT30.fn_pretty_hypothesis(s,StreamClassify(s),Fields.FieldName);
END;
