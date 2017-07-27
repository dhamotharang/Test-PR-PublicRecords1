export Out_File_Booking_stats_Population (pbooking
                                     ,pcharges
				 		                 				 ,pVersion
					                  				 ,zOut) := MACRO

import STRATA;

	#uniquename(rPopulationStats_Bookings);
	#uniquename(dPopulationStats_Bookings);
	#uniquename(zBooking);
	#uniquename(rPopulationStats_Charges);
	#uniquename(dPopulationStats_Charges);
	#uniquename(zCharges);

%rPopulationStats_Bookings%
 := record
  CountGroup									      :=	count(group);
	did_CountNonZero							    :=	sum(group,if(pBooking.did<>0,1,0));
	ssn_appended_CountNonBlank				:=	sum(group,if(pBooking.ssn<>'',1,0));
	ssn_CountNonZero						      :=	sum(group,if(pBooking.ap_ssn<>'',1,0));
	CREATION_TS_CountNonBlank		      :=	sum(group,if(pBooking.CREATION_TS<>'',1,0));
	LAST_CHANGE_TS_CountNonBlank		  :=	sum(group,if(pBooking.LAST_CHANGE_TS<>'',1,0));
	STATE_CD_CountNonBlank					  :=	sum(group,if(pBooking.STATE_CD<>'',1,0));
	primarykey_CountNonBlank	        :=	sum(group,if(pBooking.primarykey<>'',1,0));
	agencyKey_CountNonBlank				  	:=	sum(group,if(pBooking.agencyKey<>'',1,0));
	maxQueueSid_CountNonBlank					:=	sum(group,if(pBooking.maxQueueSid<>'',1,0));
	Booking_sid_CountNonBlank					:=	sum(group,if(pBooking.BOOKING_SID<>'',1,0));	
	AGENCY_CountNonBlank					    :=	sum(group,if(pBooking.AGENCY<>'',1,0));	
  BOOKING_NBR_CountNonBlank					:=	sum(group,if(pBooking.BOOKING_NBR<>'',1,0));	
	INMATE_NBR_CountNonBlank					:=	sum(group,if(pBooking.INMATE_NBR<>'',1,0));	
	STATE_ID_CountNonBlank					  :=	sum(group,if(pBooking.STATE_ID<>'',1,0));	
	oid_CountNonBlank					        :=	sum(group,if(pBooking.OID<>'',1,0));	
	LST_CHANGE_SESS_SID_CountNonBlank	:=	sum(group,if(pBooking.LAST_CHANGE_SESSION_SID<>'',1,0));		
	LAST_CHANGE_FILE_NBR_CountNonBlank:=	sum(group,if(pBooking.LAST_CHANGE_FILE_NBR<>'',1,0));		
	name_orig_CountNonBlank						:=	sum(group,if(pBooking.ap_FULL_NAME<>'',1,0));
	orig_lname_CountNonBlank					:=	sum(group,if(pBooking.ap_lname<>'',1,0));
	orig_fname_CountNonBlank					:=	sum(group,if(pBooking.ap_fname<>'',1,0));
	orig_mname_CountNonBlank					:=	sum(group,if(pBooking.ap_mname<>'',1,0));
	orig_name_suffix_CountNonBlank		:=	sum(group,if(pBooking.ap_name_suffix<>'',1,0));
	lname_CountNonBlank							  :=	sum(group,if(pBooking.lname<>'',1,0));
	fname_CountNonBlank							  :=	sum(group,if(pBooking.fname<>'',1,0));
	mname_CountNonBlank							  :=	sum(group,if(pBooking.mname<>'',1,0));
	name_suffix_CountNonBlank		      :=	sum(group,if(pBooking.name_suffix<>'',1,0));	
	ARREST_DATE_CountNonBlank					:=	sum(group,if(pBooking.ARREST_DATE<>'',1,0));
  ARREST_TS_CountNonBlank			      :=	sum(group,if(pBooking.ARREST_TS<>'',1,0));
	BOOKING_TS_RAW_CountNonBlank		  :=	sum(group,if(pBooking.BOOKING_TS_RAW<>'',1,0));
	BOOKING_DATE_CountNonBlank			  :=	sum(group,if(pBooking.BOOKING_DATE<>'',1,0));
	BOOKING_TS_CountNonBlank		      :=	sum(group,if(pBooking.BOOKING_TS<>'',1,0));
	RELEASE_DATE_CountNonBlank				:=	sum(group,if(pBooking.RELEASE_DATE<>'',1,0));
	RELEASE_TS_CountNonBlank          :=	sum(group,if(pBooking.RELEASE_TS<>'',1,0));
	DATE_OF_BIRTHCountNonBlank		    :=	sum(group,if(pBooking.DATE_OF_BIRTH<>'',1,0));
	DOB_CountNonBlank		              :=	sum(group,if(pBooking.DOB<>'',1,0));
	Race_CountNonBlank		            :=	sum(group,if(pBooking.RACE<>'',1,0));
	GENDER_CountNonBlank			        :=	sum(group,if(pBooking.GENDER<>'',1,0));
	HGT_CountNonBlank					        :=	sum(group,if(pBooking.HGT<>'',1,0));
	WGT_CountNonBlank				          :=	sum(group,if(pBooking.WGT<>'',1,0));
	HAIR_CountNonBlank					      :=	sum(group,if(pBooking.HAIR<>'',1,0));
	EYE_type_CountNonBlank				    :=	sum(group,if(pBooking.EYE<>'',1,0));
	HANDED_CountNonBlank					    :=	sum(group,if(pBooking.HANDED<>'',1,0));
	MSTATUS_CountNonBlank			        :=	sum(group,if(pBooking.MSTATUS<>'',1,0));
	RELEASED_IND_CountNonBlank	      :=	sum(group,if(pBooking.RELEASED_IND<>'',1,0));
	INCIDENT_IND_CountNonBlank	      :=	sum(group,if(pBooking.INCIDENT_IND<>'',1,0));
	RREASON_CountNonBlank	            :=	sum(group,if(pBooking.RREASON<>'',1,0));
	CUSTODY_STATUS_CD_CountNonBlank	  :=	sum(group,if(pBooking.CUSTODY_STATUS_CD<>'',1,0));
	KEY_RACE_CountNonBlank	          :=	sum(group,if(pBooking.KEY_RACE<>'',1,0));
	KEY_GENDER_CountNonBlank			    :=	sum(group,if(pBooking.KEY_GENDER<>'',1,0));
	KEY_HGT_CountNonBlank		          :=	sum(group,if(pBooking.KEY_HGT<>'',1,0));
	HGT_CD_CountNonBlank		          :=	sum(group,if(pBooking.HGT_CD<>'',1,0));
	KEY_WGT_CountNonBlank	            :=	sum(group,if(pBooking.KEY_WGT<>'',1,0));
	WGT_CD_CountNonBlank	            :=	sum(group,if(pBooking.WGT_CD<>'',1,0));
	KEY_HAIR_CountNonBlank	          :=	sum(group,if(pBooking.KEY_HAIR<>'',1,0));
	KEY_EYE_CountNonBlank	            :=	sum(group,if(pBooking.KEY_EYE<>'',1,0));
	KEY_MSTATUS_CountNonBlank	        :=	sum(group,if(pBooking.KEY_MSTATUS<>'',1,0));
	KEY_HANDED_CountNonBlank		      :=	sum(group,if(pBooking.KEY_HANDED<>'',1,0));
	ap_address1_CountNonBlank		      :=	sum(group,if(pBooking.ap_address1<>'',1,0));
	ap_address2_CountNonBlank			    :=	sum(group,if(pBooking.ap_address2<>'',1,0));
	ap_CITY_CountNonBlank			        :=	sum(group,if(pBooking.ap_CITY<>'',1,0));
	ap_STATE_CountNonBlank			      :=	sum(group,if(pBooking.ap_STATE<>'',1,0));
	ap_ZIPCODE_CountNonBlank			    :=	sum(group,if(pBooking.ap_ZIPCODE<>'',1,0));
	COMPLEX_CountNonBlank			        :=	sum(group,if(pBooking.COMPLEX<>'',1,0));
	DLNUMBER_CountNonBlank				    :=	sum(group,if(pBooking.DLNUMBER<>'',1,0));
	DLSTATE_CountNonBlank				      :=	sum(group,if(pBooking.DLSTATE<>'',1,0));
	POB_CountNonBlank						      :=	sum(group,if(pBooking.POB<>'',1,0));
	CITIZEN_IND_CountNonBlank			    :=	sum(group,if(pBooking.CITIZEN_IND<>'',1,0));
	WEEKENDER_IND_CountNonBlank			  :=	sum(group,if(pBooking.WEEKENDER_IND<>'',1,0));
	CORRECT_LENSES_IND_CountNonBlank	:=	sum(group,if(pBooking.CORRECT_LENSES_IND<>'',1,0));
	MARKS_SCARS_TATOOS_CountNonBlank	:=	sum(group,if(pBooking.MARKS_SCARS_TATOOS<>'',1,0));
	OTHER_PHY_FEATURES_CountNonBlank	:=	sum(group,if(pBooking.OTHER_PHY_FEATURES<>'',1,0));
	WARNINGS_CAUTIONS_CountNonBlank		:=	sum(group,if(pBooking.WARNINGS_CAUTIONS<>'',1,0));
	FRONT_IMAGE_CountNonBlank				  :=	sum(group,if(pBooking.FRONT_IMAGE<>'',1,0));
	PROFILE_IMAGE_CountNonBlank				:=	sum(group,if(pBooking.PROFILE_IMAGE<>'',1,0));
	HOME_PHONE_CountNonBlank		      :=	sum(group,if(pBooking.HOME_PHONE<>'',1,0));
	EMPLOYER_CountNonBlank		        :=	sum(group,if(pBooking.EMPLOYER<>'',1,0));
	WORK_PHONE_CountNonBlank		      :=	sum(group,if(pBooking.WORK_PHONE<>'',1,0));
	OCCUPATION_CountNonBlank		      :=	sum(group,if(pBooking.OCCUPATION<>'',1,0));
	LANGUAGE_SPOKEN_CountNonBlank		  :=	sum(group,if(pBooking.LANGUAGE_SPOKEN<>'',1,0));
	LANGUAGE_READ_CountNonBlank				:=	sum(group,if(pBooking.LANGUAGE_READ<>'',1,0));
	LANGUAGE_WRITTEN_CountNonBlank		:=	sum(group,if(pBooking.LANGUAGE_WRITTEN<>'',1,0));
	BLOOD_TYPE_CountNonBlank		      :=	sum(group,if(pBooking.BLOOD_TYPE<>'',1,0));
	VIOLENT_BEHAVIOR_IND_CountNonBlank:=	sum(group,if(pBooking.VIOLENT_BEHAVIOR_IND<>'',1,0));
	SUICIDE_RISK_IND_CountNonBlank		:=	sum(group,if(pBooking.SUICIDE_RISK_IND<>'',1,0));
	ESCAPE_RISK_IND_CountNonBlank		  :=	sum(group,if(pBooking.ESCAPE_RISK_IND<>'',1,0));
	FOREIGN_BORN_IND_CountNonBlank		:=	sum(group,if(pBooking.FOREIGN_BORN_IND<>'',1,0));
	SEX_OFFENDER_IND_CountNonBlank		:=	sum(group,if(pBooking.SEX_OFFENDER_IND<>'',1,0));
	MENTAL_ILLNESS_IND_CountNonBlank	:=	sum(group,if(pBooking.MENTAL_ILLNESS_IND<>'',1,0));
	GANG_CountNonBlank					      :=	sum(group,if(pBooking.GANG<>'',1,0));
	MILITARY_CountNonBlank					  :=	sum(group,if(pBooking.MILITARY<>'',1,0));
	PAROLE_CLASS_CountNonBlank				:=	sum(group,if(pBooking.PAROLE_CLASS<>'',1,0));
	FBI_NBR_CountNonBlank					    :=	sum(group,if(pBooking.FBI_NBR<>'',1,0));
	EDUCATION_YRS_CountNonBlank				:=	sum(group,if(pBooking.EDUCATION_YRS<>'',1,0));
	AGENCY_DESCRIPTION_CountNonBlank	:=	sum(group,if(pBooking.AGENCY_DESCRIPTION<>'',1,0));
	AGENCY_ORI_CountNonBlank					:=	sum(group,if(pBooking.AGENCY_ORI<>'',1,0));
	DEP_NO_SUPPRESS_WEB_DISPLAY_IND_CountNonBlank:=	sum(group,if(pBooking.DEP_NO_SUPPRESS_WEB_DISPLAY_IND<>'',1,0));
	DEP_NO_SUPPRESS_INQUIRY_IND_CountNonBlank:=	sum(group,if(pBooking.DEP_NO_SUPPRESS_INQUIRY_IND<>'',1,0));//new field
	ETHNICITY_CD_CountNonBlank				:=	sum(group,if(pBooking.ETHNICITY_CD<>'',1,0));
	KEY_ETHNICITY_CD_CountNonBlank		:=	sum(group,if(pBooking.KEY_ETHNICITY_CD<>'',1,0));
	NATIONALITY_CountNonBlank					:=	sum(group,if(pBooking.NATIONALITY<>'',1,0));
	OFFENSE_DATE_CountNonBlank				:=	sum(group,if(pBooking.OFFENSE_DATE<>'',1,0));
	OFFENSE_TS_CountNonBlank					:=	sum(group,if(pBooking.OFFENSE_TS<>'',1,0));
	SCHEDULED_RELEASE_DATE_CountNonBlank:=	sum(group,if(pBooking.SCHEDULED_RELEASE_DATE<>'',1,0));
	SENTENCE_EXP_DATE_CountNonBlank			:=	sum(group,if(pBooking.SENTENCE_EXP_DATE<>'',1,0));
	SCAR_CountNonBlank						      :=	sum(group,if(pBooking.SCAR<>'',1,0));
	mark_CountNonBlank					        :=	sum(group,if(pBooking.mark<>'',1,0));
	tattoo_CountNonBlank			          :=	sum(group,if(pBooking.tattoo<>'',1,0));
	FACIAL_HAIR_IND_CountNonBlank				:=	sum(group,if(pBooking.FACIAL_HAIR_IND<>'',1,0));
	HEARING_PROBLEM_IND_CountNonBlank		:=	sum(group,if(pBooking.HEARING_PROBLEM_IND<>'',1,0));
	RELIGION_CountNonBlank					    :=	sum(group,if(pBooking.RELIGION<>'',1,0));
	PASSPORT_VISA_NBR_CountNonBlank			:=	sum(group,if(pBooking.PASSPORT_VISA_NBR<>'',1,0));
	INS_REG_NBR_CountNonBlank					  :=	sum(group,if(pBooking.INS_REG_NBR<>'',1,0));
	HOLDING_FACILITY_CountNonBlank			:=	sum(group,if(pBooking.HOLDING_FACILITY<>'',1,0));
	COMPLEXION_CountNonBlank					  :=	sum(group,if(pBooking.COMPLEXION<>'',1,0));
	DLCLASS_TXT_CountNonBlank					  :=	sum(group,if(pBooking.DLCLASS_TXT<>'',1,0));
	RESIDENCY_STATUS_TXT_CountNonBlank	:=	sum(group,if(pBooking.RESIDENCY_STATUS_TXT<>'',1,0));
	PRIMARY_LANGUAGE_TXT_CountNonBlank	:=	sum(group,if(pBooking.PRIMARY_LANGUAGE_TXT<>'',1,0));
	ENGLISH_UNDERSTOOD_IND_CountNonBlank:=	sum(group,if(pBooking.ENGLISH_UNDERSTOOD_IND<>'',1,0));
	DNA_SAMPLE_TAKEN_IND_CountNonBlank	:=	sum(group,if(pBooking.DNA_SAMPLE_TAKEN_IND<>'',1,0));
	AFIS_ID_CountNonBlank					      :=	sum(group,if(pBooking.AFIS_ID<>'',1,0));
	ARRESTING_ORI_NBR_CountNonBlank		  :=	sum(group,if(pBooking.ARRESTING_ORI_NBR<>'',1,0));
	ARRESTING_AGENCY_NAME_CountNonBlank	:=	sum(group,if(pBooking.ARRESTING_AGENCY_NAME<>'',1,0));
	ARRESTING_AGENCY_PHONE_CountNonBlank:=	sum(group,if(pBooking.ARRESTING_AGENCY_PHONE<>'',1,0));
	HOLDING_FACILITY_DESC_CountNonBlank	:=	sum(group,if(pBooking.HOLDING_FACILITY_DESC<>'',1,0));
	HOLDING_FACILITY_ORI_CountNonBlank	:=	sum(group,if(pBooking.HOLDING_FACILITY_ORI<>'',1,0));
	SUBJECT_SEARCH_SID_CountNonBlank		:=	sum(group,if(pBooking.SUBJECT_SEARCH_SID<>'',1,0));
	SUBJECT_PERSON_SID_CountNonBlank		:=	sum(group,if(pBooking.SUBJECT_PERSON_SID<>'',1,0));
	SUBJECT_GROUP_SID_CountNonBlank			:=	sum(group,if(pBooking.SUBJECT_GROUP_SID<>'',1,0));
	GROUP_RULE_VERSION_CountNonBlank		:=	sum(group,if(pBooking.GROUP_RULE_VERSION<>'',1,0));
	KEY_COMPLEX_CountNonBlank			      :=	sum(group,if(pBooking.KEY_COMPLEX<>'',1,0));//new field
	DISPLAY_EXTRA_IMAGES_IND_CountNonBlank:=	sum(group,if(pBooking.DISPLAY_EXTRA_IMAGES_IND<>'',1,0));
	DAYS_INCARCERATED_CountNonBlank			:=	sum(group,if(pBooking.DAYS_INCARCERATED<>'',1,0));
  prim_range_CountNonBlank					  :=	sum(group,if(pBooking.prim_range<>'',1,0));
	predir_CountNonBlank						    :=	sum(group,if(pBooking.predir<>'',1,0));
	prim_name_CountNonBlank						  :=	sum(group,if(pBooking.prim_name<>'',1,0));
	addr_suffix_CountNonBlank					  :=	sum(group,if(pBooking.addr_suffix<>'',1,0));
	postdir_CountNonBlank						    :=	sum(group,if(pBooking.postdir<>'',1,0));
	unit_desig_CountNonBlank					  :=	sum(group,if(pBooking.unit_desig<>'',1,0));
	sec_range_CountNonBlank						  :=	sum(group,if(pBooking.sec_range<>'',1,0));
	p_city_name_CountNonBlank					  :=	sum(group,if(pBooking.p_city_name<>'',1,0));
	v_city_name_CountNonBlank					  :=	sum(group,if(pBooking.v_city_name<>'',1,0));
	state_CountNonBlank							      :=	sum(group,if(pBooking.state<>'',1,0));
	zip5_CountNonBlank							    :=	sum(group,if(pBooking.zip5<>'',1,0));
	zip4_CountNonBlank							    :=	sum(group,if(pBooking.zip4<>'',1,0));
	end;

%rPopulationStats_Charges%
 :=
  record
    CountGroup                             := count(group);
	  creation_ts                            := sum(group,if(pcharges.creation_ts<>'',1,0));
    last_change_ts_CountNonBlank           := sum(group,if(pcharges.last_change_ts<>'',1,0));
    maxqueuesid_CountNonBlank              := sum(group,if(pcharges.maxqueuesid<>'',1,0));
    agencykey_CountNonBlank                := sum(group,if(pcharges.agencykey<>'',1,0));
    agencyori_CountNonBlank                := sum(group,if(pcharges.agencyori<>'',1,0));
    doctype_CountNonBlank                  := sum(group,if(pcharges.doctype<>'',1,0));
    booking_sid_CountNonBlank              := sum(group,if(pcharges.booking_sid<>'',1,0));
    site_id_CountNonBlank                  := sum(group,if(pcharges.site_id<>'',1,0));
    agency_CountNonBlank                   := sum(group,if(pcharges.agency<>'',1,0));
    charge_seq_CountNonBlank               := sum(group,if(pcharges.charge_seq<>'',1,0));
    charge_cnt_CountNonBlank               := sum(group,if(pcharges.charge_cnt<>'',1,0));
    charge_CountNonBlank                   := sum(group,if(pcharges.charge<>'',1,0));
    description_CountNonBlank              := sum(group,if(pcharges.description<>'',1,0));
    charge_dt_CountNonBlank                := sum(group,if(pcharges.charge_dt<>'',1,0));
    court_dt_CountNonBlank                 := sum(group,if(pcharges.court_dt<>'',1,0));
    key_severity_CountNonBlank             := sum(group,if(pcharges.key_severity<>'',1,0));
	  bond_amt_CountNonBlank                 := sum(group,if(pcharges.bond_amt<>'',1,0));
    disposition_dt_CountNonBlank           := sum(group,if(pcharges.disposition_dt<>'',1,0));
		disposition_text_CountNonBlank         := sum(group,if(pcharges.disposition_text<>'',1,0));
	  ncic_offense_class_txt_CountNonBlank   := sum(group,if(pcharges.ncic_offense_class_txt<>'',1,0));
    ncic_offense_cd_CountNonBlank          := sum(group,if(pcharges.ncic_offense_cd<>'',1,0));
		bond_type_txt_CountNonBlank            := sum(group,if(pcharges.bond_type_txt<>'',1,0));
  end;

// Create the Main table and run the STRATA statistics
%dPopulationStats_Bookings% := table(pBooking
											     ,%rPopulationStats_Bookings%
											     ,few);
STRATA.createXMLStats(%dPopulationStats_Bookings%
					 ,'Appriss'
					 ,'Booking File'
					 ,pVersion
					 ,''
					 ,%zBooking%);
// Create the Offenses table and run the STRATA statistics
%dPopulationStats_Charges% := table(pcharges
								  	                ,%rPopulationStats_Charges%
										                ,few);
STRATA.createXMLStats(%dPopulationStats_Charges%
					 ,'Appriss'
					 ,'Charge File'
					 ,pVersion
					 ,''
					 ,%zCharges%);

zOut := parallel(%zBooking%,
                 %zCharges%
				         );

ENDMACRO;