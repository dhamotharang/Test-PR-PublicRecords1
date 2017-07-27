import ut, header_services,faa;

ds := dataset('~thor_data400::base::faa_airmen_certs_Building',faa.layout_airmen_certificate_out,flat);

temp_rec := record
	string8 date_first_seen;
	string8 date_last_seen;
	string1 current_flag;
	string1 letter;
	string7 unique_id;
	string2 rec_type;
	string1 cer_type;
	string20	cer_type_mapped;
	string1 cer_level;
	string45	cer_level_mapped;
	string8 cer_exp_date;
	string99 ratings;
	string79 filler;
	string2 lfcr;
end;
header_services.Supplemental_Data.mac_verify('file_faa_cert_inj.thor',temp_rec,attr);
 
supp_data_in := attr();

start := max(ds,(unsigned)unique_id);

faa.layout_airmen_certificate_out add_id(temp_rec l) := transform
	self.unique_id := intformat(start + (unsigned)l.unique_id,7,1);
  self := l;
end;

supp_data := project(supp_data_in, add_id(left));

total := dedup(sort(ds + supp_data,current_flag, letter, unique_id, rec_type, cer_type, cer_type_mapped, cer_level, cer_level_mapped, cer_exp_date, ratings, -date_last_seen) ,except date_first_seen, date_last_seen); 

// populate persistent record id 

f := project(total, transform( faa.layout_airmen_certificate_out, self.persistent_record_id := hash64(trim(left.current_flag,left,right)+
																																									trim(left.letter,left,right)+
																																									trim(left.unique_id,left,right)+
																																									trim(left.rec_type,left,right)+
																																									trim(left.cer_type,left,right)+
																																									trim(left.cer_type_mapped,left,right)+
																																									trim(left.cer_level,left,right)+
																																									trim(left.cer_level_mapped,left,right)+
																																									trim(left.cer_exp_date,left,right)+
																																									trim(left.ratings,left,right));
                                                          
                                 
																 self := left)); 

export file_airmen_certificate_bldg := f;