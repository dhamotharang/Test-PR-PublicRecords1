EXPORT Out_File_SANCTN_Stats_Population_V2 (pIncident_v2
																						,pParty_v2
																						,pRebuttal_v2
																						,pLicense_v2
																						,pPartyAka_v2
																						,pVersion_v2
																						,zOut_v2) := MACRO

import STRATA,lib_stringlib;

	#uniquename(rPopulationStats_pIncident_v2);
	#uniquename(rPopulationStats_SANCTN_Party_v2);
	#uniquename(rPopulationStats_SANCTN_Rebuttal_v2);
	#uniquename(rPopulationStats_SANCTN_License_v2);
	#uniquename(rPopulationStats_SANCTN_Party_AKA_v2);
	#uniquename(dPopulationStats_pIncident_v2);
	#uniquename(dPopulationStats_SANCTN_Party_v2);
	#uniquename(dPopulationStats_SANCTN_Rebuttal_v2);
	#uniquename(dPopulationStats_SANCTN_License_v2);
	#uniquename(dPopulationStats_SANCTN_Party_AKA_v2);
	#uniquename(zIncident_v2);
	#uniquename(zParty_v2);
	#uniquename(zRebuttal_v2);
	#uniquename(zLicense_v2);
	#uniquename(zParty_AKA_v2);

%rPopulationStats_pIncident_v2% := record
    pIncident_v2.AG_CODE;
    CountGroup                                      := count(group);
    BATCH_NUMBER_CountNonBlank                      := sum(group,if(pIncident_v2.BATCH_NUMBER<>'',1,0));
    INCIDENT_NUMBER_CountNonBlank                   := sum(group,if(pIncident_v2.INCIDENT_NUMBER<>'',1,0));
    PARTY_NUMBER_CountNonBlank                      := sum(group,if(pIncident_v2.PARTY_NUMBER<>'',1,0));
    RECORD_TYPE_CountNonBlank                       := sum(group,if(pIncident_v2.RECORD_TYPE<>'',1,0));
    ORDER_NUMBER_CountNonBlank                      := sum(group,if(pIncident_v2.ORDER_NUMBER<>'',1,0));
    CASE_NUMBER_CountNonBlank                       := sum(group,if(pIncident_v2.CASE_NUMBER<>'',1,0));
    INCIDENT_DATE_CountNonBlank                     := sum(group,if(pIncident_v2.INCIDENT_DATE<>'',1,0));
    JURISDICTION_CountNonBlank                      := sum(group,if(pIncident_v2.JURISDICTION<>'',1,0));
    SOURCE_DOCUMENT_CountNonBlank                   := sum(group,if(pIncident_v2.SOURCE_DOCUMENT<>'',1,0));
    ADDITIONAL_INFO_CountNonBlank                   := sum(group,if(pIncident_v2.ADDITIONAL_INFO<>'',1,0));
    AGENCY_CountNonBlank                            := sum(group,if(pIncident_v2.AGENCY<>'',1,0));
    ALLEGED_AMOUNT_CountNonBlank                    := sum(group,if(pIncident_v2.ALLEGED_AMOUNT<>'',1,0));
    ESTIMATED_LOSS_CountNonBlank                    := sum(group,if(pIncident_v2.ESTIMATED_LOSS<>'',1,0));
    FCR_DATE_CountNonBlank                          := sum(group,if(pIncident_v2.FCR_DATE<>'',1,0));
    OK_FOR_FCR_CountNonBlank                        := sum(group,if(pIncident_v2.OK_FOR_FCR<>'',1,0));
		modified_date_CountNonBlank											:= sum(group,if(pIncident_v2.modified_date<>'',1,0));
		load_date_CountNonBlank													:= sum(group,if(pIncident_v2.load_date<>'',1,0));
    incident_text_CountNonBlank                     := sum(group,if(pIncident_v2.incident_text<>'',1,0));
    incident_date_clean_CountNonBlank               := sum(group,if(pIncident_v2.incident_date_clean<>'',1,0));
    fcr_date_clean_CountNonBlank                    := sum(group,if(pIncident_v2.fcr_date_clean<>'',1,0));
		cln_modified_date_CountNonBlank									:= sum(group,if(pIncident_v2.cln_modified_date<>'',1,0));
		cln_load_date_CountNonBlank											:= sum(group,if(pIncident_v2.cln_load_date<>'',1,0));
end;


%rPopulationStats_SANCTN_Party_v2% := record
	  string20 state                              := lib_stringlib.StringLib.StringToUpperCase(trim(regexreplace('\\.|(, EC2M 4YA)|[0-9]',pParty_v2.inSTATE,''),left,right));
    CountGroup                                  := count(group);
    BATCH_NUMBER_CountNonBlank                  := sum(group,if(pParty_v2.BATCH_NUMBER<>'',1,0));
    INCIDENT_NUMBER_CountNonBlank               := sum(group,if(pParty_v2.INCIDENT_NUMBER<>'',1,0));
    PARTY_NUMBER_CountNonBlank                  := sum(group,if(pParty_v2.PARTY_NUMBER<>'',1,0));
    RECORD_TYPE_CountNonBlank                   := sum(group,if(pParty_v2.RECORD_TYPE<>'',1,0));
    ORDER_NUMBER_CountNonBlank                  := sum(group,if(pParty_v2.ORDER_NUMBER<>'',1,0));
    PARTY_NAME_CountNonBlank                    := sum(group,if(pParty_v2.PARTY_NAME<>'',1,0));
    PARTY_POSITION_CountNonBlank                := sum(group,if(pParty_v2.PARTY_POSITION<>'',1,0));
    PARTY_VOCATION_CountNonBlank                := sum(group,if(pParty_v2.PARTY_VOCATION<>'',1,0));
    PARTY_FIRM_CountNonBlank                    := sum(group,if(pParty_v2.PARTY_FIRM<>'',1,0));
    inADDRESS_CountNonBlank                     := sum(group,if(pParty_v2.inADDRESS<>'',1,0));
    inCITY_CountNonBlank                        := sum(group,if(pParty_v2.inCITY<>'',1,0));
    inSTATE_CountNonBlank                       := sum(group,if(pParty_v2.inSTATE<>'',1,0));
    inZIP_CountNonBlank                         := sum(group,if(pParty_v2.inZIP<>'',1,0));
    SSNUMBER_CountNonBlank                      := sum(group,if(pParty_v2.SSNUMBER<>'',1,0));
    FINES_LEVIED_CountNonBlank                  := sum(group,if(pParty_v2.FINES_LEVIED<>'',1,0));
    RESTITUTION_CountNonBlank                   := sum(group,if(pParty_v2.RESTITUTION<>'',1,0));
    OK_FOR_FCR_CountNonBlank                    := sum(group,if(pParty_v2.OK_FOR_FCR<>'',1,0));
    party_text_CountNonBlank                    := sum(group,if(pParty_v2.party_text<>'',1,0));
    title_CountNonBlank                         := sum(group,if(pParty_v2.title<>'',1,0));
    fname_CountNonBlank                         := sum(group,if(pParty_v2.fname<>'',1,0));
    mname_CountNonBlank                         := sum(group,if(pParty_v2.mname<>'',1,0));
    lname_CountNonBlank                         := sum(group,if(pParty_v2.lname<>'',1,0));
    name_suffix_CountNonBlank                   := sum(group,if(pParty_v2.name_suffix<>'',1,0));
    name_score_CountNonBlank                    := sum(group,if(pParty_v2.name_score<>'',1,0));
    cname_CountNonBlank                         := sum(group,if(pParty_v2.cname<>'',1,0));
    prim_range_CountNonBlank                    := sum(group,if(pParty_v2.prim_range<>'',1,0));
    predir_CountNonBlank                        := sum(group,if(pParty_v2.predir<>'',1,0));
    prim_name_CountNonBlank                     := sum(group,if(pParty_v2.prim_name<>'',1,0));
    addr_suffix_CountNonBlank                   := sum(group,if(pParty_v2.addr_suffix<>'',1,0));
    postdir_CountNonBlank                       := sum(group,if(pParty_v2.postdir<>'',1,0));
    unit_desig_CountNonBlank                    := sum(group,if(pParty_v2.unit_desig<>'',1,0));
    sec_range_CountNonBlank                     := sum(group,if(pParty_v2.sec_range<>'',1,0));
    p_city_name_CountNonBlank                   := sum(group,if(pParty_v2.p_city_name<>'',1,0));
    v_city_name_CountNonBlank                   := sum(group,if(pParty_v2.v_city_name<>'',1,0));
    st_CountNonBlank                            := sum(group,if(pParty_v2.st<>'',1,0));
    zip5_CountNonBlank                          := sum(group,if(pParty_v2.zip5<>'',1,0));
    zip4_CountNonBlank                          := sum(group,if(pParty_v2.zip4<>'',1,0));
    fips_state_CountNonBlank                    := sum(group,if(pParty_v2.fips_state<>'',1,0));
    fips_county_CountNonBlank                   := sum(group,if(pParty_v2.fips_county<>'',1,0));
    addr_rec_type_CountNonBlank                 := sum(group,if(pParty_v2.addr_rec_type<>'',1,0));
    geo_lat_CountNonBlank                       := sum(group,if(pParty_v2.geo_lat<>'',1,0));
    geo_long_CountNonBlank                      := sum(group,if(pParty_v2.geo_long<>'',1,0));
    cbsa_CountNonBlank                          := sum(group,if(pParty_v2.cbsa<>'',1,0));
    geo_blk_CountNonBlank                       := sum(group,if(pParty_v2.geo_blk<>'',1,0));
    geo_match_CountNonBlank                     := sum(group,if(pParty_v2.geo_match<>'',1,0));
    cart_CountNonBlank                          := sum(group,if(pParty_v2.cart<>'',1,0));
    cr_sort_sz_CountNonBlank                    := sum(group,if(pParty_v2.cr_sort_sz<>'',1,0));
    lot_CountNonBlank                           := sum(group,if(pParty_v2.lot<>'',1,0));
    lot_order_CountNonBlank                     := sum(group,if(pParty_v2.lot_order<>'',1,0));
    dpbc_CountNonBlank                          := sum(group,if(pParty_v2.dpbc<>'',1,0));
    chk_digit_CountNonBlank                     := sum(group,if(pParty_v2.chk_digit<>'',1,0));
    err_stat_CountNonBlank                      := sum(group,if(pParty_v2.err_stat<>'',1,0));
				UltID_CountNonZero																										:= sum(group,if(pParty_v2.UltID <>0,1,0));
				OrgID_CountNonZero																										:= sum(group,if(pParty_v2.OrgID <>0,1,0));
				SELEID_CountNonZero												  											:= sum(group,if(pParty_v2.SELEID <>0,1,0));
				ProxID_CountNonZero												  											:= sum(group,if(pParty_v2.ProxID <>0,1,0));
				POWID_CountNonZero																										:= sum(group,if(pParty_v2.POWID <>0,1,0));
				EmpID_CountNonZero																										:= sum(group,if(pParty_v2.EmpID <>0,1,0));
				DotID_CountNonZero																										:= sum(group,if(pParty_v2.DotID <>0,1,0));
				UltScore_CountNonZero																							:= sum(group,if(pParty_v2.UltScore <>0,1,0));
				OrgScore_CountNonZero																							:= sum(group,if(pParty_v2.OrgScore <>0,1,0));
				SELEScore_CountNonZero																						:= sum(group,if(pParty_v2.SELEScore <>0,1,0));
				ProxScore_CountNonZero																						:= sum(group,if(pParty_v2.ProxScore <>0,1,0));
				POWScore_CountNonZero																							:= sum(group,if(pParty_v2.POWScore <>0,1,0));
				EmpScore_CountNonZero																							:= sum(group,if(pParty_v2.EmpScore <>0,1,0));
				DotScore_CountNonZero																							:= sum(group,if(pParty_v2.DotScore <>0,1,0));
				UltWeight_CountNonZero																						:= sum(group,if(pParty_v2.UltWeight <>0,1,0));
				OrgWeight_CountNonZero																						:= sum(group,if(pParty_v2.OrgWeight <>0,1,0));
				SELEWeight_CountNonZero																					:= sum(group,if(pParty_v2.SELEWeight <>0,1,0));
				ProxWeight_CountNonZero																					:= sum(group,if(pParty_v2.ProxWeight <>0,1,0));
				POWWeight_CountNonZero																						:= sum(group,if(pParty_v2.POWWeight <>0,1,0));
				EmpWeight_CountNonZero																						:= sum(group,if(pParty_v2.EmpWeight <>0,1,0));
				DotWeight_CountNonZero																						:= sum(group,if(pParty_v2.DotWeight <>0,1,0));
				SOURCE_REC_ID_CountNonZero																		:= sum(group,if(pParty_v2.SOURCE_REC_ID <>0,1,0));
				DID_CountNonZero																												:= sum(group,if(pParty_v2.DID <>0,1,0));
				BDID_CountNonZero																											:= sum(group,if(pParty_v2.BDID <>0,1,0));
				SSN_APPENDED_CountNonBlank																		:= sum(group,if(pParty_v2.SSN_APPENDED <>'',1,0));
				dba_name_CountNonBlank																						:= sum(group,if(pParty_v2.dba_name <>'',1,0));
				contact_name_CountNonBlank																		:= sum(group,if(pParty_v2.contact_name <>'',1,0));
				ENH_DID_SRC_CountNonBlank																			:= sum(group,if(pParty_v2.ENH_DID_SRC <>'',1,0));
end;

%rPopulationStats_SANCTN_Rebuttal_v2% := record
    pRebuttal_v2.BATCH_NUMBER;
		pRebuttal_v2.INCIDENT_NUMBER;
		CountGroup                                  := count(group);
		BATCH_NUMBER_CountNonBlank                  := sum(group,if(pRebuttal_v2.BATCH_NUMBER <> '',1,0));
    INCIDENT_NUMBER_CountNonBlank               := sum(group,if(pRebuttal_v2.INCIDENT_NUMBER <> '',1,0));
    PARTY_NUMBER_CountNonBlank                  := sum(group,if(pRebuttal_v2.PARTY_NUMBER <> '',1,0));
    RECORD_TYPE_CountNonBlank                   := sum(group,if(pRebuttal_v2.RECORD_TYPE <> '',1,0));
    ORDER_NUMBER_CountNonBlank                  := sum(group,if(pRebuttal_v2.ORDER_NUMBER <> '',1,0));
		PARTY_TEXT_CountNonBlank                    := sum(group,if(pRebuttal_v2.PARTY_TEXT <> '',1,0));
end;

%rPopulationStats_SANCTN_License_v2% := record
		pLicense_v2.LICENSE_STATE;
    CountGroup                                  := count(group);
		BATCH_NUMBER_CountNonBlank                  := sum(group,if(pLicense_v2.BATCH_NUMBER <> '',1,0));
    INCIDENT_NUMBER_CountNonBlank               := sum(group,if(pLicense_v2.INCIDENT_NUMBER <> '',1,0));
    PARTY_NUMBER_CountNonBlank                  := sum(group,if(pLicense_v2.PARTY_NUMBER <> '',1,0));
    RECORD_TYPE_CountNonBlank                   := sum(group,if(pLicense_v2.RECORD_TYPE <> '',1,0));
    ORDER_NUMBER_CountNonBlank                  := sum(group,if(pLicense_v2.ORDER_NUMBER <> '',1,0));
		LICENSE_NUMBER_CountNonBlank								:= sum(group,if(pLicense_v2.LICENSE_NUMBER <> '',1,0));
		LICENSE_TYPE_CountNonBlank									:= sum(group,if(pLicense_v2.LICENSE_TYPE <> '',1,0));
		CLN_LICENSE_NUMBER_CountNonBlank						:= sum(group,if(pLicense_v2.CLN_LICENSE_NUMBER <> '',1,0));
		STD_TYPE_DESC_CountNonBlank									:= sum(group,if(pLicense_v2.STD_TYPE_DESC <> '',1,0));
end;


%rPopulationStats_SANCTN_Party_AKA_v2% := record
    pPartyAka_v2.BATCH_NUMBER;
		pPartyAka_v2.INCIDENT_NUMBER;
		CountGroup                                  := count(group);
		BATCH_NUMBER_CountNonBlank                  := sum(group,if(pPartyAka_v2.BATCH_NUMBER <> '',1,0));
    INCIDENT_NUMBER_CountNonBlank               := sum(group,if(pPartyAka_v2.INCIDENT_NUMBER <> '',1,0));
    PARTY_NUMBER_CountNonBlank                  := sum(group,if(pPartyAka_v2.PARTY_NUMBER <> '',1,0));
    RECORD_TYPE_CountNonBlank                   := sum(group,if(pPartyAka_v2.RECORD_TYPE <> '',1,0));
    ORDER_NUMBER_CountNonBlank                  := sum(group,if(pPartyAka_v2.ORDER_NUMBER <> '',1,0));
		NAME_TYPE_CountNonBlank											:= sum(group,if(pPartyAka_v2.NAME_TYPE <> '',1,0));
		LAST_NAME_CountNonBlank											:= sum(group,if(pPartyAka_v2.LAST_NAME <> '',1,0));
		FIRST_NAME_CountNonBlank										:= sum(group,if(pPartyAka_v2.FIRST_NAME <> '',1,0));
		MIDDLE_NAME_CountNonBlank										:= sum(group,if(pPartyAka_v2.MIDDLE_NAME <> '',1,0));
		AKA_DBA_TEXT_CountNonBlank                  := sum(group,if(pPartyAka_v2.AKA_DBA_TEXT <> '',1,0));
end;

	
// Create the Incident table and run the STRATA statistics
%dPopulationStats_pIncident_v2% := sort(table(pIncident_v2,%rPopulationStats_pIncident_v2%,AG_CODE,few),AG_CODE);
									 
// Create the Party table and run the STRATA statistics
%dPopulationStats_SANCTN_Party_v2% := sort(table(pParty_v2,%rPopulationStats_SANCTN_Party_v2%
																				,lib_stringlib.StringLib.StringToUpperCase(trim(regexreplace('\\.|(, EC2M 4YA)|[0-9]',pParty_v2.inSTATE,''),left,right))
																				,few),state);


// Create the Rebuttal table and run the STRATA statistics
%dPopulationStats_SANCTN_Rebuttal_v2% := sort(table(pRebuttal_v2,%rPopulationStats_SANCTN_Rebuttal_v2%,BATCH_NUMBER,INCIDENT_NUMBER,few),BATCH_NUMBER,INCIDENT_NUMBER);

// Create the License table and run the STRATA statistics
%dPopulationStats_SANCTN_License_v2% := sort(table(pLicense_v2,%rPopulationStats_SANCTN_License_v2%,LICENSE_STATE,few),LICENSE_STATE);


// Create the Party AKA/DBA table and run the STRATA statistics
%dPopulationStats_SANCTN_Party_AKA_v2% := sort(table(pPartyAka_v2,%rPopulationStats_SANCTN_Party_AKA_v2%,BATCH_NUMBER,INCIDENT_NUMBER,few),BATCH_NUMBER,INCIDENT_NUMBER);

 
// Call the STRATA function to generate the XML stats for Incidents
STRATA.createXMLStats(%dPopulationStats_pIncident_v2%,'SANCTN V2','Incident file',pVersion_v2,'',%zIncident_v2%,'view','population');

// Call the STRATA function to generate the XML stats for Parties
STRATA.createXMLStats(%dPopulationStats_SANCTN_Party_v2%,'SANCTN V2b','Party file',pVersion_v2,'',%zParty_v2%,'','population');


// Call the STRATA function to generate the XML stats for Rebuttal
STRATA.createXMLStats(%dPopulationStats_SANCTN_Rebuttal_v2%,'SANCTN V2','Rebuttal file',pVersion_v2,'',%zRebuttal_v2%,'','population');

// Call the STRATA function to generate the XML stats for License
STRATA.createXMLStats(%dPopulationStats_SANCTN_License_v2%,'SANCTN V2','License file',pVersion_v2,'',%zLicense_v2%,'','population');

// Call the STRATA function to generate the XML stats for Party AKA/DBA
STRATA.createXMLStats(%dPopulationStats_SANCTN_Party_AKA_v2%,'SANCTN V2','Party AKA DBA file',pVersion_v2,'',%zParty_AKA_v2%,'','population');


zOut_v2 := parallel(%zIncident_v2%,%zParty_v2%,%zRebuttal_v2%,%zLicense_v2%,%zParty_AKA_v2%);

ENDMACRO;