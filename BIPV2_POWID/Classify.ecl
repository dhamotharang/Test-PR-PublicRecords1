IMPORT ut,SALT33;
// This module is to the field values what the fields module is to the field itself
// It really exists to answer the question: does a token with these characters logically belong in this field?
// This module should be viewed as experimental
EXPORT Classify(DATASET(layout_POWID) h) := MODULE
 
// Most of the data we need for the classification exists in the specificities module - collect and convert
SHARED TotalClusters := specificities(h).TotalClusters;
  prim_range_tokens := PROJECT(specificities(h).prim_range_values_persisted,TRANSFORM(SALT33.Layout_Classify_Token,SELF.TokenValue := (SALT33.StrType)LEFT.prim_range; SELF.TokenType := 1; SELF.Spc := LEFT.field_Specificity ));
  prim_name_tokens := PROJECT(specificities(h).prim_name_values_persisted,TRANSFORM(SALT33.Layout_Classify_Token,SELF.TokenValue := (SALT33.StrType)LEFT.prim_name; SELF.TokenType := 2; SELF.Spc := LEFT.field_Specificity ));
  RID_If_Big_Biz_tokens := PROJECT(specificities(h).RID_If_Big_Biz_values_persisted,TRANSFORM(SALT33.Layout_Classify_Token,SELF.TokenValue := (SALT33.StrType)LEFT.RID_If_Big_Biz; SELF.TokenType := 3; SELF.Spc := LEFT.field_Specificity ));
  cnp_name_tokens := PROJECT(specificities(h).cnp_name_values_persisted,TRANSFORM(SALT33.Layout_Classify_Token,SELF.TokenValue := (SALT33.StrType)LEFT.cnp_name; SELF.TokenType := 4; SELF.Spc := LEFT.field_Specificity ));
  company_name_tokens := PROJECT(specificities(h).company_name_values_persisted,TRANSFORM(SALT33.Layout_Classify_Token,SELF.TokenValue := (SALT33.StrType)LEFT.company_name; SELF.TokenType := 5; SELF.Spc := LEFT.field_Specificity ));
  cnp_number_tokens := PROJECT(specificities(h).cnp_number_values_persisted,TRANSFORM(SALT33.Layout_Classify_Token,SELF.TokenValue := (SALT33.StrType)LEFT.cnp_number; SELF.TokenType := 6; SELF.Spc := LEFT.field_Specificity ));
  zip_tokens := PROJECT(specificities(h).zip_values_persisted,TRANSFORM(SALT33.Layout_Classify_Token,SELF.TokenValue := (SALT33.StrType)LEFT.zip; SELF.TokenType := 7; SELF.Spc := LEFT.field_Specificity ));
SHARED all_tokens0 := prim_range_tokens + prim_name_tokens + RID_If_Big_Biz_tokens + cnp_name_tokens + company_name_tokens + cnp_number_tokens + zip_tokens;
SHARED all_tokens := SALT33.fn_process_multitokens(all_tokens0);
 
EXPORT TokenKeyName := '~'+'key::BIPV2_POWID::POWID::Token::TokenKey';
 
EXPORT TokenKey := INDEX(all_tokens,{UNSIGNED4 TokenHash := HASH32(TokenValue),TokenType},{all_tokens},TokenKeyName);
 
EXPORT MultiTokenKeyName := '~'+'key::BIPV2_POWID::POWID::Token::MultiTokenKey';
 
EXPORT MultiTokenKey := INDEX(all_tokens0(SALT33.WordCount(TokenValue)>1),{UNSIGNED4 TokenHash := HASH32(TokenValue),TokenType},{all_tokens0},MultiTokenKeyName);
// Now compute the patterns of filled in field values for the various concept fields
SHARED s := specificities(h).specificities;
SHARED ih := specificities(h).input_file;
 
EXPORT Build := PARALLEL(BUILDINDEX(TokenKey, OVERWRITE),BUILDINDEX(MultiTokenKey, OVERWRITE));
 
SHARED TokenClassify_Raw(SALT33.StrType s,SET OF UNSIGNED2 Poss=[]) := PROJECT( TokenKey(TokenHash=HASH32(s),TokenValue = s,Poss=[] OR TokenType IN Poss),TRANSFORM(SALT33.Layout_Classify_Token,SELF := LEFT) );
SHARED MultiTokenClassify_Raw(SALT33.StrType s) := PROJECT( MultiTokenKey(TokenHash=HASH32(s),TokenValue = s),TRANSFORM(SALT33.Layout_Classify_Token,SELF := LEFT) );
 
EXPORT TokenClassify(SALT33.StrType s) := SORT(TokenClassify_Raw(s),spc);
 
EXPORT FieldClassify(SALT33.StrType s,SET OF UNSIGNED2 Poss=[]) := FUNCTION
  NWords := SALT33.WordCount(s);
  AsData := DATASET([{s}],{SALT33.StrType s1;});
  SALT33.Layout_Classify_Working_Hypothesis FindParts(AsData le,UNSIGNED4 Posit) := TRANSFORM
    SELF.Cpos := Posit;
    SELF.Possibles := TokenClassify_Raw(SALT33.GetNthWord(le.s1,Posit),Poss)(TokenCount = NWords,Pos = Posit);
  END;
  RETURN SALT33.fn_combine_working_hypothesis( NORMALIZE(AsData,NWords,FindParts(LEFT,COUNTER)) );
END;
// Provide classification information for entire parse stream - ASAP
EXPORT ParseClassify(DATASET(SALT33.Layout_Parse_Raw) p) := FUNCTION
  sp := SALT33.fn_split_parsed(p); // Processing module for this parse stream
  cl := JOIN(sp.Words,TokenKey,HASH32(LEFT.tstring)=RIGHT.TokenHash AND LEFT.tstring=RIGHT.TokenValue,TRANSFORM(SALT33.layout_classify_token,SELF := RIGHT));
  rl := sp.Combine(cl); // Multi-tokens will now be together
  rl0 := rl(TokenCount=1);
  rl1 := rl(TokenCount>1);
  rl2 := JOIN(rl1,MultiTokenKey,RIGHT.TokenHash=HASH32(LEFT.TokenValue) AND RIGHT.TokenValue=LEFT.TokenValue AND LEFT.TokenType = RIGHT.TokenType,TRANSFORM(sp.r,SELF.Verified := LEFT.TokenValue=RIGHT.TokenValue,SELF := LEFT),LEFT OUTER);
  RETURN sp.JoinBack(rl0+rl2);
END;
 
EXPORT StreamVerify(SALT33.StrType s,DATASET(SALT33.Layout_Classify_Hypothesis) Classified) := FUNCTION
  // MORE - could try to get clever and combine fetches for different types of same multi-token
  SALT33.Layout_Classify_Hypothesis Confirm(Classified le) := TRANSFORM
    SELF.Confirmed := EXISTS ( MultiTokenClassify_Raw(SALT33.GetRangeOfWords(s,le.StartPos,le.Startpos+le.Len-1))(TokenType=le.TokenType));
    SELF := le;
  END;
  R := Classified(len=1) + PROJECT(Classified(len>1),Confirm(LEFT))(Confirmed);
  R0 := SALT33.fn_classify_dedup_hypothesis(R,TRUE);
  RETURN SORT(R,SPC,-Len);
END;
 
EXPORT StreamClassify(SALT33.StrType s) := FUNCTION
  NWords := SALT33.WordCount(s);
  EmptyStart := dataset([],SALT33.Layout_Classify_Hypothesis);
  AH := LOOP(EmptyStart,NWords,SALT33.fn_next_working_hypothesis( ROWS(LEFT),TokenClassify_Raw(SALT33.GetNthWord(s,COUNTER)),COUNTER,Nwords) );
  DD := StreamVerify(s,AH);
  DH := SALT33.fn_classify_dedup_hypothesis(DD,TRUE);
  RETURN SORT(DH,SPC,-Len);
END;
 
EXPORT PrettyStreamClassify(SALT33.StrType s) := SALT33.fn_pretty_hypothesis(s,StreamClassify(s),Fields.FieldName);
END;
