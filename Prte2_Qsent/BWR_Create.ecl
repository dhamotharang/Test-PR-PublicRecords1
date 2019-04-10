
// DidKey & fdidKey have the two additonal CCPA fields (Prte2.layouts.DEFLT_CPA) appended to their respective layouts

import  STD,PRTE2, _control, PRTE;  

skipDOPS:=false;
string emailTo:='';
dops_name := 'QsentKeys';

pversion:=(string8)STD.Date.CurrentDate(True);

AddBuild :=       DATASET([ ],Prte2_Qsent.layouts.address);
citystname :=     DATASET([ ],Prte2_Qsent.layouts.citystname);
companyname :=    DATASET([ ],Prte2_Qsent.layouts.companyname);
did_out :=        DATASET([ ],Prte2_Qsent.layouts.did_layout);
fdid_out :=       DATASET([ ],Prte2_Qsent.layouts.fdid_layout);
name_out :=       DATASET([ ],Prte2_Qsent.layouts.name_layout);
phone_out :=      DATASET([ ],Prte2_Qsent.layouts.phone_layout);
ssn_out :=        DATASET([ ],Prte2_Qsent.layouts.ssn_layout);
stname_out :=     DATASET([ ],Prte2_Qsent.layouts.stname_layout);
zip_out :=        DATASET([ ],Prte2_Qsent.layouts.zip_layout);

AddKey := INDEX(AddBuild,
{prim_name,prim_range,st,city_code,zip,sec_range,dph_lname,lname,pfname,fname,states,lname1,lname2,lname3,lookups},{AddBuild},
prte2.constants.prefix + 'key::qsent::' + pversion + '::address'); 

CityStKey := INDEX(citystname,
{city_code,st,dph_lname,lname,pfname,fname,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups},{citystname},
prte2.constants.prefix + 'key::qsent::' + pversion + '::citystname'); 

CompanyKey := INDEX(companyname,
{company},{companyname},
prte2.constants.prefix + 'key::qsent::' + pversion + '::companyname'); 

DidKey := INDEX(did_out,
{l_did},{did_out},
prte2.constants.prefix + 'key::qsent::' + pversion + '::did'); 

fdidKey := INDEX(fdid_out,
{fdid},{fdid_out},
prte2.constants.prefix + 'key::qsent::' + pversion + '::fdids'); 

nameKey := INDEX(name_out,
{dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups},{name_out},
prte2.constants.prefix + 'key::qsent::' + pversion + '::name'); 

phoneKey := INDEX(phone_out,
{p7,p3,dph_lname,pfname,st},{phone_out},
prte2.constants.prefix + 'key::qsent::' + pversion + '::phone'); 

ssnKey := INDEX(ssn_out,
{s1, s2, s3, s4, s5, s6, s7, s8, s9, dph_lname,pfname},{ssn_out},
prte2.constants.prefix + 'key::qsent::' + pversion + '::ssn'); 

stnameKey := INDEX(stname_out,
{st,dph_lname,lname,pfname,fname,minit,yob,s4,zip,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups},{stname_out},
prte2.constants.prefix + 'key::qsent::' + pversion + '::stname'); 

zipKey := INDEX(zip_out,
{zip,dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups},{zip_out},
prte2.constants.prefix + 'key::qsent::' + pversion + '::zip'); 

//---------- making DOPS optional -------------------------------
	notifyEmail					:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
	NoUpdate 						:= OUTPUT('Skipping DOPS update because it was requested to not do it'); 
	updatedops					:=	PRTE.UpdateVersion(dops_name, pversion, notifyEmail,'B','N','N');

	PerformUpdateOrNot	:= IF(not skipDops,updatedops,NoUpdate);
	
BUILD(AddKey);
BUILD(CityStKey);
BUILD(CompanyKey);
BUILD(didKey);
BUILD(fdidKey);
BUILD(nameKey);
BUILD(phoneKey);
BUILD(ssnKey);
BUILD(stnameKey);
BUILD(zipKey);

PerformUpdateOrNot;

output ('successful');


