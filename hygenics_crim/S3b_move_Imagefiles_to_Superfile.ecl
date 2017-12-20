import Hygenics_images;

////////////////////////////////////////////////////////////////////////////////
//move image files. Do this after running the bat
////////////////////////////////////////////////////////////////////////////////		
		filedate := '20130703';

		sequential(Hygenics_images.move_crim_image_files('ar_doc', filedate),
			Hygenics_images.move_crim_image_files('co_doc', filedate),
			Hygenics_images.move_crim_image_files('fl_doc', filedate),
			Hygenics_images.move_crim_image_files('ga_doc_parole', filedate),
			Hygenics_images.move_crim_image_files('ks_doc', filedate),
			Hygenics_images.move_crim_image_files('ky_doc_website', filedate),
			Hygenics_images.move_crim_image_files('mi_doc_website', filedate),
			Hygenics_images.move_crim_image_files('ms_doc_website', filedate),
			Hygenics_images.move_crim_image_files('ms_doc_parole', filedate),
			Hygenics_images.move_crim_image_files('mt_doc', filedate),
			Hygenics_images.move_crim_image_files('nc_doc_website', filedate),
			Hygenics_images.move_crim_image_files('nd_doc', filedate),
			Hygenics_images.move_crim_image_files('nj_doc', filedate),
			Hygenics_images.move_crim_image_files('nm_doc', filedate),
			Hygenics_images.move_crim_image_files('oh_doc_website', filedate),
			Hygenics_images.move_crim_image_files('ok_doc', filedate),
			Hygenics_images.move_crim_image_files('ok_doc_vor', filedate),
			Hygenics_images.move_crim_image_files('sc_doc', filedate),
		  Hygenics_images.move_crim_image_files('ut_doc', filedate),
			Hygenics_images.move_crim_image_files('wv_doc', filedate),
			Hygenics_images.move_crim_image_files('wv_doc_alt', filedate),
			Hygenics_images.move_crim_image_files('ga_par_rel', filedate)
			);			
			
			
			filedate_a := filedate + 'a';

			Hygenics_images.move_crim_image_files('fl_doc', filedate_a);
	
	    filedate_b := filedate + 'b';

		  Hygenics_images.move_crim_image_files('fl_doc', filedate_b);

		  filedate_c := filedate + 'c';

			Hygenics_images.move_crim_image_files('fl_doc', filedate_c);			

	

   //filedate := '20130507';

		sequential(Hygenics_images.move_crim_image_files('al_baldwin_arr', filedate),
			Hygenics_images.move_crim_image_files('al_jefferson_arr', filedate),
			Hygenics_images.move_crim_image_files('al_montgomery_arr', filedate),
			Hygenics_images.move_crim_image_files('al_shelby_arr', filedate),
			Hygenics_images.move_crim_image_files('al_tuscaloosa_arr', filedate),
			Hygenics_images.move_crim_image_files('ar_washington_arr', filedate),
			Hygenics_images.move_crim_image_files('az_maricopa_arr', filedate),
		  Hygenics_images.move_crim_image_files('ca_doc_and_reh', filedate),
			Hygenics_images.move_crim_image_files('ca_tehama_arr', filedate),
			Hygenics_images.move_crim_image_files('co_pueblo_arr', filedate),
			Hygenics_images.move_crim_image_files('fl_brevard_arr', filedate),
			Hygenics_images.move_crim_image_files('fl_broward_arr', filedate),
			Hygenics_images.move_crim_image_files('fl_charlotte_arr', filedate),
			Hygenics_images.move_crim_image_files('fl_citrus_arr', filedate),
			Hygenics_images.move_crim_image_files('fl_desoto_arr', filedate),
			Hygenics_images.move_crim_image_files('fl_escambia_arr', filedate),
			Hygenics_images.move_crim_image_files('fl_hardee_arr', filedate),
			Hygenics_images.move_crim_image_files('fl_hernando_arr', filedate),
			Hygenics_images.move_crim_image_files('fl_hillsborough_arr', filedate),
			Hygenics_images.move_crim_image_files('fl_indian_river_arr', filedate),
			Hygenics_images.move_crim_image_files('fl_lake_arr', filedate),
			Hygenics_images.move_crim_image_files('fl_monroe_arr', filedate),
			Hygenics_images.move_crim_image_files('fl_osceola_arr', filedate),
			Hygenics_images.move_crim_image_files('fl_polk_arr', filedate),
			Hygenics_images.move_crim_image_files('fl_putnam_arr', filedate),
			Hygenics_images.move_crim_image_files('fl_seminole_arr', filedate),
			Hygenics_images.move_crim_image_files('fl_suwannee_arr', filedate),
			Hygenics_images.move_crim_image_files('ga_chatham_arr', filedate),
			Hygenics_images.move_crim_image_files('ga_dawson_arr', filedate),
			Hygenics_images.move_crim_image_files('ga_fulton_arr', filedate),
			Hygenics_images.move_crim_image_files('ga_gwinnett_arr', filedate),
			Hygenics_images.move_crim_image_files('ia_dallas_arr', filedate),
			Hygenics_images.move_crim_image_files('id_ada_arr', filedate),
			Hygenics_images.move_crim_image_files('id_canyon_arr', filedate),
			Hygenics_images.move_crim_image_files('ks_johnson_arr', filedate),
			Hygenics_images.move_crim_image_files('ky_boone_arr', filedate),
			Hygenics_images.move_crim_image_files('ky_fulton_arr', filedate),
			Hygenics_images.move_crim_image_files('ky_mccracken_arr', filedate),
			Hygenics_images.move_crim_image_files('ky_monroe_arr', filedate),
			Hygenics_images.move_crim_image_files('la_ouachita_arr', filedate),
			Hygenics_images.move_crim_image_files('mi_kent_arr', filedate),
			Hygenics_images.move_crim_image_files('mn_dakota_arr', filedate),
			Hygenics_images.move_crim_image_files('ms_harrison_arr', filedate),
			Hygenics_images.move_crim_image_files('ms_lee_arr', filedate),
			Hygenics_images.move_crim_image_files('nc_cabarrus_arr', filedate),
			Hygenics_images.move_crim_image_files('nc_catawba_arr', filedate),
			Hygenics_images.move_crim_image_files('nc_guilford_arr', filedate),
			Hygenics_images.move_crim_image_files('nc_lincoln_arr', filedate),
			Hygenics_images.move_crim_image_files('nc_mecklenburg_arr', filedate),
			Hygenics_images.move_crim_image_files('nc_randolph_arr', filedate),
			Hygenics_images.move_crim_image_files('nc_union_arr', filedate),
			Hygenics_images.move_crim_image_files('nm_santa_fe_arr', filedate),
			Hygenics_images.move_crim_image_files('oh_gallia_arr', filedate),
			Hygenics_images.move_crim_image_files('oh_hamilton_arr', filedate),
			Hygenics_images.move_crim_image_files('oh_logan_arr', filedate),
			Hygenics_images.move_crim_image_files('oh_montgomery_arr', filedate),
			Hygenics_images.move_crim_image_files('oh_sandusky_arr', filedate),
			Hygenics_images.move_crim_image_files('oh_shelby_arr', filedate),
			Hygenics_images.move_crim_image_files('oh_southeast_arr', filedate),
			Hygenics_images.move_crim_image_files('ok_carter_arr', filedate),
			Hygenics_images.move_crim_image_files('ok_osage_arr', filedate),
			Hygenics_images.move_crim_image_files('or_clackamas_arr', filedate),
			Hygenics_images.move_crim_image_files('or_jackson_arr', filedate),
			Hygenics_images.move_crim_image_files('or_josephine_arr', filedate),
			Hygenics_images.move_crim_image_files('or_lane_arr', filedate),
			Hygenics_images.move_crim_image_files('or_lincoln_arr', filedate),
			Hygenics_images.move_crim_image_files('or_morrow_arr', filedate),
			Hygenics_images.move_crim_image_files('or_multnomah_arr', filedate),
			Hygenics_images.move_crim_image_files('or_polk_arr', filedate),
			Hygenics_images.move_crim_image_files('or_umatilla_arr', filedate),
			Hygenics_images.move_crim_image_files('or_yamhill_arr', filedate),
			Hygenics_images.move_crim_image_files('sc_cherokee_arr', filedate),
			Hygenics_images.move_crim_image_files('sc_florence_arr', filedate),
			Hygenics_images.move_crim_image_files('sc_richland_arr', filedate),
			Hygenics_images.move_crim_image_files('sc_york_arr', filedate),
			Hygenics_images.move_crim_image_files('tn_montgomery_arr', filedate),
			Hygenics_images.move_crim_image_files('tx_brazoria_arr', filedate),
			Hygenics_images.move_crim_image_files('tx_cameron_arr', filedate),
			Hygenics_images.move_crim_image_files('tx_denton_arr', filedate),
			Hygenics_images.move_crim_image_files('tx_gregg_arr', filedate),
			Hygenics_images.move_crim_image_files('tx_parker_arr', filedate),
			Hygenics_images.move_crim_image_files('tx_smith_arr', filedate),
			Hygenics_images.move_crim_image_files('ut_iron_arr', filedate),
			Hygenics_images.move_crim_image_files('ut_washington_arr', filedate),
			Hygenics_images.move_crim_image_files('wv_regional_arr', filedate),
			
			
			Hygenics_images.move_crim_image_files('la_lafayette_arr', filedate),
			Hygenics_images.move_crim_image_files('ut_utah_arr', filedate)
			
			);


   /*******************************AOC***************************************/
	 sequential(Hygenics_images.move_crim_image_files('ut_whitecollar_or', filedate);
	 )