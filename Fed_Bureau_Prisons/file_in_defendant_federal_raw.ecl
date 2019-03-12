//
import hygenics_crim;

EXPORT file_in_defendant_federal_raw :=  dataset('~thor200_144::in::federal_inmate::defendant',
								hygenics_crim.layout_in_defendant,
								CSV(SEPARATOR('|'), TERMINATOR(['\n', '\r\n']), QUOTE('"'), MAXLENGTH(6000))) (stringlib.StringToUpperCase(recordid[1..8])<>'RECORDID' 
								                      );