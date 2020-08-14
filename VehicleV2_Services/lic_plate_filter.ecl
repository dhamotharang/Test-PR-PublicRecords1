IMPORT doxie, VehicleV2_Services;

EXPORT lic_plate_filter(DATASET(asSORTed_layouts.lic_plate_key_payload_fields) pre_DEDUP,UNSIGNED return_count,UNSIGNED starting_record,
    UNSIGNED penalt_threshold,UNSIGNED max_results, UNSIGNED in_LIMIT,UNSIGNED dppa_purpose,STRING1 state_type_val)
  := MODULE
  
    sort_fields_rec := RECORD
      STRING30 Vehicle_Key;
      STRING15 Iteration_Key;
      STRING15 Sequence_Key;
      BOOLEAN is_current;
      UNSIGNED4 date;
      UNSIGNED2 party_penalty;
      STRING1 state_type;
    END;
    
    sort_fields_rec get_penalt(assorted_layouts.lic_plate_key_payload_fields l):=TRANSFORM
      SELF.party_penalty := doxie.FN_Tra_Penalty_SSN(l.use_ssn) +
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
      SELF := l;
    END;
    
    
    w_penalt := PROJECT(pre_dedup,get_penalt(LEFT));

    srt_w_penalt := SORT(w_penalt,vehicle_key,iteration_key,sequence_key);
    
    w_penalt_group0 := GROUP(srt_w_penalt,vehicle_key,iteration_key,sequence_key);
    
    VehicleV2_Services.Mac_DppaCheck(w_penalt_group0,w_penalt_group)
    // Date and is_current should be uniform across group within the key. This is because during key build
    // we only took the latest date per group and is current is always the same per group in the data
    
    SORT_fields_rec get_fields_trickle(w_penalt_group l, DATASET(RECORDOF(w_penalt_group)) r) :=TRANSFORM
      SELF.party_penalty :=min(r,party_penalty);
      SELF.state_type := min(r,state_type);
      SELF := l;
    END;

    veh_res_trickle0 := UNGROUP(ROLLUP(w_penalt_group,GROUP,get_fields_trickle(LEFT,rows(LEFT))));
        
    rep_w_seq :=RECORD
      veh_res_trickle0;
      UNSIGNED2 seq_srt;
      UNSIGNED2 seq_srt2 :=0;
    END;
    
    rep_w_seq add_seq(veh_res_trickle0 l,INTEGER C):=TRANSFORM
      SELF.seq_srt := C;
      SELF := l;
    END;
    
    // if state type is 'A' that means moxie search with state_origin input so we only want records
    // where the state origin field matches. If state type is 'B' that means moxie search with state input
    // so we only want records where the state origin or the state fields match the input. This excludes
    // previously registered states
    state_type_set := IF(state_type_val='A',['A'],['A','B']);

    vehs_wseq0 := PROJECT(SORT(veh_res_trickle0(party_penalty < penalt_threshold AND (state_type_val='C' OR state_type in state_type_set) ),
      party_penalty,IF(is_current,0,1), -Date, - ((UNSIGNED) sequence_key[1..6])), add_seq(LEFT,COUNTER));

    rep_w_seq roll_seq(vehs_wseq0 l,vehs_wseq0 r):=TRANSFORM
      SELF.seq_srt := IF(l.vehicle_key=r.vehicle_key,l.seq_srt,r.seq_srt);
      SELF.seq_srt2 := r.seq_srt;
      SELF := r;
    END;
    
    vehs0 := iterate(SORT(vehs_wseq0,vehicle_key,seq_srt),roll_seq(LEFT,RIGHT));

    SHARED vehs1 := CHOOSEN(vehs0,max_results);
    
    SHARED vehs2 := CHOOSEN(SORT(vehs1, seq_srt,seq_srt2),
    return_Count,starting_Record);
    
    vehs3 := PROJECT(vehs2,TRANSFORM(VehicleV2_Services.Layout_VehKey_wseq,SELF:=LEFT,SELF.seq:=COUNTER));
    
    EXPORT recs := IF(in_LIMIT = 0,vehs3,CHOOSEN(vehs3,in_LIMIT));
    EXPORT cnt := COUNT(vehs1);

  END;
