import dx_gateway,did_add,AutoKeyI,suppress,targus,Doxie,STD;
/********************************************************************
Map Targus Gateway Log into base layout
/********************************************************************/
EXPORT Map_GatewayLog_Targus := function

// Decode the base64 field and extract the xml request and response
infile_decoded := gateway_collection_log.File_reader_targus.decodeFile(gateway_collection_log.Files(,false).TargusIn);
req_formatted  := gateway_collection_log.File_reader_targus.formatRequest(infile_decoded);
resp_formatted := gateway_collection_log.File_reader_targus.formatResponse(infile_decoded);

// output(req_formatted, named('req_formatted'));
// output(resp_formatted, named('resp_formatted'));

req_parsed := dx_gateway.parser_targus.parseRequest(req_formatted);
resp_parsed := dx_gateway.parser_targus.parseResponse(resp_formatted);

// output(req_parsed, named('req_parsed'));
// output(resp_parsed, named('resp_parsed'));

//****************************************************************************/
mod_access := MODULE(doxie.IDataAccess)END;
dx_gateway.mac_append_did(req_parsed, d_req_did_append, mod_access, TRUE,['A','P','Z']);
d_req_did_optout := Suppress.MAC_FlagSuppressedSource(d_req_did_append, mod_access, did);

// output(d_req_did_append, named('req_parsed_with_dids'));
// output(d_req_did_optout, named('req_parsed_with_dids_optout'));	

dx_gateway.mac_append_did(resp_parsed, d_resp_did_append, mod_access, TRUE,['A','P','Z']);
d_resp_did_optout := Suppress.MAC_FlagSuppressedSource(d_resp_did_append, mod_access, did);

// output(d_resp_did_append, named('resp_parsed_with_dids'));
// output(d_resp_did_optout, named('resp_parsed_with_dids_optout'));

/*********************************************************************************/

d_req_clean := dx_gateway.parser_targus.cleanRequest(req_formatted, mod_access, d_req_did_optout);
d_resp_clean := dx_gateway.parser_targus.cleanResponse(resp_formatted, mod_access, d_resp_did_optout);	

dfiltered_resp_did_optout := d_resp_did_optout(STD.Str.FilterOut(ssn+dob+phone10+fname+mname+lname+prim_range+predir+prim_name+
                                               addr_suffix+postdir+unit_desig+sec_range+p_city_name+st+zip4+email,' ')<>'');

/*** Put everything together to create a base record. Input + req and resp Common layout field + Decoded Json strin for request and response ***/
gateway_collection_log.Layouts.Baselayout FullRecReq(infile_decoded L,d_req_did_optout R):=transform
   self.process_date          := (STRING8)Std.Date.Today();
   self.request_did           := R.did        ;
   self.request_ssn           := R.ssn        ;
   self.request_dob           := R.dob        ;
   self.request_phone10       := R.phone10    ;
   self.request_title         := R.title      ;
   self.request_fname         := R.fname      ;
   self.request_mname         := R.mname      ;
   self.request_lname         := R.lname      ;
   self.request_suffix        := R.suffix     ;
   self.request_prim_range    := R.prim_range ;
   self.request_predir        := R.predir     ;
   self.request_prim_name     := R.prim_name  ;
   self.request_addr_suffix   := R.addr_suffix;
   self.request_postdir       := R.postdir    ;
   self.request_unit_desig    := R.unit_desig ;
   self.request_sec_range     := R.sec_range  ;
   self.request_p_city_name   := R.p_city_name;
   self.request_st            := R.st         ;
   self.request_z5            := R.z5         ;
   self.request_zip4          := R.zip4       ;
   self.request_email         := R.email      ; 
	 self.global_sid            := R.global_sid ;
	 self.date_added            := stringlib.stringfindreplace(L.date_added[1..10],'-','');
	 self.time_added            := stringlib.stringfindreplace(L.date_added[12..19],':','');
	 self.request_err_addr 	 	  := R.err_addr   ; // for address cleaner error messages ONLY 
	 self.request_err_search 	  := R.err_search ;  // standard search errors; can contain ONLY standard error codes (or combination of thereof)
	 self.request_error_code 	  := R.error_code ;
   self.requestis_suppressed  := R.is_suppressed;
   self.lexid_in              := (integer)L.lexid_in;
   self := L;
	 self.record_sid            := 0;
	 self.cln_request_data      := '';
	 self.cln_response_data     := '';
	 self := [];
end;
d_InputWithParsedReq := join(infile_decoded,d_req_did_optout,left.seq =right.seq,FullRecReq(left,right),left outer);

gateway_collection_log.Layouts.Baselayout FullRecResp(d_InputWithParsedReq L,dfiltered_resp_did_optout R):=transform
   self.response_section_id    := R.section_id ;
   self.response_did           := R.did        ;
   self.response_ssn           := R.ssn        ;
   self.response_dob           := R.dob        ;
   self.response_phone10       := R.phone10    ;
   self.response_title         := R.title      ;
   self.response_fname         := R.fname      ;
   self.response_mname         := R.mname      ;
   self.response_lname         := R.lname      ;
   self.response_suffix        := R.suffix     ;
   self.response_prim_range    := R.prim_range ;
   self.response_predir        := R.predir     ;
   self.response_prim_name     := R.prim_name  ;
   self.response_addr_suffix   := R.addr_suffix;
   self.response_postdir       := R.postdir    ;
   self.response_unit_desig    := R.unit_desig ;
   self.response_sec_range     := R.sec_range  ;
   self.response_p_city_name   := R.p_city_name;
   self.response_st            := R.st         ;
   self.response_z5            := R.z5         ;
   self.response_zip4          := R.zip4       ;
   self.response_email         := R.email      ; 
	 self.global_sid             := R.global_sid ;
	 self.response_err_addr 	 	 := R.err_addr   ;  // for address cleaner error messages ONLY 
	 self.response_err_search 	 := R.err_search ;  // standard search errors; can contain ONLY standard error codes (or combination of thereof)
	 self.response_error_code 	 := R.error_code ;
   self.responseis_suppressed  := R.is_suppressed; 
   self := L;
   SELF := [];
end;
d_InputWithParsedReqResp := join(d_InputWithParsedReq,dfiltered_resp_did_optout,left.seq =right.seq,FullRecResp(left,right),left outer);

gateway_collection_log.Layouts.Baselayout FullRecReqcln(d_InputWithParsedReqResp L,d_req_clean R):=transform

   self.cln_request_data := (string)tojson(ROW({R.gatewayparams,R.user,R.options,R.searchby},Targus.Layout_Targus_In));
   self := L;
end;
d_InputWithclnReq := join(d_InputWithParsedReqResp,d_req_clean,left.seq =(UNSIGNED) right.User.QueryId,FullRecReqcln(left,right),left outer);

gateway_collection_log.Layouts.Baselayout FullRecRespTemp(d_InputWithclnReq L,d_resp_clean R):=transform

   //Clear the enhancedata/PhoneDataExpressSearchResult depending upon the selection ID In case they contain different people.
	 self.temp_response_data1.Response.VerifyExpressResult.EnhancedData:= MAP(L.response_section_id =1 => row([],targus.Layout_Targus_out.Response.VerifyExpressResult.EnhancedData),
	                                                                          R.Response.VerifyExpressResult.EnhancedData);
	 self.temp_response_data1.Response.PhoneDataExpressSearchResult    := MAP(L.response_section_id =2 => row([],targus.Layout_Targus_out.Response.PhoneDataExpressSearchResult),
	                                                                          R.Response.PhoneDataExpressSearchResult);
	 self.temp_response_data1.Response.VerifyExpressResult.errorcode   := R.Response.VerifyExpressResult.errorcode;
	 self.temp_response_data1.Response.VerifyExpressResult.matchresults:= R.Response.VerifyExpressResult.matchresults;
   self.temp_response_data1.Response.VerifyExpressResult.inputverification := R.Response.VerifyExpressResult.inputverification;
   self.temp_response_data1.searchby                                 := R.searchby;
	 self.temp_response_data1.Response.Header                          := R.Response.Header; 
	 self.temp_response_data1.Response.WirelessConnectionSearchResult  := R.Response.WirelessConnectionSearchResult;   
	 self.temp_response_data1.Response.USPhoneDataExpressSearchResult  := R.Response.USPhoneDataExpressSearchResult; 
	 self.temp_response_data1.Response.NameVerificationSearchResult    := R.Response.NameVerificationSearchResult;
   self.cln_response_data := '';   
   self := L;
end;
d_InputWithTempResp := join(d_InputWithclnReq,d_resp_clean,left.seq =(UNSIGNED) right.Response.Header.QueryId,FullRecRespTemp(left,right),left outer);

gateway_collection_log.Layouts.Baselayout FullRecRespcln(d_InputWithTempResp L):=transform
	 
	 self.cln_response_data := (string)tojson(L.temp_response_data1);
   
   self := L;
end;

d_withJSonResp := Project(d_InputWithTempResp,FullRecRespcln(left));
return d_withJSonResp;
END;

