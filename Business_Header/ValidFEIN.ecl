Set_InValidFEINPrefix := ['00','07','08','09','17','18','19','28','29','49','78','79','**'];

export boolean ValidFEIN(unsigned4 fein) :=
  map(fein < 999999999 and (intformat(fein, 9, 1))[1..2] not in Set_InValidFEINPrefix => true,
    false);