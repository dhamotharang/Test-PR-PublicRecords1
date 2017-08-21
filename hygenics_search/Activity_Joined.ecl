import CrimSrch, Crim_Common, hygenics_crim;

hygenics_crim.layout_activity tDOCtoCrimSrchActivity(Crim_Common.Layout_In_Court_Activity pInput):= transform
	self.conviction_override_date				:= if((integer4)pInput.event_date=0,
																				pInput.process_date,
																				pInput.event_date);
	self.conviction_override_date_type	:= if(self.conviction_override_date = '',
																				'',
																				'E');	
				
	filterField(String s) := FUNCTION
		return StringLib.StringFilter(StringLib.StringToUpperCase(s),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ');
	END;
				
			Voff_comp 						:= filterField(pInput.off_comp);
			//Vcase_number 				:= filterField(l.case_number);
			Vevent_type 					:= filterField(pInput.event_type);
			Vevent_sort_key 			:= filterField(pInput.event_sort_key);
			Vevent_date 					:= filterField(pInput.event_date);
			Vevent_location_code 	:= filterField(pInput.event_location_code);
			Vevent_location_desc 	:= filterField(pInput.event_location_desc);
			Vevent_desc_code 			:= filterField(pInput.event_desc_code);
			Vevent_desc_1 				:= filterField(pInput.event_desc_1);
			Vevent_desc_2 				:= filterField(pInput.event_desc_2);
			
	self.activity_persistent_id				:= hash64(trim(pInput.offender_key, left, right) +
																							Voff_comp +
																							trim(pInput.case_number, left, right) +
																							Vevent_type +
																							Vevent_sort_key +
																							Vevent_date +
																							Vevent_location_code +
																							Vevent_location_desc +
																							Vevent_desc_code +
																							Vevent_desc_1 +
																							Vevent_desc_2);
	self 																:= pInput;
end;

lActivityProcessed := project(File_In_Court_Activity,tDOCtoCrimSrchActivity(left)): persist('persist::CrimSrch_Activity_Joined');

export Activity_Joined := lActivityProcessed;