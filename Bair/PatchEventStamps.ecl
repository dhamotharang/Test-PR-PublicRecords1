import STD;

EXPORT PatchEventStamps	:= module
												
		
		EXPORT UpdatePer(dataset(bair.layouts.dbo_event_persons_final_Base)  basePers) := FUNCTION
				
		//Code to calculate  personstamp in persons
		dPers 	:= 	distribute(basePers, hash(eid));
		dPers_1	:=	dPers(regexfind('SUSPECT|ARREST', trim(name_type, left, right), nocase));
		dPers_2	:=	dPers(~regexfind('SUSPECT|ARREST', trim(name_type, left, right), nocase) and regexfind('VICTIM', trim(name_type, left, right), nocase));
		dPers_3	:=	dPers(~regexfind('SUSPECT|ARREST|VICTIM', trim(name_type, left, right), nocase));

		SortedSet_p1	:= SORT(dPers_1, ori, ir_number
												,STD.Str.ToUpperCase(trim(last_name,left,right))
												,STD.Str.ToUpperCase(trim(first_name,left,right))
												,STD.Str.ToUpperCase(trim(middle_name,left,right))									
												,local);
												
		GroupedSet_p1	:= GROUP(SortedSet_p1, eid);

		{GroupedSet_p1, unsigned rownum, unsigned stampGroupNum} AddRowNum(GroupedSet_p1 L, integer C, unsigned stampGroupNum) := transform
				self.rownum := C - 1;
				self.stampGroupNum := stampGroupNum;
				self := L;
		end;

		pers_w_rownum1 		:= project(GroupedSet_p1, AddRowNum(left, counter, 1));
		ug_pers_w_rownum1 := UNGROUP(pers_w_rownum1);

		SortedSet_p2			:= SORT(dPers_2, eid
												,STD.Str.ToUpperCase(trim(last_name,left,right))
												,STD.Str.ToUpperCase(trim(first_name,left,right))
												,STD.Str.ToUpperCase(trim(middle_name,left,right))									
												,local);
												
		GroupedSet_p2			:= GROUP(SortedSet_p2, eid);
		pers_w_rownum2 		:= project(GroupedSet_p2, AddRowNum(left, counter, 2));
		ug_pers_w_rownum2 := UNGROUP(pers_w_rownum2);

		SortedSet_p3			:= SORT(dPers_3, eid
												,STD.Str.ToUpperCase(trim(name_type,left,right))
												,STD.Str.ToUpperCase(trim(last_name,left,right))
												,STD.Str.ToUpperCase(trim(first_name,left,right))
												,STD.Str.ToUpperCase(trim(middle_name,left,right))									
												,local);
												
		GroupedSet_p3			:= GROUP(SortedSet_p3, eid);
		pers_w_rownum3 		:= project(GroupedSet_p3, AddRowNum(left, counter, 3));
		ug_pers_w_rownum3 := UNGROUP(pers_w_rownum3);

		pers_w_rownum 		:= ug_pers_w_rownum1 + ug_pers_w_rownum2 + ug_pers_w_rownum3;

		SortedSet_p				:= SORT(pers_w_rownum, eid
												,stampGroupNum
												,rownum									
												,local);
												
		SortedSet_p AddStamp(SortedSet_p L, integer C) := transform
				self.personstamp := C - 1;
				self := L;
		end;

		GroupedSet_p			:= GROUP(SortedSet_p, eid);
		pers_w_stamp 		  := project(GroupedSet_p, AddStamp(left, counter));
		ug_pers_w_stamp 	:= UNGROUP(pers_w_stamp);
		
		persons := project(ug_pers_w_stamp, {basePers});
		return persons;
		
		END;
		
		EXPORT UpdateVeh(dataset(bair.layouts.dbo_event_vehicle_final_Base)  baseVeh) := FUNCTION
		
		//Code to calculate  vehicletamp in vehicle		
		dVeh := distribute(baseVeh, hash(ori, ir_number));
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

		vehicle := project(ug_veh_w_stamp, {baseVeh});
		
		return vehicle;
		
		END;
	
END;