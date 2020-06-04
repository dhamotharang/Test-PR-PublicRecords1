import MDR;

export SourceTools := module

	// Source Types
	export PublicRecords						:= 'PUBLIC RECORDS';
	export InsuranceRecords					:= 'INSURANCE RECORDS';
	export InquiryRecords						:= 'INQUIRY RECORDS';
	export PolicyRecords						:= 'POLICY';
	export AutoClaimsRecords				:= 'CLUE AUTO';
	export PropertyClaimsRecords		:= 'CLUE PROPERTY';
	export CompIdDMV								:= 'COMPID DMV';
	export InsuranceDMV							:= 'INSURANCE DMV';
	export MVRCourt									:= 'MVR COURT';
	export MVRDMV										:= 'MVR DMV';
	
	export src_boca_header							:= 'ADL';	// Public Header from Boca
	export src_ins_clue_auto						:= 'ICA'; // Clue Auto
	export src_ins_clue_property				:= 'ICP'; // Clue Property
	export src_ins_current_carrier			:= 'IVS'; // Current Carrier
	export src_ins_dmv_ks								:= 'IKS'; // Kensas DMV Data
	export src_ins_dmv_nm								:= 'INM'; // New Mexico DMV Data
	export src_ins_dmv_nc								:= 'INC'; // North Carolina DMV Data
	export src_ins_compid_dmv						:= 'CID';	// DMV data from mainframe comp-id
	export src_ins_inq_mvr							:= 'MVR'; // Inquiry Data - MVR

	// CompID DMV States
	export src_ins_dmv_mo				 				:= 'CIDMO'; // MISSOURI DMV Data 
	export src_ins_dmv_nh								:= 'CIDNH'; // New Hampshire DMV Data 
	export src_ins_dmv_or				 				:= 'CIDOR'; // Oregon DMV Data
	export src_ins_dmv_sc 							:= 'CIDSC'; // South Carolina DMV Data 	
	export src_ins_dmv_wi 							:= 'CIDWI'; // Wisconsin DMV Data 
	export src_ins_dmv_wv 							:= 'CIDWV'; // West Virginia DMV Data 
	// Following stats will be added to boca dmv file - 11/17/2010
	export src_ins_dmv_nv 							:= 'CIDNV'; // Nevada DMV Data 
	export src_ins_dmv_la								:= 'CIDLA'; // Louisiana DMV Data
	export src_ins_dmv_ne				 				:= 'CIDNE'; // Nebraska DMV Data
	// Historical CompID DMV States
	export src_ins_dmv_co				 				:= 'CIDCO'; // Colorado DMV Data 
	export src_ins_dmv_de								:= 'CIDDE'; // Delaware DMV Data 
	export src_ins_dmv_ia				 				:= 'CIDIA'; // Iowa DMV Data
	export src_ins_dmv_id 							:= 'CIDID'; // Idaho DMV Data 
	export src_ins_dmv_il								:= 'CIDIL'; // Illinois DMV Data
	export src_ins_dmv_ky				 				:= 'CIDKY'; // Kentucky DMV Data
	export src_ins_dmv_md				 				:= 'CIDMD'; // MISSOURI DMV Data 
	export src_ins_dmv_ms								:= 'CIDMS'; // Mississippi DMV Data 
	export src_ins_dmv_nd				 				:= 'CIDND'; // North Dakota DMV Data
	
// NIC States
	export src_ins_nic_co				 				:= 'NICCO'; // Colorado DMV Data
	export src_ins_nic_id				 				:= 'NICID'; // Idaho DMV Data
	export src_ins_nic_nm				 				:= 'NICNM'; // New Mexico DMV Data
	export src_ins_nic_va				 				:= 'NICVA'; // Virginia DMV Data

// MVR Inquiry	
	EXPORT src_ins_mvrinq 								:= 'MVRINQ'; // MVR Inquiry Data
	
// MVR Court
	SHARED mvrcrt_prefix									:= 'MVRCRT';
	
	EXPORT src_ins_mvrcrt_az							:= mvrcrt_prefix + 'AZ';
	EXPORT src_ins_mvrcrt_ct							:= mvrcrt_prefix + 'CT';
	EXPORT src_ins_mvrcrt_fl							:= mvrcrt_prefix + 'FL';
	EXPORT src_ins_mvrcrt_il							:= mvrcrt_prefix + 'IL';
	EXPORT src_ins_mvrcrt_in							:= mvrcrt_prefix + 'IN';		
	EXPORT src_ins_mvrcrt_la							:= mvrcrt_prefix + 'LA';
	EXPORT src_ins_mvrcrt_md							:= mvrcrt_prefix + 'MD';				
	EXPORT src_ins_mvrcrt_nd							:= mvrcrt_prefix + 'ND';
	EXPORT src_ins_mvrcrt_nj							:= mvrcrt_prefix + 'NJ';
	EXPORT src_ins_mvrcrt_nv							:= mvrcrt_prefix + 'NV';
	EXPORT src_ins_mvrcrt_ok							:= mvrcrt_prefix + 'OK';
	EXPORT src_ins_mvrcrt_pa							:= mvrcrt_prefix + 'PA';
	EXPORT src_ins_mvrcrt_ri							:= mvrcrt_prefix + 'RI';
	EXPORT src_ins_mvrcrt_tx							:= mvrcrt_prefix + 'TX';
	EXPORT src_ins_mvrcrt_wi							:= mvrcrt_prefix + 'WI';
	EXPORT src_ins_mvrcrt_va							:= mvrcrt_prefix + 'VA';
	
	//MVR DMV
	SHARED mvrdmv_prefix := 'MVRDMV';
	
	EXPORT src_ins_mvrdmv_al							:= mvrdmv_prefix + 'AL';
	EXPORT src_ins_mvrdmv_ak							:= mvrdmv_prefix + 'AK';
	EXPORT src_ins_mvrdmv_ar							:= mvrdmv_prefix + 'AR';
	EXPORT src_ins_mvrdmv_az							:= mvrdmv_prefix + 'AZ';
	EXPORT src_ins_mvrdmv_ca							:= mvrdmv_prefix + 'CA';
	EXPORT src_ins_mvrdmv_co							:= mvrdmv_prefix + 'CO';
	EXPORT src_ins_mvrdmv_ct							:= mvrdmv_prefix + 'CT';
	EXPORT src_ins_mvrdmv_de							:= mvrdmv_prefix + 'DE';
	EXPORT src_ins_mvrdmv_fl							:= mvrdmv_prefix + 'FL';
	EXPORT src_ins_mvrdmv_ga							:= mvrdmv_prefix + 'GA';
	EXPORT src_ins_mvrdmv_hi							:= mvrdmv_prefix + 'HI';
	EXPORT src_ins_mvrdmv_id							:= mvrdmv_prefix + 'ID';
	EXPORT src_ins_mvrdmv_il							:= mvrdmv_prefix + 'IL';
	EXPORT src_ins_mvrdmv_in							:= mvrdmv_prefix + 'IN';		
	EXPORT src_ins_mvrdmv_ia							:= mvrdmv_prefix + 'IA';		
	EXPORT src_ins_mvrdmv_ks							:= mvrdmv_prefix + 'KS';		
	EXPORT src_ins_mvrdmv_ky							:= mvrdmv_prefix + 'KY';		
	EXPORT src_ins_mvrdmv_la							:= mvrdmv_prefix + 'LA';
	EXPORT src_ins_mvrdmv_me							:= mvrdmv_prefix + 'ME';				
	EXPORT src_ins_mvrdmv_md							:= mvrdmv_prefix + 'MD';				
	EXPORT src_ins_mvrdmv_ma							:= mvrdmv_prefix + 'MA';				
	EXPORT src_ins_mvrdmv_mi							:= mvrdmv_prefix + 'MI';				
	EXPORT src_ins_mvrdmv_mn							:= mvrdmv_prefix + 'MN';				
	EXPORT src_ins_mvrdmv_ms							:= mvrdmv_prefix + 'MS';				
	EXPORT src_ins_mvrdmv_mo							:= mvrdmv_prefix + 'MO';				
	EXPORT src_ins_mvrdmv_mt							:= mvrdmv_prefix + 'MT';				
	EXPORT src_ins_mvrdmv_ne							:= mvrdmv_prefix + 'NE';				
	EXPORT src_ins_mvrdmv_nv							:= mvrdmv_prefix + 'NV';
	EXPORT src_ins_mvrdmv_nh							:= mvrdmv_prefix + 'NH';
	EXPORT src_ins_mvrdmv_nj							:= mvrdmv_prefix + 'NJ';
	EXPORT src_ins_mvrdmv_nm							:= mvrdmv_prefix + 'NM';
	EXPORT src_ins_mvrdmv_ny							:= mvrdmv_prefix + 'NY';
	EXPORT src_ins_mvrdmv_nc							:= mvrdmv_prefix + 'NC';
	EXPORT src_ins_mvrdmv_nd							:= mvrdmv_prefix + 'ND';
	EXPORT src_ins_mvrdmv_oh							:= mvrdmv_prefix + 'OH';
	EXPORT src_ins_mvrdmv_ok							:= mvrdmv_prefix + 'OK';
	EXPORT src_ins_mvrdmv_or							:= mvrdmv_prefix + 'OR';
	EXPORT src_ins_mvrdmv_pa							:= mvrdmv_prefix + 'PA';
	EXPORT src_ins_mvrdmv_ri							:= mvrdmv_prefix + 'RI';
	EXPORT src_ins_mvrdmv_sc							:= mvrdmv_prefix + 'SC';
	EXPORT src_ins_mvrdmv_sd							:= mvrdmv_prefix + 'SD';
	EXPORT src_ins_mvrdmv_tn							:= mvrdmv_prefix + 'TN';
	EXPORT src_ins_mvrdmv_tx							:= mvrdmv_prefix + 'TX';
	EXPORT src_ins_mvrdmv_ut							:= mvrdmv_prefix + 'UT';
	EXPORT src_ins_mvrdmv_vt							:= mvrdmv_prefix + 'VT';
	EXPORT src_ins_mvrdmv_va							:= mvrdmv_prefix + 'VA';
	EXPORT src_ins_mvrdmv_wa							:= mvrdmv_prefix + 'WA';
	EXPORT src_ins_mvrdmv_wv							:= mvrdmv_prefix + 'WV';
	EXPORT src_ins_mvrdmv_wi							:= mvrdmv_prefix + 'WI';
	EXPORT src_ins_mvrdmv_wy							:= mvrdmv_prefix + 'WY';
	EXPORT src_ins_mvrdmv_other						:= mvrdmv_prefix + 'XX';   
	
	// GLB Sources
	export src_Equifax										:= 'ADL' + mdr.sourceTools.src_Equifax;
	export src_Experian_Credit_Header			:= 'ADL' + mdr.sourceTools.src_Experian_Credit_Header;
	export src_Utilities									:= 'ADL' + mdr.sourceTools.src_Utilities;
	export src_Util_Work_Phone						:= 'ADL' + mdr.sourceTools.src_Util_Work_Phone;
	export src_ZUtilities									:= 'ADL' + mdr.sourceTools.src_ZUtilities;
	export src_ZUtil_Work_Phone						:= 'ADL' + mdr.sourceTools.src_ZUtil_Work_Phone;
	
	// FCRA date restricted sources
	export src_Bankruptcy 								:= src_boca_header + mdr.sourceTools.src_Bankruptcy;
	export src_Liens											:= src_boca_header + mdr.sourceTools.src_Liens_v2;
	
	// Current Carrier Insurance type
	export cc_personal_auto							:= 'PA';
	export cc_personal_property					:= 'PP';
	export cc_commercial_auto						:= 'CA';
	export cc_commercial_property				:= 'CP';
	
	// CustomerTest
	export src_ct_experian 							:= 'EXPERIAN';
	export src_ct_mvrdhdb								:= 'MVRDHDB';
	

	export set_insurance_sources            := [
		 src_ins_clue_auto           ,src_ins_clue_property               ,src_ins_current_carrier
		,src_ins_dmv_ks						   ,src_ins_dmv_nc											,src_ins_dmv_nm
		,src_ins_compid_dmv          ,src_ins_inq_mvr 										,src_ins_mvrcrt_az
		,src_ins_mvrcrt_ct					 ,src_ins_mvrcrt_fl										,src_ins_mvrcrt_il
		,src_ins_mvrcrt_in					 ,src_ins_mvrcrt_la										,src_ins_mvrcrt_md
		,src_ins_mvrcrt_nd					 ,src_ins_mvrcrt_nj										,src_ins_mvrcrt_nv
		,src_ins_mvrcrt_ok					 ,src_ins_mvrcrt_pa										,src_ins_mvrcrt_ri
		,src_ins_mvrcrt_tx					 ,src_ins_mvrcrt_va										,src_ins_mvrcrt_wi
	];
	
	export set_insurance_dmv_sources      	:= [
		 src_ins_dmv_ks						  ,src_ins_dmv_nc											,src_ins_dmv_nm
	];

	export set_compid_dmv_sources            := [
		src_ins_dmv_mo						  ,src_ins_dmv_nh											,src_ins_dmv_or
	 ,src_ins_dmv_ne						  ,src_ins_dmv_nv											,src_ins_dmv_la
	 // Historical CompID DMVs
 	 ,src_ins_dmv_co 							,src_ins_dmv_de 										,src_ins_dmv_ia
 	 ,src_ins_dmv_id 							,src_ins_dmv_il 										,src_ins_dmv_ky
 	 ,src_ins_dmv_md 							,src_ins_dmv_ms 										,src_ins_dmv_nd
 	 ,src_ins_dmv_sc              ,src_ins_dmv_wi                     ,src_ins_dmv_wv
	];

	export set_insurance_nic_sources      	:= [
		 src_ins_nic_co						  ,src_ins_nic_id											,src_ins_nic_nm			
		 ,src_ins_nic_va
	];

	export set_public_header_sources            := [
		src_boca_header
	];

	export set_current_carrier_sources          := [
		src_ins_current_carrier
	];

	export set_clue_auto_sources            		:= [
		src_ins_clue_auto
	];

	export set_clue_property_sources            := [
		src_ins_clue_property
	];
	
	export set_mvrcrt_sources 									:= [ 
		 src_ins_mvrcrt_az					 ,src_ins_mvrcrt_ct					 					,src_ins_mvrcrt_fl										
		,src_ins_mvrcrt_il					 ,src_ins_mvrcrt_in					 					,src_ins_mvrcrt_la										
		,src_ins_mvrcrt_md					 ,src_ins_mvrcrt_nd					 					,src_ins_mvrcrt_nj										
		,src_ins_mvrcrt_nv					 ,src_ins_mvrcrt_ok					 					,src_ins_mvrcrt_pa
		,src_ins_mvrcrt_ri					 ,src_ins_mvrcrt_tx								    ,src_ins_mvrcrt_va										
		,src_ins_mvrcrt_wi
	];
	
	export set_mvrdmv_sources 									:= [ 
		 src_ins_mvrdmv_al					 ,src_ins_mvrdmv_ak										,src_ins_mvrdmv_ar
		,src_ins_mvrdmv_az					 ,src_ins_mvrdmv_ca										,src_ins_mvrdmv_co
		,src_ins_mvrdmv_ct					 ,src_ins_mvrdmv_de										,src_ins_mvrdmv_fl
		,src_ins_mvrdmv_ga					 ,src_ins_mvrdmv_hi										,src_ins_mvrdmv_id
		,src_ins_mvrdmv_il					 ,src_ins_mvrdmv_in										,src_ins_mvrdmv_ia		
		,src_ins_mvrdmv_ks					 ,src_ins_mvrdmv_ky										,src_ins_mvrdmv_la
		,src_ins_mvrdmv_me					 ,src_ins_mvrdmv_md										,src_ins_mvrdmv_ma				
		,src_ins_mvrdmv_mi					 ,src_ins_mvrdmv_mn										,src_ins_mvrdmv_ms				
		,src_ins_mvrdmv_mo					 ,src_ins_mvrdmv_mt										,src_ins_mvrdmv_ne				
		,src_ins_mvrdmv_nv					 ,src_ins_mvrdmv_nh										,src_ins_mvrdmv_nj
		,src_ins_mvrdmv_nm					 ,src_ins_mvrdmv_ny										,src_ins_mvrdmv_nc
		,src_ins_mvrdmv_nd					 ,src_ins_mvrdmv_oh										,src_ins_mvrdmv_ok
		,src_ins_mvrdmv_or					 ,src_ins_mvrdmv_pa										,src_ins_mvrdmv_ri
		,src_ins_mvrdmv_sc					 ,src_ins_mvrdmv_sd									  ,src_ins_mvrdmv_tn
		,src_ins_mvrdmv_tx					 ,src_ins_mvrdmv_ut										,src_ins_mvrdmv_vt
		,src_ins_mvrdmv_va				 	 ,src_ins_mvrdmv_wa										,src_ins_mvrdmv_wv
		,src_ins_mvrdmv_wi					 ,src_ins_mvrdmv_wy										,src_ins_mvrdmv_other 
	];

	export set_ct_sources            						:= [
		src_ct_experian, src_ct_mvrdhdb
	];
	
	export set_ut_sources            						:= [
		 src_Utilities                 ,src_Util_Work_Phone    
    ,src_ZUtilities                ,src_ZUtil_Work_Phone
	];

	export set_GLB_sources											:= [src_Equifax, src_Experian_Credit_Header] + set_ut_sources;

	// validate
	export SourceIsINS                       	(string9 sr) := sr[1..3] not in set_public_header_sources and sr not in set_ct_sources;
	export SourceIsPublicHeader              	(string9 sr) := sr[1..3] in set_public_header_sources;
	export SourceIsCurrentCarrier            	(string9 sr) := sr[1..3] in set_current_carrier_sources;
	export SourceIsClueAuto      		        	(string9 sr) := sr[1..3] in set_clue_auto_sources;
	export SourceIsClueProperty	             	(string9 sr) := sr[1..3] in set_clue_property_sources;
	export SourceIsCompIdDMV		             	(string9 sr) := sr[1..5] in set_compid_dmv_sources;
	export SourceIsInsDMV		             			(string9 sr) := sr[1..3] in set_insurance_dmv_sources;
	export SourceIsBocaDMV		             		(string9 sr) := SourceIsPublicHeader(sr) and sr[4..5] in mdr.sourceTools.set_Direct_dl;
	export SourceIsDMV												(string9 sr) := SourceIsInsDMV(sr) or SourceIsBocaDMV(sr) or SourceIsCompIdDMV(sr) ;
	export SourceIsBocaProperty            		(string9 sr) := SourceIsPublicHeader(sr) and sr[4..5] in mdr.sourceTools.set_Property;
	export SourceIsBocaVehicle	           		(string9 sr) := SourceIsPublicHeader(sr) and sr[4..5] in mdr.sourceTools.set_Vehicles;
	export SourceIsMvrInq											(string9 sr) := (sr= src_ins_mvrinq);
	export SourceIsUtility										(string9 sr) := sr in set_ut_sources;
	export SourceIsGLB												(string9 sr) := sr in set_GLB_Sources;
	export SourceIsCreditBureau								(string9 sr) := sr in [src_Equifax, src_Experian_Credit_Header];
	export SourceIsMVRCourt										(string9 sr) := sr in set_mvrcrt_sources;
	export SourceIsMVRDMV											(string9 sr) := sr in set_mvrdmv_sources;
		
	// Get
	export GetSource												(string9 sr) := trim(if(sr[1..3] = src_ins_compid_dmv, sr[1..5], sr[1..3]));
	export GetSubSource											(string9 sr) := trim(sr[4..]);
	export GetSourceType										(string9 sr) := if(SourceIsPublicHeader(sr), PublicRecords, InsuranceRecords);
	export GetSubSourceType									(string9 sr) := map(SourceIsCurrentCarrier(sr) => PolicyRecords, 
																															SourceIsClueAuto(sr) => AutoClaimsRecords, 
																															SourceIsClueProperty(sr) => PropertyClaimsRecords, 
																															SourceIsCompIdDMV(sr) => CompIdDMV, 
																															SourceIsInsDMV(sr) => InsuranceDMV,
																															SourceIsMVRCourt(sr) => MVRCourt,
																															SourceIsMVRDMV(sr) => MVRDMV,
																															'');
																															
	
	// compare to Drivers.header_src
	export fDLs(string2 pState) := 
			case(pState			//Alpharetta DMVs
				,'KS' => src_ins_dmv_ks
				,'NC' => src_ins_dmv_nc
				,'NM' => src_ins_dmv_nm
				,'MO' => src_ins_dmv_mo
				,'NH' => src_ins_dmv_nh		
				,'OR' => src_ins_dmv_or
				,'SC' => src_ins_dmv_sc				
				,'WI' => src_ins_dmv_wi
				,'WV' => src_ins_dmv_wv
				// Historic or now Provided by Boca
				,'LA' => src_ins_dmv_la
				,'NE' => src_ins_dmv_ne
				,'NV' => src_ins_dmv_nv
				,'CO' => src_ins_dmv_co
				,'DE' => src_ins_dmv_de
				,'IA' => src_ins_dmv_ia
				,'ID' => src_ins_dmv_id
				,'IL' => src_ins_dmv_il
				,'KY' => src_ins_dmv_ky
				,'MD' => src_ins_dmv_md
				,'MS' => src_ins_dmv_ms
				,'ND' => src_ins_dmv_nd
				,''             
			);
	
	export fNICs(string2 pState) := 
			case(pState			//Alpharetta NIC DMVs
				,'CO' => src_ins_nic_co
				,'ID' => src_ins_nic_id
				,'NM' => src_ins_nic_nm
				,'VA' => src_ins_nic_va
				,''             
			);
	
	// DMV State - Functions
	export isBocaDMVState(string2 st, string2 src = 'AD') := MDR.sourceTools.fDLs(src, st) in mdr.sourceTools.set_Direct_dl;
	export isInsDMVState(string2 st) := fDLs(st) in [set_insurance_dmv_sources, set_compid_dmv_sources];
	export isDMVState(string2 st) := isBocaDMVState(st) or isInsDMVState(st);
	// Get Source using DMV State
	export GetSourceForBocaDMVState(string2 st, string2 src = 'AD') := MDR.sourceTools.fDLs(src, st);
	export GetSourceForInsDMVState(string2 st) := fDLs(st);
	
	// DMV NIC States - Functions
	export isDmvNicState(string2 st) := fNICs(st) in set_insurance_nic_sources;;
	
	// Death Source
	export isDeathSource								(string9 sr) := SourceIsPublicHeader(sr) and (GetSubSource(sr) in MDR.sourceTools.set_Death);
	export isRestrictedDeathSource  		(string9 sr) := SourceIsPublicHeader(sr) and (GetSubSource(sr) = mdr.sourceTools.src_Death_Restricted);

	export set_DL                         := [
		 'ADL' +mdr.sourceTools.src_CT_DL                     ,'ADL' +mdr.sourceTools.src_FL_DL                     ,'ADL' +mdr.sourceTools.src_IA_DL                     ,'ADL' +mdr.sourceTools.src_ID_DL                     
		,'ADL' +mdr.sourceTools.src_KY_DL                     ,'ADL' +mdr.sourceTools.src_MA_DL                     ,'ADL' +mdr.sourceTools.src_ME_DL                     ,'ADL' +mdr.sourceTools.src_MI_DL                     
		,'ADL' +mdr.sourceTools.src_MN_DL                     ,'ADL' +mdr.sourceTools.src_MO_DL                     ,'ADL' +mdr.sourceTools.src_NC_DL                     ,'ADL' +mdr.sourceTools.src_NE_DL   
		/*,src_NM_DL*/                                        ,'ADL' +mdr.sourceTools.src_NV_DL                 		,'ADL' +mdr.sourceTools.src_LA_DL									    ,'ADL' +mdr.sourceTools.src_OH_DL                     
		,'ADL' +mdr.sourceTools.src_OR_DL                     ,'ADL' +mdr.sourceTools.src_TN_DL                     ,'ADL' +mdr.sourceTools.src_TX_DL                     ,'ADL' +mdr.sourceTools.src_UT_DL                     
		,'ADL' +mdr.sourceTools.src_WI_DL                     ,'ADL' +mdr.sourceTools.src_WV_DL                     ,'ADL' +mdr.sourceTools.src_WY_DL                     ,'ADL' +mdr.sourceTools.src_CO_Experian_DL            
		,'ADL' +mdr.sourceTools.src_DE_Experian_DL            ,'ADL' +mdr.sourceTools.src_ID_Experian_DL            ,'ADL' +mdr.sourceTools.src_IL_Experian_DL            ,'ADL' +mdr.sourceTools.src_KY_Experian_DL            
		,'ADL' +mdr.sourceTools.src_LA_Experian_DL            ,'ADL' +mdr.sourceTools.src_MD_Experian_DL            ,'ADL' +mdr.sourceTools.src_MS_Experian_DL            ,'ADL' +mdr.sourceTools.src_ND_Experian_DL            
		,'ADL' +mdr.sourceTools.src_NH_Experian_DL            ,'ADL' +mdr.sourceTools.src_SC_Experian_DL            ,'ADL' +mdr.sourceTools.src_WV_Experian_DL            
	];

  export set_Business_services_DL_verification     := [set_DL,src_ins_dmv_mo , src_ins_dmv_nh , src_ins_dmv_or, src_ins_dmv_sc , src_ins_dmv_wi , src_ins_dmv_wv ,src_ins_dmv_nc
                                                       ,src_ins_mvrinq , src_ins_clue_auto,src_ins_clue_property,  src_ins_current_carrier ] ;  
																											 
	export SourceIsFCRAHeader									(string9 sr) := ((SourceIsPublicHeader(sr) and sr[4..5] in mdr.sourceTools.set_scoring_FCRA) and sr not in [src_Equifax,src_Experian_Credit_Header] and not isRestrictedDeathSource(sr)) /*or SourceIsDMV(sr) or SourceIsCurrentCarrier(sr) or SourceIsClueAuto(sr) or SourceIsClueProperty(sr)*/;
	
	//MVR Court Subsources
	export set_MVRCourt_Allowed := ['ALAM','BCJP','BDFD','BELM','BRZO','CIBO','COLC','COML','COPP',
																	'DALL','EPDC','FMND','GACL','GLDC','HALE','HARR','HCJP','HIGH',
																	'INSW','JEFF','LAKE','LAMR','LUBC','MDJU','MDNA','MIDC','MIDD',
																	'MTJP','MTWS','MWCM','NDSW','NJSW','NLVM','NPJC','ODCR','OSCN',
																	'PACP','PAMD','PHIL','PIMA','PLAQ','RISW','RKWL','SUPE','TAYL',
																	'TCDC','VCJP','WINN'];
																	
	export makeCourtSrc(string2 pState) := 
			case(pState			//Currently Provided
				,'AZ' => src_ins_mvrcrt_az
				,'CT' => src_ins_mvrcrt_ct
				,'FL' => src_ins_mvrcrt_fl
				,'IL' => src_ins_mvrcrt_il
				,'IN' => src_ins_mvrcrt_in		
				,'LA' => src_ins_mvrcrt_la
				,'MD' => src_ins_mvrcrt_md				
				,'ND' => src_ins_mvrcrt_nd
				,'NJ' => src_ins_mvrcrt_nj
				,'NV' => src_ins_mvrcrt_nv
				,'OK' => src_ins_mvrcrt_ok
				,'PA' => src_ins_mvrcrt_pa
				,'RI' => src_ins_mvrcrt_ri
				,'TX' => src_ins_mvrcrt_tx
				,'WI' => src_ins_mvrcrt_wi
				// Available, but not enough PII to be included as of 7/26
				,'VA' => src_ins_mvrcrt_va
				,''             
			);
			
		export makeDMVSrc(string2 pState) := 
			case(pState			//Currently Provided
				,'AL' => src_ins_mvrdmv_al
				,'AK' => src_ins_mvrdmv_ak
				,'AR' => src_ins_mvrdmv_ar
				,'AZ' => src_ins_mvrdmv_az
				,'CA' => src_ins_mvrdmv_ca
				,'CO' => src_ins_mvrdmv_co
				,'CT' => src_ins_mvrdmv_ct
				,'DE' => src_ins_mvrdmv_de
				,'FL' => src_ins_mvrdmv_fl
				,'GA' => src_ins_mvrdmv_ga
				,'HI' => src_ins_mvrdmv_hi
				,'ID' => src_ins_mvrdmv_id
				,'IL' => src_ins_mvrdmv_il
				,'IN' => src_ins_mvrdmv_in		
				,'IA' => src_ins_mvrdmv_ia		
				,'KS' => src_ins_mvrdmv_ks		
				,'KY' => src_ins_mvrdmv_ky		
				,'LA' => src_ins_mvrdmv_la
				,'ME' => src_ins_mvrdmv_me				
				,'MD' => src_ins_mvrdmv_md				
				,'MA' => src_ins_mvrdmv_ma				
				,'MI' => src_ins_mvrdmv_mi				
				,'MN' => src_ins_mvrdmv_mn				
				,'MS' => src_ins_mvrdmv_ms				
				,'MO' => src_ins_mvrdmv_mo				
				,'MT' => src_ins_mvrdmv_mt				
				,'NE' => src_ins_mvrdmv_ne				
				,'NV' => src_ins_mvrdmv_nv
				,'NH' => src_ins_mvrdmv_nh
				,'NJ' => src_ins_mvrdmv_nj
				,'NM' => src_ins_mvrdmv_nm
				,'NY' => src_ins_mvrdmv_ny
				,'NC' => src_ins_mvrdmv_nc
				,'ND' => src_ins_mvrdmv_nd
				,'OH' => src_ins_mvrdmv_oh
				,'OK' => src_ins_mvrdmv_ok
				,'OR' => src_ins_mvrdmv_or
				,'PA' => src_ins_mvrdmv_pa
				,'RI' => src_ins_mvrdmv_ri
				,'SC' => src_ins_mvrdmv_sc
				,'SD' => src_ins_mvrdmv_sd
				,'TN' => src_ins_mvrdmv_tn
				,'TX' => src_ins_mvrdmv_tx
				,'UT' => src_ins_mvrdmv_ut
				,'VT' => src_ins_mvrdmv_vt
				,'VA' => src_ins_mvrdmv_va
				,'WA' => src_ins_mvrdmv_wa
				,'WV' => src_ins_mvrdmv_wv
				,'WI' => src_ins_mvrdmv_wi
				,'WY' => src_ins_mvrdmv_wy
				// Miscellaneous DMV
				,src_ins_mvrdmv_other             
			);

end;