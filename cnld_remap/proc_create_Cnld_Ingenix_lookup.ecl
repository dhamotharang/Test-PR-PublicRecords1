rsAllCnldIngxJoins		:=	cnld_remap.proc_join_cnld_Ingenix_FEIN 
											  + cnld_remap.proc_join_cnld_Ingenix_LicNum 
												+ cnld_remap.proc_join_cnld_Ingenix_NPI 
												+ cnld_remap.proc_join_cnld_Ingenix_UPIN 
												+ cnld_remap.proc_join_cnld_Ingenix_DEA
												+ cnld_remap.proc_join_cnld_Ingenix_DID;

rsAllResultsDist			:=	DISTRIBUTE(rsAllCnldIngxJoins, HASH(GENNUM));
rsAllResultsDistSort	:=	SORT(rsAllResultsDist, GENNUM, LOCAL);
rsAllResultsDd				:=	DEDUP(rsAllResultsDistSort, GENNUM, LOCAL);

// OUTPUT(rsAllResultsDd);

export proc_create_Cnld_Ingenix_lookup := rsAllResultsDd:PERSIST('~thor_200::ingenix::in::Cnld_Ingx_lkp');