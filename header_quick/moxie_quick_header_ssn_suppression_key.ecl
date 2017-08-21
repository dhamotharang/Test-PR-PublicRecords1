import header, header_quick, ut, _control;

export moxie_quick_header_ssn_suppression_key(string filedate) := function
	ssn_suppression_rec := record
		string9 ssn;
		string6 ssn_mask;
		string15 rc;
		string2 crlf;
	end;

	ssn_suppression_rec convert_to_fixed(header_quick.file_ssn_suppression l) := transform
		self := l;
	end;

	ds_ssn_supp := project(header_quick.file_ssn_suppression,convert_to_fixed(left));

	out_ssn_suppression := output(sort(ds_ssn_supp,ssn),,'~thor_data400::out::ssn_suppression',overwrite);

	suppression_rec := record
		ssn_suppression_rec;
		unsigned integer8 __filepos {virtual(fileposition)};
	end;

	file_suppression := dataset('~thor_data400::out::ssn_suppression',suppression_rec,flat);

	ssn_rec := record
		file_suppression.ssn;
		file_suppression.__filepos;
	end;

	t_ssn_supp := table(file_suppression((integer)ssn<>0),ssn_rec);

	ssn_suppression_key	:= BUILDINDEX(t_ssn_supp,,'~thor_data400::key::moxie.ssn_suppression.ssn.key',moxie,overwrite);

	despray_moxie_ssn := fileservices.despray('~thor_data400::out::ssn_suppression',_control.IPAddress.edata12,'/hds_1/efx_hdrs/out/ssn_suppression_'+filedate+'.d00');
																	
	return sequential(out_ssn_suppression,ssn_suppression_key,despray_moxie_ssn);
end;