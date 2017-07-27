export FilesIn(string pversion = '') := module

	export New		:=	IF(FileServices.GetSuperFileSubCount('~thor_data400::in::mxd_mxdocket::sprayed::new') != 0,
													DATASET('~thor_data400::in::mxd_mxdocket::sprayed::new', MXD_MXDocket.Layouts_build.NewChg, CSV(UNICODE, HEADING(1), SEPARATOR('|'), TERMINATOR(['\n','\r\n','\n\r']), QUOTE('"'))),
													DATASET([], MXD_MXDocket.Layouts_build.NewChg));
	
	export Update	:=	IF(FileServices.GetSuperFileSubCount('~thor_data400::in::mxd_mxdocket::sprayed::update') != 0,
													DATASET('~thor_data400::in::mxd_mxdocket::sprayed::update', MXD_MXDocket.Layouts_build.NewChg, CSV(UNICODE, HEADING(1), SEPARATOR('|'), TERMINATOR(['\n','\r\n','\n\r']), QUOTE('"'))),
													DATASET([], MXD_MXDocket.Layouts_build.NewChg));
	
	export Delete	:=	IF(FileServices.GetSuperFileSubCount('~thor_data400::in::mxd_mxdocket::sprayed::delete') != 0,
													DATASET('~thor_data400::in::mxd_mxdocket::sprayed::delete', MXD_MXDocket.Layouts_build.Delete, CSV(UNICODE, HEADING(1), SEPARATOR('|'), TERMINATOR(['\n','\r\n','\n\r']), QUOTE('"'))),
													DATASET([], MXD_MXDocket.Layouts_build.Delete));
end;