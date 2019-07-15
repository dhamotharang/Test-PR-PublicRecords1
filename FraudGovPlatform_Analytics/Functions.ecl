EXPORT Functions := MODULE
	IMPORT BatchShare, FraudGovPlatform_Services, FraudGovPlatform_Analytics;

	//Project to the event scoring layout
	EXPORT projectToEventScoringLayout(DATASET(FraudGovPlatform_Services.Layouts.Batch_out_pre_w_raw) ds_in, 
		FraudGovPlatform_Services.IParam.BatchParams batch_params) := FUNCTION
		
		scoring_rec := RECORD
			BatchShare.Layouts.ShareAcct;
			unsigned6 LexID := 0;         
			unsigned customer_id_;
			unsigned industry_type_;     
			string entity_context_uid_; 
			string _cvi_;
			string _cvicustomscore_;
			integer8 deceased_;
			integer8 deceased_prior_to_event_;
			integer8 _nas__summary_;
			integer8 _nap__summary_;
			boolean _ssnfoundforlexid_;
			integer8 _subjectssncount_;
			/*
			// integer8 stolen_identity_index_;
			// integer8 synthetic_identity_index_;
			// integer8 manipulated_identity_index_;
			// integer8 vulnerable_victim_index_;
			// integer8 friendlyfraud_index_;
			// integer8 suspicious_activity_index_;
			// integer8 _v2__sourcerisklevel_;
			// integer8 _v2__assocsuspicousidentitiescount_;
			// integer8 _v2__assoccreditbureauonlycount_;
			// integer8 _v2__validationaddrproblems_;
			// integer8 _v2__inputaddrageoldest_;
			// string _v2__inputaddrdwelltype_;
			// string _v2__divssnidentitycountnew_;
		*/
			integer8 kr_high_risk_address_flag_;
			integer8 kr_high_risk_identity_flag_;
			integer8 kr_medium_risk_address_flag_;
			integer8 kr_medium_risk_identity_flag_;
			integer8 hri03_flag_;
			integer8 hri19_flag_;
			integer8 hri28_flag_;
			integer8 hri37_flag_;
			integer8 hri41_flag_;
			integer8 hri48_flag_;
			integer8 hri51_flag_;
			integer8 hri52_flag_;
			integer8 hri83_flag_;
			integer8 hri90_flag_;
			integer8 hri_cl_flag_;
			integer8 hri_dd_flag_;
			integer8 hri_df_flag_;
			integer8 hri_ms_flag_;
			integer8 hri_nf_flag_;
			integer8 addr_hri11_flag_;
			integer8 addr_hri12_flag_;
			integer8 addr_hri14_flag_;
			integer8 addr_hri25_flag_;
			integer8 addr_hri30_flag_;
			integer8 addr_hri50_flag_;
			integer8 addr_hri_co_flag_;
			integer8 addr_hri_mo_flag_;
			integer8 addr_hri_pa_flag_;
			integer8 addr_hri_po_flag_;
			integer8 addr_hri_va_flag_;
			integer8 ph_hri07_flag_;
			integer8 ph_hri08_flag_;
			integer8 ph_hri15_flag_;
			integer8 ph_hri27_flag_;
			integer8 ph_hri31_flag_;
			integer8 ssn_hri06_flag_;
			integer8 ssn_hri26_flag_;
			integer8 ssn_hri29_flag_;
			integer8 ssn_hri38_flag_;
			integer8 ssn_hri71_flag_;
			integer8 ssn_hri_it_flag_;
			integer8 ssn_hri_mi_flag_;
			integer8 in_customer_population_;
		END;

		scoring_rec xform_scoring(FraudGovPlatform_Services.Layouts.Batch_out_pre_w_raw L) := TRANSFORM
			SELF.customer_id_ :=(UNSIGNED)batch_params.GlobalCompanyId;	//always the same at runtime. To support customer specific weighting and configs
			SELF.industry_type_ := (UNSIGNED)batch_params.IndustryType;	//always the same at runtime. To support customer specific weighting and configs        
			SELF.acctno := L.acctno;
			SELF.lexid := L.batchin_rec.did;
			SELF.entity_context_uid_ := FraudGovPlatform_Analytics.Constants.KelEntityIdentifier.EVENT + (string)L.batchin_rec.did; //11 is Event
			SELF._cvi_:= L.childrecs_ciid[1].cvi;
			SELF._cvicustomscore_:= L.childrecs_ciid[1].cvicustomscore;
			SELF.deceased_:= IF((UNSIGNED)L.childrecs_death[1].dod8 <> 0, 1, 0);
			SELF.deceased_prior_to_event_:= IF((UNSIGNED)L.childrecs_death[1].dod8 <> 0, 1, 0); //if we have never seen this person before and they are dead, then they are dead prior to all their events
			SELF._nas__summary_:= L.childrecs_ciid[1].nas_summary;
			SELF._nap__summary_:= L.childrecs_ciid[1].nap_summary;
			SELF._ssnfoundforlexid_ := L.childRecs_ciid[1].ssnfoundforlexid;
			SELF._subjectssncount_ := (UNSIGNED)L.childrecs_ciid[1].subjectssncount;
			// SELF.stolen_identity_index_;
			// SELF.synthetic_identity_index_;
			// SELF.manipulated_identity_index_;
			// SELF.vulnerable_victim_index_;
			// SELF.friendlyfraud_index_;
			// SELF.suspicious_activity_index_;
			// SELF._v2__sourcerisklevel_;
			// SELF._v2__assocsuspicousidentitiescount_;
			// SELF._v2__assoccreditbureauonlycount_;
			// SELF._v2__validationaddrproblems_;
			// SELF._v2__inputaddrageoldest_;
			// SELF._v2__inputaddrdwelltype_;
			// SELF._v2__divssnidentitycountnew_;
			SELF.kr_high_risk_address_flag_ := IF((L.childrecs_fdn[1].event_type_1 IN ['301','302'] OR L.childrecs_fdn[1].event_type_2 IN ['301','302'] OR L.childrecs_fdn[1].event_type_3 IN ['301','302']) OR 
																						(L.childrecs_velocities[1].ds_payload[1].event_type_1 IN ['301','302'] OR L.childrecs_velocities[1].ds_payload[1].event_type_2 IN ['301','302'] OR L.childrecs_velocities[1].ds_payload[1].event_type_3 IN ['301','302']) OR
																						(L.childrecs_knownfrauds_raw[1].payload[1].event_type_1 IN ['301','302'] OR L.childrecs_knownfrauds_raw[1].payload[1].event_type_2 IN ['301','302'] OR L.childrecs_knownfrauds_raw[1].payload[1].event_type_3 IN ['301','302']), 1, 0);
			high_risk_identity_event_type_set := ['10000','10001','10002','10004','10005','10006','10007','11000','11001','11002','11003','11004','11005','11006','11007','11008','11009','11010','11011','11012','11013','11014','11015','11016','11017','11018','11019','12000','12001','12002','12003','12004','12005','12006','12007','13000','13001','13002','13003','13004','13005','13006','13007','1400'];
			SELF.kr_high_risk_identity_flag_ := IF((L.childrecs_fdn[1].event_type_1 IN high_risk_identity_event_type_set OR L.childrecs_fdn[1].event_type_2 IN high_risk_identity_event_type_set OR L.childrecs_fdn[1].event_type_3 IN high_risk_identity_event_type_set) OR 
																						(L.childrecs_velocities[1].ds_payload[1].event_type_1 IN high_risk_identity_event_type_set OR L.childrecs_velocities[1].ds_payload[1].event_type_2 IN high_risk_identity_event_type_set OR L.childrecs_velocities[1].ds_payload[1].event_type_3 IN high_risk_identity_event_type_set) OR
																						(L.childrecs_knownfrauds_raw[1].payload[1].event_type_1 IN high_risk_identity_event_type_set OR L.childrecs_knownfrauds_raw[1].payload[1].event_type_2 IN high_risk_identity_event_type_set OR L.childrecs_knownfrauds_raw[1].payload[1].event_type_3 IN high_risk_identity_event_type_set), 1, 0);
			SELF.kr_medium_risk_address_flag_ := IF((L.childrecs_fdn[1].event_type_1 IN ['300'] OR L.childrecs_fdn[1].event_type_2 IN ['300'] OR L.childrecs_fdn[1].event_type_3 IN ['300']) OR 
																						(L.childrecs_velocities[1].ds_payload[1].event_type_1 IN ['300'] OR L.childrecs_velocities[1].ds_payload[1].event_type_2 IN ['300'] OR L.childrecs_velocities[1].ds_payload[1].event_type_3 IN ['300']) OR
																						(L.childrecs_knownfrauds_raw[1].payload[1].event_type_1 IN ['300'] OR L.childrecs_knownfrauds_raw[1].payload[1].event_type_2 IN ['300'] OR L.childrecs_knownfrauds_raw[1].payload[1].event_type_3 IN ['300']), 1, 0);
			SELF.kr_medium_risk_identity_flag_ := IF((L.childrecs_fdn[1].event_type_1 IN ['10003','14001'] OR L.childrecs_fdn[1].event_type_2 IN ['10003','14001'] OR L.childrecs_fdn[1].event_type_3 IN ['10003','14001']) OR 
																						(L.childrecs_velocities[1].ds_payload[1].event_type_1 IN ['10003','14001'] OR L.childrecs_velocities[1].ds_payload[1].event_type_2 IN ['10003','14001'] OR L.childrecs_velocities[1].ds_payload[1].event_type_3 IN ['10003','14001']) OR
																						(L.childrecs_knownfrauds_raw[1].payload[1].event_type_1 IN ['10003','14001'] OR L.childrecs_knownfrauds_raw[1].payload[1].event_type_2 IN ['10003','14001'] OR L.childrecs_knownfrauds_raw[1].payload[1].event_type_3 IN ['10003','14001']), 1, 0);
			hriSet := SET(L.childrecs_ciid[1].ri, hri);
			SELF.hri03_flag_ := IF('03' IN hriSet, 1, 0);
			SELF.hri19_flag_ := IF('19' IN hriSet, 1, 0);
			SELF.hri28_flag_ := IF('28' IN hriSet, 1, 0);
			SELF.hri37_flag_ := IF('37' IN hriSet, 1, 0);
			SELF.hri41_flag_ := IF('41' IN hriSet, 1, 0);
			SELF.hri48_flag_ := IF('48' IN hriSet, 1, 0);
			SELF.hri51_flag_ := IF('51' IN hriSet, 1, 0);
			SELF.hri52_flag_ := IF('52' IN hriSet, 1, 0);
			SELF.hri83_flag_ := IF('83' IN hriSet, 1, 0);
			SELF.hri90_flag_ := IF('90' IN hriSet, 1, 0);
			SELF.hri_cl_flag_ := IF('CL' IN hriSet, 1, 0);
			SELF.hri_dd_flag_ := IF('DD' IN hriSet, 1, 0);
			SELF.hri_df_flag_ := IF('DF' IN hriSet, 1, 0);
			SELF.hri_ms_flag_ := IF('MS' IN hriSet, 1, 0);
			SELF.hri_nf_flag_ := IF('NF' IN hriSet, 1, 0);
			SELF.addr_hri11_flag_ := IF('11' IN hriSet, 1, 0);
			SELF.addr_hri12_flag_ := IF('12' IN hriSet, 1, 0);
			SELF.addr_hri14_flag_ := IF('14' IN hriSet, 1, 0);
			SELF.addr_hri25_flag_ := IF('25' IN hriSet, 1, 0);
			SELF.addr_hri30_flag_ := IF('30' IN hriSet, 1, 0);
			SELF.addr_hri50_flag_ := IF('50' IN hriSet, 1, 0);
			SELF.addr_hri_co_flag_ := IF('CO' IN hriSet, 1, 0);
			SELF.addr_hri_mo_flag_ := IF('MO' IN hriSet, 1, 0);
			SELF.addr_hri_pa_flag_ := IF('PA' IN hriSet, 1, 0);
			SELF.addr_hri_po_flag_ := IF('PO' IN hriSet, 1, 0);
			SELF.addr_hri_va_flag_ := IF('VA' IN hriSet, 1, 0);
			SELF.ph_hri07_flag_ := IF('07' IN hriSet, 1, 0);
			SELF.ph_hri08_flag_ := IF('08' IN hriSet, 1, 0);
			SELF.ph_hri15_flag_ := IF('15' IN hriSet, 1, 0);
			SELF.ph_hri27_flag_ := IF('27' IN hriSet, 1, 0);
			SELF.ph_hri31_flag_ := IF('31' IN hriSet, 1, 0);
			SELF.ssn_hri06_flag_ := IF('06' IN hriSet, 1, 0);
			SELF.ssn_hri26_flag_ := IF('26' IN hriSet, 1, 0);
			SELF.ssn_hri29_flag_ := IF('29' IN hriSet, 1, 0);
			SELF.ssn_hri38_flag_ := IF('38' IN hriSet, 1, 0);
			SELF.ssn_hri71_flag_ := IF('71' IN hriSet, 1, 0);
			SELF.ssn_hri_it_flag_ := IF('IT' IN hriSet, 1, 0);
			SELF.ssn_hri_mi_flag_ := IF('MI' IN hriSet, 1, 0);
			SELF.in_customer_population_ := 0; //the identity is not in the customer's population
		END;
		roxieInputPrep := PROJECT(ds_in, xform_scoring(LEFT));

		//Pivot to put the dataset in the expected layout for scoring						
		scoringInput := FraudGovPlatform_Analytics.macPivotOttoOutput(roxieInputPrep, 'acctno,customer_id_,industry_type_,entity_context_uid_,lexid',
												 '_nas__summary_,_nap__summary_,_cvi_,_ssnfoundforlexid_,_cvicustomscore_,_subjectssncount_,' + 
													//  'stolen_identity_index_,synthetic_identity_index_,manipulated_identity_index_,vulnerable_victim_index_,friendlyfraud_index_,suspicious_activity_index_,' + 
													//  '_v2__sourcerisklevel_,_v2__assocsuspicousidentitiescount_,_v2__assoccreditbureauonlycount_,_v2__validationaddrproblems_,_v2__inputaddrageoldest_,_v2__inputaddrdwelltype_,_v2__divssnidentitycountnew_,' + 
												'kr_high_risk_address_flag_,kr_high_risk_identity_flag_,kr_medium_risk_address_flag_,kr_medium_risk_identity_flag_,' +
												/*'deceased_,*/'deceased_prior_to_event_,' + 
												'hri03_flag_,hri19_flag_,hri28_flag_,hri37_flag_,hri41_flag_,hri48_flag_,hri51_flag_,hri52_flag_,hri83_flag_,hri90_flag_,' + 
												'hri_cl_flag_,hri_dd_flag_,hri_df_flag_,hri_ms_flag_,hri_nf_flag_,' + 
												'addr_hri11_flag_,addr_hri12_flag_,addr_hri14_flag_,addr_hri25_flag_,addr_hri30_flag_,addr_hri50_flag_,addr_hri_co_flag_,addr_hri_mo_flag_,addr_hri_pa_flag_,addr_hri_po_flag_,addr_hri_va_flag_,' + 
												'ph_hri07_flag_,ph_hri08_flag_,ph_hri15_flag_,ph_hri27_flag_,ph_hri31_flag_,' + 
												'ssn_hri06_flag_,ssn_hri26_flag_,ssn_hri29_flag_,ssn_hri38_flag_,ssn_hri71_flag_,ssn_hri_it_flag_,ssn_hri_mi_flag_'     
													);
		RETURN scoringInput;
	END;
	
END;