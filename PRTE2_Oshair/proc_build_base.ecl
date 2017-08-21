IMPORT  PromoteSupers, ut,prte_csv, Address,Prte2,AID;

EXPORT PROC_BUILD_BASE(String filedate) := FUNCTION

df_accident := PROJECT(Files.Accident_IN, layouts.Accident);

df_violations := PROJECT(Files.Violations_IN, layouts.Violations);

df_substance := PROJECT(Files.Substance_IN, layouts.Substance);

df_program := PROJECT(Files.Program_IN, layouts.Program);

PromoteSupers.MAC_SF_BuildProcess(df_accident,constants.Base_Accident, writefile_accident);

PromoteSupers.MAC_SF_BuildProcess(df_violations,constants.Base_Violations, writefile_violations);

PromoteSupers.MAC_SF_BuildProcess(df_substance,constants.Base_Substance, writefile_substance);

PromoteSupers.MAC_SF_BuildProcess(df_program,constants.Base_Program, writefile_program);

dInspect	:= Files.Inspection_IN;
lCleanAddr      := RECORD
                PRTE2_Oshair.Layouts.Inspection;
                UNSIGNED8 RawAID:=0;
                STRING prep_address_first;
                STRING prep_address_last;
END;

lCleanAddr      AddFullAddr(dInspect L) := TRANSFORM
                self.prep_address_first := Address.fn_addr_clean_prep(TRIM(L.inspected_site_street)+' '+ '', 'first'); 
                self.prep_address_last                 := Address.fn_addr_clean_prep(TRIM(L.inspected_site_city_name)+ ', '+TRIM(L.inspected_site_state)+' '+ (string5)L.inspected_site_zip +'', 'last');
                self         := L;
                self         := [];
END;

PrepAddr            := PROJECT(dInspect, AddFullAddr(LEFT));

unsigned4           lFlags := AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;

AID.MacAppendFromRaw_2Line(PrepAddr, prep_address_first, prep_address_last, RawAID, addr_clean, lFlags);

Layouts.layout_OSHAIR_inspection_clean_BIP_Ext ClnAddr(addr_clean l) := TRANSFORM

	self.prim_range   := l.aidwork_acecache.prim_range;
	self.predir       := l.aidwork_acecache.predir;
	self.prim_name    := l.aidwork_acecache.prim_name;
	self.addr_suffix  := l.aidwork_acecache.addr_suffix;
	self.postdir      := l.aidwork_acecache.postdir;
	self.unit_desig   := l.aidwork_acecache.unit_desig;
	self.sec_range 	  := l.aidwork_acecache.sec_range;
	self.p_city_name  := l.aidwork_acecache.p_city_name;
	self.v_city_name  := l.aidwork_acecache.v_city_name;
	self.st 	     	  := l.aidwork_acecache.st;
	self.zip5	     	  := l.aidwork_acecache.zip5;
	self.zip4	     	  := l.aidwork_acecache.zip4;
	self.cart         := l.aidwork_acecache.cart;
	self.cr_sort_sz   := l.aidwork_acecache.cr_sort_sz;
	self.lot 		      := l.aidwork_acecache.lot;
	self.lot_order 	  := l.aidwork_acecache.lot_order;
	self.dpbc       := l.aidwork_acecache.dbpc;
	self.chk_digit    := l.aidwork_acecache.chk_digit;
	self.addr_rec_type:= l.aidwork_acecache.rec_type;
	self.fips_state   := l.aidwork_acecache.st;
	self.fips_county  := l.aidwork_acecache.county;
	self.geo_lat 	    := l.aidwork_acecache.geo_lat;
	self.geo_long 	  := l.aidwork_acecache.geo_long;
	self.cbsa 		    := l.aidwork_acecache.msa;
	self.geo_blk   	  := l.aidwork_acecache.geo_blk;
	self.geo_match 	  := l.aidwork_acecache.geo_match;
	self.err_stat 	  := l.aidwork_acecache.err_stat;
	self.cname       	:= 	ut.CleanSpacesAndUpper(l.inspected_site_name);
	self.fein_append  :=l.fein;


	self.bdid := if(L.cust_name = '', 0, prte2.fn_AppendFakeID.bdid(l.inspected_site_name, self.prim_range, self.prim_name, self.v_city_name, self.st, self.zip5, L.cust_name));   

vLinkingIds := prte2.fn_AppendFakeID.LinkIds(l.inspected_site_name, L.fein, L.inc_date, self.prim_range, self.prim_name, self.sec_range, self.v_city_name, self.st, self.zip5, L.cust_name);

 self.powid	:= vLinkingIds.powid;
 self.proxid	:= vLinkingIds.proxid;
 self.seleid	:= vLinkingIds.seleid;
 self.orgid	:= vLinkingIds.orgid;
 self.ultid	:= vLinkingIds.ultid;	
 self := L;
 SELF := [];
 End;
 df_inspection	:= PROJECT(addr_clean, ClnAddr(LEFT));
 
 PromoteSupers.MAC_SF_BuildProcess(df_inspection,constants.Base_Inspection, writefile_inspection);
 
 sequential(writefile_accident,writefile_program, writefile_violations,writefile_substance,writefile_inspection);

Return 'success';
END;