IMPORT _Control;
lfn := IF(_Control.Config.IsDev,
					'~nac::nac2::groups_config_dataland',
					'~nac::nac2::groups_config_prod');

EXPORT dNAC2Config := dataset(lfn, $.rNAC2Config, thor);;