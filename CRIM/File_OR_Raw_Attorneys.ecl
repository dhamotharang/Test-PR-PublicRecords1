import ut;

payload_layout := record string payload; end;

payload_layout reformat(Crim.Layout_OR_Attorneys l) := transform
	self.payload := l.agency +
	l.person_type_code +
	l.bar_bpst_number +
	l.name +
	l.business_name +
	l.address_line_1 +
	l.address_line_2 +
	l.city +
	l.state +
	l.zip_code +
	l.phone_area_code +
	l.phone_number +
	l.fax_area_code +
	l.fax_phone_number +
	l.date_admitted_to_bar +
	l.attorney_bar_status +
	l.bar_status_date +
	l.social_security_number +
	l.judge_initals +
	l.court_box_number +
	l.record_changed_date +
	l.record_changed_time +
	l.user_id +
	l.command_name +
	l.display_only_date +
	l.display_only_flag +
	l.use_count;
end;

outfile1 := project(dataset(ut.foreign_dataland + '~thor_data400::in::OR_Court_mapped_attorneys',Crim.Layout_OR_Attorneys,flat), reformat(left));

law_layout := RECORD
   string4 concat_AGNLOC_AGNTYP;
   string3 person_type_code;
   string2 bar_BPST_no;
  string30 name;
  string30 business_name;
  string38 address_line_1;
  string38 address_line_2;
  string16 city;
  string2 state;
  string10 zip_code;
  string3 phone_area_code;
  string7 phone_number;
  string3 fax_area_code;
  string7 fax_phone_number;
  string7 date_admitted_to_bar;
  string4 attorney_bar_status;
  string7 bar_status_date;
  string9 social_security_number;
  string3 judge_initals;
  string4 court_box_number;
  string7 record_changed_date;
  string5 record_changed_time;
  string10 user_id;
  string10 command_name;
  string7 display_only_date;
  string1 display_only_flag;
  string9 use_count;
  // string4 filler;
 END;

law_layout reformat2(payload_layout l) := transform
self.concat_AGNLOC_AGNTYP := l.payload[1..4];
self.person_type_code := l.payload[5..6];
self.bar_BPST_no := l.payload[7..9];
self.name := l.payload[10..39];
self.business_name := l.payload[40..69];
self.address_line_1 := l.payload[70..107];
self.address_line_2 := l.payload[108..145];
self.city := l.payload[146..161];
self.state := l.payload[162..163];
self.zip_code := l.payload[164..173];
self.phone_area_code := l.payload[174..176];
self.phone_number := l.payload[177..183];
self.fax_area_code := l.payload[184..186];
self.fax_phone_number := l.payload[187..193];
self.date_admitted_to_bar := l.payload[194..200];
self.attorney_bar_status := l.payload[201..204];
self.bar_status_date := l.payload[205..211];
self.social_security_number := l.payload[212..220];
self.judge_initals := l.payload[221..223];
self.court_box_number := l.payload[224..227];
self.record_changed_date := l.payload[228..234];
self.record_changed_time := l.payload[235..239];
self.user_id := l.payload[240..249];
self.command_name := l.payload[250..259];
self.display_only_date := l.payload[260..266];
self.display_only_flag := l.payload[267..267];
self.use_count := l.payload[268..276];

end;

outfile2 := project(outfile1, reformat2(left));

export File_OR_Raw_Attorneys := outfile2;
