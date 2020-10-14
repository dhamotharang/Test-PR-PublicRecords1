IMPORT iesp, Address, dx_gateway, didville;

EXPORT Get_HeaderData (	iesp.share.t_Name Name, 
												iesp.share.t_date dob,
												STRING9 SSN,
												STRING25 DLNumber,
												STRING2 DLState,
												Address.ICleanAddress	clean_addr) := FUNCTION
	dx_gateway.Layouts.common_optout create_request() := TRANSFORM
		SELF.dob 					:= iesp.ECL2ESP.DateToString(DOB);
    SELF.prim_range 	:= clean_addr.prim_range;
    SELF.predir 			:= clean_addr.predir;
    SELF.prim_name 		:= clean_addr.prim_name;
    SELF.addr_suffix 	:= clean_addr.suffix;
    SELF.postdir 			:= clean_addr.postdir;
    SELF.unit_desig 	:= clean_addr.unit_desig;
    SELF.sec_range 		:= clean_addr.sec_range;
    SELF.p_city_name 	:= clean_addr.p_city;
    SELF.st 					:= clean_addr.state;
    SELF.z5 					:= clean_addr.zip;
    SELF.zip4 				:= clean_addr.zip4;
		SELF.fname 				:= Name.First;
		SELF.mname 				:= Name.middle;
		SELF.lname 				:= Name.Last;
		SELF.suffix 			:= Name.suffix;
		SELF.title 				:= Name.Prefix;
		SELF.ssn 					:= SSN;
		SELF.dl_nbr 			:= DLNumber;
		SELF.dl_state 		:= DLState;
     
		SELF.global_sid 	:= Constants.CCPA_Global_SourceID;
    SELF.record_sid 	:= 0;
    SELF.did 					:= 0;
    SELF.seq 					:= 1;
    SELF.transaction_id := '';
		SELF 							:= [];
	END;
	ds_in_nodids 				:= DATASET([create_request()]);

  didville.MAC_DidAppend(ds_in_nodids, ds_in_append_local, TRUE, ''); 
  rec_in_append 			:= JOIN(ds_in_nodids, ds_in_append_local, 
													LEFT.seq		 = RIGHT.seq AND
													RIGHT.score >= dx_gateway.Constants.DID_SCORE_THRESHOLD, 
													TRANSFORM(dx_gateway.Layouts.common_optout, 
														SELF.did 	:= if(RIGHT.did > 0, RIGHT.did, LEFT.did);
														SELF 			:= LEFT), 
													LEFT OUTER, KEEP(1), LIMIT(0)); 
	
  resolved_lexid 			:= rec_in_append[1].did;
	RETURN resolved_lexid;
END;