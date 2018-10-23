import Advo, UPS_Services;

EXPORT fn_AdvoLookup(dataset(UPS_Services.layout_Common) preRecords ) := function 

	finalRecords :=  join(preRecords, Advo.Key_Addr1,
												keyed(left.zip = right.zip) and
												keyed(left.prim_range = right.prim_range) and
												keyed(left.prim_name = right.prim_name) and
												keyed(left.suffix = right.addr_suffix) and
												keyed(left.predir = right.predir) and
												keyed(left.postdir = right.postdir) and
												keyed(left.sec_range = right.sec_range),
												transform(UPS_Services.layout_Common,
													self.AddressType := right.residential_or_business_ind,
													self 	:= left),
												LEFT OUTER	, keep(1),limit(0));

	return(finalRecords);
end;