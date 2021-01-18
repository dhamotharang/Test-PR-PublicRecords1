/*For use in Public Records environment, expecting 
string2 src, string18 vendor_id, unsigned3 dt_first_seen, unsigned6 rid, string2 st.
Permissions is an unsigned8 value that will be overwritten by this macro.*/

EXPORT addAddressPerms(inds,src,vendor_id,dt_first_seen,rid,st,global_sid,permissions,isThor=FALSE,data_env) := FUNCTIONMACRO

IMPORT MDR,Codes,Consumer_Header_Best,dx_header,suppress;

local perms :=  Consumer_Header_Best.Permissions.bitmap;
							
//GLB - set for all
local glb (string2 src) :=  src in mdr.sourcetools.set_GLB;

//PREGLB - no nonglb_last_seen_dt, use first_seen_dt
local dateEffective := 200106;
  
local dateOK (unsigned3 first_seen) := first_seen <= dateEffective and first_seen > 0;	 
	 
local HeaderIsPreGLB (string2 src, unsigned3 first_seen) :=
       MAP (src IN mdr.sourcetools.set_AlwaysGLB => FALSE,
            src NOT IN mdr.sourcetools.set_GLB => TRUE,
            dateOK (first_seen));
   
local preglb (string2 src, unsigned3 dt_first_seen) := HeaderIsPreGLB(src,dt_first_seen);

//EQ /EN /TU /UTIL
local equifax (string2 src) := MDR.sourceTools.SourceIsEquifax(src);
local experian (string2 src) := MDR.sourceTools.SourceIsExperian_Credit_Header(src);
local transunion (string2 src) := MDR.sourceTools.SourceIsTransUnion_Credit_Header(src);
local utility (string2 src) := MDR.sourceTools.SourceIsUtility(src);

//No infutor or insurance data at this time
local infutor(string2 src) := FALSE;
local ins(string2 src) := FALSE;

local other_src (string2 src) := ~(equifax(src) OR experian(src) OR transunion(src) OR utility(src) OR infutor(src) OR ins(src));

//DPPA
local dppa (string2 src) := src IN MDR.sourceTools.set_DPPA_sources;

//D2C / RESELLERS - for our purposes - non-glb and non-dppa
local d2C(string2 src) := src NOT IN [MDR.sourceTools.set_DPPA_sources,mdr.sourcetools.set_GLB];
local resellers(string2 src) := src NOT IN [MDR.sourceTools.set_DPPA_sources,mdr.sourcetools.set_GLB];


local unsigned src2bmap(string2 src, unsigned3 dt_first_seen, boolean existsDPPA1, boolean existsDPPA2, boolean existsDPPA3, boolean existsDPPA4, boolean existsDPPA5, boolean existsDPPA6, boolean existsDPPA7, boolean existsDMVRestricted, boolean existsProbation, boolean existsMarketing, boolean existsCCPA) :=
								IF(glb(src), perms.glb1, 0)
						| 	IF(glb(src), perms.glb2, 0)
						| 	IF(glb(src), perms.glb3, 0)
						| 	IF(glb(src), perms.glb4, 0)
						| 	IF(glb(src), perms.glb5, 0)
						| 	IF(glb(src), perms.glb6, 0)
						| 	IF(glb(src), perms.glb7, 0)
						| 	IF(glb(src), perms.glb10, 0)
						| 	IF(glb(src), perms.glb11, 0)
						|		IF(preglb(src,dt_first_seen), perms.preglb, 0)
						|		IF(dppa(src), perms.dppa, 0)
						|		IF(dppa(src) AND existsDPPA1, perms.dppa1, 0)
						|		IF(dppa(src) AND existsDPPA2, perms.dppa2, 0)
						|		IF(dppa(src) AND existsDPPA3, perms.dppa3, 0)
						|		IF(dppa(src) AND existsDPPA4, perms.dppa4, 0)
						|		IF(dppa(src) AND existsDPPA5, perms.dppa5, 0)
						|		IF(dppa(src) AND existsDPPA6, perms.dppa6, 0)
						|		IF(dppa(src) AND existsDPPA7, perms.dppa7, 0)
						|		IF(equifax(src), perms.equifax, 0)
						|		IF(experian(src), perms.experian, 0)
						|		IF(utility(src), perms.utility, 0)
						|   IF(transunion(src), perms.transunion, 0)
						|   IF(other_src(src), perms.other_src, 0)
						|   IF(infutor(src), perms.infutor, 0)
						|   IF(ins(src), perms.insurance, 0)
						|		IF(existsProbation, perms.src_probation, 0)
						|		IF(existsDMVRestricted, perms.dmv_restricted, 0)
						|		IF(existsCCPA, perms.ccpa, 0)
						|		IF(~existsMarketing, perms.marketing, 0)
						|		IF(~d2c(src), perms.d2c, 0)
						|		IF(~resellers(src), perms.resellers, 0);

local ds_in := inds;
local inRec := RECORDOF(ds_in);

local no_st := ds_in(st = '');
local has_st := ds_in(st <> '');

local dppaRec := RECORD
	 inRec;
	 string strfn;
	 boolean existsDPPA1; 
	 boolean existsDPPA2; 
	 boolean existsDPPA3; 
	 boolean existsDPPA4; 
	 boolean existsDPPA5; 
	 boolean existsDPPA6; 
	 boolean existsDPPA7;
END;

local p_dppa := PROJECT(has_st,TRANSFORM(dppaRec,isExperian := (MDR.sourceTools.SourceIsExperianVehicle(left.src) OR MDR.sourceTools.SourceIsExperianVehicle(left.src) OR MDR.sourceTools.SourceIsExperianDL(left.src)); self.strfn := IF (isExperian, 'EXPERIAN-DL-PURPOSE', 'DL-PURPOSE');self:=left,self:=[]));

local j_codes_dppa := #IF(isThor)
												JOIN(p_dppa,codes.key_codes_v3,right.file_name = 'GENERAL' and right.field_name=left.strfn and right.field_name2 = left.st,
											#ELSE
												JOIN(p_dppa,codes.key_codes_v3,KEYED(right.file_name = 'GENERAL') and KEYED(right.field_name=left.strfn) and KEYED(right.field_name2 = left.st),
											#END
											TRANSFORM(dppaRec,self.existsDPPA1 := IF(right.code = '1',TRUE,FALSE);self.existsDPPA2 := IF(right.code = '2',TRUE,FALSE);self.existsDPPA3 := IF(right.code = '3',TRUE,FALSE);self.existsDPPA4 := IF(right.code = '4',TRUE,FALSE);self.existsDPPA5 := IF(right.code = '5',TRUE,FALSE);self.existsDPPA6 := IF(right.code = '6',TRUE,FALSE);self.existsDPPA7 := IF(right.code = '7',TRUE,FALSE);self:=left),
											#IF (isThor)
											many lookup,left outer);
											#ELSE
											left outer);
											#END

local roll_dppa := ROLLUP(SORT(
										#IF (isThor)
											DISTRIBUTE(j_codes_dppa,rid),rid,local),
										#ELSE
											j_codes_dppa,rid),
										#END
										TRANSFORM(dppaRec,self.existsDPPA1 := left.existsDPPA1 OR right.existsDPPA1,self.existsDPPA2 := left.existsDPPA2 OR right.existsDPPA2,self.existsDPPA3 := left.existsDPPA3 OR right.existsDPPA3,self.existsDPPA4 := left.existsDPPA4 OR right.existsDPPA4,self.existsDPPA5 := left.existsDPPA5 OR right.existsDPPA5,self.existsDPPA6 := left.existsDPPA6 OR right.existsDPPA6,self.existsDPPA7 := left.existsDPPA7 OR right.existsDPPA7,self:=left),rid
								#IF(isThor)
									,local)
								#ELSE
									)
								#END 
								+ PROJECT(no_st,TRANSFORM(dppaRec,self:=left,self:=[]));

local codesRec := RECORD
	dppaRec;
	string2 code;
	boolean existsProbation;
	boolean existsMarketing;
END;

local p_code := PROJECT(roll_dppa,TRANSFORM(codesRec,
                                        self.code := IF(left.src IN MDR.sourceTools.set_Liens,left.vendor_id[..2], left.src),
																				self := left, self:= []));

local j_codes_other := JOIN(p_code,codes.key_codes_v3,
														#IF (isThor)
															left.code = right.code,
														#ELSE
															KEYED(left.code = right.code) AND
															WILD(right.file_name) AND WILD(right.field_name) AND WILD(right.field_name2),
														#END
															TRANSFORM(codesRec,
																self.existsProbation := right.file_name = 'HEADER_MASTER_V5' AND right.field_name = 'PROBATION' AND 
																	right.field_name2 = '' AND right.long_desc <> '' AND left.src NOT IN MDR.sourceTools.set_Liens,
																existsMarketing_vendor := right.file_name = 'VENDOR_SOURCES' AND right.field_name = 'DIRECTMARKETING' AND 
																	right.field_name2 = 'SCODE' AND left.src NOT IN MDR.sourceTools.set_Liens AND
																	NOT (left.src = MDR.sourceTools.src_LnPropV2_Lexis_Asrs AND left.st IN ['ID','IL','KS','NM','SC','WA', '']) AND 
																	NOT (left.src = MDR.sourceTools.src_LnPropV2_Lexis_Deeds_Mtgs AND left.st IN ['ID','IL','KS','NM','SC','WA', '']);
																existsMarketing_lien := right.file_name = 'LIEN_SOURCES' AND right.field_name = 'DIRECTMARKETING' AND    
																	right.field_name2 = 'TMSID' AND left.src IN MDR.sourceTools.set_Liens;
																existsMarketing_vehwc := right.file_name IN ['VEHICLE_SOURCES','WATERCRAFT_SOURCES'] AND 
																	right.field_name = 'DIRECTMARKETING' AND  right.field_name2 = 'SCODE' AND
																	left.src NOT IN MDR.sourceTools.set_Liens;
																self.existsMarketing := existsMarketing_vendor OR existsMarketing_lien OR existsMarketing_vehwc;
																self:=left),
														#IF (isThor)
															many lookup,left outer);
														#ELSE
															left outer);
														#END

local roll_codes := ROLLUP(SORT(
								#IF (isThor)
									DISTRIBUTE(j_codes_other,rid),rid,local),
								#ELSE
									j_codes_other,rid),
								#END
								TRANSFORM(codesRec,self.existsProbation := left.existsProbation OR right.existsProbation,self.existsMarketing := left.existsMarketing OR right.existsMarketing,self:=left),rid
								#IF(isThor)
									,local);
								#ELSE
									);
								#END 
								
local dmvRec := RECORD
	codesRec;
	boolean existsDMVRestricted;
END;

local j_dmv_restricted := JOIN(roll_codes,dx_header.key_DMV_restricted(),
									#IF (isThor)
										left.rid=right.rid,
									#ELSE
										KEYED(left.rid=right.rid),
									#END
										TRANSFORM(dmvRec,self.existsDMVRestricted := IF(right.exclusiveDMVSourced,TRUE,FALSE),self:=left),
									#IF (isThor)
										many lookup,left outer);
									#ELSE
										left outer);
									#END

local ccpaRec := RECORD
	dmvRec;
	boolean existsCCPA;
END;

local j_ccpa := JOIN(j_dmv_restricted,suppress.key_OptOutSrc(data_env),
					#IF (isThor)
						(unsigned6)left.did=right.lexid,
					#ELSE
						KEYED((unsigned6)left.did=right.lexid),
					#END
					TRANSFORM(ccpaRec,self.existsCCPA:=IF(left.global_sid IN right.global_sids,TRUE,FALSE),self:=left),
					#IF (isThor)
						many lookup,left outer);
					#ELSE
						left outer);
					#END

local ded_ccpa := DEDUP(SORT(
					#IF (isThor)
						DISTRIBUTE(j_ccpa,rid),rid,-existsCCPA,local),rid,local);
					#ELSE
						j_ccpa,rid,-existsCCPA),rid);
					#END

local perms_added := PROJECT(ded_ccpa,TRANSFORM(inRec, self.permissions := src2bmap(left.src, left.dt_first_seen, left.existsDPPA1,left.existsDPPA2,left.existsDPPA3,left.existsDPPA4,left.existsDPPA5,left.existsDPPA6,left.existsDPPA7,left.existsDMVRestricted,left.existsProbation,left.existsMarketing,left.existsCCPA),self:= left));

RETURN perms_added;

ENDMACRO;