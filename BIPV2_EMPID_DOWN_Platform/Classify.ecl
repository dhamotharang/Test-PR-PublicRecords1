IMPORT ut,SALT32;
// This module is to the field values what the fields module is to the field itself
// It really exists to answer the question: does a token with these characters logically belong in this field?
// This module should be viewed as experimental
EXPORT Classify(DATASET(layout_EmpID) h) := MODULE
 
// Most of the data we need for the classification exists in the specificities module - collect and convert
SHARED TotalClusters := specificities(h).TotalClusters;
  orgid_tokens := PROJECT(specificities(h).orgid_values_persisted,TRANSFORM(SALT32.Layout_Classify_Token,SELF.TokenValue := (SALT32.StrType)LEFT.orgid; SELF.TokenType := 2; SELF.Spc := LEFT.field_Specificity ));
  fname_tokens := PROJECT(specificities(h).fname_values_persisted,TRANSFORM(SALT32.Layout_Classify_Token,SELF.TokenValue := (SALT32.StrType)LEFT.fname; SELF.TokenType := 3; SELF.Spc := LEFT.field_Specificity ));
  mname_tokens := PROJECT(specificities(h).mname_values_persisted,TRANSFORM(SALT32.Layout_Classify_Token,SELF.TokenValue := (SALT32.StrType)LEFT.mname; SELF.TokenType := 4; SELF.Spc := LEFT.field_Specificity ));
  lname_tokens := PROJECT(specificities(h).lname_values_persisted,TRANSFORM(SALT32.Layout_Classify_Token,SELF.TokenValue := (SALT32.StrType)LEFT.lname; SELF.TokenType := 5; SELF.Spc := LEFT.field_Specificity ));
  name_suffix_tokens := PROJECT(specificities(h).name_suffix_values_persisted,TRANSFORM(SALT32.Layout_Classify_Token,SELF.TokenValue := (SALT32.StrType)LEFT.name_suffix; SELF.TokenType := 6; SELF.Spc := LEFT.field_Specificity ));
  contact_did_tokens := PROJECT(specificities(h).contact_did_values_persisted,TRANSFORM(SALT32.Layout_Classify_Token,SELF.TokenValue := (SALT32.StrType)LEFT.contact_did; SELF.TokenType := 7; SELF.Spc := LEFT.field_Specificity ));
  contact_ssn_tokens := PROJECT(specificities(h).contact_ssn_values_persisted,TRANSFORM(SALT32.Layout_Classify_Token,SELF.TokenValue := (SALT32.StrType)LEFT.contact_ssn; SELF.TokenType := 8; SELF.Spc := LEFT.field_Specificity ));
SHARED all_tokens0 := orgid_tokens + fname_tokens + mname_tokens + lname_tokens + name_suffix_tokens + contact_did_tokens + contact_ssn_tokens;
  all_tokens := SALT32.fn_process_multitokens(all_tokens0);
 
EXPORT TokenKeyName := '~'+'key::BIPV2_EMPID_DOWN_Platform::EmpID::Token::TokenKey';
 
EXPORT TokenKey := INDEX(all_tokens,{UNSIGNED4 TokenHash := HASH32(TokenValue),TokenType},{all_tokens},TokenKeyName);
 
EXPORT MultiTokenKeyName := '~'+'key::BIPV2_EMPID_DOWN_Platform::EmpID::Token::MultiTokenKey';
 
EXPORT MultiTokenKey := INDEX(all_tokens0(SALT32.WordCount(TokenValue)>1),{UNSIGNED4 TokenHash := HASH32(TokenValue),TokenType},{all_tokens0},MultiTokenKeyName);
// Now compute the patterns of filled in field values for the various concept fields
SHARED s := specificities(h).specificities;
SHARED ih := specificities(h).input_file;
 
EXPORT Build := PARALLEL(BUILDINDEX(TokenKey, OVERWRITE),BUILDINDEX(MultiTokenKey, OVERWRITE));
 
SHARED TokenClassify_Raw(SALT32.StrType s,SET OF UNSIGNED2 Poss=[]) := PROJECT( TokenKey(TokenHash=HASH32(s),TokenValue = s,Poss=[] OR TokenType IN Poss),TRANSFORM(SALT32.Layout_Classify_Token,SELF := LEFT) );
SHARED MultiTokenClassify_Raw(SALT32.StrType s) := PROJECT( MultiTokenKey(TokenHash=HASH32(s),TokenValue = s),TRANSFORM(SALT32.Layout_Classify_Token,SELF := LEFT) );
 
EXPORT TokenClassify(SALT32.StrType s) := SORT(TokenClassify_Raw(s),spc);
 
EXPORT FieldClassify(SALT32.StrType s,SET OF UNSIGNED2 Poss=[]) := FUNCTION
  NWords := SALT32.WordCount(s);
  AsData := DATASET([{s}],{SALT32.StrType s1;});
  SALT32.Layout_Classify_Working_Hypothesis FindParts(AsData le,UNSIGNED4 Posit) := TRANSFORM
    SELF.Cpos := Posit;
    SELF.Possibles := TokenClassify_Raw(SALT32.GetNthWord(le.s1,Posit),Poss)(TokenCount = NWords,Pos = Posit);
  END;
  RETURN SALT32.fn_combine_working_hypothesis( NORMALIZE(AsData,NWords,FindParts(LEFT,COUNTER)) );
END;
// Provide classification information for entire parse stream - ASAP
EXPORT ParseClassify(DATASET(SALT32.Layout_Parse_Raw) p) := FUNCTION
  sp := SALT32.fn_split_parsed(p); // Processing module for this parse stream
  cl := JOIN(sp.Words,TokenKey,HASH32(LEFT.tstring)=RIGHT.TokenHash AND LEFT.tstring=RIGHT.TokenValue,TRANSFORM(SALT32.layout_classify_token,SELF := RIGHT));
  rl := sp.Combine(cl); // Multi-tokens will now be together
  rl0 := rl(TokenCount=1);
  rl1 := rl(TokenCount>1);
  rl2 := JOIN(rl1,MultiTokenKey,RIGHT.TokenHash=HASH32(LEFT.TokenValue) AND RIGHT.TokenValue=LEFT.TokenValue AND LEFT.TokenType = RIGHT.TokenType,TRANSFORM(sp.r,SELF.Verified := LEFT.TokenValue=RIGHT.TokenValue,SELF := LEFT),LEFT OUTER);
  RETURN sp.JoinBack(rl0+rl2);
END;
 
EXPORT StreamVerify(SALT32.StrType s,DATASET(SALT32.Layout_Classify_Hypothesis) Classified) := FUNCTION
  // MORE - could try to get clever and combine fetches for different types of same multi-token
  SALT32.Layout_Classify_Hypothesis Confirm(Classified le) := TRANSFORM
    SELF.Confirmed := EXISTS ( MultiTokenClassify_Raw(SALT32.GetRangeOfWords(s,le.StartPos,le.Startpos+le.Len-1))(TokenType=le.TokenType));
    SELF := le;
  END;
  R := Classified(len=1) + PROJECT(Classified(len>1),Confirm(LEFT))(Confirmed);
  R0 := SALT32.fn_classify_dedup_hypothesis(R,TRUE);
  RETURN SORT(R,SPC,-Len);
END;
 
EXPORT StreamClassify(SALT32.StrType s) := FUNCTION
  NWords := SALT32.WordCount(s);
  EmptyStart := dataset([],SALT32.Layout_Classify_Hypothesis);
  AH := LOOP(EmptyStart,NWords,SALT32.fn_next_working_hypothesis( ROWS(LEFT),TokenClassify_Raw(SALT32.GetNthWord(s,COUNTER)),COUNTER,Nwords) );
  DD := StreamVerify(s,AH);
  DH := SALT32.fn_classify_dedup_hypothesis(DD,TRUE);
  RETURN SORT(DH,SPC,-Len);
END;
 
EXPORT PrettyStreamClassify(SALT32.StrType s) := SALT32.fn_pretty_hypothesis(s,StreamClassify(s),Fields.FieldName);
END;
