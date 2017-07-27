#workunit('name','Spray Professional Licenses'); 

import lib_stringlib, lib_fileservices, prof_license;

 

fSprayOrig(string pState)

 := lib_fileservices.FileServices.sprayfixed('10.150.12.240',

                                             '/data_build_1/prolic/work/out/' + 'prolic_' + trim(pState,left,right) + '.d00',

                                             3459,

                                             'thor_dell400',

                                             '~thor_data400::in::prolic_' + lib_stringlib.StringLib.stringtolowercase(trim(pState)),

                                             ,,,true,true

                                            );
							
					


	fSprayOrig('ak');
	fSprayOrig('al');
	fSprayOrig('ar');
	fSprayOrig('az');
	fSprayOrig('ca');
	fSprayOrig('co');
	fSprayOrig('ct');
	fSprayOrig('dc');
	fSprayOrig('de');
	fSprayOrig('fl');
	fSprayOrig('ga');
	fSprayOrig('hi');
	fSprayOrig('ia');
	fSprayOrig('id');
	fSprayOrig('il');
	fSprayOrig('in');
	fSprayOrig('irs_enrolled_agents');
	fSprayOrig('ks');
	fSprayOrig('ky');
	fSprayOrig('la');
	fSprayOrig('ma');
	fSprayOrig('md');
	fSprayOrig('me');
	fSprayOrig('mi');
	fSprayOrig('mn');
	fSprayOrig('mo');
	fSprayOrig('ms');
	fSprayOrig('nc');
	fSprayOrig('nd');
	fSprayOrig('ne');
	fSprayOrig('nh');
	fSprayOrig('nj');
	fSprayOrig('nm');
	fSprayOrig('nv');
	fSprayOrig('ny');
	fSprayOrig('oh');
	fSprayOrig('ok');
	fSprayOrig('or');
	fSprayOrig('pa');
	fSprayOrig('ri');
	fSprayOrig('sc');
	fSprayOrig('sd');
	fSprayOrig('sec_brokers_ct');
	fSprayOrig('sec_brokers_fl');
	fSprayOrig('tn');
	fSprayOrig('tx');
	fSprayOrig('ut');
	fSprayOrig('va');
	fSprayOrig('vt');
	fSprayOrig('wi');
	fSprayOrig('wv');
	fSprayOrig('wy');

