import header;

export Keys := module

	shared srcFile := dataset([], recordof(header.File_Headers));

	export Source := index(srcFile,{rid},{srcFile},'~thor_data400::key::header_delta::source');
	export Target := index(srcFile,{rid},{srcFile},'~thor_data400::key::header_delta::target');
	export Raw_Source := index(srcFile,{rid},{srcFile},'~thor_data400::key::header_raw::source');
	export Raw_Target := index(srcFile,{rid},{srcFile},'~thor_data400::key::header_raw::target');

end;