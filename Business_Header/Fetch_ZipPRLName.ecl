import autokey,doxie;

ak := 
	AutoKey.Fetch_ZipPRLName(  //note: this is actually searching company name, not lname, but we don't know which the fedex user is inputting
		t := '~thor_data400::key::business_header.',
		workhard := false,
		nofail := false
	);

ec := ak[1].error_code;	

export Fetch_ZipPRLName(boolean noFail = false) := 
	if(
		~noFail and ec > 0, fail(doxie.layout_references, ec, doxie.ErrorCodes(ec)),
		project(ak(error_code = 0), doxie.layout_references)
	);