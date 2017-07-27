import autokeyb,Business_Header_SS,business_header,ut;

export BWR_buildautokeyB(

	string pversion

) := 
function

	new_layout :=
	RECORD
		business_header.Layout_Business_Contact_Full;
		string3 score;
	END;

	dd := business_header.File_Employment_keybuild;

	new_layout transthis(business_header.Layout_Employment_keybuild l) :=TRANSFORM
	self.dt_first_seen := (unsigned4) l.dt_first_seen;
	self.dt_last_seen :=(unsigned4) l.dt_last_seen;
	self.GLB := (boolean) ((integer) l.GLB);
	self.zip := (unsigned3) l.zip;
	self.zip4 := (unsigned2) l.zip4;
	self.phone :=(unsigned5) l.phone;
	self.ssn := (unsigned5) l.ssn;
	self.company_zip :=(unsigned3) l.company_zip;
	self.company_zip4 :=(unsigned2) l.company_zip4;
	self.company_phone :=(unsigned5) l.company_phone;
	self.company_fein := (unsigned5) l.company_fein;
	self.did := (unsigned6) l.did;
	self.bdid :=(unsigned6) l.bdid;

	//self.zip5 := l.zip4;
	//self.company_zip5 :=l.company_zip4;

	self := l;
	self := [];
	END;

	d1 := Project(dd, transthis(left));

	rec := record
		d1;
		unsigned1 zero := 0;
		string5 zip5;
		string5 company_zip5;
	end;

	rec tra(d1 l) := transform
		self := l;
		self.zip5 := if(l.zip = 0, '', (string5)l.zip);
		self.company_zip5 := if(l.company_zip = 0, '', (string5)l.company_zip);
	end;

	d2 := project(d1, tra(left));


	t					:= Business_header.keynames(pversion).paw.autokey.template;
	inlogical := Business_header.keynames(pversion).paw.autokey.new;


	AutoKeyB.MAC_Build (d2,fname,mname,lname,
							ssn,
							zero,
							phone,
							prim_name,prim_range,state,city,zip5,sec_range,
							zero,
							zero,zero,zero,
							zero,zero,zero,
							zero,zero,zero,
							zero,
							DID,
							company_name,
							company_fein,
							company_phone,
							company_prim_name,company_prim_range,company_state,company_city,company_zip5,company_sec_range,
							bdid,
							t,inlogical,outaction,false,
							[],true,'PAW',,,zero) 

	return outaction;
	
end;