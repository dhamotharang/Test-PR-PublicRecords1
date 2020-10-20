import text_search, data_services;
EXPORT constants(string mode) := module // mode = 'qa' or 'built' or filedate
	export keyprefix := '~thor_data400::dsharma';
	export source := 'frags';
	export fileinfo := Text_Search.FileName_Info_Instance(keyprefix, source, mode);
	export persistfile(string filename) := '~dsharma::persist::frags::' + filename;
end;