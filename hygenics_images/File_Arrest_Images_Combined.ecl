import data_services, images;

export File_Arrest_Images_Combined := module

	//Use following code for Production:
		export al_baldwin_arr 			:= Common_IMG_AL('AL', data_services.foreign_prod+'images::in::al_baldwin_arr') 		: persist('images::base::al_baldwin_arr');
		export al_jefferson_arr 		:= Common_IMG_AL('AL', data_services.foreign_prod+'images::in::al_jefferson_arr') 	: persist('images::base::al_jefferson_arr');
		export al_montgomery_arr 		:= Common_IMG_AL('AL', data_services.foreign_prod+'images::in::al_montgomery_arr') 	: persist('images::base::al_montgomery_arr');
		export al_shelby_arr	 			:= Common_IMG_AL('AL', data_services.foreign_prod+'images::in::al_shelby_arr') 		: persist('images::base::al_shelby_arr');
		export al_tuscaloosa_arr 		:= Common_IMG_AL('AL', data_services.foreign_prod+'images::in::al_tuscaloosa_arr') 	: persist('images::base::al_tuscaloosa_arr');
		export ar_washington_arr 		:= Common_IMG_AL('AR', data_services.foreign_prod+'images::in::ar_washington_arr') 	: persist('images::base::ar_washington_arr');
		export az_maricopa_arr 			:= Common_IMG_AL('AZ', data_services.foreign_prod+'images::in::az_maricopa_arr') 		: persist('images::base::az_maricopa_arr');
		export ca_tehama_arr 				:= Common_IMG_AL('CA', data_services.foreign_prod+'images::in::ca_tehama_arr') 		: persist('images::base::ca_tehama_arr');
		export co_pueblo_arr 				:= Common_IMG_AL('CO', data_services.foreign_prod+'images::in::co_pueblo_arr') 		: persist('images::base::co_pueblo_arr');
		export fl_brevard_arr 			:= Common_IMG_AL('FL', data_services.foreign_prod+'images::in::fl_brevard_arr') 		: persist('images::base::fl_brevard_arr');
		export fl_broward_arr 			:= Common_IMG_AL('FL', data_services.foreign_prod+'images::in::fl_broward_arr') 		: persist('images::base::fl_broward_arr');
		export fl_charlotte_arr 		:= Common_IMG_AL('FL', data_services.foreign_prod+'images::in::fl_charlotte_arr') 	: persist('images::base::fl_charlotte_arr');
		export fl_citrus_arr 				:= Common_IMG_AL('FL', data_services.foreign_prod+'images::in::fl_citrus_arr') 		: persist('images::base::fl_citrus_arr');
		export fl_desoto_arr 				:= Common_IMG_AL('FL', data_services.foreign_prod+'images::in::fl_desoto_arr') 		: persist('images::base::fl_desoto_arr');
		export fl_escambia_arr 			:= Common_IMG_AL('FL', data_services.foreign_prod+'images::in::fl_escambia_arr') 		: persist('images::base::fl_escambia_arr');
		export fl_hardee_arr 				:= Common_IMG_AL('FL', data_services.foreign_prod+'images::in::fl_hardee_arr') 		: persist('images::base::fl_hardee_arr');
		export fl_hernando_arr 			:= Common_IMG_AL('FL', data_services.foreign_prod+'images::in::fl_hernando_arr') 		: persist('images::base::fl_hernando_arr');
		export fl_hillsborough_arr 	:= Common_IMG_AL('FL', data_services.foreign_prod+'images::in::fl_hillsborough_arr') 	: persist('images::base::fl_hillsborough_arr');
		export fl_indian_river_arr 	:= Common_IMG_AL('FL', data_services.foreign_prod+'images::in::fl_indian_river_arr') 	: persist('images::base::fl_indian_river_arr');
		export fl_lake_arr 					:= Common_IMG_AL('FL', data_services.foreign_prod+'images::in::fl_lake_arr') 				: persist('images::base::fl_lake_arr');
		export fl_monroe_arr 				:= Common_IMG_AL('FL', data_services.foreign_prod+'images::in::fl_monroe_arr') 		: persist('images::base::fl_monroe_arr');
		export fl_osceola_arr 			:= Common_IMG_AL('FL', data_services.foreign_prod+'images::in::fl_osceola_arr') 		: persist('images::base::fl_osceola_arr');
		export fl_polk_arr 					:= Common_IMG_AL('FL', data_services.foreign_prod+'images::in::fl_polk_arr') 				: persist('images::base::fl_polk_arr');
		export fl_putnam_arr 				:= Common_IMG_AL('FL', data_services.foreign_prod+'images::in::fl_putnam_arr') 		: persist('images::base::fl_putnam_arr');
		export fl_seminole_arr 			:= Common_IMG_AL('FL', data_services.foreign_prod+'images::in::fl_seminole_arr') 		: persist('images::base::fl_seminole_arr');
		export fl_suwannee_arr 			:= Common_IMG_AL('FL', data_services.foreign_prod+'images::in::fl_suwannee_arr') 		: persist('images::base::fl_suwannee_arr');
		export ga_chatham_arr 			:= Common_IMG_AL('GA', data_services.foreign_prod+'images::in::ga_chatham_arr') 		: persist('images::base::ga_chatham_arr');
		export ga_dawson_arr 				:= Common_IMG_AL('GA', data_services.foreign_prod+'images::in::ga_dawson_arr') 		: persist('images::base::ga_dawson_arr');
		export ga_fulton_arr 				:= Common_IMG_AL('GA', data_services.foreign_prod+'images::in::ga_fulton_arr') 		: persist('images::base::ga_fulton_arr');
		export ga_gwinnett_arr 			:= Common_IMG_AL('GA', data_services.foreign_prod+'images::in::ga_gwinnett_arr') 		: persist('images::base::ga_gwinnett_arr');
		export id_ada_arr 					:= Common_IMG_AL('ID', data_services.foreign_prod+'images::in::id_ada_arr') 			: persist('images::base::id_ada_arr');
		export id_canyon_arr 				:= Common_IMG_AL('ID', data_services.foreign_prod+'images::in::id_canyon_arr') 		: persist('images::base::id_canyon_arr');
		export ia_dallas_arr 				:= Common_IMG_AL('IA', data_services.foreign_prod+'images::in::ia_dallas_arr') 		: persist('images::base::ia_dallas_arr');
		export ks_johnson_arr 			:= Common_IMG_AL('KS', data_services.foreign_prod+'images::in::ks_johnson_arr') 		: persist('images::base::ks_johnson_arr');
		export ky_boone_arr 				:= Common_IMG_AL('KY', data_services.foreign_prod+'images::in::ky_boone_arr') 		: persist('images::base::ky_boone_arr');
		export ky_fulton_arr 				:= Common_IMG_AL('KY', data_services.foreign_prod+'images::in::ky_fulton_arr') 		: persist('images::base::ky_fulton_arr');
    export ky_mccracken_arr 		:= Common_IMG_AL('KY', data_services.foreign_prod+'images::in::ky_mccracken_arr') 	: persist('images::base::ky_mccracken_arr');
    export la_lafayette_arr 		:= Common_IMG_AL('LA', data_services.foreign_prod+'images::in::la_lafayette_arr') 	: persist('images::base::la_lafayette_arr');
		export la_ouachita_arr 			:= Common_IMG_AL('LA', data_services.foreign_prod+'images::in::la_ouachita_arr') 		: persist('images::base::la_ouachita_arr');
		export mi_kent_arr 					:= Common_IMG_AL('MI', data_services.foreign_prod+'images::in::mi_kent_arr') 			: persist('images::base::mi_kent_arr');
		export mn_dakota_arr 				:= Common_IMG_AL('MN', data_services.foreign_prod+'images::in::mn_dakota_arr') 		: persist('images::base::mn_dakota_arr');
		export ms_harrison_arr 			:= Common_IMG_AL('MS', data_services.foreign_prod+'images::in::ms_harrison_arr') 		: persist('images::base::ms_harrison_arr');
		export ms_lee_arr 					:= Common_IMG_AL('MS', data_services.foreign_prod+'images::in::ms_lee_arr') 			: persist('images::base::ms_lee_arr');
		export nc_cabarrus_arr 			:= Common_IMG_AL('NC', data_services.foreign_prod+'images::in::nc_cabarrus_arr') 		: persist('images::base::nc_cabarrus_arr');
		export nc_catawba_arr 			:= Common_IMG_AL('NC', data_services.foreign_prod+'images::in::nc_catawba_arr') 		: persist('images::base::nc_catawba_arr');
		export nc_guilford_arr 			:= Common_IMG_AL('NC', data_services.foreign_prod+'images::in::nc_guilford_arr') 		: persist('images::base::nc_guilford_arr');
		export nc_lincoln_arr 			:= Common_IMG_AL('NC', data_services.foreign_prod+'images::in::nc_lincoln_arr') 		: persist('images::base::nc_lincoln_arr');
		export nc_mecklenburg_arr 	:= Common_IMG_AL('NC', data_services.foreign_prod+'images::in::nc_mecklenburg_arr') 	: persist('images::base::nc_mecklenburg_arr');
		export nc_randolph_arr 			:= Common_IMG_AL('NC', data_services.foreign_prod+'images::in::nc_randolph_arr') 		: persist('images::base::nc_randolph_arr');
		export nc_union_arr 				:= Common_IMG_AL('NC', data_services.foreign_prod+'images::in::nc_union_arr') 		: persist('images::base::nc_union_arr');
		export nm_santa_fe_arr 			:= Common_IMG_AL('NM', data_services.foreign_prod+'images::in::nm_santa_fe_arr') 		: persist('images::base::nm_santa_fe_arr');
		export oh_gallia_arr 				:= Common_IMG_AL('OH', data_services.foreign_prod+'images::in::oh_gallia_arr') 		: persist('images::base::oh_gallia_arr');
		export oh_hamilton_arr 			:= Common_IMG_AL('OH', data_services.foreign_prod+'images::in::oh_hamilton_arr') 		: persist('images::base::oh_hamilton_arr');
		export oh_logan_arr 				:= Common_IMG_AL('OH', data_services.foreign_prod+'images::in::oh_logan_arr') 		: persist('images::base::oh_logan_arr');
		export oh_montgomery_arr 		:= Common_IMG_AL('OH', data_services.foreign_prod+'images::in::oh_montgomery_arr') 	: persist('images::base::oh_montgomery_arr');
		export oh_sandusky_arr 			:= Common_IMG_AL('OH', data_services.foreign_prod+'images::in::oh_sandusky_arr') 		: persist('images::base::oh_sandusky_arr');
		export oh_shelby_arr 				:= Common_IMG_AL('OH', data_services.foreign_prod+'images::in::oh_shelby_arr') 		: persist('images::base::oh_shelby_arr');
		export oh_southeast_arr			:= Common_IMG_AL('OH', data_services.foreign_prod+'images::in::oh_southeast_arr') 	: persist('images::base::oh_southeast_arr');
		export ok_carter_arr 				:= Common_IMG_AL('OK', data_services.foreign_prod+'images::in::ok_carter_arr') 		: persist('images::base::ok_carter_arr');
		export ok_osage_arr 				:= Common_IMG_AL('OK', data_services.foreign_prod+'images::in::ok_osage_arr') 		: persist('images::base::ok_osage_arr');
		export or_clackamas_arr 		:= Common_IMG_AL('OR', data_services.foreign_prod+'images::in::or_clackamas_arr') 	: persist('images::base::or_clackamas_arr');
		export or_jackson_arr 			:= Common_IMG_AL('OR', data_services.foreign_prod+'images::in::or_jackson_arr') 		: persist('images::base::or_jackson_arr');
		export or_josephine_arr 		:= Common_IMG_AL('OR', data_services.foreign_prod+'images::in::or_josephine_arr') 	: persist('images::base::or_josephine_arr');
		export or_lane_arr 					:= Common_IMG_AL('OR', data_services.foreign_prod+'images::in::or_lane_arr') 			: persist('images::base::or_lane_arr');
		export or_lincoln_arr 			:= Common_IMG_AL('OR', data_services.foreign_prod+'images::in::or_lincoln_arr') 		: persist('images::base::or_lincoln_arr');
		export or_morrow_arr 				:= Common_IMG_AL('OR', data_services.foreign_prod+'images::in::or_morrow_arr') 		: persist('images::base::or_morrow_arr');
		export or_multnomah_arr 		:= Common_IMG_AL('OR', data_services.foreign_prod+'images::in::or_multnomah_arr') 	: persist('images::base::or_multnomah_arr');
		export or_polk_arr 					:= Common_IMG_AL('OR', data_services.foreign_prod+'images::in::or_polk_arr') 			: persist('images::base::or_polk_arr');
		export or_umatilla_arr 			:= Common_IMG_AL('OR', data_services.foreign_prod+'images::in::or_umatilla_arr') 		: persist('images::base::or_umatilla_arr');
		export or_yamhill_arr 			:= Common_IMG_AL('OR', data_services.foreign_prod+'images::in::or_yamhill_arr') 		: persist('images::base::or_yamhill_arr');
		export sc_cherokee_arr 			:= Common_IMG_AL('SC', data_services.foreign_prod+'images::in::sc_cherokee_arr') 		: persist('images::base::sc_cherokee_arr');
		export sc_florence_arr 			:= Common_IMG_AL('SC', data_services.foreign_prod+'images::in::sc_florence_arr') 		: persist('images::base::sc_florence_arr');
		export sc_richland_arr 			:= Common_IMG_AL('SC', data_services.foreign_prod+'images::in::sc_richland_arr') 		: persist('images::base::sc_richland_arr');
		export sc_york_arr 					:= Common_IMG_AL('SC', data_services.foreign_prod+'images::in::sc_york_arr') 			: persist('images::base::sc_york_arr');
		export tn_montgomery_arr 		:= Common_IMG_AL('TN', data_services.foreign_prod+'images::in::tn_montgomery_arr') 	: persist('images::base::tn_montgomery_arr');
		export tx_brazoria_arr 			:= Common_IMG_AL('TX', data_services.foreign_prod+'images::in::tx_brazoria_arr') 		: persist('images::base::tx_brazoria_arr');
		export tx_cameron_arr 			:= Common_IMG_AL('TX', data_services.foreign_prod+'images::in::tx_cameron_arr') 		: persist('images::base::tx_cameron_arr');
		export tx_denton_arr 				:= Common_IMG_AL('TX', data_services.foreign_prod+'images::in::tx_denton_arr') 		: persist('images::base::tx_denton_arr');
		export tx_gregg_arr 				:= Common_IMG_AL('TX', data_services.foreign_prod+'images::in::tx_gregg_arr') 		: persist('images::base::tx_gregg_arr');
		export tx_parker_arr 				:= Common_IMG_AL('TX', data_services.foreign_prod+'images::in::tx_parker_arr') 		: persist('images::base::tx_parker_arr');
		export tx_smith_arr 				:= Common_IMG_AL('TX', data_services.foreign_prod+'images::in::tx_smith_arr') 		: persist('images::base::tx_smith_arr');
		export ut_iron_arr 					:= Common_IMG_AL('UT', data_services.foreign_prod+'images::in::ut_iron_arr') 				: persist('images::base::ut_iron_arr');
		export ut_washington_arr 		:= Common_IMG_AL('UT', data_services.foreign_prod+'images::in::ut_washington_arr') 	: persist('images::base::ut_washington_arr');
    export ut_ut_arr 		        := Common_IMG_AL('UT', data_services.foreign_prod+'images::in::ut_utah_arr') 	        : persist('images::base::ut_utah_arr');
		export wv_regional_arr 			:= Common_IMG_AL('WV', data_services.foreign_prod+'images::in::wv_regional_arr') 		: persist('images::base::wv_regional_arr');
	  export ky_monroe_arr        := Common_IMG_AL('KY', data_services.foreign_prod+'images::in::ky_monroe_arr') 		  : persist('images::base::ky_monroe_arr');
	   
		export ARR_Concat_All			:= al_baldwin_arr + 	
																	al_jefferson_arr + 
																	al_montgomery_arr + 
																	al_shelby_arr + 
																	al_tuscaloosa_arr + 
																	ar_washington_arr +
																	az_maricopa_arr + 
																	ca_tehama_arr + 
																	co_pueblo_arr + 
																	fl_brevard_arr + 
																	fl_broward_arr + 
																	fl_charlotte_arr + 
																	fl_citrus_arr + 
																	fl_desoto_arr + 
																	fl_escambia_arr + 
																	fl_hardee_arr + 
																	fl_hernando_arr + 
																	fl_hillsborough_arr + 
																	fl_indian_river_arr + 
																	fl_lake_arr + 
																	fl_monroe_arr + 
																	fl_osceola_arr + 
																	fl_polk_arr + 
																	fl_putnam_arr + 
																	fl_seminole_arr + 
																	fl_suwannee_arr + 
																	ga_chatham_arr + 
																	ga_dawson_arr + 
																	ga_fulton_arr + 
																	ga_gwinnett_arr + 
																	id_ada_arr + 
																	id_canyon_arr + 
																	ia_dallas_arr + 
																	ks_johnson_arr + 
																	ky_boone_arr + 
																	ky_fulton_arr + 
																	ky_mccracken_arr + 
																	la_lafayette_arr + // added 20130102 VC
																	la_ouachita_arr +
																	mi_kent_arr +
																	mn_dakota_arr +
																	ms_harrison_arr + 
																	ms_lee_arr + 
																	nm_santa_fe_arr + 
																	nc_cabarrus_arr + 
																	nc_catawba_arr + 
																	nc_guilford_arr + 
																	nc_lincoln_arr + 
																	nc_mecklenburg_arr +
																	nc_randolph_arr +
																	nc_union_arr + 
																	oh_gallia_arr + 
																	oh_hamilton_arr + 
																	oh_logan_arr + 
																	oh_montgomery_arr + 
																	oh_sandusky_arr + 
																	oh_shelby_arr + 
																	oh_southeast_arr + 
																	ok_carter_arr + 
																	ok_osage_arr + 
																	or_clackamas_arr + 
																	or_jackson_arr + 
																	or_josephine_arr + 
																	or_lane_arr + 
																	or_lincoln_arr + 
																	or_morrow_arr + 
																	or_multnomah_arr + 
																	or_polk_arr + 
																	or_umatilla_arr + 
																	or_yamhill_arr + 
																	sc_cherokee_arr + 
																	sc_florence_arr + 
																	sc_richland_arr + 
																	sc_york_arr + 
																	tn_montgomery_arr + 
																	tx_brazoria_arr + 
																	tx_cameron_arr + 
																	tx_denton_arr + 
																	tx_gregg_arr + 
																	tx_parker_arr + 
																	tx_smith_arr + 
																	ut_iron_arr + 
																	ut_ut_arr + // added 20130102 VC
																	ut_washington_arr +
																	wv_regional_arr+
																	ky_monroe_arr:persist('~thor400_84::persist::arr_concat_all');
	end;