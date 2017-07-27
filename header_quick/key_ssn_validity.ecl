import header, header_quick, experiancred,doxie;

//get SSN from header, quick_header and experian credit
hdr     := header.file_headers(ssn<>'');
quick_hdr := header_quick.file_header_quick(ssn <> '');
exp_f  := experiancred.files.base_file_out(Social_Security_Number <> '');

rec_ssn := record
string9 ssn;
end;
		
combine_files := project(hdr, rec_ssn) + project(quick_hdr, rec_ssn) 
                + project(exp_f, transform(rec_ssn, self.ssn := left.Social_Security_Number));
combine_files_dedup := dedup(distribute(combine_files, hash(ssn)),all,local);

//append SSN flags

hdr_ssn := header.fn_append_ssn_flags(combine_files_dedup);

export key_ssn_validity := index(hdr_ssn, {ssn}, {ssn, ssn_flags_bitmap},'~thor_data400::key::' + header_quick.str_SegmentName + '_SSN_validity_' + Doxie.Version_SuperKey);