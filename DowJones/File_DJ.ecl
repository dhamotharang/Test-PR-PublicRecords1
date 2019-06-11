import _control;
//EXPORT File_DJ := '~file::bctlpedata10.risk.regn.net::data::hds_3::^Dow^Jones::input::^P^F^A2_'+Version+'2200_^F.xml';
Version := '20130605' : STORED('DJVersion');
EXPORT File_DJ := '~file::'+_control.IPAddress.bctlpedata10+'::data::hds_3::^Dow^Jones::input::^P^F^A2_'+Version+'2200_^F.xml';
