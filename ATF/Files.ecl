import ut;
EXPORT Files := module

Export Firearms_license:=DATASET('~thor_data400::in::firearms_licenses',atf.layouts.firearms_in
,CSV(
HEADING(2)
,SEPARATOR('\t')

,TERMINATOR(['\n', '\r\n'])
,QUOTE('"')
,MAXLENGTH(65535)
)
);    


Export Explosives_license:=
if(nothor(FileServices.GetSuperFileSubCount('~thor_data400::in::explosives_licenses')) > 0
 ,DATASET('~thor_data400::in::explosives_licenses',atf.layouts.explosives_in
,CSV(
HEADING(2)
,SEPARATOR('\t')
,TERMINATOR(['\n', '\r\n'])
,QUOTE('"')
,MAXLENGTH(65535)
),opt
));                                                                             
end;

