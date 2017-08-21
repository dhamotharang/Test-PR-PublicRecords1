import ut;

export File_In_SO_Addresshistory_cw := dataset('~thor200_144::in::sex_offender::hd::address_history_cw',
												                         Layout_In_SO_Addresshistory,
												                         CSV(SEPARATOR('|'), TERMINATOR(['\n', '\r\n']), QUOTE('"'), MAXLENGTH(2000)))(stringlib.StringToUpperCase(recordid[1..8])<>'RECORDID');