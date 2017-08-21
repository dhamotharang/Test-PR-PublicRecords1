import corp2;

export Query_Samples(
	 dataset(Layouts.Base															)	pDellOut					= files().dell_out.built
	,dataset(Layouts.layaddr													) pAddressSummary		= files().address_summary.built
	,dataset(Layouts.laybus														) pBusinessSummary	= files().business_summary.built
	,dataset(Layouts.laycont													) pContactSummary		= files().contact_summary.built	
	,dataset(Corp2.Layout_Corporate_Direct_Corp_Base	) pCorp2						= Prep_CorpV2.fCorp()
	,dataset(Corp2.Layout_Corporate_Direct_Cont_Base	) pCorp2Cont				= Prep_CorpV2.fCont()
	,dataset(Corp2.Layout_Corporate_Direct_Event_Base	) pCorp2Events			= Prep_CorpV2.fEvent()	
) :=
module

	shared ldell_out					:= pDellOut;
	shared laddress_summary		:= pAddressSummary;
	shared lbusiness_summary	:= pBusinessSummary;
	shared lcontact_summary		:= pContactSummary;
	shared lcorp2							:= pCorp2;

	export Greenwest								:= 000446162992;
	export GARR											:= 001911770155;
	export SHANNON									:= 000096870275;
	export EAST_LOS_ANGELES_BAKERY	:= 001945057359;
	export CERAMI										:= 000447065822;
	export AUSPEX_ALPHATRONIX				:= 000410582352;
	export DIJON										:= 001770937631;
	export WOLFMAN									:= 000471117222;
	export KVH											:= 001939296736;
	export AFCOM										:= 000620312886;
	export GMG											:= 001005782835;
	export OMLEY										:= 001068495162;
	export ATLANTA_GAS							:= 001877249667;
	export ELITE_MODA								:= 000631566003;
	export set_dfs_examples := [
	 803448066
	,803451223
	,803488259
	,803433197
	,803490706
	];
	
	export sample_bdids := [
		 Greenwest							
	  ,GARR										
	  ,SHANNON								
	  ,EAST_LOS_ANGELES_BAKERY
	  ,CERAMI									
	  ,AUSPEX_ALPHATRONIX			
	  ,DIJON									
	  ,WOLFMAN								
	  ,KVH										
	  ,AFCOM									
	  ,GMG										
	  ,OMLEY									
	  ,ATLANTA_GAS						
	  ,ELITE_MODA							
	];

	export dcorp2_samples													:= set(sort(lcorp2(bdid in sample_bdids		),bdid),corp_key);
	export dcorp2_sample_Greenwest								:= lcorp2(bdid = Greenwest								)[1].corp_key;
	export dcorp2_sample_GARR											:= lcorp2(bdid = GARR											)[1].corp_key;
	export dcorp2_sample_SHANNON									:= lcorp2(bdid = SHANNON									)[1].corp_key;
	export dcorp2_sample_EAST_LOS_ANGELES_BAKERY	:= lcorp2(bdid = EAST_LOS_ANGELES_BAKERY	)[1].corp_key;
	export dcorp2_sample_CERAMI										:= lcorp2(bdid = CERAMI										)[1].corp_key;
	export dcorp2_sample_AUSPEX_ALPHATRONIX				:= lcorp2(bdid = AUSPEX_ALPHATRONIX				)[1].corp_key;
	export dcorp2_sample_DIJON										:= lcorp2(bdid = DIJON										)[1].corp_key;
	export dcorp2_sample_WOLFMAN									:= lcorp2(bdid = WOLFMAN									)[1].corp_key;
	export dcorp2_sample_KVH											:= lcorp2(bdid = KVH											)[1].corp_key;
	export dcorp2_sample_AFCOM										:= lcorp2(bdid = AFCOM										)[1].corp_key;
	export dcorp2_sample_GMG											:= lcorp2(bdid = GMG											)[1].corp_key;
	export dcorp2_sample_OMLEY										:= lcorp2(bdid = OMLEY										)[1].corp_key;
	export dcorp2_sample_ATLANTA_GAS							:= lcorp2(bdid = ATLANTA_GAS							)[1].corp_key;
	export dcorp2_sample_ELITE_MODA								:= lcorp2(bdid = ELITE_MODA								)[1].corp_key;
	
	export ddell_samples												:= sort(ldell_out(bdid in sample_bdids						),bdid);
	export ddell_sample_Greenwest								:= Dell_Convert_To_Csv(ldell_out(bdid = Greenwest								));
	export ddell_sample_GARR										:= Dell_Convert_To_Csv(ldell_out(bdid = GARR										));
	export ddell_sample_SHANNON									:= Dell_Convert_To_Csv(ldell_out(bdid = SHANNON									));
	export ddell_sample_EAST_LOS_ANGELES_BAKERY	:= Dell_Convert_To_Csv(ldell_out(bdid = EAST_LOS_ANGELES_BAKERY	));
	export ddell_sample_CERAMI									:= Dell_Convert_To_Csv(ldell_out(bdid = CERAMI									));
	export ddell_sample_AUSPEX_ALPHATRONIX			:= Dell_Convert_To_Csv(ldell_out(bdid = AUSPEX_ALPHATRONIX			));
	export ddell_sample_DIJON										:= Dell_Convert_To_Csv(ldell_out(bdid = DIJON										));
	export ddell_sample_WOLFMAN									:= Dell_Convert_To_Csv(ldell_out(bdid = WOLFMAN									));
	export ddell_sample_KVH											:= Dell_Convert_To_Csv(ldell_out(bdid = KVH											));
	export ddell_sample_AFCOM										:= Dell_Convert_To_Csv(ldell_out(bdid = AFCOM										));
	export ddell_sample_GMG											:= Dell_Convert_To_Csv(ldell_out(bdid = GMG											));
	export ddell_sample_OMLEY										:= Dell_Convert_To_Csv(ldell_out(bdid = OMLEY										));
	export ddell_sample_ATLANTA_GAS							:= Dell_Convert_To_Csv(ldell_out(bdid = ATLANTA_GAS							));
	export ddell_sample_ELITE_MODA							:= Dell_Convert_To_Csv(ldell_out(bdid = ELITE_MODA							));
	export ddell_out_DFS_sample									:= Dell_Convert_To_Csv(ldell_out((unsigned)rawfields.app_ref_key in set_dfs_examples));

	export dbusiness_summary_samples												:= sort(lbusiness_summary(vendor_id != '',vendor_id in dcorp2_samples						),vendor_id);
	export dbusiness_summary_sample_Greenwest								:= project(lbusiness_summary(vendor_id != '',vendor_id = dcorp2_sample_Greenwest								),transform({string name,recordof(lbusiness_summary)},self.name := 'Greenwest								'	;self := left));
	export dbusiness_summary_sample_GARR										:= project(lbusiness_summary(vendor_id != '',vendor_id = dcorp2_sample_GARR											),transform({string name,recordof(lbusiness_summary)},self.name := 'GARR										'	;self := left));
	export dbusiness_summary_sample_SHANNON									:= project(lbusiness_summary(vendor_id != '',vendor_id = dcorp2_sample_SHANNON									),transform({string name,recordof(lbusiness_summary)},self.name := 'SHANNON									'	;self := left));
	export dbusiness_summary_sample_EAST_LOS_ANGELES_BAKERY	:= project(lbusiness_summary(vendor_id != '',vendor_id = dcorp2_sample_EAST_LOS_ANGELES_BAKERY	),transform({string name,recordof(lbusiness_summary)},self.name := 'EAST_LOS_ANGELES_BAKERY	'	;self := left));
	export dbusiness_summary_sample_CERAMI									:= project(lbusiness_summary(vendor_id != '',vendor_id = dcorp2_sample_CERAMI										),transform({string name,recordof(lbusiness_summary)},self.name := 'CERAMI									'	;self := left));
	export dbusiness_summary_sample_AUSPEX_ALPHATRONIX			:= project(lbusiness_summary(vendor_id != '',vendor_id = dcorp2_sample_AUSPEX_ALPHATRONIX				),transform({string name,recordof(lbusiness_summary)},self.name := 'AUSPEX_ALPHATRONIX			'	;self := left));
	export dbusiness_summary_sample_DIJON										:= project(lbusiness_summary(vendor_id != '',vendor_id = dcorp2_sample_DIJON										),transform({string name,recordof(lbusiness_summary)},self.name := 'DIJON										'	;self := left));
	export dbusiness_summary_sample_WOLFMAN									:= project(lbusiness_summary(vendor_id != '',vendor_id = dcorp2_sample_WOLFMAN									),transform({string name,recordof(lbusiness_summary)},self.name := 'WOLFMAN									'	;self := left));
	export dbusiness_summary_sample_KVH											:= project(lbusiness_summary(vendor_id != '',vendor_id = dcorp2_sample_KVH											),transform({string name,recordof(lbusiness_summary)},self.name := 'KVH											'	;self := left));
	export dbusiness_summary_sample_AFCOM										:= project(lbusiness_summary(vendor_id != '',vendor_id = dcorp2_sample_AFCOM										),transform({string name,recordof(lbusiness_summary)},self.name := 'AFCOM										'	;self := left));
	export dbusiness_summary_sample_GMG											:= project(lbusiness_summary(vendor_id != '',vendor_id = dcorp2_sample_GMG											),transform({string name,recordof(lbusiness_summary)},self.name := 'GMG											'	;self := left));
	export dbusiness_summary_sample_OMLEY										:= project(lbusiness_summary(vendor_id != '',vendor_id = dcorp2_sample_OMLEY										),transform({string name,recordof(lbusiness_summary)},self.name := 'OMLEY										'	;self := left));
	export dbusiness_summary_sample_ATLANTA_GAS							:= project(lbusiness_summary(vendor_id != '',vendor_id = dcorp2_sample_ATLANTA_GAS							),transform({string name,recordof(lbusiness_summary)},self.name := 'ATLANTA_GAS							'	;self := left));
	export dbusiness_summary_sample_ELITE_MODA							:= project(lbusiness_summary(vendor_id != '',vendor_id = dcorp2_sample_ELITE_MODA								),transform({string name,recordof(lbusiness_summary)},self.name := 'ELITE_MODA							'	;self := left));

	export dAll_Business_Summary := 
		dbusiness_summary_sample_Greenwest								
	+ dbusiness_summary_sample_GARR										
	+ dbusiness_summary_sample_SHANNON									
	+ dbusiness_summary_sample_EAST_LOS_ANGELES_BAKERY	
	+ dbusiness_summary_sample_CERAMI									
	+ dbusiness_summary_sample_AUSPEX_ALPHATRONIX			
	+ dbusiness_summary_sample_DIJON										
	+ dbusiness_summary_sample_WOLFMAN									
	+ dbusiness_summary_sample_KVH											
	+ dbusiness_summary_sample_AFCOM										
	+ dbusiness_summary_sample_GMG											
	+ dbusiness_summary_sample_OMLEY										
	+ dbusiness_summary_sample_ATLANTA_GAS							
	+ dbusiness_summary_sample_ELITE_MODA							
	;

	export daddress_summary_samples													:= sort(laddress_summary(vendor_id != '',vendor_id in dcorp2_samples						),vendor_id);
	export daddress_summary_sample_Greenwest								:= project(laddress_summary(vendor_id != '',vendor_id = dcorp2_sample_Greenwest								),transform({string sample_name,recordof(laddress_summary)},self.sample_name := 'Greenwest								'	;self := left));
	export daddress_summary_sample_GARR											:= project(laddress_summary(vendor_id != '',vendor_id = dcorp2_sample_GARR										),transform({string sample_name,recordof(laddress_summary)},self.sample_name := 'GARR											'	;self := left));
	export daddress_summary_sample_SHANNON									:= project(laddress_summary(vendor_id != '',vendor_id = dcorp2_sample_SHANNON									),transform({string sample_name,recordof(laddress_summary)},self.sample_name := 'SHANNON									'	;self := left));
	export daddress_summary_sample_EAST_LOS_ANGELES_BAKERY	:= project(laddress_summary(vendor_id != '',vendor_id = dcorp2_sample_EAST_LOS_ANGELES_BAKERY	),transform({string sample_name,recordof(laddress_summary)},self.sample_name := 'EAST_LOS_ANGELES_BAKERY	'	;self := left));
	export daddress_summary_sample_CERAMI										:= project(laddress_summary(vendor_id != '',vendor_id = dcorp2_sample_CERAMI									),transform({string sample_name,recordof(laddress_summary)},self.sample_name := 'CERAMI										'	;self := left));
	export daddress_summary_sample_AUSPEX_ALPHATRONIX				:= project(laddress_summary(vendor_id != '',vendor_id = dcorp2_sample_AUSPEX_ALPHATRONIX			),transform({string sample_name,recordof(laddress_summary)},self.sample_name := 'AUSPEX_ALPHATRONIX				'	;self := left));
	export daddress_summary_sample_DIJON										:= project(laddress_summary(vendor_id != '',vendor_id = dcorp2_sample_DIJON										),transform({string sample_name,recordof(laddress_summary)},self.sample_name := 'DIJON										'	;self := left));
	export daddress_summary_sample_WOLFMAN									:= project(laddress_summary(vendor_id != '',vendor_id = dcorp2_sample_WOLFMAN									),transform({string sample_name,recordof(laddress_summary)},self.sample_name := 'WOLFMAN									'	;self := left));
	export daddress_summary_sample_KVH											:= project(laddress_summary(vendor_id != '',vendor_id = dcorp2_sample_KVH											),transform({string sample_name,recordof(laddress_summary)},self.sample_name := 'KVH											'	;self := left));
	export daddress_summary_sample_AFCOM										:= project(laddress_summary(vendor_id != '',vendor_id = dcorp2_sample_AFCOM										),transform({string sample_name,recordof(laddress_summary)},self.sample_name := 'AFCOM										'	;self := left));
	export daddress_summary_sample_GMG											:= project(laddress_summary(vendor_id != '',vendor_id = dcorp2_sample_GMG											),transform({string sample_name,recordof(laddress_summary)},self.sample_name := 'GMG											'	;self := left));
	export daddress_summary_sample_OMLEY										:= project(laddress_summary(vendor_id != '',vendor_id = dcorp2_sample_OMLEY										),transform({string sample_name,recordof(laddress_summary)},self.sample_name := 'OMLEY										'	;self := left));
	export daddress_summary_sample_ATLANTA_GAS							:= project(laddress_summary(vendor_id != '',vendor_id = dcorp2_sample_ATLANTA_GAS							),transform({string sample_name,recordof(laddress_summary)},self.sample_name := 'ATLANTA_GAS							'	;self := left));
	export daddress_summary_sample_ELITE_MODA								:= project(laddress_summary(vendor_id != '',vendor_id = dcorp2_sample_ELITE_MODA							),transform({string sample_name,recordof(laddress_summary)},self.sample_name := 'ELITE_MODA								'	;self := left));

	export dAll_Address_Summary := 
		daddress_summary_sample_Greenwest								
	+ daddress_summary_sample_GARR										
	+ daddress_summary_sample_SHANNON									
	+ daddress_summary_sample_EAST_LOS_ANGELES_BAKERY
	+ daddress_summary_sample_CERAMI									
	+ daddress_summary_sample_AUSPEX_ALPHATRONIX			
	+ daddress_summary_sample_DIJON										
	+ daddress_summary_sample_WOLFMAN								
	+ daddress_summary_sample_KVH										
	+ daddress_summary_sample_AFCOM									
	+ daddress_summary_sample_GMG										
	+ daddress_summary_sample_OMLEY									
	+ daddress_summary_sample_ATLANTA_GAS						
	+ daddress_summary_sample_ELITE_MODA								
	; 							
	
	export dcontact_summary_samples													:= sort(lcontact_summary(vendor_id != '',vendor_id in dcorp2_samples						),vendor_id);
	export dcontact_summary_sample_Greenwest								:= project(lcontact_summary(vendor_id != '',vendor_id = dcorp2_sample_Greenwest								),transform({string name,recordof(lcontact_summary)},self.name := 'Greenwest								'	;self := left));
	export dcontact_summary_sample_GARR											:= project(lcontact_summary(vendor_id != '',vendor_id = dcorp2_sample_GARR										),transform({string name,recordof(lcontact_summary)},self.name := 'GARR											'	;self := left));
	export dcontact_summary_sample_SHANNON									:= project(lcontact_summary(vendor_id != '',vendor_id = dcorp2_sample_SHANNON									),transform({string name,recordof(lcontact_summary)},self.name := 'SHANNON									'	;self := left));
	export dcontact_summary_sample_EAST_LOS_ANGELES_BAKERY	:= project(lcontact_summary(vendor_id != '',vendor_id = dcorp2_sample_EAST_LOS_ANGELES_BAKERY	),transform({string name,recordof(lcontact_summary)},self.name := 'EAST_LOS_ANGELES_BAKERY	'	;self := left));
	export dcontact_summary_sample_CERAMI										:= project(lcontact_summary(vendor_id != '',vendor_id = dcorp2_sample_CERAMI									),transform({string name,recordof(lcontact_summary)},self.name := 'CERAMI										'	;self := left));
	export dcontact_summary_sample_AUSPEX_ALPHATRONIX				:= project(lcontact_summary(vendor_id != '',vendor_id = dcorp2_sample_AUSPEX_ALPHATRONIX			),transform({string name,recordof(lcontact_summary)},self.name := 'AUSPEX_ALPHATRONIX				'	;self := left));
	export dcontact_summary_sample_DIJON										:= project(lcontact_summary(vendor_id != '',vendor_id = dcorp2_sample_DIJON										),transform({string name,recordof(lcontact_summary)},self.name := 'DIJON										'	;self := left));
	export dcontact_summary_sample_WOLFMAN									:= project(lcontact_summary(vendor_id != '',vendor_id = dcorp2_sample_WOLFMAN									),transform({string name,recordof(lcontact_summary)},self.name := 'WOLFMAN									'	;self := left));
	export dcontact_summary_sample_KVH											:= project(lcontact_summary(vendor_id != '',vendor_id = dcorp2_sample_KVH											),transform({string name,recordof(lcontact_summary)},self.name := 'KVH											'	;self := left));
	export dcontact_summary_sample_AFCOM										:= project(lcontact_summary(vendor_id != '',vendor_id = dcorp2_sample_AFCOM										),transform({string name,recordof(lcontact_summary)},self.name := 'AFCOM										'	;self := left));
	export dcontact_summary_sample_GMG											:= project(lcontact_summary(vendor_id != '',vendor_id = dcorp2_sample_GMG											),transform({string name,recordof(lcontact_summary)},self.name := 'GMG											'	;self := left));
	export dcontact_summary_sample_OMLEY										:= project(lcontact_summary(vendor_id != '',vendor_id = dcorp2_sample_OMLEY										),transform({string name,recordof(lcontact_summary)},self.name := 'OMLEY										'	;self := left));
	export dcontact_summary_sample_ATLANTA_GAS							:= project(lcontact_summary(vendor_id != '',vendor_id = dcorp2_sample_ATLANTA_GAS							),transform({string name,recordof(lcontact_summary)},self.name := 'ATLANTA_GAS							'	;self := left));
	export dcontact_summary_sample_ELITE_MODA								:= project(lcontact_summary(vendor_id != '',vendor_id = dcorp2_sample_ELITE_MODA							),transform({string name,recordof(lcontact_summary)},self.name := 'ELITE_MODA								'	;self := left));

	export dAll_Contact_Summary := 
		dcontact_summary_sample_Greenwest								
	+ dcontact_summary_sample_GARR										
	+ dcontact_summary_sample_SHANNON									
	+ dcontact_summary_sample_EAST_LOS_ANGELES_BAKERY	
	+ dcontact_summary_sample_CERAMI									
	+ dcontact_summary_sample_AUSPEX_ALPHATRONIX			
	+ dcontact_summary_sample_DIJON										
	+ dcontact_summary_sample_WOLFMAN									
	+ dcontact_summary_sample_KVH											
	+ dcontact_summary_sample_AFCOM										
	+ dcontact_summary_sample_GMG											
	+ dcontact_summary_sample_OMLEY										
	+ dcontact_summary_sample_ATLANTA_GAS							
	+ dcontact_summary_sample_ELITE_MODA							
	;
	
	export dcorp2_sample_data													:= sort(lcorp2(bdid in sample_bdids						),corp_key);
	export dcorp2_sample_data_Greenwest								:= sort(lcorp2(bdid = Greenwest								),corp_key);
	export dcorp2_sample_data_GARR										:= sort(lcorp2(bdid = GARR										),corp_key);
	export dcorp2_sample_data_SHANNON									:= sort(lcorp2(bdid = SHANNON									),corp_key);
	export dcorp2_sample_data_EAST_LOS_ANGELES_BAKERY	:= sort(lcorp2(bdid = EAST_LOS_ANGELES_BAKERY	),corp_key);
	export dcorp2_sample_data_CERAMI									:= sort(lcorp2(bdid = CERAMI									),corp_key);
	export dcorp2_sample_data_AUSPEX_ALPHATRONIX			:= sort(lcorp2(bdid = AUSPEX_ALPHATRONIX			),corp_key);
	export dcorp2_sample_data_DIJON										:= sort(lcorp2(bdid = DIJON										),corp_key);
	export dcorp2_sample_data_WOLFMAN									:= sort(lcorp2(bdid = WOLFMAN									),corp_key);
	export dcorp2_sample_data_KVH											:= sort(lcorp2(bdid = KVH											),corp_key);
	export dcorp2_sample_data_AFCOM										:= sort(lcorp2(bdid = AFCOM										),corp_key);
	export dcorp2_sample_data_GMG											:= sort(lcorp2(bdid = GMG											),corp_key);
	export dcorp2_sample_data_OMLEY										:= sort(lcorp2(bdid = OMLEY										),corp_key);
	export dcorp2_sample_data_ATLANTA_GAS							:= sort(lcorp2(bdid = ATLANTA_GAS							),corp_key);
	export dcorp2_sample_data_ELITE_MODA							:= sort(lcorp2(bdid = ELITE_MODA							),corp_key);
	
	export dcorp2_cont_sample_data													:= sort(pCorp2Cont(bdid in sample_bdids						),corp_key);
	export dcorp2_cont_sample_data_Greenwest								:= sort(pCorp2Cont(bdid = Greenwest								),corp_key);
	export dcorp2_cont_sample_data_GARR											:= sort(pCorp2Cont(bdid = GARR										),corp_key);
	export dcorp2_cont_sample_data_SHANNON									:= sort(pCorp2Cont(bdid = SHANNON									),corp_key);
	export dcorp2_cont_sample_data_EAST_LOS_ANGELES_BAKERY	:= sort(pCorp2Cont(bdid = EAST_LOS_ANGELES_BAKERY	),corp_key);
	export dcorp2_cont_sample_data_CERAMI										:= sort(pCorp2Cont(bdid = CERAMI									),corp_key);
	export dcorp2_cont_sample_data_AUSPEX_ALPHATRONIX				:= sort(pCorp2Cont(bdid = AUSPEX_ALPHATRONIX			),corp_key);
	export dcorp2_cont_sample_data_DIJON										:= sort(pCorp2Cont(bdid = DIJON										),corp_key);
	export dcorp2_cont_sample_data_WOLFMAN									:= sort(pCorp2Cont(bdid = WOLFMAN									),corp_key);
	export dcorp2_cont_sample_data_KVH											:= sort(pCorp2Cont(bdid = KVH											),corp_key);
	export dcorp2_cont_sample_data_AFCOM										:= sort(pCorp2Cont(bdid = AFCOM										),corp_key);
	export dcorp2_cont_sample_data_GMG											:= sort(pCorp2Cont(bdid = GMG											),corp_key);
	export dcorp2_cont_sample_data_OMLEY										:= sort(pCorp2Cont(bdid = OMLEY										),corp_key);
	export dcorp2_cont_sample_data_ATLANTA_GAS							:= sort(pCorp2Cont(bdid = ATLANTA_GAS							),corp_key);
	export dcorp2_cont_sample_data_ELITE_MODA								:= sort(pCorp2Cont(bdid = ELITE_MODA							),corp_key);

	export dcorp2_events_sample_data													:= sort(pCorp2Events(bdid in sample_bdids						),corp_key);
	export dcorp2_events_sample_data_Greenwest								:= sort(pCorp2Events(bdid = Greenwest								),corp_key);
	export dcorp2_events_sample_data_GARR											:= sort(pCorp2Events(bdid = GARR										),corp_key);
	export dcorp2_events_sample_data_SHANNON									:= sort(pCorp2Events(bdid = SHANNON									),corp_key);
	export dcorp2_events_sample_data_EAST_LOS_ANGELES_BAKERY	:= sort(pCorp2Events(bdid = EAST_LOS_ANGELES_BAKERY	),corp_key);
	export dcorp2_events_sample_data_CERAMI										:= sort(pCorp2Events(bdid = CERAMI									),corp_key);
	export dcorp2_events_sample_data_AUSPEX_ALPHATRONIX				:= sort(pCorp2Events(bdid = AUSPEX_ALPHATRONIX			),corp_key);
	export dcorp2_events_sample_data_DIJON										:= sort(pCorp2Events(bdid = DIJON										),corp_key);
	export dcorp2_events_sample_data_WOLFMAN									:= sort(pCorp2Events(bdid = WOLFMAN									),corp_key);
	export dcorp2_events_sample_data_KVH											:= sort(pCorp2Events(bdid = KVH											),corp_key);
	export dcorp2_events_sample_data_AFCOM										:= sort(pCorp2Events(bdid = AFCOM										),corp_key);
	export dcorp2_events_sample_data_GMG											:= sort(pCorp2Events(bdid = GMG											),corp_key);
	export dcorp2_events_sample_data_OMLEY										:= sort(pCorp2Events(bdid = OMLEY										),corp_key);
	export dcorp2_events_sample_data_ATLANTA_GAS							:= sort(pCorp2Events(bdid = ATLANTA_GAS							),corp_key);
	export dcorp2_events_sample_data_ELITE_MODA								:= sort(pCorp2Events(bdid = ELITE_MODA							),corp_key);


	export dKim_sample_bizSum_Greenwest								:= dataset([{'Greenwest-Kim',Greenwest								,dcorp2_sample_Greenwest							,'','G',19960207,20090520,20090520,0,0,0,0,0,0,0,0,3,14,2,2,11,3,0,9,2,0,0,0,0,0}],{string name,recordof(lbusiness_summary)});

	export dKim_sample_bizSum_GARR										:= dataset([
		{'GARR-Kim'
		,GARR											// Bdid
		,dcorp2_sample_GARR				// unique id for dataset(i.e. for corps, corp_key)						
		,''                       // Source code
		,'G'                      // (D = Delinquent, G = Good Standing)
		,19810514                 // Initial Filing Date
		,20090804                 // Latest Filing Date or Latest Filing Event
		,20090804                 // date of the most recent filing status for the bdid / corp_key
		,0                        // date the status for the bdid / corp_key combo last reflected something different 
		,0                        // Date of Last Event Filing
		,0                        // Date of Last Derog Event Filing
		,0                        // Date of Last Dissolution Event
		,0                        // Date of Last Reinstatement
		,0                        // Count of how many delinquent statuses there have been
		,0                        // Count of all Derog Events
		,0                        // Count of all Bankruptcies
		,0                        // Count of all Liens and Judgements
		,5                        // Count of all UCCs
		,2                        // Count of total address changes reported
		,0                        // Count of total contact changes reported
		,13                       // Count other businesses filed at address
		,11                       // Count number of businesses filed at address currently with derogatory status
		,0                         // Count number of businesses with derogatory events filed at address					
		,0                         // Count number of additional businesses associated with contacts
		,0                         // Count number of delinquent businesses associated with contacts
		,0                         // Count number of businesses with derogatory events associated with contacts
		,0                         // # of months between run date and latest filing
		,0                         // # of months between latest filing and previous filing
		,0                         // # of months between latest event and previous event
		,0                         // # of months between dissolution and reinstatement																
		}],{string name,recordof(lbusiness_summary)});
	export dKim_sample_bizSum_SHANNON									:= dataset([{
		 'SHANNON-Kim'
		,SHANNON										// Bdid
		,dcorp2_sample_SHANNON		// unique id for dataset(i.e. for corps, corp_key)												
		,''                       // Source code
		,'G'                         // (D = Delinquent, G = Good Standing)
		,19930917                         // Initial Filing Date
		,20091020                         // Latest Filing Date or Latest Filing Event
		,20091020                         // date of the most recent filing status for the bdid / corp_key
		,0                        // date the status for the bdid / corp_key combo last reflected something different 
		,0                        // Date of Last Event Filing
		,0                        // Date of Last Derog Event Filing
		,0                        // Date of Last Dissolution Event
		,0                        // Date of Last Reinstatement
		,0                        // Count of how many delinquent statuses there have been
		,0                        // Count of all Derog Events
		,0                        // Count of all Bankruptcies
		,0                         // Count of all Liens and Judgements
		,2                         // Count of all UCCs
		,3                         // Count of total address changes reported
		,2                         // Count of total contact changes reported
		,3                         // Count other businesses filed at address
		,3                         // Count number of businesses filed at address currently with derogatory status
		,0                          // Count number of businesses with derogatory events filed at address					
		,1                          // Count number of additional businesses associated with contacts
		,1                          // Count number of delinquent businesses associated with contacts
		,0                          // Count number of businesses with derogatory events associated with contacts
		,0                          // # of months between run date and latest filing
		,0                          // # of months between latest filing and previous filing
		,0                          // # of months between latest event and previous event
		,0                          // # of months between dissolution and reinstatement																
		}],{string name,recordof(lbusiness_summary)});
	
	export dKim_sample_bizSum_EAST_LOS_ANGELES_BAKERY	:= dataset([{
		 'EAST_LOS_ANGELES_BAKERY-Kim'
		,EAST_LOS_ANGELES_BAKERY	
		,dcorp2_sample_EAST_LOS_ANGELES_BAKERY
		,''                       // Source code
		,'G'                         // (D = Delinquent, G = Good Standing)
		,19950609                         // Initial Filing Date
		,20090218                         // Latest Filing Date or Latest Filing Event
		,20090218                         // date of the most recent filing status for the bdid / corp_key
		,0                        // date the status for the bdid / corp_key combo last reflected something different 
		,0                        // Date of Last Event Filing
		,0                        // Date of Last Derog Event Filing
		,0                        // Date of Last Dissolution Event
		,0                        // Date of Last Reinstatement
		,0                        // Count of how many delinquent statuses there have been
		,0                        // Count of all Derog Events
		,0                        // Count of all Bankruptcies
		,3                         // Count of all Liens and Judgements
		,0                         // Count of all UCCs
		,3                         // Count of total address changes reported
		,2                         // Count of total contact changes reported
		,6                         // Count other businesses filed at address
		,5                         // Count number of businesses filed at address currently with derogatory status
		,0                          // Count number of businesses with derogatory events filed at address					
		,1                          // Count number of additional businesses associated with contacts
		,1                          // Count number of delinquent businesses associated with contacts
		,0                          // Count number of businesses with derogatory events associated with contacts
		,0                          // # of months between run date and latest filing
		,0                          // # of months between latest filing and previous filing
		,0                          // # of months between latest event and previous event
		,0                          // # of months between dissolution and reinstatement																
		}],{string name,recordof(lbusiness_summary)});
	export dKim_sample_bizSum_CERAMI									:= dataset([{
		 'CERAMI-Kim'
		,CERAMI										
		,dcorp2_sample_CERAMI									
		,''                       // Source code
		,'G'                         // (D = Delinquent, G = Good Standing)
		,20020528                         // Initial Filing Date
		,20040615                         // Latest Filing Date or Latest Filing Event
		,20040615                         // date of the most recent filing status for the bdid / corp_key
		,0                        // date the status for the bdid / corp_key combo last reflected something different 
		,0                        // Date of Last Event Filing
		,0                        // Date of Last Derog Event Filing
		,0                        // Date of Last Dissolution Event
		,0                        // Date of Last Reinstatement
		,0                        // Count of how many delinquent statuses there have been
		,0                        // Count of all Derog Events
		,0                        // Count of all Bankruptcies
		,3                         // Count of all Liens and Judgements
		,7                         // Count of all UCCs
		,0                         // Count of total address changes reported
		,0                         // Count of total contact changes reported
		,5                         // Count other businesses filed at address
		,0                         // Count number of businesses filed at address currently with derogatory status
		,0                          // Count number of businesses with derogatory events filed at address					
		,6                          // Count number of additional businesses associated with contacts
		,4                          // Count number of delinquent businesses associated with contacts
		,0                          // Count number of businesses with derogatory events associated with contacts
		,0                          // # of months between run date and latest filing
		,0                          // # of months between latest filing and previous filing
		,0                          // # of months between latest event and previous event
		,0                          // # of months between dissolution and reinstatement																
		}],{string name,recordof(lbusiness_summary)});
	export dKim_sample_bizSum_AUSPEX_ALPHATRONIX			:= dataset([{
		 'AUSPEX_ALPHATRONIX-Kim'
		,AUSPEX_ALPHATRONIX				
		,dcorp2_sample_AUSPEX_ALPHATRONIX			
		,''                       // Source code
		,'D'                         // (D = Delinquent, G = Good Standing)
		,19910710                         // Initial Filing Date
		,20070126                         // Latest Filing Date or Latest Filing Event
		,20070126                         // date of the most recent filing status for the bdid / corp_key
		,0                        // date the status for the bdid / corp_key combo last reflected something different 
		,0                        // Date of Last Event Filing
		,0                        // Date of Last Derog Event Filing
		,0                        // Date of Last Dissolution Event
		,0                        // Date of Last Reinstatement
		,0                        // Count of how many delinquent statuses there have been
		,0                        // Count of all Derog Events
		,1                        // Count of all Bankruptcies
		,11                         // Count of all Liens and Judgements
		,11                         // Count of all UCCs
		,0                         // Count of total address changes reported
		,0                         // Count of total contact changes reported
		,0                         // Count other businesses filed at address
		,0                         // Count number of businesses filed at address currently with derogatory status
		,0                          // Count number of businesses with derogatory events filed at address					
		,0                          // Count number of additional businesses associated with contacts
		,0                          // Count number of delinquent businesses associated with contacts
		,0                          // Count number of businesses with derogatory events associated with contacts
		,0                          // # of months between run date and latest filing
		,0                          // # of months between latest filing and previous filing
		,0                          // # of months between latest event and previous event
		,0                          // # of months between dissolution and reinstatement																
		}],{string name,recordof(lbusiness_summary)});
	export dKim_sample_bizSum_DIJON										:= dataset([{
		 'DIJON-Kim'
		,DIJON										
		,dcorp2_sample_DIJON									
		,''                       // Source code
		,'G'                         // (D = Delinquent, G = Good Standing)
		,19990823                         // Initial Filing Date
		,20091029                         // Latest Filing Date or Latest Filing Event
		,20091029                         // date of the most recent filing status for the bdid / corp_key
		,0                        // date the status for the bdid / corp_key combo last reflected something different 
		,0                        // Date of Last Event Filing
		,0                        // Date of Last Derog Event Filing
		,0                        // Date of Last Dissolution Event
		,0                        // Date of Last Reinstatement
		,0                        // Count of how many delinquent statuses there have been
		,0                        // Count of all Derog Events
		,2                        // Count of all Bankruptcies
		,4                         // Count of all Liens and Judgements
		,0                         // Count of all UCCs
		,1                         // Count of total address changes reported
		,0                         // Count of total contact changes reported
		,5                         // Count other businesses filed at address
		,5                         // Count number of businesses filed at address currently with derogatory status
		,0                          // Count number of businesses with derogatory events filed at address					
		,5                          // Count number of additional businesses associated with contacts
		,0                          // Count number of delinquent businesses associated with contacts
		,0                          // Count number of businesses with derogatory events associated with contacts
		,0                          // # of months between run date and latest filing
		,0                          // # of months between latest filing and previous filing
		,0                          // # of months between latest event and previous event
		,0                          // # of months between dissolution and reinstatement																
		}],{string name,recordof(lbusiness_summary)});
/*	export dKim_sample_bizSum_WOLFMAN									:= dataset([{
		WOLFMAN									
		,dcorp2_sample_WOLFMAN								
		,''                       // Source code
		,                         // (D = Delinquent, G = Good Standing)
		,                         // Initial Filing Date
		,                         // Latest Filing Date or Latest Filing Event
		,                         // date of the most recent filing status for the bdid / corp_key
		,0                        // date the status for the bdid / corp_key combo last reflected something different 
		,0                        // Date of Last Event Filing
		,0                        // Date of Last Derog Event Filing
		,0                        // Date of Last Dissolution Event
		,0                        // Date of Last Reinstatement
		,0                        // Count of how many delinquent statuses there have been
		,0                        // Count of all Derog Events
		,0                        // Count of all Bankruptcies
		,                         // Count of all Liens and Judgements
		,                         // Count of all UCCs
		,                         // Count of total address changes reported
		,                         // Count of total contact changes reported
		,                         // Count other businesses filed at address
		,                         // Count number of businesses filed at address currently with derogatory status
		,                          // Count number of businesses with derogatory events filed at address					
		,                          // Count number of additional businesses associated with contacts
		,                          // Count number of delinquent businesses associated with contacts
		,                          // Count number of businesses with derogatory events associated with contacts
		,                          // # of months between run date and latest filing
		,                          // # of months between latest filing and previous filing
		,                          // # of months between latest event and previous event
		,                          // # of months between dissolution and reinstatement																
		}],{string name,recordof(lbusiness_summary)});
*/	export dKim_sample_bizSum_KVH											:= dataset([{
		 'KVH-Kim'
		,KVH											
		,dcorp2_sample_KVH										
		,''                       // Source code
		,'G'                      // (D = Delinquent, G = Good Standing)
		,20010403                 // Initial Filing Date
		,20090428                 // Latest Filing Date or Latest Filing Event
		,20090428                 // date of the most recent filing status for the bdid / corp_key
		,0                        // date the status for the bdid / corp_key combo last reflected something different 
		,0                        // Date of Last Event Filing
		,0                        // Date of Last Derog Event Filing
		,0                        // Date of Last Dissolution Event
		,0                        // Date of Last Reinstatement
		,0                        // Count of how many delinquent statuses there have been
		,0                        // Count of all Derog Events
		,0                        // Count of all Bankruptcies
		,0                         // Count of all Liens and Judgements
		,0                         // Count of all UCCs
		,3                         // Count of total address changes reported
		,1                         // Count of total contact changes reported
		,1                         // Count other businesses filed at address
		,1                         // Count number of businesses filed at address currently with derogatory status
		,1                          // Count number of businesses with derogatory events filed at address					
		,1                          // Count number of additional businesses associated with contacts
		,0                          // Count number of delinquent businesses associated with contacts
		,0                          // Count number of businesses with derogatory events associated with contacts
		,0                          // # of months between run date and latest filing
		,0                          // # of months between latest filing and previous filing
		,0                          // # of months between latest event and previous event
		,0                          // # of months between dissolution and reinstatement																
		}],{string name,recordof(lbusiness_summary)});
	export dKim_sample_bizSum_AFCOM										:= dataset([{
		 'AFCOM-Kim'
		,AFCOM										
		,dcorp2_sample_AFCOM									
		,''                       // Source code
		,'D'                         // (D = Delinquent, G = Good Standing)
		,20050603                         // Initial Filing Date
		,20071005                         // Latest Filing Date or Latest Filing Event
		,20071005                         // date of the most recent filing status for the bdid / corp_key
		,0                        // date the status for the bdid / corp_key combo last reflected something different 
		,0                        // Date of Last Event Filing
		,0                        // Date of Last Derog Event Filing
		,0                        // Date of Last Dissolution Event
		,0                        // Date of Last Reinstatement
		,0                        // Count of how many delinquent statuses there have been
		,0                        // Count of all Derog Events
		,0                        // Count of all Bankruptcies
		,1                         // Count of all Liens and Judgements
		,0                         // Count of all UCCs
		,0                         // Count of total address changes reported
		,0                         // Count of total contact changes reported
		,0                         // Count other businesses filed at address
		,0                         // Count number of businesses filed at address currently with derogatory status
		,0                          // Count number of businesses with derogatory events filed at address					
		,2                          // Count number of additional businesses associated with contacts
		,2                          // Count number of delinquent businesses associated with contacts
		,0                          // Count number of businesses with derogatory events associated with contacts
		,0                          // # of months between run date and latest filing
		,0                          // # of months between latest filing and previous filing
		,0                          // # of months between latest event and previous event
		,0                          // # of months between dissolution and reinstatement																
		}],{string name,recordof(lbusiness_summary)});
	export dKim_sample_bizSum_GMG											:= dataset([{
		 'GMG-Kim'
		,GMG											
		,dcorp2_sample_GMG										
		,''                       // Source code
		,'D'                         // (D = Delinquent, G = Good Standing)
		,20061027                         // Initial Filing Date
		,20090407                         // Latest Filing Date or Latest Filing Event
		,20090407                         // date of the most recent filing status for the bdid / corp_key
		,0                        // date the status for the bdid / corp_key combo last reflected something different 
		,0                        // Date of Last Event Filing
		,0                        // Date of Last Derog Event Filing
		,0                        // Date of Last Dissolution Event
		,0                        // Date of Last Reinstatement
		,0                        // Count of how many delinquent statuses there have been
		,0                        // Count of all Derog Events
		,0                        // Count of all Bankruptcies
		,1                         // Count of all Liens and Judgements
		,0                         // Count of all UCCs
		,0                         // Count of total address changes reported
		,0                         // Count of total contact changes reported
		,1                         // Count other businesses filed at address
		,0                         // Count number of businesses filed at address currently with derogatory status
		,0                          // Count number of businesses with derogatory events filed at address					
		,1                          // Count number of additional businesses associated with contacts
		,0                          // Count number of delinquent businesses associated with contacts
		,0                          // Count number of businesses with derogatory events associated with contacts
		,0                          // # of months between run date and latest filing
		,0                          // # of months between latest filing and previous filing
		,0                          // # of months between latest event and previous event
		,0                          // # of months between dissolution and reinstatement																
		}],{string name,recordof(lbusiness_summary)});
	export dKim_sample_bizSum_OMLEY										:= dataset([{
		 'OMLEY-Kim'
		,OMLEY										
		,dcorp2_sample_OMLEY									
		,''                       // Source code
		,'D'                         // (D = Delinquent, G = Good Standing)
		,20061020                         // Initial Filing Date
		,20080701                         // Latest Filing Date or Latest Filing Event
		,20080701                         // date of the most recent filing status for the bdid / corp_key
		,0                        // date the status for the bdid / corp_key combo last reflected something different 
		,0                        // Date of Last Event Filing
		,0                        // Date of Last Derog Event Filing
		,0                        // Date of Last Dissolution Event
		,0                        // Date of Last Reinstatement
		,0                        // Count of how many delinquent statuses there have been
		,0                        // Count of all Derog Events
		,0                       // Count of all Bankruptcies
		,22                         // Count of all Liens and Judgements
		,1                         // Count of all UCCs
		,2                         // Count of total address changes reported
		,0                         // Count of total contact changes reported
		,15                         // Count other businesses filed at address
		,11                         // Count number of businesses filed at address currently with derogatory status
		,11                          // Count number of businesses with derogatory events filed at address					
		,6                          // Count number of additional businesses associated with contacts
		,4                          // Count number of delinquent businesses associated with contacts
		,0                          // Count number of businesses with derogatory events associated with contacts
		,0                          // # of months between run date and latest filing
		,0                          // # of months between latest filing and previous filing
		,0                          // # of months between latest event and previous event
		,0                          // # of months between dissolution and reinstatement																
		}],{string name,recordof(lbusiness_summary)});
	export dKim_sample_bizSum_ATLANTA_GAS							:= dataset([{
		 'ATLANTA_GAS-Kim'
		,ATLANTA_GAS							
		,dcorp2_sample_ATLANTA_GAS						
		,''                       // Source code
		,'G'                         // (D = Delinquent, G = Good Standing)
		,20061101                         // Initial Filing Date
		,20091201                         // Latest Filing Date or Latest Filing Event
		,20091201                         // date of the most recent filing status for the bdid / corp_key
		,0                        // date the status for the bdid / corp_key combo last reflected something different 
		,0                        // Date of Last Event Filing
		,0                        // Date of Last Derog Event Filing
		,0                        // Date of Last Dissolution Event
		,0                        // Date of Last Reinstatement
		,0                        // Count of how many delinquent statuses there have been
		,0                        // Count of all Derog Events
		,0                        // Count of all Bankruptcies
		,3                         // Count of all Liens and Judgements
		,4                         // Count of all UCCs
		,3                         // Count of total address changes reported
		,0                         // Count of total contact changes reported
		,24                         // Count other businesses filed at address
		,14                         // Count number of businesses filed at address currently with derogatory status
		,17                          // Count number of businesses with derogatory events filed at address					
		,2                          // Count number of additional businesses associated with contacts
		,1                          // Count number of delinquent businesses associated with contacts
		,0                          // Count number of businesses with derogatory events associated with contacts
		,0                          // # of months between run date and latest filing
		,0                          // # of months between latest filing and previous filing
		,0                          // # of months between latest event and previous event
		,0                          // # of months between dissolution and reinstatement																
		}],{string name,recordof(lbusiness_summary)});
	export dKim_sample_bizSum_ELITE_MODA							:= dataset([{
		 'ELITE_MODA-Kim'
		,ELITE_MODA								
		,dcorp2_sample_ELITE_MODA							
		,''                       // Source code
		,''                         // (D = Delinquent, G = Good Standing)
		,20060913                         // Initial Filing Date
		,20090721                         // Latest Filing Date or Latest Filing Event
		,20090721                         // date of the most recent filing status for the bdid / corp_key
		,0                        // date the status for the bdid / corp_key combo last reflected something different 
		,0                        // Date of Last Event Filing
		,0                        // Date of Last Derog Event Filing
		,0                        // Date of Last Dissolution Event
		,0                        // Date of Last Reinstatement
		,0                        // Count of how many delinquent statuses there have been
		,0                        // Count of all Derog Events
		,1                        // Count of all Bankruptcies
		,1                         // Count of all Liens and Judgements
		,1                         // Count of all UCCs
		,3                         // Count of total address changes reported
		,0                         // Count of total contact changes reported
		,1                         // Count other businesses filed at address
		,0                         // Count number of businesses filed at address currently with derogatory status
		,0                          // Count number of businesses with derogatory events filed at address					
		,4                          // Count number of additional businesses associated with contacts
		,1                          // Count number of delinquent businesses associated with contacts
		,0                          // Count number of businesses with derogatory events associated with contacts
		,0                          // # of months between run date and latest filing
		,0                          // # of months between latest filing and previous filing
		,0                          // # of months between latest event and previous event
		,0                          // # of months between dissolution and reinstatement																
		}],{string name,recordof(lbusiness_summary)});

	export Kims_Samples := 
			dKim_sample_bizSum_Greenwest
		+ dKim_sample_bizSum_GARR										
		+ dKim_sample_bizSum_SHANNON								
		+ dKim_sample_bizSum_EAST_LOS_ANGELES_BAKERY
		+ dKim_sample_bizSum_CERAMI									
		+ dKim_sample_bizSum_AUSPEX_ALPHATRONIX			
		+ dKim_sample_bizSum_DIJON									
//		+ dKim_sample_bizSum_WOLFMAN		//doesn't exist in corpv2
		+ dKim_sample_bizSum_KVH										
		+ dKim_sample_bizSum_AFCOM									
		+ dKim_sample_bizSum_GMG										
		+ dKim_sample_bizSum_OMLEY									
		+ dKim_sample_bizSum_ATLANTA_GAS						
		+ dKim_sample_bizSum_ELITE_MODA							
		;


	export dAll_Business_Summary_with_Kims_Samples := sort(
			dAll_Business_Summary
		+ Kims_Samples
		,bdid
		);







/*

		unsigned8	bdid 																	;	// Bdid
		string		vendor_id     												;	// unique id for dataset(i.e. for corps, corp_key)
		string 		source 																;	// Source code
		string		latest_status     										;	// (D = Delinquent, G = Good Standing)
		unsigned8 Date_Filing_First_Seen								;	// Initial Filing Date
		unsigned8 Date_Filing_Last_Seen 								;	// Latest Filing Date or Latest Filing Event
		unsigned8 Date_Current_Status 									;	// date of the most recent filing status for the bdid / corp_key
		unsigned8 Date_Prior_Status			 								;	// date the status for the bdid / corp_key combo last reflected something different 
		unsigned8 Date_Last_Event 											;	// Date of Last Event Filing
		unsigned8 Date_Last_Derog_Event									;	// Date of Last Derog Event Filing
		unsigned8 Date_Most_Recent_Dissolution					;	// Date of Last Dissolution Event
		unsigned8 Date_Most_Recent_Reinstatement				;	// Date of Last Reinstatement
		unsigned8 Count_Delinquent_Statuses 						;	// Count of how many delinquent statuses there have been
		unsigned8 Count_Derog_Events 										;	// Count of all Derog Events
		unsigned8 Count_Bankruptcies_business 					;	// Count of all Bankruptcies
		unsigned8 Count_Liens_Judgements_business 			;	// Count of all Liens and Judgements
		unsigned8 Count_UCCs_business 									;	// Count of all UCCs
		unsigned8 count_address_changes									;	// Count of total address changes reported
		unsigned8 count_contact_changes									;	// Count of total contact changes reported
		unsigned8 Count_Business_At_Address							;	// Count other businesses filed at address
		unsigned8 Count_Delinquent_Business_At_Address	;	// Count number of businesses filed at address currently with derogatory status
		unsigned8 Count_Derogatory_Business_At_Address	;	// Count number of businesses with derogatory events filed at address					
		unsigned8 count_business_contacts								; // Count number of additional businesses associated with contacts
		unsigned8 count_delinquent_business_contacts		; // Count number of delinquent businesses associated with contacts
		unsigned8 count_derogatory_business_contacts		; // Count number of businesses with derogatory events associated with contacts
		unsigned8 time_since_last_report_date						;	// # of months between run date and latest filing
		unsigned8 time_between_filings									;	// # of months between latest filing and previous filing
		unsigned8 time_between_events										;	// # of months between latest event and previous event
		unsigned8 time_between_dissolution_reinstatement;	// # of months between dissolution and reinstatement																		

*/






	// -- Greenwest
	// -- 'F.S.I. GREENWEST ACTIVEWEAR, INC.'
	// -- '399 W ARTESIA BLVD'
	// -- 'COMPTON 90220'
	// -- bdid 000446162992
/*	
GARR LAND & RESOURCE MANAGEMENT, INC.
3003 S HILL ST
LOS ANGELES 90007
bdid 001911770155

SHANNON'S ACCESSORIES, INC
1225 W JAMES M WOOD BLVD
LOS ANGELES  90015
bdid 000096870275

EAST LOS ANGELES BAKERY, INC.
4825 CRENSHAW BLVD
LOS ANGELES 90008
bdid 001945057359

CERAMI AUTOMOTIVE ENTERPRISES L.L.C.
755 N STATE RT 17 S
PARAMUS 07652
bdid 000001062118	// couple different bdids here, this looks like best one

AUSPEX SYST4EMS, INC.
4022 STIRRUP CREEK DR STE 315
DURHAM 27703
bdid 000019449233 // ALPHATRONIX

DIJON BUSINESS GROUP, INC.
1102 Carlisle Ave
Macon, GA 31204
bdid 000568060080 // MONAGHAN VIRGINIA M MONAGHAN JAS C HEIRS OF
bdid 001770937631 //DIJON BUSINESS GROUP, INC. 1368 NULL DUNCAN AVE 

WOLFMAN'S TOWING & TRANSPORTATION
315 CHESTER ST
GLENDALE  91203
bdid 000471117222

K.V.H. ENTERPRISES, INC.
10929 VANOWEN ST STE 119
NORTH HOLLYWOOD  91605
bdid 001939296736

AFCOM L.L.C
4426 RENN ST
ROCKVILLE  20853
bdid 000620312886

GMG AMERICA INC
700 E CHEVY CHASE DR APT B, GLENDALE  CA 91205-3098
444 PIEDMONT AVE UNIT 204, GLENDALE  CA  91206-6114
bdid 001005782835
	
OMLEY TELECOMM
6853 65TH ST
SACARMENTO  95828
bdid 001068495162

ATLANTA GAS SERVICES, INC.
8014 CUMMING HWY STE 403
CANTON 30115
bdid 001877249667

ELITE MODA II, INC.
23439 MICHIGAN AVE STE 2W
DEARBORN  48124
bdid 001949376176

*/






end;