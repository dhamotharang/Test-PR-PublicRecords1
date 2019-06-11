import header, _validate, ut, watchdog, doxie,Data_Services;

//take header records where a valid date shows them to be a minor
h := 
	header.File_Headers(
		dob > 0 and 
		_Validate.Date.fIsValid((string8)dob,,true,true) and 
		ut.Age(dob) < 18
	);

//just keep the higher of their DOBs, if multiple	
s := 
	sort(
		h,
		did,
		-dob,
		local
	);
	
d := 
	dedup(
		s,
		did,
		local
	);
	
//throw them out if the best file says they are of age
b := 
	watchdog.File_Best(
		dob > 0 and 
		_Validate.Date.fIsValid((string8)dob,,true,true) and 
		ut.Age(dob) >= 18
	);		

j := 
	join(
		d,
		b,
		left.did = right.did,
		hash,
		left only
	);
	
export file_minors := j:persist('~thor_data400::persist::header::minors',expire(7));