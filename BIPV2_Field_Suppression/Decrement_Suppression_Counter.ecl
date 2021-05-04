// -- Decrements the suppression counter on the suppression file
import LinkingTools;

EXPORT Decrement_Suppression_Counter(dataset(LinkingTools.layouts.Suppression_out) pDataset = BIPV2_Field_Suppression.files.Suppression) :=
function

  return BIPV2_Field_Suppression._Config().Suppression_File.DecrementSuppressionCounter(pDataset);
  
end;