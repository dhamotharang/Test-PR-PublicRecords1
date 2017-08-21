#workunit('name','Spray Civil Court Files'); 

import lib_stringlib, lib_fileservices, civil_court;

 

fSprayOriga(string pDataname)

 := lib_fileservices.FileServices.sprayfixed('10.150.12.240',

                                             '/stub_cleaning/court/work/out/' + 'civil_case_activity_' + trim(pDataname,left,right) + '.d00',

                                             345,

                                             'thor_200',

                                             '~thor_200::in::civil_' + lib_stringlib.StringLib.stringtolowercase(trim(pDataname)) + '_activity',

                                             ,,,true,true

                                            );
							
					




	fSprayOriga('az_ffreplace_20060711');
	fSprayOriga('ca_la_co_upd_20060720');
	fSprayOriga('ny_downstate_20060802');
	fSprayOriga('ny_upstate_20060802');
	fSprayOriga('ms_harrison_co_20060725');
	fSprayOriga('ct_ffreplace_20060711');	
	fSprayOriga('mi_saginaw_co_20060705');
	
	//fSprayOriga('fl_orange_co_20060623');	
	//fSprayOriga('fl_alachua_co_nlj_upd_20060629');
	//fSprayOriga('va_upd_20060403');
	//fSprayOriga('wa_ltd_juri_civil_court02_upd20060117');

/*********************************************************************************************************************************************/	

	fSprayOrigm(string pDataname)

 := lib_fileservices.FileServices.sprayfixed('10.150.12.240',

                                             '/stub_cleaning/court/work/out/' + 'civil_matter_' + trim(pDataname,left,right) + '.d00',

                                             1004,

                                             'thor_200',

                                             '~thor_200::in::civil_' + lib_stringlib.StringLib.stringtolowercase(trim(pDataname)) + '_matter',

                                             ,,,true,true

                                            );
							
					

	fSprayOrigm('fl_alachua_co_upd_20060727');
	fSprayOrigm('ar_20060727');
	fSprayOrigm('az_ffreplace_20060711');
	fSprayOrigm('ny_downstate_20060802');
	fSprayOrigm('ny_upstate_20060802');
	fSprayOrigm('ct_ffreplace_20060711');
	fSprayOrigm('ca_fresno_co_upd_20060717');
	fSprayOrigm('tx_gregg_co_20060727');
	fSprayOrigm('ms_harrison_co_20060725');
	fSprayOrigm('fl_hillsborough_co_fullfilereplace_20060731');
	fSprayOrigm('ms_hinds_co_upd_20060713');
	fSprayOrigm('ca_la_co_upd_20060720');
	fSprayOrigm('az_maricopa_co_20060802');	
	fSprayOrigm('ca_mendocino_co_20060714');
	fSprayOrigm('fl_orange_co_20060703');
	fSprayOrigm('ca_orange_co_family_upd_2006703');
	fSprayOrigm('fl_pasco_co_upd_20060714');
	fSprayOrigm('oh_portage_co_thru_20060809');	
  fSprayOrigm('tx_potter_co_ffreplace_20060801');	
	fSprayOrigm('mi_saginaw_co_20060705');
	fSprayOrigm('ca_san_luis_obispo_co_ffreplace_20060731');
	fSprayOrigm('ut_thru_20060801');
	fSprayOrigm('tx_victoria_co_20060710');	
  fSprayOrigm('ca_marin_co_20060718');



	//fSprayOrigm('fl_alachua_co_nlj_upd_20060629');
	//fSprayOrigm('ca_santa_barbara_co_ffreplace_20060605');
	//fSprayOrigm('ca_stanislaus_co_20060518');
	//fSprayOrigm('ca_ventura_co_20060602');
	//fSprayOrigm('ct_ffreplace_20060605');
  //fSprayOrigm('wa_ltd_juri_civil_court02_upd20060117');
  //fSprayOrigm('tx_denton_co_20050801');
	//fSprayOrigm('mi_saginaw_co_20060606');
	//fSprayOrigm('fl_pasco_co_upd_20051212');
	//fSprayOrigm('ak_ffreplace_20060612');
	//fSprayOrigm('ca_fresno_co_upd_20060522');
	//fSprayOrigm('ca_orange_co_upd_20060530');
  //fSprayOrigm('ca_san_bernardino_co_upd_20060425');



/*********************************************************************************************************************************************/	

	
	fSprayOrigp(string pDataname)

 := lib_fileservices.FileServices.sprayfixed('10.150.12.240',

                                             '/stub_cleaning/court/work/out/' + 'civil_party_clean_' + trim(pDataname,left,right) + '.d00',

                                             4505,

                                             'thor_200',

                                             '~thor_200::in::civil_' + lib_stringlib.StringLib.stringtolowercase(trim(pDataname)) + '_party',

                                             ,,,true,true

                                            );
							
					




	fSprayOrigp('fl_alachua_co_upd_20060727');
	fSprayOrigp('ar_20060727');
	fSprayOrigp('az_ffreplace_20060711');
	fSprayOrigp('ny_downstate_20060802');
	fSprayOrigp('ny_upstate_20060802');
	fSprayOrigp('ct_ffreplace_20060711');
	fSprayOrigp('ca_fresno_co_upd_20060717');
	fSprayOrigp('tx_gregg_co_20060727');
	fSprayOrigp('ms_harrison_co_20060725');
	fSprayOrigp('fl_hillsborough_co_fullfilereplace_20060731');
	fSprayOrigp('ms_hinds_co_upd_20060713');
	fSprayOrigp('ca_la_co_upd_20060720');
	fSprayOrigp('az_maricopa_co_20060802');	
	fSprayOrigp('ca_mendocino_co_20060714');
	fSprayOrigp('fl_orange_co_20060703');
	fSprayOrigp('ca_orange_co_family_upd_2006703');
	fSprayOrigp('fl_pasco_co_upd_20060714');
	fSprayOrigp('oh_portage_co_thru_20060809');	
  fSprayOrigp('tx_potter_co_ffreplace_20060801');	
	fSprayOrigp('mi_saginaw_co_20060705');
	fSprayOrigp('ca_san_luis_obispo_co_ffreplace_20060731');
	fSprayOrigp('ut_thru_20060801');
	fSprayOrigp('tx_victoria_co_20060710');	
  fSprayOrigp('ca_marin_co_20060718');
/*
	fSprayOrigp('ak_ffreplace_20060515');
	fSprayOrigp('ar_20060601');
	fSprayOrigp('az_ffreplace_20060510');
	fSprayOrigp('az_maricopa_co_20060531');
	fSprayOrigp('ca_fresno_co_upd_20060522');
  fSprayOrigp('ca_fresno_co_upd_20060118');
	fSprayOrigp('ca_kern_co_ffreplace_20060516');
	fSprayOrigp('ca_la_co_upd_20060517');
  fSprayOrigp('ca_marin_co_20050715');
	fSprayOrigp('ca_mendocino_co_20060510');
	fSprayOrigp('ca_orange_co_upd_20060530');
	fSprayOrigp('ca_orange_co_family_upd_2006530');
  fSprayOrigp('ca_san_bernardino_co_upd_20060425');
	fSprayOrigp('ca_san_luis_obispo_co_ffreplace_20060522');
	fSprayOrigp('ca_santa_barbara_co_ffreplace_20060605');
	fSprayOrigp('ca_stanislaus_co_20060518');
	fSprayOrigp('ca_ventura_co_20060602');
	fSprayOrigp('ct_ffreplace_20060605');
	fSprayOrigp('fl_alachua_co_upd_20060601');
	fSprayOrigp('fl_alachua_co_nlj_upd_20060601');
	fSprayOrigp('fl_hillsborough_co_fullfilereplace_20060605');
	fSprayOrigp('fl_lake_co_upd_20060606');
	fSprayOrigp('fl_orange_co_20060508');
  fSprayOrigp('fl_pasco_co_upd_20051212');
	fSprayOrigp('fl_pasco_co_upd_20060515');
	fSprayOrigp('mi_saginaw_co_20060606');
  fSprayOrigp('ms_hinds_co_upd_20060509');
	fSprayOrigp('ny_downstate_20060605');
	fSprayOrigp('ny_upstate_20060606');
	fSprayOrigp('oh_portage_co_thru_20060509');
  fSprayOrigp('tx_denton_co_20050801');
	fSprayOrigp('tx_gregg_co_20060524');
	fSprayOrigp('tx_potter_co_ffreplace_20060502');
	fSprayOrigp('tx_victoria_co_20060508');
	fSprayOrigp('ut_thru_20060530');
  fSprayOrigp('wa_ltd_juri_civil_court02_upd20060117');


	fSprayOrigp('ar_20060125');
	fSprayOrigp('az_ffreplace_20060112');
	fSprayOrigp('az_maricopa_co_20060123');
	fSprayOrigp('ca_fresno_co_upd_20051212');
	fSprayOrigp('ca_fresno_co_upd_20060118');
	fSprayOrigp('ca_kern_co_ffreplace_20051223');
	fSprayOrigp('ca_la_co_upd_20060109');
	fSprayOrigp('ca_marin_co_20050715');
	fSprayOrigp('ca_mendocino_co_20050818');
	fSprayOrigp('ca_orange_co_upd_20060127');
	fSprayOrigp('ca_orange_co_family_upd_20051202')
	fSprayOrigp('ca_san_luis_obispo_co_ffreplace_20051229');
	fSprayOrigp('ca_santa_barbara_co_ffreplace_20060109');
	fSprayOrigp('ca_stanislaus_co_20050809');
	fSprayOrigp('ca_ventura_co_20060104');
	fSprayOrigp('ct_ffreplace_20060109');
	fSprayOrigp('fl_alachua_co_upd_20060105');
	fSprayOrigp('fl_alachua_co_nlj_upd_20060112');
	fSprayOrigp('fl_hillsborough_co_fullfilereplace_20060117');
	fSprayOrigp('fl_lake_co_upd_20060117');
	fSprayOrigp('fl_orange_co_20060106');
	fSprayOrigp('fl_pasco_co_upd_20051212');
	fSprayOrigp('fl_pasco_co_upd_20060112');
	fSprayOrigp('ny_downstate_20060118');
	fSprayOrigp('ny_upstate_20060118');
	fSprayOrigp('oh_portage_co_thru_20060109');
	fSprayOrigp('tx_denton_co_20050801');
	fSprayOrigp('tx_potter_co_ffreplace_20060105');
	fSprayOrigp('tx_gregg_co_20060109');
	fSprayOrigp('tx_victoria_co_20060109');
	fSprayOrigp('ut_thru_20060117');
	fSprayOrigp('wa_ltd_juri_civil_court02_upd20060117');*/
