import  STD, PRTE2, _control, PRTE,dx_header,header_quick; 

skipDOPS:=false;
string emailTo:='';
dops_name := 'QuickHeaderKeys';
dops_name_fcra:='FCRA_QuickHeaderKeys';

pversion:=(string8)STD.Date.CurrentDate(True);

didkeybuild :=      DATASET([ ],dx_header.Layout_Header-[dodgy_tracking, nid,address_ind, name_ind]);
eqkeybuild :=       DATASET([ ],header_quick.layout_fraud_flag_eq.key);
ssnValidKeybuild := DATASET([ ],{string9 ssn, unsigned8 ssn_flags_bitmap});
didridkeybuild :=   DATASET([ ],Layouts.didrid);

AddBuild :=       DATASET([ ],layouts.address);
citystname :=     DATASET([ ],layouts.citystname);
name_out :=       DATASET([ ],layouts.name_layout);
Payload :=        DATASET([ ],layouts.payload);
phone :=          DATASET([ ],layouts.phone_layout);
ssn :=            DATASET([ ],layouts.ssn_layout);
stname :=         DATASET([ ],layouts.stname_layout);
zipprlname :=     DATASET([ ],layouts.zipprlname);
zip_out :=        DATASET([ ],layouts.zip_out);


didKey :=       INDEX(didkeybuild,{did},{didkeybuild},prte2.constants.prefix + 'key::headerquick::' + pversion + '::did'); 
didFCRAKey :=   INDEX(didkeybuild,{did},{didkeybuild},prte2.constants.prefix + 'key::headerquick::fcra::' + pversion + '::did'); 
eqKey :=        INDEX(eqkeybuild,{did},{eqkeybuild},prte2.constants.prefix + 'key::headerquick::fraud_flag::' + pversion + '::eq');
ssnValidKey :=  INDEX(ssnValidkeybuild,{ssn},{ssnValidkeybuild},prte2.constants.prefix + 'key::headerquick::' + pversion + '::ssn_validity');
didridKey :=    INDEX(didridkeybuild,{did,rid},{didridkeybuild},prte2.constants.prefix + 'key::header_nlr::' + pversion + '::did.rid'); 

AddKey := INDEX(AddBuild,
{prim_name,prim_range,st,city_code,zip,sec_range,dph_lname,lname,pfname,fname,states,lname1,lname2,lname3,lookups},{AddBuild},
prte2.constants.prefix + 'key::headerquick::' + pversion + '::autokey_address'); 

CityStKey := INDEX(citystname,
{city_code,st,dph_lname,lname,pfname,fname,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups},{citystname},
prte2.constants.prefix + 'key::headerquick::' + pversion + '::autokey_citystname'); 

nameKey := INDEX(name_out,
{dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups},{name_out},
prte2.constants.prefix + 'key::headerquick::' + pversion + '::autokey_name'); 

payloadKey := INDEX(payload,
{fakeid},{payload},
prte2.constants.prefix + 'key::headerquick::' + pversion + '::autokey_payload');

phoneKey := INDEX(phone,
{p7,p3,dph_lname,pfname,st},{phone},
prte2.constants.prefix + 'key::headerquick::' + pversion + '::autokey_phone'); 

ssnKey := INDEX(ssn,
{s1, s2, s3, s4, s5, s6, s7, s8, s9, dph_lname,pfname},{ssn},
prte2.constants.prefix + 'key::headerquick::' + pversion + '::autokey_ssn'); 

stnameKey := INDEX(stname,
{st,dph_lname,lname,pfname,fname,minit,yob,s4,zip,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups},{stname},
prte2.constants.prefix + 'key::headerquick::' + pversion + '::autokey_stname'); 

zipprlnameKey := INDEX(zipprlname,
{zip, prim_range, lname, lookups},{zipprlname},
prte2.constants.prefix + 'key::headerquick::' + pversion + '::autokey_zipprlname'); 

zipKey := INDEX(zip_out,
{zip,dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups},{zip_out},
prte2.constants.prefix + 'key::headerquick::' + pversion + '::autokey_zip'); 

                                                                    
//---------- making DOPS optional -------------------------------
	notifyEmail					:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
	NoUpdate 						:= OUTPUT('Skipping DOPS update because it was requested to not do it'); 
	updatedops					:=	PRTE.UpdateVersion(dops_name, pversion, notifyEmail,'B','N','N');
	updatedops_fcra  		:= PRTE.UpdateVersion(dops_name_FCRA,pversion,notifyEmail,'B','F','N');

	PerformUpdateOrNot	:= IF(not skipDops,parallel(updatedops,updatedops_FCRA),NoUpdate);

BUILD(didKey);
BUILD(eqKey);
BUILD(ssnValidKey);
BUILD(didridKey);
BUILD(addKey);
BUILD(citystkey);
BUILD(namekey);
BUILD(payloadkey);
BUILD(phonekey);
BUILD(ssnkey);
BUILD(stnamekey);
BUILD(zipprlnameKey);
BUILD(zipKey);
BUILD(didFCRAKey);

//PerformUpdateOrNot;

output ('successful');

