IMPORT _Control, Data_Services;
lfnx := 'nac::nac2::groups_config';
lfn := IF(_Control.Config.IsDev,
					Data_Services.foreign_prod + lfnx,
					'~' + lfnx);

EXPORT dNAC2Config := dataset(lfn, $.rNAC2Config, thor);
