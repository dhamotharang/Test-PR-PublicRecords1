IMPORT infutor,ut,header_slimsort,did_add,didville,business_header_ss,business_header,address;

LexIdThreshold := 75;
// Macro takes either of the two input formats, re-formats and cleans the data
// and determines clean name and address information
macPrepForClean(dIn,sVendor,dOut):=MACRO
  #UNIQUENAME(tMap)
  reunion.layouts.lClean %tMap%(RECORDOF(dIn) L):=TRANSFORM
	  sCleanPerson:=address.cleanpersonlfm73(TRIM(stringlib.stringtouppercase(L.last_name),LEFT,RIGHT)+', '+TRIM(stringlib.stringtouppercase(L.first_name),LEFT,RIGHT));
		#IF((UNSIGNED)sVendor > 1 AND (UNSIGNED)sVendor < 6)
		  sCleanAddress:=address.cleanaddress182(stringlib.stringtouppercase(L.street),stringlib.stringtouppercase(L.city)+' '+stringlib.stringtouppercase(L.state)+' '+L.zip);
		#END
    SELF.vendor:=sVendor;
    SELF.orig_vendor_id:=L.user_num;
    SELF.orig_last_name:=stringlib.stringtouppercase(L.last_name);
    SELF.orig_first_name:=stringlib.stringtouppercase(L.first_name);
    SELF.title:=sCleanPerson[ 1.. 5];
    SELF.fname:=sCleanPerson[ 6..25];
    SELF.mname:=sCleanPerson[26..45];
    SELF.lname:=sCleanPerson[46..65];
    SELF.name_suffix:=sCleanPerson[66..70];
    SELF.name_score:=sCleanPerson[71..73];
    SELF.orig_dob:=L.dob;
    SELF.orig_gender:=stringlib.stringtouppercase(L.gender);
    SELF.orig_zip:=L.zip;
		#IF((UNSIGNED)sVendor = 6)
			SELF.clean_dob:=L.dob;
		#ELSE
			SELF.clean_dob:=L.dob[7..10]+L.dob[1..2]+L.dob[4..5];
		#END
    SELF.clean_dob_yyyymm :=SELF.clean_dob[1..6];
		#IF((UNSIGNED)sVendor in [1,6])
		  SELF.zip:=SELF.orig_zip[1..5];
		#ELSE
		  SELF.orig_strt:=stringlib.stringtouppercase(L.street);
			SELF.orig_locnm:=stringlib.stringtouppercase(L.city);
			SELF.orig_state:=stringlib.stringtouppercase(L.state);
      SELF.prim_range  := sCleanAddress[ 1..  10];
      SELF.predir      := sCleanAddress[ 11.. 12];
      SELF.prim_name   := sCleanAddress[ 13.. 40];
      SELF.addr_suffix := sCleanAddress[ 41.. 44];
      SELF.postdir     := sCleanAddress[ 45.. 46];
      SELF.unit_desig  := sCleanAddress[ 47.. 56];
      SELF.sec_range   := sCleanAddress[ 57.. 64];
      SELF.p_city_name := sCleanAddress[ 65.. 89];
      SELF.v_city_name := sCleanAddress[ 90..114];
      SELF.st          := sCleanAddress[115..116];
      SELF.zip         := sCleanAddress[117..121];
      SELF.zip4        := sCleanAddress[122..125];
      SELF.cart        := sCleanAddress[126..129];
      SELF.cr_sort_sz  := sCleanAddress[130..130];
      SELF.lot         := sCleanAddress[131..134];
      SELF.lot_order   := sCleanAddress[135..135];
      SELF.dbpc        := sCleanAddress[136..137];
      SELF.chk_digit   := sCleanAddress[138..138];
      SELF.rec_type    := sCleanAddress[139..140];
      SELF.county      := sCleanAddress[141..145];
      SELF.geo_lat     := sCleanAddress[146..155];
      SELF.geo_long    := sCleanAddress[156..166];
      SELF.msa         := sCleanAddress[167..170];
      SELF.geo_blk     := sCleanAddress[171..177];
      SELF.geo_match   := sCleanAddress[178..178];
      SELF.err_stat    := sCleanAddress[179..182];
		#END
    SELF:=[];
  END;
	dOut:=PROJECT(dIn,%tMap%(LEFT));
ENDMACRO;

macPrepForClean(reunion.files(1).dRawIn01(),'1',dPrep01);
macPrepForClean(reunion.files(1).dRawIn02(),'2',dPrep02);
macPrepForClean(reunion.files(1).dRawIn03(),'3',dPrep03);
macPrepForClean(reunion.files(1).dRawIn04(),'4',dPrep04);
macPrepForClean(reunion.files(1).dRawIn05(),'5',dPrep05);
macPrepForClean(reunion.files(1).dRawIn06(),'6',dPrep06);

// recs := 1000;
// macPrepForClean(choosen(reunion.files(1).dRawIn01(), recs),'1',dPrep01);
// macPrepForClean(choosen(reunion.files(1).dRawIn02(), recs),'2',dPrep02);
// macPrepForClean(choosen(reunion.files(1).dRawIn03(), recs),'3',dPrep03);
// macPrepForClean(choosen(reunion.files(1).dRawIn04(), recs),'4',dPrep04);
// macPrepForClean(choosen(reunion.files(1).dRawIn05(), recs),'5',dPrep05);
// macPrepForClean(choosen(reunion.files(1).dRawIn06(), recs),'6',dPrep06);

// Prep the two input files for DID lookup
dCleanPrep01:=dPrep01:PERSIST('~thor::persist::mylife::01_prep', EXPIRE(10), refresh(false));
dCleanPrep02:=dPrep02:PERSIST('~thor::persist::mylife::02_prep', EXPIRE(10), refresh(false));
dCleanPrep03:=dPrep03:PERSIST('~thor::persist::mylife::03_prep', EXPIRE(10), refresh(false));
dCleanPrep04:=dPrep04:PERSIST('~thor::persist::mylife::04_prep', EXPIRE(10), refresh(false));
dCleanPrep05:=dPrep05:PERSIST('~thor::persist::mylife::05_prep', EXPIRE(10), refresh(false));
dCleanPrep06:=dPrep06:PERSIST('~thor::persist::mylife::06_prep', EXPIRE(10), refresh(false));

dAllPrepped:=(dCleanPrep01+dCleanPrep02+dCleanPrep03+dCleanPrep04+dCleanPrep05+dCleanPrep06)(TRIM(fname+lname)<>'');

ssMatchSet:=['A','P','Z','D','Q'];

// First pass.pulling as exact as possible.
did_add.MAC_Match_Flex(dAllPrepped,ssMatchSet,'',clean_dob,fname,mname,lname,name_suffix,prim_range,prim_name,sec_range,zip,st,clean_phone,DID,reunion.layouts.lClean,true,did_score,LexIdThreshold,dMatches01);
dMatched01:=dMatches01(did<>0);

//Second pass against the remainder from the first, dropping the day from the DOB
dNotMatched01:=dMatches01(did =0);
did_add.MAC_Match_Flex(dNotMatched01,ssMatchSet,'',clean_dob_yyyymm,fname,mname,lname,name_suffix,prim_range,prim_name,sec_range,zip,st,clean_phone,DID,reunion.layouts.lClean,true,did_score,LexIdThreshold,dMatches02);

dMatched02:=dMatches02(did<>0);
dNotMatched02:=dMatches02(did =0);

// Business header pass against the remainder of the second pass.
business_header_ss.MAC_Add_BDID_Flex(dNotMatched02,ssMatchSet,orig_fsn,prim_range,prim_name,zip,sec_range,st,clean_phone,foo,bdid,reunion.layouts.lClean,true,bdid_score,dMatches03);
dMatched03:=dMatches03;

EXPORT reunion_clean(unsigned1 mode):=(dMatched01+dMatched02+dMatched03):PERSIST('~thor::persist::mylife::did::' + reunion.Constants.sMode(mode), EXPIRE(10), REFRESH(FALSE));
