export File_In_SO_Other := dataset('~thor200_144::in::sex_offender::hd::other',
										Layout_In_SO_Other,
										CSV(SEPARATOR('|'), TERMINATOR(['\n', '\r\n']), QUOTE('"'), MAXLENGTH(4000)))(stringlib.StringToUpperCase(recordid[1..8])<>'RECORDID');