IMPORT InsuranceHeader_xLink;
IMPORT Doxie;
IMPORT IDL_header;
IMPORT _Control;
IMPORT Data_Services;

// Full Payload definition
ds_payload := InsuranceHeader_xLink.fn_insuranceheader_full_payload(
  ds_boca_prekey := doxie.header_pre_keybuild,
  ds_alpha_header := IDL_header.files.DS_IDL_POLICY_HEADER_BASE
);

EXPORT Key_InsuranceHeader_DID := INDEX(ds_payload, {unsigned6 s_did := did}, {ds_payload}-_Control.Layout_KeyExclusions, 
						                      Data_Services.Data_location.person_header + 'thor_data400::key::insuranceheader_xlink::' + doxie.Version_SuperKey + '::did' );