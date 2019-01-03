import _Control;

// Tapeload landing zone \\tapeload02b\k\telephone\wired_assets_(en)\phones_plus_last_resort
EXPORT Spray_Wired_Assets_Owned (string version):= function

wa_owned_spray := fileservices.SprayVariable(_Control.IPAddress.bctlpedata11, '/data/hds_2/phonesplus/sources/neustar/data_files/wired_assets_owned/'+ version+'/Wired_Assets_Phones_Plus_Last_Resort.rpt_*',
																20,                   // max rec size
																,               // separator
															  ,           // end of rec terminator
																,              	 // quotations included
															  'thor400_44', // cluster
																'~thor_data400::base::wa_royalty_owned_' +  version,// filename on Thor
																,
																,
																,
																true,         // overwrite
																true,        // replicate
																true       // compress
                   );

return sequential(
wa_owned_spray
,FileServices.StartSuperFileTransaction()
,FileServices.AddSuperFile('~thor_data400::base::wa_royalty_owned','~thor_data400::base::wa_royalty_owned_' +  version)
,FileServices.FinishSuperFileTransaction()
);
end;