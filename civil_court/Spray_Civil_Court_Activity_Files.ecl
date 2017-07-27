#workunit('name','Spray Civil Court Activity Files'); 

import lib_stringlib, lib_fileservices, civil_court;

 

fSprayOrig(string pDataname)

 := lib_fileservices.FileServices.sprayfixed('10.150.12.240',

                                             '/stub_cleaning/court/work/out/' + 'civil_case_activity_' + trim(pDataname,left,right) + '.d00',

                                             345,

                                             'thor_200',

                                             '~thor_200::in::civil_' + lib_stringlib.StringLib.stringtolowercase(trim(pDataname)) + '_activity',

                                             ,,,true,true

                                            );
							
					




	

	fSprayOrig('fl_orange_co_20050808');
	fSprayOrig('ny_downstate_20050819');
	fSprayOrig('ny_upstate_20050818');
