import Gateway, doxie;

input_layout:=BatchServices.Layouts.RTPhones.rec_batch_RTPhones_input;									

export fillInhouse(BatchServices.RealTimePhones_Params.params gmod,
  dataset(input_layout) f_in,
  dataset(Gateway.Layouts.Config) in_gateways,
  string20 searchType,
  doxie.IDataAccess mod_access) := function
									
  IH_ds := f_in;									
	flat_out := BatchServices.Layouts.RTPhones.rec_output_internal;
	flat_out norm_resp(flat_out Rs) := transform
		self := Rs ;
	end;
	IH_resp := normalize(IH_ds,left.results,norm_resp(right));
	// make a request ds out of the previous responses from inhouse search
	f_in switch_trans(IH_resp L, integer c) := transform
		// must have a unique acctno when calling BatchServices.RealTimePhones_Gateway
		self.acctno := if (l.line_type <> '',skip,trim(l.acctno) + intformat(c,3,1));
		self.phoneno := l.phone;
		self.requeststatus := l.responsestatus;
		self.orig_acctno := l.acctno;  // for logging purpose in the gateway
		self := [];
	end;
	GW_Req := project(IH_resp, switch_trans(left,counter));  
	// remove rows from the request file when there is already a gateway response from a different row but the same phone number 
	notsent := join(gw_req,ih_resp,left.phoneno=right.phone and right.line_type <> '',transform(input_layout,self := left),left only);
	gw_d := dedup(sort(notsent,phoneno),phoneno);  
	GW := BatchServices.RealTimePhones_Gateway(gw_d, in_gateways, gmod, searchType, mod_access);
	GW_resp := normalize(GW,left.results,norm_resp(right));
	
	flat_out comb_tran_response (flat_out LF,flat_out RF) := transform
		  self.acctno := lf.acctno;
			self.seq := lf.seq;
			self.ssn := lf.ssn; 
			self.DID := lf.DID; 
      self.phone := lf.phone;                            
			self.name := lf.name;
			self.callerid_name := lf.callerid_name;
			self.address := lf.address;
			self.city := lf.city;
			self.state := lf.state;
			self.zip := lf.zip;
			self.responsestatus := lf.responsestatus;
			self.dt_last_seen := lf.dt_last_seen;
			self.dt_first_seen := lf.dt_first_seen;
			self.listing_creation_date := lf.listing_creation_date;
			self.listing_transaction_date := lf.listing_transaction_date ;
			self.latitude := lf.latitude;
			self.longitude := lf.longitude;
			self.carrier_route := lf.carrier_route;
			self.sort_zone := lf.sort_zone;
			self.fips := lf.fips;
			self.msa := lf.msa ;
			self.cmsa := lf.cmsa;
			self.congressional_district := lf.congressional_district;
							
			self := if (lf.line_type <> '',lf,rf);
	end;
	// add the new responses to the responses that were only from inhouse search
	presort_Resp := join(IH_resp,GW_resp,left.phone=right.phone,comb_tran_response(left,right),left outer);
	// sort the 'PV' rows on top in case there are multiple rows for the same phone number... the join will get the PV this way
	resp := sort(presort_resp,phone,-line_type);
	// fill in the same phone numbers that had hits from previous gateway searches
	final_fill := join(resp,resp,left.phone = right.phone and left.line_type = '' and right.line_type <> '',comb_tran_response(left,right),keep(1),left outer);
	input_layout DeNormThem(input_layout L, DATASET(flat_out) R) := TRANSFORM
		SELF.resultcount := COUNT(R);  
		SELF.results := choosen(sort(R,responseStatus,-dt_last_seen,-dt_first_seen),gmod.maxResults);
		SELF := L;
	END;
	DeNormed := DENORMALIZE(IH_ds, final_fill,LEFT.acctno = RIGHT.acctno,GROUP,DeNormThem(LEFT,ROWS(RIGHT)));
	return DeNormed;
end;
