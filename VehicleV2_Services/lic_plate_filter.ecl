import doxie, VehicleV2_Services;

export 	lic_plate_filter(dataset(assorted_layouts.lic_plate_key_payload_fields) pre_dedup,unsigned return_count,unsigned starting_record,
		unsigned penalt_threshold,unsigned max_results, unsigned in_limit,unsigned dppa_purpose,string1 state_type_val)
	:= MODULE
	
		sort_fields_rec := record
		string30 Vehicle_Key;
		string15 Iteration_Key;
		string15 Sequence_Key;
		boolean is_current;
		unsigned4 date;
		unsigned2 party_penalty;
		string1 state_type;
		end;
		
		sort_fields_rec get_penalt(assorted_layouts.lic_plate_key_payload_fields l):=transform
			self.party_penalty :=	doxie.FN_Tra_Penalty_SSN(l.use_ssn) +
							doxie.FN_Tra_Penalty_Name(l.fname, 
								l.mname, l.lname)+ 
							doxie.FN_Tra_Penalty_Addr(l.predir,
								l.prim_range, 
								l.prim_name,
								l.addr_suffix, 
								l.postdir,
								l.sec_range,
								l.v_city_name,
								l.State_origin, l.zip5)+
								doxie.FN_Tra_Penalty_CName(l.append_clean_cname);
			self := l;
		END;
		
		
		w_penalt := project(pre_dedup,get_penalt(left));

		srt_w_penalt :=	sort(w_penalt,vehicle_key,iteration_key,sequence_key);
		
		w_penalt_group0 := group(srt_w_penalt,vehicle_key,iteration_key,sequence_key);
		
		VehicleV2_Services.Mac_DppaCheck(w_penalt_group0,w_penalt_group)
		// Date and is_current should be uniform across group within the key. This is because during key build
		// we only took the latest date per group and is current is always the same per group in the data
		
		sort_fields_rec get_fields_trickle(w_penalt_group l, dataset(recordof(w_penalt_group)) r) :=transform
			self.party_penalty :=min(r,party_penalty);
			self.state_type := min(r,state_type);
			self := l;
		END;



		veh_res_trickle0 := ungroup(rollup(w_penalt_group,group,get_fields_trickle(left,rows(left))));			
				

		rep_w_seq :=record
			veh_res_trickle0;
			unsigned2 seq_srt;
			unsigned2 seq_srt2 :=0;
		end;
		
		rep_w_seq add_seq(veh_res_trickle0 l,integer C):=transform
			self.seq_srt := C;
			self := l;
		END;
		
		
		// if state type is 'A' that means moxie search with state_origin input so we only want records
		// where the state origin field matches. If state type is 'B' that means moxie search with state input
		// so we only want records where the state origin or the state fields match the input. This excludes
		// previously registered states
		state_type_set := if(state_type_val='A',['A'],['A','B']);

		vehs_wseq0 := project(sort(veh_res_trickle0(party_penalty < penalt_threshold and (state_type_val='C' or state_type in state_type_set) ),
			party_penalty,if(is_current,0,1), -Date, - ((unsigned) sequence_key[1..6])), add_seq(left,counter));

		rep_w_seq roll_seq(vehs_wseq0 l,vehs_wseq0 r):=transform
			self.seq_srt := if(l.vehicle_key=r.vehicle_key,l.seq_srt,r.seq_srt);
			self.seq_srt2 := r.seq_srt;
			self := r;
		END;
		
		vehs0 := iterate(sort(vehs_wseq0,vehicle_key,seq_srt),roll_seq(left,right));

		shared vehs1 := choosen(vehs0,max_results);
		
		shared vehs2 := choosen(sort(vehs1, seq_srt,seq_srt2),
		return_Count,starting_Record);
		
		vehs3 := project(vehs2,transform(VehicleV2_Services.Layout_VehKey_wseq,self:=left,self.seq:=counter));
		
		export recs := if(in_limit = 0,vehs3,choosen(vehs3,in_limit));
		export cnt := count(vehs1);			

	end;