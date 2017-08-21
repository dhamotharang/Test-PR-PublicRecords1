IMPORT BairRx_Common,iesp;

EXPORT Layouts := MODULE

	EXPORT LayoutEntity := record
		BairRx_PSS.SALTLayout.LayoutOut.eid;
		BairRx_PSS.SALTLayout.LayoutOut.eid_hash;
		BairRx_PSS.SALTLayout.LayoutOut.weight;
		BairRx_PSS.SALTLayout.LayoutOut.lexid;
		BairRx_PSS.SALTLayout.LayoutOut.title;
		BairRx_PSS.SALTLayout.LayoutOut.clean_gender;
	END;	

	EXPORT LayoutName := record
		BairRx_PSS.SALTLayout.LayoutOut.prepped_name;
		BairRx_PSS.SALTLayout.LayoutOut.title;
		BairRx_PSS.SALTLayout.LayoutOut.fname;
		BairRx_PSS.SALTLayout.LayoutOut.mname;
		BairRx_PSS.SALTLayout.LayoutOut.lname;
		BairRx_PSS.SALTLayout.LayoutOut.name_suffix;
		BairRx_PSS.SALTLayout.LayoutOut.clean_gender;
		BairRx_PSS.SALTLayout.LayoutOut.name_type;
	END;
	
	EXPORT LayoutNameRec := record		
		LayoutEntity;
		LayoutName;
	END;
	
	EXPORT LayoutNameGroup := record
		BairRx_PSS.SALTLayout.LayoutOut.lexid;
		DATASET(LayoutName) names;
	END;

	EXPORT LayoutAddr := record		
		BairRx_PSS.SALTLayout.LayoutOut.prepped_rec_type;
		BairRx_PSS.SALTLayout.LayoutOut.prepped_addr1;
		BairRx_PSS.SALTLayout.LayoutOut.prepped_addr2;
		BairRx_PSS.SALTLayout.LayoutOut.prim_range;
		BairRx_PSS.SALTLayout.LayoutOut.predir;
		BairRx_PSS.SALTLayout.LayoutOut.prim_name;
		BairRx_PSS.SALTLayout.LayoutOut.addr_suffix;
		BairRx_PSS.SALTLayout.LayoutOut.postdir;
		BairRx_PSS.SALTLayout.LayoutOut.unit_desig;
		BairRx_PSS.SALTLayout.LayoutOut.sec_range;
		BairRx_PSS.SALTLayout.LayoutOut.p_city_name;		
		BairRx_PSS.SALTLayout.LayoutOut.st;
		BairRx_PSS.SALTLayout.LayoutOut.zip;
		BairRx_PSS.SALTLayout.LayoutOut.zip4;
		BairRx_PSS.SALTLayout.LayoutOut.county;		
	END;
	export LayoutAddrExt := record(LayoutAddr)
		BairRx_PSS.SALTLayout.LayoutOut.latitude;
		BairRx_PSS.SALTLayout.LayoutOut.longitude;
	END;
	
	EXPORT LayoutAddrRec := record		
		BairRx_PSS.SALTLayout.LayoutOut.lexid;
		LayoutAddrExt;
	END;	
	
	EXPORT LayoutAddrGroup := record		
		BairRx_PSS.SALTLayout.LayoutOut.lexid;
		DATASET(LayoutAddrExt) addrs;
	END;
	
	EXPORT LayoutDOB := record
		BairRx_PSS.SALTLayout.LayoutOut.dob;
	END;
	
	EXPORT LayoutDOBRec := record		
		LayoutEntity;
		LayoutDOB;
	END;
	
	EXPORT LayoutDOBGroup := record		
		BairRx_PSS.SALTLayout.LayoutOut.lexid;
		DATASET(LayoutDOB) DOBs;
	END;
	
	EXPORT LayoutSSN := record
		BairRx_PSS.SALTLayout.LayoutOut.possible_ssn;
	end;
	
	EXPORT LayoutSSNGroupByDID := record
		BairRx_PSS.SALTLayout.LayoutOut.lexid;
		DATASET(LayoutSSN) ssns;
	END;

	EXPORT LayoutSSNRecByDID := record(LayoutSSN)
		BairRx_PSS.SALTLayout.LayoutOut.lexid;
	END;

	EXPORT LayoutSSNGroupByEID := record
		BairRx_PSS.SALTLayout.LayoutOut.eid;
		DATASET(LayoutSSN) ssns;
	END;

	EXPORT LayoutSSNRecByEID := record(LayoutSSN)
		BairRx_PSS.SALTLayout.LayoutOut.eid;
	END;
	
	EXPORT LayoutScore := RECORD
		STRING64 Field;
		INTEGER2 Score;		
	END;	
	
	EXPORT LayoutEID := record
		BairRx_PSS.SALTLayout.LayoutOut.eid;
		STRING3 eid_type;
		INTEGER2 weight;
		INTEGER2 record_Score;
		LayoutScore;
	END;
	
	EXPORT LayoutEIDRec := record		
		BairRx_PSS.SALTLayout.LayoutOut.lexid;
		LayoutEID;
	END;
	
	EXPORT LayoutEIDScore := record		
		LayoutEID-LayoutScore;
		DATASET(LayoutScore) scores;
	END;
	
	EXPORT LayoutEIDScoreGroup := record		
		BairRx_PSS.SALTLayout.LayoutOut.lexid;
		LayoutEID-LayoutScore;
		DATASET(LayoutScore) scores;
	END;
	
	EXPORT LayoutEIDGroup := record		
		BairRx_PSS.SALTLayout.LayoutOut.lexid;
		DATASET(LayoutEIDScore) EIDs;
	END;
	
	EXPORT LayoutMO := record
		BairRx_Common.Layouts.EID;
		BairRx_Common.Keys.PayloadMOKey().ir_number;
		BairRx_Common.Keys.PayloadMOKey().x_coordinate;
		BairRx_Common.Keys.PayloadMOKey().y_coordinate;
		BairRx_Common.Keys.PayloadMOKey().ucr_group;
		BairRx_Common.Keys.PayloadMOKey().crime;
		BairRx_Common.Keys.PayloadMOKey().address_of_crime;
		BairRx_Common.Keys.PayloadMOKey().first_date;
		BairRx_Common.Keys.PayloadMOKey().last_date;
		BairRx_Common.Keys.PayloadMOKey().beat;
		BairRx_Common.Keys.PayloadMOKey().rd;
		BairRx_Common.Keys.PayloadMOKey().agency;
		BairRx_Common.Keys.PayloadPersonKey().name_type;
	END;
	
	EXPORT LayoutMORec := record		
		LayoutEntity;
		LayoutMO;
		LayoutAddr;
	END;
	
	EXPORT LayoutMOGroup := record		
		BairRx_PSS.SALTLayout.LayoutOut.lexid;
		DATASET(LayoutMORec) Events;
	END;
		
	EXPORT LayoutCFS := record
		BairRx_Common.Keys.PayloadCFSKey().eid;
		BairRx_Common.Keys.PayloadCFSKey().x_coordinate;
		BairRx_Common.Keys.PayloadCFSKey().y_coordinate;
		BairRx_Common.Keys.PayloadCFSKey().event_number;
		BairRx_Common.Keys.PayloadCFSKey().final_ucr_group;
		BairRx_Common.Keys.PayloadCFSKey().initial_type;
		BairRx_Common.Keys.PayloadCFSKey().final_type;
		BairRx_Common.Keys.PayloadCFSKey().address;
		BairRx_Common.Keys.PayloadCFSKey().date_time_received;
		BairRx_Common.Keys.PayloadCFSKey().beat;
		BairRx_Common.Keys.PayloadCFSKey().district;
		BairRx_Common.Keys.PayloadCFSKey().data_provider_name;
	END;

	EXPORT LayoutCFSRec := record		
		LayoutEntity;
		LayoutCFS;
		LayoutAddr;
	END;
	
	EXPORT LayoutCFSGroup := record		
		BairRx_PSS.SALTLayout.LayoutOut.lexid;
		DATASET(LayoutCFSRec) CFS;
	END;
	
	EXPORT LayoutOffender:= record(LayoutAddr)
		BairRx_Common.Keys.PayloadOffenderKey().eid;
		BairRx_Common.Keys.PayloadOffenderKey().x_coordinate;
		BairRx_Common.Keys.PayloadOffenderKey().y_coordinate;
		BairRx_Common.Keys.PayloadOffenderKey().classification;
		BairRx_Common.Keys.PayloadOffenderKey().agency_offender_id;
		BairRx_Common.Keys.PayloadOffenderKey().address;
		BairRx_Common.Keys.PayloadOffenderKey().first_name;
		BairRx_Common.Keys.PayloadOffenderKey().middle_name;
		BairRx_Common.Keys.PayloadOffenderKey().last_name;
		BairRx_Common.Keys.PayloadOffenderKey().data_provider_name;		
		BairRx_Common.Keys.PayloadOffenderKey().charge_offense;			
		BairRx_Common.Keys.PayloadOffenderKey().expiration_date;	
		BairRx_Common.Keys.PayloadOffenderKey().lexid;
		BairRx_Common.Keys.PayloadOffenderKey().has_image;
	END;
	
	EXPORT LayoutOffenderRec := record		
		LayoutEntity;
		LayoutOffender;
	END;
	
	EXPORT LayoutOffenderGroup := record		
		BairRx_PSS.SALTLayout.LayoutOut.lexid;
		DATASET(LayoutOffenderRec) Offenders;
	END;
		
	EXPORT LayoutLPR:= record
		BairRx_Common.Layouts.EID;
		BairRx_Common.Keys.PayloadLprKey().eventnumber;
		BairRx_Common.Keys.PayloadLprKey().x_coordinate;
		BairRx_Common.Keys.PayloadLprKey().y_coordinate;
		BairRx_Common.Keys.PayloadLprKey().plate;
		BairRx_Common.Keys.PayloadLprKey().capturedatetime;
		BairRx_Common.Keys.PayloadLprKey().data_provider_name;	
	END;
	
	EXPORT LayoutLPRRec := record		
		LayoutEntity;
		LayoutLPR;
	END;
	
	EXPORT LayoutLPRGroup := record		
		BairRx_PSS.SALTLayout.LayoutOut.lexid;
		DATASET(LayoutLPRRec) LPR;
	END;
	
	EXPORT LayoutCrash:= record
		BairRx_Common.Layouts.EID;
		BairRx_Common.Keys.PayloadCrashKey().x;
		BairRx_Common.Keys.PayloadCrashKey().y;
		BairRx_Common.Keys.PayloadCrashKey().crashtype;
		BairRx_Common.Keys.PayloadCrashKey().case_number;
		BairRx_Common.Keys.PayloadCrashKey().reportnumber;
		// BairRx_Common.Keys.PayloadCrashKey().licensenumber;
		// BairRx_Common.Keys.PayloadCrashKey().licensestate;
		// BairRx_Common.Keys.PayloadCrashKey().race;
		BairRx_Common.Keys.PayloadCrashKey().address;
		BairRx_Common.Keys.PayloadCrashKey().report_date;
		BairRx_Common.Keys.PayloadCrashKey().data_provider_name;
	END;
	
	EXPORT LayoutCrashRec := record		
		LayoutEntity;
		LayoutCrash;
		LayoutAddr;
	END;	
	
	EXPORT LayoutCrashGroup := record		
		BairRx_PSS.SALTLayout.LayoutOut.lexid;
		DATASET(LayoutCrashRec) Crash;
	END;
	
	// --------- PERSON SEARCH -----------------
	
	EXPORT LayoutInternal := RECORD(BairRx_PSS.SALTLayout.LayoutOut)
	END;	
	
	EXPORT LayoutPersonPresentation := record(LayoutInternal)
		iesp.bair_person.t_BAIRPersonSearchRecord;
	END;	
	
	// --------- VEHICLE SEARCH -----------------
	
	EXPORT LayoutVehicle := record
		BairRx_PSS.SALTLayout.LayoutOut.eid;
		BairRx_PSS.SALTLayout.LayoutOut.vin;
		BairRx_PSS.SALTLayout.LayoutOut.plate;
		BairRx_PSS.SALTLayout.LayoutOut.plate_st;
		BairRx_PSS.SALTLayout.LayoutOut.year;
		BairRx_PSS.SALTLayout.LayoutOut.make;
		BairRx_PSS.SALTLayout.LayoutOut.model;
		BairRx_PSS.SALTLayout.LayoutOut.color;
		BairRx_PSS.SALTLayout.LayoutOut.style;		
		BairRx_PSS.SALTLayout.LayoutOut.weight;
		BairRx_PSS.SALTLayout.LayoutOut.score;
		BairRx_PSS.SALTLayout.LayoutOut.record_score;
		BairRx_PSS.SALTLayout.LayoutOut.sequence;
		BairRx_PSS.SALTLayout.LayoutOut.vehicle_match;
		unsigned4 vehicleid;
		boolean main_vehicle := false;		
	END;
	
	EXPORT LayoutVehicleParty := record	
		BairRx_PSS.SALTLayout.LayoutOut.eid;
		BairRx_PSS.SALTLayout.LayoutOut.lexid;		
		BairRx_PSS.SALTLayout.LayoutOut.latitude;
		BairRx_PSS.SALTLayout.LayoutOut.longitude;
		LayoutName;
		LayoutAddr;
		BairRx_PSS.SALTLayout.LayoutOut.dob;
		LayoutSSN;
		BairRx_PSS.SALTLayout.LayoutOut.dl;
		BairRx_PSS.SALTLayout.LayoutOut.dl_st;		
		BairRx_PSS.SALTLayout.LayoutOut.weight;
		BairRx_PSS.SALTLayout.LayoutOut.score;
		BairRx_PSS.SALTLayout.LayoutOut.record_score;		
		BairRx_PSS.SALTLayout.LayoutOut.sequence;
		BairRx_PSS.SALTLayout.LayoutOut.clean_company_name;
		BairRx_PSS.SALTLayout.LayoutOut.person_match;
		unsigned4 vehicleid;
		boolean main_vehicle := false;
	END;
	
	EXPORT LayoutVehiclePartyGroup := record
		BairRx_PSS.SALTLayout.LayoutOut.eid;
		BairRx_PSS.SALTLayout.LayoutOut.weight;
		BairRx_PSS.SALTLayout.LayoutOut.score;
		BairRx_PSS.SALTLayout.LayoutOut.record_score;
		unsigned4 vehicleid;
		boolean main_vehicle := false;
		DATASET(LayoutVehicleParty) parties;
	END;
	
	EXPORT LayoutOtherVehicle := record(LayoutVehicle)
		DATASET(LayoutVehicleParty) parties;
	END;	
	
	EXPORT LayoutOtherVehicleGroup := record
		BairRx_PSS.SALTLayout.LayoutOut.eid;
		BairRx_PSS.SALTLayout.LayoutOut.weight;
		BairRx_PSS.SALTLayout.LayoutOut.score;
		BairRx_PSS.SALTLayout.LayoutOut.record_score;		
		DATASET(LayoutOtherVehicle) other_vehicles;
	END;	
	
	EXPORT LayoutOtherVehicleOut := record
		BairRx_PSS.SALTLayout.LayoutOut.eid;
		dataset(iesp.bair_vehiclesearch.t_BAIROtherVehicle) OtherVehicles;
	END;
	
	EXPORT LayoutVehiclePresentation := record(LayoutInternal)
		iesp.bair_vehiclesearch.t_BAIRVehicleSearchRecord;
	END;	

	//--------- Phone SEARCH -----------------
	
	EXPORT LayoutPhoneMORec := RECORD(LayoutMORec)
		TYPEOF(BairRx_PSS.SALTLayout.LayoutOut.phone) narrative_phone;
	END;

	EXPORT LayoutPhoneSearchRec := RECORD(BairRx_PSS.SALTLayout.LayoutOut)
		TYPEOF(BairRx_PSS.SALTLayout.LayoutOut.phone) narrative_phone;		
		// boolean match_by_phone := false;
	END;

	EXPORT LayoutPhoneAddrRec := RECORD		
		BairRx_PSS.SALTLayout.LayoutOut.eid;
		LayoutAddrExt;
	END;	
	
	EXPORT LayoutPhoneAddrGroup := RECORD		
		BairRx_PSS.SALTLayout.LayoutOut.eid;
		DATASET(LayoutAddrExt) addrs;
	END;

	EXPORT LayoutParsedPhone := RECORD
		BairRx_PSS.SALTLayout.LayoutOut.eid;
		BairRx_PSS.SALTLayout.LayoutOut.eid_hash;
		BairRx_PSS.SALTLayout.LayoutOut.phone;
		boolean match_by_phone := false;
	END;
		
	EXPORT LayoutPhonePresentation := RECORD(LayoutInternal)
		iesp.bair_phonesearch.t_BAIRPhoneSearchRecord;
	END;		
	
END;