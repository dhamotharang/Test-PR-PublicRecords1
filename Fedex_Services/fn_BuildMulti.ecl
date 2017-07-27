import codes;
rec := fedex_services.Layouts.out;

export fn_BuildMulti(
	dataset(rec) l):= 
FUNCTION
// 

// count the occurences of each state
r := record
	l.st;
	counted := count(group);
end;

t := table(l, r, st, few);

p := 
	project(
		t,
		transform(
			rec,
			self.st := left.st,
			self.st_result_count := left.counted,
			self.st_decode := 
				if(
					Fedex_Services.Inputs.IsCanadaSearch,
					Codes.GENERAL.CANADIAN_PROVINCE_LONG(left.st),
					Codes.GENERAL.STATE_LONG(left.st)
				),
			self := []
		)
	);
	
return p;

END;