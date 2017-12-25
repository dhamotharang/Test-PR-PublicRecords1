import std, _control;

EXPORT Spray_Deact2_Daily(string version, const varstring eclsourceip, string thorname):= FUNCTION

	srcdir 	:= '/data/data_999/phones/mobile_id_deact2/build/';
	sfDaily := '~thor_data400::in::phones::deact2_daily';
	
	sprayFile 	:= std.File.SprayVariable(eclsourceip,
																																						srcdir + version + '/Wireless_Deact_' + version + '.csv',
																																						,
																																						',',
																																						'\r\n',
																																						,
																																						STD.System.Thorlib.Group(),
																																						sfDaily + '_' + version,
																																						,
																																						,
																																						,
																																						true,
																																						false,
																																						true);
																																						
	addSuper 		:= sequential(FileServices.StartSuperFileTransaction(),
																										Fileservices.ClearSuperfile('~thor_data400::in::phones::deact2_daily'),
																										Fileservices.AddSuperfile('~thor_data400::in::phones::deact2_daily', sfDaily + '_' + version),
																										FileServices.FinishSuperFileTransaction());

	return SEQUENTIAL(sprayFile,
																			addSuper);

END; 