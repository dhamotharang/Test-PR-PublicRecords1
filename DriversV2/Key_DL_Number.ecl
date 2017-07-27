import Doxie_Build, Drivers;

export Key_DL_Number := DriversV2.key_prep_dl_number;
/*
base := DriversV2.File_dl(trim(dl_number,left,right) <> '');

export Key_DL_Number := index(base,
														  {dl_number},
													    {base},
													     Drivers.Cluster+'key::dl::'+Drivers.Version+'::dl_number'
                              );
*/