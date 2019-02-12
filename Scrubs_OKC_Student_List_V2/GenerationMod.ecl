// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.4';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_OKC_Student_List_V2';
  EXPORT spc_NAMESCOPE := '';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := 'cleancollegeid';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'OKC_Student_List';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,cleanaddr1,cleanaddr2,cleanattendancedte,cleancity,cleanstate,cleanzip,cleanzip4,cleanfulladdr,cleandob,cleanupdatedte,cleanemail,append_email_username,append_domain,append_domain_type,append_domain_root,append_domain_ext,append_is_tld_state,append_is_tld_generic,append_is_tld_country,append_is_valid_domain_ext,cleantitle,cleanfirstname,cleanmidname,cleanlastname,cleansuffixname,cleanmajor,cleanphone,did,process_date,date_first_seen,date_last_seen,date_vendor_first_reported,date_vendor_last_reported,dateadded,dateupdated,studentid,dartid,collegeid,projectsource,collegestate,college,semester,year,firstname,middlename,lastname,suffix,major,grade,email,dateofbirth,dob_formatted,attendancedate,enrollmentstatus,addresstype,address_1,address_2,city,state,z5,z4,phonetyp,phonenumber,tier,school_size_code,competitive_code,tuition_code,title,fname,mname,lname,name_suffix,name_score,rawaid,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,zip,zip4,cart,cr_sort_sz,lot,lot_order,dpbc,chk_digit,rec_type,county,fips_state,fips_county,geo_lat,geo_long,msa,geo_blk,geo_match,err_stat,telephone,tier2,source,key,ssn,historical_flag,full_name,college_class,college_name,ln_college_name,college_major,new_college_major,college_code,college_code_exploded,college_type,college_type_exploded,file_type,collegeupdate';
  EXPORT spc_HAS_TWOSTEP := FALSE;
  EXPORT spc_HAS_PARTITION := FALSE;
  EXPORT spc_HAS_FIELDTYPES := TRUE;
  EXPORT spc_HAS_INCREMENTAL := FALSE;
  EXPORT spc_HAS_ASOF := FALSE;
  EXPORT spc_HAS_NONCONTIGUOUS := FALSE;
  EXPORT spc_HAS_SUPERFILES := FALSE;
  EXPORT spc_HAS_CONSISTENT := FALSE;
  EXPORT spc_HAS_EXTERNAL := FALSE;
  EXPORT spc_HAS_PARENTS := FALSE;
  EXPORT spc_HAS_FORCE := FALSE;
  EXPORT spc_HAS_BLOCKLINK := FALSE;
 
  // The entire spec file
  EXPORT spcString :=
    'OPTIONS:-gh\n'
    + 'MODULE:Scrubs_OKC_Student_List_V2\n'
    + 'FILENAME:OKC_Student_List\n'
    + '//Uncomment up to NINES for internal or external adl\n'
    + '//IDFIELD:EXISTS:<NameOfIDField>\n'
    + '//RIDFIELD:<NameOfRidField>\n'
    + '//RECORDS:<NumberOfRecordsInDataFile>\n'
    + '//POPULATION:<ExpectedNumberOfEntitiesInDataFile>\n'
    + '//NINES:<Precision required 3 = 99.9%, 2 = 99% etc>\n'
    + '//Uncomment Process if doing external adl\n'
    + '//PROCESS:<ProcessName>\n'
    + 'SOURCEFIELD:cleancollegeid\n'
    + 'FIELDTYPE:nums:ALLOW(0123456789)\n'
    + 'FIELDTYPE:lowercase:ALLOW(abcdefghijklmnopqrstuvwxyz)\n'
    + 'FIELDTYPE:uppercase:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ)\n'
    + 'FIELDTYPE:alphas:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz)\n'
    + 'FIELDTYPE:lowercaseandnums:ALLOW(abcdefghijklmnopqrstuvwxyz0123456789)\n'
    + 'FIELDTYPE:uppercaseandnums:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789)\n'
    + 'FIELDTYPE:alphasandnums:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789)\n'
    + 'FIELDTYPE:allupper:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZÃ…Ã‰Ã‘Ã•ÃšÃœÃÃ¡Ã£Ã±Ã³Ã¶Ã©)\n'
    + '// FIELDTYPE:allupperandnums:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZÃ…Ã‰Ã‘Ã•ÃšÃœÃÃ¡Ã£Ã±Ã³Ã¶Ã©0123456789)\n'
    + '// FIELDTYPE:allalphaandnums:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZÃ…Ã‰Ã‘Ã•ÃšÃœÃÃ¡Ã£Ã±Ã³Ã¶Ã©abcdefghijklmnopqrstuvwxyz0123456789)\n'
    + 'FIELDTYPE:invalid_blank:LENGTHS(0)\n'
    + '// FIELDTYPE:invalid_alpha:SPACES( ):ALLOW( &(),-/.\'#:;*;ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz)\n'
    + 'FIELDTYPE:invalid_date:LIKE(nums):SPACES( ):LENGTHS(0,8)\n'
    + 'FIELDTYPE:invalid_AttendanceDate:ALLOW( /;0123456789SPRINGUMEFALTW)\n'
    + 'FIELDTYPE:invalid_phone:LIKE(nums):SPACES(()-+):LENGTHS(0,9..15)\n'
    + 'FIELDTYPE:invalid_phonetyp:ENUM(HOME|CELL|OTHER|)\n'
    + 'FIELDTYPE:invalid_name:LIKE(allupper):SPACES( -,&\\/.:;`\'()_+):LENGTHS(0..)\n'
    + 'FIELDTYPE:invalid_suffix:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ)\n'
    + 'FIELDTYPE:invalid_address:LIKE(uppercaseandnums):SPACES( ,-.()\':;"&#/)\n'
    + 'FIELDTYPE:invalid_college:LIKE(alphasandnums):SPACES( -&/./())\n'
    + 'FIELDTYPE:invalid_city:LIKE(uppercase):SPACES( .\'-,)\n'
    + 'FIELDTYPE:invalid_state:LIKE(uppercase):LENGTHS(0,2)\n'
    + 'FIELDTYPE:invalid_semester:ENUM(SPRING|SUMMER|FALL|AUTUMN|WINTER|):LENGTHS(0,4,6)\n'
    + '// FIELDTYPE:invalid_csz:SPACES( ):ALLOW( ,-ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789)\n'
    + 'FIELDTYPE:invalid_email:LIKE(alphasandnums):SPACES(.@-_)\n'
    + 'FIELDTYPE:invalid_addresstype:ENUM(CURRENT|Permanent|DORM|HOME|)\n'
    + 'FIELDTYPE:invalid_MajorCode:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ)\n'
    + 'FIELDTYPE:invalid_NewMajorCode:CUSTOM(Scrubs_OKC_Student_List_V2.validNewMajorCode>0)\n'
    + 'FIELD:cleanaddr1:LIKE(invalid_address):TYPE(STRING):0,0\n'
    + 'FIELD:cleanaddr2:LIKE(invalid_address):TYPE(STRING):0,0\n'
    + 'FIELD:cleanattendancedte:TYPE(STRING):0,0\n'
    + 'FIELD:cleancity:LIKE(invalid_city):TYPE(STRING):0,0\n'
    + 'FIELD:cleanstate:LIKE(invalid_state):TYPE(STRING):0,0\n'
    + 'FIELD:cleanzip:TYPE(STRING):0,0\n'
    + 'FIELD:cleanzip4:TYPE(STRING):0,0\n'
    + 'FIELD:cleanfulladdr:TYPE(STRING):0,0\n'
    + 'FIELD:cleandob:LIKE(invalid_date):TYPE(STRING):0,0\n'
    + 'FIELD:cleanupdatedte:LIKE(invalid_date):TYPE(STRING):0,0\n'
    + 'FIELD:cleanemail:LIKE(invalid_email):TYPE(STRING):0,0\n'
    + 'FIELD:append_email_username:TYPE(STRING):0,0\n'
    + 'FIELD:append_domain:TYPE(STRING):0,0\n'
    + 'FIELD:append_domain_type:TYPE(STRING):0,0\n'
    + 'FIELD:append_domain_root:TYPE(STRING):0,0\n'
    + 'FIELD:append_domain_ext:TYPE(STRING):0,0\n'
    + 'FIELD:append_is_tld_state:TYPE(BOOLEAN1):0,0\n'
    + 'FIELD:append_is_tld_generic:TYPE(BOOLEAN1):0,0\n'
    + 'FIELD:append_is_tld_country:TYPE(BOOLEAN1):0,0\n'
    + 'FIELD:append_is_valid_domain_ext:TYPE(BOOLEAN1):0,0\n'
    + 'FIELD:cleantitle:TYPE(STRING):0,0\n'
    + 'FIELD:cleanfirstname:LIKE(invalid_name):TYPE(STRING):0,0\n'
    + 'FIELD:cleanmidname:LIKE(invalid_name):TYPE(STRING):0,0\n'
    + 'FIELD:cleanlastname:LIKE(invalid_name):TYPE(STRING):0,0\n'
    + 'FIELD:cleansuffixname:LIKE(invalid_name):TYPE(STRING):0,0\n'
    + 'FIELD:cleanmajor:TYPE(STRING):0,0\n'
    + 'FIELD:cleanphone:LIKE(invalid_phone):TYPE(STRING):0,0\n'
    + 'FIELD:did:TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:process_date:LIKE(invalid_date):TYPE(STRING8):0,0\n'
    + 'FIELD:date_first_seen:LIKE(invalid_date):TYPE(STRING8):0,0\n'
    + 'FIELD:date_last_seen:LIKE(invalid_date):TYPE(STRING8):0,0\n'
    + 'FIELD:date_vendor_first_reported:LIKE(invalid_date):TYPE(STRING8):0,0\n'
    + 'FIELD:date_vendor_last_reported:LIKE(invalid_date):TYPE(STRING8):0,0\n'
    + 'FIELD:dateadded:LIKE(invalid_date):TYPE(STRING8):0,0\n'
    + 'FIELD:dateupdated:LIKE(invalid_date):TYPE(STRING8):0,0\n'
    + 'FIELD:studentid:LIKE(nums):TYPE(STRING):0,0\n'
    + 'FIELD:dartid:LIKE(nums):TYPE(STRING4):0,0\n'
    + 'FIELD:collegeid:TYPE(STRING):0,0\n'
    + 'FIELD:projectsource:TYPE(STRING100):0,0\n'
    + 'FIELD:collegestate:TYPE(STRING20):0,0\n'
    + 'FIELD:college:LIKE(invalid_college):TYPE(STRING100):0,0\n'
    + 'FIELD:semester:LIKE(invalid_semester):TYPE(STRING6):0,0\n'
    + 'FIELD:year:LIKE(nums):TYPE(STRING4):0,0\n'
    + 'FIELD:firstname:TYPE(STRING50):0,0\n'
    + 'FIELD:middlename:TYPE(STRING50):0,0\n'
    + 'FIELD:lastname:TYPE(STRING50):0,0\n'
    + 'FIELD:suffix:TYPE(STRING10):0,0\n'
    + 'FIELD:major:TYPE(STRING150):0,0\n'
    + 'FIELD:grade:TYPE(STRING50):0,0\n'
    + 'FIELD:email:TYPE(STRING75):0,0\n'
    + 'FIELD:dateofbirth:LIKE(invalid_date):TYPE(STRING8):0,0\n'
    + 'FIELD:dob_formatted:LIKE(invalid_date):TYPE(STRING8):0,0\n'
    + 'FIELD:attendancedate:TYPE(STRING):0,0\n'
    + 'FIELD:enrollmentstatus:TYPE(STRING50):0,0\n'
    + 'FIELD:addresstype:LIKE(invalid_addresstype):TYPE(STRING10):0,0\n'
    + 'FIELD:address_1:TYPE(STRING100):0,0\n'
    + 'FIELD:address_2:TYPE(STRING100):0,0\n'
    + 'FIELD:city:TYPE(STRING50):0,0\n'
    + 'FIELD:state:TYPE(STRING50):0,0\n'
    + 'FIELD:z5:TYPE(STRING5):0,0\n'
    + 'FIELD:z4:TYPE(STRING4):0,0\n'
    + 'FIELD:phonetyp:LIKE(invalid_phonetyp):TYPE(STRING5):0,0\n'
    + 'FIELD:phonenumber:TYPE(STRING):0,0\n'
    + 'FIELD:tier:TYPE(STRING1):0,0\n'
    + 'FIELD:school_size_code:TYPE(STRING1):0,0\n'
    + 'FIELD:competitive_code:TYPE(STRING1):0,0\n'
    + 'FIELD:tuition_code:TYPE(STRING1):0,0\n'
    + 'FIELD:title:TYPE(STRING5):0,0\n'
    + 'FIELD:fname:TYPE(STRING20):0,0\n'
    + 'FIELD:mname:TYPE(STRING20):0,0\n'
    + 'FIELD:lname:TYPE(STRING20):0,0\n'
    + 'FIELD:name_suffix:LIKE(invalid_suffix):TYPE(STRING5):0,0\n'
    + 'FIELD:name_score:TYPE(STRING3):0,0\n'
    + 'FIELD:rawaid:TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:prim_range:LIKE(invalid_address):TYPE(STRING10):0,0\n'
    + 'FIELD:predir:LIKE(invalid_address):TYPE(STRING2):0,0\n'
    + 'FIELD:prim_name:LIKE(invalid_address):TYPE(STRING28):0,0\n'
    + 'FIELD:addr_suffix:LIKE(invalid_address):TYPE(STRING4):0,0\n'
    + 'FIELD:postdir:LIKE(invalid_address):TYPE(STRING2):0,0\n'
    + 'FIELD:unit_desig:LIKE(invalid_address):TYPE(STRING10):0,0\n'
    + 'FIELD:sec_range:LIKE(invalid_address):TYPE(STRING8):0,0\n'
    + 'FIELD:p_city_name:LIKE(invalid_city):TYPE(STRING25):0,0\n'
    + 'FIELD:v_city_name:LIKE(invalid_city):TYPE(STRING25):0,0\n'
    + 'FIELD:st:TYPE(STRING2):0,0\n'
    + 'FIELD:zip:TYPE(STRING5):0,0\n'
    + 'FIELD:zip4:TYPE(STRING4):0,0\n'
    + 'FIELD:cart:TYPE(STRING4):0,0\n'
    + 'FIELD:cr_sort_sz:TYPE(STRING1):0,0\n'
    + 'FIELD:lot:TYPE(STRING4):0,0\n'
    + 'FIELD:lot_order:TYPE(STRING1):0,0\n'
    + 'FIELD:dpbc:TYPE(STRING2):0,0\n'
    + 'FIELD:chk_digit:TYPE(STRING1):0,0\n'
    + 'FIELD:rec_type:TYPE(STRING2):0,0\n'
    + 'FIELD:county:TYPE(STRING5):0,0\n'
    + 'FIELD:fips_state:TYPE(STRING2):0,0\n'
    + 'FIELD:fips_county:TYPE(STRING3):0,0\n'
    + 'FIELD:geo_lat:TYPE(STRING10):0,0\n'
    + 'FIELD:geo_long:TYPE(STRING11):0,0\n'
    + 'FIELD:msa:TYPE(STRING4):0,0\n'
    + 'FIELD:geo_blk:TYPE(STRING7):0,0\n'
    + 'FIELD:geo_match:TYPE(STRING1):0,0\n'
    + 'FIELD:err_stat:TYPE(STRING4):0,0\n'
    + 'FIELD:telephone:LIKE(invalid_phone):TYPE(STRING10):0,0\n'
    + 'FIELD:tier2:TYPE(STRING5):0,0\n'
    + 'FIELD:source:TYPE(STRING2):0,0\n'
    + 'FIELD:key:TYPE(INTEGER8):0,0\n'
    + 'FIELD:ssn:TYPE(STRING9):0,0\n'
    + 'FIELD:historical_flag:TYPE(STRING1):0,0\n'
    + 'FIELD:full_name:TYPE(STRING60):0,0\n'
    + 'FIELD:college_class:TYPE(STRING2):0,0\n'
    + 'FIELD:college_name:TYPE(STRING50):0,0\n'
    + 'FIELD:ln_college_name:TYPE(STRING50):0,0\n'
    + 'FIELD:college_major:LIKE(invalid_MajorCode):TYPE(STRING1):0,0\n'
    + 'FIELD:new_college_major:LIKE(invalid_NewMajorCode):TYPE(STRING4):0,0\n'
    + 'FIELD:college_code:TYPE(STRING1):0,0\n'
    + 'FIELD:college_code_exploded:TYPE(STRING20):0,0\n'
    + 'FIELD:college_type:TYPE(STRING1):0,0\n'
    + 'FIELD:college_type_exploded:TYPE(STRING25):0,0\n'
    + 'FIELD:file_type:TYPE(STRING1):0,0\n'
    + 'FIELD:collegeupdate:TYPE(STRING4):0,0\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

