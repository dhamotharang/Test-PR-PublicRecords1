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
	
	// GLB Sources
	export src_Equifax										:= 'ADL' + mdr.sourceTools.src_Equifax;
	export src_Experian_Credit_Header			:= 'ADL' + mdr.sourceTools.src_Experian_Credit_Header;
	export src_Utilities									:= 'ADL' + mdr.sourceTools.src_Utilities;
	export src_Util_Work_Phone						:= 'ADL' + mdr.sourceTools.src_Util_Work_Phone;
	export src_ZUtilities									:= 'ADL' + mdr.sourceTools.src_ZUtilities;
	export src_ZUtil_Work_Phone						:= 'ADL' + mdr.sourceTools.src_ZUtil_Work_Phone;
	
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
		,src_ins_compid_dmv          ,src_ins_inq_mvr
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

	export set_ct_sources            						:= [
		src_ct_experian, src_ct_mvrdhdb
	];
	
	export set_ut_sources            						:= [
		 src_Utilities                 ,src_Util_Work_Phone    
    ,src_ZUtilities                ,src_ZUtil_Work_Phone
	];

	export set_GLB_sources											:= [src_Equifax, src_Experian_Credit_Header] + set_ut_sources;

	// validate
	export SourceIsINS                       	(string9 sr) := sr[1..3] not in set_public_header_sources;
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
	// Get
	export GetSource												(string9 sr) := trim(if(sr[1..3] = src_ins_compid_dmv, sr[1..5], sr[1..3]));
	export GetSubSource											(string9 sr) := trim(sr[4..]);
	export GetSourceType										(string9 sr) := if(SourceIsPublicHeader(sr), PublicRecords, InsuranceRecords);
	export GetSubSourceType									(string9 sr) := map(SourceIsCurrentCarrier(sr) => PolicyRecords, 
																															SourceIsClueAuto(sr) => AutoClaimsRecords, 
																															SourceIsClueProperty(sr) => PropertyClaimsRecords, 
																															SourceIsCompIdDMV(sr) => CompIdDMV, 
																															SourceIsInsDMV(sr) => InsuranceDMV, 	'');
																															
	
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

end;