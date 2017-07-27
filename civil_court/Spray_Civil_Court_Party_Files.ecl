#workunit('name','Spray Civil Court Party Files'); 

import lib_stringlib, lib_fileservices, civil_court;

 

fSprayOrig(string pDataname)

 := lib_fileservices.FileServices.sprayfixed('10.150.12.240',

                                             '/stub_cleaning/court/work/out/' + 'civil_party_clean_' + trim(pDataname,left,right) + '.d00',

                                             4505,

                                             'thor_200',

                                             '~thor_200::in::civil_' + lib_stringlib.StringLib.stringtolowercase(trim(pDataname)) + '_party',

                                             ,,,true,true

                                            );
							
					



	fSprayOrig('az_maricopa_co_20050817');
	fSprayOrig('ca_marin_co_20050715');
	fSprayOrig('ca_mendocino_co_20050818');
	fSprayOrig('ca_stanislaus_co_20050809');
	fSprayOrig('fl_orange_co_20050808');
	fSprayOrig('ny_downstate_20050819');
	fSprayOrig('ny_upstate_20050818');
	fSprayOrig('tx_denton_co_20050801');
	fSprayOrig('tx_gregg_co_20050804');
	fSprayOrig('tx_victoria_co_20050809');
