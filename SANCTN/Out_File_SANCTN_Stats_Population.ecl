EXPORT Out_File_SANCTN_Stats_Population (pIncident
                                        ,pParty
																				,pRebuttal
																				,pLicense
																				,pVersion
																				,zOut) := MACRO

import STRATA,lib_stringlib;

	#uniquename(rPopulationStats_pIncident);
	#uniquename(rPopulationStats_SANCTN_Party);
	#uniquename(rPopulationStats_SANCTN_Rebuttal);
	#uniquename(rPopulationStats_SANCTN_License);
	#uniquename(dPopulationStats_pIncident);
	#uniquename(dPopulationStats_SANCTN_Party);
	#uniquename(dPopulationStats_SANCTN_Rebuttal);
	#uniquename(dPopulationStats_SANCTN_License);
	#uniquename(zIncident);
	#uniquename(zParty);
	#uniquename(zRebuttal);
	#uniquename(zLicense);

%rPopulationStats_pIncident% := record
    pIncident.AG_CODE;
    CountGroup                                      := count(group);
    BATCH_NUMBER_CountNonBlank                      := sum(group,if(pIncident.BATCH_NUMBER<>'',1,0));
    INCIDENT_NUMBER_CountNonBlank                   := sum(group,if(pIncident.INCIDENT_NUMBER<>'',1,0));
    PARTY_NUMBER_CountNonBlank                      := sum(group,if(pIncident.PARTY_NUMBER<>'',1,0));
    RECORD_TYPE_CountNonBlank                       := sum(group,if(pIncident.RECORD_TYPE<>'',1,0));
    ORDER_NUMBER_CountNonBlank                      := sum(group,if(pIncident.ORDER_NUMBER<>'',1,0));
    CASE_NUMBER_CountNonBlank                       := sum(group,if(pIncident.CASE_NUMBER<>'',1,0));
    INCIDENT_DATE_CountNonBlank                     := sum(group,if(pIncident.INCIDENT_DATE<>'',1,0));
    JURISDICTION_CountNonBlank                      := sum(group,if(pIncident.JURISDICTION<>'',1,0));
    SOURCE_DOCUMENT_CountNonBlank                   := sum(group,if(pIncident.SOURCE_DOCUMENT<>'',1,0));
    ADDITIONAL_INFO_CountNonBlank                   := sum(group,if(pIncident.ADDITIONAL_INFO<>'',1,0));
    AGENCY_CountNonBlank                            := sum(group,if(pIncident.AGENCY<>'',1,0));
    ALLEGED_AMOUNT_CountNonBlank                    := sum(group,if(pIncident.ALLEGED_AMOUNT<>'',1,0));
    ESTIMATED_LOSS_CountNonBlank                    := sum(group,if(pIncident.ESTIMATED_LOSS<>'',1,0));
    FCR_DATE_CountNonBlank                          := sum(group,if(pIncident.FCR_DATE<>'',1,0));
    OK_FOR_FCR_CountNonBlank                        := sum(group,if(pIncident.OK_FOR_FCR<>'',1,0));
		modified_date_CountNonBlank											:= sum(group,if(pIncident.modified_date<>'',1,0));
		load_date_CountNonBlank													:= sum(group,if(pIncident.load_date<>'',1,0));
    incident_text_CountNonBlank                     := sum(group,if(pIncident.incident_text<>'',1,0));
    incident_date_clean_CountNonBlank               := sum(group,if(pIncident.incident_date_clean<>'',1,0));
    fcr_date_clean_CountNonBlank                    := sum(group,if(pIncident.fcr_date_clean<>'',1,0));
		cln_modified_date_CountNonBlank									:= sum(group,if(pIncident.cln_modified_date<>'',1,0));
		cln_load_date_CountNonBlank											:= sum(group,if(pIncident.cln_load_date<>'',1,0));
end;


%rPopulationStats_SANCTN_Party% := record
	  string20 state                              := lib_stringlib.StringLib.StringToUpperCase(trim(regexreplace('\\.|(, EC2M 4YA)|[0-9]',pParty.inSTATE,''),left,right));
    CountGroup                                  := count(group);
    BATCH_NUMBER_CountNonBlank                  := sum(group,if(pParty.BATCH_NUMBER<>'',1,0));
    INCIDENT_NUMBER_CountNonBlank               := sum(group,if(pParty.INCIDENT_NUMBER<>'',1,0));
    PARTY_NUMBER_CountNonBlank                  := sum(group,if(pParty.PARTY_NUMBER<>'',1,0));
    RECORD_TYPE_CountNonBlank                   := sum(group,if(pParty.RECORD_TYPE<>'',1,0));
    ORDER_NUMBER_CountNonBlank                  := sum(group,if(pParty.ORDER_NUMBER<>'',1,0));
    PARTY_NAME_CountNonBlank                    := sum(group,if(pParty.PARTY_NAME<>'',1,0));
    PARTY_POSITION_CountNonBlank                := sum(group,if(pParty.PARTY_POSITION<>'',1,0));
    PARTY_VOCATION_CountNonBlank                := sum(group,if(pParty.PARTY_VOCATION<>'',1,0));
    PARTY_FIRM_CountNonBlank                    := sum(group,if(pParty.PARTY_FIRM<>'',1,0));
    inADDRESS_CountNonBlank                     := sum(group,if(pParty.inADDRESS<>'',1,0));
    inCITY_CountNonBlank                        := sum(group,if(pParty.inCITY<>'',1,0));
    inSTATE_CountNonBlank                       := sum(group,if(pParty.inSTATE<>'',1,0));
    inZIP_CountNonBlank                         := sum(group,if(pParty.inZIP<>'',1,0));
    SSNUMBER_CountNonBlank                      := sum(group,if(pParty.SSNUMBER<>'',1,0));
    FINES_LEVIED_CountNonBlank                  := sum(group,if(pParty.FINES_LEVIED<>'',1,0));
    RESTITUTION_CountNonBlank                   := sum(group,if(pParty.RESTITUTION<>'',1,0));
    OK_FOR_FCR_CountNonBlank                    := sum(group,if(pParty.OK_FOR_FCR<>'',1,0));
    party_text_CountNonBlank                    := sum(group,if(pParty.party_text<>'',1,0));
    title_CountNonBlank                         := sum(group,if(pParty.title<>'',1,0));
    fname_CountNonBlank                         := sum(group,if(pParty.fname<>'',1,0));
    mname_CountNonBlank                         := sum(group,if(pParty.mname<>'',1,0));
    lname_CountNonBlank                         := sum(group,if(pParty.lname<>'',1,0));
    name_suffix_CountNonBlank                   := sum(group,if(pParty.name_suffix<>'',1,0));
    name_score_CountNonBlank                    := sum(group,if(pParty.name_score<>'',1,0));
    cname_CountNonBlank                         := sum(group,if(pParty.cname<>'',1,0));
    prim_range_CountNonBlank                    := sum(group,if(pParty.prim_range<>'',1,0));
    predir_CountNonBlank                        := sum(group,if(pParty.predir<>'',1,0));
    prim_name_CountNonBlank                     := sum(group,if(pParty.prim_name<>'',1,0));
    addr_suffix_CountNonBlank                   := sum(group,if(pParty.addr_suffix<>'',1,0));
    postdir_CountNonBlank                       := sum(group,if(pParty.postdir<>'',1,0));
    unit_desig_CountNonBlank                    := sum(group,if(pParty.unit_desig<>'',1,0));
    sec_range_CountNonBlank                     := sum(group,if(pParty.sec_range<>'',1,0));
    p_city_name_CountNonBlank                   := sum(group,if(pParty.p_city_name<>'',1,0));
    v_city_name_CountNonBlank                   := sum(group,if(pParty.v_city_name<>'',1,0));
    st_CountNonBlank                            := sum(group,if(pParty.st<>'',1,0));
    zip5_CountNonBlank                          := sum(group,if(pParty.zip5<>'',1,0));
    zip4_CountNonBlank                          := sum(group,if(pParty.zip4<>'',1,0));
    fips_state_CountNonBlank                    := sum(group,if(pParty.fips_state<>'',1,0));
    fips_county_CountNonBlank                   := sum(group,if(pParty.fips_county<>'',1,0));
    addr_rec_type_CountNonBlank                 := sum(group,if(pParty.addr_rec_type<>'',1,0));
    geo_lat_CountNonBlank                       := sum(group,if(pParty.geo_lat<>'',1,0));
    geo_long_CountNonBlank                      := sum(group,if(pParty.geo_long<>'',1,0));
    cbsa_CountNonBlank                          := sum(group,if(pParty.cbsa<>'',1,0));
    geo_blk_CountNonBlank                       := sum(group,if(pParty.geo_blk<>'',1,0));
    geo_match_CountNonBlank                     := sum(group,if(pParty.geo_match<>'',1,0));
    cart_CountNonBlank                          := sum(group,if(pParty.cart<>'',1,0));
    cr_sort_sz_CountNonBlank                    := sum(group,if(pParty.cr_sort_sz<>'',1,0));
    lot_CountNonBlank                           := sum(group,if(pParty.lot<>'',1,0));
    lot_order_CountNonBlank                     := sum(group,if(pParty.lot_order<>'',1,0));
    dpbc_CountNonBlank                          := sum(group,if(pParty.dpbc<>'',1,0));
    chk_digit_CountNonBlank                     := sum(group,if(pParty.chk_digit<>'',1,0));
    err_stat_CountNonBlank                      := sum(group,if(pParty.err_stat<>'',1,0));
		dba_name_CountNonBlank											:= sum(group,if(pParty.dba_name <>'',1,0));
		contact_name_CountNonBlank									:= sum(group,if(pParty.contact_name <>'',1,0));
end;


%rPopulationStats_SANCTN_Rebuttal% := record
    pRebuttal.BATCH_NUMBER;
		pRebuttal.INCIDENT_NUMBER;
		CountGroup                                  := count(group);
		BATCH_NUMBER_CountNonBlank                  := sum(group,if(pRebuttal.BATCH_NUMBER <> '',1,0));
    INCIDENT_NUMBER_CountNonBlank               := sum(group,if(pRebuttal.INCIDENT_NUMBER <> '',1,0));
    PARTY_NUMBER_CountNonBlank                  := sum(group,if(pRebuttal.PARTY_NUMBER <> '',1,0));
    RECORD_TYPE_CountNonBlank                   := sum(group,if(pRebuttal.RECORD_TYPE <> '',1,0));
    ORDER_NUMBER_CountNonBlank                  := sum(group,if(pRebuttal.ORDER_NUMBER <> '',1,0));
		PARTY_TEXT_CountNonBlank                    := sum(group,if(pRebuttal.PARTY_TEXT <> '',1,0));
end;

%rPopulationStats_SANCTN_License% := record
		pLicense.LICENSE_STATE;
    CountGroup                                  := count(group);
		BATCH_NUMBER_CountNonBlank                  := sum(group,if(pLicense.BATCH_NUMBER <> '',1,0));
    INCIDENT_NUMBER_CountNonBlank               := sum(group,if(pLicense.INCIDENT_NUMBER <> '',1,0));
    PARTY_NUMBER_CountNonBlank                  := sum(group,if(pLicense.PARTY_NUMBER <> '',1,0));
    RECORD_TYPE_CountNonBlank                   := sum(group,if(pLicense.RECORD_TYPE <> '',1,0));
    ORDER_NUMBER_CountNonBlank                  := sum(group,if(pLicense.ORDER_NUMBER <> '',1,0));
		LICENSE_NUMBER_CountNonBlank								:= sum(group,if(pLicense.LICENSE_NUMBER <> '',1,0));
		LICENSE_TYPE_CountNonBlank									:= sum(group,if(pLicense.LICENSE_TYPE <> '',1,0));
		CLN_LICENSE_NUMBER_CountNonBlank						:= sum(group,if(pLicense.CLN_LICENSE_NUMBER <> '',1,0));
		STD_TYPE_DESC_CountNonBlank									:= sum(group,if(pLicense.STD_TYPE_DESC <> '',1,0));
end;

	
// Create the Incident table and run the STRATA statistics
%dPopulationStats_pIncident% := sort(table(pIncident,%rPopulationStats_pIncident%,AG_CODE,few),AG_CODE);
									 
// Create the Party table and run the STRATA statistics
%dPopulationStats_SANCTN_Party% := sort(table(pParty,%rPopulationStats_SANCTN_Party%
																				,lib_stringlib.StringLib.StringToUpperCase(trim(regexreplace('\\.|(, EC2M 4YA)|[0-9]',pParty.inSTATE,''),left,right))
																				,few),state);


// Create the Rebuttal table and run the STRATA statistics
%dPopulationStats_SANCTN_Rebuttal% := sort(table(pRebuttal,%rPopulationStats_SANCTN_Rebuttal%,BATCH_NUMBER,INCIDENT_NUMBER,few),BATCH_NUMBER,INCIDENT_NUMBER);

// Create the License table and run the STRATA statistics
%dPopulationStats_SANCTN_License% := sort(table(pLicense,%rPopulationStats_SANCTN_License%,LICENSE_STATE,few),LICENSE_STATE);

 
// Call the STRATA function to generate the XML stats for Incidents
STRATA.createXMLStats(%dPopulationStats_pIncident%,'SANCTN','Incident file',pVersion,'',%zIncident%,,'population');

// Call the STRATA function to generate the XML stats for Parties
STRATA.createXMLStats(%dPopulationStats_SANCTN_Party%,'SANCTN','Party file',pVersion,'',%zParty%,,'population');


// Call the STRATA function to generate the XML stats for Rebuttal
STRATA.createXMLStats(%dPopulationStats_SANCTN_Rebuttal%,'SANCTN','Rebuttal file',pVersion,'',%zRebuttal%,,'population');

// Call the STRATA function to generate the XML stats for License
STRATA.createXMLStats(%dPopulationStats_SANCTN_License%,'SANCTN','License file',pVersion,'',%zLicense%,,'population');


zOut := parallel(%zIncident%,%zParty%,%zRebuttal%,%zLicense%);

ENDMACRO;