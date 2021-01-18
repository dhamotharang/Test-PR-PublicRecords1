/* For use in Public Records environment with Header.Append_addr_ind/thor.
Expecting dataset input of midRec, output of newRec.*/

EXPORT reduceAddressPerms (ds_in, isThor=FALSE) := FUNCTIONMACRO

IMPORT Header,Consumer_Header_Best,MDR,IDL_Header,STD,ut;

local newRec := record
  Header.Layout_addr_ind_full;
	unsigned6 rid;
	string1 isTU;
	string1 isQH;
	string2 src;
	string18 vendor_id;
	unsigned8 rawaid;
	unsigned4 global_sid;
end;

local midRec := RECORD
	newRec - permissions_ds;
	unsigned8 permissions;
END;

local inds := #IF(isThor)
          DISTRIBUTE(ds_in,hash(did));
				#ELSE
				  ds_in;
				#END
				
local perms := Consumer_Header_Best.Permissions;

local tu_srcs := MDR.SourceTools.set_Transunion + ['TS'];
local bureau_srcs := [MDR.SourceTools.set_Equifax,MDR.SourceTools.set_Transunion, MDR.SourceTools.src_Experian_Credit_Header];
local ins_srcs := IDL_Header.SourceTools.set_insurance_sources;
local prop_srcs := MDR.SourceTools.set_Property;
local utility_srcs := MDR.SourceTools.set_Utility_sources;
local veh_srcs := MDR.SourceTools.set_Vehicles;
local dl_srcs := MDR.SourceTools.set_DL;
local voter_srcs := MDR.SourceTools.src_Voters_v2;

local mindate (unsigned3 dt1, unsigned3 dt2) := MAP(dt1 = 0 => dt2, dt2 = 0 => dt1, min(dt1,dt2));

local filt_unregulated := inds(~perms.bit_test(permissions,perms.bitmap.glb1) AND
		                     ~perms.bit_test(permissions,perms.bitmap.dppa) AND
												 ~perms.bit_test(permissions,perms.bitmap.equifax) AND
												 ~perms.bit_test(permissions,perms.bitmap.experian) AND
												 ~perms.bit_test(permissions,perms.bitmap.utility) AND
												 ~perms.bit_test(permissions,perms.bitmap.insurance) AND
												 ~perms.bit_test(permissions,perms.bitmap.src_probation) AND
												 ~perms.bit_test(permissions,perms.bitmap.dmv_restricted) AND
												 ~perms.bit_test(permissions,perms.bitmap.ccpa) AND
												 ~perms.bit_test(permissions,perms.bitmap.marketing) AND
												 ~perms.bit_test(permissions,perms.bitmap.d2c) AND
												 ~perms.bit_test(permissions,perms.bitmap.resellers));
												 
/*----------------------First reduction-----------------------------------------------*/
/* 1. Completely unregulated record providing address, so address needs no permissions*/
/*------------------------------------------------------------------------------------*/
local ded_addr_unregulated := ROLLUP(SORT(filt_unregulated,did,prim_range,predir,prim_name,addr_suffix,postdir,sec_range,city,st,zip,src
                          #IF(isThor) ,local), #ELSE ), #END
                          TRANSFORM(recordof(left),
															self.dt_first_seen  := mindate(left.dt_first_seen,right.dt_first_seen),
										          self.dt_first_seen_pr  := mindate(left.dt_first_seen_pr,right.dt_first_seen_pr),
															self.dt_last_seen   := max(left.dt_last_seen,right.dt_last_seen),
															self.dt_last_seen_pr   := max(left.dt_last_seen_pr,right.dt_last_seen_pr),
															self.dt_vendor_first_reported  := mindate(left.dt_vendor_first_reported,right.dt_vendor_first_reported),
															self.dt_vendor_first_reported_pr  := mindate(left.dt_vendor_first_reported_pr,right.dt_vendor_first_reported_pr),
															self.dt_vendor_last_reported   := max(left.dt_vendor_last_reported,right.dt_vendor_last_reported),
															self.dt_vendor_last_reported_pr   := max(left.dt_vendor_last_reported_pr,right.dt_vendor_last_reported_pr),
															self.src_cnt        := if(left.src<>right.src,left.src_cnt + right.src_cnt,left.src_cnt),
															self.insurance_src_cnt := if(left.src<>right.src AND right.src IN ins_srcs,left.insurance_src_cnt + right.insurance_src_cnt,left.insurance_src_cnt),
															self.bureau_src_cnt := if(left.src<>right.src AND right.src IN bureau_srcs,left.bureau_src_cnt + right.bureau_src_cnt,left.bureau_src_cnt),
															self.property_src_cnt := if(left.src<>right.src AND right.src IN prop_srcs,left.property_src_cnt + right.property_src_cnt,left.property_src_cnt),
															self.utility_src_cnt := if(left.src<>right.src AND right.src IN utility_srcs,left.utility_src_cnt + right.utility_src_cnt,left.utility_src_cnt),
															self.vehicle_src_cnt := if(left.src<>right.src AND right.src IN veh_srcs,left.vehicle_src_cnt + right.vehicle_src_cnt,left.vehicle_src_cnt),
															self.dl_src_cnt := if(left.src<>right.src AND right.src IN dl_srcs,left.dl_src_cnt + right.dl_src_cnt,left.dl_src_cnt),
															self.voter_src_cnt := if(left.src<>right.src AND right.src = voter_srcs,left.voter_src_cnt + right.voter_src_cnt,left.voter_src_cnt),
															self.src_cnt_total := if(left.src<>right.src,left.src_cnt_total + right.src_cnt_total,left.src_cnt_total),
															self.insurance_src_cnt_total := if(left.src<>right.src AND right.src IN ins_srcs,left.insurance_src_cnt_total + right.insurance_src_cnt_total,left.insurance_src_cnt_total),
															self.bureau_src_cnt_total := if(left.src<>right.src AND right.src IN bureau_srcs,left.bureau_src_cnt_total + right.bureau_src_cnt_total,left.bureau_src_cnt_total),
															self.property_src_cnt_total := if(left.src<>right.src AND right.src IN prop_srcs,left.property_src_cnt_total + right.property_src_cnt_total,left.property_src_cnt_total),
															self.utility_src_cnt_total := if(left.src<>right.src AND right.src IN utility_srcs,left.utility_src_cnt_total + right.utility_src_cnt_total,left.utility_src_cnt_total),
															self.vehicle_src_cnt_total := if(left.src<>right.src AND right.src IN veh_srcs,left.vehicle_src_cnt_total + right.vehicle_src_cnt_total,left.vehicle_src_cnt_total),
															self.dl_src_cnt_total := if(left.src<>right.src AND right.src IN dl_srcs,left.dl_src_cnt_total + right.dl_src_cnt_total,left.dl_src_cnt_total),
															self.voter_src_cnt_total := if(left.src<>right.src AND right.src = voter_srcs,left.voter_src_cnt_total + right.voter_src_cnt_total,left.voter_src_cnt_total),
															self.permissions := perms.permissions_roll(left.permissions,right.permissions),
															self:=left),did,prim_range,predir,prim_name,addr_suffix,postdir,sec_range,city,st,zip
															#IF(isThor) ,local); #ELSE ); #END

local j_addr_regulated := JOIN(inds,ded_addr_unregulated,left.did=right.did AND 
																								 left.prim_range=right.prim_range AND
																								 left.predir=right.predir AND
																								 left.prim_name=right.prim_name AND
																								 left.addr_suffix=right.addr_suffix AND
																								 left.postdir=right.postdir AND
																								 left.sec_range=right.sec_range AND
																								 left.city=right.city AND
																								 left.st=right.st AND
																								 left.zip=right.zip,
																								 TRANSFORM(LEFT),left only
																								 #IF(isThor) ,local); #ELSE ); #END
																								 
local ded_addr_regulated0 := ROLLUP(SORT(j_addr_regulated,did,prim_range,predir,prim_name,addr_suffix,postdir,sec_range,city,st,zip,src
                        #IF(isThor) ,local), #ELSE ), #END
												TRANSFORM(recordof(left),
														self.dt_first_seen  := mindate(left.dt_first_seen,right.dt_first_seen),
										        self.dt_first_seen_pr  := mindate(left.dt_first_seen_pr,right.dt_first_seen_pr),
														self.dt_last_seen   := max(left.dt_last_seen,right.dt_last_seen),
														self.dt_last_seen_pr   := max(left.dt_last_seen_pr,right.dt_last_seen_pr),
														self.dt_vendor_first_reported  := mindate(left.dt_vendor_first_reported,right.dt_vendor_first_reported),
														self.dt_vendor_first_reported_pr  := mindate(left.dt_vendor_first_reported_pr,right.dt_vendor_first_reported_pr),
														self.dt_vendor_last_reported   := max(left.dt_vendor_last_reported,right.dt_vendor_last_reported),
														self.dt_vendor_last_reported_pr   := max(left.dt_vendor_last_reported_pr,right.dt_vendor_last_reported_pr),
														self.src_cnt        := if(left.src<>right.src,left.src_cnt + right.src_cnt,left.src_cnt),
														self.insurance_src_cnt := if(left.src<>right.src AND right.src IN ins_srcs,left.insurance_src_cnt + right.insurance_src_cnt,left.insurance_src_cnt),
														self.bureau_src_cnt := if(left.src<>right.src AND right.src IN bureau_srcs,left.bureau_src_cnt + right.bureau_src_cnt,left.bureau_src_cnt),
														self.property_src_cnt := if(left.src<>right.src AND right.src IN prop_srcs,left.property_src_cnt + right.property_src_cnt,left.property_src_cnt),
														self.utility_src_cnt := if(left.src<>right.src AND right.src IN utility_srcs,left.utility_src_cnt + right.utility_src_cnt,left.utility_src_cnt),
														self.vehicle_src_cnt := if(left.src<>right.src AND right.src IN veh_srcs,left.vehicle_src_cnt + right.vehicle_src_cnt,left.vehicle_src_cnt),
														self.dl_src_cnt := if(left.src<>right.src AND right.src IN dl_srcs,left.dl_src_cnt + right.dl_src_cnt,left.dl_src_cnt),
														self.voter_src_cnt := if(left.src<>right.src AND right.src = voter_srcs,left.voter_src_cnt + right.voter_src_cnt,left.voter_src_cnt),
														self.src_cnt_total := if(left.src<>right.src,left.src_cnt_total + right.src_cnt_total,left.src_cnt_total),
														self.insurance_src_cnt_total := if(left.src<>right.src AND right.src IN ins_srcs,left.insurance_src_cnt_total + right.insurance_src_cnt_total,left.insurance_src_cnt_total),
														self.bureau_src_cnt_total := if(left.src<>right.src AND right.src IN bureau_srcs,left.bureau_src_cnt_total + right.bureau_src_cnt_total,left.bureau_src_cnt_total),
														self.property_src_cnt_total := if(left.src<>right.src AND right.src IN prop_srcs,left.property_src_cnt_total + right.property_src_cnt_total,left.property_src_cnt_total),
														self.utility_src_cnt_total := if(left.src<>right.src AND right.src IN utility_srcs,left.utility_src_cnt_total + right.utility_src_cnt_total,left.utility_src_cnt_total),
														self.vehicle_src_cnt_total := if(left.src<>right.src AND right.src IN veh_srcs,left.vehicle_src_cnt_total + right.vehicle_src_cnt_total,left.vehicle_src_cnt_total),
														self.dl_src_cnt_total := if(left.src<>right.src AND right.src IN dl_srcs,left.dl_src_cnt_total + right.dl_src_cnt_total,left.dl_src_cnt_total),
														self.voter_src_cnt_total := if(left.src<>right.src AND right.src = voter_srcs,left.voter_src_cnt_total + right.voter_src_cnt_total,left.voter_src_cnt_total),
														self:=left),did,prim_range,predir,prim_name,addr_suffix,postdir,sec_range,city,st,zip #IF(isThor) ,local); #ELSE ); #END
														
ded_addr_regulated_perms := DEDUP(SORT(j_addr_regulated,did,prim_range,predir,prim_name,addr_suffix,postdir,sec_range,city,st,zip,src,permissions
                            #IF(isThor) ,local), #ELSE ), #END did,prim_range,predir,prim_name,addr_suffix,postdir,sec_range,city,st,zip,permissions
														#IF(isThor) ,local); #ELSE ); #END

local ded_addr_regulated := JOIN(ded_addr_regulated_perms,ded_addr_regulated0,left.did=right.did AND left.prim_range=right.prim_range AND left.predir=right.predir AND left.prim_name=right.prim_name AND left.addr_suffix=right.addr_suffix AND left.postdir=right.postdir AND left.sec_range=right.sec_range AND left.city=right.city AND left.st=right.st AND left.zip=right.zip,TRANSFORM(recordof(right),self.permissions:=left.permissions,self:=right) #IF(isThor) ,local); #ELSE ); #END
																							
local tab_addr_regulated := TABLE(ded_addr_regulated,{ded_addr_regulated.did,ded_addr_regulated.prim_range,ded_addr_regulated.predir,ded_addr_regulated.prim_name,ded_addr_regulated.addr_suffix,ded_addr_regulated.postdir,ded_addr_regulated.sec_range,ded_addr_regulated.city,ded_addr_regulated.st,ded_addr_regulated.zip,cnt:=COUNT(GROUP)},did,prim_range,predir,prim_name,addr_suffix,postdir,sec_range,city,st,zip #IF(isThor) ,local); #ELSE ); #END

local single_perm := tab_addr_regulated(cnt = 1);

/*----------------------Second reduction-----------------------*/
/* 2. Only a single permission required, no reduction necessary*/
/*-------------------------------------------------------------*/
local j_single_perm := JOIN(ded_addr_regulated,single_perm,left.did=right.did AND 
																								 left.prim_range=right.prim_range AND
																								 left.predir=right.predir AND
																								 left.prim_name=right.prim_name AND
																								 left.addr_suffix=right.addr_suffix AND
																								 left.postdir=right.postdir AND
																								 left.sec_range=right.sec_range AND
																								 left.city=right.city AND
																								 left.st=right.st AND
																								 left.zip=right.zip,TRANSFORM(LEFT)
																								 #IF(isThor) ,local); #ELSE ); #END

local multi_perm := tab_addr_regulated(cnt > 1);

local permCompRec := RECORD
	unsigned8 permissions_baseline;
	unsigned2 ranking;
	newRec - permissions_ds;
END;

local multi_perm_full := JOIN(ded_addr_regulated,multi_perm,left.did=right.did AND 
																								 left.prim_range=right.prim_range AND
																								 left.predir=right.predir AND
																								 left.prim_name=right.prim_name AND
																								 left.addr_suffix=right.addr_suffix AND
																								 left.postdir=right.postdir AND
																								 left.sec_range=right.sec_range AND
																								 left.city=right.city AND
																								 left.st=right.st AND
																								 left.zip=right.zip,
																						TRANSFORM(permCompRec,self.permissions_baseline:=left.permissions,
																								 self.ranking:=1,self:=left)
																								 #IF(isThor) ,local); #ELSE ); #END

local multi_perm_ranked := ITERATE(SORT(multi_perm_full,did,prim_range,predir,prim_name,addr_suffix,postdir,sec_range,city,st,zip,-STD.str.reverse(ut.IntegerToBinaryString(permissions_baseline))
                     #IF(isThor) ,local), #ELSE ), #END TRANSFORM(permCompRec,self.ranking:=IF(left.ranking=0 OR left.did<>right.did OR left.prim_range<>right.prim_range OR left.predir<>right.predir OR left.prim_name<>right.prim_name OR left.addr_suffix<>right.addr_suffix OR left.postdir<>right.postdir OR left.sec_range <> right.sec_range OR left.city<>right.city OR left.st<>right.st OR left.zip<>right.zip,1,left.ranking+1),
										 self:=right) #IF(isThor) ,local); #ELSE ); #END

local permResolvedRec := RECORD
	unsigned8 permissions_baseline;
	unsigned2 ranking;
	unsigned2 ranking2;
	unsigned8 permissions_reworked;
	set of unsigned2 ranks_rolled;
	unsigned8 permissions_resolved;
	newRec - permissions_ds;
END;

local permResolvedRec permJoin(permCompRec L, permCompRec R) := TRANSFORM
	permissions := IF(R.permissions_baseline > 0,perms.permissions_roll(L.permissions_baseline,R.permissions_baseline),L.permissions_baseline);
	SELF.permissions_reworked := permissions;
	SELF.ranking := L.ranking;
	SELF.ranking2 := R.ranking;
	SELF.ranks_rolled := [L.ranking,R.ranking];
	SELF.permissions_resolved := permissions;
	SELF := L;
END;

local permResolvedRec permRoll(permResolvedRec L, permResolvedRec R) := TRANSFORM
	permissions := perms.permissions_roll(L.permissions_reworked,R.permissions_reworked);
	SELF.permissions_resolved := permissions;
	SELF.ranking := L.ranking;
	SELF.ranking2 := L.ranking2;
	SELF.ranks_rolled := L.ranks_rolled + R.ranks_rolled;
	SELF := L;
END;

local perm_combos_reworked := JOIN(multi_perm_ranked,multi_perm_ranked,
															left.did=right.did AND left.prim_range=right.prim_range AND
															left.predir=right.predir AND left.prim_name=right.prim_name AND
															left.addr_suffix=right.addr_suffix AND left.postdir=right.postdir AND
															left.sec_range=right.sec_range AND left.city=right.city AND
															left.st=right.st AND left.zip=right.zip AND left.ranking < right.ranking AND 
															perms.permissions_compare(left.permissions_baseline,right.permissions_baseline),
															permJoin(LEFT,RIGHT),left outer #IF(isThor) ,local); #ELSE ); #END

local perm_combos_reduced := ROLLUP(SORT(perm_combos_reworked,did,prim_range,predir,prim_name,addr_suffix,postdir,sec_range,city,st,zip,ranking,ranking2
                       #IF(isThor) ,local), #ELSE ), #END permRoll(LEFT,RIGHT),did,prim_range,predir,prim_name,addr_suffix,postdir,sec_range,city,st,zip,ranking #IF(isThor) ,local); #ELSE ); #END

local perms_combos_resolved := ROLLUP(SORT(perm_combos_reduced,did,prim_range,predir,prim_name,addr_suffix,postdir,sec_range,city,st,zip,-MAX(ranks_rolled),ranking
                         #IF(isThor) ,local), #ELSE ), #END permRoll(LEFT,RIGHT),left.did=right.did AND left.prim_range=right.prim_range AND left.predir=right.predir AND left.prim_name=right.prim_name AND left.addr_suffix=right.addr_suffix AND left.postdir=right.postdir AND left.sec_range=right.sec_range AND left.city=right.city AND left.st=right.st AND left.zip=right.zip AND left.ranking2 > 0 AND right.ranking IN left.ranks_rolled #IF(isThor) ,local); #ELSE ); #END

local ded_addr_regulated_final := DEDUP(SORT(JOIN(ded_addr_regulated,multi_perm,
															left.did=right.did AND left.prim_range=right.prim_range AND
															left.predir=right.predir AND left.prim_name=right.prim_name AND
															left.addr_suffix=right.addr_suffix AND left.postdir=right.postdir AND
															left.sec_range=right.sec_range AND left.city=right.city AND
															left.st=right.st AND left.zip=right.zip,TRANSFORM(LEFT)
															#IF(isThor) ,local), #ELSE ), #END
														did,prim_range,predir,prim_name,addr_suffix,postdir,sec_range,city,st,zip #IF(isThor) ,local), #ELSE ), #END
														did,prim_range,predir,prim_name,addr_suffix,postdir,sec_range,city,st,zip #IF(isThor) ,local); #ELSE ); #END

local prep_resolved := PROJECT(ded_addr_regulated_final,TRANSFORM(newRec,self:=left,self:=[]) #IF(isThor) ,local); #ELSE ); #END

local newRec permDeNorm(newRec L, DATASET(permResolvedRec) R) := TRANSFORM
	self.permissions_ds := SORT(PROJECT(R,TRANSFORM({unsigned8 permissions},
																			self.permissions:=LEFT.permissions_resolved)),permissions);
	SELF := L;
END;

/*----------------------Third reduction---------------------------*/
/* 3. Remaining addresses have permissions reduced as much as possible*/
/*----------------------------------------------------------------*/
local multi_perm_resolved_final := DENORMALIZE(prep_resolved,perms_combos_resolved,left.did=right.did AND left.prim_range=right.prim_range AND left.predir=right.predir AND left.prim_name=right.prim_name AND left.addr_suffix=right.addr_suffix AND left.postdir=right.postdir AND left.sec_range=right.sec_range AND left.city=right.city AND left.st=right.st AND left.zip=right.zip,GROUP,permDeNorm(LEFT,ROWS(RIGHT)) #IF(isThor) ,local); #ELSE ); #END

/*All addresses fit into category 1, 2, or 3 and are recombined here*/
local final_out := PROJECT(ded_addr_unregulated,TRANSFORM(newRec,SELF.permissions_ds := DATASET([{left.permissions}],{unsigned8 permissions}),self:=left) #IF(isThor) ,local) #ELSE ) #END + 
             PROJECT(j_single_perm,TRANSFORM(newRec,SELF.permissions_ds := DATASET([{left.permissions}],{unsigned8 permissions}),self:=left) #IF(isThor) ,local) #ELSE ) #END + multi_perm_resolved_final;

RETURN final_out;
												 
ENDMACRO;