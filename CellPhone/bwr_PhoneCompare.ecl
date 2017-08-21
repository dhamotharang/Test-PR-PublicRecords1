import lib_stringlib;

#workunit('name', 'Complete Phone Evaluation')

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/* INSTRUCTIONS */
/* Assigned to please_place_input_file_here - File must have field named PHONE with all 10 digits (digits only) */
/* Change Mac_evaluateCellFile Attribute to match layout for population stats */
/* Select flag to indicate if address records will be passed through the macro */

please_place_input_file_here := table(dataset('~thor_200::in::lssi::20081219::landline.txt', {string area, string nphone}, csv), {string10 phone := intformat((integer)area, 3,0) + intformat((integer)nphone, 7,0)});

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

new_layout := record 
string phone := ''; 
string gong := ''; 
string gong_history := ''; 
string pplus := ''; 
string conf := ''; 
string hdr := '';  
end;

place_input_file_here := distribute(please_place_input_file_here(phone <> ''), hash(phone));

set_inputfile := dedup(table(place_input_file_here, {phone}), all);

inGong := dedup(join(gong.File_GongBase, set_inputfile, left.phoneno = right.phone, transform(new_layout, self.phone := left.phoneno, self.gong := 'Y', self := left)), record, all);

inGongH := dedup(join(Gong.File_History(current_record_flag <> 'Y'), set_inputfile, left.phone10 = right.phone, transform(new_layout, self.phone := left.phone10, self.gong_history := 'Y', self := left)), record, all);

inPP := dedup(join(Phonesplus.file_phonesplus_base, set_inputfile, left.cellphone = right.phone, transform(new_layout, self.phone := left.cellphone, self.pplus := 'Y', self.conf := (string)left.ConfidenceScore, self := left)), record, all);

inHDR := dedup(join(header.File_Headers, set_inputfile, left.phone = right.phone, transform(new_layout, self.phone := left.phone, self.hdr := 'Y', self := left)), record, all);

flaggedFile := project(inGong + inGongH + inPP + inHDR, transform(new_layout, self := left));

new_layout tr(new_layout L, new_layout R) := TRANSFORM
self.gong_history := if(l.gong_history > r.gong_history, l.gong_history, r.gong_history);
self.gong := if(l.gong > r.gong, l.gong, r.gong);
self.pplus := if(l.pplus > r.pplus, l.pplus, r.pplus);
self.conf := if(l.conf > r.conf, l.conf, r.conf);
self.hdr := if(l.hdr > r.hdr, l.hdr, r.hdr);
SELF := L;
END;

output_file_flags := ROLLUP(sort(flaggedFile, record), left.phone = right.phone, tr(LEFT, RIGHT));

YellowPages.NPA_PhoneType(place_input_file_here, phone, phonetype, outfile_ptype);

cellphone.mac_evaluateCellFile(place_input_file_here, phone, outfile_macro);

parallel(
	output(output_file_flags,,'~thor_200::out::phone_eval::flagged'+Thorlib.WUID( ), overwrite, expire(7)),
	output(choosen(table(output_file_flags, {count_gong := count(group, gong <> ''), 
									count_gong_history := count(group, gong_history <> ''),
									count_pplus := count(group, pplus <> ''),
									count_pplus_gd := count(group, conf > '10'),
									count_hdr := count(group, hdr <> '')}), 100)),
	output(outfile_ptype,,'~thor_200::out::phone_eval::phonetypes'+Thorlib.WUID( ), overwrite, expire(7)),
	output(choosen(table(outfile_ptype, {phonetype, count_types := count(group)}, phonetype), 100), named('Phone_Types_Available')),
	outfile_macro
);
