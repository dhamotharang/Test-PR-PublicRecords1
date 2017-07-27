import AutoStandardI,Accident_Services,iesp,FLAccidents_eCrash,ut,codes;
EXPORT Transforms := MODULE
	export NationalAccident_Services.Layouts.tmpBatchNationalAccident BatchProcessing(
	NationalAccident_Services.Layouts.inBatchNationalAccident srcBy,
	unsigned2 MaxResultsPerAcct, boolean ECrashAccidents) := TRANSFORM
		searchBy :=  module(project(AutoStandardI.GlobalModule(),Accident_Services.IParam.searchrecords,opt))
				export string20	acctno := srcBy.acctno;
				export unsigned8 seq := srcBy.seq;
				export string40 Accident_Number := '';
				export string2  Accident_State  := '';
				export string8 Tag_Number       := '';
				export string30	firstname				:= srcBy.name_first;
				export string30 middlename			:= srcBy.name_middle;
				export string30	lastname				:= srcBy.name_last;
				export string4	suffix					:= srcBy.name_suffix;
				export boolean  EnableNationalAccidents := true;
				export boolean  EnableExtraAccidents := ECrashAccidents;
				export string30 VIN := srcBy.vin;
				export string10 ReportType := srcBy.searchType;
				export string11 SSN := srcBy.ssn;
				export string24 DriverLicenseNumber := srcBy.dl;
				export string2 DriverLicenseState := srcBy.dlstate;
				export string10 prim_range := srcBy.prim_range;
				export string2 predir := srcBy.predir;
				export string28 prim_name := srcBy.prim_name;
				export string4 addr_suffix := srcBy.addr_suffix;
				export string2 postdir := srcBy.postdir;
				export string10 unit_desig := srcBy.unit_desig;
				export string8 sec_range := srcBy.sec_range;
				export string25 city := srcBy.p_city_name;
				export string2 state := srcBy.st;
				export string5 z5 := srcBy.z5;
				export unsigned8 dob := (Integer)srcBy.dob;
				export String10 Plate := '';
				export String2 PlateState := '';
				export unsigned4 AccidentDate := srcBy.AccidentDate;
				export string32 applicationType := Accident_Services.Constants.claimsApplicationType;
		end;
		results := Accident_Services.Report_Records.vertical(searchBy);
		self.acctno 										:= srcBy.acctno;
		self.accidents									:= project(choosen(results,MaxResultsPerAcct),
																						transform(NationalAccident_Services.Layouts.tmpBatchNationalAccident_Slim,
																											self.ReportDescription:=  left.ReportDescription,
																											self.AccidentId:=  left.AccidentId,
																											self.AccidentDate:=  iesp.ECL2ESP.t_DateToString8(left.AccidentDate),
																											self.City:=  left.Location.City,
																											self.State:=  left.Location.State,
																											self.VIN:=  left.vehicles[1].VIN
																											));
end;

	export NationalAccident_Services.Layouts.outBatchNationalAccident xformFlatten(NationalAccident_Services.Layouts.tmpBatchNationalAccident recs, integer c) := transform
		accNbrs1:=FLAccidents_eCrash.Key_eCrashV2_vin(l_vin=choose(c,recs.accidents[c].VIN) and (integer)accident_nbr=(integer)choose(c,recs.accidents[c].AccidentId));
		owners1:= JOIN(accNbrs1,FLAccidents_eCrash.Key_eCrash2v,KEYED(LEFT.accident_nbr=RIGHT.l_acc_nbr) and right.vehicle_id_nbr=choose(c,recs.accidents[c].VIN),LIMIT(0),KEEP(10000));
		driver1:= JOIN(accNbrs1,FLAccidents_eCrash.Key_eCrash4,KEYED(LEFT.accident_nbr=RIGHT.l_acc_nbr) and right.section_nbr=owners1[1].section_nbr,LIMIT(0),KEEP(10000));
		owners2:= JOIN(accNbrs1,FLAccidents_eCrash.Key_eCrash2v,KEYED(LEFT.accident_nbr=RIGHT.l_acc_nbr) and right.vehicle_id_nbr!=choose(c,recs.accidents[c].VIN),LIMIT(0),KEEP(10000));
		driver2:= JOIN(accNbrs1,FLAccidents_eCrash.Key_eCrash4,KEYED(LEFT.accident_nbr=RIGHT.l_acc_nbr) and right.section_nbr=owners2[1].section_nbr,LIMIT(0),KEEP(10000));
		self.acctno 										:= recs.acctno;
		self.seq												:= c;
		self.search_status     			    := 0;
		self.matchCode		    			    := '';
		self.ReportDescription					:= choose(c,recs.accidents[c].ReportDescription);
		self.AccidentId									:= choose(c,recs.accidents[c].AccidentId);
		self.AccidentDate								:= choose(c,recs.accidents[c].AccidentDate);
		self.AccidentCity								:= choose(c,recs.accidents[c].City);
		self.AccidentState							:= choose(c,recs.accidents[c].State);
		self.DriverFirst_1							:=driver1[1].fname;
		self.DriverMiddle_1							:=driver1[1].mname;
		self.DriverLast_1								:=driver1[1].lname;
		self.DriverSuffix_1							:=driver1[1].suffix;
		self.Owner1First_1							:=owners1[1].fname;
		self.Owner1Middle_1							:=owners1[1].mname;
		self.Owner1Last_1								:=owners1[1].lname;
		self.Owner1Suffix_1							:=owners1[1].suffix;
		self.Owner1Full_1								:=owners1[1].vehicle_owner_name;
		self.Owner2First_1							:=owners1[2].fname;
		self.Owner2Middle_1							:=owners1[2].mname;
		self.Owner2Last_1								:=owners1[2].lname;
		self.Owner2Suffix_1							:=owners1[2].suffix;
		self.Owner2Full_1								:=owners1[2].vehicle_owner_name;;
		self.StreetNumber_1							:=owners1[1].prim_range;
		self.StreetPreDirection_1				:=owners1[1].predir;
		self.StreetName_1								:=owners1[1].prim_name;
		self.StreetSuffix_1							:=owners1[1].addr_suffix;
		self.StreetPostDirection_1			:=owners1[1].postdir;
		self.UnitDesignation_1					:=owners1[1].unit_desig;
		self.UnitNumber_1								:=owners1[1].sec_range;
		self.StreetAddress_1						:=if(owners1[1].err_stat[1]='E',owners1[1].vehicle_owner_st_city,'');
		self.City_1											:=owners1[1].p_city_name;
		self.State_1										:=if(owners1[1].err_stat[1]='E',owners1[1].vehicle_owner_st,owners1[1].st);
		self.Zip5_1											:=owners1[1].zip;
		self.Veh_Year_1     				    :=(Integer)owners1[1].Model_Year;
		self.Veh_Make_1									:=owners1[1].Make_description;
		self.Veh_Model_1								:=owners1[1].Model_description;
		self.Veh_VIN_1									:=owners1[1].Vehicle_ID_NBR;
		self.Veh_DamageLocation_1				:=if(ut.isNumeric(owners1[1].point_of_impact),codes.KeyCodes('FLCRASH2_VEHICLE','POINT_OF_IMPACT','',owners1[1].point_of_impact),owners1[1].point_of_impact);
		self.DriverFirst_2							:=driver2[1].fname;
		self.DriverMiddle_2							:=driver2[1].mname;
		self.DriverLast_2								:=driver2[1].lname;
		self.DriverSuffix_2							:=driver2[1].suffix;
		self.Owner1First_2							:=owners2[1].fname;
		self.Owner1Middle_2							:=owners2[1].mname;
		self.Owner1Last_2								:=owners2[1].lname;
		self.Owner1Suffix_2							:=owners2[1].suffix;
		self.Owner1Full_2								:=owners2[1].vehicle_owner_name;
		self.Owner2First_2							:=if(owners2[1].accident_nbr = owners2[2].accident_nbr,owners2[2].fname,'');
		self.Owner2Middle_2							:=if(owners2[1].accident_nbr = owners2[2].accident_nbr,owners2[2].mname,'');
		self.Owner2Last_2								:=if(owners2[1].accident_nbr = owners2[2].accident_nbr,owners2[2].lname,'');
		self.Owner2Suffix_2							:=if(owners2[1].accident_nbr = owners2[2].accident_nbr,owners2[2].suffix,'');
		self.Owner2Full_2								:=if(owners2[1].accident_nbr = owners2[2].accident_nbr,owners2[2].vehicle_owner_name,'');
		self.StreetNumber_2							:=owners2[1].prim_range;
		self.StreetPreDirection_2				:=owners2[1].predir;
		self.StreetName_2								:=owners2[1].prim_name;
		self.StreetSuffix_2							:=owners2[1].addr_suffix;
		self.StreetPostDirection_2			:=owners2[1].postdir;
		self.UnitDesignation_2					:=owners2[1].unit_desig;
		self.UnitNumber_2								:=owners2[1].sec_range;
		self.StreetAddress_2						:=if(owners2[1].err_stat[1]='E',owners2[1].vehicle_owner_st_city,'');
		self.City_2											:=owners2[1].p_city_name;
		self.State_2										:=if(owners2[1].err_stat[1]='E',owners2[1].vehicle_owner_st,owners2[1].st);
		self.Zip5_2											:=owners2[1].zip;
		self.Veh_Year_2     				    :=(Integer)owners2[1].Model_Year;
		self.Veh_Make_2									:=owners2[1].Make_description;
		self.Veh_Model_2								:=owners2[1].Model_description;
		self.Veh_VIN_2									:=owners2[1].Vehicle_ID_NBR;
		self.Veh_DamageLocation_2				:=if(ut.isNumeric(owners2[1].point_of_impact),codes.KeyCodes('FLCRASH2_VEHICLE','POINT_OF_IMPACT','',owners2[1].point_of_impact),owners2[1].point_of_impact);
	end;
	
End;