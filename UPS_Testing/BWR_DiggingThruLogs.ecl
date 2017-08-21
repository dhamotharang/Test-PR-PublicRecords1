ds := 
// UPS_Testing.dsProdLogs20090915;
UPS_Testing.dslogs911_disk;


spos(string f, string s) := stringlib.stringfind(s,'<' + f + '>' ,1) + length(trim(f)) + 2;
epos(string f, string s) := stringlib.stringfind(s,'</' + f + '>' ,1) + - 1;

mac(infile, outfile, f) := macro
	
	outfile := 
	project(
		infile,
		transform(
			{string200 f, infile},
			self.f := left.rest[spos(#TEXT(f),left.rest)..epos(#TEXT(f),left.rest)],
			self := left
		)
	);

endmacro;

mac(ds, ds1, StreetAddress1)
mac(ds1, ds2, City)
mac(ds2, ds3, Zip5)
mac(ds3, ds4, State)
mac(ds4, ds5, LastNameOrCompany)
mac(ds5, ds6, First)
mac(ds6, ds6a, ReturnCount)
mac(ds6a, ds6b, MaxResults)
mac(ds6b, ds7, Phone)

// output(ds7(lastnameorcompany = 'JPSTEN CONTROL'));
// output(ds7(lastnameorcompany = 'SALLORD'));
output(ds7(lastnameorcompany = 'SALLEE'));
output(ds7(lastnameorcompany = 'PIGORD'));
output(ds7(lastnameorcompany = 'JERRY ZOLBORN'));
// output(ds7(city = 'NORTH PORT'));
output(ds7(lastnameorcompany = 'SELTS'));
// output(ds7(city = 'PHARR'));
// count(ds7);

myrec := recordof(ds7) - rest;

ds8 := 
project(
	ds7,
	myrec
);

// count(dedup(ds8,StreetAddress1,City,Zip5,State,LastNameOrCompany,First,Phone, all));
dd := dedup(ds8,StreetAddress1,City,Zip5,State,LastNameOrCompany,First,Phone,ReturnCount,MaxResults,resultsize, all);

r := record
	dd.StreetAddress1;
	dd.City;
	dd.Zip5;
	dd.State;
	dd.LastNameOrCompany;
	dd.First;
	dd.Phone;
	cnt := count(group);
	//resultsize
end;

t := 
table(
	sort(dd(StreetAddress1 <> '' or City <> '' or Zip5 <> '' or State <> '' or LastNameOrCompany <> '' or First <> '' or Phone <> ''), StreetAddress1,City,Zip5,State,LastNameOrCompany,First,Phone), 
	r,
	StreetAddress1,City,Zip5,State,LastNameOrCompany,First,Phone
);

tt := t(cnt > 1);

j :=
join(
	tt,
	dd,
	left.StreetAddress1 = right.StreetAddress1 and
	left.City = right.city and 
	left.Zip5 = right.zip5 and 
	left.State = right.state and left.
	LastNameOrCompany = right.LastNameOrCompany and
	left.First = right.first and 
	left.Phone = right.phone,
	transform(right)
);

// output(j)



// count(ds8);
// count(ds8(state <> '' and state = streetaddress1));
// count(dedup(ds8,StreetAddress1,City,Zip5,State,LastNameOrCompany,First,Phone, all));
// count(dedup(ds8,StreetAddress1,City,Zip5,State,LastNameOrCompany,First,Phone,resultsize, all));