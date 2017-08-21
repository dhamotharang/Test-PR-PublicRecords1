import Header,death_master,ut ; 

// only SSA dod's are taken into watchdog

dSourceData := Header.File_DID_Death_MasterV2 ((integer)did <>0 and state_death_id=death_master.fn_fake_state_death_id(ssn,lname,dod8)) ; 
 //crlf='SA' flags Direct records where the SSN was overlaid w/ one from the SSA
dDeathAsSource := dSourceData(crlf<>'SA') ; 

	  header.Layout_header into_fat(dDeathAsSource le) := transform
	  self.did        := (integer)le.did; 
	  self.rid        := 0;
	  self.dt_first_seen            := ut.MOB((integer)le.dod8);
	  self.dt_last_seen             := ut.MOB((integer)le.dod8);
	  self.dt_vendor_first_reported := ut.MOB((integer)le.dod8);
	  self.dt_vendor_last_reported  := ut.MOB((integer)le.dod8);
	  self.dt_nonglb_last_seen      := ut.MOB((integer)le.dod8);
	  self.vendor_id  := '';
	  self.phone      := '';
	  self.prim_range := '';
	  self.dob        := (integer)le.dob8;
	  self.prim_name  := if(le.dod8<>'','DOD: '+le.dod8,'');
	  self.unit_desig := '';
	  self.title      := '';
	  self.predir     := '';
	  self.postdir    := '';
	  self.suffix     := '';
	  self.city_name  := '';
	  self.st         := '';
	  self.zip4       := '';
	  self.county     := '';
	  self.cbsa       := '';
	  self.geo_blk    := '';
	  self.zip        := if (le.zip_lastres<>'',le.zip_lastres,le.zip_lastpayment);
	  self.sec_range  := '';
	  self.src        := 'DE' ; 
	  self            := le;
	  
	  end;

	death_in := project(dDeathAsSource,into_fat(left));

	//drop records that only have a name and date_of_death
	keep_these_ssa_death := death_in(fname<>'' and lname<>'' and (ssn<>'' or dob>0));

export deathmaster_dod_into_watchdog := distribute(keep_these_ssa_death,hash(did));