import Data_Services;

export File_In_SO_Defendant := 
                    dataset(Data_Services.foreign_prod+'thor200_144::in::sex_offender::hd::defendant',
										Layout_In_SO_Defendant,
										CSV(SEPARATOR('|'), TERMINATOR(['\n', '\r\n']), QUOTE('"'), MAXLENGTH(4000)))(stringlib.StringToUpperCase(recordid[1..8])<>'RECORDID')
										+ 
										Hygenics_SOff.File_In_SO_Defendant_CW;