#workunit('name','Spray Civil Court Activity Files'); 

import lib_stringlib, lib_fileservices, civil_court;

 

fSprayOrig(string pDataname)

 := lib_fileservices.FileServices.sprayfixed('10.150.12.240',

                                             '/stub_cleaning/court/work/out/ng_to_spray/' + 'civil_case_activity_' + trim(pDataname,left,right) + '.d00',

                                             345,

                                             'thor_200',

                                             '~thor_200::in::civil_' + lib_stringlib.StringLib.stringtolowercase(trim(pDataname)) + '_activity',

                                             ,,,true,true

                                            );
							
					




	

	fSprayOrig('az_ffreplace_20051012');
	fSprayOrig('ct_ffreplace_20051010');
	fSprayOrig('fl_alachua_co_nlj_upd_20051013');
	fSprayOrig('va_upd_20050926');

