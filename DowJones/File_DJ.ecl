import _control;
Version := '20130605' : STORED('DJVersion');
boolean isDelta := false : STORED('UseDeltaFile');
EXPORT File_DJ := IF(isDelta,
	'~file::'+_control.IPAddress.bctlpedata10+'::data::hds_3::^Dow^Jones::input::^P^F^A2_'+Version+'2200_^D.xml',
	'~file::'+_control.IPAddress.bctlpedata10+'::data::hds_3::^Dow^Jones::input::^P^F^A2_'+Version+'2200_^F.xml'
);
