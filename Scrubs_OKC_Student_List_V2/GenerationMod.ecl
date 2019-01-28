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
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,cleanaddr1,cleanaddr2,cleanattendancedte,cleancity,cleanstate,cleandob,cleanupdatedte,cleanemail,append_email_username,append_domain,append_domain_type,append_domain_root,append_domain_ext,append_is_tld_state,append_is_tld_generic,append_is_tld_country,append_is_valid_domain_ext,cleancollegeId,cleantitle,cleanfirstname,cleanmidname,cleanlastname,cleansuffixname,cleanzip,cleanzip4,cleanmajor,cleanphone,rcid,did,process_date,date_first_seen,date_last_seen,vendor_first_reported,vendor_last_reported,dateupdated,studentid,dartid,collegeid,projectsource,collegestate,college,semester,year,firstname,middlename,lastname,suffix,major,COLLEGE_MAJOR,NEW_COLLEGE_MAJOR,grade,email,dateofbirth,dob_formatted,attendancedate,enrollmentstatus,addresstype,address1,address2,city,state,zip,zip4,phonetyp,phonenumber,tier,school_size_code,competitive_code,tuition_code,title,fname,mname,lname,name_suffix,name_score,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,z5,z4,cart,cr_sort_sz,lot,lot_order,dbpc,chk_digit,rec_type,county,fips_state,fips_county,geo_lat,geo_long,msa,geo_blk,geo_match,err_stat,telephone,tier2,source';
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
    + 'FIELD:cleanaddr1:TYPE(STRING100):LIKE(invalid_address):0,0\n'
    + 'FIELD:cleanaddr2:TYPE(STRING100):LIKE(invalid_address):0,0\n'
    + 'FIELD:cleanattendancedte:0,0\n'
    + 'FIELD:cleancity:TYPE(STRING8):LIKE(invalid_city):0,0\n'
    + 'FIELD:cleanstate:TYPE(STRING8):LIKE(invalid_state):0,0\n'
    + 'FIELD:cleandob:TYPE(STRING8):LIKE(invalid_date):0,0\n'
    + 'FIELD:cleanupdatedte:TYPE(STRING8):LIKE(invalid_date):0,0\n'
    + 'FIELD:cleanemail:TYPE(STRING80):LIKE(invalid_email):0,0\n'
    + 'FIELD:append_email_username:0,0\n'
    + 'FIELD:append_domain:0,0\n'
    + 'FIELD:append_domain_type:0,0\n'
    + 'FIELD:append_domain_root:0,0\n'
    + 'FIELD:append_domain_ext:0,0\n'
    + 'FIELD:append_is_tld_state:0,0\n'
    + 'FIELD:append_is_tld_generic:0,0\n'
    + 'FIELD:append_is_tld_country:0,0\n'
    + 'FIELD:append_is_valid_domain_ext:0,0\n'
    + 'FIELD:cleancollegeId:TYPE(STRING10):0,0\n'
    + 'FIELD:cleantitle:TYPE(STRING5):0,0\n'
    + 'FIELD:cleanfirstname:TYPE(STRING50):LIKE(invalid_name):0,0\n'
    + 'FIELD:cleanmidname:TYPE(STRING50):LIKE(invalid_name):0,0\n'
    + 'FIELD:cleanlastname:TYPE(STRING50):LIKE(invalid_name):0,0\n'
    + 'FIELD:cleansuffixname:TYPE(STRING10):LIKE(invalid_name):0,0\n'
    + 'FIELD:cleanzip:TYPE(STRING5):0,0\n'
    + 'FIELD:cleanzip4:TYPE(STRING4):0,0\n'
    + 'FIELD:cleanmajor:0,0\n'
    + 'FIELD:cleanphone:TYPE(STRING10):LIKE(invalid_phone):0,0\n'
    + 'FIELD:rcid:0,0\n'
    + 'FIELD:did:TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:process_date:TYPE(STRING8):LIKE(invalid_date):0,0\n'
    + 'FIELD:date_first_seen:TYPE(STRING8):LIKE(invalid_date):0,0\n'
    + 'FIELD:date_last_seen:TYPE(STRING8):LIKE(invalid_date):0,0\n'
    + 'FIELD:vendor_first_reported:TYPE(STRING8):LIKE(invalid_date):0,0\n'
    + 'FIELD:vendor_last_reported:TYPE(STRING8):LIKE(invalid_date):0,0\n'
    + 'FIELD:dateupdated:TYPE(STRING8):LIKE(invalid_date):0,0\n'
    + 'FIELD:studentid:TYPE(STRING):LIKE(nums):0,0\n'
    + 'FIELD:dartid:TYPE(STRING4):LIKE(nums):0,0\n'
    + 'FIELD:collegeid:TYPE(STRING10):0,0\n'
    + 'FIELD:projectsource:TYPE(STRING):0,0\n'
    + 'FIELD:collegestate:0,0\n'
    + 'FIELD:college:TYPE(STRING100):LIKE(invalid_college):0,0\n'
    + 'FIELD:semester:TYPE(STRING6):LIKE(invalid_semester):0,0\n'
    + 'FIELD:year:TYPE(STRING4):LIKE(nums):0,0\n'
    + 'FIELD:firstname:0,0\n'
    + 'FIELD:middlename:0,0\n'
    + 'FIELD:lastname:0,0\n'
    + 'FIELD:suffix:0,0\n'
    + 'FIELD:major:0,0\n'
    + 'FIELD:COLLEGE_MAJOR:LIKE(invalid_MajorCode):0,0\n'
    + 'FIELD:NEW_COLLEGE_MAJOR:LIKE(invalid_NewMajorCode):0,0\n'
    + 'FIELD:grade:0,0\n'
    + 'FIELD:email:0,0\n'
    + 'FIELD:dateofbirth:TYPE(STRING8):LIKE(invalid_date):0,0\n'
    + 'FIELD:dob_formatted:TYPE(STRING8):LIKE(invalid_date):0,0\n'
    + 'FIELD:attendancedate:0,0\n'
    + 'FIELD:enrollmentstatus:0,0\n'
    + 'FIELD:addresstype:TYPE(STRING5):LIKE(invalid_addresstype):0,0\n'
    + 'FIELD:address1:0,0\n'
    + 'FIELD:address2:0,0\n'
    + 'FIELD:city:0,0\n'
    + 'FIELD:state:0,0\n'
    + 'FIELD:zip:0,0\n'
    + 'FIELD:zip4:0,0\n'
    + 'FIELD:phonetyp:TYPE(STRING10):LIKE(invalid_phonetyp):0,0\n'
    + 'FIELD:phonenumber:0,0\n'
    + 'FIELD:tier:TYPE(STRING1):0,0\n'
    + 'FIELD:school_size_code:TYPE(STRING1):0,0\n'
    + 'FIELD:competitive_code:TYPE(STRING1):0,0\n'
    + 'FIELD:tuition_code:TYPE(STRING1):0,0\n'
    + 'FIELD:title:TYPE(STRING5):0,0\n'
    + 'FIELD:fname:TYPE(STRING20):0,0\n'
    + 'FIELD:mname:TYPE(STRING20):0,0\n'
    + 'FIELD:lname:TYPE(STRING20):0,0\n'
    + 'FIELD:name_suffix:TYPE(STRING5):LIKE(invalid_suffix):0,0\n'
    + 'FIELD:name_score:TYPE(STRING3):0,0\n'
    + 'FIELD:prim_range:TYPE(STRING10):LIKE(invalid_address):0,0\n'
    + 'FIELD:predir:TYPE(STRING2):LIKE(invalid_address):0,0\n'
    + 'FIELD:prim_name:TYPE(STRING28):LIKE(invalid_address):0,0\n'
    + 'FIELD:addr_suffix:TYPE(STRING4):LIKE(invalid_address):0,0\n'
    + 'FIELD:postdir:TYPE(STRING2):LIKE(invalid_address):0,0\n'
    + 'FIELD:unit_desig:TYPE(STRING10):LIKE(invalid_address):0,0\n'
    + 'FIELD:sec_range:TYPE(STRING8):LIKE(invalid_address):0,0\n'
    + 'FIELD:p_city_name:TYPE(STRING25):LIKE(invalid_city):0,0\n'
    + 'FIELD:v_city_name:TYPE(STRING25):LIKE(invalid_city):0,0\n'
    + 'FIELD:st:TYPE(STRING2):0,0\n'
    + 'FIELD:z5:TYPE(STRING5):0,0\n'
    + 'FIELD:z4:TYPE(STRING4):0,0\n'
    + 'FIELD:cart:TYPE(STRING4):0,0\n'
    + 'FIELD:cr_sort_sz:TYPE(STRING1):0,0\n'
    + 'FIELD:lot:TYPE(STRING4):0,0\n'
    + 'FIELD:lot_order:TYPE(STRING1):0,0\n'
    + 'FIELD:dbpc:TYPE(STRING2):0,0\n'
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
    + 'FIELD:telephone:TYPE(STRING10):LIKE(invalid_phone):0,0\n'
    + 'FIELD:tier2:TYPE(STRING5):0,0\n'
    + 'FIELD:source:TYPE(STRING2):0,0'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

