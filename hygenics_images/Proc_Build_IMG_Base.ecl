import ut, RoxieKeyBuild, images, crim_common, hygenics_crim, corrections,data_services;

export Proc_Build_IMG_base(string filedate):= function

//PROCESS ARRESTLONG IMAGES/////////////////////////
	
/*	export Common_IMG_AL(STRING2 state, STRING fname) := FUNCTION

		injpg := RECORD, MAXLENGTH(100000000)
			STRING   filename;
			UNSIGNED4 imgLength;
			images.JPEG(SELF.imgLength) photo;
		END;

	ds1 := dataset(fname,injpg,flat);
	//ds1a 	:= ds1(imgLength <= 49000);

	images.MAC_ShrinkImage(ds1,filename,imgLength,photo,ds1b);
	ds2 := sort(distribute(ds1b, hash(filename)), filename, local);

	//Base Offender File
	ds 	:= dataset('~thor_data400::base::corrections_offenders_public', corrections.layout_offender, flat)(trim(image_link,left,right) <> '');

		rec := RECORD
			STRING offender_key;
			string state_origin;
			string filename;
		END;
	
		rec slimFile(ds l):= transform
		  self.state_origin := ut.st2abbrev(stringlib.stringtouppercase(l.orig_state));
			self.filename 	:= l.image_link;
			self 			:= l;
		end;

	File_IMG_CommonIn 	:= project(ds, slimFile(left));
	File_IMG_CommonInf	:= distribute(File_IMG_CommonIn, hash(filename));

	Layout_Common getspk(File_IMG_CommonInf le, ds2 ri) := TRANSFORM
		SELF.did 			:= 0;
		SELF.state 		:= state;
		SELF.rtype 		:= 'AL';
		SELF.id 			:= le.offender_key;
		SELF.seq 			:= 0;
		SELF.date 		:= '';
		SELF.num 			:= 1;
		self.image_link := le.filename;
		SELF.imgLength 	:= ri.imgLength;
		SELF.photo 		:= ri.photo;
	END;

	j := JOIN(File_IMG_CommonInf, ds2, 
				LEFT.filename=RIGHT.filename AND 
				LEFT.state_origin=state, 
				getspk(LEFT,RIGHT), local);//, LOOKUP);
																		
	RETURN j;

	END;

	export File_arrest_Images_Combined := module

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
		export ok_osage_arr 				:= Common_IMG_AL('OK', data_services.foreign_prod+'images::in::ok_osage_arr') 		  : persist('images::base::ok_osage_arr');
		export or_clackamas_arr 		:= Common_IMG_AL('OR', data_services.foreign_prod+'images::in::or_clackamas_arr') 	: persist('images::base::or_clackamas_arr');
		export or_jackson_arr 			:= Common_IMG_AL('OR', data_services.foreign_prod+'images::in::or_jackson_arr') 		: persist('images::base::or_jackson_arr');
		export or_josephine_arr 		:= Common_IMG_AL('OR', data_services.foreign_prod+'images::in::or_josephine_arr') 	: persist('images::base::or_josephine_arr');
		export or_lane_arr 					:= Common_IMG_AL('OR', data_services.foreign_prod+'images::in::or_lane_arr') 			  : persist('images::base::or_lane_arr');
		export or_lincoln_arr 			:= Common_IMG_AL('OR', data_services.foreign_prod+'images::in::or_lincoln_arr') 		: persist('images::base::or_lincoln_arr');
		export or_morrow_arr 				:= Common_IMG_AL('OR', data_services.foreign_prod+'images::in::or_morrow_arr') 		  : persist('images::base::or_morrow_arr');
		export or_multnomah_arr 		:= Common_IMG_AL('OR', data_services.foreign_prod+'images::in::or_multnomah_arr') 	: persist('images::base::or_multnomah_arr');
		export or_polk_arr 					:= Common_IMG_AL('OR', data_services.foreign_prod+'images::in::or_polk_arr') 			  : persist('images::base::or_polk_arr');
		export or_umatilla_arr 			:= Common_IMG_AL('OR', data_services.foreign_prod+'images::in::or_umatilla_arr') 		: persist('images::base::or_umatilla_arr');
		export or_yamhill_arr 			:= Common_IMG_AL('OR', data_services.foreign_prod+'images::in::or_yamhill_arr') 		: persist('images::base::or_yamhill_arr');
		export sc_cherokee_arr 			:= Common_IMG_AL('SC', data_services.foreign_prod+'images::in::sc_cherokee_arr') 		: persist('images::base::sc_cherokee_arr');
		export sc_florence_arr 			:= Common_IMG_AL('SC', data_services.foreign_prod+'images::in::sc_florence_arr') 		: persist('images::base::sc_florence_arr');
		export sc_richland_arr 			:= Common_IMG_AL('SC', data_services.foreign_prod+'images::in::sc_richland_arr') 		: persist('images::base::sc_richland_arr');
		export sc_york_arr 					:= Common_IMG_AL('SC', data_services.foreign_prod+'images::in::sc_york_arr') 			  : persist('images::base::sc_york_arr');
		export tn_montgomery_arr 		:= Common_IMG_AL('TN', data_services.foreign_prod+'images::in::tn_montgomery_arr') 	: persist('images::base::tn_montgomery_arr');
		export tx_brazoria_arr 			:= Common_IMG_AL('TX', data_services.foreign_prod+'images::in::tx_brazoria_arr') 		: persist('images::base::tx_brazoria_arr');
		export tx_cameron_arr 			:= Common_IMG_AL('TX', data_services.foreign_prod+'images::in::tx_cameron_arr') 		: persist('images::base::tx_cameron_arr');
		export tx_denton_arr 				:= Common_IMG_AL('TX', data_services.foreign_prod+'images::in::tx_denton_arr') 		  : persist('images::base::tx_denton_arr');
		export tx_gregg_arr 				:= Common_IMG_AL('TX', data_services.foreign_prod+'images::in::tx_gregg_arr') 		  : persist('images::base::tx_gregg_arr');
		export tx_parker_arr 				:= Common_IMG_AL('TX', data_services.foreign_prod+'images::in::tx_parker_arr') 		  : persist('images::base::tx_parker_arr');
		export tx_smith_arr 				:= Common_IMG_AL('TX', data_services.foreign_prod+'images::in::tx_smith_arr') 		  : persist('images::base::tx_smith_arr');
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

//PROCESS DOC IMAGES/////////////////////////

	export Common_IMG_DC(STRING2 state, STRING fname) := FUNCTION

		injpg := RECORD, MAXLENGTH(100000000)
			STRING   filename;
			UNSIGNED4 imgLength;
			images.JPEG(SELF.imgLength) photo;
		END;

		ds1 	:= dataset(fname,injpg,flat);
		//ds1a 	:= ds1(imgLength <= 49000);

		images.MAC_ShrinkImage(ds1,filename,imgLength,photo,ds1b);
		ds2 := distribute(ds1b, hash(filename));

		//Base Offender File
		ds 	:= dataset('~thor_data400::base::corrections_offenders_public', corrections.layout_offender, flat)(trim(image_link,left,right) <> '');

		rec := RECORD
			STRING offender_key;
			string state_origin;
			string filename;
		END;
	
		rec slimFile(ds l):= transform
		  self.state_origin := ut.st2abbrev(stringlib.stringtouppercase(l.orig_state));
			self.filename 		:= l.image_link;
			self 							:= l;
		end;

	File_IMG_CommonIn 	:= project(ds, slimFile(left));
	File_IMG_CommonInf	:= distribute(File_IMG_CommonIn, hash(filename));

	Layout_Common getspk(File_IMG_CommonInf le, ds2 ri) := TRANSFORM
		SELF.did 			:= 0;
		SELF.state 		:= state;
		SELF.rtype 		:= 'DC';
		SELF.id 			:= le.offender_key;
		SELF.seq 			:= 0;
		SELF.date 		:= '';
		SELF.num 			:= 1;
		self.image_link := le.filename;
		SELF.imgLength 	:= ri.imgLength;
		SELF.photo 		:= ri.photo;
	END;

	j := JOIN(File_IMG_CommonInf, ds2, 
				LEFT.filename=RIGHT.filename AND 
				LEFT.state_origin=state, 
				getspk(LEFT,RIGHT), local);//, LOOKUP);
																		
	RETURN j;

	END;

	export File_doc_Images_Combined := module

		export ar_doc 				:= Common_IMG_DC('AR', data_services.foreign_prod+'images::in::ar_doc') 			: persist('images::base::ar_doc');
		export co_doc 				:= Common_IMG_DC('CO', data_services.foreign_prod+'images::in::co_doc') 			: persist('images::base::co_doc');
		export fl_doc 				:= Common_IMG_DC('FL', data_services.foreign_prod+'images::in::fl_doc') 			: persist('images::base::fl_doc');
		export ga_doc_parole	:= Common_IMG_DC('GA', data_services.foreign_prod+'images::in::ga_doc_parole') 		: persist('images::base::ga_doc_parole');
		export ga_doc_website	:= Common_IMG_DC('GA', data_services.foreign_prod+'images::in::ga_doc_website') 	: persist('images::base::ga_doc_website');
		export ks_doc 				:= Common_IMG_DC('KS', data_services.foreign_prod+'images::in::ks_doc') 			: persist('images::base::ks_doc');
		export ms_doc_website := Common_IMG_DC('MS', data_services.foreign_prod+'images::in::ms_doc_website') 	: persist('images::base::ms_doc_website');
		export mt_doc 				:= Common_IMG_DC('MT', data_services.foreign_prod+'images::in::mt_doc') 			: persist('images::base::mt_doc');
		export nc_doc_website := Common_IMG_DC('NC', data_services.foreign_prod+'images::in::nc_doc_website') 	: persist('images::base::nc_doc_website');
		export nd_doc 				:= Common_IMG_DC('ND', data_services.foreign_prod+'images::in::nd_doc') 			: persist('images::base::nd_doc');
		export nj_doc 				:= Common_IMG_DC('NJ', data_services.foreign_prod+'images::in::nj_doc') 			: persist('images::base::nj_doc');
		export nm_doc 				:= Common_IMG_DC('NM', data_services.foreign_prod+'images::in::nm_doc') 			: persist('images::base::nm_doc');
		export oh_doc_website := Common_IMG_DC('OH', data_services.foreign_prod+'images::in::oh_doc_website') 	: persist('images::base::oh_doc_website');
		export ok_doc 				:= Common_IMG_DC('OK', data_services.foreign_prod+'images::in::ok_doc') 			: persist('images::base::ok_doc');
		export sc_doc 				:= Common_IMG_DC('SC', data_services.foreign_prod+'images::in::sc_doc') 			: persist('images::base::sc_doc');
		export ut_doc 				:= Common_IMG_DC('UT', data_services.foreign_prod+'images::in::ut_doc') 			: persist('images::base::ut_doc');
		export wv_doc 				:= Common_IMG_DC('WV', data_services.foreign_prod+'images::in::wv_doc') 			: persist('images::base::wv_doc');
		export wv_doc_alt 		:= Common_IMG_DC('WV', data_services.foreign_prod+'images::in::wv_doc_alt') 		: persist('images::base::wv_doc_alt');
		
		export ky_doc_website	:= Common_IMG_DC('KY', data_services.foreign_prod+'images::in::ky_doc_website') : persist('images::base::ky_doc_website');
	  export ok_doc_vor 	  := Common_IMG_DC('OK', data_services.foreign_prod+'images::in::ok_doc_vor') 		: persist('images::base::ok_doc_vor');
	  export ms_DOC_Par     := Common_IMG_DC('MS', data_services.foreign_prod+'images::in::ms_doc_parole') 	: persist('images::base::ms_doc_parole');
		export mi_doc_website := Common_IMG_DC('MI', data_services.foreign_prod+'images::in::mi_doc_website') : persist('images::base::mi_doc_website');
	
		export DOC_Concat_All	:= ar_doc + 
															co_doc + 
															fl_doc + 
															ga_doc_parole + 
															//ga_doc_website +  VC 20130823
															ks_doc + 
															ms_doc_website +  
															mt_doc + 
															nc_doc_website + 
															nd_doc +
															nj_doc +
															nm_doc +
															oh_doc_website + 
															ok_doc + 
															sc_doc + 
															ut_doc + 
															wv_doc + 
															wv_doc_alt+
															ky_doc_website+
								              ok_doc_vor+
								              ms_DOC_Par+
															mi_doc_website:persist('~thor400_84::persist::doc_concat_all');
 
	end;*/

/*
EXPORT integer8 hygenics_images__maxlength_fullimage := 150000;

EXPORT hygenics_images__jpeg(integer8 len) := TYPE
 EXPORT data load(data dd) := dd[1..len];
 EXPORT integer8 physicallength(data dd) := len;
 EXPORT data store(data dd) := dd[1..len];
END;

dslayout :=RECORD
,maxLength(hygenics_images__maxlength_fullimage)
  unsigned6 did;
  string2 state;
  string2 rtype;
  string60 id;
  unsigned2 seq;
  string8 date;
  unsigned2 num;
  string image_link;
  unsigned4 imglength;
  hygenics_images__jpeg(SELF.imglength) photo;
 END;
 
arr_all := dataset('~thor400_84::persist::arr_concat_all', dslayout, flat);
doc_all := dataset('~thor400_84::persist::doc_concat_all', dslayout, flat); 
*/

//CONCAT IMAGES/////////////////////////

	_all_images := File_arrest_Images_Combined.ARR_Concat_All + File_doc_Images_Combined.DOC_Concat_All;

	// Make sure the id's are left justified
	Layout_Common trimmer(_all_images L) := TRANSFORM
		SELF.id := TRIM(L.id, ALL);
		SELF := L;
	END;

	trimmed := PROJECT(_all_images, trimmer(LEFT));

	Layout_Common get_dids(trimmed l, hygenics_images.File_idDID R) := transform
		self.did := R.did;
		self := L;
	end;

	// switched this proc from an output to a persist...need an action for the sequential
	// so outputting the first record to force the persist to build...
	prebuild := output(choosen(hygenics_images.proc_build_idDID,1));

	withdid_join := join(trimmed, hygenics_images.File_idDID, 
										left.state = right.state and
										left.rtype = right.rtype and
										left.id = right.id,
										get_dids(LEFT,RIGHT), left outer, hash);
						
	withd 			 := withdid_join(image_link<>'' and imglength>0);
	withdids 		 := dedup(sort(withd, record), record);
	
	doc_num_only := withdids(rtype in ['DC']);
	
	doc_num_only fixId(doc_num_only l):= transform
		self.id := l.id[3..];
		self := l;
	end;
	
	doc_num_file := project(doc_num_only, fixId(left));
	
	withdid := withdids + doc_num_file;
	
	//Add Image Date//////////////////////////////////////////////////////////////
	// ds_img 	:= sort(withdid(rtype='DC'), hash(state, image_link), state, image_link);
	ds_img 	:= withdid(rtype='DC');
	ds_doc 	:= hygenics_crim.file_in_defendant_doc(photoname<>'');

	imglnk_layout := record
		ds_doc;
		string imagelink;
		string photodate;
	end;

	//DOC
	imglnk_layout addVend(ds_doc l):= transform
		vVendor 				:= hygenics_crim._functions.fn_sourcename_to_vendor(trim(l.sourcename),l.statecode);
		
		self.photoname 	:= if(trim(l.photoname, left, right)<>'',
																StringLib.StringToUpperCase(vVendor+'_'+l.photoname),
																'');
		self.imagelink	:= '';
				
		self.photodate	:= if(regexfind('PHOTO DATE:', l.defendantadditionalinfo, 0)<>'',
													trim(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'PHOTO DATE:', 1)+12..stringlib.stringfind(l.defendantadditionalinfo, 'PHOTO DATE:', 1)+20]),
													l.institutionreceiptdate);
		self 						:= l;
	end;

	// doc_addDate := sort(distribute(project(ds_doc, addVend(left)), hash(statecode, photoname)), statecode, photoname,local);
	doc_addDate := project(ds_doc, addVend(left));
	
	withdid addDt(ds_img l, doc_addDate r) := transform
		self.date				:= if(r.photodate[1..2] in ['19','20'],
														r.photodate,
														'');
		self 						:= l;	
	end;
	
	doc_match 				:= join(ds_img, doc_addDate, 
													trim(left.state,left,right) = stringlib.StringToUpperCase(trim(right.statecode,left,right)) and																										
													trim(left.image_link,left,right) = trim(right.photoname,left,right), 
													addDt(left,right), 
													left outer, keep(1)):persist('~thor400_20::persist::doc_image_base');

	//Arrest File//////////////////////////////////////////////////////////////
	// ds_img_a 	:= sort(withdid(rtype='AL'), hash(state, image_link), state, image_link);
	ds_img_a 	:= withdid(rtype='AL');
	ds_arr 		:= hygenics_crim.file_in_defendant_arrests(photoname<>'');
	ds_chg		:= hygenics_crim.file_in_charge_arrests;

	imglnk_layout2 := record
		ds_arr;
		string imagelink;
		string photodate;
	end;

	//Arrest
	imglnk_layout2 addVendr(ds_arr l):= transform
		vVendor 				:= hygenics_crim._functions.fn_sourcename_to_vendor(trim(l.sourcename),l.statecode);
		
		 self.photoname	:=  if(trim(l.photoname, left, right)<>'' and trim(l.sourcename, left, right)<>'FLORIDA_BREVARD_COUNTY_ARRESTS',
														StringLib.StringToUpperCase(vVendor+'_'+l.photoname),
													if(trim(l.photoname, left, right)<>'' and regexfind(',', l.photoname, 0)<>'' and trim(l.sourcename, left, right)='FLORIDA_BREVARD_COUNTY_ARRESTS',
														StringLib.StringToUpperCase(vVendor+'_'+l.photoname[1..DataLib.StringFind(l.photoname, ',', 1)]),
													if(trim(l.photoname, left, right)<>'' and regexfind(',', l.photoname, 0)='' and trim(l.sourcename, left, right)='FLORIDA_BREVARD_COUNTY_ARRESTS',
														StringLib.StringToUpperCase(vVendor+'_'+l.photoname),
														'')));
		self.photodate	:= '';
		self.imagelink	:= '';
		self 						:= l;
	end;

	arr_addVendor := project(ds_arr, addVendr(left));
	
	addChgLayout := record
		arr_addVendor;
		string20	BookingNumber;
		string8		ArrestDate;
		string8		BookingDate;
	end;

	addChgLayout addField(arr_addVendor l, ds_chg r):= transform
		self 								:= l;
		self.bookingnumber 	:= r.bookingnumber;
		self.arrestdate			:= r.arrestdate;
		self.bookingdate 		:= r.bookingdate;
	end;
	
	slim_AllOff 	:= join(arr_addVendor, ds_chg,
												left.statecode=right.statecode and 
												left.recordid=right.recordid,
												addField(left,right));	
	
	// slim_AllOffChg:= sort(distribute(slim_AllOff, hash(statecode, photoname)), statecode, photoname,local);
	slim_AllOffChg:=slim_AllOff;

	withdid addDt2(ds_img_a l, slim_AllOffChg r) := transform
		self.date				:= if(r.arrestdate[1..2] in ['19','20'],
													r.arrestdate,
												if(r.bookingdate[1..2] in ['19','20'],
													r.bookingdate,
														''));
		self 						:= l;	
	end;
	
	arr_match 				:= join(ds_img_a, slim_AllOffChg, 
													trim(left.state,left,right) = stringlib.StringToUpperCase(trim(right.statecode,left,right)) and																										
													trim(left.image_link,left,right) = trim(right.photoname,left,right), 
													addDt2(left,right), 
													left outer, keep(1)):persist('~thor400_20::persist::arr_image_base');

	ds_complete := withdid(rtype not in ['DC','AL']) + doc_match + arr_match;

//CREATE IMAGE BASE FILE/////////////////////////

	RoxieKeyBuild.Mac_SF_BuildProcess(ds_complete,'~criminal_images::base::Matrix_Images',
                '~criminal_images::base::criminal::'+filedate+'::matrix_images_base', do_build, 2);

	outfile := sequential(prebuild, do_build);

return outfile;

end;