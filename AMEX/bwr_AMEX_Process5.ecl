#workunit('name','AMEX Process5 Best from DID');
//                    RUN on hTHOR
import doxie,ut,risk_indicators, watchdog;
   infile_name := '~gwhitaker::in::AMEX_job1_process5_relDIDs';
// infile_name := '~gwhitaker::in::AMEX_job2_process5_relDIDs';

   outfile_name := '~gwhitaker::in::AMEX_job1_process1_relDIDs';
// outfile_name := '~gwhitaker::in::AMEX_job2_process1_relDIDs';

ds_in := dataset (infile_name, amex.layouts.inputProc1,CSV(QUOTE('"')));

unsigned1	DPPA := 1; 
unsigned1 GLB := 1;
boolean IsFCRA := false;
#stored('DPPA_Purpose',DPPA);
#stored('GLB_Purpose',GLB);
#stored('DataRestrictionMask','1    0');
//#stored('DataRestrictionMask','1    1'); //use this when isFCRA=TRUE to restrict Experian Data.

string10 DataRestriction := risk_indicators.iid_constants.default_DataRestriction : stored('DataRestrictionMask');

amex.layouts.inputProc1 get_best(ds_in L, watchdog.Key_Watchdog_GLB R) := transform
	self.FirstName := R.fname;
	self.LastName := R.lname;
	self.StreetAddress  := Risk_Indicators.MOD_AddressClean.street_address('',R.prim_Range, R.predir, R.prim_name, R.suffix, R.postdir, R.unit_desig, R.sec_range);
	self.City	:= R.city_name;
	self.State	:= R.st;
	self.Zip	:= R.zip;
	self.SSN	:= R.ssn;
	self.DateOfBirth	:= (string)R.dob;
	self.HomePhone	:= R.phone;
	self := L;
end;
amex.layouts.inputProc1 get_best_nonExperian(ds_in L, watchdog.Key_Watchdog_GLB_nonExperian R) := transform
	self.FirstName := R.fname;
	self.LastName := R.lname;
	self.StreetAddress  := Risk_Indicators.MOD_AddressClean.street_address('',R.prim_Range, R.predir, R.prim_name, R.suffix, R.postdir, R.unit_desig, R.sec_range);
	self.City	:= R.city_name;
	self.State	:= R.st;
	self.Zip	:= R.zip;
	self.SSN	:= R.ssn;
	self.DateOfBirth	:= (string)R.dob;
	self.HomePhone	:= R.phone;
	self := L;
end;

amex.layouts.inputProc1 get_best_nonglb(ds_in L, watchdog.Key_Watchdog_nonglb R) := transform
	self.FirstName := R.fname;
	self.LastName := R.lname;
	self.StreetAddress  := Risk_Indicators.MOD_AddressClean.street_address('',R.prim_Range, R.predir, R.prim_name, R.suffix, R.postdir, R.unit_desig, R.sec_range);
	self.City	:= R.city_name;
	self.State	:= R.st;
	self.Zip	:= R.zip;
	self.SSN	:= R.ssn;
	self.DateOfBirth	:= (string)R.dob;
	self.HomePhone	:= R.phone;
	self := L;
end;
											// it's permitted if datarestriction = false
experian_permitted := DataRestriction[risk_indicators.iid_constants.posExperianRestriction]=risk_indicators.iid_constants.sFalse;

outrecs := if (ut.glb_ok(GLB), 
	
						 if(experian_permitted, 
								join(ds_in, watchdog.Key_Watchdog_GLB,
									(integer)left.did != 0 and keyed((integer)left.did = right.did),
										get_best(LEFT,RIGHT), left outer),
							 
							 join(ds_in, watchdog.Key_Watchdog_GLB_nonExperian,
										(integer)left.did != 0 and keyed((integer)left.did = right.did),
										 get_best_nonExperian(LEFT,RIGHT), left outer) ),
										 
						 // if glb isn't ok, use the nonglb key	 
					   join(ds_in, watchdog.Key_Watchdog_nonglb,
							(integer)left.did != 0 and keyed((integer)left.did = right.did),
						   get_best_nonglb(LEFT,RIGHT),left outer));
							

OUTPUT(outrecs, , outfile_name, CSV(QUOTE('"')),overwrite);  
