import prte_csv, prte2_sanctn_np, data_services, sanctn_mari;

EXPORT Files := module

export sample_incident					:= dataset(data_services.foreign_prod +'prte::base::sanctn_np::incident', SANCTN_Mari.layouts_SANCTN_common.SANCTN_incident_bip,thor);
export sample_incidentcode			:= dataset(data_services.foreign_prod +'prte::base::sanctn_np::incidentcode', SANCTN_Mari.layouts_SANCTN_common.Midex_cd,thor);
export sample_incidenttext			:= dataset(data_services.foreign_prod +'prte::base::sanctn_np::incidenttext', SANCTN_Mari.layouts_SANCTN_common.SANCTN_incident_text,thor);
export sample_party							:= dataset(data_services.foreign_prod +'prte::base::sanctn_np::party', SANCTN_Mari.layouts_SANCTN_common.SANCTN_party_bip,thor);
export sample_partytext					:= dataset(data_services.foreign_prod +'prte::base::sanctn_np::partytext', SANCTN_Mari.layouts_SANCTN_common.SANCTN_party_text,thor);
export sample_party_aka_dba			:= dataset(data_services.foreign_prod +'prte::base::sanctn_np::party_aka_dba', SANCTN_Mari.layouts_SANCTN_common.party_aka_dba,thor);

//old code
// export sample_bdid 													:= dataset([], layouts.rKeySanctn__key__sanctn__np__bdid	);
// export sample_did 														:= dataset([], layouts.rKeySanctn__key__sanctn__np__did	);
// export sample_license_midex					:= dataset([], layouts.rKeySanctn__key__sanctn__np__license_midex	);
// export sample_license_nbr							:= dataset([], layouts.rKeySanctn__key__sanctn__np__license_nbr	);
// export sample_midex_rpt_nbr					:= dataset([], layouts.rKeySanctn__key__sanctn__np__midex_rpt_nbr);
// export sample_nmls_id											:= dataset([], layouts.rKeySanctn__key__sanctn__np__nmls_id);
// export sample_nmls_midex								:= dataset([], layouts.rKeySanctn__key__sanctn__np__nmls_midex);
// export sample_ssn4														:= dataset([], layouts.rKeySanctn__key__sanctn__np__ssn4	);
// export sample_tin															:= dataset([], layouts.rKeySanctn__key__sanctn__np__tin	);
// export sample_linkid_incident			:= dataset([], layouts.rKeySanctn__key__sanctn__np__linkids_incident );
// export sample_linkids_party					:= dataset([], layouts.rKeySanctn__key__sanctn__np__linkids_party	);

end;