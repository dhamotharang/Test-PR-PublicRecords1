import BairRx_Common,iesp;

EXPORT Layouts := MODULE

	EXPORT PayloadIncident := RECORD
		BairRx_Common.Layouts.EID;
		BairRx_Common.Keys.PayloadCrashKey().case_number;
		BairRx_Common.Keys.PayloadCrashKey().reportnumber;
		BairRx_Common.Keys.PayloadCrashKey().report_date;
		BairRx_Common.Keys.PayloadCrashKey().address;
		BairRx_Common.Keys.PayloadCrashKey().county;
		BairRx_Common.Keys.PayloadCrashKey().crash_city;
		BairRx_Common.Keys.PayloadCrashKey().crash_state;
		BairRx_Common.Keys.PayloadCrashKey().x;
		BairRx_Common.Keys.PayloadCrashKey().y;		
		BairRx_Common.Keys.PayloadCrashKey().hitandrun;
		BairRx_Common.Keys.PayloadCrashKey().intersectionrelated;
		BairRx_Common.Keys.PayloadCrashKey().officername;
		BairRx_Common.Keys.PayloadCrashKey().crashtype;
		BairRx_Common.Keys.PayloadCrashKey().locationtype;
		BairRx_Common.Keys.PayloadCrashKey().accidentclass;
		BairRx_Common.Keys.PayloadCrashKey().specialcircumstance1;
		BairRx_Common.Keys.PayloadCrashKey().specialcircumstance2;
		BairRx_Common.Keys.PayloadCrashKey().specialcircumstance3;
		BairRx_Common.Keys.PayloadCrashKey().lightcondition;
		BairRx_Common.Keys.PayloadCrashKey().weathercondition;
		BairRx_Common.Keys.PayloadCrashKey().surfacetype;
		BairRx_Common.Keys.PayloadCrashKey().roadspecialfeature1;
		BairRx_Common.Keys.PayloadCrashKey().roadspecialfeature2;
		BairRx_Common.Keys.PayloadCrashKey().roadspecialfeature3;
		BairRx_Common.Keys.PayloadCrashKey().surfacecondition;
		BairRx_Common.Keys.PayloadCrashKey().trafficcontrolpresent;
		BairRx_Common.Keys.PayloadCrashKey().data_provider_id;
		BairRx_Common.Keys.PayloadCrashKey().data_provider_ori;
		BairRx_Common.Keys.PayloadCrashKey().data_provider_name;
	END;
	
	EXPORT PayloadVehicle := RECORD
		BairRx_Common.Layouts.EID;
		BairRx_Common.Keys.PayloadCrashVehicleKey().vehicleid;
		BairRx_Common.Keys.PayloadCrashVehicleKey().vin;
		BairRx_Common.Keys.PayloadCrashVehicleKey().plate;
		BairRx_Common.Keys.PayloadCrashVehicleKey().platestate;
		BairRx_Common.Keys.PayloadCrashVehicleKey().year;
		BairRx_Common.Keys.PayloadCrashVehicleKey().make;
		BairRx_Common.Keys.PayloadCrashVehicleKey().model;
		BairRx_Common.Keys.PayloadCrashVehicleKey().towed;
		BairRx_Common.Keys.PayloadCrashVehicleKey().vehicle_type;
		BairRx_Common.Keys.PayloadCrashVehicleKey().damage;
		BairRx_Common.Keys.PayloadCrashVehicleKey().sequence;
		BairRx_Common.Keys.PayloadCrashVehicleKey().action;
		BairRx_Common.Keys.PayloadCrashVehicleKey().driverimpairment;
		BairRx_Common.Keys.PayloadCrashVehicleKey().data_provider_id;
	END;
	
	EXPORT PayloadPerson := RECORD
		BairRx_Common.Layouts.EID;
		BairRx_Common.Keys.PayloadCrashPersonKey().driver;
		BairRx_Common.Keys.PayloadCrashPersonKey().first_name;
		BairRx_Common.Keys.PayloadCrashPersonKey().last_name;
		BairRx_Common.Keys.PayloadCrashPersonKey().licensenumber;
		BairRx_Common.Keys.PayloadCrashPersonKey().licensestate;
		BairRx_Common.Keys.PayloadCrashPersonKey().race;
		BairRx_Common.Keys.PayloadCrashPersonKey().sex;
		BairRx_Common.Keys.PayloadCrashPersonKey().city;
		BairRx_Common.Keys.PayloadCrashPersonKey().state;
		BairRx_Common.Keys.PayloadCrashPersonKey().age;
		BairRx_Common.Keys.PayloadCrashPersonKey().driveractions;
		BairRx_Common.Keys.PayloadCrashPersonKey().airbag;
		BairRx_Common.Keys.PayloadCrashPersonKey().seatbelt;
		BairRx_Common.Keys.PayloadCrashPersonKey().personid;
		BairRx_Common.Keys.PayloadCrashPersonKey().personvehicleid;
		BairRx_Common.Keys.PayloadCrashPersonKey().data_provider_id;
		BairRx_Common.Keys.PayloadCrashPersonKey().lexid;
	END;
	
	EXPORT Payload := RECORD
		PayloadIncident;
		PayloadVehicle - [EID];
		PayloadPerson - [EID];
	END;

	EXPORT SearchPayload := RECORD
		Payload;
		BairRx_Common.Layouts.SortingFields;
		BairRx_Common.Layouts.CustomSortLayout;
		unsigned4 distance;
	END;
	
	EXPORT PayloadReport := RECORD
		PayloadIncident;
		DATASET(PayloadIncident) incidents;
		DATASET(PayloadVehicle) vehicles;
		DATASET(PayloadPerson) persons;
		DATASET(BairRx_Common.Layouts.PayloadNotes) notes;
	END;
	
	EXPORT SearchResults := RECORD
		unsigned match_count;
		DATASET(iesp.bair_crash.t_BAIRCrashSearchRecord) records;
	END;	
	
END;