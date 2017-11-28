IMPORT Data_Services, lib_StringLib;
	Incidents := FLAccidents_Ecrash.IncidentsAfterSuppression(Source_id IN ['EA','TM','TF'] );

	// Suppress the DE records basing on the drivers_exchange_flag in the agency file. 
	suppressAgencies := FLAccidents_Ecrash.Infiles.agency(drivers_exchange_flag ='0');

	Incidents_DE_Suppression :=  JOIN(Incidents,suppressAgencies(agency_id!=''),
																																TRIM(LEFT.agency_id,LEFT,RIGHT) = TRIM(RIGHT.agency_id,LEFT,RIGHT) AND TRIM(LEFT.report_type_id,LEFT,RIGHT) ='DE' ,
																																MANY LOOKUP , LEFT ONLY );	
							
	FLAccidents_Ecrash.Layout_VehIncidents.SlimIncidents RemoveNulls(Incidents_DE_Suppression L) := TRANSFORM
			acc_nbr 																:= 	IF(L.source_id IN ['TM','TF'], stringlib.stringtouppercase(L.State_Report_number), stringlib.stringtouppercase(L.Case_identIFier));
			t_scrub 																:= 	stringlib.StringFilter(acc_nbr,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
			accident_nbr 													:= 	IF(t_scrub IN ['UNK', 'UNKNOWN'], 'UNK'+l.incident_id,t_scrub); 
			jurisdiction_state										:= 	IF(L.case_identifier = '11030001','GA',L.Loss_state_Abbr);
			jurisdiction															:= 	IF(L.incident_id[1..9]='188188188' ,'LN Test PD',TRIM(L.agency_name,LEFT,RIGHT));
			t_accident_date 										:= 	stringlib.stringfilterout(TRIM(L.crash_date,LEFT,RIGHT),'-');
			accident_date					    					:= 	IF(L.incident_id[1..9] ='188188188','20100901',t_accident_date);
			Sent_to_HPCC_DateTime 				:= 	stringlib.stringfilterout(TRIM(L.Sent_to_HPCC_DateTime,LEFT,RIGHT),'-');
			jurisdiction_nbr				    					:= 	IF(L.incident_id[1..9]='188188188','1536035',L.AGENCY_ID);
			SELF.agency_id 											:= IF(stringlib.stringtouppercase(TRIM(L.agency_id,LEFT,RIGHT))='NULL','',L.agency_id);
		 SELF.Work_Type_ID 								:= IF(stringlib.stringtouppercase(TRIM(L.Work_Type_ID,LEFT,RIGHT))='NULL','',L.Work_Type_ID);
		 SELF.vehicle_incident_id 					:= IF(stringlib.stringtouppercase(TRIM(L.incident_id,LEFT,RIGHT))='NULL','',L.incident_id);
		 SELF.accident_nbr 									:= IF(stringlib.stringtouppercase(TRIM(accident_nbr,LEFT,RIGHT))='NULL','',accident_nbr);
		 SELF.Sent_to_HPCC_DateTime 	:= IF(stringlib.stringtouppercase(TRIM(Sent_to_HPCC_DateTime,LEFT,RIGHT))='NULL','',Sent_to_HPCC_DateTime);
		 SELF.accident_date 								:= IF(stringlib.stringtouppercase(TRIM(accident_date,LEFT,RIGHT))='NULL','',accident_date);
		 SELF.report_code 										:= IF(stringlib.stringtouppercase(TRIM(L.Source_id,LEFT,RIGHT))='NULL','',L.Source_id);
		 SELF.report_id 												:= IF(stringlib.stringtouppercase(TRIM(L.report_id,LEFT,RIGHT))IN ['NULL', 'NUL'],'',L.report_id);
		 SELF.report_type_id 								:= IF(stringlib.stringtouppercase(TRIM(L.report_type_id,LEFT,RIGHT)) IN ['NULL', 'NUL'],'',L.report_type_id);
		 SELF.jurisdiction_state 						:= IF(stringlib.stringtouppercase(TRIM(jurisdiction_state,LEFT,RIGHT))='NULL','',jurisdiction_state);
			SELF.jurisdiction_nbr 							:= IF(stringlib.stringtouppercase(TRIM(jurisdiction_nbr,LEFT,RIGHT))='NULL','',jurisdiction_nbr);
		 SELF.jurisdiction 										:= IF(stringlib.stringtouppercase(TRIM(jurisdiction,LEFT,RIGHT))='NULL','',jurisdiction);
		 SELF.cru_order_id 									:= IF(stringlib.stringtouppercase(TRIM(L.cru_order_id,LEFT,RIGHT))='NULL','',L.cru_order_id);
			SELF.ORI_number 									:= IF(stringlib.stringtouppercase(TRIM(L.ORI_number,LEFT,RIGHT))='NULL','',L.ORI_number);
			SELF.Crash_City 										:= IF(stringlib.stringtouppercase(TRIM(L.Crash_City,LEFT,RIGHT))='NULL','',L.Crash_City);
			SELF.Loss_Street 										:= IF(stringlib.stringtouppercase(TRIM(L.Loss_Street,LEFT,RIGHT))='NULL','',L.Loss_Street);
			SELF.Loss_cross_street 					:= IF(stringlib.stringtouppercase(TRIM(L.Loss_cross_street,LEFT,RIGHT))='NULL','',L.Loss_cross_street);
			SELF.vehicle_incident_id_latest	:= 	'';
			SELF 																		:= 	L;
	END; 

	CleanIncidents := PROJECT(Incidents_DE_Suppression,RemoveNulls(LEFT)) :INDEPENDENT;

	//   drop any TM's that came after TF's
	TMReports 					:= DISTRIBUTE(CleanIncidents(report_code  = 'TM'),HASH32(accident_nbr));
	TFReports 					:= DISTRIBUTE(CleanIncidents(report_code  = 'TF'),HASH32(accident_nbr));

	Jn_TM_Reports 		:= JOIN(TMReports,TFReports, 
																								LEFT.accident_nbr = RIGHT.accident_nbr AND 
																								LEFT.ORI_Number = RIGHT.ORI_Number AND 
																								TRIM(LEFT.jurisdiction_state, LEFT,RIGHT) = TRIM(RIGHT.jurisdiction_state, LEFT,RIGHT) AND 
																								TRIM(LEFT.report_type_id, LEFT,RIGHT)  = TRIM(RIGHT.report_type_id, LEFT,RIGHT) AND 
																								LEFT.Sent_to_HPCC_DateTime >= RIGHT.Sent_to_HPCC_DateTime,
																								TRANSFORM(LEFT) , LEFT ONLY, LOCAL) ; 		

	IncidentsAfterTMTF	:= 	CleanIncidents(report_code IN ['EA']) + Jn_TM_Reports  + TFReports :INDEPENDENT;

	//Meow Key
	

	iMeowKey 							:= INDEX(DATASET([],FLAccidents_Ecrash.Layout_VehIncidents.MeowLayout),{idfield}, {FLAccidents_Ecrash.Layout_VehIncidents.MeowLayout -{idfield}}, '~foreign::'+Constants.alpha_ip+'::thor_data400::key::ecrash_cru::qa::idfield::meow');
			 
	MeowKey 							:= DISTRIBUTE(PULL(iMeowKey(report_code IN ['EA','TM','TF'])),HASH32(vehicle_incident_id));
		
	dMeowKey 						:= DISTRIBUTE(DEDUP(SORT(MeowKey, vehicle_incident_id, LOCAL), vehicle_incident_id, LOCAL), HASH32(l_accnbr)) : INDEPENDENT;
			
	FLAccidents_Ecrash.Layout_VehIncidents.SlimIncidents trecs(IncidentsAfterTMTF L, dMeowKey R) := TRANSFORM
			SELF.vehicle_incident_id_latest 	:=  R.vehicle_incident_id; 
			SELF 																			:= L;
	END;  

	TMTFIncidents  	 	:=		IncidentsAfterTMTF(report_code IN ['TM', 'TF']);
	NonTMTFIncidents 	:= 	IncidentsAfterTMTF(report_code NOT IN ['TM', 'TF']);
	TMTFMeow							:=		dMeowKey(report_code IN ['TM', 'TF']);
	NonTMTFMeow				:=	 dMeowKey(report_code NOT IN ['TM', 'TF']);
			
	JnIncidentsTMTF 		:= 	JOIN(TMTFIncidents , TMTFMeow,
																											TRIM(LEFT.accident_nbr,LEFT,RIGHT) 			= TRIM(RIGHT.l_accnbr,LEFT,RIGHT) AND 
																											TRIM(LEFT.jurisdiction_state,LEFT,RIGHT)	= TRIM(RIGHT.jurisdiction_state,LEFT,RIGHT) AND
																											TRIM(LEFT.jurisdiction_nbr,LEFT,RIGHT) 		= TRIM(RIGHT.jurisdiction_nbr,LEFT,RIGHT) AND
																											TRIM(LEFT.report_code,LEFT,RIGHT) 				= TRIM(RIGHT.report_code,LEFT,RIGHT) AND 
																											TRIM(LEFT.report_type_id,LEFT,RIGHT) 		= TRIM(RIGHT.report_type_id,LEFT,RIGHT),
																											trecs(LEFT,RIGHT), LEFT OUTER, LOCAL);

	MatchedTMTF 				:= JnIncidentsTMTF(TRIM(vehicle_incident_id_latest,LEFT,RIGHT) != '');
	NonMatchingTMTF 	:= JnIncidentsTMTF(TRIM(vehicle_incident_id_latest,LEFT,RIGHT) = '');
	NonMatchingTM				:= NonMatchingTMTF(report_code IN ['TM']);
	NonMatchingTF				:= JnIncidentsTMTF(report_code IN ['TF']);

	FLAccidents_Ecrash.Layout_VehIncidents.SlimIncidents trecs1(NonMatchingTM L, NonMatchingTF R) := TRANSFORM
		SELF.vehicle_incident_id_latest 	:=		R.vehicle_incident_id; 
		SELF 																			:=		L;
	END;
	jnNonMatchIncidentsTMTF := 	JOIN(NonMatchingTM,NonMatchingTF, 
																															TRIM(LEFT.accident_nbr,LEFT,RIGHT) 			= TRIM(RIGHT.accident_nbr,LEFT,RIGHT) AND 
																															TRIM(LEFT.ORI_Number,LEFT,RIGHT) 			= TRIM(RIGHT.ORI_Number,LEFT,RIGHT) AND 
																															TRIM(LEFT.jurisdiction_state,LEFT,RIGHT) = TRIM(RIGHT.jurisdiction_state,LEFT,RIGHT) AND
																															TRIM(LEFT.report_type_id,LEFT,RIGHT) 		= TRIM(RIGHT.report_type_id,LEFT,RIGHT), 
																															trecs1(LEFT,RIGHT),LEFT OUTER, LOCAL);
	MatchedIncidentsTMTF			:= 	jnNonMatchIncidentsTMTF(TRIM(vehicle_incident_id_latest,LEFT,RIGHT) != '');

	JnIncidentNonTMTF 				:= 	JOIN(NonTMTFIncidents , NonTMTFMeow,
																																TRIM(LEFT.accident_nbr,LEFT,RIGHT) 			= TRIM(RIGHT.l_accnbr,LEFT,RIGHT) AND 
																																(INTEGER)LEFT.accident_date 							= (INTEGER)RIGHT.accident_date AND
																																TRIM(LEFT.jurisdiction_state,LEFT,RIGHT) = TRIM(RIGHT.jurisdiction_state,LEFT,RIGHT) AND
																																TRIM(LEFT.report_code,LEFT,RIGHT) 				= TRIM(RIGHT.report_code,LEFT,RIGHT) AND 
																																TRIM(LEFT.report_type_id,LEFT,RIGHT) 		= TRIM(RIGHT.report_type_id,LEFT,RIGHT),
																																trecs(LEFT,RIGHT), LEFT OUTER , LOCAL) : INDEPENDENT;
																																						
	MatchedInicdentOthers 		:= 	JnIncidentNonTMTF(TRIM(vehicle_incident_id_latest,LEFT,RIGHT) != '');																																						
	dsJnEmptyIncidentId 			:= 	JnIncidentNonTMTF(TRIM(vehicle_incident_id_latest,LEFT,RIGHT) = '');
											
	CruIncidents 									:= 	JnIncidentNonTMTF(Work_Type_ID IN ['2','3'] AND TRIM(vehicle_incident_id_latest,LEFT,RIGHT) = '' ) ;
	NonCruIncidents 						:= 	JnIncidentNonTMTF(Work_Type_ID NOT IN ['2','3'] AND TRIM(vehicle_incident_id_latest,LEFT,RIGHT) = '' ) ;

	JnIncidentsCru 							:= 	JOIN(CruIncidents	, NonTMTFMeow,
																																TRIM(LEFT.accident_nbr,LEFT,RIGHT) 			= TRIM(RIGHT.l_accnbr,LEFT,RIGHT) AND 
																																TRIM(LEFT.jurisdiction_state,LEFT,RIGHT) = TRIM(RIGHT.jurisdiction_state,LEFT,RIGHT) AND
																																TRIM(LEFT.report_code,LEFT,RIGHT) 				= TRIM(RIGHT.report_code,LEFT,RIGHT) AND
																																TRIM(LEFT.jurisdiction_nbr,LEFT,RIGHT) 		= TRIM(RIGHT.jurisdiction_nbr,LEFT,RIGHT) AND
																																TRIM(LEFT.cru_order_id	,LEFT,RIGHT)				= TRIM(RIGHT.cru_order_id,LEFT,RIGHT) AND 
																																TRIM(LEFT.report_type_id,LEFT,RIGHT) 		= TRIM(RIGHT.report_type_id,LEFT,RIGHT),
																																trecs(LEFT,RIGHT), LEFT OUTER , LOCAL);
																										
	MatchedIncidentsCru 				:= JnIncidentsCru(TRIM(vehicle_incident_id_latest,LEFT,RIGHT) != '');		
	FinalNonMatchingIncidents	:= JnIncidentsCru(TRIM(vehicle_incident_id_latest,LEFT,RIGHT) = '') + NonCruIncidents + jnNonMatchIncidentsTMTF(TRIM(vehicle_incident_id_latest,LEFT,RIGHT) = '') + NonMatchingTMTF(report_code not IN ['TM']) :persist('~thor_data400::ecrash::persist::FinalNonMatchinginIncidents') ;
				

	FLAccidents_Ecrash.Layout_VehIncidents.SlimIncidents trecs4(FinalNonMatchingIncidents L, dMeowKey R) := TRANSFORM
		SELF.vehicle_incident_id_latest 	:=		R.vehicle_incident_id; 
		SELF 																			:= 	L;
	END; 

	JnFinalNonMatchingIncidents	:= JOIN(FinalNonMatchingIncidents(report_code IN ['EA'] AND work_type_id IN ['0','1','2','3'])	, NonTMTFMeow,
																																TRIM(LEFT.accident_date,LEFT,RIGHT) 			= TRIM(RIGHT.accident_date,LEFT,RIGHT) AND 
																																TRIM(LEFT.jurisdiction_state,LEFT,RIGHT)	= TRIM(RIGHT.jurisdiction_state,LEFT,RIGHT) AND
																																TRIM(LEFT.report_code,LEFT,RIGHT) 				= TRIM(RIGHT.report_code,LEFT,RIGHT) AND
																																TRIM(LEFT.report_type_id,LEFT,RIGHT) 		= TRIM(RIGHT.report_type_id,LEFT,RIGHT) AND
																																TRIM(LEFT.crash_city,LEFT,RIGHT) 					= TRIM(RIGHT.vehicle_incident_city,LEFT,RIGHT) AND
																																TRIM(LEFT.loss_street,LEFT,RIGHT) 				= TRIM(RIGHT.accident_street,LEFT,RIGHT) AND
																																TRIM(LEFT.loss_cross_street,LEFT,RIGHT) = TRIM(RIGHT.accident_cross_street,LEFT,RIGHT) AND
																																(LEFT.report_code NOT IN ['TM','TF'] OR TRIM(LEFT.ori_number,LEFT,RIGHT) = TRIM(RIGHT.agency_ori,LEFT,RIGHT)), 
																																trecs4(LEFT,RIGHT), LEFT OUTER);
																		
	FinalMatchedIncidents			:= JnFinalNonMatchingIncidents(TRIM(vehicle_incident_id_latest,LEFT,RIGHT) != '');

	MatchedIncidents 											:= MatchedTMTF + MatchedIncidentsTMTF +MatchedInicdentOthers + MatchedIncidentsCru + FinalMatchedIncidents;
	EXPORT BuildIncidentsExtract 			:= DEDUP(SORT(DISTRIBUTE(MatchedIncidents, HASH32(vehicle_incident_id)), vehicle_incident_id, LOCAL), vehicle_incident_id, LOCAL);
											
