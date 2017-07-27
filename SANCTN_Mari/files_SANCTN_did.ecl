import SANCTN_Mari;

export files_SANCTN_did := MODULE

//export incident_did	:= dataset('~thor_data400::base::SANCTN_Mari::incident_base',SANCTN_Mari.layouts_SANCTN_common.SANCTN_incident,thor);
//export party_did	:= dataset('~thor_data400::base::SANCTN_Mari::party_base',SANCTN_Mari.layouts_SANCTN_common.SANCTN_party,thor);

export incident_did	:= dataset(SANCTN_Mari.cluster_name +'base::sanctn::np::incident',SANCTN_Mari.layouts_SANCTN_common.SANCTN_incident_base,thor);

export party_did		:= dataset(SANCTN_Mari.cluster_name +'base::sanctn::np::party',SANCTN_Mari.layouts_SANCTN_common.SANCTN_party_base,thor);

export incident_aid	:= dataset(SANCTN_Mari.cluster_name +'temp::sanctn::np::cln_incident_aid',SANCTN_Mari.layouts_SANCTN_common.SANCTN_incident_did,thor);

export party_aid		:= dataset(SANCTN_Mari.cluster_name +'temp::sanctn::np::cln_party_aid',SANCTN_Mari.layouts_SANCTN_common.SANCTN_party_did,thor);

export clnIncident_did	:= dataset(SANCTN_Mari.cluster_name +'out::sanctn::np::cln_incident_did',SANCTN_Mari.layouts_SANCTN_common.SANCTN_incident_did,thor);

export clnParty_DID			:= dataset(SANCTN_Mari.cluster_name +'out::sanctn::np::cln_party_did',SANCTN_Mari.layouts_SANCTN_common.SANCTN_party_did,thor);
													
END;