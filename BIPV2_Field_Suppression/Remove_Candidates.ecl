// -- both take in 1 suppression id as an integer

EXPORT Remove_Candidates(integer pGid) :=
function

  return BIPV2_Field_Suppression._Config().Suppression_File.removeCandidates(pGid);
  
end;