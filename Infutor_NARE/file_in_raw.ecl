Import Infutor_NARE, ut;

d_raw_infutor := DATASET('~thor_data400::in::email::infutor_email_raw',Infutor_NARE.layouts.layout_raw, CSV(Separator ('\t'), Terminator('\r\n')));

EXPORT file_in_raw := project(d_raw_infutor,transform(Infutor_NARE.layouts.layout_raw_slim, self.ZipCode := LEFT.Zip5, Self.ZipPlus4 := LEFT.Zip4, self:=left));