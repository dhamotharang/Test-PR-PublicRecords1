EXPORT Out_File_SANCTN_Mari_Stats_Population (pIncident
																						 ,pIncidentBip
																						 ,pParty
																						 ,pPartyBip
																						 ,pIncidentText
																						 ,pPartyText
																						 ,pIncidentCode
																						 ,pPartyAKA
																						 ,pVersion
																						 ,zOut) := MACRO

import STRATA,lib_stringlib;

	#uniquename(rPopulationStats_SANCTN_Mari_Incident);
	#uniquename(rPopulationStats_SANCTN_Mari_Incident_Bip);	
	#uniquename(rPopulationStats_SANCTN_Mari_Party);
	#uniquename(rPopulationStats_SANCTN_Mari_Party_Bip);	
	#uniquename(rPopulationStats_SANCTN_Mari_IncidentText);
	#uniquename(rPopulationStats_SANCTN_Mari_PartyText);
	#uniquename(rPopulationStats_SANCTN_Mari_IncidentCode);
	#uniquename(rPopulationStats_SANCTN_Mari_Party_AKA_DBA);
	#uniquename(dPopulationStats_SANCTN_Mari_Incident);
	#uniquename(dPopulationStats_SANCTN_Mari_Incident_Bip);	
	#uniquename(dPopulationStats_SANCTN_Mari_Party);
	#uniquename(dPopulationStats_SANCTN_Mari_Party_Bip);	
	#uniquename(dPopulationStats_SANCTN_Mari_IncidentText);
	#uniquename(dPopulationStats_SANCTN_Mari_PartyText);
	#uniquename(dPopulationStats_SANCTN_Mari_IncidentCode);
	#uniquename(dPopulationStats_SANCTN_Mari_Party_AKA_DBA);
	#uniquename(zIncident);
	#uniquename(zIncidentBip);	
	#uniquename(zParty);
	#uniquename(zPartyBip);
	#uniquename(zIncidentText);
	#uniquename(zPartyText);
	#uniquename(zIncidentCode);
	#uniquename(zPartyAKA);

%rPopulationStats_SANCTN_Mari_Incident% := record
    pIncident.SRCE_CD;
    CountGroup                                      := COUNT(GROUP);
    BATCH_CountNonBlank                      				:= SUM(GROUP,IF(pIncident.BATCH<>'',1,0));
		BATCH_DATE_CountNonBlank                      	:= SUM(GROUP,IF(pIncident.BATCH_DATE<>'',1,0));
		DBCODE_CountNonBlank                      			:= SUM(GROUP,IF(pIncident.DBCODE<>'',1,0));
    INCIDENT_NUM_CountNonBlank                   		:= SUM(GROUP,IF(pIncident.INCIDENT_NUM<>'',1,0));
    INCIDENT_DATE_CountNonBlank                   	:= SUM(GROUP,IF(pIncident.INCIDENT_DATE<>'',1,0));
    INT_KEY_CountNonBlank                   				:= SUM(GROUP,IF(pIncident.INT_KEY<>0,1,0));
		//SRCE_CD;
    BILLING_CODE_CountNonBlank                   		:= SUM(GROUP,IF(pIncident.BILLING_CODE<>'',1,0));
    CASE_NUM_CountNonBlank                   				:= SUM(GROUP,IF(pIncident.CASE_NUM<>'',1,0));
    JURISDICTION_CountNonBlank                   		:= SUM(GROUP,IF(pIncident.JURISDICTION<>'',1,0));
    AGENCY_CountNonBlank                            := SUM(GROUP,IF(pIncident.AGENCY<>'',1,0));
    SOURCE_DOC_CountNonBlank                        := SUM(GROUP,IF(pIncident.SOURCE_DOC<>'',1,0));
    SOURCE_REF_CountNonBlank                        := SUM(GROUP,IF(pIncident.SOURCE_REF<>'',1,0));
    ADDITIONAL_INFO_CountNonBlank                   := SUM(GROUP,IF(pIncident.ADDITIONAL_INFO<>'',1,0));
    MODIFIED_DATE_CountNonBlank                     := SUM(GROUP,IF(pIncident.MODIFIED_DATE<>'',1,0));
		ENTRY_DATE_CountNonBlank                 				:= SUM(GROUP,IF(pIncident.ENTRY_DATE<>'',1,0));
		MEMBER_NAME_CountNonBlank                 			:= SUM(GROUP,IF(pIncident.MEMBER_NAME<>'',1,0));
    SUBMITTER_NAME_CountNonBlank                    := SUM(GROUP,IF(pIncident.SUBMITTER_NAME<>'',1,0));
    SUBMITTER_NICKNAME_CountNonBlank                := SUM(GROUP,IF(pIncident.SUBMITTER_NICKNAME<>'',1,0));
    SUBMITTER_PHONE_CountNonBlank                   := SUM(GROUP,IF(pIncident.SUBMITTER_PHONE<>'',1,0));
    SUBMITTER_FAX_CountNonBlank                   	:= SUM(GROUP,IF(pIncident.SUBMITTER_FAX<>'',1,0));
    SUBMITTER_EMAIL_CountNonBlank                   := SUM(GROUP,IF(pIncident.SUBMITTER_EMAIL<>'',1,0));
		PROP_ADDR_CountNonBlank                   			:= SUM(GROUP,IF(pIncident.PROP_ADDR<>'',1,0));
		PROP_CITY_CountNonBlank                   			:= SUM(GROUP,IF(pIncident.PROP_CITY<>'',1,0));		
		PROP_STATE_CountNonBlank                   			:= SUM(GROUP,IF(pIncident.PROP_STATE<>'',1,0));
		PROP_ZIP_CountNonBlank                   				:= SUM(GROUP,IF(pIncident.PROP_ZIP<>'',1,0));
		AID_CountNonBlank                   						:= SUM(GROUP,IF(pIncident.AID<>0,1,0));
		DID_CountNonBlank                   						:= SUM(GROUP,IF(pIncident.DID<>0,1,0));
		DID_SCORE_CountNonBlank                   			:= SUM(GROUP,IF(pIncident.DID_SCORE<>0,1,0));
		BDID_CountNonBlank                   						:= SUM(GROUP,IF(pIncident.BDID<>0,1,0));
		BDID_SCORE_CountNonBlank                   			:= SUM(GROUP,IF(pIncident.BDID_SCORE<>0,1,0));
END;

%rPopulationStats_SANCTN_Mari_Incident_Bip% := record
    pIncidentBip.SRCE_CD;
    CountGroup                                      := COUNT(GROUP);
    DotID_CountNonZero		                 				 	:= sum(group,if(pIncidentBip.DotID<>0,1,0));
    DotScore_CountNonZero                 			  	:= sum(group,if(pIncidentBip.DotScore<>0,1,0));
    DotWeight_CountNonZero                         	:= sum(group,if(pIncidentBip.DotWeight<>0,1,0));
    EmpID_CountNonZero	                           	:= sum(group,if(pIncidentBip.EmpID<>0,1,0));
    EmpScore_CountNonZero                          	:= sum(group,if(pIncidentBip.EmpScore<>0,1,0));
    EmpWeight_CountNonZero                         	:= sum(group,if(pIncidentBip.EmpWeight<>0,1,0));
    POWID_CountNonZero		                         	:= sum(group,if(pIncidentBip.POWID<>0,1,0));
    POWScore_CountNonZero                          	:= sum(group,if(pIncidentBip.POWScore<>0,1,0));
    POWWeight_CountNonZero                         	:= sum(group,if(pIncidentBip.POWWeight<>0,1,0));
    ProxID_CountNonZero	                           	:= sum(group,if(pIncidentBip.ProxID<>0,1,0));
    ProxScore_CountNonZero                         	:= sum(group,if(pIncidentBip.ProxScore<>0,1,0));
    ProxWeight_CountNonZero                        	:= sum(group,if(pIncidentBip.ProxWeight<>0,1,0));
    SELEID_CountNonZero	                           	:= sum(group,if(pIncidentBip.SELEID<>0,1,0));
    SELEScore_CountNonZero                         	:= sum(group,if(pIncidentBip.SELEScore<>0,1,0));
    SELEWeight_CountNonZero                        	:= sum(group,if(pIncidentBip.SELEWeight<>0,1,0));	
    OrgID_CountNonZero		                         	:= sum(group,if(pIncidentBip.OrgID<>0,1,0));
    OrgScore_CountNonZero                          	:= sum(group,if(pIncidentBip.OrgScore<>0,1,0));
    OrgWeight_CountNonZero                         	:= sum(group,if(pIncidentBip.OrgWeight<>0,1,0));
    UltID_CountNonZero		                         	:= sum(group,if(pIncidentBip.UltID<>0,1,0));
    UltScore_CountNonZero                          	:= sum(group,if(pIncidentBip.UltScore<>0,1,0));
    UltWeight_CountNonZero                         	:= sum(group,if(pIncidentBip.UltWeight<>0,1,0));
    Source_Rec_ID_CountNonZero                      := sum(group,if(pIncidentBip.Source_Rec_ID<>0,1,0));
    BATCH_CountNonBlank                      				:= SUM(GROUP,IF(pIncidentBip.BATCH<>'',1,0));
		BATCH_DATE_CountNonBlank                      	:= SUM(GROUP,IF(pIncidentBip.BATCH_DATE<>'',1,0));
		DBCODE_CountNonBlank                      			:= SUM(GROUP,IF(pIncidentBip.DBCODE<>'',1,0));
    INCIDENT_NUM_CountNonBlank                   		:= SUM(GROUP,IF(pIncidentBip.INCIDENT_NUM<>'',1,0));
    INCIDENT_DATE_CountNonBlank                   	:= SUM(GROUP,IF(pIncidentBip.INCIDENT_DATE<>'',1,0));
    INT_KEY_CountNonBlank                   				:= SUM(GROUP,IF(pIncidentBip.INT_KEY<>0,1,0));
		//SRCE_CD;
    BILLING_CODE_CountNonBlank                   		:= SUM(GROUP,IF(pIncidentBip.BILLING_CODE<>'',1,0));
    CASE_NUM_CountNonBlank                   				:= SUM(GROUP,IF(pIncidentBip.CASE_NUM<>'',1,0));
    JURISDICTION_CountNonBlank                   		:= SUM(GROUP,IF(pIncidentBip.JURISDICTION<>'',1,0));
    AGENCY_CountNonBlank                            := SUM(GROUP,IF(pIncidentBip.AGENCY<>'',1,0));
    SOURCE_DOC_CountNonBlank                        := SUM(GROUP,IF(pIncidentBip.SOURCE_DOC<>'',1,0));
    SOURCE_REF_CountNonBlank                        := SUM(GROUP,IF(pIncidentBip.SOURCE_REF<>'',1,0));
    ADDITIONAL_INFO_CountNonBlank                   := SUM(GROUP,IF(pIncidentBip.ADDITIONAL_INFO<>'',1,0));
    MODIFIED_DATE_CountNonBlank                     := SUM(GROUP,IF(pIncidentBip.MODIFIED_DATE<>'',1,0));
		ENTRY_DATE_CountNonBlank                 				:= SUM(GROUP,IF(pIncidentBip.ENTRY_DATE<>'',1,0));
		MEMBER_NAME_CountNonBlank                 			:= SUM(GROUP,IF(pIncidentBip.MEMBER_NAME<>'',1,0));
    SUBMITTER_NAME_CountNonBlank                    := SUM(GROUP,IF(pIncidentBip.SUBMITTER_NAME<>'',1,0));
    SUBMITTER_NICKNAME_CountNonBlank                := SUM(GROUP,IF(pIncidentBip.SUBMITTER_NICKNAME<>'',1,0));
    SUBMITTER_PHONE_CountNonBlank                   := SUM(GROUP,IF(pIncidentBip.SUBMITTER_PHONE<>'',1,0));
    SUBMITTER_FAX_CountNonBlank                   	:= SUM(GROUP,IF(pIncidentBip.SUBMITTER_FAX<>'',1,0));
    SUBMITTER_EMAIL_CountNonBlank                   := SUM(GROUP,IF(pIncidentBip.SUBMITTER_EMAIL<>'',1,0));
		PROP_ADDR_CountNonBlank                   			:= SUM(GROUP,IF(pIncidentBip.PROP_ADDR<>'',1,0));
		PROP_CITY_CountNonBlank                   			:= SUM(GROUP,IF(pIncidentBip.PROP_CITY<>'',1,0));		
		PROP_STATE_CountNonBlank                   			:= SUM(GROUP,IF(pIncidentBip.PROP_STATE<>'',1,0));
		PROP_ZIP_CountNonBlank                   				:= SUM(GROUP,IF(pIncidentBip.PROP_ZIP<>'',1,0));
		AID_CountNonBlank                   						:= SUM(GROUP,IF(pIncidentBip.AID<>0,1,0));
		DID_CountNonBlank                   						:= SUM(GROUP,IF(pIncidentBip.DID<>0,1,0));
		DID_SCORE_CountNonBlank                   			:= SUM(GROUP,IF(pIncidentBip.DID_SCORE<>0,1,0));
		BDID_CountNonBlank                   						:= SUM(GROUP,IF(pIncidentBip.BDID<>0,1,0));
		BDID_SCORE_CountNonBlank                   			:= SUM(GROUP,IF(pIncidentBip.BDID_SCORE<>0,1,0));
END;

%rPopulationStats_SANCTN_Mari_Party% := record
		//string20 state                             	:= lib_stringlib.StringLib.StringToUpperCase(trim(regexreplace('\\.|(, EC2M 4YA)|[0-9]',pParty.STATE,''),left,right));
		pParty.STATE;
    CountGroup                                  		:= COUNT(GROUP);
		BATCH_CountNonBlank                  						:= SUM(GROUP,IF(pParty.BATCH<>'',1,0));
		DBCODE_CountNonBlank                  					:= SUM(GROUP,IF(pParty.DBCODE<>'',1,0));
    INCIDENT_NUM_CountNonBlank               				:= SUM(GROUP,IF(pParty.INCIDENT_NUM<>'',1,0));
    PARTY_NUM_CountNonBlank                  				:= SUM(GROUP,IF(pParty.PARTY_NUM<>'',1,0));
		SANCTIONS_CountNonBlank                  				:= SUM(GROUP,IF(pParty.SANCTIONS<>'',1,0));
		ADDITIONAL_INFO_CountNonBlank               		:= SUM(GROUP,IF(pParty.ADDITIONAL_INFO<>'',1,0));
    PARTY_FIRM_CountNonBlank                    		:= SUM(GROUP,IF(pParty.PARTY_FIRM<>'',1,0));
		TIN_CountNonBlank                      					:= SUM(GROUP,IF(pParty.TIN<>'',1,0));
 		NAME_FIRST_CountNonBlank                    		:= SUM(GROUP,IF(pParty.NAME_FIRST<>'',1,0));
		NAME_LAST_CountNonBlank                    			:= SUM(GROUP,IF(pParty.NAME_LAST<>'',1,0));
	  NAME_MIDDLE_CountNonBlank                   		:= SUM(GROUP,IF(pParty.NAME_MIDDLE<>'',1,0));
		SUFFIX_CountNonBlank                   					:= SUM(GROUP,IF(pParty.SUFFIX<>'',1,0));
		NICKNAME_CountNonBlank                   				:= SUM(GROUP,IF(pParty.NICKNAME<>'',1,0));
    PARTY_POSITION_CountNonBlank                		:= SUM(GROUP,IF(pParty.PARTY_POSITION<>'',1,0));
    PARTY_EMPLOYER_CountNonBlank                		:= SUM(GROUP,IF(pParty.PARTY_EMPLOYER<>'',1,0));
		SSN_CountNonBlank                      					:= SUM(GROUP,IF(pParty.SSN<>'',1,0));
		DOB_CountNonBlank                      					:= SUM(GROUP,IF(pParty.DOB<>'',1,0));
    ADDRESS_CountNonBlank                     			:= SUM(GROUP,IF(pParty.ADDRESS<>'',1,0));
    CITY_CountNonBlank                        			:= SUM(GROUP,IF(pParty.CITY<>'',1,0));
    //STATE;
    ZIP_CountNonBlank                         			:= SUM(GROUP,IF(pParty.ZIP<>'',1,0));
 		PARTY_TYPE_CountNonBlank                   			:= SUM(GROUP,IF(pParty.PARTY_TYPE<>'',1,0));
		PARTY_KEY_CountNonBlank                   			:= SUM(GROUP,IF(pParty.PARTY_KEY<>0,1,0));
		INT_KEY_CountNonBlank                   				:= SUM(GROUP,IF(pParty.INT_KEY<>0,1,0));
		AID_CountNonBlank                   						:= SUM(GROUP,IF(pParty.AID<>0,1,0));
		DID_CountNonBlank                   						:= SUM(GROUP,IF(pParty.DID<>0,1,0));
		DID_SCORE_CountNonBlank                   			:= SUM(GROUP,IF(pParty.DID_SCORE<>0,1,0));
		BDID_CountNonBlank                   						:= SUM(GROUP,IF(pParty.BDID<>0,1,0));
		BDID_SCORE_CountNonBlank                   			:= SUM(GROUP,IF(pParty.BDID_SCORE<>0,1,0));
END;

%rPopulationStats_SANCTN_Mari_Party_BIP% := RECORD
		pPartyBip.STATE;
    CountGroup                                  		:= COUNT(GROUP);
    DotID_CountNonZero		                 				 	:= sum(group,if(pPartyBip.DotID<>0,1,0));
    DotScore_CountNonZero                 			  	:= sum(group,if(pPartyBip.DotScore<>0,1,0));
    DotWeight_CountNonZero                         	:= sum(group,if(pPartyBip.DotWeight<>0,1,0));
    EmpID_CountNonZero	                           	:= sum(group,if(pPartyBip.EmpID<>0,1,0));
    EmpScore_CountNonZero                          	:= sum(group,if(pPartyBip.EmpScore<>0,1,0));
    EmpWeight_CountNonZero                         	:= sum(group,if(pPartyBip.EmpWeight<>0,1,0));
    POWID_CountNonZero		                         	:= sum(group,if(pPartyBip.POWID<>0,1,0));
    POWScore_CountNonZero                          	:= sum(group,if(pPartyBip.POWScore<>0,1,0));
    POWWeight_CountNonZero                         	:= sum(group,if(pPartyBip.POWWeight<>0,1,0));
    ProxID_CountNonZero	                           	:= sum(group,if(pPartyBip.ProxID<>0,1,0));
    ProxScore_CountNonZero                         	:= sum(group,if(pPartyBip.ProxScore<>0,1,0));
    ProxWeight_CountNonZero                        	:= sum(group,if(pPartyBip.ProxWeight<>0,1,0));
    SELEID_CountNonZero	                           	:= sum(group,if(pPartyBip.SELEID<>0,1,0));
    SELEScore_CountNonZero                         	:= sum(group,if(pPartyBip.SELEScore<>0,1,0));
    SELEWeight_CountNonZero                        	:= sum(group,if(pPartyBip.SELEWeight<>0,1,0));	
    OrgID_CountNonZero		                         	:= sum(group,if(pPartyBip.OrgID<>0,1,0));
    OrgScore_CountNonZero                          	:= sum(group,if(pPartyBip.OrgScore<>0,1,0));
    OrgWeight_CountNonZero                         	:= sum(group,if(pPartyBip.OrgWeight<>0,1,0));
    UltID_CountNonZero		                         	:= sum(group,if(pPartyBip.UltID<>0,1,0));
    UltScore_CountNonZero                          	:= sum(group,if(pPartyBip.UltScore<>0,1,0));
    UltWeight_CountNonZero                         	:= sum(group,if(pPartyBip.UltWeight<>0,1,0));
    Source_Rec_ID_CountNonZero                      := sum(group,if(pPartyBip.Source_Rec_ID<>0,1,0));		
		BATCH_CountNonBlank                  						:= SUM(GROUP,IF(pPartyBip.BATCH<>'',1,0));
		DBCODE_CountNonBlank                  					:= SUM(GROUP,IF(pPartyBip.DBCODE<>'',1,0));
    INCIDENT_NUM_CountNonBlank               				:= SUM(GROUP,IF(pPartyBip.INCIDENT_NUM<>'',1,0));
    PARTY_NUM_CountNonBlank                  				:= SUM(GROUP,IF(pPartyBip.PARTY_NUM<>'',1,0));
		SANCTIONS_CountNonBlank                  				:= SUM(GROUP,IF(pPartyBip.SANCTIONS<>'',1,0));
		ADDITIONAL_INFO_CountNonBlank               		:= SUM(GROUP,IF(pPartyBip.ADDITIONAL_INFO<>'',1,0));
    PARTY_FIRM_CountNonBlank                    		:= SUM(GROUP,IF(pPartyBip.PARTY_FIRM<>'',1,0));
		TIN_CountNonBlank                      					:= SUM(GROUP,IF(pPartyBip.TIN<>'',1,0));
 		NAME_FIRST_CountNonBlank                    		:= SUM(GROUP,IF(pPartyBip.NAME_FIRST<>'',1,0));
		NAME_LAST_CountNonBlank                    			:= SUM(GROUP,IF(pPartyBip.NAME_LAST<>'',1,0));
	  NAME_MIDDLE_CountNonBlank                   		:= SUM(GROUP,IF(pPartyBip.NAME_MIDDLE<>'',1,0));
		SUFFIX_CountNonBlank                   					:= SUM(GROUP,IF(pPartyBip.SUFFIX<>'',1,0));
		NICKNAME_CountNonBlank                   				:= SUM(GROUP,IF(pPartyBip.NICKNAME<>'',1,0));
    PARTY_POSITION_CountNonBlank                		:= SUM(GROUP,IF(pPartyBip.PARTY_POSITION<>'',1,0));
    PARTY_EMPLOYER_CountNonBlank                		:= SUM(GROUP,IF(pPartyBip.PARTY_EMPLOYER<>'',1,0));
		SSN_CountNonBlank                      					:= SUM(GROUP,IF(pPartyBip.SSN<>'',1,0));
		DOB_CountNonBlank                      					:= SUM(GROUP,IF(pPartyBip.DOB<>'',1,0));
    ADDRESS_CountNonBlank                     			:= SUM(GROUP,IF(pPartyBip.ADDRESS<>'',1,0));
    CITY_CountNonBlank                        			:= SUM(GROUP,IF(pPartyBip.CITY<>'',1,0));
    ZIP_CountNonBlank                         			:= SUM(GROUP,IF(pPartyBip.ZIP<>'',1,0));
 		PARTY_TYPE_CountNonBlank                   			:= SUM(GROUP,IF(pPartyBip.PARTY_TYPE<>'',1,0));
		PARTY_KEY_CountNonBlank                   			:= SUM(GROUP,IF(pPartyBip.PARTY_KEY<>0,1,0));
		INT_KEY_CountNonBlank                   				:= SUM(GROUP,IF(pPartyBip.INT_KEY<>0,1,0));
		AID_CountNonBlank                   						:= SUM(GROUP,IF(pPartyBip.AID<>0,1,0));
		DID_CountNonBlank                   						:= SUM(GROUP,IF(pPartyBip.DID<>0,1,0));
		DID_SCORE_CountNonBlank                   			:= SUM(GROUP,IF(pPartyBip.DID_SCORE<>0,1,0));
		BDID_CountNonBlank                   						:= SUM(GROUP,IF(pPartyBip.BDID<>0,1,0));
		BDID_SCORE_CountNonBlank                   			:= SUM(GROUP,IF(pPartyBip.BDID_SCORE<>0,1,0));
		title_CountNonBlank                   					:= sum(group,if(pPartyBip.title<>'',1,0));
		fname_CountNonBlank                   					:= sum(group,if(pPartyBip.fname<>'',1,0));
		mname_CountNonBlank                   					:= sum(group,if(pPartyBip.mname<>'',1,0));
		lname_CountNonBlank                   					:= sum(group,if(pPartyBip.lname<>'',1,0));
		name_suffix_CountNonBlank                   		:= sum(group,if(pPartyBip.name_suffix<>'',1,0));
		name_score_CountNonBlank                   			:= sum(group,if(pPartyBip.name_score<>'',1,0));
		ename_CountNonBlank                   					:= sum(group,if(pPartyBip.ename<>'',1,0));
		cname_CountNonBlank                   					:= sum(group,if(pPartyBip.cname<>'',1,0));		
    prim_range_CountNonBlank                        := sum(group,if(pPartyBip.prim_range<>'',1,0));
    predir_CountNonBlank                            := sum(group,if(pPartyBip.predir<>'',1,0));
    prim_name_CountNonBlank                         := sum(group,if(pPartyBip.prim_name<>'',1,0));
    addr_suffix_CountNonBlank                       := sum(group,if(pPartyBip.addr_suffix<>'',1,0));
    postdir_CountNonBlank                           := sum(group,if(pPartyBip.postdir<>'',1,0));
    unit_desig_CountNonBlank                        := sum(group,if(pPartyBip.unit_desig<>'',1,0));
    sec_range_CountNonBlank                         := sum(group,if(pPartyBip.sec_range<>'',1,0));
    p_city_name_CountNonBlank                       := sum(group,if(pPartyBip.p_city_name<>'',1,0));
    v_city_name_CountNonBlank                       := sum(group,if(pPartyBip.v_city_name<>'',1,0));
    st_CountNonBlank                                := sum(group,if(pPartyBip.st<>'',1,0));
    zip5_CountNonBlank                              := sum(group,if(pPartyBip.zip5<>'',1,0));
    zip4_CountNonBlank                              := sum(group,if(pPartyBip.zip4<>'',1,0));
    fips_state_CountNonBlank                        := sum(group,if(pPartyBip.fips_state<>'',1,0));
    fips_county_CountNonBlank                       := sum(group,if(pPartyBip.fips_county<>'',1,0));
    addr_rec_type_CountNonBlank                     := sum(group,if(pPartyBip.addr_rec_type<>'',1,0));
    geo_lat_CountNonBlank                           := sum(group,if(pPartyBip.geo_lat<>'',1,0));
    geo_long_CountNonBlank                          := sum(group,if(pPartyBip.geo_long<>'',1,0));
    cbsa_CountNonBlank                              := sum(group,if(pPartyBip.cbsa<>'',1,0));
    geo_blk_CountNonBlank                           := sum(group,if(pPartyBip.geo_blk<>'',1,0));
    geo_match_CountNonBlank                         := sum(group,if(pPartyBip.geo_match<>'',1,0));
    cart_CountNonBlank                              := sum(group,if(pPartyBip.cart<>'',1,0));
    cr_sort_sz_CountNonBlank                        := sum(group,if(pPartyBip.cr_sort_sz<>'',1,0));
    lot_CountNonBlank                               := sum(group,if(pPartyBip.lot<>'',1,0));
    lot_order_CountNonBlank                         := sum(group,if(pPartyBip.lot_order<>'',1,0));
    dpbc_CountNonBlank                              := sum(group,if(pPartyBip.dpbc<>'',1,0));
    chk_digit_CountNonBlank                         := sum(group,if(pPartyBip.chk_digit<>'',1,0));
    err_stat_CountNonBlank                          := sum(group,if(pPartyBip.err_stat<>'',1,0));	
END;

%rPopulationStats_SANCTN_Mari_IncidentText% := RECORD
		pIncidentText.DBCODE;
    CountGroup                                  		:= COUNT(GROUP);
		BATCH_CountNonBlank                  						:= SUM(GROUP,IF(pIncidentText.BATCH<>'',1,0));
		//DBCODE;
		INCIDENT_NUM_CountNonBlank                  		:= SUM(GROUP,IF(pIncidentText.INCIDENT_NUM<>'',1,0));
		SEQ_CountNonBlank                  							:= SUM(GROUP,IF(pIncidentText.SEQ<>'',1,0));
		FIELD_NAME_CountNonBlank                  			:= SUM(GROUP,IF(pIncidentText.FIELD_NAME<>'',1,0));
		FIELD_TXT_CountNonBlank                  				:= SUM(GROUP,IF(pIncidentText.FIELD_TXT<>'',1,0));
END;

%rPopulationStats_SANCTN_Mari_PartyText% := RECORD
		pPartyText.DBCODE;
    CountGroup                                  		:= COUNT(GROUP);
		BATCH_CountNonBlank                  						:= SUM(GROUP,IF(pPartyText.BATCH<>'',1,0));
		//DBCODE;
		INCIDENT_NUM_CountNonBlank                  		:= SUM(GROUP,IF(pPartyText.INCIDENT_NUM<>'',1,0));
		PARTY_NUM_CountNonBlank                  				:= SUM(GROUP,IF(pPartyText.PARTY_NUM<>'',1,0));
		SEQ_CountNonBlank                  							:= SUM(GROUP,IF(pPartyText.SEQ<>'',1,0));
		FIELD_NAME_CountNonBlank                  			:= SUM(GROUP,IF(pPartyText.FIELD_NAME<>'',1,0));
		FIELD_TXT_CountNonBlank                  				:= SUM(GROUP,IF(pPartyText.FIELD_TXT<>'',1,0));
END;

%rPopulationStats_SANCTN_Mari_IncidentCode% := RECORD
		pIncidentCode.CODE_STATE;
    CountGroup                                  		:= COUNT(GROUP);
		BATCH_CountNonBlank                  						:= SUM(GROUP,IF(pIncidentCode.BATCH<>'',1,0));
		DBCODE_CountNonBlank                  					:= SUM(GROUP,IF(pIncidentCode.DBCODE<>'',1,0));
		PRIMARY_KEY_CountNonBlank                  			:= SUM(GROUP,IF(pIncidentCode.PRIMARY_KEY<>0,1,0));
		FOREIGN_KEY_CountNonBlank                  			:= SUM(GROUP,IF(pIncidentCode.FOREIGN_KEY<>0,1,0));
		INCIDENT_NUM_CountNonBlank                  		:= SUM(GROUP,IF(pIncidentCode.INCIDENT_NUM<>'',1,0));
		NUMBER_CountNonBlank                  					:= SUM(GROUP,IF(pIncidentCode.NUMBER<>'',1,0));
		FIELD_NAME_CountNonBlank                  			:= SUM(GROUP,IF(pIncidentCode.FIELD_NAME<>'',1,0));
		CODE_TYPE_CountNonBlank                  				:= SUM(GROUP,IF(pIncidentCode.CODE_TYPE<>'',1,0));
		CODE_VALUE_CountNonBlank                  			:= SUM(GROUP,IF(pIncidentCode.CODE_VALUE<>'',1,0));
		//CODE_STATE;
		OTHER_DESC_CountNonBlank                  			:= SUM(GROUP,IF(pIncidentCode.OTHER_DESC<>'',1,0));
		STD_TYPE_DESC_CountNonBlank                 		:= SUM(GROUP,IF(pIncidentCode.STD_TYPE_DESC<>'',1,0));
		CLN_LICENSE_NUMBER_CountNonBlank            		:= SUM(GROUP,IF(pIncidentCode.CLN_LICENSE_NUMBER<>'',1,0));
END;

%rPopulationStats_SANCTN_Mari_Party_AKA_DBA% := RECORD
		pPartyAKA.NAME_TYPE;
    CountGroup                                		:= COUNT(GROUP);
		BATCH_CountNonBlank                  						:= SUM(GROUP,IF(pPartyAKA.BATCH<>'',1,0));
		DBCODE_CountNonBlank                  					:= SUM(GROUP,IF(pPartyAKA.DBCODE<>'',1,0));
		INCIDENT_NUM_CountNonBlank                  		:= SUM(GROUP,IF(pPartyAKA.INCIDENT_NUM<>'',1,0));
		PARTY_NUM_CountNonBlank                  					:= SUM(GROUP,IF(pPartyAKA.PARTY_NUM<>'',1,0));
		// NAME_TYPE_CountNonBlank                  					:= SUM(GROUP,IF(pPartyAKA.NAME_TYPE<>'',1,0));
		FIRST_NAME_CountNonBlank                  			:= SUM(GROUP,IF(pPartyAKA.FIRST_NAME<>'',1,0));
		MIDDLE_NAME_CountNonBlank                  			:= SUM(GROUP,IF(pPartyAKA.MIDDLE_NAME<>'',1,0));
		LAST_NAME_CountNonBlank                  				:= SUM(GROUP,IF(pPartyAKA.LAST_NAME<>'',1,0));
		AKA_DBA_TEXT_CountNonBlank                  		:= SUM(GROUP,IF(pPartyAKA.AKA_DBA_TEXT<>'',1,0));
		PARTY_KEY_CountNonZero            							:= SUM(GROUP,IF(pPartyAKA.PARTY_KEY<>0,1,0));
END;



// Create the Incident table and run the STRATA statistics
%dPopulationStats_SANCTN_Mari_Incident% 						:= SORT(TABLE(pIncident
																																	,%rPopulationStats_SANCTN_Mari_Incident%
																																	,SRCE_CD
																																	,few)
																																,SRCE_CD);

// Create the Incident table and run the STRATA statistics
%dPopulationStats_SANCTN_Mari_Incident_Bip% 						:= SORT(TABLE(pIncidentBip
																																	,%rPopulationStats_SANCTN_Mari_Incident_Bip%
																																	,SRCE_CD
																																	,few)
																																	,SRCE_CD);

// Create the Party table and run the STRATA statistics
%dPopulationStats_SANCTN_Mari_Party% 								:= SORT(TABLE(pParty
																																	,%rPopulationStats_SANCTN_Mari_Party%
																																	,STATE
																																	,few)
																																	,STATE);

%dPopulationStats_SANCTN_Mari_Party_BIP% 						:= SORT(TABLE(pPartyBip
																																	,%rPopulationStats_SANCTN_Mari_Party_BIP%
																																	,STATE
																																	,few)
																																	,STATE);																														
																														
// Create the Incident Text table and run the STRATA statistics
%dPopulationStats_SANCTN_Mari_IncidentText% 				:= SORT(TABLE(pIncidentText
																																	,%rPopulationStats_SANCTN_Mari_IncidentText%
																																	,DBCODE
																																	,few)
																																	,DBCODE);

// Create the Party Text table and run the STRATA statistics
%dPopulationStats_SANCTN_Mari_PartyText% 						:= SORT(TABLE(pPartyText
																																	,%rPopulationStats_SANCTN_Mari_PartyText%
																																	,DBCODE
																																	,few)
																																	,DBCODE);

// Create the Incident Text table and run the STRATA statistics
%dPopulationStats_SANCTN_Mari_IncidentCode% 				:= SORT(TABLE(pIncidentCode
																																	,%rPopulationStats_SANCTN_Mari_IncidentCode%
																																	,CODE_STATE
																																	,few)
																																	,CODE_STATE);


// Create the Party AKA/DBA table and run the STRATA statistics
%dPopulationStats_SANCTN_Mari_Party_AKA_DBA% 				:= SORT(TABLE(pPartyAKA
																																	,%rPopulationStats_SANCTN_Mari_Party_AKA_DBA%
																																	,NAME_TYPE
																																	,few)
																																	,NAME_TYPE);




// Call the STRATA function to generate the XML stats for Incidents
STRATA.createXMLStats(%dPopulationStats_SANCTN_Mari_Incident%
											,'SANCTN_Mari'
											,'Incident file'
											,pVersion
											,''
											,%zIncident%
											,
											,'population');
// Call the STRATA function to generate the XML stats for Incidents
STRATA.createXMLStats(%dPopulationStats_SANCTN_Mari_Incident_Bip%
											,'SANCTN_Mari'
											,'Incident Bip file'
											,pVersion
											,''
											,%zIncidentBip%
											,
											,'population');											
// Call the STRATA function to generate the XML stats for Parties
STRATA.createXMLStats(%dPopulationStats_SANCTN_Mari_Party%
											,'SANCTN_Mari'
											,'Party file'
											,pVersion
											,''
											,%zParty%
											,
											,'population');
// Call the STRATA function to generate the XML stats for Parties with BIP linkids
STRATA.createXMLStats(%dPopulationStats_SANCTN_Mari_Party_Bip%
											,'SANCTN_Mari'
											,'Party Bip file'
											,pVersion
											,''
											,%zPartyBip%
											,
											,'population');										
// Call the STRATA function to generate the XML stats for Incident Text
STRATA.createXMLStats(%dPopulationStats_SANCTN_Mari_IncidentText%
											,'SANCTN_Mari'
											,'Incident Text file'
											,pVersion
											,''
											,%zIncidentText%
											,
											,'population');
// Call the STRATA function to generate the XML stats for Party Text
STRATA.createXMLStats(%dPopulationStats_SANCTN_Mari_PartyText%
											,'SANCTN_Mari'
											,'Party Text file'
											,pVersion
											,''
											,%zPartyText%
											,
											,'population');
// Call the STRATA function to generate the XML stats for Incident Code
STRATA.createXMLStats(%dPopulationStats_SANCTN_Mari_IncidentCode%
											,'SANCTN_Mari'
											,'Incident Code file'
											,pVersion
											,''
											,%zIncidentCode%
											,
											,'population');


// Call the STRATA function to generate the XML stats for Party AKA/DBA
STRATA.createXMLStats(%dPopulationStats_SANCTN_Mari_Party_AKA_DBA%
											,'SANCTN_Mari'
											,'Party AKA DDB file'
											,pVersion
											,''
											,%zPartyAKA%
											,
											,'population');

zOut := parallel(%zIncident%,%zIncidentBip%,%zParty%,%zPartyBip%,%zIncidentText%,%zPartyText%,%zIncidentCode%,%zPartyAKA%);

ENDMACRO;