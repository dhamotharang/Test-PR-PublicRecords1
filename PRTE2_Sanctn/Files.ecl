import prte_csv, data_services, sanctn;

EXPORT Files := module

	export sample_incident				:= dataset(data_services.foreign_prod + 'prte::base::sanctn::incident', SANCTN.layout_SANCTN_incident_clean, thor);
	export sample_party						:= dataset(data_services.foreign_prod + 'prte::base::sanctn::party', SANCTN.layout_SANCTN_did, thor);
	export sample_license					:= dataset(data_services.foreign_prod + 'prte::base::sanctn::license', SANCTN.layout_SANCTN_license_clean, thor);
	export sample_party_aka_dba		:= dataset(data_services.foreign_prod + 'prte::base::sanctn::party_aka_dba', SANCTN.layout_SANCTN_aka_dba_in,thor);
	export sample_rebuttal				:= dataset(data_services.foreign_prod + 'prte::base::sanctn::rebuttal', SANCTN.layout_SANCTN_rebuttal_in,thor);
	// export sample_bdid				 		:= dataset([], layouts.rKeySanctn__key__sanctn__bdid	);
	// export sample_did							:= dataset([], layouts.rKeySanctn__key__sanctn__did	);
	// export sample_linkids					:= dataset([], layouts.rKeySanctn__key__sanctn__linkids	);
	// export sample_midex_rpt_nbr		:= dataset([], layouts.rKeySanctn__key__sanctn__midex_rpt_nbr);
	// export sample_casenum					:= dataset([], layouts.rKeySanctn__key__sanctn__casenum	);
	// export sample_incident_midex	:= dataset([], layouts.rKeySanctn__key__sanctn__incident_midex	);
	// export sample_license_midex		:= dataset([], layouts.rKeySanctn__key__sanctn__license_midex	);
	// export sample_license_nbr			:= dataset('~prte::base::sanctn::license', SANCTN.layout_SANCTN_license_clean, thor);

	// export sample_nmls_id					:= dataset([], layouts.rKeySanctn__key__sanctn__nmls_id);
	// export sample_nmls_midex			:= dataset([], layouts.rKeySanctn__key__sanctn__nmls_midex);
	
	// export sample_ssn4						:= dataset([], layouts.rKeySanctn__key__sanctn__ssn4	);
	
																																			
end;																																			
	
	