import _Control, data_services, FCRA, vault;

ds := dataset('~thor_data400::base::override::fcra::qa::gong', fcra.Layout_Override_Gong_In,csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);

fcra.Layout_Override_Gong proj_recs(ds l) := transform
	self.l_did := (unsigned6)l.did;
	self.did := (unsigned6)l.did;
	self.hhid := (unsigned6)l.hhid;
	self.bdid := (unsigned6)l.bdid;
	self.disc_cnt6 := (unsigned2)l.disc_cnt6;
	self.disc_cnt12 := (unsigned2)l.disc_cnt12;
	self.disc_cnt18 := (unsigned2)l.disc_cnt18;
	self.current_flag := (boolean)l.current_flag;
	self.business_flag := (boolean)l.business_flag;
	self.src := if (l.src <> '', l.src, 'GO');
	self := l;
end;

//DF-28168 - filter out records with blank flag_file_id
kf := project(ds(flag_file_id<>''),proj_recs(left));

#IF(_Control.Environment.onVault)
export Key_Override_Gong_FFID := vault.FCRA.Key_Override_Gong_FFID;
#ELSE
export Key_Override_Gong_FFID := index(kf,{flag_file_id}, {kf},
data_services.data_location.prefix('fcra_overrides')+'thor_data400::key::override::fcra::gong::qa::ffid');
#END;
