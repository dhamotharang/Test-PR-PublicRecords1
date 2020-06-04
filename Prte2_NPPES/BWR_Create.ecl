import STD, PRTE2, _control, PRTE; 

skipDOPS:=false;
string emailTo:='';
dops_name := 'NppesKeys';

pversion:=(string8)STD.Date.CurrentDate(True);

PayloadBuild :=      DATASET([ ],Layouts.NPPES_Payload_Layout);
AddressBuild :=      DATASET([ ],Layouts.Address_Layout);
AddressBuildb2 :=    DATASET([ ],Layouts.Addressb2_Layout);
CitystNameBuild :=   DATASET([ ],Layouts.Citystname_Layout);
CitystNameb2Build:=  DATASET([ ],Layouts.Citystnameb2_Layout);
NameBuild :=         DATASET([ ],Layouts.name_Layout);
Nameb2Build :=       DATASET([ ],Layouts.nameb2_Layout);
Namewords2Build :=   DATASET([ ],Layouts.namewords2_Layout);
StnameBuild :=       DATASET([ ],Layouts.stname_Layout);
Stnameb2Build :=     DATASET([ ],Layouts.stnameb2_Layout);
zipBuild :=          DATASET([ ],Layouts.zip_Layout);
zipb2Build :=        DATASET([ ],Layouts.zipb2_Layout);
lnpidBuild:=         Dataset([ ],layouts.lnpid_slim_Layout);
npiBuild :=          DATASET([ ],Layouts2);



PayloadKey := INDEX(PayloadBuild,
{fakeid},{PayloadBuild},
prte2.constants.prefix + 'key::nppes::' + pversion + '::autokey::payload'); 

AddressKey := INDEX(AddressBuild,
{prim_name, prim_range, st, city_code, zip, sec_range, dph_lname, lname, pfname, fname, states, lname1, lname2, lname3, lookups},{AddressBuild},
prte2.constants.prefix + 'key::nppes::' + pversion + '::autokey::address'); 

AddressKeyb2 := INDEX(AddressBuildb2,
{prim_name,prim_range,st,city_code,zip,sec_range,cname_indic,cname_sec, bdid},{AddressBuildb2},
prte2.constants.prefix + 'key::nppes::' + pversion + '::autokey::addressb2'); 

CitystNameKey := INDEX(CitystNameBuild,
{city_code,st,dph_lname,lname,pfname,fname,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups},{CitystNameBuild},
prte2.constants.prefix + 'key::nppes::' + pversion + '::autokey::citystname'); 

CitystNameb2Key := INDEX(CitystNameb2Build,
{city_code, st,cname_indic, cname_sec,bdid},{CitystNameb2Build},
prte2.constants.prefix + 'key::nppes::' + pversion + '::autokey::citystnameb2'); 

NameKey := INDEX(NameBuild,
{ dph_lname, lname, pfname, fname, minit, yob, s4, dob, states, lname1, lname2, lname3, city1, city2, city3, rel_fname1,rel_fname2, rel_fname3, lookups},{NameBuild},
prte2.constants.prefix + 'key::nppes::' + pversion + '::autokey::name'); 

Nameb2Key := INDEX(Nameb2Build,
{ cname_indic, cname_sec, bdid},{Nameb2Build},
prte2.constants.prefix + 'key::nppes::' + pversion + '::autokey::nameb2'); 

Namewords2Key := INDEX(Namewords2Build,
{ word, state, seq, bdid},{Namewords2Build},
prte2.constants.prefix + 'key::nppes::' + pversion + '::autokey::namewords2'); 

stnameKey := INDEX(stnameBuild,
{ st, dph_lname, lname, pfname,fname, minit, yob, s4, zip, dob, states, lname1, lname2, lname3,city1,city2, city3, rel_fname1, rel_fname2, rel_fname3, lookups},{stnameBuild},
prte2.constants.prefix + 'key::nppes::' + pversion + '::autokey::stname'); 

stnameb2Key := INDEX(stnameb2Build,
{ st, cname_indic, cname_sec, bdid},{stnameb2Build},
prte2.constants.prefix + 'key::nppes::' + pversion + '::autokey::stnameb2'); 

zipKey := INDEX(zipBuild,
{zip, dph_lname, lname, pfname, fname, minit, yob, s4, dob, states, lname1, lname2,lname3, city1, city2, city3, rel_fname1, rel_fname2, rel_fname3, lookups},{zipBuild},
prte2.constants.prefix + 'key::nppes::' + pversion + '::autokey::zip'); 

zipb2Key := INDEX(zipb2Build,
{ zip, cname_indic, cname_sec, bdid},{zipb2Build},
prte2.constants.prefix + 'key::nppes::' + pversion + '::autokey::zipb2'); 

lnpidKey := INDEX(lnpidBuild,
{lnpid},{lnpidBuild},
prte2.constants.prefix + 'key::nppes::' + pversion + '::lnpid'); 

npiKey := INDEX(npiBuild,
{npi},{npiBuild},
prte2.constants.prefix + 'key::nppes::' + pversion + '::npi'); 



//---------- making DOPS optional -------------------------------
	notifyEmail					:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
	NoUpdate 						:= OUTPUT('Skipping DOPS update because it was requested to not do it'); 
	updatedops          :=  PRTE.UpdateVersion(dops_name, pversion, notifyEmail, l_inloc:='B',l_inenvment:='N',l_includeboolean := 'N');
		
	PerformUpdateOrNot	:= IF(not skipDops,updatedops,NoUpdate);


BUILDINDEX(PayloadKey);
BUILDINDEX(AddressKey);
BUILDINDEX(AddressKeyb2);
BUILDINDEX(CitystNameKey);
BUILDINDEX(CitystNameb2Key);
BUILDINDEX(NameKey);
BUILDINDEX(Nameb2Key);
BUILDINDEX(Namewords2Key);
BUILDINDEX(stnameKey);
BUILDINDEX(stnameb2Key);
BUILDINDEX(zipKey);
BUILDINDEX(zipb2Key);
BUILDINDEX(lnpidKey);
BUILDINDEX(npiKey);


PerformUpdateOrNot;

output ('successful');

