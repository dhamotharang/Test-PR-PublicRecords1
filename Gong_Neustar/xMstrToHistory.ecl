EXPORT Layout_History xMstrToHistory(Layout_gongMaster mstr, string update_date='') := TRANSFORM
		self.bell_id := 'NEU';
		self.current_record_flag := 'Y';
		self.deletion_date := '';		// all new records
		self.dt_first_seen := mstr.add_date;
		self.dt_last_seen := if(update_date='', mstr.dt_last_seen, update_date);
		
		self.phone10 := mstr.phone10;
		self.listed_name := mstr.company_name;
		self.sequence_number := (string)mstr.sequence_number;
		
		// names are cleaned
		//self.nid := mstr.nid;
		//self.nametype := mstr.nametype;
		//self.name_ind := mstr.name_ind;
		self.pclean := mstr.record_id;
		
		/* fields are no longer populated in new records and need to be populated for history */
		self.v_predir := mstr.predir ;
		self.v_prim_name := mstr.prim_name ;
		self.v_suffix := mstr.suffix ;
		self.v_postdir := mstr.postdir ;	
		self := mstr;
		self := [];
	END;