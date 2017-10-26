import Data_Services;

export File_In_SO_Offense := dataset(Data_Services.foreign_prod+'thor200_144::in::sex_offender::hd::offense',
									Layout_In_SO_Offense,
									CSV(SEPARATOR('|'), TERMINATOR(['\n', '\r\n']), QUOTE('"'), MAXLENGTH(2000)))(stringlib.StringToUpperCase(recordid[1..8])<>'RECORDID')
									+ Hygenics_SOff.File_In_SO_Offense_CW;