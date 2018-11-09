import Bair, SALT32;
EXPORT proc_GeoHash(string pversion, boolean pUseProd = false, boolean pUseDelta = false, boolean EmptyBase = false) := MODULE
	_mo_bfile_  	   			:= Bair.files('', pUseProd, pUseDelta).mo_Base.built(eid<>''      and quarantined = '0',x_coordinate<>0,         y_coordinate<>0);
	Person_bfile   			:= Bair.files('', pUseProd, pUseDelta).persons_Base.built(eid<>'' and quarantined = '0',persons_x_coordinate<>0, persons_y_coordinate<>0);
	vh_bfile       			:= Bair.files('', pUseProd, pUseDelta).vehicle_Base.built(eid<>'' and quarantined = '0',vehicle_x_coordinate<>0, vehicle_y_coordinate<>0);
	
	DataProvider 				:= bair.files().dataprovider_base.built;
	mo_bfile_ 					:= join(_mo_bfile_, DataProvider, left.ORI = right.data_provider_id
													,transform({_mo_bfile_}, self.data_provider_ori := if(left.ORI = right.data_provider_id, right.data_provider_ori, left.data_provider_ori); self := left; )
													,lookup
													,LEFT OUTER);

	mo_bfile := project(mo_bfile_, transform({mo_bfile_, boolean raidsOnly}, self.raidsOnly := if(left.le_only = '0' and left.raids = '1', true, false); self := left;));
	
	layout_mo_base := record
		mo_bfile;
		string 		moudf1			:='';
		string 		moudf2			:='';
		string 		moudf3			:='';
		string 		moudf4			:='';
		string 		moudf5			:='';
		string 		moudf6			:='';
		string 		moudf7			:='';
		string 		moudf8			:='';
	end;
	
	mo_bfile_d := project(mo_bfile, transform(layout_mo_base, self := left; self := [];));
	
	mo_udf_file := Bair.files('', pUseProd, pUseDelta).mo_udf_Base.built;			
	mo_udf_base := DISTRIBUTED(mo_udf_file(eid <> ''),hash(eid));				
	mo_udf := Sort(mo_udf_base,recordid_raids,ori,fieldid,local);
					
	layout_mo_base Denorm_MO(mo_bfile_d L, mo_udf R, Integer C) := TRANSFORM
		Self.moudf1	:= IF(C=1,if(R.string_val <> '', R.string_val, if(R.integer_val <> 0, (string)R.integer_val, if(R.decimal_val <> 0.0, (string)R.decimal_val, if(R.datetime_val<>'', R.datetime_val, R.yes_no_val)))),L.moudf1);
		Self.moudf2	:= IF(C=2,if(R.string_val <> '', R.string_val, if(R.integer_val <> 0, (string)R.integer_val, if(R.decimal_val <> 0.0, (string)R.decimal_val, if(R.datetime_val<>'', R.datetime_val, R.yes_no_val)))),L.moudf2);
		Self.moudf3	:= IF(C=3,if(R.string_val <> '', R.string_val, if(R.integer_val <> 0, (string)R.integer_val, if(R.decimal_val <> 0.0, (string)R.decimal_val, if(R.datetime_val<>'', R.datetime_val, R.yes_no_val)))),L.moudf3);
		Self.moudf4	:= IF(C=4,if(R.string_val <> '', R.string_val, if(R.integer_val <> 0, (string)R.integer_val, if(R.decimal_val <> 0.0, (string)R.decimal_val, if(R.datetime_val<>'', R.datetime_val, R.yes_no_val)))),L.moudf4);
		Self.moudf5	:= IF(C=5,if(R.string_val <> '', R.string_val, if(R.integer_val <> 0, (string)R.integer_val, if(R.decimal_val <> 0.0, (string)R.decimal_val, if(R.datetime_val<>'', R.datetime_val, R.yes_no_val)))),L.moudf5);
		Self.moudf6	:= IF(C=6,if(R.string_val <> '', R.string_val, if(R.integer_val <> 0, (string)R.integer_val, if(R.decimal_val <> 0.0, (string)R.decimal_val, if(R.datetime_val<>'', R.datetime_val, R.yes_no_val)))),L.moudf6);
		Self.moudf7	:= IF(C=7,if(R.string_val <> '', R.string_val, if(R.integer_val <> 0, (string)R.integer_val, if(R.decimal_val <> 0.0, (string)R.decimal_val, if(R.datetime_val<>'', R.datetime_val, R.yes_no_val)))),L.moudf7);
		Self.moudf8	:= IF(C=8,if(R.string_val <> '', R.string_val, if(R.integer_val <> 0, (string)R.integer_val, if(R.decimal_val <> 0.0, (string)R.decimal_val, if(R.datetime_val<>'', R.datetime_val, R.yes_no_val)))),L.moudf8);
		Self := L;
	END;
	
	
	mo := Denormalize(mo_bfile_d,mo_udf,
									left.recordid_raids=right.recordid_raids and
									left.ori = right.ori,
									Denorm_MO(left,right,counter),local);
	
	layout_per_base := record
		Person_bfile;
		string 		personudf1	:='';
		string 		personudf2	:='';
		string 		personudf3	:='';
		string 		personudf4	:='';
	end;
	
	Person_bfile_d := project(Person_bfile, transform(layout_per_base, self := left; self := [];));
	
  persons_udf_file := Bair.files('', pUseProd, pUseDelta).persons_udf_Base.built;			
	persons_udf_base := DISTRIBUTED(persons_udf_file(eid <> ''),hash(eid));				
	persons_udf := sort(persons_udf_base,recordid_raids,ori,fieldid,local);	
	
	layout_per_base Denorm_PER(Person_bfile_d L, persons_udf R, Integer C) := TRANSFORM		
			self.personudf1	:= IF(C=1,if(R.string_val <> '', R.string_val, if(R.integer_val <> 0, (string)R.integer_val, if(R.decimal_val <> 0.0, (string)R.decimal_val, if(R.datetime_val<>'', R.datetime_val, R.yes_no_val)))),L.personudf1);
			self.personudf2	:= IF(C=2,if(R.string_val <> '', R.string_val, if(R.integer_val <> 0, (string)R.integer_val, if(R.decimal_val <> 0.0, (string)R.decimal_val, if(R.datetime_val<>'', R.datetime_val, R.yes_no_val)))),L.personudf2);
			self.personudf3	:= IF(C=3,if(R.string_val <> '', R.string_val, if(R.integer_val <> 0, (string)R.integer_val, if(R.decimal_val <> 0.0, (string)R.decimal_val, if(R.datetime_val<>'', R.datetime_val, R.yes_no_val)))),L.personudf3);
			self.personudf4	:= IF(C=4,if(R.string_val <> '', R.string_val, if(R.integer_val <> 0, (string)R.integer_val, if(R.decimal_val <> 0.0, (string)R.decimal_val, if(R.datetime_val<>'', R.datetime_val, R.yes_no_val)))),L.personudf4);
			self :=L;
	END;
	
	persons := Denormalize(Person_bfile_d,persons_udf,
											left.recordid_raids=right.recordid_raids and
											left.ori = right.ori,
											Denorm_PER(left,right,counter),local);
	
	d_mo:=table(mo,{eid
									,ir_number
									,crime
									,location_type
									,object_of_attack_1
									,object_of_attack_2
									,point_of_entry_1
									,point_of_entry_2
									,suspects_actions_against_person_1
									,suspects_actions_against_person_2
									,suspects_actions_against_person_3
									,suspects_actions_against_person_4
									,suspects_actions_against_person_5
									,suspects_actions_against_property_1
									,suspects_actions_against_property_2
									,suspects_actions_against_property_3
									,property_taken_1
									,property_taken_2
									,property_taken_3
									,property_value
									,method_of_departure
									,first_date_time
									,last_date_time
									,report_date
									,address_of_crime
									,beat
									,rd
									,companions
									,apt
									,agency
									,accuracy
									,ucr_group
									,data_provider_ori
									,mostamp
									,x_coordinate
									,y_coordinate
									,longitude
									,latitude
									,First_Date
									,Last_Date
									,First_Time
									,Last_Time
									,WEAPON_TYPE_1
									,WEAPON_TYPE_2
									,Method_of_Entry_1
									,Method_of_Entry_2
									,First_Day
									,last_day
									,Address_Name
									,raidsOnly
									,moudf1
									,moudf2
									,moudf3
									,moudf4
									,moudf5
									,moudf6
									,moudf7
									,moudf8
									},record);

	d_per:=table(persons,{eid
												,name_type
												,first_name
												,middle_name
												,last_name
												,moniker
												,persons_address
												,dob
												,race
												,sex
												,hair
												,hair_length
												,eyes
												,hand_use
												,speech
												,teeth
												,physical_condition
												,build
												,complexion
												,facial_hair
												,hat
												,mask
												,glasses
												,appearance
												,shirt
												,pants
												,shoes
												,jacket
												,soundex
												,facial_recognition
												,weight_1
												,weight_2
												,height_1
												,height_2
												,age_1
												,age_2
												,persons_sid
												,personudf1
												,personudf2
												,personudf3
												,personudf4
												},record,merge,few);

	d_vh:=table(vh_bfile,{eid
												,plate
												,make
												,model
												,style
												,color
												,year
												,type
												,vehicle_status
												,vehicle_address
												,plate_state
												},record,merge,few);

		j1:=join(distributed(d_mo,hash(eid)),distributed(d_per,hash(eid))
		// j1:=join(d_mo, d_per
						,left.eid=right.eid
						,transform({d_mo,{d_per} - eid}
							,self:=left
							,self:=right
							)
						,left outer
						,local
						);

		Eve_bfile:=distribute(join(distributed(j1, hash(eid)),distributed(d_vh,hash(eid))
		// Eve_bfile:=join(j1, d_vh
						,left.eid=right.eid
						,transform({j1,{d_vh} - eid}
							,self:=left
							,self:=right
							)
						,left outer
						,local
						), hash(eid));
	
	export GeoHash_Keys() := FUNCTION
						
		Lpr_bfile_  := Bair.files('', pUseProd, pUseDelta).LPR_Base.built(eid<>'');
		cfs_bfile_ 	:= Bair.files('', pUseProd, pUseDelta).cfs_Base.built(eid<>'' and quarantined = '0');
		off_bfile_ 	:= Bair.files('', pUseProd, pUseDelta).offenders_Base.built(eid<>'' and quarantined = '0');
		intel_bfile_ := Bair.files('', pUseProd, pUseDelta).intel_Base.built(eid<>'');
		crash_bfile_ := Bair.files('', pUseProd, pUseDelta).crash_Base.built(eid<>'' and quarantined = '0');
		shot_bfile_ 	:= Bair.files('', pUseProd, pUseDelta).Shotspotter_Base.built(eid<>'');
	
		Lpr_bfile 	:= join(Lpr_bfile_, DataProvider, left.data_provider_id = right.data_provider_id
													,transform({Lpr_bfile_}, self.data_provider_ori := if(left.data_provider_id = right.data_provider_id, right.data_provider_ori, left.data_provider_ori); self := left; )
													,lookup
													,LEFT OUTER);
		
		cfs_bfile 	:= join(cfs_bfile_, DataProvider, left.data_provider_id = right.data_provider_id
													,transform({cfs_bfile_}, self.data_provider_ori := if(left.data_provider_id = right.data_provider_id, right.data_provider_ori, left.data_provider_ori); self := left; )
													,lookup
													,LEFT OUTER);
		
		off_bfile 	:= join(off_bfile_, DataProvider, left.data_provider_id = right.data_provider_id
													,transform({off_bfile_}, self.data_provider_ori := if(left.data_provider_id = right.data_provider_id, right.data_provider_ori, left.data_provider_ori); self := left; )
													,lookup
													,LEFT OUTER);
													
		intel_bfile 	:= join(intel_bfile_, DataProvider, left.data_provider_id = right.data_provider_id
													,transform({intel_bfile_}, self.data_provider_ori := if(left.data_provider_id = right.data_provider_id, right.data_provider_ori, left.data_provider_ori); self := left; )
													,lookup
													,LEFT OUTER);
		
		crash_bfile 	:= join(crash_bfile_, DataProvider, left.data_provider_id = right.data_provider_id
													,transform({crash_bfile_}, self.data_provider_ori := if(left.data_provider_id = right.data_provider_id, right.data_provider_ori, left.data_provider_ori); self := left; )
													,lookup
													,LEFT OUTER);
		
		shot_bfile 	:= join(shot_bfile_, DataProvider, left.data_provider_id = right.data_provider_id
													,transform({shot_bfile_}, self.data_provider_ori := if(left.data_provider_id = right.data_provider_id, right.data_provider_ori, left.data_provider_ori); self := left; )
													,lookup
													,LEFT OUTER);
													
		bakedEve 				:= Bair.Build_GeoHash.BakeEveFile(Eve_bfile);
		bakedLpr 				:= Bair.Build_GeoHash.BakeLprFile(Lpr_bfile);
		bakedCfs 				:= Bair.Build_GeoHash.BakeCfsFile(cfs_bfile);																		
		bakedOffenders 	:= Bair.Build_GeoHash.BakeOffenderFile(off_bfile);			
		bakedIntel 			:= Bair.Build_GeoHash.BakeIntelFile(intel_bfile);			
		bakedCrash 			:= Bair.Build_GeoHash.BakeCrashFile(crash_bfile);
		bakedShot 			:= Bair.Build_GeoHash.BakeShotSpotterFile(shot_bfile);			

		bakedOffendersReady := ROLLUP(SORT(DISTRIBUTE(bakedOffenders, HASH(eid)), eid, stamp, class, LOCAL), 
										LEFT.eid = RIGHT.eid and LEFT.stamp = RIGHT.stamp and LEFT.class = RIGHT.class,
										TRANSFORM(recordof(bakedOffenders),
												SELF.date := IF(LEFT.date>0, LEFT.date, RIGHT.date),
												SELF.class := IF(LEFT.class<>'', LEFT.class, RIGHT.class),
												SELF.ori := IF(LEFT.ori<>'', LEFT.ori, RIGHT.ori),
												SELF := LEFT
												), LOCAL);
												
		bakedOthers := bakedEve + bakedCfs + bakedIntel + bakedCrash + bakedShot + bakedLpr;
		
		bakedOthersReady := ROLLUP(SORT(DISTRIBUTE(bakedOthers, HASH(eid)), eid, stamp, LOCAL), 
										LEFT.eid = RIGHT.eid and LEFT.stamp = RIGHT.stamp,
										TRANSFORM(recordof(bakedOthers),
												SELF.date := IF(LEFT.date>0, LEFT.date, RIGHT.date),
												SELF.class := IF(LEFT.class<>'', LEFT.class, RIGHT.class),
												SELF.ori := IF(LEFT.ori<>'', LEFT.ori, RIGHT.ori),
												SELF := LEFT
												), LOCAL);
												
		bakedReady := bakedOthersReady + bakedOffendersReady;
		
		return Bair.Build_GeoHash.BuildAll(pUseProd, bakedReady, pVersion, pUseDelta, EmptyBase);
	END;
	
	export GeoHash_LPR_Keys() := FUNCTION
		
		DataProvider 				:= bair.files().dataprovider_base.built;
		Lpr_bfile_  := Bair.files('', pUseProd, pUseDelta).LPR_Base.built(eid<>'');
		Lpr_bfile 	:= join(Lpr_bfile_, DataProvider, left.data_provider_id = right.data_provider_id
									,transform({Lpr_bfile_}, self.data_provider_ori := if(left.data_provider_id = right.data_provider_id, right.data_provider_ori, left.data_provider_ori); self := left; )
									,lookup
									,LEFT OUTER);
		bakedLpr 		:= Bair.Build_GeoHash.BakeLprFile(Lpr_bfile);
		bakedLprReady := ROLLUP(SORT(DISTRIBUTE(bakedLpr, HASH(eid)), eid, stamp, LOCAL), 
										LEFT.eid = RIGHT.eid and LEFT.stamp = RIGHT.stamp,
										TRANSFORM(recordof(bakedLpr),
												SELF.date := IF(LEFT.date>0, LEFT.date, RIGHT.date),
												SELF.class := IF(LEFT.class<>'', LEFT.class, RIGHT.class),
												SELF.ori := IF(LEFT.ori<>'', LEFT.ori, RIGHT.ori),
												SELF := LEFT
												), LOCAL);		
		return Bair.Build_GeoHash.BuildLPR(pUseProd, bakedLprReady, pVersion, pUseDelta, EmptyBase);
	END;
	
END;