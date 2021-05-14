//-----------------------------------------------------------------------------
// Gets the records to be used in the main (a combination of the input data
// with some relative data added in) and appends additional information
// including date of death, phone and job descriptions.
//-----------------------------------------------------------------------------
IMPORT AutoStandardI, header,risk_indicators,Suppress;

EXPORT various_appends_core(unsigned1 mode, STRING sVersion) := MODULE

// get_universe.get_main produces a list of candidate DIDs along with an
// integer "came_from" which indicates the degree of separation.  came_from='1'
// is the original input data, came_from='2' are first-degree relatives, etc.
// dUniverse:=DISTRIBUTE(reunion.get_universe(mode).get_main,HASH(did));
dUniverse:=distribute(project(reunion.files(1).dMain, transform({STRING1 came_from, unsigned6 did}, SELF.came_from := '1'; self.did := (unsigned6)left.adl)),HASH(did));

// An inner join with watchdog_for_reunion gets all of the non-GLB, non-child
// header records for the DIDs in the above dataset.
dInfutor:=DISTRIBUTE(reunion.infutor_for_reunion(mode),HASH(did));
dWithInfutor1 :=JOIN(dUniverse,
					dInfutor,
					LEFT.did=RIGHT.did,
					TRANSFORM(reunion.layouts.lMainRaw,SELF.title:='';SELF.dob:=(STRING)RIGHT.dob;SELF:=LEFT;SELF:=RIGHT; SELF := [];),LOCAL);

coresDS := pull(Header.key_ADL_segmentation(ind1 = 'CORE')); //257,216,208
coreInfutor := join(dInfutor, distribute(coresDS, hash(did)), left.did = right.did, transform(left), local);

//came_from = 5 are all core records
dWithInfutor2 :=JOIN(distribute(coreInfutor, hash(did)),
					 distribute(dWithInfutor1, hash(did)),					
					LEFT.did=RIGHT.did,
					TRANSFORM(reunion.layouts.lMainRaw,SELF.title:='';SELF.dob:=(STRING)RIGHT.dob;SELF.came_from := '5'; SELF:=LEFT;SELF:=RIGHT;),
					INNER,
					LOCAL);

dWithInfutor := dWithInfutor2;
header.Mac_apply_title(dWithInfutor,title,fname,mname,dWithTitle);

// Outer join the data to the following sources to get additional
// information where available.
dWithDeceased:=JOIN(dWithTitle,reunion.deceased,LEFT.did=RIGHT.did,TRANSFORM(reunion.layouts.lMainRaw,SELF.date_of_death:=RIGHT.dod8;SELF:=LEFT;),LEFT OUTER,LOCAL);
dWithPhones:=JOIN(dWithDeceased,reunion.phones,LEFT.did=RIGHT.did,TRANSFORM(reunion.layouts.lMainRaw,SELF.phone:=RIGHT.phone;SELF:=LEFT;),LEFT OUTER,LOCAL);
dWithjobDescriptions:=JOIN(dWithPhones,reunion.job_descriptions,LEFT.did=RIGHT.did,TRANSFORM(reunion.layouts.lMainRaw,SELF.job_desc:=RIGHT.job_desc;SELF:=LEFT;),LEFT OUTER,KEEP(1),LOCAL);

appType := (string)AutoStandardI.InterfaceTranslator.application_type_val.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.application_type_val.params));  

//DID suppression
Suppress.MAC_Suppress(dWithjobDescriptions, cleaned_did, appType,Suppress.Constants.LinkTypes.DID,did);

EXPORT all := cleaned_did : PERSIST('~thor::persist::mylife::appends::' + reunion.Constants.sMode(mode));

END;