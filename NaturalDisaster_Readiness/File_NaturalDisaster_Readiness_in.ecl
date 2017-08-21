export File_NaturalDisaster_Readiness_in := dataset('~thor_data400::in::NaturalDisaster_Readiness::sprayed',
																						 NaturalDisaster_Readiness.Layouts.Input,
																						 csv(heading(1),
																						 UNICODE,
																						 separator('|'),
																						 maxlength(40000),
																						 quote('"'),
																						 terminator(['\r\n','\r','\n'])));