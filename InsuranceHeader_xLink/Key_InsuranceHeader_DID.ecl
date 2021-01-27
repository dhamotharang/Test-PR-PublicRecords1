IMPORT InsuranceHeader_xLink;
IMPORT Doxie;
IMPORT _Control;
IMPORT Data_Services;

EXPORT Key_InsuranceHeader_DID := INDEX(
  DATASET([], InsuranceHeader_xLink.layout_insuranceheader_payload),
  {UNSIGNED6 s_did := did}, 
  {InsuranceHeader_xLink.layout_insuranceheader_payload}-_Control.Layout_KeyExclusions, 
  Data_Services.Data_Location.person_header + 'thor_data400::key::insuranceheader_xlink::' + doxie.Version_SuperKey + '::did'
);