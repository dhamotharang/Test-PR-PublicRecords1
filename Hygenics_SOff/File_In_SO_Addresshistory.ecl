import Data_Services;

export File_In_SO_Addresshistory :=  
                        dataset(Data_Services.foreign_prod+'thor200_144::in::sex_offender::hd::address_history',
												Layout_In_SO_Addresshistory,
												CSV(SEPARATOR('|'), TERMINATOR(['\n', '\r\n']), QUOTE('"'), MAXLENGTH(2000)))(stringlib.StringToUpperCase(recordid[1..8])<>'RECORDID')
												+ 
												Hygenics_SOff.File_In_SO_Addresshistory_CW;