import ut;


export File_In_SO_Alias_CW := dataset('~thor200_144::in::sex_offender::hd::alias_cw',
									                    Layout_In_SO_Alias,
									                    CSV(SEPARATOR('|'), TERMINATOR(['\n', '\r\n']), QUOTE('"'), MAXLENGTH(2000)))(stringlib.StringToUpperCase(recordid[1..8])<>'RECORDID');