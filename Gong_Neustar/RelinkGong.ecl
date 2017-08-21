import _Control, ut, header;

roxieip := if (_Control.ThisEnvironment.Name = 'Dataland',
									_Control.RoxieEnv.certvip,
									_Control.RoxieEnv.prod_batch_neutral);
									
string weekday := ut.Weekday((integer)GetDate);

EXPORT RelinkGong := if ((header.IsNewProdHeaderVersion('gong_history','header_build_version',roxieip) or 
											header.IsNewProdHeaderVersion('gong_history','bheader_build_version',roxieip)) and 
											(weekday = 'SATURDAY' or weekday = 'SUNDAY'),
											true,false) : stored('RelinkGong');