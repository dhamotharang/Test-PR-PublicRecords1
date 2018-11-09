IMPORT std,data_services,header;
EXPORT file_fraud_flag_eq_in := function

lc:=data_services.foreign_prod;

monthly_file := Header.File_Header_In().monthly_file;

fst_file := nothor(std.file.superfilecontents(lc+'thor_data400::in::hdr_raw',true)[1].name);
dt:=regexfind('2[0-2][0-9][0-9][0-1][0-9][1-3][0-9]',fst_file,0)[1..6];
monthly_with_fraud := monthly_file(blank3[6]<>'');

monthly_fraud_flag_raw := 

project(monthly_with_fraud,transform(header_quick.layout_fraud_flag_eq.in,
        self.factact_code := LEFT.blank3[6..7],
        self.date_reported:= LEFT.blank3[7..11],
        self.filename := '::'+dt;
        self:=LEFT));

return monthly_fraud_flag_raw;

end;