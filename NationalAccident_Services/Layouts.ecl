import Autokey_batch,iesp;

EXPORT Layouts := MODULE
		EXPORT inBatchNationalAccident := 
			RECORD
				Autokey_batch.Layouts.rec_inBatchMaster;
				unsigned4 AccidentDate;
		END;
		Export tmpBatchNationalAccident_Slim := 
			RECORD
				string65 ReportDescription;
				string40 AccidentId;
				string8 AccidentDate;
				string25 City;
				string2 State;
				string22 VIN;
		end;
		Export tmpBatchNationalAccident := 
			RECORD
				STRING30  acctno             				  := '';
				dataset(tmpBatchNationalAccident_Slim) accidents;
		end;

		EXPORT outBatchNationalAccident := 
			RECORD
				STRING30  acctno             				  := '';
				unsigned8 seq 												:= 0;
				UNSIGNED1 search_status     			    := 0;
				STRING10  matchCode		    			      := '';
				string65 	ReportDescription						:='';
				string40 	AccidentId									:='';
				string8 	AccidentDate								:='';
				string25 	AccidentCity								:='';
				string2 	AccidentState								:='';
				string20 	DriverFirst_1								:='';
				string20 	DriverMiddle_1							:='';
				string20 	DriverLast_1								:='';
				string5 	DriverSuffix_1							:='';
				string20 	Owner1First_1								:='';
				string20 	Owner1Middle_1							:='';
				string20 	Owner1Last_1								:='';
				string5 	Owner1Suffix_1							:='';
				string62 	Owner1Full_1								:='';
				string20 	Owner2First_1								:='';
				string20 	Owner2Middle_1							:='';
				string20 	Owner2Last_1								:='';
				string5 	Owner2Suffix_1							:='';
				string62 	Owner2Full_1								:='';
				string10 	StreetNumber_1							:='';
				string2	 	StreetPreDirection_1				:='';
				string28	StreetName_1								:='';
				string4		StreetSuffix_1							:='';
				string2 	StreetPostDirection_1				:='';
				string10 	UnitDesignation_1						:='';
				string8 	UnitNumber_1								:='';
				string60 	StreetAddress_1							:='';
				string25 	City_1											:='';
				string2 	State_1											:='';
				string5 	Zip5_1											:='';
				integer2 	Veh_Year_1     				    	:= 0;
				string20 	Veh_Make_1									:='';
				string25 	Veh_Model_1									:='';
				string22 	Veh_VIN_1										:='';
				string30 	Veh_DamageLocation_1				:='';
				string20 	DriverFirst_2								:='';
				string20 	DriverMiddle_2							:='';
				string20 	DriverLast_2								:='';
				string5 	DriverSuffix_2							:='';
				string20 	Owner1First_2								:='';
				string20 	Owner1Middle_2							:='';
				string20 	Owner1Last_2								:='';
				string5 	Owner1Suffix_2							:='';
				string62 	Owner1Full_2								:='';
				string20 	Owner2First_2								:='';
				string20 	Owner2Middle_2							:='';
				string20 	Owner2Last_2								:='';
				string5 	Owner2Suffix_2							:='';
				string62 	Owner2Full_2								:='';
				string10 	StreetNumber_2							:='';
				string2	 	StreetPreDirection_2				:='';
				string28	StreetName_2								:='';
				string4		StreetSuffix_2							:='';
				string2 	StreetPostDirection_2				:='';
				string10 	UnitDesignation_2						:='';
				string8 	UnitNumber_2								:='';
				string60 	StreetAddress_2							:='';
				string25 	City_2											:='';
				string2 	State_2											:='';
				string5 	Zip5_2											:='';
				integer2 	Veh_Year_2  	   			    	:= 0;
				string20 	Veh_Make_2									:='';
				string25 	Veh_Model_2									:='';
				string22 	Veh_VIN_2										:='';
				string30 	Veh_DamageLocation_2				:='';
			END;
			
END;	// MODULE
