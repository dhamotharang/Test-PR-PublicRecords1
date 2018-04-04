import ut, Drivers;

export FL_as_DL(dataset(drivers.Layout_FL_Update) pFile_FL_Input ) := function

bad_names  := ['UNKNOWN','UNK','UNKN','NONE','N/A','UNAVAILABLE'];
bad_mnames := ['NMN','NMI'];

// UPDATE FILE
upd := pFile_FL_Input;

DriversV2.Layout_DL_Extended from_upd(upd le) := transform
  self.orig_state               := 'FL';
  self.history                  := IF(le.license_type IN [' ','CLASS N', 'N'] or le.issuance = '6','E',' ');
  self.dt_first_seen            := if(self.history = 'E', 0, (unsigned8)le.process_date div 100);
  self.dt_last_seen             := if(self.history = 'E', 0, (unsigned8)le.process_date div 100);
  self.dt_vendor_first_reported := if(self.history = 'E', 0, (unsigned8)le.process_date div 100);
  self.dt_vendor_last_reported  := if(self.history = 'E', 0, (unsigned8)le.process_date div 100);
	self.dateReceived							:= (integer)le.process_date;
  self.motorcycle_code          := '';
  self.privacy_flag             := le.personal_info_flag;
  self.status                   := '';		  //will be set on output
  self.active_date              := 0;		  //rvh old date not used anymore
  self.inactive_date            := 0;		  //rvh old date not used anymore
  //if they have a new_dl_number, then their new becomes our regular and their reg becomes our old
  self.old_dl_number            := if(le.new_dl_number <> '' and le.new_dl_number <> le.dl_number, le.dl_number, ''); 
  self.dl_number                := if(le.new_dl_number <> '' and le.new_dl_number <> le.dl_number, le.new_dl_number, le.dl_number);
  self.dob                      := ut.Date_MMDDYYYY_i2(le.dob);
  self.expiration_date          := ut.Date_MMDDYYYY_i2(le.orig_expiration_date);
  self.orig_expiration_date     := 0;
  self.lic_issue_date           := ut.Date_MMDDYYYY_i2(le.lic_issue_date);
  self.orig_issue_date          := ut.Date_MMDDYYYY_i2(le.dl_orig_issue_date);
  self.license_type             := trim(le.issuance, left, right);
  self.license_class            := DriversV2.Florida_Map_License_class(le.license_type);
	self.origLicenseType					:= trim(le.issuance, left, right);
	self.origLicenseClass					:= trim(le.license_type, left, right);		
  self.moxie_license_type       := drivers.Florida_Map_License_Type(le.license_type);
	self.RawFullName							:= le.name;
  self.fname                    := if (trim(le.fname,left,right) in bad_names, '', le.fname);
  self.lname                    := if (trim(le.lname,left,right) in bad_names, '', le.lname);
  self.mname                    := if (trim(le.mname,left,right) in bad_names + bad_mnames, '', le.mname);
  self.attention_flag           := trim(le.attention_flag, left, right);
  self.issuance                 := '';
	self.ssn_safe                 := trim(le.ssn, left, right); //** vendor provided ssn is mapped to ssn_safe fields
  self                          := le;
end;

Fupd		:= project(upd,from_upd(left));

// Filtering records to drop all the 18th century records as per bug# 21076
FL_as_DL_mapper := fupd(dob not between 18000101 and 18991231);
 
return FL_as_DL_mapper;
 
end;
