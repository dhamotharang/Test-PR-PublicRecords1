import prof_license, ut;

df := dataset('~thor_data400::base::prof_licenses_Building',prof_license.layout_proflic_out,flat);

// Commented out b/c this doesn't seem to be doing anything.  Input and output of   
// transform is same layout and nothing is being done in the transform. 

// prof_license.layout_proflic_out into(df L) := transform
	// self := l;
// end;

// export file_proflicense_keybuilt := project(df,into(LEFT));

tempLayout := RECORD
	prof_license.layout_proflic_out;
	unsigned6	temp_DID;
end;

tempLayout trfTempLayout(prof_license.layout_proflic_out input)	:= transform
	self.temp_did	:= (integer)input.did;
	self					:= input;
end;
 
tempBase	:= project(df, trfTempLayout(left));

ut.mac_suppress_by_phonetype(tempBase,Phone,St,phone_suppression,true,temp_did);	

prof_license.layout_proflic_out trfBaseLayout(tempLayout input)	:= transform
	self								:= input;
end;
 
Base	:= project(phone_suppression, trfBaseLayout(left));		

export file_proflicense_keybuilt := base : persist('~thor_dell400::persist::proflic_keybuilt');