// -- both take in datasets in their respective layouts.  Adds those candidates to the underlink file.

// -- BIPV2_ForceLink.Layouts.Proxid_Underlink  -- { unsigned6 proxid  ,integer   underLinkId }
// -- BIPV2_ForceLink.Layouts.lgid3_Underlink   -- { unsigned6 lgid3   ,integer   underLinkId }
import LinkingTools;

EXPORT Add_Candidates(dataset(LinkingTools.layouts.Suppression_in) pDataset) :=
function

  return BIPV2_Field_Suppression._Config().Suppression_File.addCandidates(pDataset);
  
end;