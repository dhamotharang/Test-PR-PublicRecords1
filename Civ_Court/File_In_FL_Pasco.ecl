import ut;

temp_layout := Record
string blob;
end;

df := dataset('~thor_data400::in::civil::fl_pasco',	temp_layout, csv(terminator('\r\n'), separator('')));

df_fixed := df(length(blob) > 1);

Civ_Court.Layout_In_FL_Pasco Pasco_Fixed(df_fixed input) := Transform
self.defendant_plaintiff := input.blob[1..2];
self.name := input.blob[3..29];
self.street_address := input.blob[30..51];
self.city := input.blob[52..67];
self.state := input.blob[68..69];
self.zip_code := input.blob[70..78];
self.phone_number := input.blob[79..88];
self.uniform_case_number := input.blob[89..108];
self.date_filed := input.blob[109..116];
//self.crlf := '  ';
end;

df_Pasco := project(df_fixed, Pasco_Fixed(left));

export File_In_FL_Pasco := df_Pasco;