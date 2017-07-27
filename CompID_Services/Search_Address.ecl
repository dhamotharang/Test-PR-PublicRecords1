IMPORT CompId_Services, Address, Doxie, Doxie_Raw, DriversV2_Services, UT;

EXPORT Search_Address := MODULE
	// Modules
	shared dlSearch		:=	DriversV2_Services.DLRaw.narrow_view.by_did;
	// Layouts
	shared LayoutAddPersonalID	:= CompId_Services.Layouts.Layout_Add_PersonalID;
	shared LayoutAddResult			:= CompId_Services.Layouts.Layout_Add_Result;
	/* 
	**	Retrieve Names residing on Address 
	**	1. 	Input Address is standardized
	**	2. 	Standard address is used to search using Doxie_Raw.Residents_Raw (which in turn gets best record), no DOD return
	**	3.	Get dl information for persons found on addresses
	**	4.	Build results in format Layout_CompId_AddrSearch_Result
	*/
	EXPORT DATASET(LayoutAddResult) getResultForAddress(UNSIGNED6 Seq_Value, STRING StreetNumber, STRING UnitNumber, 
	                                                    STRING StreetName, STRING City, STRING State, STRING Zip5, 
																											STRING Zip4, UNSIGNED MaxRecordsToReturn = Constants.MAX_CANDIDATES_ON_ADDRESS) := FUNCTION
		// Create Address struct for search using Doxie_Raw.Residents_Raw
		rec := RECORD
			UNSIGNED1 seq;
		END;
		d := dataset([{1}],rec);
		// Now time to call FirstLogic's address standardization before making a call to household search
		addrStreet	:= Address.Addr1FromComponents(StreetNumber, '', StreetName,'', '', '', UnitNumber);
		addrCityStZip := Address.Addr2FromComponents(City, State, Zip5);
		addrClean := Address.GetCleanAddress(addrStreet, 
																				 addrCityStZip, 
																				 Address.Components.Country.US).results;
		//Prepare addresssearch_plus dataset in order to call household search
		doxie.layout_addressSearch_plus into(rec l) := TRANSFORM
			SELF.prim_range	:= addrClean.prim_range;
			SELF.prim_name	:= addrClean.prim_name;
			SELF.sec_range	:= addrClean.sec_range;
			SELF.suffix			:= addrClean.suffix;
			SELF.state			:= addrClean.state;
			SELF.zip				:= addrClean.zip;
			SELF.zip4				:= addrClean.zip4;
			SELF						:= [];
		END;
		seachAddr	:= PROJECT(d, into(LEFT));
		// Use Doxie_Raw.Residents_Raw to get best record but looks like this blocks DOD empty records or does not bring dod
		residentResults := Doxie_Raw.Residents_Raw(seachAddr, 0, 0, 0, 'NONE', false, false, MaxRecordsToReturn);
		// Get the DL info
		DLRecs := dlSearch(PROJECT(residentResults, TRANSFORM(Doxie.Layout_References_hh, self.did := left.did)));
		// Get only 'Current' information
		sortedDLRecord := sort(DLRecs(History_Name='Current'), did, -expiration_date);
		FilteredDLRec := dedup(sortedDLRecord, did);
		// Now we got person and dl data time to pack those to person dataset 
		LayoutAddPersonalID XformBestRecords(residentResults L, DLRecs R) := TRANSFORM
			SELF.DID 													:= L.DID;
			SELF.name_first 									:= L.fname;
			SELF.name_middle 									:= L.mname;
			SELF.name_last 										:= L.lname;
			SELF.name_suffix 									:= L.name_suffix;
			SELF.ssn 													:= L.ssn;
			SELF.dt_first_seen 								:= L.dt_first_seen;
			SELF.dt_max_seen 									:= L.dt_last_seen;
			SELF.dod													:= 0; //DOD person are not returned from query
			SELF.dob													:= ut.Date_MMDDYYYY_I2((STRING)L.dob);
			SELF.currentDL.dlState 						:= r.orig_state;
			SELF.currentDL.dl_number 					:= r.dl_number;
			SELF.currentDL.lic_issue_date 		:= ut.Date_MMDDYYYY_I2((STRING)r.lic_issue_date);
			SELF.currentDL.expiration_date  	:= ut.Date_MMDDYYYY_I2((STRING)r.expiration_date);
			SELF.currentDL.restrictions 			:= r.restrictions_delimited;// This needs to be changed to get what is more appropriate
			SELF.currentDL.license_class  		:= r.license_class;
			SELF.currentDL.license_type 			:= r.license_type;
			SELF.gender 											:= r.sex_flag;
			SELF															:= [];
		END;
		PersonDataWithDL	:=	JOIN (residentResults, FilteredDLRec, LEFT.DID	= RIGHT.DID, 
																XformBestRecords(LEFT, RIGHT), LEFT OUTER);
		// Finaly time to map PersonDataWithDL tom input and prepare final result 
		LayoutAddResult MapInputDataToFinalResult (rec L) := TRANSFORM
			SELF.seq        									:= Seq_Value;
			SELF.currentAddress.prim_range		:= StreetNumber;
			SELF.currentAddress.addr					:= StreetName;
			SELF.currentAddress.unit					:= UnitNumber;
			SELF.currentAddress.city					:= city;
			SELF.currentAddress.state					:= state;
			SELF.currentAddress.zip						:= zip5;
			SELF.currentAddress.zip4					:= zip4;
			SELF.namesList										:= PersonDataWithDL;
			SELF.score												:= IF (EXISTS(PersonDataWithDL), 100, 0); // Store score 100 for hit 0 for nohit
			SELF															:= [];
		END;

		result := PROJECT (d, MapInputDataToFinalResult (LEFT));
		// output(residentResults, named('ResidentRecord'));
		// output(DLRecs, named('DLRecs'));
		// output(sortedDLRecord, named('sortedDLRecord'));
		// output(FilteredDLRec, named('FilteredDLRec'));
		// output(PersonDataWithDL, named('PersonalDatawithDL'));
		// output(result, named('MapInputDataToFinalResult'));
		RETURN result;
	END;
END;