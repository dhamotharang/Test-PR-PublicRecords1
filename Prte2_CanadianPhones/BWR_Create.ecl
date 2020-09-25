import STD, PRTE2, _control, PRTE, Orbit3; 

skipDOPS:=false;
string emailTo:='';
dops_name := 'CanadianPhonesKeys';

pversion:=(string8)STD.Date.CurrentDate(True);

fdidBuild :=         DATASET([ ],Layouts.fdid);
addressBuild :=      DATASET([ ],Layouts.address);
addressb2build :=    DATASET([ ],Layouts.addressb2);
citystnamebuild :=   DATASET([ ],Layouts.citystname);
citystnameb2build := DATASET([ ],Layouts.citystnameb2);
namebuild :=         DATASET([ ],Layouts.name);
nameb2build :=       DATASET([ ],Layouts.nameb2);
namewords2build :=   DATASET([ ],Layouts.namewords2);
phone2build :=       DATASET([ ],Layouts.phone2);
phoneb2build :=      DATASET([ ],Layouts.phoneb2);
stnamebuild :=       DATASET([ ],Layouts.stname);
stnameb2build :=     DATASET([ ],Layouts.stnameb2);
zipbuild :=          DATASET([ ],Layouts.zip);
zipb2build :=        DATASET([ ],Layouts.zipb2);
zipprlnamebuild :=   DATASET([ ],Layouts.zipprlname);

fdidKey := INDEX(fdidBuild,
{fdid},{fdidbuild},
prte2.constants.prefix + 'key::canadianwp::' + pversion + '::fdids'); 

addressKey := INDEX(addressBuild,
{prim_name, prim_range, st, city_code, zip, sec_range, dph_lname, lname, pfname, fname, lookups},{addressbuild},
prte2.constants.prefix + 'key::canadianwp::' + pversion + '::autokey::address'); 

addressb2Key := INDEX(addressb2Build,
{prim_name, prim_range, st, city_code, zip, sec_range, cname_indic, cname_sec, bdid},{addressb2build},
prte2.constants.prefix + 'key::canadianwp::' + pversion + '::autokey::addressb2'); 

citystnameKey := INDEX(citystnameBuild,
{city_code, st, dph_lname, lname, pfname, fname, dob, states, lname1, lname2, lname3, city1, city2, city3, rel_fname1, rel_fname2, rel_fname3, lookups},{citystnamebuild},
prte2.constants.prefix + 'key::canadianwp::' + pversion + '::autokey::citystname'); 

citystnameb2Key := INDEX(citystnameb2Build,
{city_code, st, cname_indic, cname_sec, bdid},{citystnameb2build},
prte2.constants.prefix + 'key::canadianwp::' + pversion + '::autokey::citystnameb2'); 

nameKey := INDEX(nameBuild,
{dph_lname, lname, pfname, fname, minit, yob, s4, dob, states, lname1, lname2, lname3, city1, city2, city3, rel_fname1, rel_fname2, rel_fname3, lookups},{namebuild},
prte2.constants.prefix + 'key::canadianwp::' + pversion + '::autokey::name'); 

nameb2Key := INDEX(nameb2Build,
{cname_indic, cname_sec, bdid},{nameb2build},
prte2.constants.prefix + 'key::canadianwp::' + pversion + '::autokey::nameb2');

namewords2Key := INDEX(namewords2build,
{word, state, seq, bdid},{namewords2build},
prte2.constants.prefix + 'key::canadianwp::' + pversion + '::autokey::namewords2');  

phone2Key := INDEX(phone2build,
{p7, p3, dph_lname, pfname, st, did},{phone2build},
prte2.constants.prefix + 'key::canadianwp::' + pversion + '::autokey::phone2');  

phoneb2Key := INDEX(phoneb2build,
{p7, p3, cname_indic, cname_sec, st, bdid},{phoneb2build},
prte2.constants.prefix + 'key::canadianwp::' + pversion + '::autokey::phoneb2');  

stnameKey := INDEX(stnamebuild,
{st, dph_lname, lname, pfname, fname, minit, yob, s4, zip, dob, states, lname1, lname2, lname3, city1, city2, city3, rel_fname1, rel_fname2, rel_fname3, lookups},{stnamebuild},
prte2.constants.prefix + 'key::canadianwp::' + pversion + '::autokey::stname');  

stnameb2Key := INDEX(stnameb2build,
{st, cname_indic, cname_sec, bdid},{stnameb2build},
prte2.constants.prefix + 'key::canadianwp::' + pversion + '::autokey::stnameb2');  

zipKey := INDEX(zipbuild,
{zip,dph_lname, lname, pfname, fname, minit,did},{zipbuild},
prte2.constants.prefix + 'key::canadianwp::' + pversion + '::autokey::zip');  

zipb2Key := INDEX(zipb2build,
{zip, cname_indic, cname_sec, bdid},{zipb2build},
prte2.constants.prefix + 'key::canadianwp::' + pversion + '::autokey::zipb2');  

zipprlnameKey := INDEX(zipprlnamebuild,
{zip, prim_range,lname, lookups},{zipprlnamebuild},
prte2.constants.prefix + 'key::canadianwp::' + pversion + '::autokey::zipprlname');  



//---------- making DOPS optional -------------------------------
	notifyEmail					:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
	NoUpdate 						:= OUTPUT('Skipping DOPS update because it was requested to not do it'); 
	updatedops					:=	PRTE.UpdateVersion(dops_name, pversion, notifyEmail,'B','N','N');
	
	updateOrbit:=Orbit3.proc_Orbit3_CreateBuild('PRTE - Canadian Phones', pversion, 'PN', false, false, true, _control.MyInfo.EmailAddressNormal);
  NoOrbitUpdate 						:= OUTPUT('Skipping Orbit because it was requested to not do it'); 
	
	PerformUpdateOrNot	:= IF(not skipDops,updatedops,NoUpdate);
	
	PerformOrbitOrNot:=    IF(not skipDops,updateOrbit,NoOrbitUpdate);
	
	

 BUILD(fdidKey);
 BUILD(addressKey);
 BUILD(addressb2Key);
 BUILD(citystnamekey);
 BUILD(citystnameb2key);
 BUILD(namekey);
 BUILD(nameb2key);
 BUILD(namewords2key);
 BUILD(phone2key);
 BUILD(phoneb2key);
 BUILD(stnamekey);
 BUILD(stnameb2key);
 BUILD(zipkey);
 BUILD(zipb2key);
 BUILD(zipprlnamekey);
 
 PerformUpdateOrNot;
 PerformOrbitOrNot;

 output ('successful');

