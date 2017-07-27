import SANCTN_Mari;

export files_SANCTN_common := MODULE

export incident_common	:= dataset(SANCTN_Mari.cluster_name +'out::SANCTN::NP::midex_incident_base',SANCTN_Mari.layouts_SANCTN_common.SANCTN_incident_base,thor);

export incident_bip	:= dataset(SANCTN_Mari.cluster_name +'base::SANCTN::NP::incident_bip',SANCTN_Mari.layouts_SANCTN_common.SANCTN_incident_bip,thor);

export party_common	:= dataset(SANCTN_Mari.cluster_name +'out::SANCTN::NP::midex_party_base',SANCTN_Mari.layouts_SANCTN_common.SANCTN_party_base,thor);
								
export incident_text	:= dataset(SANCTN_Mari.cluster_name +'base::SANCTN::NP::incidenttext',SANCTN_Mari.layouts_SANCTN_common.SANCTN_incident_text,thor);

export incident_codes	:= dataset(SANCTN_Mari.cluster_name +'base::SANCTN::NP::incidentcode',SANCTN_Mari.layouts_SANCTN_common.Midex_cd,thor);		

export party_text	:= dataset(SANCTN_Mari.cluster_name +'base::SANCTN::NP::partytext',SANCTN_Mari.layouts_SANCTN_common.SANCTN_party_text,thor);																								

export party_bip	:= dataset(SANCTN_Mari.cluster_name +'base::SANCTN::NP::party_bip',SANCTN_Mari.layouts_SANCTN_common.SANCTN_party_bip,thor);

export party_aka_dba := dataset(SANCTN_Mari.cluster_name + 'base::SANCTN::NP::party_aka_dba',SANCTN_Mari.layouts_SANCTN_common.party_aka_dba,thor);
END;
