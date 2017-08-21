IMPORT bair,ut;
EXPORT Update_Input := MODULE
	
	
	EXPORT MAC_EventMosExt( EVENT_MO_input, pGeoMos, pUseProd = false, pUseDelta = false ) := FUNCTIONMACRO  

		IMPORT bair,ut,STD,address,_Validate;
	
		
		time := ut.getTime();
		date := ut.GetDate;
		v_edit_date := date[1..4] + '-' + date[5..6] + '-' + date[7..8] + ' ' + time[1..2] + ':' + time[3..4] + ':' + time[5..6] + '.000';

		dp  := bair.files().DataProvider_Base.Built(); 
		layouts.event_dbo_mo_In_extended DataProvider_T (EVENT_MO_input L, dp R) := TRANSFORM
			SELF.recordID_RAIDS := 		0;
			SELF.Duration := (UNSIGNED4)L.Duration;
			SELF.Sequence := (UNSIGNED4)L.Sequence;
			SELF.Interval := (real8)L.Interval;
			SELF.Commonalities := (UNSIGNED4)L.Commonalities;
			SELF.MOSTAMP := (UNSIGNED4)L.MOSTAMP;
			SELF.T_Coordinate := (REAL8)L.T_Coordinate;
			SELF.UCR_Group := 26;
			SELF.ORI := (UNSIGNED4) L.ORI; 	
			SELF.Projected_X := (real8) L.Projected_X;
			SELF.Projected_Y := (real8) L.Projected_Y;
			SELF.Citizen_Observer_ID := (UNSIGNED4) L.Citizen_Observer_ID;
			SELF.group_id := (UNSIGNED4) L.group_id;
			SELF.incidentID := (UNSIGNED4) L.incidentID;
			SELF.First_Time := (UNSIGNED4) L.First_Time;	
			SELF.Last_Date := if (L.Last_Date='',L.First_Date, L.Last_Date);		
			SELF.Last_Date_Time := if (L.Last_Date_Time='',L.First_Date_Time, L.Last_Date_Time);	
			SELF.Last_Time := (UNSIGNED4) if (L.Last_Time='',L.First_Time, L.Last_Time);		
			SELF.import_instance_id := (UNSIGNED4) L.import_instance_id;
			SELF.x_coordinate := (real8)L.x_coordinate;
			SELF.y_coordinate := (real8)L.y_coordinate;
			SELF.X_Offset := (real8)L.X_Offset;
			SELF.Y_Offset := (real8)L.Y_Offset;
			SELF.Accuracy_code := (unsigned1)L.accuracy;
			SELF.mo_udf_1 := regexreplace( '[^0-9a-zA-Z]+',trim(L.mo_udf_1, LEFT, RIGHT), '');				
			SELF.mo_udf_2 := regexreplace( '[^0-9a-zA-Z]+',trim(L.mo_udf_2, LEFT, RIGHT), '');				
			SELF.mo_udf_3 := regexreplace( '[^0-9a-zA-Z]+',trim(L.mo_udf_3, LEFT, RIGHT), '');				
			SELF.mo_udf_4 := regexreplace( '[^0-9a-zA-Z]+',trim(L.mo_udf_4, LEFT, RIGHT), '');				
			SELF.mo_udf_5 := regexreplace( '[^0-9a-zA-Z]+',trim(L.mo_udf_5, LEFT, RIGHT), '');				
			SELF.mo_udf_6 := regexreplace( '[^0-9a-zA-Z]+',trim(L.mo_udf_6, LEFT, RIGHT), '');				
			SELF.mo_udf_7 := regexreplace( '[^0-9a-zA-Z]+',trim(L.mo_udf_7, LEFT, RIGHT), '');		
			SELF.mo_udf_8 := regexreplace( '[^0-9a-zA-Z]+',trim(L.mo_udf_8, LEFT, RIGHT), '');																													
			SELF.X_Offset_Min := R.X_Offset_Min;
			SELF.X_Offset_Max	:= R.X_Offset_Max;
			SELF.Y_Offset_Min	:= R.Y_Offset_Min;
			SELF.Y_Offset_Max	:= R.Y_Offset_Max;																										
			SELF.boundingBoxSouthWestLat 	:= 0;
			SELF.boundingBoxSouthWestLong	:= 0;
			SELF.boundingBoxNorthEastLat	:= 0;
			SELF.boundingBoxNorthEastLong	:= 0;			
			SELF.quarantine_code := 0;
			SELF.offsettype := 0;
			SELF :=	L;
		END;
		
		DataProvider := join(EVENT_MO_input, 
							 dp, 
							left.ORI = right.data_provider_id, 
							DataProvider_T(LEFT,RIGHT),
							left outer,
							LOOKUP);

		dpl := Bair.files().DataProviderLoc_Base.built();
		layouts.event_dbo_mo_In_extended DataProvider_Loc_T (DataProvider L, dpl R) := TRANSFORM
			SELF.boundingBoxSouthWestLat 	:= R.boundingBoxSouthWestLat;
			SELF.boundingBoxSouthWestLong	:= R.boundingBoxSouthWestLong;
			SELF.boundingBoxNorthEastLat	:= R.boundingBoxNorthEastLat;
			SELF.boundingBoxNorthEastLong	:= R.boundingBoxNorthEastLong;			
			SELF :=	L;
		END;
		
		DataProvider_Loc := join(DataProvider, 
							 dpl, 
							left.ORI = right.dataproviderid, 
							DataProvider_Loc_T(LEFT,RIGHT),
							left outer,
							LOOKUP);		
							
		acl := distribute(bair.files().AgencyCrimeLookup_Base.built, hash(dataproviderid));
		
		layouts.event_dbo_mo_In_extended AgencyCrimeLookup_T (DataProvider_Loc L, acl R) := TRANSFORM
			SELF.offsetType 	:= R.offsetType;
			SELF :=	L;
		END;
		
		AgencyCrimeLookup_Base := join(distribute(DataProvider_Loc, hash(ori)), 
							 acl, 
							left.ORI = right.dataproviderid and STD.Str.ToLowerCase(LEFT.crime) = STD.Str.ToLowerCase(RIGHT.crime), 
							AgencyCrimeLookup_T(LEFT,RIGHT),
							left outer,
							keep(1),
							local);		
							
		AddressCache  := dedup(files().baseLNAddressCache.built(ac_x_coordinate != 0 and ac_y_coordinate != 0) + pGeoMos, all);					

		layouts.event_dbo_mo_In_extended temp_mos (AgencyCrimeLookup_Base L, layouts.address_cache R, integer C) := TRANSFORM

			provided_by_agency := IF (L.x_coordinate != 0 and L.y_coordinate != 0, TRUE, FALSE);
			
			x_coordinate 	:= if(provided_by_agency,L.x_coordinate,R.ac_x_coordinate);
			y_coordinate 	:= if(provided_by_agency,L.y_coordinate,R.ac_y_coordinate);
			accuracy := if(provided_by_agency,(unsigned1)L.Accuracy_code,(unsigned1) R.ac_accuracy);		
			Accuracy_code := if(provided_by_agency,L.accuracy_code,(unsigned1) R.ac_accuracy);	
			geocoded := if(provided_by_agency,L.geocoded, R.ac_geocoded);

			SELF.Address_of_Crime_Clean := R.ac_clean_address_182;
			SELF.X_Coordinate := x_coordinate;
			SELF.Y_Coordinate := y_coordinate;
			SELF.Accuracy_code := Accuracy_code;
 			SELF.geocoded := geocoded;
			
			first_date 	:= ut.DateTimeToYYYYMMDD((string)trim(stringlib.stringfilterout(L.First_Date,'.>$!%*@=?&\''),left,right)); 
			last_date 	:= ut.DateTimeToYYYYMMDD((string)trim(stringlib.stringfilterout(L.Last_Date,	'.>$!%*@=?&\''),left,right)); 
			Unsigned4 lTestFlags := _Validate.Date.Rules.Optional | _Validate.Date.Rules.YearValid 	| _Validate.Date.Rules.MonthValid 	| _Validate.Date.Rules.DayValid;		
			
			SELF.quarantine_code := map(
						first_date = '' => 1, 	//-- MO	First Date time and time missing
						_Validate.Date.fIsValid(first_date, lTestFlags,false,false)=false 		=> 4, 	//-- MO	Invalid date string or MO First Date Time before 1900
						L.Last_Date != '' and first_date > last_date => 15,	//-- MO First Date after Last Date
						L.Last_Date != '' and first_date = last_date and (unsigned)L.last_time  != 0 and (unsigned)L.first_time > (unsigned)L.last_time => 5,		//-- MO	First Date Time after Last Date Time
						L.Last_Date != '' and last_date > (string8)std.date.today() => 6,		//-- MO	Future Last Date
						L.Last_Date != '' and last_date = (string8)std.date.today() and (unsigned)L.last_time  != 0  and (unsigned)L.last_time > (unsigned)Std.Date.SecondsToString(Std.date.CurrentSeconds(true), '%H%M%S')[1..4]	=> 7,		//-- MO Future Last Date Time
						L.Last_Date != '' and _Validate.Date.fIsValid(last_date,lTestFlags,false,false)=false => 11,	//-- MO Last Date Time before 1900
						first_date = (string8)std.date.today() and (unsigned)L.first_time > (unsigned)Std.Date.SecondsToString(Std.date.CurrentSeconds(true), '%H%M%S')[1..4]	=> 17,	//-- MO Future First Date Time
						x_coordinate = 0 and y_coordinate = 0  and L.Address_of_Crime = '' => 10,	//-- MO Missing address
						(x_coordinate = 0 or y_coordinate = 0) and L.Address_of_Crime != '' => 12,	//-- MO Unknown address
						accuracy > 0 and accuracy < 6 => 3,   //-- MO	Low Accuracy*
						x_coordinate != 0 and y_coordinate != 0 and ((L.Boundingboxsouthwestlat > y_coordinate) or (L.Boundingboxnortheastlat < y_coordinate) or (L.Boundingboxsouthwestlong > x_coordinate) or (L.boundingboxnortheastlong < x_coordinate)) => 13, 	//-- MO Out of bounds*
						0);	
						
			SELF.Quarantined := if(SELF.quarantine_code=0,'0','1');			
			
			SELF.X_Offset := map(L.offsettype = 1 => (real8) Validate_Input.CalculateOffset(L.x_offset_min, L.x_offset_max),
													 L.offsettype = 2 => (real8) Validate_Input.findNearestIntersection(L.ORI, (REAL8)R.ac_x_coordinate, (REAL8)R.ac_y_coordinate)[1].deltax,
													(real8)L.X_Offset);
			SELF.Y_Offset := map(L.offsettype = 1 => (real8) Validate_Input.CalculateOffset(L.y_offset_min, L.y_offset_max),
													 L.offsettype = 2 => (real8) Validate_Input.findNearestIntersection(L.ORI, (REAL8)R.ac_x_coordinate, (REAL8)R.ac_y_coordinate)[1].deltay,
													(real8)L.Y_Offset);		
			SELF := L;
		END;
		
		mo := join(distribute(AgencyCrimeLookup_Base, hash(ori)), 
							 distribute(AddressCache, hash(ac_dataProviderID)), 
							left.ORI = right.ac_dataProviderID and ut.CleanSpacesAndUpper(left.address_of_Crime) = ut.CleanSpacesAndUpper(right.ac_address), 
							temp_mos(LEFT,RIGHT,COUNTER),
							left outer,
							local);

	 INTEGER last_recordID_RAIDS := Validate_Input.fn_GetMORecordID(true):INDEPENDENT;

		layouts.event_dbo_mo_In_extended AddRecordID_RAIDS(layouts.event_dbo_mo_In_extended L, integer C) := transform
				SELF.recordID_RAIDS := last_recordID_RAIDS + C;
				self := L;
		end;
		
		mo_recordid_raids := project(mo, AddRecordID_RAIDS(left, counter));

		//Code to calculate mostamp and ucr_group in mo
    CrimeTypes 			:= Bair.Files().AgencyCrimeLookup_Base.built;
		Classfications  := bair.files().event_helper_ucr_group_classifications_input;
				
		map_crimetypes_class := join(CrimeTypes, Classfications, ut.CleanSpacesAndUpper(left.type) = ut.CleanSpacesAndUpper(right.name), lookup);
		
		{mo, UNSIGNED4 	severity} AddUCR_group(mo_recordid_raids l, map_crimetypes_class r) := transform
				self.UCR_Group := r.ucr_group_id;
				self.DoNotImport := if(l.ori = r.dataproviderid and r.visibility = 0, TRUE, FALSE);
				self.severity := r.severity;
				self := l;
		end;
										
		mo_t := join(mo_recordid_raids
								,map_crimetypes_class
								,left.ori = right.dataproviderid and ut.CleanSpacesAndUpper(left.crime) = ut.CleanSpacesAndUpper(right.crime)
								,AddUCR_group(left, right)
								,left outer
								,lookup
								);
																																										
		SortedSet  := SORT(mo_t, ori, ir_number, severity, local);
		GroupedSet := GROUP(SortedSet, ori, ir_number);
		
		GroupedSet AddStamp(GroupedSet L, integer C) := transform
				self.mostamp := C - 1;
				self := L;
		end;
		
		importer_mo := project(GroupedSet, AddStamp(left, counter));
		p1 := project(UNGROUP(importer_mo), {mo});

		//block full event if one of the crimes is marked as donotimport
		donotimport := p1(donotimport = true);
		
		p1 DoNotImportFullEvent(p1 l, donotimport r) := transform
			self.donotimport := if(r.donotimport = true, true, l.donotimport);
			self := l;
		end;
		
		p2 := dedup(join(p1
								,donotimport
								,left.ori = right.ori and left.ir_number = right.ir_number
								,DoNotImportFullEvent(left, right)
								,left outer
								,LOOKUP
								), record, all);
	
		RETURN p2;
		
	ENDMACRO;
	
	EXPORT MAC_EventMos(pMosExt) := FUNCTIONMACRO 
		Mos :=  project(pMosExt,layouts.event_dbo_mo_In_extended - [quarantine_code,mo_udf_1,mo_udf_2,mo_udf_3,mo_udf_4,mo_udf_5,mo_udf_6,mo_udf_7,mo_udf_8]);
		return dedup(Mos,all);
	ENDMACRO;
	
	
	EXPORT MAC_EventMosUDF(pMos) := FUNCTIONMACRO
	
		bair.layouts.event_dbo_mo_udf_In temp_mo_udf (layouts.event_dbo_mo_In_extended L, UNSIGNED2 ctr) := TRANSFORM
			self.id													:= 		0;
			self.recordID_RAIDS							:= 		L.recordID_RAIDS;
			self.ir_number									:= 		L.ir_number;
			self.ORI												:= 		(UNSIGNED4)L.ORI;
			self.fieldId										:= 		ctr;
			
			v_mo_udf_1 := trim(L.mo_udf_1, left, right);
			v_mo_udf_2 := trim(L.mo_udf_2, left, right);
			v_mo_udf_3 := trim(L.mo_udf_3, left, right);
			v_mo_udf_4 := trim(L.mo_udf_4, left, right);
			v_mo_udf_5 := trim(L.mo_udf_5, left, right);
			v_mo_udf_6 := trim(L.mo_udf_6, left, right);
			v_mo_udf_7 := trim(L.mo_udf_7, left, right);
			v_mo_udf_8 := trim(L.mo_udf_8, left, right);
			
			integer_pattern 	:= '^[0-9]*$';
			real_pattern			:= '^[0-9]*\\.[0-9]*$';
			datetime_pattern	:= '^([0-9]+)-+([0-9]+)-+([0-9])+(\\s+([0-9]+):+([0-9]+):+([0-9]+)(\\.([0-9]+))?)?$';
			yes_no_pattern		:= '^(true|false|yes|no)$';
			
			self.string_val									:= 		choose(ctr,	
																												if (~regexfind(integer_pattern,v_mo_udf_1) and ~regexfind(real_pattern,v_mo_udf_1) and ~regexfind(datetime_pattern,v_mo_udf_1) and ~regexfind(yes_no_pattern,v_mo_udf_1,NOCASE), v_mo_udf_1, ''),
																												if (~regexfind(integer_pattern,v_mo_udf_2) and ~regexfind(real_pattern,v_mo_udf_2) and ~regexfind(datetime_pattern,v_mo_udf_2) and ~regexfind(yes_no_pattern,v_mo_udf_2,NOCASE), v_mo_udf_2, ''),
																												if (~regexfind(integer_pattern,v_mo_udf_3) and ~regexfind(real_pattern,v_mo_udf_3) and ~regexfind(datetime_pattern,v_mo_udf_3) and ~regexfind(yes_no_pattern,v_mo_udf_3,NOCASE), v_mo_udf_3, ''),
																												if (~regexfind(integer_pattern,v_mo_udf_4) and ~regexfind(real_pattern,v_mo_udf_4) and ~regexfind(datetime_pattern,v_mo_udf_4) and ~regexfind(yes_no_pattern,v_mo_udf_4,NOCASE), v_mo_udf_4, ''),
																												if (~regexfind(integer_pattern,v_mo_udf_5) and ~regexfind(real_pattern,v_mo_udf_5) and ~regexfind(datetime_pattern,v_mo_udf_5) and ~regexfind(yes_no_pattern,v_mo_udf_5,NOCASE), v_mo_udf_5, ''),
																												if (~regexfind(integer_pattern,v_mo_udf_6) and ~regexfind(real_pattern,v_mo_udf_6) and ~regexfind(datetime_pattern,v_mo_udf_6) and ~regexfind(yes_no_pattern,v_mo_udf_6,NOCASE), v_mo_udf_6, ''),
																												if (~regexfind(integer_pattern,v_mo_udf_7) and ~regexfind(real_pattern,v_mo_udf_7) and ~regexfind(datetime_pattern,v_mo_udf_7) and ~regexfind(yes_no_pattern,v_mo_udf_7,NOCASE), v_mo_udf_7, ''),
																												if (~regexfind(integer_pattern,v_mo_udf_8) and ~regexfind(real_pattern,v_mo_udf_8) and ~regexfind(datetime_pattern,v_mo_udf_8) and ~regexfind(yes_no_pattern,v_mo_udf_8,NOCASE), v_mo_udf_8, '')
																										);
			self.integer_val								:= 		(integer)choose(ctr,	
																												if (regexfind(integer_pattern,v_mo_udf_1),v_mo_udf_1,'0'),
																												if (regexfind(integer_pattern,v_mo_udf_2),v_mo_udf_2,'0'),
																												if (regexfind(integer_pattern,v_mo_udf_3),v_mo_udf_3,'0'),
																												if (regexfind(integer_pattern,v_mo_udf_4),v_mo_udf_4,'0'),
																												if (regexfind(integer_pattern,v_mo_udf_5),v_mo_udf_5,'0'),
																												if (regexfind(integer_pattern,v_mo_udf_6),v_mo_udf_6,'0'),
																												if (regexfind(integer_pattern,v_mo_udf_7),v_mo_udf_7,'0'),
																												if (regexfind(integer_pattern,v_mo_udf_8),v_mo_udf_8,'0')
																										);
			self.decimal_val								:= 		(real8)choose(ctr,	
																												if (regexfind(real_pattern,v_mo_udf_1),v_mo_udf_1,'0.0'),
																												if (regexfind(real_pattern,v_mo_udf_2),v_mo_udf_2,'0.0'),
																												if (regexfind(real_pattern,v_mo_udf_3),v_mo_udf_3,'0.0'),
																												if (regexfind(real_pattern,v_mo_udf_4),v_mo_udf_4,'0.0'),
																												if (regexfind(real_pattern,v_mo_udf_5),v_mo_udf_5,'0.0'),
																												if (regexfind(real_pattern,v_mo_udf_6),v_mo_udf_6,'0.0'),
																												if (regexfind(real_pattern,v_mo_udf_7),v_mo_udf_7,'0.0'),
																												if (regexfind(real_pattern,v_mo_udf_8),v_mo_udf_8,'0.0')
																										);
			self.datetime_val								:= 		choose(ctr,	
																												if (regexfind(datetime_pattern,v_mo_udf_1),v_mo_udf_1,''),
																												if (regexfind(datetime_pattern,v_mo_udf_2),v_mo_udf_2,''),
																												if (regexfind(datetime_pattern,v_mo_udf_3),v_mo_udf_3,''),
																												if (regexfind(datetime_pattern,v_mo_udf_4),v_mo_udf_4,''),
																												if (regexfind(datetime_pattern,v_mo_udf_5),v_mo_udf_5,''),
																												if (regexfind(datetime_pattern,v_mo_udf_6),v_mo_udf_6,''),
																												if (regexfind(datetime_pattern,v_mo_udf_7),v_mo_udf_7,''),
																												if (regexfind(datetime_pattern,v_mo_udf_8),v_mo_udf_8,'')
																										);
			self.yes_no_val									:= 		choose(ctr,
																												if (regexfind(yes_no_pattern,v_mo_udf_1,NOCASE),v_mo_udf_1,''),
																												if (regexfind(yes_no_pattern,v_mo_udf_2,NOCASE),v_mo_udf_2,''),
																												if (regexfind(yes_no_pattern,v_mo_udf_3,NOCASE),v_mo_udf_3,''),
																												if (regexfind(yes_no_pattern,v_mo_udf_4,NOCASE),v_mo_udf_4,''),
																												if (regexfind(yes_no_pattern,v_mo_udf_5,NOCASE),v_mo_udf_5,''),
																												if (regexfind(yes_no_pattern,v_mo_udf_6,NOCASE),v_mo_udf_6,''),
																												if (regexfind(yes_no_pattern,v_mo_udf_7,NOCASE),v_mo_udf_7,''),
																												if (regexfind(yes_no_pattern,v_mo_udf_8,NOCASE),v_mo_udf_8,'')
																										);
			self.crime											:= 		L.Crime;
		END;
		moUdf := normalize(pMos, 8, temp_mo_udf(left, counter));
		
		return moUdf(string_val != '' or integer_val != 0 or decimal_val != 0.0 or datetime_val != '' or yes_no_val != '');

	ENDMACRO;


	EXPORT MAC_EventPersonsExt( EVENT_PERSONS_input, EVENT_input, pVersion, pEventGeoPersons, pUseProd = false, pUseDelta = false) := FUNCTIONMACRO

		IMPORT bair,ut,STD,address;
	
		AddressCache  := dedup(files().baseLNAddressCache.built(ac_x_coordinate != 0 and ac_y_coordinate != 0) + pEventGeoPersons, all);		
		
		layouts.event_dbo_persons_In_extended temp_persons (EVENT_PERSONS_input L, layouts.address_cache R, integer C) := TRANSFORM
		
			x_coordinate 	:= (real8)L.persons_x_coordinate;
			y_coordinate 	:= (real8)L.persons_y_coordinate;
			provided_by_agency := IF (x_coordinate != 0 and y_coordinate != 0, TRUE, FALSE);
			
			self.recordID_RAIDS 					:= 		0;
			self.personstamp 							:= 		(UNSIGNED4)L.personstamp; 			//******* Calculated
			self.weight_1 								:= 		(UNSIGNED2)L.weight_1;
			self.weight_2 								:= 		(UNSIGNED2)L.weight_2;
			self.height_1 								:= 		(UNSIGNED2)L.height_1;
			self.height_2 								:= 		(UNSIGNED2)L.height_2;
			self.age_1 										:= 		(UNSIGNED2)L.age_1;
			self.age_2 										:= 		(UNSIGNED2)L.age_2;
			self.persons_sid 							:= 		L.sid;
			self.persons_x_projected 			:= 		(real8)L.persons_x_projected;
			self.persons_y_projected 			:= 		(real8)L.persons_y_projected;	
			self.ori 											:= 		(UNSIGNED4)L.ori;
			self.quarantined 							:= 		'0';
			self.mo_relationship 					:= 		(UNSIGNED4)L.mo_relationship;
			self.group_id 								:= 		(UNSIGNED4)L.group_id; 						//******* Calculated
			self.import_instance_id 			:= 		(UNSIGNED4)L.import_instance_id; 	//******* Calculated
			//extended =>
			SELF.quarantine_code					:=		0;
			self.persons_accuracy_code 		:= 		if(provided_by_agency,(unsigned1)L.persons_accuracy,(unsigned1)R.ac_accuracy);
			self.persons_geocoded					:= 		if(provided_by_agency, L.persons_geocoded,R.ac_geocoded);
			self.persons_x_coordinate 		:= 		if(provided_by_agency, x_coordinate, R.ac_x_coordinate); 
			self.persons_y_coordinate 		:= 		if(provided_by_agency, y_coordinate, R.ac_y_coordinate);
			SELF.persons_address_clean		:=    R.ac_clean_address_182;
			SELF.person_udf_1 						:= regexreplace( '[^0-9a-zA-Z]+',trim(L.person_udf_1, LEFT, RIGHT), '');				
			SELF.person_udf_2 						:= regexreplace( '[^0-9a-zA-Z]+',trim(L.person_udf_2, LEFT, RIGHT), '');				
			SELF.person_udf_3 						:= regexreplace( '[^0-9a-zA-Z]+',trim(L.person_udf_3, LEFT, RIGHT), '');				
			SELF.person_udf_4 						:= regexreplace( '[^0-9a-zA-Z]+',trim(L.person_udf_4, LEFT, RIGHT), '');				
			SELF.person_udf_5 						:= regexreplace( '[^0-9a-zA-Z]+',trim(L.person_udf_5, LEFT, RIGHT), '');	
			SELF													:= 		L;
		END;
		

		inputPersons := join(distribute(EVENT_PERSONS_input, hash(ori)), 
							 distribute(AddressCache, hash(ac_dataProviderID)), 
							left.ORI = right.ac_dataProviderID and ut.CleanSpacesAndUpper(left.persons_address) = ut.CleanSpacesAndUpper(right.ac_address), 
							temp_persons(LEFT,RIGHT, COUNTER),
							left outer,
							local);
				
		layouts.event_dbo_persons_In_extended T_EventPersons(layouts.event_dbo_persons_In_extended  L, EVENT_input R) := TRANSFORM
			SELF.quarantined := if(L.ir_number = R.IR_Number and L.ori = R.ori,R.quarantined,L.quarantined);
			SELF.quarantine_code := if(L.ir_number = R.IR_Number and L.ori = R.ori,19,(unsigned1)L.quarantined);
			SELF := L;
		END;

    persons := join(
									 distribute(inputPersons,hash(ori,ir_number))
									,distribute(EVENT_input,hash(ori,IR_Number))
									,left.ir_number = right.IR_Number and left.ori = right.ori
									,T_EventPersons(LEFT, RIGHT)
									,LEFT OUTER 
									,LOCAL
									,KEEP(1)
							);					
	
	
		INTEGER last_recordID_RAIDS := Validate_Input.fn_GetPersonRecordID(true):INDEPENDENT;
	  
		layouts.event_dbo_persons_In_extended AddRecordID_RAIDS(layouts.event_dbo_persons_In_extended L, integer C) := transform
				SELF.recordID_RAIDS := last_recordID_RAIDS + C;
				self := L;
		end;
		
		persons_recordid_raids := project(persons, AddRecordID_RAIDS(left, counter));
		
		//Code to calculate  personstamp in persons
		
		dPers 	:= 	distribute(persons_recordid_raids, hash(ori, ir_number));
		dPers_1	:=	dPers(regexfind('SUSPECT|ARREST', trim(name_type, left, right), nocase));
		dPers_2	:=	dPers(~regexfind('SUSPECT|ARREST', trim(name_type, left, right), nocase) and regexfind('VICTIM', trim(name_type, left, right), nocase));
		dPers_3	:=	dPers(~regexfind('SUSPECT|ARREST|VICTIM', trim(name_type, left, right), nocase));

		SortedSet_p1	:= SORT(dPers_1, ori, ir_number
												,STD.Str.ToUpperCase(trim(last_name,left,right))
												,STD.Str.ToUpperCase(trim(first_name,left,right))
												,STD.Str.ToUpperCase(trim(middle_name,left,right))									
												,local);
												
		GroupedSet_p1	:= GROUP(SortedSet_p1, ori, ir_number);

		{GroupedSet_p1, unsigned rownum, unsigned stampGroupNum} AddRowNum(GroupedSet_p1 L, integer C, unsigned stampGroupNum) := transform
				self.rownum := C - 1;
				self.stampGroupNum := stampGroupNum;
				self := L;
		end;

		pers_w_rownum1 		:= project(GroupedSet_p1, AddRowNum(left, counter, 1));
		ug_pers_w_rownum1 := UNGROUP(pers_w_rownum1);

		SortedSet_p2			:= SORT(dPers_2, ori, ir_number
												,STD.Str.ToUpperCase(trim(last_name,left,right))
												,STD.Str.ToUpperCase(trim(first_name,left,right))
												,STD.Str.ToUpperCase(trim(middle_name,left,right))									
												,local);
												
		GroupedSet_p2			:= GROUP(SortedSet_p2, ori, ir_number);
		pers_w_rownum2 		:= project(GroupedSet_p2, AddRowNum(left, counter, 2));
		ug_pers_w_rownum2 := UNGROUP(pers_w_rownum2);

		SortedSet_p3			:= SORT(dPers_3, ori, ir_number
												,STD.Str.ToUpperCase(trim(name_type,left,right))
												,STD.Str.ToUpperCase(trim(last_name,left,right))
												,STD.Str.ToUpperCase(trim(first_name,left,right))
												,STD.Str.ToUpperCase(trim(middle_name,left,right))									
												,local);
												
		GroupedSet_p3			:= GROUP(SortedSet_p3, ori, ir_number);
		pers_w_rownum3 		:= project(GroupedSet_p3, AddRowNum(left, counter, 3));
		ug_pers_w_rownum3 := UNGROUP(pers_w_rownum3);


		pers_w_rownum 		:= ug_pers_w_rownum1 + ug_pers_w_rownum2 + ug_pers_w_rownum3;

		SortedSet_p				:= SORT(pers_w_rownum, ori, ir_number
												,stampGroupNum
												,rownum									
												,local);
												
		SortedSet_p AddStamp(SortedSet_p L, integer C) := transform
				self.personstamp := C - 1;
				self := L;
		end;

		GroupedSet_p			:= GROUP(SortedSet_p, ori, ir_number);
		pers_w_stamp 		  := project(GroupedSet_p, AddStamp(left, counter));
		ug_pers_w_stamp 	:= UNGROUP(pers_w_stamp);
		
		EventPersonsJoined := project(ug_pers_w_stamp, {persons_recordid_raids});
		RETURN EventPersonsJoined;
	ENDMACRO;

	EXPORT MAC_EventPersons(pEventPersonsExt) := FUNCTIONMACRO 
		return project(pEventPersonsExt, layouts.event_dbo_persons_In_extended - [quarantine_code,person_udf_1,person_udf_2,person_udf_3,person_udf_4,person_udf_5]);
	ENDMACRO;	

	

	EXPORT MAC_EventPersonsUDF(pPersons) := FUNCTIONMACRO

		bair.layouts.event_dbo_persons_udf_In temp_persons_udf (layouts.event_dbo_persons_In_extended L, UNSIGNED2 ctr) := TRANSFORM 
			self.id													:= 		0;
			self.recordID_RAIDS							:= 		L.recordID_RAIDS;			
			self.ir_number									:= 		L.ir_number;
			self.ORI												:= 		(UNSIGNED4)L.ORI;
			self.fieldId										:= 		8 + ctr;
			
			v_person_udf_1 := trim(L.person_udf_1, left, right);
			v_person_udf_2 := trim(L.person_udf_2, left, right);
			v_person_udf_3 := trim(L.person_udf_3, left, right);
			v_person_udf_4 := trim(L.person_udf_4, left, right);
			v_person_udf_5 := trim(L.person_udf_5, left, right);
			
			integer_pattern 	:= '^[0-9]*$';
			real_pattern			:= '^[0-9]*\\.[0-9]*$';
			datetime_pattern	:= '^([0-9]+)-+([0-9]+)-+([0-9])+(\\s+([0-9]+):+([0-9]+):+([0-9]+)(\\.([0-9]+))?)?$';
			yes_no_pattern		:= '^(true|false|yes|no)$';
			
			self.string_val									:= 		choose(ctr,	
																												if (~regexfind(integer_pattern,v_person_udf_1) and ~regexfind(real_pattern,v_person_udf_1) and ~regexfind(datetime_pattern,v_person_udf_1) and ~regexfind(yes_no_pattern,v_person_udf_1,NOCASE), v_person_udf_1, ''),
																												if (~regexfind(integer_pattern,v_person_udf_2) and ~regexfind(real_pattern,v_person_udf_2) and ~regexfind(datetime_pattern,v_person_udf_2) and ~regexfind(yes_no_pattern,v_person_udf_2,NOCASE), v_person_udf_2, ''),
																												if (~regexfind(integer_pattern,v_person_udf_3) and ~regexfind(real_pattern,v_person_udf_3) and ~regexfind(datetime_pattern,v_person_udf_3) and ~regexfind(yes_no_pattern,v_person_udf_3,NOCASE), v_person_udf_3, ''),
																												if (~regexfind(integer_pattern,v_person_udf_4) and ~regexfind(real_pattern,v_person_udf_4) and ~regexfind(datetime_pattern,v_person_udf_4) and ~regexfind(yes_no_pattern,v_person_udf_4,NOCASE), v_person_udf_4, ''),
																												if (~regexfind(integer_pattern,v_person_udf_5) and ~regexfind(real_pattern,v_person_udf_5) and ~regexfind(datetime_pattern,v_person_udf_5) and ~regexfind(yes_no_pattern,v_person_udf_5,NOCASE), v_person_udf_5, '')
																										);
			self.integer_val								:= 		(integer)choose(ctr,	
																												if (regexfind(integer_pattern,v_person_udf_1),v_person_udf_1,'0'),
																												if (regexfind(integer_pattern,v_person_udf_2),v_person_udf_2,'0'),
																												if (regexfind(integer_pattern,v_person_udf_3),v_person_udf_3,'0'),
																												if (regexfind(integer_pattern,v_person_udf_4),v_person_udf_4,'0'),
																												if (regexfind(integer_pattern,v_person_udf_5),v_person_udf_5,'0')
																										);
			self.decimal_val								:= 		(real8)choose(ctr,	
																												if (regexfind(real_pattern,v_person_udf_1),v_person_udf_1,'0.0'),
																												if (regexfind(real_pattern,v_person_udf_2),v_person_udf_2,'0.0'),
																												if (regexfind(real_pattern,v_person_udf_3),v_person_udf_3,'0.0'),
																												if (regexfind(real_pattern,v_person_udf_4),v_person_udf_4,'0.0'),
																												if (regexfind(real_pattern,v_person_udf_5),v_person_udf_5,'0.0')
																										);
			self.datetime_val								:= 		choose(ctr,	
																												if (regexfind(datetime_pattern,v_person_udf_1),v_person_udf_1,''),
																												if (regexfind(datetime_pattern,v_person_udf_2),v_person_udf_2,''),
																												if (regexfind(datetime_pattern,v_person_udf_3),v_person_udf_3,''),
																												if (regexfind(datetime_pattern,v_person_udf_4),v_person_udf_4,''),
																												if (regexfind(datetime_pattern,v_person_udf_5),v_person_udf_5,'')
																										);
			self.yes_no_val									:= 		choose(ctr,
																												if (regexfind(yes_no_pattern,v_person_udf_1,NOCASE),v_person_udf_1,''),
																												if (regexfind(yes_no_pattern,v_person_udf_2,NOCASE),v_person_udf_2,''),
																												if (regexfind(yes_no_pattern,v_person_udf_3,NOCASE),v_person_udf_3,''),
																												if (regexfind(yes_no_pattern,v_person_udf_4,NOCASE),v_person_udf_4,''),
																												if (regexfind(yes_no_pattern,v_person_udf_5,NOCASE),v_person_udf_5,'')
																										);
																										

		END;
		personsUdf := normalize(pPersons, 5, temp_persons_udf(left, counter));
		
		return personsUdf(string_val != '' or integer_val != 0 or decimal_val != 0.0 or datetime_val != '' or yes_no_val != '');	
	ENDMACRO;

	
	EXPORT MAC_EventVehiclesExt(EVENT_VEHICLES_input, EVENT_input, pVersion,pEventGeoVehicles, pUseProd = false, pUseDelta = false) := FUNCTIONMACRO

		IMPORT bair,ut,STD,address;
	
		time := ut.getTime();
		date := ut.GetDate;
		v_edit_date := date[1..4] + '-' + date[5..6] + '-' + date[7..8] + ' ' + time[1..2] + ':' + time[3..4] + ':' + time[5..6] + '.000';


		AddressCache  := dedup(files().baseLNAddressCache.built(ac_x_coordinate != 0 and ac_y_coordinate != 0) + pEventGeoVehicles, all);	
			
		layouts.event_dbo_vehicle_In_extended temp_vehicles (EVENT_VEHICLES_input L, layouts.address_cache R) := TRANSFORM
			x_coordinate 	:= (real8)L.vehicle_x_coordinate;
			y_coordinate 	:= (real8)L.vehicle_y_coordinate;
			provided_by_agency := IF (x_coordinate != 0 and y_coordinate != 0, TRUE, FALSE);
			
			self.recordID_RAIDS 					:= 0;
			self.vehiclestamp		 					:= (UNSIGNED4)L.vehiclestamp;  						//******* Calculated
			self.vehicle_x_projected 			:= (real8)L.vehicle_x_projected; 		
			self.vehicle_y_projected 			:= (real8)L.vehicle_y_projected; 		
			self.ori 											:= (UNSIGNED4)L.ori; 
			self.person_relationship 			:= (integer)L.person_relationship;   				
			self.group_id 								:= (UNSIGNED2)L.group_id;   										//******* Calculated
			self.import_instance_id 			:= (UNSIGNED4)L.import_instance_id;   					//******* Calculated
			//extended =>
			SELF.quarantine_code					:=		0;
			self.vehicle_accuracy_code		:= 		if(provided_by_agency,(unsigned1)L.vehicle_accuracy, (unsigned1)R.ac_accuracy); 
			self.vehicle_geocoded 				:= 		if(provided_by_agency,L.vehicle_geocoded, R.ac_geocoded); 
			self.vehicle_x_coordinate 		:= 		if(provided_by_agency,x_coordinate, R.ac_x_coordinate); 
			self.vehicle_y_coordinate 		:= 		if(provided_by_agency,y_coordinate, R.ac_y_coordinate);
			SELF.vehicle_address_clean		:=    R.ac_clean_address_182;
			SELF													:= 		L;			
		END;
		
		inputVehicles := join(distribute(EVENT_VEHICLES_input,hash(ori)), 
							 distribute(AddressCache,hash(ac_dataProviderID)), 
							left.ORI = right.ac_dataProviderID and ut.CleanSpacesAndUpper(left.vehicle_address) = ut.CleanSpacesAndUpper(right.ac_address),
							temp_vehicles(LEFT,RIGHT),
							left outer,
							LOCAL);

		layouts.event_dbo_vehicle_In_extended T_EventVehicles(layouts.event_dbo_vehicle_In_extended  L, EVENT_input R) := TRANSFORM
			SELF.quarantined 			:= if(L.ir_number = R.IR_Number and L.ori = R.ori,	R.quarantined,L.quarantined);
			SELF.quarantine_code 	:= if(L.ir_number = R.IR_Number and L.ori = R.ori,	19,						(unsigned1)L.quarantined);
			SELF := L;
		END;
    vehicle := join(
														 distribute(inputVehicles,hash(ori,ir_number))
														,distribute(EVENT_input,hash(ori,IR_Number))
														,left.ir_number = right.IR_Number and left.ori = right.ori
														,T_EventVehicles(LEFT, RIGHT)
														, LEFT OUTER 
														,keep(1),
														LOCAL
												);					

		//Code to calculate  vehicletamp in vehicle		
		
		dVeh := distribute(vehicle, hash(ori, ir_number));
		dVeh_1:=dVeh(regexfind('STOLEN', trim(vehicle_status, left, right), nocase));
		dVeh_2:=dVeh(~regexfind('STOLEN', trim(vehicle_status, left, right), nocase) and regexfind('SUSPECT|ARREST', trim(vehicle_status, left, right), nocase));
		dVeh_3:=dVeh(~regexfind('STOLEN|SUSPECT|ARREST', trim(vehicle_status, left, right), nocase));

		SortedSet_p1		:= SORT(dVeh_1, ori, ir_number
												,STD.Str.ToUpperCase(trim(make,left,right))
												,STD.Str.ToUpperCase(trim(model,left,right))					
												,local);
												
		GroupedSet_p1	:= GROUP(SortedSet_p1, ori, ir_number);

		{GroupedSet_p1, unsigned rownum, unsigned stampGroupNum} AddRowNum(GroupedSet_p1 L, integer C, unsigned stampGroupNum) := transform
				self.rownum := C - 1;
				self.stampGroupNum := stampGroupNum;
				self := L;
		end;

		veh_w_rownum1 		:= project(GroupedSet_p1, AddRowNum(left, counter, 1));
		ug_veh_w_rownum1 	:= UNGROUP(veh_w_rownum1);

		SortedSet_p2			:= SORT(dVeh_2, ori, ir_number
												,STD.Str.ToUpperCase(trim(make,left,right))
												,STD.Str.ToUpperCase(trim(model,left,right))									
												,local);
												
		GroupedSet_p2			:= GROUP(SortedSet_p2, ori, ir_number);
		veh_w_rownum2 		:= project(GroupedSet_p2, AddRowNum(left, counter, 2));
		ug_veh_w_rownum2 	:= UNGROUP(veh_w_rownum2);

		SortedSet_p3			:= SORT(dVeh_3, ori, ir_number
												,STD.Str.ToUpperCase(trim(vehicle_status,left,right))
												,STD.Str.ToUpperCase(trim(make,left,right))
												,STD.Str.ToUpperCase(trim(model,left,right))								
												,local);
												
		GroupedSet_p3			:= GROUP(SortedSet_p3, ori, ir_number);
		veh_w_rownum3 		:= project(GroupedSet_p3, AddRowNum(left, counter, 3));
		ug_veh_w_rownum3 	:= UNGROUP(veh_w_rownum3);


		veh_w_rownum 			:= ug_veh_w_rownum1 + ug_veh_w_rownum2 + ug_veh_w_rownum3;

		SortedSet_p				:= SORT(veh_w_rownum, ori, ir_number
												,stampGroupNum
												,rownum
												,local);
												
		SortedSet_p AddStamp(SortedSet_p L, integer C) := transform
				self.vehiclestamp := C - 1;
				self := L;
		end;

		GroupedSet_p			:= GROUP(SortedSet_p, ori, ir_number);
		veh_w_stamp 		  := project(GroupedSet_p, AddStamp(left, counter));
		ug_veh_w_stamp 		:= UNGROUP(veh_w_stamp);

		EventVehiclesJoined := project(ug_veh_w_stamp, {vehicle});
		RETURN EventVehiclesJoined;
	ENDMACRO;
	
	EXPORT MAC_EventVehicles(pEventVehiclesExt) := FUNCTIONMACRO 
		return project(pEventVehiclesExt, layouts.event_dbo_vehicle_In_extended - [quarantine_code]);
	ENDMACRO;		
	
	
	EXPORT MAC_Cfs_Ext(CFS_input,CFSOFFICERS_input, pCfsGeoAddresses) := FUNCTIONMACRO
	
		IMPORT bair,ut,STD,address;
	
		time := ut.getTime();
		date := ut.GetDate;
		v_edit_date := date[1..4] + '-' + date[5..6] + '-' + date[7..8] + ' ' + time[1..2] + ':' + time[3..4] + ':' + time[5..6] + '.000';

		dpl := Bair.files().DataProviderLoc_Base.built();
		layouts.cfs_dbo_cfs_2_In_extended DataProvider_T (CFS_input L, dpl R) := TRANSFORM
			self.cfs_id 														:= (UNSIGNED4)L.cfs_id;    //******* Calculated
			self.ori 																:= (UNSIGNED4)L.ori;
			self.edit_date													:= if(L.edit_date='',(string8)std.date.today(),L.edit_date);    //******* Translation or Calculated	ISNULL(edit_Date, GETDATE())
			self.priority1													:= L.priority;
			self.total_minutes_on_call							:= (real8)L.total_minutes_on_call;
			self.projected_x_coordinate							:= (real8)L.projected_x_coordinate;
			self.projected_y_coordinate							:= (real8)L.projected_y_coordinate;
			self.accuracy_code											:= (unsigned1)L.accuracy;    //******* Lookup or Calculated
			self.complainant_x_coordinate 					:= (real8)L.complainant_x_coordinate;
			self.complainant_y_coordinate 					:= (real8)L.complainant_y_coordinate;
			self.complainant_projected_x_coordinate := (real8)L.complainant_projected_x_coordinate;
			self.complainant_projected_y_coordinate := (real8)L.complainant_projected_y_coordinate;
			self.complainant_accuracy 							:= (unsigned1)L.complainant_accuracy;
			self.quarantined												:= '0';
			self.group_id 													:= (UNSIGNED2)L.group_id;    //******* Calculated
			self.import_instance_id									:= (UNSIGNED4)L.import_instance_id;    //******* Calculated
			self.initial_ucr_group 									:= 1034;
			self.final_ucr_group 										:= 1034;
			self.util_integer_1											:= (unsigned2)L.util_integer_1;
			self.util_integer_2											:= (unsigned2)L.util_integer_2;
			self.util_integer_3											:= (unsigned2)L.util_integer_3;
			self.util_decimal_1											:= (real8)L.util_decimal_1;
			self.util_decimal_2											:= (real8)L.util_decimal_2;
			self.util_decimal_3											:= (real8)L.util_decimal_3;
			self.util_yes_no_1											:= (boolean)L.util_yes_no_1;
			self.util_yes_no_2											:= (boolean)L.util_yes_no_2;
			self.util_yes_no_3											:= (boolean)L.util_yes_no_3;
			self.x_coordinate												:= (real8) L.x_coordinate;
			self.y_coordinate												:= (real8) L.y_coordinate;
			//extended
			self.quarantine_code										:= 0;
			self.date_time_dispatched								:= '';
			self.date_time_enroute									:= '';
			self.date_time_arrived									:= '';
			self.date_time_cleared									:= '';
			self.unit																:= '';
			self.officer_name												:= '';
			self.officer_ori												:= 0;
			self.officer_event_number								:= '';			
			SELF.boundingBoxSouthWestLat 						:= R.boundingBoxSouthWestLat;
			SELF.boundingBoxSouthWestLong						:= R.boundingBoxSouthWestLong;
			SELF.boundingBoxNorthEastLat						:= R.boundingBoxNorthEastLat;
			SELF.boundingBoxNorthEastLong						:= R.boundingBoxNorthEastLong;			
			SELF :=	L;
		END;
		
		DataProvider_Loc := join(CFS_input, 
							 dpl, 
							left.ORI = right.dataproviderid, 
							DataProvider_T(LEFT,RIGHT),
							left outer,
							LOOKUP);		
							

		
		layouts.cfs_dbo_cfs_2_In_extended temp_cfs (DataProvider_Loc L,CFSOFFICERS_input R) := TRANSFORM
			self.date_time_dispatched								:= R.date_time_dispatched;
			self.date_time_enroute									:= R.date_time_enroute;
			self.date_time_arrived									:= R.date_time_arrived;
			self.date_time_cleared									:= R.date_time_cleared;
			self.unit																:= R.unit;
			self.officer_name												:= R.officer_name;
			self.officer_ori												:= R.officer_ori;
			self.officer_event_number								:= R.officer_event_number;
			self																		:= L;
		END;

		cfs_2_xml := join(
								 distribute(DataProvider_Loc,hash(ori,event_number)),
								 distribute(CFSOFFICERS_input,hash(officer_ori,officer_event_number)),
								 left.ori = right.officer_ori and left.event_number = right.officer_event_number,
								 temp_cfs(LEFT,RIGHT),
								 left outer,
								 keep(1),
								 LOCAL
							);
									
		layouts.cfs_dbo_cfs_2_In_extended temp_cfs_address (layouts.cfs_dbo_cfs_2_In_extended L, layouts.address_cache R) := TRANSFORM
			provided_by_agency := IF ((real8)L.x_coordinate != 0 and (real8)L.y_coordinate != 0, TRUE, FALSE);
			
			X_Coordinate 	:= if(provided_by_agency,(real8)L.x_coordinate,R.ac_x_coordinate) ;
			Y_Coordinate 	:= if(provided_by_agency,(real8)L.y_coordinate,R.ac_y_coordinate) ;

			accuracy_code := if(provided_by_agency,(unsigned1)L.accuracy_code,(unsigned1) R.ac_accuracy);

			vDateTimeArrived 		:= (unsigned)trim(stringlib.stringfilterout(L.date_time_received,'-/:T'),left,right);		
			vDateTimeArrivedF 	:= ut.DateTimeToYYYYMMDD((string)trim(stringlib.stringfilterout(L.date_time_received,'.>$!%*@=?&\''),left,right));
			vDateTimeDispatched := (unsigned)trim(stringlib.stringfilterout(L.date_time_dispatched,'-/:T'),left,right);		
			vDateTimeDispatchedF:= ut.DateTimeToYYYYMMDD((string)trim(stringlib.stringfilterout(L.date_time_dispatched,'.>$!%*@=?&\''),left,right)); 			
			vDateTimeReceived 	:= (unsigned)trim(stringlib.stringfilterout(L.date_time_received,'-/:T'),left,right);			
			vDateTimeReceivedF 	:= ut.DateTimeToYYYYMMDD((string)trim(stringlib.stringfilterout(L.date_time_received,'.>$!%*@=?&\''),left,right)); 						
			vDateTimeEnroute 		:= (unsigned)trim(stringlib.stringfilterout(L.date_time_enroute,'-/:T'),left,right);			
			vDateTimeEnrouteF		:= ut.DateTimeToYYYYMMDD((string)trim(stringlib.stringfilterout(L.date_time_enroute,'.>$!%*@=?&\''),left,right)); 
			vDateTimeCleared 		:= (unsigned)trim(stringlib.stringfilterout(L.date_time_cleared,'-/:T'),left,right);			
			vDateTimeClearedF		:= ut.DateTimeToYYYYMMDD((string)trim(stringlib.stringfilterout(L.date_time_cleared,'.>$!%*@=?&\''),left,right)); 
			
			
			Unsigned4 lTestFlags := _Validate.Date.Rules.Optional | _Validate.Date.Rules.YearValid 	| _Validate.Date.Rules.MonthValid 	| _Validate.Date.Rules.DayValid;
			
			SELF.quarantine_code := map(		
											(X_Coordinate = 0.0 or Y_Coordinate = 0.0) and L.address != '' => 1,	  // CFS Unknown addresss
											accuracy_code > 0 and accuracy_code < 6 => 9,   // CFS Low Accuracy
											L.initial_type = '' => 2, 	// CFS Initial Type missing
											L.officer_ori != 0 and L.officer_event_number != '' and	vDateTimeDispatchedF >= vDateTimeReceivedF and vDateTimeDispatched < vDateTimeReceived  => 4, 	// CFS Officer DateTimeDispatched before CFS DateTimeReceived
											L.officer_ori != 0 and L.officer_event_number != '' and	vDateTimeArrivedF > (string8)std.date.today()	=> 5, 	// CFS Future Officer DateTimeArrived
											vDateTimeReceivedF = '' => 6,		// CFS DateTimeReceived missing	
											_Validate.Date.fIsValid(vDateTimeReceivedF, lTestFlags,false,false)=false	=> 16, 	// CFS DateTimeReceived before 1900 											
											L.officer_ori != 0 and L.officer_event_number != '' and	vDateTimeClearedF > (string8)std.date.today()	=> 7, 	// CFS Future Officer DateTimeCleared
											(X_Coordinate = 0.0 or Y_Coordinate = 0.0) and L.address = '' => 8,		// CFS Missing address
											L.officer_ori != 0 and L.officer_event_number != '' and	L.unit = '' and L.officer_name = '' => 10,	// CFS Both Unit and Officer Name are missing from OFFICER record							
											vDateTimeReceivedF > (string8)std.date.today() => 11,	// CFS Future DateTimeReceived					
											L.officer_ori != 0 and L.officer_event_number != '' and vDateTimeArrivedF >= vDateTimeReceivedF and vDateTimeArrived < vDateTimeReceived => 13,	// CFS Officer DateTimeArrived before CFS DateTimeReceived
											L.officer_ori != 0 and L.officer_event_number != '' and	vDateTimeEnrouteF >= vDateTimeReceivedF and	vDateTimeEnroute < vDateTimeReceived => 14,	// CFS Officer DateTimeEnroute before CFS DateTimeReceived
											L.officer_ori != 0 and L.officer_event_number != '' and	vDateTimeDispatchedF > (string8)std.date.today() => 15,	// CFS Future Officer DateTimeDispatched
											L.officer_ori != 0 and L.officer_event_number != '' and	vDateTimeClearedF >= vDateTimeReceivedF and vDateTimeCleared < vDateTimeReceived => 17,	// CFS Officer DateTimeCleared before CFS DateTimeReceived
											L.officer_ori != 0 and L.officer_event_number != '' and	vDateTimeEnrouteF > (string8)std.date.today() => 3, 	// CFS Future Officer DateTimeEnroute	
											(X_Coordinate != 0 and Y_Coordinate != 0) and	(L.BoundingBoxSouthWestLat > Y_Coordinate  or	L.BoundingBoxNorthEastLat < Y_Coordinate or L.BoundingBoxSouthWestLong > X_Coordinate or L.BoundingBoxNorthEastLong < X_Coordinate) => 12, 	// CFS Out of bounds*				
											0);	

			SELF.quarantined := if(SELF.quarantine_code=0,'0','1');

			SELF.geocoded									:= 		if(provided_by_agency, '0', R.ac_geocoded);
			self.accuracy_code						:= 		if(provided_by_agency, (unsigned1)L.accuracy_code , (unsigned1)R.ac_accuracy  ); 
			self.x_coordinate 						:= 		if(provided_by_agency, x_coordinate , R.ac_x_coordinate); 
			self.y_coordinate 						:= 		if(provided_by_agency, y_coordinate , R.ac_y_coordinate );
			SELF.address_clean						:=    R.ac_clean_address_182;
			SELF													:= 		L;
		END;
		
		AddressCache  	:= distribute(dedup(files().baseLNAddressCache.built(ac_x_coordinate != 0 and ac_y_coordinate != 0) + pCfsGeoAddresses, all), hash(ac_dataproviderid));	
		
		cfs_2_A := join(distribute(cfs_2_xml,hash(ori)), 
							 AddressCache, 
							left.ori = right.ac_dataProviderID and ut.CleanSpacesAndUpper(left.address) = ut.CleanSpacesAndUpper(right.ac_address),
							temp_cfs_address(LEFT,RIGHT),
							left outer,
							local);

		
		//Geocode Caller Address
		layouts.cfs_dbo_cfs_2_In_extended temp_cfs_caller_address (layouts.cfs_dbo_cfs_2_In_extended L, layouts.address_cache R) := TRANSFORM
			SELF.caller_address_clean			:= 		R.ac_clean_address_182;
			SELF													:= 		L;
		END;
		
		cfs_2_B := join(distribute(cfs_2_A,hash(ori)), 
							 AddressCache, 
							left.ori = right.ac_dataProviderID and ut.CleanSpacesAndUpper(left.caller_address) = ut.CleanSpacesAndUpper(right.ac_address),
							temp_cfs_caller_address(LEFT,RIGHT),
							left outer,
							local);
				
		//Geocode Complainant Address
		layouts.cfs_dbo_cfs_2_In_extended temp_cfs_complainant_address (layouts.cfs_dbo_cfs_2_In_extended L, layouts.address_cache R) := TRANSFORM
			x_coordinate 	:= (real8)L.complainant_x_coordinate;
			y_coordinate 	:= (real8)L.complainant_y_coordinate;
			provided_by_agency := IF (x_coordinate != 0 and y_coordinate != 0, TRUE, FALSE);
			
			SELF.complainant_address_clean:= 		R.ac_clean_address_182;
			SELF.complainant_x_coordinate	:= 		if(provided_by_agency, x_coordinate , R.ac_x_coordinate);
			SELF.complainant_y_coordinate	:= 		if(provided_by_agency, y_coordinate , R.ac_y_coordinate);
			SELF.complainant_geocoded			:= 		if(provided_by_agency, L.complainant_geocoded, R.ac_geocoded); 	
			SELF.complainant_accuracy			:= 		if(provided_by_agency, (unsigned1)L.complainant_accuracy, (unsigned1)R.ac_accuracy); 	
			SELF													:= 		L;
		END;
		
		cfs_2_C := join(distribute(cfs_2_B,hash(ori)), 
							 AddressCache, 
							left.ori = right.ac_dataProviderID and ut.CleanSpacesAndUpper(left.complainant_address) = ut.CleanSpacesAndUpper(right.ac_address),
							temp_cfs_complainant_address(LEFT,RIGHT),
							left outer,
							local);
				
		
		//Code to calculate ucr_group in cfs_2		
    CfsTypes				:= Bair.Files().AgencyCfsLookup_Base.built;
		Classfications	:= bair.files().event_helper_ucr_group_classifications_input;
		
		map_cfstypes_class := join(CfsTypes, Classfications, left.type = right.name, lookup);
		
		cfs_2_C AddUCR_group(cfs_2_C l, map_cfstypes_class r) := transform
		
					initial_type := ut.CleanSpacesAndUpper(l.initial_type);
					final_type 	 := ut.CleanSpacesAndUpper(l.final_type);
					agency_type  := ut.CleanSpacesAndUpper(r.agencyType);
					
					self.initial_ucr_group   := if(initial_type = agency_type, r.ucr_group_id, l.initial_ucr_group);
					self.final_ucr_group     := if(final_type		= agency_type, r.ucr_group_id, l.final_ucr_group);
					self.initial_DoNotImport := if(l.ori = r.dataproviderid and initial_type 	= agency_type and r.visibility = 0, TRUE, FALSE);
					self.final_DoNotImport	 := if(l.ori = r.dataproviderid and final_type 		= agency_type and r.visibility = 0, TRUE, FALSE);
					self := l;
		end;
		
			cfs_2_j1 := dedup(join(cfs_2_C
												,map_cfstypes_class
												,left.ori = right.dataproviderid and ut.CleanSpacesAndUpper(left.initial_type) = ut.CleanSpacesAndUpper(right.agencyType)
												,AddUCR_group(left, right)
												,left outer
												,LOOKUP), record, all);
																																										
		importer_cfs_2 := dedup(join(cfs_2_j1
													,map_cfstypes_class
													,left.ori = right.dataproviderid and  ut.CleanSpacesAndUpper(left.final_type) = ut.CleanSpacesAndUpper(right.agencyType)
													,AddUCR_group(left, right)
													,left outer
													,LOOKUP), record, all);
				

		//block full event if one of the crimes is marked as donotimport
		donotimport := importer_cfs_2(initial_DoNotImport = true or final_DoNotImport = true);
		
		importer_cfs_2 DoNotImportFullEvent(importer_cfs_2 l, donotimport r) := transform
			self.initial_DoNotImport := if(r.initial_DoNotImport = true or r.final_DoNotImport = true, true, l.initial_DoNotImport);
			self.final_DoNotImport := 	if(r.initial_DoNotImport = true or r.final_DoNotImport = true, true, l.final_DoNotImport);
			self := l;
		end;
		
		p2 := join(importer_cfs_2
								,donotimport
								,left.ori = right.ori and left.event_number = right.event_number
								,DoNotImportFullEvent(left, right)
								,left outer
								,LOOKUP);
	
		RETURN p2;

	ENDMACRO;
	
	EXPORT MAC_Cfs(pCFSExt) := FUNCTIONMACRO 
		Cfs :=  project(pCFSExt, layouts.cfs_dbo_cfs_2_In_extended - [quarantine_code,date_time_dispatched,date_time_enroute,date_time_arrived,date_time_cleared,unit,officer_name]	);		
		return dedup(Cfs,all);
	ENDMACRO;	

	EXPORT MAC_Cfs_officers (CFSOFFICERS_input) := FUNCTIONMACRO
		
		bair.layouts.cfs_dbo_cfs_officers_2_In temp_cfs_officers (CFSOFFICERS_input L) := TRANSFORM
			self.ori 												:=  (UNSIGNED4)L.officer_ori;
			self.event_number								:=  L.officer_event_number;
			self.cfs_officers_id 						:=  (UNSIGNED4) L.cfs_officers_id;
			self.cfs_id											:= 	(UNSIGNED4) L.cfs_id;
			self.minutes_on_call						:=  (real8) L.minutes_on_call;
			self.minutes_response						:=  (real8) L.minutes_response;
			self.off_util_integer_1					:=  (unsigned2)L.util_integer_1;
			self.off_util_integer_2					:=  (unsigned2)L.util_integer_2;
			self.off_util_integer_3					:=  (unsigned2)L.util_integer_3;
			self.off_util_decimal_1					:=  (real8)L.util_decimal_1;
			self.off_util_decimal_2					:=  (real8)L.util_decimal_2;
			self.off_util_decimal_3					:=  (real8)L.util_decimal_3;
			self.off_util_yes_no_1					:=  (boolean)L.util_yes_no_1;
			self.off_util_yes_no_2					:=  (boolean)L.util_yes_no_2;
			self.off_util_yes_no_3					:=  (boolean)L.util_yes_no_3;	
			self.off_util_string_1					:=  L.util_string_1;
			self.off_util_string_2					:=  L.util_string_2;
			self.off_util_string_3					:=  L.util_string_3;
			self.off_util_string_4					:=  L.util_string_4;
			self.off_util_string_5					:=  L.util_string_5;	
			self.off_util_datetime_1				:=  L.util_datetime_1;
			self.off_util_datetime_2				:=  L.util_datetime_2;
			self.off_util_datetime_3				:=  L.util_datetime_3;
			self.off_util_datetime_4				:=  L.util_datetime_4;
			self.off_util_datetime_5				:=  L.util_datetime_5;
			self														:=  L;
		END;
		
		p1 := project(
					CFSOFFICERS_input,
					temp_cfs_officers(LEFT)
				);
		
		RETURN p1;	
	ENDMACRO;
	
	EXPORT MAC_Crash_Ext (CRASH_input, pGeoCrash, pUseProd = false, pUseDelta = false) := FUNCTIONMACRO

		IMPORT bair,ut,STD,address;

		AddressCache := dedup(files().baseLNAddressCache.built(ac_x_coordinate != 0 and ac_y_coordinate != 0) + pGeoCrash, all);	
		
		dpl := Bair.files().DataProviderLoc_Base.built();
		layouts.crash_dbo_crash_In_extended DataProvider_Base_T (CRASH_input L, dpl R) := TRANSFORM
			x_coordinate 	:= (real8)L.x_coordinate;
			y_coordinate 	:= (real8)L.y_coordinate;		
			SELF.boundingBoxSouthWestLat 	:= R.boundingBoxSouthWestLat;
			SELF.boundingBoxSouthWestLong	:= R.boundingBoxSouthWestLong;
			SELF.boundingBoxNorthEastLat		:= R.boundingBoxNorthEastLat;
			SELF.boundingBoxNorthEastLong	:= R.boundingBoxNorthEastLong;	
			self.ori							:= L.dataProviderId;
			self.case_number			:= L.caseNumber;
			self.report_date			:= L.reportDate;
			self.crash_city				:= L.city;
			self.crash_state			:= L.state;			
			self.crash_import_id	:= (UNSIGNED2) L.crash_import_id;	
			SELF.x 								:= x_coordinate; 
			SELF.y 								:= y_coordinate;
			self.quarantine_code  := 0;
			SELF :=	L;
		END;
		
		DataProvider_Loc := join(CRASH_input, 
							 dpl, 
							left.dataProviderId = right.dataproviderid, 
							DataProvider_Base_T(LEFT,RIGHT),
							left outer,
							lookup);
							
							
		layouts.crash_dbo_crash_In_extended temp_crash (DataProvider_Loc L, layouts.address_cache R) := TRANSFORM
			provided_by_agency := IF (L.x != 0 and L.y != 0, TRUE, FALSE);
			
			X_Coordinate := if(provided_by_agency, L.x , R.ac_x_coordinate ); 
			Y_Coordinate := if(provided_by_agency, L.y , R.ac_y_coordinate );
			SELF.x 								:= X_Coordinate; 
			SELF.y 								:= Y_Coordinate;

			
			vReportDate 	:= (unsigned)trim(stringlib.stringfilterout(L.report_date,'-/:T'),left,right);
			vReportDateF 	:= ut.DateTimeToYYYYMMDD((string)trim(stringlib.stringfilterout(L.report_date,'.>$!%*@=?&\''),left,right)); 

			self.quarantine_code := map(
										X_Coordinate = 0.0 and  Y_Coordinate = 0.0 and L.Address = '' 							=> 1, // Missing Address
										//X_Coordinate = 0.0 or Y_Coordinate = 0.0   and pAddress != ''							=> '2', // Unknown address	
										X_Coordinate != 0.0 and Y_Coordinate != 0.0 and ((L.BoundingBoxSouthWestLat  > Y_Coordinate) or (L.BoundingBoxNorthEastLat  < Y_Coordinate) or (L.BoundingBoxSouthWestLong > X_Coordinate) or (L.BoundingBoxNorthEastLong < X_Coordinate)) => 3, // Out of bounds
										vReportDateF > (string8)std.date.today() => 4, // Future report date
										0);
										
			self.quarantined := IF(self.quarantine_code=0,'0','1');
			
			SELF.address_clean		:= R.ac_clean_address_182;
			SELF									:= L;			
		END;

		Crash := join(distribute(DataProvider_Loc,hash(ori)), 
							 distribute(AddressCache,hash(ac_dataProviderID)), 
							left.ori = right.ac_dataProviderID and ut.CleanSpacesAndUpper(left.address) = ut.CleanSpacesAndUpper(right.ac_address),
							temp_crash(LEFT,RIGHT),
							left outer,
							local);

		RETURN Crash;		
		
	ENDMACRO;	
	
	EXPORT MAC_Crash(pCrashExt) := FUNCTIONMACRO 
		return project(pCrashExt, layouts.crash_dbo_crash_In_extended - [quarantine_code]);
	ENDMACRO;		
	
	EXPORT MAC_Crash_Persons (CRASH_PERSON_input, pUseProd = false, pUseDelta = false) := FUNCTIONMACRO
		
		bair.layouts.crash_dbo_person_In temp_crash_persons (CRASH_PERSON_input L) := TRANSFORM
			self.ori									:= (UNSIGNED4) L.dataProviderId;
			self.case_number					:= L.caseNumber;
			self.per_id 							:= (UNSIGNED4) L.id;
			self.per_crashId 					:= (UNSIGNED4) L.crashId;
			self.vehicleId 						:= (UNSIGNED4) L.vehicleId;
			self.age 									:= (UNSIGNED2) L.age;
			self.first_name 					:= L.firstName;
			self.last_name 						:= L.lastName;		
			self.per_city 						:= L.city;
			self.per_state 						:= L.state;			
			self.agency_person_id 		:= (UNSIGNED4) L.agency_person_id;
			self.per_crash_import_id	:= (UNSIGNED5) L.crash_import_id;
			self											:= L;
		END;
		
		p1 := project(
					CRASH_PERSON_input,
					temp_crash_persons(LEFT)
				);
		
		RETURN p1;	
	ENDMACRO;		


	EXPORT MAC_Crash_Vehicles (CRASH_VEHICLE_input, pUseProd = false, pUseDelta = false) := FUNCTIONMACRO
		
		bair.layouts.crash_dbo_vehicle_In temp_crash_vehicles (CRASH_VEHICLE_input L) := TRANSFORM
			self.ori				:= (UNSIGNED4) L.dataProviderId;
			self.case_number					:= L.caseNumber;
			self.veh_id 							:= (UNSIGNED4) L.id;
			self.veh_crashId 					:= (UNSIGNED4) L.crashId;
			self.vehicle_type 				:= L.vehicleType;
			self.agency_vehicle_id 		:= L.agency_vehicle_id;
			self.veh_crash_import_id	:= (UNSIGNED5) L.crash_import_id;
			self											:= L;
		END;
		
		p1 := project(
					CRASH_VEHICLE_input,
					temp_crash_vehicles(LEFT)
				);
		
		RETURN p1;	
	ENDMACRO;
	
	EXPORT MAC_Offender_Ext (OFFENDER_input, pOffenderGeoAddress, pUseProd = false, pUseDelta = false) := FUNCTIONMACRO

		IMPORT bair,ut,STD,address;

		AddressCache  	:= files().baseLNAddressCache.built(ac_x_coordinate != 0 and ac_y_coordinate != 0) + pOffenderGeoAddress;

		layouts.Offenders_dbo_offender_In_extended temp_offender (OFFENDER_input L, layouts.address_cache R) := TRANSFORM
			provided_by_agency := IF ((real8)L.x_coordinate != 0 and (real8)L.y_coordinate != 0, TRUE, FALSE);
			
			X_Coordinate 	:= if(provided_by_agency, (real8)L.x_coordinate, R.ac_x_coordinate) ;
			Y_Coordinate 	:= if(provided_by_agency, (real8)L.y_coordinate, R.ac_y_coordinate) ;
			
			
			
			self.ori							 	:= (UNSIGNED4) L.data_provider_id;
			self.weight_1 					:= (UNSIGNED3) L.weight_1;
			self.weight_2 					:= (UNSIGNED3) L.weight_2;
			self.height_1 					:= (UNSIGNED3) L.height_1;
			self.height_2 					:= (UNSIGNED3) L.height_2;
			self.age_1 							:= (INTEGER2) L.age_1;
			self.age_2 							:= (INTEGER2) L.age_2;
			self.Offenders_sid 			:= L.sid;
			self.group_id 					:= (UNSIGNED2) L.group_id;
			self.BAIR_score 				:= (real8) L.BAIR_score;
			self.RAIDS_activityDate := L.raids_activity_date;
			self.import_instance_id := (UNSIGNED2) L.import_instance_id;
			self.user_integer 			:= (UNSIGNED2) L.user_integer;
			self.user_float 				:= (real8) L.user_float;
			//extended =>
			SELF.x_coordinate 			:= if(provided_by_agency, x_coordinate, R.ac_x_coordinate); 
			SELF.y_coordinate 			:= if(provided_by_agency, y_coordinate, R.ac_y_coordinate);
		
			self.quarantine_code := map(	 
										X_Coordinate = 0.0 and Y_Coordinate = 0.0  and L.address = '' 	=> 1, 	// Offenders Missing addresss
										(X_Coordinate = 0.0 or Y_Coordinate = 0.0) and L.address != ''	  => 2,	  // Offenders Unknown address	
										0);	
										
			self.quarantined := IF(self.quarantine_code=0,'0','1');
						
			SELF.address_clean			:= R.ac_clean_address_182;
			SELF := 		L;				
		END;
		
		Offenders := join(distribute(OFFENDER_input,hash(data_provider_id)), 
							 distribute(AddressCache,hash(ac_dataProviderID)), 
							left.data_provider_id = right.ac_dataProviderID and ut.CleanSpacesAndUpper(left.address) = ut.CleanSpacesAndUpper(right.ac_address),
							temp_offender(LEFT,RIGHT),
							left outer,
							local);				
		
		RETURN Offenders;	
	ENDMACRO;
	
	EXPORT MAC_Offender(pOffenderExt) := FUNCTIONMACRO 
		return project(pOffenderExt, layouts.Offenders_dbo_offender_In_extended - [quarantine_code]);
	ENDMACRO;	
	
	EXPORT MAC_Offender_Class (OFFENDER_CLASS_input, pUseProd = false, pUseDelta = false) := FUNCTIONMACRO
		
		bair.layouts.Offenders_dbo_offender_classification_In temp_offender_classification (OFFENDER_CLASS_input L) := TRANSFORM
			self.ori 										:= (UNSIGNED4) L.data_provider_id;
			self												:= L;
		END;
		
		p1 := project(
					OFFENDER_CLASS_input,
					temp_offender_classification(LEFT)
				);
		
		RETURN p1;	
	ENDMACRO;	
	
	EXPORT MAC_Offender_Picture (OFFENDER_PIC_input, pUseProd = false, pUseDelta = false) := FUNCTIONMACRO
		
		bair.layouts.Offenders_dbo_offender_picture_In temp_offender_picture (OFFENDER_PIC_input L) := TRANSFORM
			self.ori 	:= (UNSIGNED4) L.data_provider_id;
			self.offender_id			:= L.agency_offender_id;
			self.picture_image		:= L.offender_picture;
			self									:= L;
		END;
		
		p1 := project(
					OFFENDER_PIC_input,
					temp_offender_picture(LEFT)
				);
		
		RETURN p1;	
	ENDMACRO;		
	
	
	EXPORT MAC_Lpr_Ext (LPR_input) := FUNCTIONMACRO
		
		dpl := Bair.files().DataProviderLoc_Base.built();
		layouts.lpr_dbo_LicensePlate_In_extended DataProvider_Base_T (LPR_input L, dpl R) := TRANSFORM
			self.Confidence								:= (integer) L.Confidence;
			self.X_Coordinate							:= (real8) L.X_Coordinate; 
			self.Y_Coordinate							:= (real8) L.Y_Coordinate; 
			self.ORI											:= (UNSIGNED4) L.ORI;

			vCaptureDateTimeF	:= ut.DateTimeToYYYYMMDD((string)trim(stringlib.stringfilterout(L.CaptureDateTime,'.>$!%*@=?&\''),left,right)); 
			vCaptureDateTime 	:= (unsigned)trim(stringlib.stringfilterout(L.CaptureDateTime,'-/:T'),left,right);
			X_Coordinate := (real8) L.X_Coordinate;
			Y_Coordinate := (real8) L.Y_Coordinate;
			self.quarantine_code := map(	
										X_Coordinate = 0.0 or Y_Coordinate = 0.0 => 1,		// Missing X/Y Coordinates
										(X_Coordinate != 0.0 or Y_Coordinate != 0.0) and (R.BoundingBoxSouthWestLat > Y_Coordinate) or (R.BoundingBoxNorthEastLat < Y_Coordinate) or (R.BoundingBoxSouthWestLong > X_Coordinate) or (R.BoundingBoxNorthEastLong < X_Coordinate) => 2, 	// LPR Out of bounds										
										vCaptureDateTimeF > (string8)std.date.today() => 3,   // Future CaptureDateTime	
										0);	
													
			self.base64										:= FALSE;
			SELF.boundingBoxSouthWestLat 	:= R.boundingBoxSouthWestLat;
			SELF.boundingBoxSouthWestLong	:= R.boundingBoxSouthWestLong;
			SELF.boundingBoxNorthEastLat		:= R.boundingBoxNorthEastLat;
			SELF.boundingBoxNorthEastLong	:= R.boundingBoxNorthEastLong;			
			SELF :=	L;
		END;
		
		LPR := join(LPR_input, 
							 dpl, 
							(unsigned4)left.ORI = right.dataProviderID, 
							DataProvider_Base_T(LEFT,RIGHT),
							left outer,
							LOOKUP);	
		
						
		RETURN LPR;	
	ENDMACRO;		
	
	
	EXPORT MAC_Lpr(LPRExt) := FUNCTIONMACRO 
		return project(LPRExt, layouts.lpr_dbo_LicensePlate_In_extended - [quarantine_code]);
	ENDMACRO;		

	EXPORT MAC_deletes_events(EVENTS_delete_input) := FUNCTIONMACRO

		bair.layouts.Agency_Deletes temp_mos_deletes (EVENTS_delete_input L) := TRANSFORM
			self.field1				:= 'EVENTS';
			self.field2 			:= (string)L.ori;
			self.field3				:= L.IR_Number;
		END;
		
		p1 := project(
					EVENTS_delete_input,
					temp_mos_deletes(LEFT)
				);

		RETURN p1;
	ENDMACRO;

	EXPORT MAC_deletes_cfs(CFS_delete_input) := FUNCTIONMACRO

		bair.layouts.agency_deletes temp_cfs_deletes (CFS_delete_input L) := TRANSFORM
			self.field1				:= 'CFS';
			self.field2 			:= (string)L.ori;
			self.field3				:= L.event_number;
		END;
		
		p1 := project(
					CFS_delete_input,
					temp_cfs_deletes(LEFT)
				);

		RETURN p1;
	ENDMACRO;

 	EXPORT MAC_deletes_crash(CFS_delete_input, pUseProd = false, pUseDelta = false) := FUNCTIONMACRO
   
   		bair.layouts.Agency_Deletes temp_crash_deletes (CFS_delete_input L) := TRANSFORM
   			self.field1				:= 'CRASH';
   			self.field2 			:= (string)L.dataProviderId;
   			self.field3				:= L.caseNumber;
   		END;
   		
   		p1 := project(
   					CFS_delete_input,
   					temp_crash_deletes(LEFT)
   				);
   
   		RETURN p1;  
   	ENDMACRO;
   
   	EXPORT MAC_deletes_offenders(OFFENDER_delete_input, pUseProd = false, pUseDelta = false) := FUNCTIONMACRO
   
   		bair.layouts.Agency_Deletes temp_offenders_deletes (OFFENDER_delete_input L) := TRANSFORM
   			self.field1				:= 'OFFENDERS';
   			self.field2 			:= (string)L.data_provider_id;
   			self.field3				:= L.agency_offender_id;

   		END;
   		
   		p1 := project(
   					OFFENDER_delete_input,
   					temp_offenders_deletes(LEFT)
   				);
   
   		RETURN p1;
   	ENDMACRO;
   
   	EXPORT MAC_deletes_lpr(pFile, pUseProd = false, pUseDelta = false) := FUNCTIONMACRO
   
   		bair.layouts.agency_deletes temp_lpr_deletes (layouts.SprayedLPRXML L) := TRANSFORM
   			self.field1				:= 'LPR';
   			self.field2 			:= L.ORI;
   			self.field3				:= L.EventNumber;

   		END;
   		
   		p1 := project(
   					files().lpr_delete,
   					temp_lpr_deletes(LEFT)
   				);
   
   		RETURN p1;
   	ENDMACRO;

	
END;