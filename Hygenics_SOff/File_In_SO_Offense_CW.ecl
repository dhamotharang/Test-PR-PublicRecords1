import ut;

EXPORT File_In_SO_Offense_CW := 
                          dataset('~thor200_144::in::sex_offender::hd::offense_cw',
									        Layout_In_SO_Offense,
									        CSV(SEPARATOR('|'), TERMINATOR(['\n', '\r\n']), QUOTE('"'), MAXLENGTH(2000)))(stringlib.StringToUpperCase(recordid[1..8])<>'RECORDID');