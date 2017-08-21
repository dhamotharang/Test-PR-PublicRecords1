endVersion	:=	'20170707';

sequential(
		parallel(
					FileServices.clearsuperfile('~thor_data400::base::corp2::prod::corp_xtnd'),
					FileServices.clearsuperfile('~thor_data400::base::corp2::prod::cont_xtnd'),
					FileServices.clearsuperfile('~thor_data400::base::corp2::prod::stock_xtnd'),
					FileServices.clearsuperfile('~thor_data400::base::corp2::prod::event_xtnd'),
					FileServices.clearsuperfile('~thor_data400::base::corp2::prod::ar_xtnd')		
						),
		parallel(
					Fileservices.Addsuperfile(	'~thor_data400::base::corp2::prod::corp_xtnd',
														'~thor_data400::base::corp2::' + endVersion +'::corp_xtnd'
													 ),
					Fileservices.Addsuperfile(	'~thor_data400::base::corp2::prod::cont_xtnd',
														'~thor_data400::base::corp2::' + endVersion +'::cont_xtnd'
													 ),
					Fileservices.Addsuperfile(	'~thor_data400::base::corp2::prod::stock_xtnd',
														'~thor_data400::base::corp2::' + endVersion +'::stock_xtnd'
													 ),
					Fileservices.Addsuperfile(	'~thor_data400::base::corp2::prod::event_xtnd',
														'~thor_data400::base::corp2::' + endVersion +'::event_xtnd'
													 ),
					Fileservices.Addsuperfile(	'~thor_data400::base::corp2::prod::ar_xtnd',
														'~thor_data400::base::corp2::' + endVersion +'::ar_xtnd'
													 )				 
						)
				);