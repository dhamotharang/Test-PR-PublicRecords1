
import ut;

export in_sex_offender_defendant_raw :=
                            dataset(
														   ut.foreign_prod + 'thor200_144::in::sex_offender::hd::defendant',
                                	scrubs_sexoffender_def_raw.layout_sex_offender_defendant_raw,
								                   	CSV(SEPARATOR('|'), TERMINATOR(['\n', '\r\n']), QUOTE('"'), MAXLENGTH(4000)))(stringlib.StringToUpperCase(recordid[1..8])<>'RECORDID' 
								                     	);