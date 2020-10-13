EXPORT Mapping_Common_Spoofing(string8 version) := FUNCTION

	inFile := PhoneFraud.File_Spoofing.Raw;

	//Normalize Phones for Index
	PhoneFraud.Layout_Spoofing.Base spoofTr(inFile l, integer1 c) :=transform	
		self.date_file_loaded			:= version[1..8];
		self.reference_id					:= _Functions.rmNull(l.reference_id);
		self.mode_type						:= _Functions.rmNull(l.mode_type);
		self.account_name					:= _Functions.rmNull(l.account_name);
		
		//split event date from time
		self.event_date						:= _Functions.clNum(l.event_time)[1..8];
		self.event_time						:= _Functions.clNum(l.event_time)[9..];
		self.phone   							:= choose(c, _Functions.clNum(l.spoofed_phone_number), _Functions.clNum(l.destination_number), _Functions.clNum(l.source_phone_number));
		self.phone_origin 				:= choose(c, 'S', 'D', 'C');
																	//S - spoofing; 
																	//D - destination; 
																	//C - source;
		self.ip_address						:= _Functions.rmNull(l.ip_address);
		self.neustar_lower_bound	:= _Functions.rmNull(l.neustar_lower_bound);
		self.neustar_upper_bound	:= _Functions.rmNull(l.neustar_upper_bound);
		self.vendor								:= _Functions.rmNull(l.vendor);
		
		//split date added from time
		self.date_added						:= _Functions.clNum(l.date_added)[1..8];
		self.time_added						:= _Functions.clNum(l.date_added)[9..];
		self         							:= l;
	end;
	 
	phoneNorm 	:= normalize(inFile, 3, spoofTr(left,counter))(phone<>'');
	concatFile	:= phoneNorm; //+ PhoneFraud.File_Spoofing.Base; -20200921 change to delta update
	ddConcat 		:= dedup(sort(distribute(concatFile, hash(id)), id, phone_origin, date_file_loaded, local), record, except date_file_loaded, local);
	
	RETURN ddConcat;

END;