IMPORT iesp, Address, didville;

EXPORT Get_Lexid (	iesp.share.t_Name Name, 
                        iesp.share.t_date dob,
                        STRING9 SSN,
                        STRING25 DLNumber,
                        STRING2 DLState,
                        Address.ICleanAddress	clean_addr) := FUNCTION
  {DidVille.Layout_did_inbatch, unsigned6 did} create_request() := TRANSFORM
    SELF.seq 					:= 1;
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
    SELF 							:= [];
  END;
  ds_in_nodids 				:= DATASET([create_request()]);

  didville.MAC_DidAppend(ds_in_nodids, ds_in_append_local, TRUE, ''); 
  resolved_lexid 			:= ds_in_append_local(did > 0 AND score >= Constants.DID_SCORE_THRESHOLD)[1].did;
  RETURN resolved_lexid;
END;