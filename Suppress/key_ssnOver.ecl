import data_services;

fname_base := data_services.data_location.prefix() + 'thor_data400::base::md5::qa::ssn';
fname_key  := data_services.data_location.prefix() + 'thor_data400::key::md5::qa::ssn';

layout_ssnOver := record 
	data16 hval;
end;

base_ssnOver := dataset(fname_base, layout_ssnOver, flat);

export key_ssnOver := index(base_ssnOver, {hval}, {base_ssnOver}, fname_key, OPT);
