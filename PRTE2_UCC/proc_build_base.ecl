IMPORT PRTE2_UCC, UCCV2, PromoteSupers, STD, PRTE2, Address, AID, AID_Support, ut;
#constant(AID_Support.Constants.StoredWhichAIDCache, AID_Support.Constants.eCache.ForNonHeader);

EXPORT proc_build_base := FUNCTION
//Input
//Uppercase, CleanSpaces, and remove unprintable characters
PRTE2.CleanFields(PRTE2_UCC.Files.Main_in, dMainIn);
PRTE2.CleanFields(PRTE2_UCC.Files.Party_in, dPartyIn);

// Customer data -- future
//Project into same layout as Initial data

// New data
//dMain_new		:= dMainIn(trim(cust_name) != ''); -- No need to seperate file as no cleaning is done with output
dParty_new	:= dPartyIn(trim(cust_name) != '');

//Create persist Main
Layouts.Main_ext PersistMain(Layouts.Main_in le) := TRANSFORM
	SELF.persistent_record_id := HASH64(
															le.tmsid	
															+le.rmsid	
															+le.orig_filing_number
															+le.orig_filing_type
															+le.orig_filing_date
															+le.orig_filing_time
															+le.filing_number
															+le.filing_type
															+le.filing_date
															+le.filing_time
															+le.filing_status
															+le.Status_type
															+le.page
															+le.expiration_date
															+le.contract_type
															+le.statements_filed
															+le.microfilm_number
															+le.duns_number
															+le.collateral_desc
															+le.prim_machine
															+le.manufacturer_code
															+le.manufacturer_name
															+le.model
															+le.model_year
															+le.model_desc
															+le.collateral_count
															+le.manufactured_year
															+le.serial_number
															+le.Property_desc
															+le.borough
															+le.block
															+le.lot
															+le.collateral_address
															+le.air_rights_indc
															);									
  SELF := le;
	SELF := [];
 END;
 
 pMainOut := PROJECT(dMainIn, PersistMain(left));
 
 //Clean Names/address and create persist - Party 
Layouts.Party_ext PrepAddr(Layouts.Party_in le) := TRANSFORM
	tempFullAddr			:= Address.fn_addr_clean_prep(TRIM(le.Orig_address1)+' '+ TRIM(le.Orig_address2), 'first');
	tempCityStZip			:= Address.fn_addr_clean_prep(TRIM(le.Orig_city) +', '+ TRIM(le.Orig_state) +' '+ TRIM(le.Orig_zip5)+TRIM(le.Orig_zip4), 'last');
	SELF.prep_addr_line1			:= tempFullAddr;
	SELF.prep_addr_last_line	:= tempCityStZip;
  SELF := le;
	SELF := [];
 END;
 
pPrepAddrOut	:= PROJECT(dParty_new, PrepAddr(left));
 
unsigned4	lFlags := AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;

AID.MacAppendFromRaw_2Line(pPrepAddrOut, prep_addr_line1, prep_addr_last_line, RawAID, addr_clean, lFlags);
		
Layouts.Party_ext xForm(addr_clean le) := TRANSFORM
	//Clean Name/Company
	tempName	:= IF(TRIM(le.Orig_lname) <> '' and TRIM(le.Orig_fname) <> '',
											Address.CleanPersonLFM73(TRIM(le.Orig_lname)+ IF(TRIM(le.Orig_suffix) <> '',' '+TRIM(le.Orig_suffix)+', ',', ')
											+TRIM(le.Orig_fname)+' '+TRIM(le.Orig_mname)),'');
											
	TempCleanComp	:= IF(TRIM(le.Orig_name)<> '', STD.Str.CleanSpaces(le.Orig_name),'');
	
	SELF.title				:= tempName[1..5];
	SELF.fname				:= tempName[6..25];
	SELF.mname				:= tempName[26..45];
	SELF.lname				:= tempName[46..65];
	SELF.name_suffix	:= tempName[66..70];
	SELF.name_score		:= tempName[71..73];
	SELF.company_name := TempCleanComp;
	
	//Clean Address
	SELF.RawAID	   		:=	le.AIDWork_RawAID;
	SELF.prim_range   :=  le.AIDWork_ACECache.prim_range;
	SELF.predir       :=  le.AIDWork_ACECache.predir;
	SELF.prim_name    :=  le.aidwork_acecache.prim_name;
	SELF.suffix  			:=  le.AIDWork_ACECache.addr_suffix;
	SELF.postdir      :=  le.AIDWork_ACECache.postdir;
	SELF.unit_desig	  :=	le.AIDWork_AceCache.unit_desig;
	SELF.sec_range    :=  le.AIDWork_ACECache.sec_range;
	SELF.p_city_name  :=  le.AIDWork_ACECache.p_city_name;
	SELF.v_city_name  :=  le.AIDWork_ACECache.v_city_name;
	SELF.st           :=  le.AIDWork_ACECache.st;
	SELF.zip5         :=  le.aidwork_acecache.zip5;
	SELF.zip4         :=  le.aidwork_acecache.zip4;
	SELF.cart		      :=	le.AIDWork_AceCache.cart;
	SELF.cr_sort_sz	  :=	le.AIDWork_AceCache.cr_sort_sz;
	SELF.lot		      :=	le.AIDWork_AceCache.lot;
	SELF.lot_order		:=	le.AIDWork_AceCache.lot_order;
	SELF.dpbc		      :=	le.AIDWork_AceCache.dbpc;
	SELF.chk_digit		:=	le.AIDWork_AceCache.chk_digit;
	SELF.rec_type	    :=	le.AIDWork_AceCache.rec_type;
	SELF.county	      :=	le.AIDWork_AceCache.county;
	SELF.geo_lat		  :=	le.AIDWork_AceCache.geo_lat;
	SELF.geo_long		  :=	le.AIDWork_AceCache.geo_long;
	SELF.msa			   	:=	le.AIDWork_AceCache.msa;
	SELF.geo_blk		  :=	le.AIDWork_AceCache.geo_blk;
	SELF.geo_match		:=	le.AIDWork_AceCache.geo_match;
	SELF.err_stat		  :=	le.AIDWork_AceCache.err_stat;
	//DID and BDID process
	SELF.bdid					:= prte2.fn_AppendFakeID.bdid(self.company_name, self.prim_range,  self.prim_name,  self.v_city_name,  self.st,  self.zip5,  le.cust_name);
	SELF.did	 				:= prte2.fn_AppendFakeID.did(self.fname, self.lname, le.link_ssn, le.link_dob, le.cust_name);
	
	vLinkingIds 			:= prte2.fn_AppendFakeID.LinkIds(TempCleanComp, le.link_fein, le.link_inc_date,  le.AIDWork_ACECache.prim_range,  le.aidwork_acecache.prim_name,
																											le.AIDWork_ACECache.sec_range,  le.AIDWork_ACECache.v_city_name,  le.AIDWork_ACECache.st,  le.aidwork_acecache.zip5,  le.cust_name);
	SELF.powid				:= vLinkingIds.powid;
	SELF.proxid				:= vLinkingIds.proxid;
	SELF.seleid				:= vLinkingIds.seleid;
	SELF.orgid				:= vLinkingIds.orgid;
	SELF.ultid				:= vLinkingIds.ultid;
  SELF := le;
 END;
 
 pCleanOut	:= PROJECT(addr_clean, xForm(left));
 
 //combine the sources
//concatMain := MainBase + new_data_etl'd
concatParty := PROJECT(dPartyIn(TRIM(cust_name) = ''),TRANSFORM(Layouts.Party_ext,SELF := LEFT; SELF := [])) + pCleanOut;
dedParty		:= DEDUP(SORT(concatParty,tmsid,rmsid),ALL);
 
 Layouts.Party_ext PersistParty(dedParty le) := TRANSFORM
 	SELF.persistent_record_id := hash64( 
																le.tmsid
																+le.rmsid
																+le.Orig_name
																+le.Orig_lname
																+le.Orig_fname
																+le.Orig_mname
																+le.Orig_suffix
																+le.duns_number
																+le.hq_duns_number
																+le.ssn
																+le.fein
																+le.Incorp_state
																+le.corp_number
																+le.corp_type
																+le.Orig_address1
																+le.Orig_address2
																+le.Orig_city
																+le.Orig_state
																+le.Orig_zip5
																+le.Orig_zip4
																+le.Orig_country
																+le.Orig_postal_code
																+le.Party_type
																+le.company_name
																+le.title
																+le.fname
																+le.mname
																+le.lname
																+le.name_suffix
																+le.prim_range
																+le.prim_name
																+le.suffix
																+le.postdir
																+le.unit_desig
																+le.sec_range
																+le.p_city_name
																+le.zip5
																+le.bdid
																+le.did
																);
	  SELF := le;
 END;
 
 pPartyOut	:= PROJECT(dedParty, PersistParty(left));

PromoteSupers.Mac_SF_BuildProcess(pMainOut(TMSID <> ''), Constants.BASE_PREFIX +'main', build_main);
PromoteSupers.Mac_SF_BuildProcess(pPartyOut(TMSID <> ''), Constants.BASE_PREFIX +'party', build_party);

RETURN SEQUENTIAL(build_main, build_party);

END;