// -- zeros out the suppression counter on the suppression file, so that explosions will be performed again.  if suppression_counter > 0 for any suppression will cause the explosion part to not be performed.
import LinkingTools;

EXPORT Initialize_Suppression_Counter(dataset(LinkingTools.layouts.Suppression_out) pDataset = BIPV2_Field_Suppression.files.Suppression) :=
function

  return BIPV2_Field_Suppression._Config().Suppression_File.InitializeSuppressionCounter(pDataset);
  
end;