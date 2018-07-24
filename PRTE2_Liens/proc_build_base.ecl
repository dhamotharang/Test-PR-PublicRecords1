/* *********************************************************************************************
Please inform the Insurance team if any significant data preparation changes are done
in here.  They may need to imitate data-prep in their PRTE2_Liens_Ins.proc_build_base
********************************************************************************************* */
IMPORT PRTE2_Liens, LiensV2, ut, PromoteSupers, NID, Address, BIPV2, STD, PRTE2_Common, Prte2, AID, AID_Support;
#constant(AID_Support.Constants.StoredWhichAIDCache, AID_Support.Constants.eCache.ForNonHeader);

// Input 
Base_Main_in		:= PRTE2_Liens.files.MainStatus(TMSID <> ''); //Spreadsheet passed blank records
Base_Party_in 	:= PRTE2_Liens.files.SprayParty(TMSID <> ''); //Spreadsheet passed blank records

//Insurance data - Already processed using PRTE2_Liens_Ins.BWR_Spray_Both_Files
Base_Main_Ins 	:= DATASET(PRTE2_Common.Cross_Module_Files.LiensV2_Base_SF_Main, PRTE2_Liens.Layouts.main_base_ext, THOR);
Base_Party_Ins	:= DATASET(PRTE2_Common.Cross_Module_Files.LiensV2_Base_SF_Party, PRTE2_Liens.Layouts.party_base_ext, THOR);

//Create TMSID/RMSID, Persist ID
PRTE2_Liens.Layouts.main_base_ext PopulateID(Base_Main_in L) := TRANSFORM
		self.persistent_record_id := 	HASH64(trim(L.tmsid,left,right)+ ','+
																					trim(L.rmsid,left,right)+  ','+
																					trim(L.filing_jurisdiction,left,right)+  ','+
																					trim(L.filing_state ,left,right)+  ','+
																					trim(L.orig_filing_date ,left,right)+  ','+
																					trim(L.case_number   ,left,right)+  ','+
																					trim(L.filing_number ,left,right)+  ','+
																					trim(L.filing_type_desc ,left,right)+  ','+
																					trim(L.filing_date ,left,right)+  ','+
																					trim(L.filing_time ,left,right)+  ','+
																					trim(L.vendor_entry_date ,left,right)+  ','+
																					trim(L.judge ,left,right)+  ','+
																					trim(L.case_title ,left,right)+  ','+
																					trim(L.release_date ,left,right)+  ','+
																					trim(L.amount ,left,right)+  ','+
																					trim(L.eviction ,left,right)+  ','+
																					trim(L.satisifaction_type ,left,right)+  ','+
																					trim(L.judg_satisfied_date ,left,right)+  ','+
																					trim(L.judg_vacated_date ,left,right)+  ','+
																					trim(L.tax_code ,left,right)+  ','+
																					trim(L.effective_date ,left,right)+  ','+
																					trim(L.lapse_date ,left,right)+  ','+
																					trim(L.accident_date ,left,right)+  ','+
																					trim(L.sherrif_indc ,left,right)+  ','+
																					trim(L.expiration_date ,left,right)+  ','+
																					trim(L.agency ,left,right)+  ','+
																					trim(L.agency_city ,left,right)+  ','+
																					trim(L.agency_state ,left,right)+  ','+
																					trim(L.agency_county ,left,right)+  ','+
																					trim(L.legal_lot ,left,right)+  ','+
																					trim(L.legal_block ,left,right)+  ','+
																					trim(L.legal_borough ,left,right)+  ','+
																					trim(L.certificate_number ,left,right)+ ','+
																					trim(L.filing_status[1].filing_status ,left,right)+trim(L.filing_status[1].filing_status_desc,left,right));
	
	self := L;
END;
pCreateMainIDs := DEDUP(PROJECT(Base_Main_in, PopulateID(left)),ALL);

//Clean address - new records only
fPrevParty	:= PROJECT(Base_Party_in(trim(DID) != '' OR trim(BDID) != ''),PRTE2_Liens.Layouts.party_base_ext); 
fNewParty		:= Base_Party_in(trim(cust_name) != '' AND (trim(DID) = '' or trim(BDID) = ''));

lCleanAddr	:= RECORD
	PRTE2_Liens.Layouts.BaseParty_in;
	UNSIGNED8 RawAID:=0;
	STRING prep_address_first;
	STRING prep_address_last;
END;

lCleanAddr	AddFullAddr(fNewParty L) := TRANSFORM
	self.prep_address_first := Address.fn_addr_clean_prep(TRIM(L.orig_address1)+' '+TRIM(L.orig_address2), 'first'); 
	self.prep_address_last 	:= Address.fn_addr_clean_prep(TRIM(L.orig_city)+ ', '+TRIM(L.orig_state)+' '+TRIM(L.orig_zip5)+TRIM(L.orig_zip4), 'last');
	self	:= L;
	self	:= [];
END;

PrepAddr	:= PROJECT(fNewParty, AddFullAddr(LEFT));

unsigned4	lFlags := AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;

AID.MacAppendFromRaw_2Line(PrepAddr, prep_address_first, prep_address_last, RawAID, addr_clean, lFlags);															

//Add Persistent Record ID/Clean names/Linking ID's
PRTE2_Liens.Layouts.party_base_ext xfmNamesAddr(addr_clean L) := TRANSFORM
	//clean name
	Pname							:= IF(L.ssn != '',trim(L.orig_lname)+', '+trim(L.orig_fname),'');
	TempPname					:= Address.CleanPersonLFM73_fields(Pname);
	self.title				:= TempPname.title;
	self.fname				:= TempPname.fname;
	self.mname				:= TempPname.mname;
	self.lname				:= TempPname.lname;
	self.name_suffix	:= TempPname.name_suffix;
	self.name_score		:= TempPname.name_score;
	self.cname				:= IF(L.tax_id != '', ut.CleanSpacesAndUpper(L.orig_full_debtorname),'');
		
	//Clean address
	self.prim_range     :=  l.AIDWork_ACECache.prim_range;
	self.predir         :=  l.AIDWork_ACECache.predir;
	self.prim_name      :=  l.AIDWork_ACECache.prim_name;;
	self.addr_suffix		:=  l.AIDWork_ACECache.addr_suffix;
	self.postdir        :=  l.AIDWork_ACECache.postdir;
	self.unit_desig	   	:=	l.AIDWork_AceCache.unit_desig;
	self.sec_range      :=  l.AIDWork_ACECache.sec_range;
	self.p_city_name    :=  l.AIDWork_ACECache.p_city_name;
	self.v_city_name    :=  l.AIDWork_ACECache.v_city_name;
	self.st             :=  l.AIDWork_ACECache.st;
	self.zip	          :=  l.aidwork_acecache.zip5;
	self.zip4           :=  l.aidwork_acecache.zip4;
	self.cart		       	:=	l.AIDWork_AceCache.cart;
	self.cr_sort_sz	   	:=	l.AIDWork_AceCache.cr_sort_sz;
	self.lot		       	:=	l.AIDWork_AceCache.lot;
	self.lot_order		  :=	l.AIDWork_AceCache.lot_order;
	self.dbpc		       	:=	l.AIDWork_AceCache.dbpc;
	self.chk_digit		  :=	l.AIDWork_AceCache.chk_digit;
	self.rec_type	      :=	l.AIDWork_AceCache.rec_type;
	self.county	       	:=	l.AIDWork_AceCache.county;
	self.geo_lat		   	:=	l.AIDWork_AceCache.geo_lat;
	self.geo_long		   	:=	l.AIDWork_AceCache.geo_long;
	self.msa			   		:=	l.AIDWork_AceCache.msa;
	self.geo_blk		   	:=	l.AIDWork_AceCache.geo_blk;
	self.geo_match		  :=	l.AIDWork_AceCache.geo_match;
	self.err_stat		   	:=	l.AIDWork_AceCache.err_stat;
		
	//Linking ID's
	self.bdid						:= IF(trim(self.cname) != '', (string)Prte2.fn_AppendFakeID.bdid(self.cname, self.prim_range, self.prim_name, self.v_city_name, self.st, self.zip, L.cust_name),'');
	self.DID						:= IF(trim(self.lname) != '', (string)prte2.fn_AppendFakeID.did(self.fname, self.lname, L.link_ssn, L.link_dob, L.cust_name), '');

	vLinkingIds := Prte2.fn_AppendFakeID.LinkIds(L.orig_full_debtorname, L.link_fein, L.link_inc_date, L.prim_range, L.prim_name, L.sec_range, L.v_city_name, L.st, L.zip, L.cust_name);
	self.powid	:= vLinkingIds.powid;
	self.proxid	:= vLinkingIds.proxid;
	self.seleid	:= vLinkingIds.seleid;
	self.orgid	:= vLinkingIds.orgid;
	self.ultid	:= vLinkingIds.ultid;
	self	:= L;
	self	:= [];
END;

pCleanNameAddr := PROJECT(addr_clean, xfmNamesAddr(left));

//Concat to existing PRCT records and create persistent_id
fPartyAll := pCleanNameAddr + fPrevParty;

PRTE2_Liens.Layouts.party_base_ext AddPersist(fPartyAll L) := TRANSFORM
	self.persistent_record_id := hash64(trim(l.tmsid,left,right)+','+
																		trim(l.rmsid,left,right)+','+
																		trim(l.orig_full_debtorname,left,right)+','+
																		trim(l.orig_name ,left,right)+','+
																		trim(l.orig_lname,left,right)+','+
																		trim(l.orig_fname,left,right)+','+
																		trim(l.orig_mname ,left,right)+','+
																		trim(l.orig_suffix ,left,right)+','+
																		trim(l.tax_id ,left,right)+','+
																		trim(l.ssn ,left,right)+','+
																		trim(l.cname ,left,right)+','+
																		trim(l.orig_address1 ,left,right)+','+
																		trim(l.orig_address2 ,left,right)+','+
																		trim(l.orig_city ,left,right)+','+
																		trim(l.orig_state ,left,right)+','+
																		trim(l.orig_zip5 ,left,right)+','+
																		trim(l.orig_zip4 ,left,right)+','+
																		trim(l.orig_county ,left,right)+','+
																		trim(l.orig_country ,left,right)+','+
																		trim(l.phone ,left,right)+ ','+
																		trim(l.name_type ,left,right) +','+ trim(l.bdid,left,right) +','+trim(l.did,left,right)+','+trim(l.zip,left,right)
																		+trim(l.fname,left,right)+','+trim(l.lname,left,right)+','+trim(l.mname,left,right)+','+trim(l.name_suffix,left,right) +','+ trim(l.zip4,left,right)); // orig name has multiple names 

	self	:= L;
	self	:= [];
END;

pAppendPersist	:= PROJECT(fPartyAll, AddPersist(LEFT));

//combine Boca & Insurance data - insurance data s/b in the *_ext layouts anyway but project just to be sure.
concatMain := pCreateMainIDs + PROJECT(Base_Main_Ins, TRANSFORM(PRTE2_Liens.Layouts.main_base_ext, SELF := LEFT; SELF := []));
concatParty := pAppendPersist + PROJECT(Base_Party_Ins, TRANSFORM(PRTE2_Liens.Layouts.party_base_ext, SELF := LEFT; SELF := []));

PromoteSupers.Mac_SF_BuildProcess(concatMain, Constants.BASE_PREFIX +'main', build_main_base);
PromoteSupers.Mac_SF_BuildProcess(concatParty, Constants.BASE_PREFIX +'party', build_party_base);

EXPORT proc_build_base := SEQUENTIAL(build_main_base, build_party_base);