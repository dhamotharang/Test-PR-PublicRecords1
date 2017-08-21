import ut, Drivers;
// BASE FILE
old := Drivers.File_Fl_DL_Raw;

bad_names  := ['UNKNOWN','UNK','UNKN','NONE','N/A','UNAVAILABLE'];
bad_mnames := ['NMN','NMI'];

DriversV2.Layout_DL_Extended from_old(old le) := transform
  self.dt_first_seen := MAP (le.active_date <> '' => (unsigned4)le.active_date,
   							 le.inactive_date <> '' => (unsigned4)le.inactive_date,
							 (unsigned8)le.lic_issue_date<>0 => ut.date_MMDDYYYY_i2(le.lic_issue_date) div 100,
							 200209 );

  self.dt_last_seen  := MAP (le.inactive_date<>'' => (unsigned4)le.inactive_date,
	  		                 self.dt_first_seen > 200209 => self.dt_first_seen,
							 200209 );

  self.dt_vendor_first_reported := 
						MAP ((unsigned8)le.dl_orig_issue_date <> 0 => ut.date_MMDDYYYY_i2(le.dl_orig_issue_date) div 100,
							 (unsigned8)le.lic_issue_date <> 0 => ut.date_MMDDYYYY_i2(le.lic_issue_date) div 100,
							 le.active_date<>'' => (unsigned4)le.active_date,
							 le.inactive_date <> '' => (unsigned4)le.inactive_date,
							 200209 );

  self.dt_vendor_last_reported :=  
				       MAP(le.inactive_date <> '' => (unsigned4)le.inactive_date,
					       le.active_date <> '' => (unsigned4)le.active_date,
						   (unsigned8)le.lic_issue_date <> 0 => ut.date_MMDDYYYY_i2(le.lic_issue_date) div 100,
						   200209 );
	self.dateReceived					:= (integer)((string)self.dt_last_seen + '01');	
  self.dob                  := ut.Date_MMDDYYYY_i2(le.dob);
  self.orig_expiration_date := ut.Date_MMDDYYYY_i2(le.orig_expiration_date);
  self.expiration_date      := ut.Date_MMDDYYYY_i2(le.expiration_date);
  self.lic_issue_date       := ut.Date_MMDDYYYY_i2(le.lic_issue_date);
  self.orig_issue_date      := ut.Date_MMDDYYYY_i2(le.dl_orig_issue_date);
  self.active_date          := (unsigned4)le.active_date;
  self.inactive_date        := (unsigned4)le.inactive_date;
  self.orig_state           := 'FL';
  self.history              := IF(le.license_type IN [' ','CLASS N', 'N'] or le.issuance = '6','E',' ');
  self.license_type         := trim(le.issuance, left, right);
  self.license_class        := DriversV2.Florida_Map_License_Class(le.license_type);
	self.origLicenseType			:= trim(le.license_type, left, right);	
	self.origLicenseClass			:= '';
  self.moxie_license_type   := drivers.Florida_Map_License_Type(le.license_type);
	self.RawFullName					:= le.name;
  self.fname                := if (trim(le.fname,left,right) in bad_names, '', le.fname);
  self.lname                := if (trim(le.lname,left,right) in bad_names, '', le.lname);
  self.mname                := if (trim(le.mname,left,right) in bad_names + bad_mnames, '', le.mname);
  self.attention_flag       := trim(le.attention_flag, left, right);
  self.issuance             := '';
  self                      := le;
end;

Fold := project(old,from_old(left));

// UPDATE FILES
upd := Drivers.File_FL_Update + DriversV2.File_DL_FL_Cleaned;
onl := Drivers.File_FL_Online_Renewals;

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
  self                          := le;
end;

Fupd		:= project(upd,from_upd(left));
fonl		:= project(onl,from_upd(left));

FoldDist	:= distribute(Fold,hash(dl_number));
FonlDist	:= distribute(Fonl,hash(dl_number));
FoldSort	:= sort(FoldDist,	dl_number,lic_issue_date,local);
FonlSort	:= sort(FonlDist,	dl_number,lic_issue_date,local);

DriversV2.Layout_DL_Extended	tJustInCase(FonlSort pOnline, FoldSort pFullFile)	// probably not really required
 :=
  transform
	self	:= pOnline;
  end
 ;

fonlOnly	:= join(fonlSort,foldSort,
					left.dl_number = right.dl_number and
				    left.lic_issue_date = right.lic_issue_date,
					tJustInCase(left,right),
				 	left only,
					local
				   );
					 
// Filtering records to drop all the 18th century records as per bug# 21076
export FL_as_DL := Fold(dob not between 18000101 and 18991231) + 
				   fupd(dob not between 18000101 and 18991231) + 
				   FonlOnly(dob not between 18000101 and 18991231) : persist(DriversV2.Constants.Cluster + 'Persist::DL2::DrvLic_FL_as_DL');
