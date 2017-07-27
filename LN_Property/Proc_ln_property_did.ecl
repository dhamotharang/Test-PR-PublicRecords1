import ut;
with_did := ln_property.Prop_DID;

ut.MAC_SF_BuildProcess(with_did,'~thor_data400::base::Property_DID',run_did,'2');

export Proc_ln_property_did := run_did;