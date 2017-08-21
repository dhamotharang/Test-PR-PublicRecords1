import ut,iesp;

UseHThor :=
false;
// true;
HthorQueryNo := 8;

samp := 10;
toskip := 1;

inf := choosen(UPS_Testing.File_AutonomyQueries.records, samp, toskip + 1);	
	


inxml := record
	dataset(iesp.rightaddress.t_RightAddressSearchRequest) RightAddressSearchRequest;
end;


make_f_prep_xml(dataset(recordof(inf)) l) :=
project(
	l,
	transform(
		inxml,
		self.RightAddressSearchRequest :=
		project(
			left,
			transform(
				iesp.rightaddress.t_RightAddressSearchRequest,
				self.User.QueryId := (string)left.queryno,
				self.SearchBy :=
				project(
					left,
					transform(
						iesp.rightaddress.t_RightAddressSearchBy,
						self.name := 
						project(
							left,
							transform(
								iesp.share.t_Name,
								// self.Full := left.firstname + left.middlename + left.lastname, //this is overly complicated.  i think i could have said "self.searchby.name.full := " and saved two project()s
								self.Full := '',
								self.first := left.firstname,
								self.last := left.lastname,
								self.middle := left.middlename,
								self.suffix := '',
								self.prefix := ''
							)
						),
						self.address :=
						project(
							left,
							transform(
								iesp.share.t_Address,
								self.StreetAddress1 := left.StreetAddress,
								self.City := left.city,
								self.State := left.state,
								self.Zip5 := left.zip,
								self := []
							)
						),
						self.Phone10 := left.phone,
						self.EntityType := '',
						self := []
					)
					
				),
				self  := []
			)
		)
	)
);
	

f_prep_xml := make_f_prep_xml(inf);

f_prep := f_prep_xml;

#if(UseHThor)

hthorinput := make_f_prep_xml(inf(queryno = HthorQueryNo));
output(hthorinput,,'cemtemp::xml',xml,overwrite);
#stored('RightAddressSearchRequest', hthorinput[1].RightAddressSearchRequest);
UPS_Services.RightAddressService();

#else

l_bs := record (iesp.rightaddress.t_RightAddressSearchResponse)
	unsigned error_code;
	STRING50 error_message;
end;


l_bs ft_bs(f_prep le) :=
TRANSFORM
	// SELF.internal_seq := (unsigned)le.seq;
	SELF.error_code := FAILCODE;
	SELF.error_message := FAILMESSAGE;
	SELF := [];
END;
	
s_bs := 
				 SOAPCALL(f_prep, 
									// 'http://10.173.190.1:9876',  //dev
									'http://10.173.195.2:9876',    //prod one-way #2
									'UPS_Services.RightAddressService', 
									{f_prep},
									DATASET(l_bs), 
									PARALLEL(1), onFail(ft_bs(LEFT)), LOG) 
									(recordcount > 0 or error_code > 0);

output(inf, named('inf'));									
// output(f_prep, named('f_prep'));																	
// output(choosen(s_bs, 100), named('s_bs'));
// output(s_bs,,'~thor_data400::cemtemp::upstest_roxie',overwrite);

oldonly := 
join(
	UPS_Testing.File_AutonomyEntities.records(queryno in set(inf, queryno)),  //WONT WORK FOR HUGE SAMPLES
	s_bs,
	(integer8)left.queryno = (integer8)right._header.queryid,
	left only,
	hash
);

// output(oldonly, named('oldonly'));
oldonly_ddp := dedup(oldonly, queryno, all);
output(count(oldonly_ddp), named('count_oldonly'));



myq := UPS_Testing.File_AutonomyQueries.records(queryno in set(oldonly, queryno));
output(myq, named('Queries_oldonly'));

mye := UPS_Testing.File_AutonomyEntities.records(queryno in set(oldonly, queryno));
output(mye, named('Entities_oldonly'));

myn := UPS_Testing.File_AutonomyNames.records(seqno in set(mye, seqno));
output(myn, named('Names_oldonly'));	

mya := UPS_Testing.File_AutonomyAddrs.records(seqno in set(mye, seqno));
output(mya, named('Addrs_oldonly'));	

myq_xml := make_f_prep_xml(inf(queryno in set(oldonly, queryno)));
output(myq_xml,,'cemtemp::xml',xml,overwrite);

#end
