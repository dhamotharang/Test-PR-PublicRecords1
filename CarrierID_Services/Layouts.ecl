import FLAccidents_Ecrash,iesp;

export layouts := module

	export r_accnbr := record
		string40 accnbr;
		string   did               :='';
		boolean  found_by_deep_dive:=false;
	end;
	
	export r_payload_with_penalty := record
		FLAccidents_Ecrash.key_EcrashV2_accnbrV1;   		
		unsigned2 penalt := 0;
		boolean   found_by_deep_dive := false;
	end;

  export r_response := record 
	 (iesp.carrierid.t_CarrierIDSearchRespData)
	 string10  vehicle_incident_id :='';
   string    tmp_src             :='';	 
	 integer   dl_st_hit           :=0;
	 boolean   is_natl_inq         := false;
	 string1   hit_type            :='';
	 boolean   found_by_deep_dive  := false;
	 boolean   nneq_linkid         := true;
	 boolean   nneq_dl             := true;
	 boolean   nneq_dob            := true; 
	 unsigned2 penalt              :=0;
	 string    l_accnbr            :='';
	end;
	
end;