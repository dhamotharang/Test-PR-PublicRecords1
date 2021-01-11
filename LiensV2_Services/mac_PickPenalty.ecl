
EXPORT mac_PickPenalty(starting_score = 100) :=
MACRO

  Min2(INTEGER L, INTEGER R) := IF ( l>r , r, l );
  SELF.penalt := min2(starting_score, IF(EXISTS(r.parties), r.penalt, 100));
  
ENDMACRO;
