// -- both take in datasets in their respective layouts.  Adds those candidates to the suppression file.

import LinkingTools;

EXPORT Add_Candidates(
   dataset(LinkingTools.layouts.Suppression_in) pDataset
  ,string2                                      pOperation  = 'IL' // 'IL' = Internal Linking ,'HY' = Hierarchy
) :=
function

  return if(pOperation  = 'IL'
            ,BIPV2_Field_Suppression._Config().Suppression_File           .addCandidates  (pDataset)
            ,BIPV2_Field_Suppression._Config().Hierarchy_Suppression_File .addCandidates  (pDataset)
         );
  
end;