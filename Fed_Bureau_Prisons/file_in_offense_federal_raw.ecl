//
import hygenics_crim;


EXPORT file_in_offense_federal_raw := dataset('~thor200_144::in::federal_inmate::offense',
										           hygenics_crim.layout_in_offense,
										           CSV(SEPARATOR('|'), TERMINATOR(['\n', '\r\n']), QUOTE('"'), MAXLENGTH(2000)))  (stringlib.StringToUpperCase(recordid[1..8])<>'RECORDID'
										          )	;