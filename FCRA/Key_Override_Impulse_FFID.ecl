import ut, data_services;



ds := dedup(sort(dataset('~thor_data400::base::override::fcra::qa::impulse', fcra.Layout_Override_impulse_In, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt),-flag_file_id),except flag_file_id,keep(1));

fcra.Layout_Override_Impulse proj_recs(ds l) := transform
	self.did := (integer8)l.did;
	self.did_score := (integer8)l.did_score;
	self.aid := (unsigned4)l.aid;
	self.ln_ANNUALINCOME := (integer)l.ln_ANNUALINCOME;
	self.DateVendorFirstReported := (unsigned3)l.DateVendorFirstReported;
	self.DateVendorLastReported := (unsigned3)l.DateVendorLastReported;
	self := l;
end;

kf := project(ds,proj_recs(left));

export Key_Override_Impulse_FFID := index(kf,{flag_file_id}, {kf},
data_services.data_location.prefix('fcra_overrides')+'thor_data400::key::override::fcra::impulse::qa::ffid');