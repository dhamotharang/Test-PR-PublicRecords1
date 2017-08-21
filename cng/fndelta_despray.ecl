export fndelta_despray(string hdrfileversion) := module
	
	export adds := fileservices.despray('~thor_data400::out::header::deltas_adds::'+ hdrfileversion, '10.194.72.226', '/data/header_delta_adds_' + hdrfileversion,,,200);

	export chgs := fileservices.despray('~thor_data400::out::header::deltas_rems::'+ hdrfileversion, '10.194.72.226', '/data/header_delta_rems_' + hdrfileversion,,,200);

	export rems := fileservices.despray('~thor_data400::out::header::deltas_chgs::'+ hdrfileversion, '10.194.72.226', '/data/header_delta_chgs_' + hdrfileversion,,,200);
	
end;