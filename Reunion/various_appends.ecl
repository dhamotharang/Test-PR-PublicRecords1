//-----------------------------------------------------------------------------
// Gets the records to be used in the main (a combination of the input data
// with some relative data added in) and appends additional information
// including date of death, phone and job descriptions.
//-----------------------------------------------------------------------------
IMPORT watchdog;

// get_universe.get_main produces a list of candidate DIDs along with an
// integer "came_from" which indicates the degree of separation.  came_from='1'
// is the original input data, came_from='2' are first-degree relatives, etc.
dUniverse:=DISTRIBUTE(reunion.get_universe.get_main,HASH(did));

// An inner join with watchdog_for_reunion gets all of the non-GLB, non-child
// header records for the DIDs in the above dataset.
dWatchdog:=DISTRIBUTE(reunion.watchdog_for_reunion,HASH(did));
dWithWatchdog:=JOIN(dUniverse,dWatchdog,LEFT.did=RIGHT.did,TRANSFORM(reunion.layouts.lMainRaw,SELF.dob:=(STRING)RIGHT.dob;SELF:=LEFT;SELF:=RIGHT;),LOCAL);

// Outer join the data to the following sources to get additional
// information where available.
dWithDeceased:=JOIN(dWithWatchdog,reunion.deceased,LEFT.did=RIGHT.did,TRANSFORM(reunion.layouts.lMainRaw,SELF.date_of_death:=RIGHT.dod8;SELF:=LEFT;),LEFT OUTER,LOCAL);
dWithPhones:=JOIN(dWithDeceased,reunion.phones,LEFT.did=RIGHT.did,TRANSFORM(reunion.layouts.lMainRaw,SELF.phone:=RIGHT.phone;SELF:=LEFT;),LEFT OUTER,LOCAL);
dWithjobDescriptions:=JOIN(dWithPhones,reunion.job_descriptions,LEFT.did=RIGHT.did,TRANSFORM(reunion.layouts.lMainRaw,SELF.job_desc:=RIGHT.job_desc;SELF:=LEFT;),LEFT OUTER,KEEP(1),LOCAL);

EXPORT various_appends := dWithjobDescriptions:PERSIST('~thor::persist::mylife::appends');