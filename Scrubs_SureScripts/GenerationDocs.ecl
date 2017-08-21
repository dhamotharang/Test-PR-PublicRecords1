Generated by SALT V3.1.3
File being processed :-
MODULE:Scrubs_SureScripts
FILENAME:SureScripts
NAMESCOPE:SureScripts
//Uncomment up to NINES for internal or external adl
//IDFIELD:EXISTS:<NameOfIDField>
//RIDFIELD:<NameOfRidField>
//RECORDS:<NumberOfRecordsInDataFile>
//POPULATION:<ExpectedNumberOfEntitiesInDataFile>
//NINES:<Precision required 3 = 99.9%, 2 = 99% etc>
//Uncomment Process if doing external adl
//PROCESS:<ProcessName>
// Following lines generated in Types output
FIELDTYPE:did:SPACES( ):ALLOW(0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:did_score:SPACES( ):ALLOW(0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:bdid:SPACES( ):ALLOW(0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:bdid_score:SPACES( ):ALLOW(0157):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:best_dob:SPACES( ):ALLOW(0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:best_ssn:SPACES( ):ALLOW(0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:spi:SPACES( ):ALLOW(0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:dea:SPACES( ):ALLOW(-0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:statelicensenumber:SPACES( ):ALLOW( #:-.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghiklmnopqrstuwxyz):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:specialtycodeprimary:SPACES( ):ALLOW(ABCDEFGHILMNOPQRSTUVY):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:prefixname:SPACES( ):ALLOW( -.ABCDEFGHIJKLMNOPQRSTdeghinorst):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:lastname:SPACES( ):ALLOW( ,.-'ABCDEFGHIJKLMNOPQRSTUVWXYZ):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:firstname:SPACES( ):ALLOW( -'ABCDEFGHIJKLMNOPQRSTUVWXYZ):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:middlename:SPACES( ):ALLOW( -'.ABCDEFGHIJKLMNOPQRSTUVWYZabcdefghijklmnopqrstuvwxyz):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:suffixname:SPACES( ):ALLOW( (),-.ABCDEFHIJLMNOPQRSTUVWYZdehinrst):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:clinicname:SPACES( ):ALLOW( `;+#&@'(),-./\0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ_):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:addressline1:SPACES( ):ALLOW( |@`()/#,':;-&.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:addressline2:SPACES( ):ALLOW( |@`()/#':*,&;'-./0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:city:SPACES( ):ALLOW( .`'-ABCDEFGHIJKLMNOPQRSTUVWXYZ):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:state:SPACES( ):ALLOW(ACDEFGHIJKLMNOPQRSTUVWXYZ):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:zipcode:SPACES( ):ALLOW(0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:phoneprimary:SPACES( ):ALLOW(0123456789Xx):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:fax:SPACES( ):ALLOW(0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:email:SPACES( ):ALLOW(-.0123456789@ABCDEFGHIJKLMNOPQRSTUVXWYZ_abcdefghijklmnopqrstuvwxyz):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:phonealt1:SPACES( ):ALLOW(0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:phonealt1qualifier:SPACES( ):ALLOW(BCEFNPTWX):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:phonealt2:SPACES( ):ALLOW(0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:phonealt2qualifier:SPACES( ):ALLOW(CEFHNPTWX):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:phonealt3:SPACES( ):ALLOW(0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:phonealt3qualifier:SPACES( ):ALLOW(EFHPTWX):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:phonealt4:SPACES( ):ALLOW(0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:phonealt4qualifier:SPACES( ):ALLOW(EFPTWX):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:phonealt5:SPACES( ):ALLOW(0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:phonealt5qualifier:SPACES( ):ALLOW(EFPTWX):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:activestarttime:SPACES( ):ALLOW(-.0123456789:TZ):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:activeendtime:SPACES( ):ALLOW(-.0123456789:TZ):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:servicelevel:SPACES( ):ALLOW(0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:partneraccount:SPACES( ):ALLOW(-.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ_abcdefghijklmnopqrstuvwxyz):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:lastmodifieddate:SPACES( ):ALLOW(-.0123456789:TZ):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:recordchange:SPACES( ):ALLOW():LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:oldservicelevel:SPACES( ):ALLOW(-1):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:textservicelevel:SPACES( ):ALLOW():LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:textservicelevelchange:SPACES( ):ALLOW():LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:version:SPACES( ):ALLOW(0123456789CI_vV):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:npi:SPACES( ):ALLOW(0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:npilocation:SPACES( ):ALLOW(0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:specialitytype1:SPACES( ):ALLOW(ADNPRcdeinorst):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:specialitytype2:SPACES( ):ALLOW(ACNPQRScdeilnorst):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:specialitytype3:SPACES( ):ALLOW(NPRdeinst):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:specialitytype4:SPACES( ):ALLOW():LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:fileid:SPACES( ):ALLOW(-^0123456789ABCDEFGHIJKLMNPQRSTWXYZ_abcdefghiklmnopqrstuvwxyz):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:medicarenumber:SPACES( ):ALLOW(/0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZceimnpqrst):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:medicaidnumber:SPACES( ):ALLOW( 0123456789ACDEFGLMNOPQRSTZ):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:dentistlicensenumber:SPACES( ):ALLOW(0123456789ABOPYcs):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:upin:SPACES( ):ALLOW( 0123456789ABCDEFGHIKLMNOPQRSTUVWXZhot):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:pponumber:SPACES( ):ALLOW(0123456789ABCFJKLVWtu):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:socialsecurity:SPACES( ):ALLOW(-0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:priorauthorization:SPACES( ):ALLOW(0123456789BCFJKLVW):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:mutuallydefined:SPACES( ):ALLOW( -0123456789:ABCDEGHIJKLMNORSTU\abcdefghijklmnopqrstuvwxyz):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:instorencpdpid:SPACES( ):ALLOW():LEFTTRIM:LENGTHS(0):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:spec_code:SPACES( ):ALLOW(0123456789ABCDEFGHJKMNPQRSTUVWX):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:spec_desc:SPACES( ):ALLOW( &,/ACDEFGHIMNOPQRSUabcdefghilmnopqrstuvy):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:activity_code:SPACES( ):ALLOW(0123456789ACT):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:practice_type_code:SPACES( ):ALLOW(05GP):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:practice_type_desc:SPACES( ):ALLOW(Pachinsy):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:taxonomy:SPACES( ):ALLOW(0123456789ACDEGHILNPQRSTVWXY):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:src:SPACES( ):ALLOW(126CHMRS_):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:dt_vendor_first_reported:SPACES( ):ALLOW(0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:dt_vendor_last_reported:SPACES( ):ALLOW(0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:dt_first_seen:SPACES( ):ALLOW(0):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:dt_last_seen:SPACES( ):ALLOW(0):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:record_type:SPACES( ):ALLOW(C):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:source_rid:SPACES( ):ALLOW(0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:lnpid:SPACES( ):ALLOW(0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:title:SPACES( ):ALLOW(MRS):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:fname:SPACES( ):ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:mname:SPACES( ):ALLOW(-ABCDEFGHIJKLMNOPQRSTUVWXYZ):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:lname:SPACES( ):ALLOW( -ABCDEFGHIJKLMNOPQRSTUVWXYZ):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:name_suffix:SPACES( ):ALLOW(IJRSV):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:name_type:SPACES( ):ALLOW(BIP):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:nid:SPACES( ):ALLOW(0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:clean_clinic_name:SPACES( ):ALLOW( `+#@&,&0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ_):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:prepped_addr1:SPACES( ):ALLOW( |@`:()/&#,;'-.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:prepped_addr2:SPACES( ):ALLOW( |@`:()/&,;-.'0123456789ABCDEFGHIJKLMNOPRQSTUVWXYZ):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:prim_range:SPACES( ):ALLOW(-0123456789AB):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:predir:SPACES( ):ALLOW(ENSW):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:prim_name:SPACES( ):ALLOW( 0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:addr_suffix:SPACES( ):ALLOW(ABCDEFHIKLNOPQRSTVWXYZ):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:postdir:SPACES( ):ALLOW(ENSW):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:unit_desig:SPACES( ):ALLOW(#ABCDEFGILMNOPQRSTUWX):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:sec_range:SPACES( ):ALLOW(-0123456789ABCDEFGHIJKLMNOPQRSTUVW):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:p_city_name:SPACES( ):ALLOW( ABCDEFGHIJKLMNOPQRSTUVWXY):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:v_city_name:SPACES( ):ALLOW( ABCDEFGHIJKLMNOPQRSTUVWXY):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:st:SPACES( ):ALLOW( ACDEFGHIJKLMNOPQRSTUVWXYZ):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:zip:SPACES( ):ALLOW(0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:zip4:SPACES( ):ALLOW(0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:cart:SPACES( ):ALLOW(0123456789CHR):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:cr_sort_sz:SPACES( ):ALLOW(BCD):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:lot:SPACES( ):ALLOW(0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:lot_order:SPACES( ):ALLOW(AD):LEFTTRIM:ONFAIL(CLEAN)
FIELD:did:5,1
FIELD:did_score:5,1
FIELD:bdid:5,1
FIELD:bdid_score:5,1
FIELD:best_dob:5,1
FIELD:best_ssn:5,1
FIELD:spi:5,1
FIELD:dea:5,1
FIELD:statelicensenumber:5,1
FIELD:specialtycodeprimary:5,1
FIELD:prefixname:5,1
FIELD:lastname:5,1
FIELD:firstname:5,1
FIELD:middlename:5,1
FIELD:suffixname:5,1
FIELD:clinicname:5,1
FIELD:addressline1:5,1
FIELD:addressline2:5,1
FIELD:city:5,1
FIELD:state:5,1
FIELD:zipcode:5,1
FIELD:phoneprimary:5,1
FIELD:fax:5,1
FIELD:email:5,1
FIELD:phonealt1:5,1
FIELD:phonealt1qualifier:5,1
FIELD:phonealt2:5,1
FIELD:phonealt2qualifier:5,1
FIELD:phonealt3:5,1
FIELD:phonealt3qualifier:5,1
FIELD:phonealt4:5,1
FIELD:phonealt4qualifier:5,1
FIELD:phonealt5:5,1
FIELD:phonealt5qualifier:5,1
FIELD:activestarttime:5,1
FIELD:activeendtime:5,1
FIELD:servicelevel:5,1
FIELD:partneraccount:5,1
FIELD:lastmodifieddate:5,1
FIELD:recordchange:5,1
FIELD:oldservicelevel:5,1
FIELD:textservicelevel:5,1
FIELD:textservicelevelchange:5,1
FIELD:version:5,1
FIELD:npi:5,1
FIELD:npilocation:5,1
FIELD:specialitytype1:5,1
FIELD:specialitytype2:5,1
FIELD:specialitytype3:5,1
FIELD:specialitytype4:5,1
FIELD:fileid:5,1
FIELD:medicarenumber:5,1
FIELD:medicaidnumber:5,1
FIELD:dentistlicensenumber:5,1
FIELD:upin:5,1
FIELD:pponumber:5,1
FIELD:socialsecurity:5,1
FIELD:priorauthorization:5,1
FIELD:mutuallydefined:5,1
FIELD:instorencpdpid:5,1
FIELD:spec_code:5,1
FIELD:spec_desc:5,1
FIELD:activity_code:5,1
FIELD:practice_type_code:5,1
FIELD:practice_type_desc:5,1
FIELD:taxonomy:5,1
FIELD:src:5,1
FIELD:dt_vendor_first_reported:5,1
FIELD:dt_vendor_last_reported:5,1
FIELD:dt_first_seen:5,1
FIELD:dt_last_seen:5,1
FIELD:record_type:5,1
FIELD:source_rid:5,1
FIELD:lnpid:5,1
FIELD:title:5,1
FIELD:fname:5,1
FIELD:mname:5,1
FIELD:lname:5,1
FIELD:name_suffix:5,1
FIELD:name_type:5,1
FIELD:nid:5,1
FIELD:clean_clinic_name:5,1
FIELD:prepped_addr1:5,1
FIELD:prepped_addr2:5,1
FIELD:prim_range:5,1
FIELD:predir:5,1
FIELD:prim_name:5,1
FIELD:addr_suffix:5,1
FIELD:postdir:5,1
FIELD:unit_desig:5,1
FIELD:sec_range:5,1
FIELD:p_city_name:5,1
FIELD:v_city_name:5,1
FIELD:st:5,1
FIELD:zip:5,1
FIELD:zip4:5,1
FIELD:cart:5,1
FIELD:cr_sort_sz:5,1
FIELD:lot:5,1
FIELD:lot_order:5,1
FIELD:dbpc:5,1
FIELD:chk_digit:5,1
FIELD:rec_type:5,1
FIELD:fips_st:5,1
FIELD:fips_county:5,1
FIELD:geo_lat:5,1
FIELD:geo_long:5,1
FIELD:msa:5,1
FIELD:geo_blk:5,1
FIELD:geo_match:5,1
FIELD:err_stat:5,1
FIELD:rawaid:5,1
FIELD:aceaid:5,1
FIELD:clean_phone:5,1
FIELD:dotid:5,1
FIELD:dotscore:5,1
FIELD:dotweight:5,1
FIELD:empid:5,1
FIELD:empscore:5,1
FIELD:empweight:5,1
FIELD:powid:5,1
FIELD:powscore:5,1
FIELD:powweight:5,1
FIELD:proxid:5,1
FIELD:proxscore:5,1
FIELD:proxweight:5,1
FIELD:seleid:5,1
FIELD:selescore:5,1
FIELD:seleweight:5,1
FIELD:orgid:5,1
FIELD:orgscore:5,1
FIELD:orgweight:5,1
FIELD:ultid:5,1
FIELD:ultscore:5,1
FIELD:ultweight:5,1
Total available specificity:675
Search Threshold set at -4
Use of PERSISTs in code set at:3
__Glossary__
Edit Distance: An edit distance of (say) one implies that one string can be converted into another by doing one of
  - Changing one character
  - Deleting one character
  - Transposing two characters
Forcing Criteria: In addition to the general 'best match' logic it is possible to insist that
one particular field must match to some degree or the whole record is considered a bad match.
The criterial applied to that one field is the forcing criteria.
Cascade: Best Type rules are applied in such a way that the rules are applied one by one UNTIL the first rule succeeds; subsequent rules are then skipped.
__General Notes__
How is it decided how much to subtract for a bad match?
SALT computes for each field the percentage likelihood that a valid cluster will have two or more values for a given field
this value (called the switch value in the SALT literature) is then used to produce the subtraction value from the match value.
The value in this document is the one typed into the SPC file; the code will use a value computed at run-time.
