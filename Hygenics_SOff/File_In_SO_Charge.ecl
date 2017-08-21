export File_In_SO_Charge := dataset('~thor200_144::in::sex_offender::hd::charge',
									Layout_In_SO_charge,
									CSV(SEPARATOR('|'), TERMINATOR(['\n', '\r\n']), QUOTE('"'), MAXLENGTH(2000)))(stringlib.StringToUpperCase(recordid[1..8])<>'RECORDID');