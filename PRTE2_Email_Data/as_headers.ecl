import header;

EXPORT as_headers := module

//YOU ONLY NEED THIS WHEN YOUR FILE HAS CONSUMERS
  Header.Layout_New_Records 		map_to_person_header(files.File_Key le) := transform
    self.src                      := le.email_src;   //Multiple email sources
    self.dt_first_seen            := (unsigned3)le.date_first_seen[1..6]; 
    self.dt_last_seen             := (unsigned3)le.date_last_seen[1..6];
    self.dt_vendor_first_reported := 0;
    self.dt_vendor_last_reported  := 0;
    self.did                      := le.did;
    self.title                    := '';
    self.fname                    := le.clean_name.fname;
    self.mname                    := le.clean_name.mname;
    self.lname                    := le.clean_name.lname;
    self.name_suffix              := le.clean_name.name_suffix;
    self.prim_range               := le.clean_address.prim_range;
    self.predir                   := le.clean_address.predir;
    self.prim_name                := le.clean_address.prim_name;
    self.suffix                   := le.clean_address.addr_suffix;
    self.postdir                  := le.clean_address.postdir;
    self.unit_desig               := le.clean_address.unit_desig;
    self.sec_range                := le.clean_address.sec_range;
    self.city_name                := le.clean_address.v_city_name;
    self.st                       := le.clean_address.st;
    self.zip                      := le.clean_address.zip;
    self.zip4                     := le.clean_address.zip4;
    self.county                   := le.clean_address.county[3..5];
	  self := le;
    self := [];
  end;

//this then gets read into a separate process (our Header process) for the creation and managing of our LexID's
export person_header_email_recs := project(files.File_Key(did>0),map_to_person_header(left));

END;