IMPORT  prte2_DLV2,PromoteSupers,prte2,std,AID,Address,PRTE2,ut;

EXPORT PROC_BUILD_BASE(String filedate) := FUNCTION
  //uppercase and remove spaces from in file
  PRTE2.CleanFields(Files.dl2_drvlic_in,dInClean);
   
  //Splitting New & Exisitng Records
  dExistingRecords := PROJECT(dInClean(TRIM(cust_name) = ''), TRANSFORM(Layouts.Layout_Base, SELF := LEFT, SELF := [])); 
  dNewRecords			 := dInClean(TRIM(cust_name) <> '');
  
  //Prepping Raw Addresses for New Records
  PrepAddrLayout := 
  RECORD
    layouts.layout_in;
    STRING100	Append_Ace1_PrepAddr2;
    AID.Common.xAID	Append_Ace1_RawAID	:=	0;
  END;

  PrepAddrLayout	tAppendPrepAddr(dNewRecords L) := 
  TRANSFORM
    SELF.Append_Ace1_PrepAddr2	:= Address.Addr2FromComponents(L.City, L.State, L.Zip);
    SELF := L;
    SELF := [];
  END;
  
  dAddressPrep	:= PROJECT(dNewRecords, tAppendPrepAddr(LEFT)); 

  //Address Cleaning
  UNSIGNED4 lAIDAppendFlags := AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords|AID.Common.eReturnValues.NoNewCacheFiles;
  AID.MacAppendFromRaw_2Line(dAddressPrep, Addr1, Append_Ace1_PrepAddr2, Append_Ace1_RawAID, dAddressCleaned, lAIDAppendFlags);																			

  //Transforming Name & Address 																			
  Layouts.Layout_Base	xformBase(dAddressCleaned	l) := 
  TRANSFORM																	
      //Name Cleaning
      v_clean_name := Address.CleanPersonFML73(L.name); 
      SELF.fname					:= v_clean_name[6..25];
      SELF.mname					:= v_clean_name[26..45];	
      SELF.lname					:= v_clean_name[46..65];
      SELF.name_suffix		:= v_clean_name[66..70];
      SELF.cleaning_score	:= v_clean_name[71..73];

      SELF.prim_range   := L.AIDWork_ACECache.prim_range;
      SELF.predir       := L.AIDWork_ACECache.predir;
      SELF.prim_name    := L.AIDWork_ACECache.prim_name;;
      SELF.suffix    		:= L.AIDWork_ACECache.addr_suffix;
      SELF.postdir      := L.AIDWork_ACECache.postdir;
      SELF.unit_desig	  := L.AIDWork_ACECache.unit_desig;
      SELF.sec_range    := L.AIDWork_ACECache.sec_range;
      SELF.p_city_name  := L.AIDWork_ACECache.p_city_name;
      SELF.v_city_name  := L.AIDWork_ACECache.v_city_name;
      SELF.st           := L.AIDWork_ACECache.st;
      SELF.zip5         := L.AIDWork_ACECache.zip5;
      SELF.zip4         := L.AIDWork_ACECache.zip4;
      SELF.cart         := L.AIDWork_ACECache.cart;
      SELF.cr_sort_sz   := L.AIDWork_ACECache.cr_sort_sz;
      SELF.lot          := L.AIDWork_ACECache.lot;
      SELF.lot_order    := L.AIDWork_ACECache.lot_order;
      SELF.chk_digit    := L.AIDWork_ACECache.chk_digit;
      SELF.rec_type     := L.AIDWork_ACECache.rec_type;
      SELF.ace_fips_st  := L.AIDWork_ACECache.county[1..2];
      SELF.county				:= L.AIDWork_ACECache.county[3..5];
      SELF.geo_lat		  := L.AIDWork_ACECache.geo_lat;
      SELF.geo_long		  := L.AIDWork_ACECache.geo_long;
      SELF.geo_blk		  := L.AIDWork_ACECache.geo_blk;
      SELF.geo_match		:= L.AIDWork_ACECache.geo_match;
      SELF.err_stat		  := L.AIDWork_ACECache.err_stat;
    
      //Append ID(s)
      dob := (string)L.dob;
      SELF.did := prte2.fn_AppendFakeID.did(SELF.fname, SELF.lname, L.ssn, dob, L.cust_name);

      SELF.age := (qstring3)ut.age(L.dob);
      
      SELF := L;
      SELF := [];
  END;
  
  dNewRecordsClean := project(dAddressCleaned, xformBase(left));
  
  //Concatenating Original & New Records
  dFinal := dNewRecordsClean + dExistingRecords;
  
  //generating a sequence number for "dl_seq"
  ut.MAC_Sequence_Records(dFinal,dl_seq,dFinalSeq);

  PromoteSupers.MAC_SF_BuildProcess(dFinalSeq,Constants.file_base, writefile);

  RETURN writefile;

END;