// -- both take in 1 suppression id as an integer

EXPORT Remove_Candidates(
   integer  pGid
  ,string2  pOperation  = 'IL' // 'IL' = Internal Linking ,'HY' = Hierarchy
) :=
function

  return if(pOperation  = 'IL'
            ,BIPV2_Field_Suppression._Config().Suppression_File           .removeCandidates(pGid)
            ,BIPV2_Field_Suppression._Config().Hierarchy_Suppression_File .removeCandidates(pGid)
         );
  
end;
