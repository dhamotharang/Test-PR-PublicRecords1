import text_search, data_services;
EXPORT constants(string mode) := module // mode = 'qa' or 'built' or filedate
	export keyprefix := data_services.Data_location.Prefix('BAIR') + 'thor_data400::bair';
	export source := 'frags';
	export fileinfo := Text_Search.FileName_Info_Instance(keyprefix, source, mode);
	export persistfile(string filename) := '~bair::persist::frags::' + filename;
end;