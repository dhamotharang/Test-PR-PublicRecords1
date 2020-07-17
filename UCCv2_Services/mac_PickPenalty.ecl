EXPORT mac_PickPenalty(starting_score_arg = -1) := MACRO

  starting_score := IF(starting_score_arg = -1, uccPenalty.large, starting_score_arg);
  
  Min2(INTEGER A, INTEGER B) := IF ( A<B, A, B );
  partyPenalt := min2(starting_score, IF(EXISTS(r.parties), r.penalt, uccPenalty.large));
  SELF.penalt := min2(L.penalt, partyPenalt);
    
ENDMACRO;
