// header/layout_header --> header/layout_header_v2
EXPORT layout_header := RECORD
  unsigned6    did := 0;
  //unsigned6    PreGLB_did := 0;
  unsigned6    rid;
  string1    pflag1 := '';    //for original pflag purposes
    //A is the former A1A
    //P is the former A1P - although i see none of these
    //+ is the former A1+
  string1     pflag2 := '';    //for phone number related work
    //R is where a phone number was replaced by gong hist phone number
    //E is where a phone number was enhance by gong hist phone number
    //N is where we have added an area code using zip and nxx match to tpm file
    //P is where you accidentally got a property phone that we later cleaned out
    //A is where we added an apt number - see header.apt_patch
      //see gong.BWR_Patch_Header
  string1     pflag3 := '';    //for marking records that will have to be split into multiples for despray
    //see header.translatePflag3
  string2      src;
  unsigned3    dt_first_seen;
  unsigned3    dt_last_seen;
  unsigned3    dt_vendor_last_reported;
  unsigned3    dt_vendor_first_reported;
  unsigned3    dt_nonglb_last_seen;
  string1      rec_type;
  qstring18    vendor_id;
  qstring10    phone;
  qstring9     ssn;
  integer4     dob;
  qstring5     title;
  qstring20    fname;
  qstring20    mname;
  qstring20    lname;
  qstring5     name_suffix;
  qstring10    prim_range;
  string2      predir;
  qstring28    prim_name;
  qstring4     suffix;
  string2      postdir;
  qstring10    unit_desig;
  qstring8     sec_range;
  qstring25    city_name;
  string2      st;
  qstring5     zip;
  qstring4     zip4;
  string3      county;
  qstring7     geo_blk;
  qstring5     cbsa := '';
  string1      tnt := ' ';
  // these are computed during header build
  // N = Name+Address does not exist in Gong
  // Y = Name+Address does exist in Gong
  // P = Name+Address+Phone does exist in Gong
  // D = Dead
  // these are computed at query time
  // TNT Verification levels
  // B = Bullseye Â– is currently the Â‘bestÂ’ address and is a DID match to the gong file
  // *** The ultimate, full phone verification and other records pointing at that being best address too
  // V = Verified Â– is currently the Â‘bestÂ’ address and is a HHID match to the gong file
  // *** Other records support this as the best address and the HOUSEHOLD has a phone registered at this line. Will pick up women with different lname to husbands
  // C = Current Â– is best address but not validated by the gong file
  // *** Self evident, works even when there is no phone indicator
  // P = Probable Â– is not currently the best address, but is did verified or hhid verified with a dt_last_seen within 6 months
  // *** Most likely because the best address is a mailing (only) address. This annotates the address with the active phone line out of Â‘lived inÂ’ addresses
  // R = Relative Â– is not currently the best address, and has a dt_last_seen > 6 months ago but is HHID verified
  // *** Probably identifies a situation where a family member moved out of the address
  // H = Historic Â– is not the best address and is not HHID or DID verified
  // *** A dead, historic address
  string1     valid_SSN := '';
  // G=good; F=fatfingers(typo; one or two digits off in the same positions);
  // R=relative ; B=bad ; O=old (SSA issued before individual's DOB);
  // Z= ssn matches best_ssn, but someone else owns it;
  // U=unknown 
  // M=SSN in the records is manufactured; it cam from watchdog non-GLB best if available
  // M is populated in the keys only.  base file does not contain M.
  string1     jflag1 := '';  //valid_DOB
  // C - correct 
  // L - correct but low quality
  // I - invalid
  // T - typo
  // B - bad
  // U - undetermined
  string1      jflag2 := '';
  // set in header.Last_Rollup amd header.With_Did
  // Ambiguous := 'A';
  // AmbiguousPropertySingleton := 'D';
  // AmbiguousPropertyMultiple := 'E';
  // NotAmbiguousPropertyMultiple := 'C';
  // NotAmbiguousPropertySingleton := 'B';
  string1     jflag3 := ''; //ssn confirmed from EQ or BA
  unsigned8   RawAID := 0; 
  string5    Dodgy_tracking:= '';  // UNK's from name_suffix
  unsigned8  NID:=0;  // name cleaner ID
  unsigned2  address_ind:=0;  // address indicator bitmap
  unsigned2  name_ind:=0;  // name indicator bitmap
  unsigned8 persistent_record_ID := 0; //tracking the record between full header and individual dataset
END;
