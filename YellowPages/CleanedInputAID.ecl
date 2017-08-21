IMPORT YellowPages, address, AID, MDR, STD;

EXPORT CleanedInputAID(
  STRING																	  pversion	
 ,DATASET(Layout_YellowPages)	              pInput          = Files().Input.Using
                                                              //Remove the historical Gong records first
 ,DATASET(Layout_YellowPages_Base_V2_BIP	)	pBaseFile				= Files().Base.QA(source <> MDR.sourceTools.src_Gong_Government AND
                                                                              source <> MDR.sourceTools.src_Gong_Business)
)	:=	FUNCTION

  TargusIn	:=	pInput(business_name <> '');

  YellowPages.Layout_YellowPages_Base_V2_BIP tProjectAIDClean(TargusIn L) := TRANSFORM
	  SELF.Append_Prep_Address_Situs				:=	Address.fn_addr_clean_prep(TRIM( TRIM(L.House,      LEFT, RIGHT) + ' ' 
																																						 + TRIM(L.Predir,     LEFT, RIGHT) + ' '
																																						 + TRIM(L.Street,     LEFT, RIGHT) + ' '
																																						 + TRIM(L.StreetType, LEFT, RIGHT) + ' '
																																						 + TRIM(L.Postdir,    LEFT, RIGHT) + ' '
																																						 + TRIM(L.AptType,    LEFT, RIGHT) + ' '
																																						 + TRIM(L.AptNbr,     LEFT, RIGHT) + ' '
																																						 + IF(L.BoxNbr <> '', 'PO Box ', '')
																																						 + IF(L.BoxNbr <> '', TRIM(L.BoxNbr,LEFT,RIGHT), '')
																																						 ),
																																						 'first');
		SELF.Append_Prep_Address_Last_Situs	:=	Address.fn_addr_clean_prep(  TRIM( TRIM(L.orig_city,  LEFT, RIGHT)
																																						 + IF(TRIM(L.orig_city,  LEFT, RIGHT) <> '',', ','') 
																																						 + TRIM(L.orig_state, LEFT, RIGHT)
																																						 + IF(regexfind('[0-9]{5}',L.orig_zip[1..5]), ' ' + TRIM(L.orig_zip[1..5],   LEFT, RIGHT), '')
																																						 ),
																																						 'last');
		SELF.record_type                    := 'C';
		SELF.RawAID                         := 0;
	  SELF.addr_suffix_flag	              := 'N';
	  SELF.bus_name_flag		              := 'Y';
	  SELF.business_name		              := stringlib.StringToUppercase(L.business_name);
	  SELF.orig_city				              := stringlib.StringToUppercase(L.orig_city);
	  SELF.BusShortName			              := stringlib.StringToUppercase(L.BusShortName);
	  SELF.BusDeptName			              := stringlib.StringToUppercase(L.BusDeptName);
    SELF.dt_first_seen							    := IF(STD.Date.IsValidDate((UNSIGNED4)L.pub_date),     (UNSIGNED4)L.pub_date, 0);
    SELF.dt_last_seen							      := IF(STD.Date.IsValidDate((UNSIGNED4)L.pub_date),     (UNSIGNED4)L.pub_date, 0);
    SELF.dt_vendor_first_reported	      := IF(STD.Date.IsValidDate((UNSIGNED4)pversion[1..8]), (UNSIGNED4)pversion[1..8], 0);
    SELF.dt_vendor_last_reported		    := IF(STD.Date.IsValidDate((UNSIGNED4)pversion[1..8]), (UNSIGNED4)pversion[1..8], 0);	
		SELF                                := L;
    SELF                                := [];
  END;

  rsAIDClean := PROJECT(TargusIn ,tProjectAIDClean(LEFT));

  layout_base_unique := RECORD
    YellowPages.Layout_YellowPages_Base_V2_BIP;
	  UNSIGNED8 unique_id;
  END;

  layout_base_unique tAddUniqueId(rsAIDClean l, UNSIGNED8 cnt) := TRANSFORM
    SELF.unique_id		:= cnt;
	  SELF							:= l;
  END;   

  //At this point we want to work with just the historical yellowpages records,
  //so we filter out the historical Gong records and merge the yp base files with the yp input
  YPBaseFile        := PROJECT(pBaseFile(source = MDR.sourceTools.src_Yellow_Pages), TRANSFORM(RECORDOF(pBaseFile), SELF.record_type := 'H'; SELF := LEFT));
  
  dAllUniqueId      := PROJECT(rsAIDClean + YPBaseFile, tAddUniqueId(LEFT,COUNTER));
  dAllUniqueId_dist := DISTRIBUTE(dAllUniqueId, unique_id);

  layout_AIDSlim_prep := RECORD
	  STRING77	Append_Prep_Address_Situs;
	  STRING54	Append_Prep_Address_Last_Situs;
	  AID.Common.xAID	RawAID;
    UNSIGNED8 unique_id;
  END;

  dPreppedSlim := PROJECT(dAllUniqueId_dist(TRIM(Append_Prep_Address_Last_Situs, ALL) <> ''), layout_AIDSlim_prep);
  
  UNSIGNED4 lAIDFlags := AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;
  AID.MacAppendFromRaw_2Line(dPreppedSlim,Append_Prep_Address_Situs, Append_Prep_Address_Last_Situs, RawAID, rsCleanAID, lAIDFlags);

  dAIDSlim_dist := DISTRIBUTE(rsCleanAID, unique_id);
																											
  YellowPages.Layout_YellowPages_Base_V2_BIP CleanAddr(dAllUniqueId_dist L, dAIDSlim_dist R) := TRANSFORM	
	  SELF.prim_range				:= R.aidwork_acecache.prim_range;
	  SELF.predir						:= R.aidwork_acecache.predir;
	  SELF.prim_name				:= R.aidwork_acecache.prim_name;
	  SELF.suffix						:= R.aidwork_acecache.addr_suffix;
	  SELF.postdir					:= R.aidwork_acecache.postdir;
	  SELF.unit_desig				:= R.aidwork_acecache.unit_desig;
	  SELF.sec_range				:= R.aidwork_acecache.sec_range;
	  SELF.p_city_name			:= R.aidwork_acecache.p_city_name;
	  SELF.v_city_name			:= R.aidwork_acecache.v_city_name;
	  SELF.st								:= R.aidwork_acecache.st;
	  SELF.zip							:= R.aidwork_acecache.zip5;
	  SELF.zip4							:= R.aidwork_acecache.zip4;
	  SELF.cart							:= R.aidwork_acecache.cart;
	  SELF.cr_sort_sz				:= R.aidwork_acecache.cr_sort_sz;
	  SELF.lot							:= R.aidwork_acecache.lot;
	  SELF.lot_order				:= R.aidwork_acecache.lot_order;
	  SELF.dpbc							:= R.aidwork_acecache.dbpc;
	  SELF.chk_digit				:= R.aidwork_acecache.chk_digit;
	  SELF.rec_type					:= R.aidwork_acecache.rec_type;
	  SELF.county						:= R.aidwork_acecache.county;
	  SELF.geo_lat					:= R.aidwork_acecache.geo_lat;
	  SELF.geo_long					:= R.aidwork_acecache.geo_long;
	  SELF.msa							:= R.aidwork_acecache.msa;
	  SELF.geo_blk					:= R.aidwork_acecache.geo_blk;
	  SELF.geo_match				:= R.aidwork_acecache.geo_match;
	  SELF.err_stat					:= R.aidwork_acecache.err_stat;
	  SELF.rawaid           := R.aidwork_rawaid;
    SELF.aceaid				    := R.aidwork_acecache.aid;
	  SELF.orig_street			:= R.Append_Prep_Address_Situs;
	  SELF									:= L;
	  SELF									:= [];
  END;
		
  TargusInAddrCleaned	:=	JOIN(dAllUniqueId_dist,
                               dAIDSlim_dist,
                               LEFT.unique_id = RIGHT.unique_id,
                               CleanAddr(LEFT,RIGHT),
                               LOCAL);			
			
  npanxx_layout	:=	RECORD
	  STRING3		npa;
	  STRING3		nxx;
	  STRING25	city;
	  STRING2		state;
	  STRING5		zip;
	  STRING1		aceFlag;
	  STRING25	altCity1;
	  STRING5		altZip1;
	  STRING25	altCity2;
	  STRING5		altZip2;
	  STRING1		lf;
  END;

  npaState_layout	:=	record
    STRING3		npa;
	  STRING2		state;
	  STRING1		lf;
  END;

  npanxx_lookup	  :=	DATASET('~thor_data400::in::npanxx::lookup', npanxx_layout, FLAT);
  npaState_lookup	:=	DATASET('~thor_data400::in::npa_state::lookup', npaState_layout, FLAT);

  YellowPages.Layout_YellowPages_Base_V2_BIP join4NPANXX(TargusInAddrCleaned l, npanxx_layout r)	:=	TRANSFORM
	  SELF.nn_fix_city		  :=	r.city;
	  SELF.nn_fix_state		  :=	r.state;	
	  SELF.nn_fix_zip			  :=	r.zip;
	  SELF.nn_fix_ace_flag	:=	r.aceFlag;
	  SELF.nn_fix_alt_city1	:=	r.altCity1;
	  SELF.nn_fix_alt_zip1	:=	r.altZip1;
	  SELF.nn_fix_alt_city2	:=	r.altCity2;
	  SELF.nn_fix_alt_zip2	:=	r.altZip2;
	  SELF.n_fix_state		  :=	'';
	  SELF					        :=	l;
  END;	

  Add_NPANXX	 	:=  JOIN(	TargusInAddrCleaned,
								          npanxx_lookup,
								          LEFT.orig_phone10[1..3] = RIGHT.npa AND
								          LEFT.orig_phone10[4..6] = RIGHT.nxx,
								          join4NPANXX(LEFT,RIGHT),
								          LOOKUP,
								          LEFT OUTER);	
							
  YellowPages.Layout_YellowPages_Base_V2_BIP join4NPAState(Add_NPANXX l, npaState_layout r)	:=	TRANSFORM
    SELF.n_fix_state		:=	r.state;
	  SELF								:=	l;
  END;	
																											
  returndataset :=  JOIN(	Add_NPANXX,
								          npaState_lookup,
								          LEFT.orig_phone10[1..3] = RIGHT.npa,
								          join4NPAState(LEFT,RIGHT),
								          LOOKUP,
								          LEFT OUTER) :PERSIST(persistnames().Cleaned_Input_AID);
	
	RETURN returndataset;

END;