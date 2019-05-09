import data_services;
Offense_arrests     := dataset(data_services.foreign_prod+ 'thor_200::in::crim::hd::arrest_offense',
										           layout_in_offense,
										           CSV(SEPARATOR('|'), TERMINATOR(['\n', '\r\n']), QUOTE('"'), MAXLENGTH(2000)))  (stringlib.StringToUpperCase(recordid[1..8])<>'RECORDID'
										          );
file_in_Offense_CW  :=  dataset(data_services.foreign_prod+'thor_200::in::crim::hd::arrest_offense_cw', hygenics_crim.layout_in_offense,
														    CSV(SEPARATOR('|'), TERMINATOR(['\n', '\r\n']), QUOTE('"'), MAXLENGTH(4096)))
														    (stringlib.StringToUpperCase(recordid[1..8])<>'RECORDID') ;

proj_off_cw         := Project(file_in_Offense_CW,transform(hygenics_crim.layout_in_offense,self.sourcename := trim(left.sourcename)+'_CW'; self := left;));										

file_in_Offense_IE  :=  dataset(data_services.foreign_prod+'thor_200::in::crim::hd::arrest_offense_IE', hygenics_crim.layout_in_offense,
														    CSV(SEPARATOR('|'), TERMINATOR(['\n', '\r\n']), QUOTE('"'), MAXLENGTH(4096)))
														    (stringlib.StringToUpperCase(recordid[1..8])<>'RECORDID') ;

proj_off_IE         := Project(file_in_Offense_IE,transform(hygenics_crim.layout_in_offense,self.sourcename := trim(left.sourcename)+'_IE'; self := left;));										

export file_in_offense_arrests := Offense_arrests+proj_off_cw+proj_off_IE : INDEPENDENT;