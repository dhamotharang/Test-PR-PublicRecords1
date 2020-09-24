import STD, PRTE2, _control, PRTE, Orbit3, dops; 

skipDOPS:=false;
string emailTo:='';
dops_name := 'CanadianPhonesV2Keys';

pversion:=(string8)STD.Date.CurrentDate(True);

didBuild :=         DATASET([ ],Layouts.did_layout);

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

didKey := INDEX(didBuild,
{did},{didbuild},
prte2.constants.prefix + 'key::canadianwp_v2::' + pversion + '::did'); 

fdidKey := INDEX(fdidBuild,
{fdid},{fdidbuild},
prte2.constants.prefix + 'key::canadianwp_v2::' + pversion + '::fdids'); 

addressKey := INDEX(addressBuild,
{prim_name, prim_range, st, city_code, zip, sec_range, dph_lname, lname, pfname, fname, lookups},{addressbuild},
prte2.constants.prefix + 'key::canadianwp_v2::' + pversion + '::autokey::address'); 

addressb2Key := INDEX(addressb2Build,
{prim_name, prim_range, st, city_code, zip, sec_range, cname_indic, cname_sec, bdid},{addressb2build},
prte2.constants.prefix + 'key::canadianwp_v2::' + pversion + '::autokey::addressb2'); 

citystnameKey := INDEX(citystnameBuild,
{city_code, st, dph_lname, lname, pfname, fname, dob, states, lname1, lname2, lname3, city1, city2, city3, rel_fname1, rel_fname2, rel_fname3, lookups},{citystnamebuild},
prte2.constants.prefix + 'key::canadianwp_v2::' + pversion + '::autokey::citystname'); 

citystnameb2Key := INDEX(citystnameb2Build,
{city_code, st, cname_indic, cname_sec, bdid},{citystnameb2build},
prte2.constants.prefix + 'key::canadianwp_v2::' + pversion + '::autokey::citystnameb2'); 

nameKey := INDEX(nameBuild,
{dph_lname, lname, pfname, fname, minit, yob, s4, dob, states, lname1, lname2, lname3, city1, city2, city3, rel_fname1, rel_fname2, rel_fname3, lookups},{namebuild},
prte2.constants.prefix + 'key::canadianwp_v2::' + pversion + '::autokey::name'); 

nameb2Key := INDEX(nameb2Build,
{cname_indic, cname_sec, bdid},{nameb2build},
prte2.constants.prefix + 'key::canadianwp_v2::' + pversion + '::autokey::nameb2');

namewords2Key := INDEX(namewords2build,
{word, state, seq, bdid},{namewords2build},
prte2.constants.prefix + 'key::canadianwp_v2::' + pversion + '::autokey::namewords2');  

phone2Key := INDEX(phone2build,
{p7, p3, dph_lname, pfname, st, did},{phone2build},
prte2.constants.prefix + 'key::canadianwp_v2::' + pversion + '::autokey::phone2');  

phoneb2Key := INDEX(phoneb2build,
{p7, p3, cname_indic, cname_sec, st, bdid},{phoneb2build},
prte2.constants.prefix + 'key::canadianwp_v2::' + pversion + '::autokey::phoneb2');  

stnameKey := INDEX(stnamebuild,
{st, dph_lname, lname, pfname, fname, minit, yob, s4, zip, dob, states, lname1, lname2, lname3, city1, city2, city3, rel_fname1, rel_fname2, rel_fname3, lookups},{stnamebuild},
prte2.constants.prefix + 'key::canadianwp_v2::' + pversion + '::autokey::stname');  

stnameb2Key := INDEX(stnameb2build,
{st, cname_indic, cname_sec, bdid},{stnameb2build},
prte2.constants.prefix + 'key::canadianwp_v2::' + pversion + '::autokey::stnameb2');  

zipKey := INDEX(zipbuild,
{zip,dph_lname, lname, pfname, fname, minit,did},{zipbuild},
prte2.constants.prefix + 'key::canadianwp_v2::' + pversion + '::autokey::zip');  

zipb2Key := INDEX(zipb2build,
{zip, cname_indic, cname_sec, bdid},{zipb2build},
prte2.constants.prefix + 'key::canadianwp_v2::' + pversion + '::autokey::zipb2');  

zipprlnameKey := INDEX(zipprlnamebuild,
{zip, prim_range,lname, lookups},{zipprlnamebuild},
prte2.constants.prefix + 'key::canadianwp_v2::' + pversion + '::autokey::zipprlname');  



//---------- making DOPS optional -------------------------------
	notifyEmail					:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
	NoUpdate 						:= OUTPUT('Skipping DOPS update because it was requested to not do it'); 
	updatedops          := PRTE.UpdateVersion(dops_name, pversion, _control.MyInfo.EmailAddressNormal, l_inloc:='B', l_inenvment:='N', l_includeboolean := 'N');
	
  Key_Validation     := output(dops.ValidatePRCTFileLayout(pversion, /*Dataland IP*/ '10.173.14.204', /*Prod IP*/ prte2.constants.ipaddr_prod, dops_name, 'N'));	
	
	updateOrbit         := Orbit3.proc_Orbit3_CreateBuild('PRTE - Canadian Phones v2', pversion, 'PN', email_list:= _control.MyInfo.EmailAddressNormal);
  NoOrbitUpdate 			:= OUTPUT('Skipping Orbit because it was requested to not do it'); 

	PerformUpdateOrNot	:= IF(not skipDops,updatedops,NoUpdate);
	PerformOrbitOrNot:=    IF(not skipDops,updateOrbit,NoOrbitUpdate);
  
	

 BUILD(didKey);
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
 
 //key_Validation;
 
 //PerformUpdateOrNot;
 //PerformOrbitOrNot;

output ('successful');

