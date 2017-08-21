#workunit('name','Spray Civil Court Matter Files'); 

import lib_stringlib, lib_fileservices, civil_court;

 

fSprayOrig(string pDataname)

 := lib_fileservices.FileServices.sprayfixed('10.150.12.240',

                                             '/stub_cleaning/court/work/out/ng_to_spray/' + 'civil_matter_' + trim(pDataname,left,right) + '.d00',

                                             1004,

                                             'thor_200',

                                             '~thor_200::in::civil_' + lib_stringlib.StringLib.stringtolowercase(trim(pDataname)) + '_matter',

                                             ,,,true,true

                                            );
							
					



	fSprayOrig('ar_ffreplace_20050929');
	fSprayOrig('az_ffreplace_20051012');
	fSprayOrig('ca_fresno_co_upd_20051013');
	fSprayOrig('ca_kern_co_upd_20050927');
	fSprayOrig('ca_la_co_upd_20051013');
	fSprayOrig('ca_san_luis_obispo_co_ffreplace_20050922');
	fSprayOrig('ca_santa_barbara_co_ffreplace_20051014');
	fSprayOrig('ct_ffreplace_20051010');
	fSprayOrig('fl_alachua_co_nlj_upd_20051013');
	fSprayOrig('fl_alachua_co_upd_20051013');
	fSprayOrig('fl_hillsborough_co_fullfilereplace_20051010');
	fSprayOrig('fl_lake_co_upd_20051011');
	fSprayOrig('fl_pasco_co_upd_20051012');
	fSprayOrig('ms_hinds_co_upd_20051004');
	fSprayOrig('oh_portage_co_upd_20050913');
	fSprayOrig('tx_potter_co_ffreplace_20051004');
	fSprayOrig('ut_thru_20051018');
	fSprayOrig('va_upd_20050926');
