EXPORT	Layout_History xNewHistory(Layout_gongMaster mstr) := TRANSFORM
		self.bell_id := 'NEU';
		//self.current_record_flag := 'Y';
		//self.deletion_date := '';		// all new records
		self.dt_first_seen := mstr.dt_first_seen;
		self.dt_last_seen := mstr.dt_last_seen;
		
			// temp fix for professional records
					self.listing_type_res := MAP(
									UC(mstr.record_type) = 'R' => 'R',
									mstr.record_type='P' AND mstr.nametype='P' => 'R',
								'');
		self.phone10 := mstr.phone10;
		self.listed_name := mstr.company_name;
		self.sequence_number := (string)mstr.sequence_number;
		//self.persistent_record_id := 0;
		// names are cleaned
		//self.nid := mstr.nid;
		//self.nametype := mstr.nametype;
		//self.name_ind := mstr.name_ind;
		self.pclean := mstr.record_id;		// we don't need pclean, but we do need the record id
		
		/* fields are no longer populated in new records and need to be populated for history */
		self.v_predir := mstr.predir ;
		self.v_prim_name := mstr.prim_name ;
		self.v_suffix := mstr.suffix ;
		self.v_postdir := mstr.postdir ;	
		self := mstr;
		self := [];
	END;
	