import STD, PRTE2, _control, PRTE,dops; 

skipDOPS:=false;
string emailTo:='';
dops_name := 'EnclarityKeys';

pversion:=(string8)STD.Date.CurrentDate(True);

billing_group_keyBuild :=   DATASET([ ],billing_group_key);
bill_tinBuild :=            DATASET([ ],bill_tin);
associate_group_keyBuild := DATASET([ ],associate_group_key);
facility_group_keyBuild:=   DATASET([ ],facility_group_key);
address1Build:=             DATASET([ ],address1);
citystnameBuild :=          DATASET([ ],citystname);
Name1Build :=               DATASET([ ],name1);
PayloadBuild    :=          DATASET([ ],payload);
ssn2Build    :=             DATASET([ ],ssn2);
stNameBuild :=              DATASET([ ],stname);
zipBuild :=                 DATASET([ ],zip);
individual_group_keyBuild :=      DATASET([ ],individual_group_key);
lnpidBuild :=                     DATASET([ ],lnpid);
license_group_keyBuild :=         DATASET([ ],license_group_key);
medschool_group_keyBuild :=       DATASET([ ],medschool_group_key);
sanction_group_keyBuild:=         DATASET([ ],sanction_group_key);
sanc_codesBuild :=                DATASET([ ],sanc_codes);
prov_type_codeBuild :=            DATASET([ ],prov_type_code);
spec_codeBuild :=                 DATASET([ ],spec_code);
taxonomy_group_keyBuild    :=     DATASET([ ],taxonomy_group_key);


 billing_group_key1 := INDEX(billing_group_keyBuild,
 {billing_group_key},{billing_group_keyBuild},
 prte2.constants.prefix + 'key::enclarity::associate::' + pversion + '::billing_group_key');
 
 bill_tinKey := INDEX(bill_tinBuild,
 {bill_tin},{bill_tinBuild},
  prte2.constants.prefix + 'key::enclarity::associate::' + pversion + '::bill_tin');
 
 associate_group_key1 := INDEX(associate_group_keyBuild,
 {group_key},{associate_group_keyBuild},
  prte2.constants.prefix + 'key::enclarity::associate::' + pversion + '::group_key');
	
	facility_group_key1 := INDEX(facility_group_keyBuild,
 {group_key},{facility_group_keyBuild},
  prte2.constants.prefix + 'key::enclarity::facility::' + pversion + '::group_key');
	

 address1Key := INDEX(address1Build,
 {prim_name, prim_range,st, city_code, zip, sec_range, dph_lname, lname, pfname, fname, states, lname1, lname2,lname3, lookups},{address1Build},
   prte2.constants.prefix + 'key::enclarity::individual::' + pversion + '::autokey::address');
 
CitystNameKey := INDEX(CitystNameBuild,
{ city_code,st,dph_lname, lname, pfname, fname, dob, states,lname1, lname2, lname3, city1,city2, city3, rel_fname1, rel_fname2,rel_fname3, lookups},{CitystNameBuild},
prte2.constants.prefix + 'key::enclarity::individual::' + pversion + '::autokey::citystname');

 Name1Key := INDEX(Name1Build,
 {dph_lname,lname, pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3, lookups},{Name1Build},
prte2.constants.prefix + 'key::enclarity::individual::' + pversion + '::autokey::name');

PayloadKey := INDEX(PayloadBuild,
 {fakeid},{PayloadBuild},
prte2.constants.prefix + 'key::enclarity::individual::' + pversion + '::autokey::payload');
 
 ssn2Key := INDEX(ssn2build,
 {s1; s2;s3;s4;s5;s6;s7;s8;s9;dph_lname;pfname;did},{ssn2Build},
prte2.constants.prefix + 'key::enclarity::individual::' + pversion + '::autokey::ssn2');;

 StnameKey := INDEX(StnameBuild,
 {st; dph_lname;lname;pfname;fname; minit;yob; s4; zip;dob; states;lname1;lname2;lname3;city1;city2;city3;rel_fname1; rel_fname2;rel_fname3;lookups},{stnameBuild},
prte2.constants.prefix + 'key::enclarity::individual::' + pversion + '::autokey::stname');

zipKey := INDEX(zipBuild,
 {zip; dph_lname;lname;pfname;fname; minit; yob; s4;dob;states;lname1;lname2;lname3;city1;city2;city3;rel_fname1;rel_fname2;rel_fname3;lookups;},{zipBuild},
prte2.constants.prefix + 'key::enclarity::individual::' + pversion + '::autokey::zip');

individual_group_key1 := INDEX(individual_group_keyBuild,
 {group_key},{individual_group_keyBuild},
  prte2.constants.prefix + 'key::enclarity::individual::' + pversion + '::group_key');
	
	lnpidKey := INDEX(lnpidBuild,
 {lnpid},{lnpidBuild},
  prte2.constants.prefix + 'key::enclarity::individual::' + pversion + '::lnpid');
	
	license_group_key1 := INDEX(license_group_keyBuild,
 {group_key},{license_group_keyBuild},
  prte2.constants.prefix + 'key::enclarity::license::' + pversion + '::group_key');
	

	medschool_group_key1 := INDEX(medschool_group_keyBuild,
 {group_key},{medschool_group_keyBuild},
  prte2.constants.prefix + 'key::enclarity::medschool::' + pversion + '::group_key');
 
 	sanction_group_key1 := INDEX(sanction_group_keyBuild,
 {group_key},{sanction_group_keyBuild},
  prte2.constants.prefix + 'key::enclarity::sanction::' + pversion + '::group_key');
	
	sanc_codeskey := INDEX(sanc_codesBuild,
 {sanc_code},{sanc_codesBuild},
  prte2.constants.prefix + 'key::enclarity::sanc_codes::' + pversion + '::sanc_codes');

	prov_type_codekey := INDEX(prov_type_codeBuild,
 {prov_type_code},{prov_type_codeBuild},
  prte2.constants.prefix + 'key::enclarity::sanc_prov_type::' + pversion + '::prov_type_code');
	
	spec_codekey := INDEX(spec_codeBuild,
 {group_key,spec_code},{spec_codeBuild},
  prte2.constants.prefix + 'key::enclarity::specialty::' + pversion + '::group_key_spec_code');


	taxonomy_group_key1 := INDEX(taxonomy_group_keyBuild,
 {group_key},{taxonomy_group_keyBuild},
  prte2.constants.prefix + 'key::enclarity::taxonomy::' + pversion + '::group_key');

 
//---------- making DOPS optional -------------------------------
	notifyEmail					:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
	NoUpdate 						:= OUTPUT('Skipping DOPS update because it was requested to not do it'); 
	updatedops          :=  PRTE.UpdateVersion(dops_name, pversion, notifyEmail, l_inloc:='B',l_inenvment:='N',l_includeboolean := 'N');
		
	PerformUpdateOrNot	:= IF(not skipDops,updatedops,NoUpdate);
	
	key_validation :=  output(dops.ValidatePRCTFileLayout(pversion, prte2.Constants.ipaddr_prod, prte2.Constants.ipaddr_roxie_nonfcra,dops_name, 'N'), named(dops_name+'Validation'));

  BUILDINDEX(billing_group_key1);
  BUILDINDEX(bill_tinKey);
  BUILDINDEX(associate_group_key1);
  BUILDINDEX(facility_group_key1);
  BUILDINDEX(address1Key);
  BUILDINDEX(CitystNameKey);
  BUILDINDEX(Name1Key);
  BUILDINDEX(PayloadKey);
  BUILDINDEX(stnameKey);
  BUILDINDEX(ssn2Key);
  BUILDINDEX(zipKey);
  BUILDINDEX(individual_group_key1);
  BUILDINDEX(lnpidKey);
  BUILDINDEX(license_group_key1);
  BUILDINDEX(medschool_group_key1); 
  BUILDINDEX(sanction_group_key1);
  BUILDINDEX(sanc_codeskey);
  BUILDINDEX(prov_type_codekey);
  BUILDINDEX(spec_codekey);
  BUILDINDEX(taxonomy_group_key1);


 PerformUpdateOrNot;
 key_validation;

output ('successful');

