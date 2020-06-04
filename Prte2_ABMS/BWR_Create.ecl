import STD, PRTE2, _control, PRTE, Dops; 

skipDOPS:=false;
string emailTo:='';
dops_name := 'ABMSKeys';

pversion:=(string8)STD.Date.CurrentDate(True);

AddressBuild :=      DATASET([ ],address_layout);
Addressb2Build :=    DATASET([ ],addressb2_layout);
CitystNameBuild :=   DATASET([ ],Citystname_Layout);
CitystNameb2Build:=  DATASET([ ],Citystnameb2_Layout);
NameBuild :=         DATASET([ ],name_Layout);
Nameb2Build :=       DATASET([ ],nameb2_Layout);
Namewords2Build :=   DATASET([ ],namewords2_Layout);
PayloadBuild    :=   DATASET([ ],payload_Layout);
StnameBuild :=       DATASET([ ],stname_Layout);
Stnameb2Build :=     DATASET([ ],stnameb2_Layout);
zipBuild :=          DATASET([ ],zip_Layout);
zipb2Build :=        DATASET([ ],zipb2_Layout);
career_biog_numberBuild :=           DATASET([ ],career_biog_number_Layout);
cert_biog_numberBuild :=             DATASET([ ],cert_biog_number_Layout);
education_biog_numberBuild :=        DATASET([ ],education_biog_number_Layout);
specialtyBuild :=                    DATASET([ ],specialty_Layout);
bdidBuild :=                         DATASET([ ],bdid_Layout);
main_biog_numberBuild :=             DATASET([ ],main_biog_number_Layout);
didBuild :=                          DATASET([ ],did_Layout);
lname_cert_fnameBuild :=             DATASET([ ],lname_cert_fname_Layout);
lnpidBuild :=                        DATASET([ ],lnpid_Layout);
npiBuild :=                          DATASET([ ],npi_Layout);
membership_biog_numberBuild :=       DATASET([ ],membership_biog_number_Layout);
typeofpractice_biog_numberBuild :=   DATASET([ ],typeofpractice_biog_number_Layout);


AddressKey := INDEX(AddressBuild,
{prim_name, prim_range,st, city_code, zip, sec_range, dph_lname, lname, pfname, fname, states, lname1, lname2,lname3, lookups},{AddressBuild},
prte2.constants.prefix + 'key::abms::' + pversion + '::autokey::address'); 

Addressb2Key := INDEX(Addressb2Build,
{prim_name, prim_range, st, city_code, zip,sec_range, cname_indic, cname_sec, bdid},{Addressb2Build},
prte2.constants.prefix + 'key::abms::' + pversion + '::autokey::addressb2'); 

CitystNameKey := INDEX(CitystNameBuild,
{ city_code,st,dph_lname, lname, pfname, fname, dob, states,lname1, lname2, lname3, city1,city2, city3, rel_fname1, rel_fname2,rel_fname3, lookups},{CitystNameBuild},
prte2.constants.prefix + 'key::abms::' + pversion + '::autokey::CitystName'); 

 CitystNameb2Key := INDEX(CitystNameb2Build,
 {city_code, st, cname_indic, cname_sec, bdid},{CitystNameb2Build},
 prte2.constants.prefix + 'key::abms::' + pversion + '::autokey::citystnameb2');
 
 NameKey := INDEX(NameBuild,
 {dph_lname,lname, pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3, lookups},{NameBuild},
 prte2.constants.prefix + 'key::abms::' + pversion + '::autokey::name');

Nameb2Key := INDEX(Nameb2Build,
 {cname_indic, cname_sec,bdid},{Nameb2Build},
 prte2.constants.prefix + 'key::abms::' + pversion + '::autokey::nameb2');
 
 Namewords2Key := INDEX(Namewords2Build,
 {word,state,seq,bdid},{Namewords2Build},
 prte2.constants.prefix + 'key::abms::' + pversion + '::autokey::namewords2');

PayloadKey := INDEX(PayloadBuild,
 {fakeid},{PayloadBuild},
 prte2.constants.prefix + 'key::abms::' + pversion + '::autokey::payload');
 
 StnameKey := INDEX(StnameBuild,
 {st; dph_lname;lname;pfname;fname; minit;yob; s4; zip;dob; states;lname1;lname2;lname3;city1;city2;city3;rel_fname1; rel_fname2;rel_fname3;lookups},{stnameBuild},
 prte2.constants.prefix + 'key::abms::' + pversion + '::autokey::stname');

Stnameb2Key := INDEX(Stnameb2Build,
 { st; cname_indic; cname_sec; bdid},{stnameb2Build},
 prte2.constants.prefix + 'key::abms::' + pversion + '::autokey::stnameb2');
 
 zipKey := INDEX(zipBuild,
 {zip; dph_lname;lname;pfname;fname; minit; yob; s4;dob;states;lname1;lname2;lname3;city1;city2;city3;rel_fname1;rel_fname2;rel_fname3;lookups;},{zipBuild},
 prte2.constants.prefix + 'key::abms::' + pversion + '::autokey::zip');

zipb2Key := INDEX(zipb2Build,
 {zip; cname_indic; cname_sec;bdid;},{zipb2Build},
 prte2.constants.prefix + 'key::abms::' + pversion + '::autokey::zipb2');

career_biog_numberKey := INDEX(career_biog_numberBuild,
 {biog_number;record_type;},{career_biog_numberBuild},
 prte2.constants.prefix + 'key::abms::' + pversion + '::career::biog_number');
 
 cert_biog_numberKey := INDEX(cert_biog_numberBuild,
 {biog_number;record_type;},{cert_biog_numberBuild},
 prte2.constants.prefix + 'key::abms::' + pversion + '::cert::biog_number');
 
 education_biog_numberKey := INDEX(education_biog_numberBuild,
 {biog_number;record_type;},{education_biog_numberBuild},
 prte2.constants.prefix + 'key::abms::' + pversion + '::education::biog_number');
 
 specialtyKey := INDEX(specialtyBuild,
 {specialty;sub_specialty_id;sub_specialty},{specialtyBuild},
 prte2.constants.prefix + 'key::abms::' + pversion + '::lookups::specialty');

bdidKey := INDEX(bdidBuild,
 {bdid;biog_number},{bdidBuild},
 prte2.constants.prefix + 'key::abms::' + pversion + '::main::bdid');

main_biog_numberKey := INDEX(main_biog_numberBuild,
 {biog_number;record_type;},{main_biog_numberBuild},
 prte2.constants.prefix + 'key::abms::' + pversion + '::main::biog_number');
 
 didKey := INDEX(didBuild,
 {did;biog_number},{didBuild},
 prte2.constants.prefix + 'key::abms::' + pversion + '::main::did');

 lname_cert_fnameKey := INDEX(lname_cert_fnameBuild,
 {last_name; cert_name;first_name; biog_number},{lname_cert_fnameBuild},
 prte2.constants.prefix + 'key::abms::' + pversion + '::main::lname_cert_fname'); 
 
 lnpidKey := INDEX(lnpidBuild,
 {lnpid},{lnpidBuild},
 prte2.constants.prefix + 'key::abms::' + pversion + '::main::lnpid'); 
 
 npiKey := INDEX(npiBuild,
 { npi; biog_number},{npiBuild},
 prte2.constants.prefix + 'key::abms::' + pversion + '::main::npi'); 
 
 membership_biog_numberKey := INDEX(membership_biog_numberBuild,
 {biog_number;record_type;},{membership_biog_numberBuild},
 prte2.constants.prefix + 'key::abms::' + pversion + '::membership::biog_number');
 
 typeofpractice_biog_numberKey := INDEX(typeofpractice_biog_numberBuild,
 {biog_number;record_type;},{typeofpractice_biog_numberBuild},
 prte2.constants.prefix + 'key::abms::' + pversion + '::typeofpractice::biog_number');


//---------- making DOPS optional -------------------------------
	notifyEmail					:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
	NoUpdate 						:= OUTPUT('Skipping DOPS update because it was requested to not do it'); 
	updatedops          :=  PRTE.UpdateVersion(dops_name, pversion, notifyEmail, l_inloc:='B',l_inenvment:='N',l_includeboolean := 'N');
		
	PerformUpdateOrNot	:= IF(not skipDops,updatedops,NoUpdate);

	key_validation :=  output(dops.ValidatePRCTFileLayout(pversion, prte2.Constants.ipaddr_prod, prte2.Constants.ipaddr_roxie_nonfcra,dops_name, 'N'), named(dops_name+'Validation'));

 BUILDINDEX(AddressKey);
 BUILDINDEX(Addressb2Key);
 BUILDINDEX(CitystNameKey);
 BUILDINDEX(CitystNameb2Key);
 BUILDINDEX(NameKey);
 BUILDINDEX(Nameb2Key);
 BUILDINDEX(Namewords2Key);
 BUILDINDEX(PayloadKey);
 BUILDINDEX(stnameKey);
 BUILDINDEX(stnameb2Key);
 BUILDINDEX(zipKey);
 BUILDINDEX(zipb2Key);
 BUILDINDEX(career_biog_numberKey);
 BUILDINDEX(cert_biog_numberKey);
 BUILDINDEX(education_biog_numberKey);
 BUILDINDEX(specialtyKey); 
 BUILDINDEX(bdidkey);
 BUILDINDEX(main_biog_numberKey);
 BUILDINDEX(didkey);
 BUILDINDEX(lname_cert_fnameKey);
 BUILDINDEX(lnpidKey);
 BUILDINDEX(npiKey);
 BUILDINDEX(membership_biog_numberKey);
 BUILDINDEX(typeofpractice_biog_numberKey);

 PerformUpdateOrNot;
 key_validation;

output ('successful');

