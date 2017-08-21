import ut;
export Files := module
	export base   	:= DATASET(ut.foreign_prod+'~thor_data400::dor::fl_addr', Layouts.fl_csv, CSV(heading(0),separator(['|']),terminator(['\r']),Quote(['\"'])));
	export history	:= DATASET('~thor_data400::dor::fl_addr_history', Layouts.fl_csv, CSV(heading(0),separator(['|']),terminator(['\r']),Quote(['\"'])));
	export create_superfiles:=parallel(
		if(~FileServices.SuperFileExists('~thor_data400::dor::fl_addr'),fileservices.createsuperfile('~thor_data400::dor::fl_addr'))
		,if(~FileServices.SuperFileExists('~thor_data400::dor::fl_addr_history'),fileservices.createsuperfile('~thor_data400::dor::fl_addr_history'))
	);

end;