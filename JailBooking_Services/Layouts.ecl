import Appriss;

EXPORT Layouts := MODULE
	
	EXPORT FakeID := RECORD
		unsigned6 id;
	END;
	
	EXPORT FakeIDMapping := RECORD
		unsigned6 fakeid;			
		Appriss.Layout_Base_Bookings.booking_sid;
	END;
	
	EXPORT bookingId := RECORD
		Appriss.Layout_Base_Bookings.booking_sid;
		boolean isDeepDive := false;
	END;
	
	EXPORT DLNumber := RECORD
		Appriss.Layout_Base_Bookings.DLNUMBER;
	END;
	
	EXPORT FBINumber := RECORD
		Appriss.Layout_Base_Bookings.FBI_NBR;
	END;
	
	EXPORT stateID := RECORD
		Appriss.Layout_Base_Bookings.STATE_ID;
	END;
	
	EXPORT agency := RECORD
		Appriss.Layout_Base_Bookings.Agency_ori;
		Appriss.Layout_Base_Bookings.State_Cd;
	END;
	
	EXPORT attributes := RECORD
		Appriss.Layout_Base_Bookings.KEY_RACE;	
		Appriss.Layout_Base_Bookings.KEY_GENDER;	
		unsigned2 heightLow;	
		unsigned2 heightHigh;
		unsigned2 weightLow;
		unsigned2 weightHigh;		
		Appriss.Layout_Base_Bookings.KEY_HAIR;	
		Appriss.Layout_Base_Bookings.KEY_EYE;	
		unsigned2 yearLow;
		unsigned2 yearHigh;
	END;
	
	EXPORT Payload := RECORD
  //unsigned6 fakeid;
		string15 booking_sid;
		string10 prim_range;
		string28 prim_name;
		string8 sec_range;
		string25 p_city_name;
		String2 state;
		string5 zip5;
		string20 fname;
		string20 mname;
		string20 lname;
		string9 ssn;
		string8   DATE_OF_BIRTH;	
		unsigned8 did;		
		string25 home_phone;
    string30 work_phone;		
		unsigned1 zero;
		string1 blank;
 END;

	EXPORT bookingCharges := RECORD
		Appriss.Layout_Key_charges.booking_sid;
		Appriss.Layout_Key_charges.agencykey;
		Appriss.Layout_Key_charges.agency;
		Appriss.Layout_Key_charges.charge_seq;
		Appriss.Layout_Key_charges.charge_cnt;
		Appriss.Layout_Key_charges.charge;
		Appriss.Layout_Key_charges.description;
		Appriss.Layout_Key_charges.charge_dt;
		Appriss.Layout_Key_charges.court_dt;
		Appriss.Layout_Key_charges.key_severity;
		Appriss.Layout_Key_charges.bond_amt;
		Appriss.Layout_Key_charges.disposition_dt;
		Appriss.Layout_Key_charges.disposition_text;
		Appriss.Layout_Key_charges.ncic_offense_class_txt;
		Appriss.Layout_Key_charges.ncic_offense_cd;
		Appriss.Layout_Key_charges.bond_type_txt;
		Appriss.Layout_Key_charges.site_id;		
	END;

 
	EXPORT mainBooking := RECORD
		Appriss.Layout_key_booking.title;
		Appriss.Layout_key_booking.fname;
		Appriss.Layout_key_booking.mname;
		Appriss.Layout_key_booking.lname;
		Appriss.Layout_key_booking.name_suffix;
		Appriss.Layout_key_booking.date_of_birth;
		Appriss.Layout_key_booking.key_race;
		Appriss.Layout_key_booking.race;
		Appriss.Layout_key_booking.key_gender;  
		Appriss.Layout_key_booking.gender;
		Appriss.Layout_key_booking.release_date;
		Appriss.Layout_key_booking.rreason;
		Appriss.Layout_key_booking.ssn;
		Appriss.Layout_key_booking.key_wgt;
		Appriss.Layout_key_booking.wgt;  
		Appriss.Layout_key_booking.key_hgt;  
		Appriss.Layout_key_booking.hgt;
		Appriss.Layout_key_booking.arrest_date;
		Appriss.Layout_key_booking.inmate_nbr;	
		Appriss.Layout_key_booking.prim_range;
		Appriss.Layout_key_booking.predir;
		Appriss.Layout_key_booking.prim_name;
		Appriss.Layout_key_booking.addr_suffix;
		Appriss.Layout_key_booking.postdir;
		Appriss.Layout_key_booking.unit_desig;
		Appriss.Layout_key_booking.sec_range;
		Appriss.Layout_key_booking.p_city_name;
		Appriss.Layout_key_booking.v_city_name;
		Appriss.Layout_key_booking.state;
		Appriss.Layout_key_booking.zip5;
		Appriss.Layout_key_booking.zip4;
		Appriss.Layout_key_booking.key_hair;
		Appriss.Layout_key_booking.hair;
		Appriss.Layout_key_booking.key_eye;	
		Appriss.Layout_key_booking.eye;  
		Appriss.Layout_key_booking.pob;
		Appriss.Layout_key_booking.state_id;
		Appriss.Layout_key_booking.home_phone;
		Appriss.Layout_key_booking.key_mstatus;
		Appriss.Layout_key_booking.mstatus;
		Appriss.Layout_key_booking.employer;
		Appriss.Layout_key_booking.occupation;
		Appriss.Layout_key_booking.dlnumber;
		Appriss.Layout_key_booking.dlstate;
		Appriss.Layout_key_booking.education_yrs;
		Appriss.Layout_key_booking.correct_lenses_ind;
		Appriss.Layout_key_booking.marks_scars_tatoos;
		Appriss.Layout_key_booking.scar;
		Appriss.Layout_key_booking.mark;
		Appriss.Layout_Key_booking.tattoo;
		Appriss.Layout_key_booking.key_complex;
		Appriss.Layout_key_booking.fbi_nbr;
		Appriss.Layout_key_booking.state_cd;		
		Appriss.Layout_key_booking.citizen_ind;
		Appriss.Layout_key_booking.violent_behavior_ind;
		Appriss.Layout_key_booking.escape_risk_ind;
		Appriss.Layout_key_booking.key_handed;  
		Appriss.Layout_key_booking.handed;
		Appriss.Layout_key_booking.other_phy_features;
		Appriss.Layout_key_booking.suicide_risk_ind;
		Appriss.Layout_key_booking.nationality;
		Appriss.Layout_key_booking.key_ethnicity_cd;
		Appriss.Layout_key_booking.ethnicity_cd;
		Appriss.Layout_key_booking.foreign_born_ind;
		Appriss.Layout_key_booking.language_spoken;
		Appriss.Layout_key_booking.work_phone;
		Appriss.Layout_key_booking.language_written;
		Appriss.Layout_key_booking.language_read;  
		Appriss.Layout_key_booking.warnings_cautions;
		Appriss.Layout_key_booking.weekender_ind;
		Appriss.Layout_key_booking.medical_alert;
		Appriss.Layout_key_booking.military;
		Appriss.Layout_key_booking.gang;
		Appriss.Layout_key_booking.mental_illness_ind;
		Appriss.Layout_key_booking.sex_offender_ind;
		Appriss.Layout_key_booking.offense_date;
		Appriss.Layout_key_booking.booking_sid;
		Appriss.Layout_key_booking.booking_date;
		Appriss.Layout_Key_booking.booking_nbr;
		Appriss.Layout_key_booking.agencykey;
		Appriss.Layout_key_booking.agency;
		Appriss.Layout_key_booking.agency_description;
		Appriss.Layout_key_booking.agency_ori;
		Appriss.Layout_key_booking.arresting_agency_name;
		Appriss.Layout_key_booking.arresting_agency_phone;
		Appriss.Layout_key_booking.did;			
		boolean isDeepDive;
		unsigned2 record_penalty;
		dataset(bookingCharges) charges {MAXCOUNT(Constant.MAX_CHARGES_PER_BOOKING)};
	END;

END;