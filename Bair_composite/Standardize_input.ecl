IMPORT bair,ut, mdr, tools, _validate, Address, Ut, lib_stringlib, _Control, business_header, Enclarity,
Header, Header_Slimsort, didville, ut, DID_Add, Business_Header_SS, NID, AID,STD;

EXPORT Standardize_input (string filedate='', boolean pUseProd = false, boolean pUseDelta = false) := MODULE

	EXPORT CFS_caller_addr                := 1;
	EXPORT CFS_complainant_addr           := 2;
	EXPORT CFS_Incident_addr              := 3;
	EXPORT Events_Mo_address_of_crime     := 4;
	EXPORT Events_Persons_persons_address := 6;
	EXPORT Events_Vehicle_vehicle_address := 8;
	EXPORT Offenders_                     := 10;
	EXPORT Crash_Incident                 := 11;
	EXPORT License_Plates                 := 12;
	EXPORT Crash_Person		                := 13;
	EXPORT Crash_Vehicle                  := 14;
	
	EXPORT CFS := FUNCTION	
			baseFile 					:= bair.Files(filedate, pUseProd,pUseDelta).cfs_Base.built;

			layouts.Base tMapping(baseFile L,  integer C) := TRANSFORM
						self.data_provider_id:=L.ori;
						self.data_provider_ori:=L.data_provider_ori;
						self.incident:=(string)L.cfs_id;
						self.orig_name:=L.complainant;
						self.Prepped_rec_type:=choose(C,CFS_caller_addr,CFS_complainant_addr,CFS_Incident_addr);
						self.orig_officer:=L.officer_name;
						self.orig_address:=choose(C
												,L.caller_address
												,if(L.complainant_address='',L.caller_address,L.complainant_address)
												,if(L.address=''            ,L.caller_address,L.address)
												);
						self.orig_City:=L.city;
						self.latitude:=(string)choose(C,L.complainant_y_coordinate,L.complainant_y_coordinate,L.y_coordinate);
						self.longitude:=(string)choose(C,L.complainant_x_coordinate,L.complainant_x_coordinate,L.x_coordinate);						
						self.crime:=trim(StringLib.StringCleanSpaces(STD.Str.ToUpperCase(L.initial_type)));
						self.phone:=L.clean_current_phone;
						self.dt_first_seen:=ut.min2(L.clean_date_occurred,L.clean_date_time_received);
						self.dt_last_seen:=ut.min2(L.clean_date_occurred,L.clean_date_time_received);
						self.class_code:=Bair.MapClassCodeNum(2,(string)L.initial_ucr_group);
						self.Sequence := Bair_composite.Sequence_Flag.fn_GetSequenceFlag(pUseDelta);
						SELF := L;
						SELF := [];
		END;

		dStd := NORMALIZE(baseFile, 3, tMapping(LEFT,counter));
		return dStd;
		
	END;
	
	EXPORT MO := FUNCTION	
			baseFile 					:= bair.Files(filedate, pUseProd,pUseDelta).mo_Base.built;

			layouts.Base tMapping(baseFile L) := TRANSFORM
						self.data_provider_id:=L.ori;
						self.incident:=L.ir_number;
						self.data_provider_ori:=L.data_provider_ori;
						self.Prepped_rec_type:=Events_Mo_address_of_crime;
						self.orig_address:=L.address_of_crime;
						self.orig_City:=L.city;
						self.orig_st:=L.state;
						self.orig_zip:=L.zip;
						self.dt_first_seen:=L.clean_First_Date_Time;
						self.dt_last_seen:=L.clean_Last_Date_Time;
						self.class_code:=Bair.MapClassCodeNum(1, (string)L.ucr_group);
						self.crime:=trim(StringLib.StringCleanSpaces(STD.Str.ToUpperCase(L.crime)));
						self.latitude:=(string)L.Y_Coordinate;
						self.longitude:=(string)L.X_Coordinate;
						self.Sequence := Bair_composite.Sequence_Flag.fn_GetSequenceFlag(pUseDelta);
						SELF := L;
						SELF := [];
		END;

		dStd := PROJECT(baseFile, tMapping(LEFT));
		return dStd;
		
	END;

	EXPORT Pers := FUNCTION	
			baseFile 					:= bair.Files(filedate, pUseProd,pUseDelta).persons_Base.built;
			
			layouts.Base tMapping(baseFile L) := TRANSFORM
					  self.lexid:=0;
						self.data_provider_id:=L.ori;
						self.data_provider_ori:=L.data_provider_ori;
						self.incident:=L.ir_number;
						self.Prepped_rec_type:=Events_Persons_persons_address;
						self.name_type:=L.name_type;
						self.orig_address:=L.persons_address;														
						self.orig_City:=L.city;
						self.orig_st:=L.state;
						self.orig_zip:=L.zip;
						self.age:=bair.fnAge((unsigned4)L.clean_dob);
						self.orig_moniker:=trim(L.moniker);
						self.name_hint:='FML';
						self.orig_name:=trim(StringLib.StringCleanSpaces(L.first_name+' '+L.middle_name+' '+L.last_name+' '+ut.fGetSuffix(L.moniker)),left,right);
						self.orig_gender:=L.sex;
						self.clean_gender:='';
						self.latitude:=(string)L.latitude;
						self.longitude:=(string)L.longitude;
						self.orig_sid:=L.persons_sid;
						self.dob:=(unsigned)L.clean_dob;
						self.Sequence := Bair_composite.Sequence_Flag.fn_GetSequenceFlag(pUseDelta);
						self := L;
						self := [];
				END;
				dStd := PROJECT(baseFile, tMapping(LEFT));
		return dStd;
	END;
	
	EXPORT veh := FUNCTION	
			baseFile 					:= bair.Files(filedate, pUseProd,pUseDelta).vehicle_Base.built;
			
			layouts.Base tMapping(baseFile L) := TRANSFORM
					  self.lexid:=0;
						self.data_provider_id:=L.ori;
						self.data_provider_ori:=L.data_provider_ori;
						self.incident:=L.ir_number;
						self.Prepped_rec_type:=Events_Vehicle_vehicle_address;
						self.orig_address:=L.vehicle_address;
						self.orig_City:=L.city;
						self.orig_st:=L.state;
						self.orig_zip:=L.zip;
						self.plate:=STD.Str.ToUpperCase(trim(L.plate));
						self.plate_st:=STD.Str.ToUpperCase(trim(L.plate_state));
						self.make:=STD.Str.ToUpperCase(trim(L.make));
						self.model:=STD.Str.ToUpperCase(trim(L.model));
						self.style:=STD.Str.ToUpperCase(trim(L.style));
						self.color:=STD.Str.ToUpperCase(trim(L.color));
						self.year:=L.year;
						self.latitude:=(string)L.latitude;
						self.longitude:=(string)L.longitude;
						self.Sequence := Bair_composite.Sequence_Flag.fn_GetSequenceFlag(pUseDelta);
						self := L;
						self := [];
				END;
				
				dStd := PROJECT(baseFile, tMapping(LEFT));
		return dStd;
	END;

	EXPORT OFFEN := FUNCTION	
			baseFile 					:= bair.Files(filedate, pUseProd,pUseDelta).offenders_Base.built;

			layouts.Base tMapping(baseFile L,  integer C) := TRANSFORM
						self.Prepped_rec_type:=Offenders_;
						self.lexid:=0;
						self.data_provider_id:=L.data_provider_id;
						self.data_provider_ori:=L.data_provider_ori;
						self.incident:=L.agency_offender_id;
						self.orig_address:=L.address;
						self.age:=choose(C
															,L.age_1
															,if(L.age_2=0,L.age_1,L.age_2)
															);
						self.orig_moniker:=trim(L.moniker);
						self.name_hint:='FML';
						self.orig_name:=trim(StringLib.StringCleanSpaces(L.first_name+' '+L.middle_name+' '+L.last_name+' '+ut.fGetSuffix(L.moniker)),left,right);
						self.dl:=L.dl_number;
						self.dl_st:=L.dl_state;
						self.dob:=(unsigned)L.clean_dob;
						self.crime:=trim(StringLib.StringCleanSpaces(STD.Str.ToUpperCase(L.classification_description)));
						self.orig_sid:=L.Offenders_sid;
						self.latitude:=(string)L.Y_coordinate;
						self.longitude:=(string)L.X_coordinate;
						self.dt_first_seen:=L.clean_user_datetime;
						self.dt_last_seen:=L.clean_user_datetime;
						self.class_code:=Bair.MapClassCodeNum(7,L.classification);
						self.Sequence := Bair_composite.Sequence_Flag.fn_GetSequenceFlag(pUseDelta);
						self:=L;
						self:=[];
				END;		
		dStd := NORMALIZE(baseFile, 2, tMapping(LEFT,counter));
		return dStd;
		
	END;

	EXPORT CRASH := FUNCTION	
			baseFile 					:= bair.Files(filedate, pUseProd,pUseDelta).crash_Base.built;
		
			layouts.Base tMapping(baseFile L,  Integer C) := TRANSFORM
						self.Prepped_rec_type:=choose(C,Crash_Incident,Crash_Person,Crash_Vehicle);
						self.lexid:=0;
						self.data_provider_id:=L.data_provider_id;
						self.data_provider_ori:=L.data_provider_ori;
						self.incident:=L.case_number;
						self.orig_address:=L.address;
						self.orig_city:=L.crash_city;
						self.orig_st:=L.crash_state;
						self.orig_officer:=L.officername;
						self.name_hint:='FML';
						self.orig_name:=Choose(C,'',trim(StringLib.StringCleanSpaces(L.first_name+' '+L.last_name),left,right),'');
						self.dt_first_seen:=L.clean_Report_Date;
						self.dt_last_seen:=L.clean_Report_Date;
						self.class_code:=Bair.MapClassCodeNum(3,L.crashType);
						self.age:=Choose(C,0,L.age,0);
						self.dl:=Choose(C,'',STD.Str.ToUpperCase(trim(L.licensenumber)),'');
						self.dl_st:=Choose(C,'',STD.Str.ToUpperCase(trim(L.licensestate)),'');
						self.vin:=Choose(C,'','',STD.Str.ToUpperCase(trim(L.vin)));
						self.plate:=Choose(C,'','',STD.Str.ToUpperCase(trim(L.plate)));
						self.plate_st:=Choose(C,'','',STD.Str.ToUpperCase(trim(L.platestate)));
						self.year:=Choose(C,'','',L.year);
						self.make:=Choose(C,'','',STD.Str.ToUpperCase(trim(L.make)));
						self.model:=Choose(C,'','',STD.Str.ToUpperCase(trim(L.model)));
						self.vehicleid:=Choose(C,0,L.vehicleid,L.vehicleid);
						self.latitude:=(string)L.Y;
						self.longitude:=(string)L.X;
						self.Sequence := Bair_composite.Sequence_Flag.fn_GetSequenceFlag(pUseDelta);
						self:=L;
						self:=[];
					END;
				
				dStd := dedup(sort(Normalize(baseFile,3, tMapping(LEFT,counter)),record,except Prepped_rec_type,vehicleid),record,except Prepped_rec_type,vehicleid);
		return dStd;
	END;
	
	EXPORT LPR := FUNCTION	
			baseFile 					:= bair.Files(filedate, pUseProd,pUseDelta).LPR_Base.built;
		
			layouts.Base tMapping(baseFile L) := TRANSFORM
						self.Prepped_rec_type:=License_Plates;
						self.data_provider_ori:=L.data_provider_ori;
						self.dt_first_seen:=L.clean_CaptureDateTime;
						self.dt_last_seen:=L.clean_CaptureDateTime;
						self.plate:=L.plate;
						self.latitude:=(string)L.Y_Coordinate;
						self.longitude:=(string)L.X_Coordinate;
						self.class_code:=600;
						self.Sequence := Bair_composite.Sequence_Flag.fn_GetSequenceFlag(pUseDelta);
						self:=L;
						self:=[];
					END;
				
				dStd := PROJECT(baseFile, tMapping(LEFT));
		return dStd;
	END;	
						
END;
