import doxie, Doxie_Raw, Doxie_crs, suppress, ut, mdr, watercraft, 
       census_data, DEAV2_Services, DeathV2_Services,
			 VotersV2_services, Header, faa;

export HeaderShowSources(
    dataset(Doxie.Layout_ref_rid) rid_data,
    unsigned4 dateVal = 0,
    unsigned1 dppa_purpose = 0,
    unsigned1 glb_purpose = 0,
		SET OF STRING2 sources = ALL,
	  string32 appType,
		boolean IncludeNonRegulatedVehicleSources = false,
		boolean IncludeNonRegulatedWatercraftSources = false
) := FUNCTION

// canot use doxie.functions.GetGlobalDataAccessModule (); -- because of name conflicts
mod_access := MODULE (doxie.functions.GetGlobalDataAccessModuleTranslated (AutoStandardI.GlobalModule()))
  EXPORT unsigned1 glb := glb_purpose;
  EXPORT unsigned1 dppa := dppa_purpose;
  EXPORT string32 application_type := appType; //is it translated?
  EXPORT unsigned3 datdate_threshold := dateVal;

  // these are hardcoded for MAC_GlbClean_Header below; setting them here is a bit risky, since there's no guarantee
  // that this module will be used in other calls, where values should be taken from global module, but this doesn't happen so far.
  EXPORT boolean probation_override := FALSE;
  EXPORT string5 industry_class := '';
  EXPORT boolean no_scrub := FALSE;
END;

boolean glb_ok := mod_access.isValidGLB();
boolean dppa_ok := mod_access.isValidDPPA();

optionsMod := MODULE
  EXPORT UNSIGNED1 GLBPurpose      := mod_access.glb;
  EXPORT UNSIGNED1 DPPAPurpose     := mod_access.dppa;
  EXPORT STRING32  ApplicationType := mod_access.application_type;
  EXPORT UNSIGNED4 dateVal         := mod_access.date_threshold;
  EXPORT BOOLEAN   IncludeNonRegulatedVehicleSources    := IncludeNonRegulatedVehicleSources;
	EXPORT BOOLEAN   IncludeNonRegulatedWatercraftSources := IncludeNonRegulatedWatercraftSources;
END;

key_hdr_rid  := doxie.Key_Header_Rid(false,false);
key_qhdr_rid := doxie.Key_Header_Rid(true,false);

//Get only RIDs with correct permissions
key_data_rec := record
	unsigned6 rid;
	unsigned6 did;
	unsigned6 first_seen;
	unsigned3 dt_nonglb_last_seen;
	Header.Layout_Source_ID;
end;

key_data_rec  loadit(Doxie.Layout_ref_rid l, recordof(key_hdr_rid) r) := transform
  self.did := if(l.did > 0 ,l.did,r.did); //  138824: Search by DID has value for l.did  and Search by RID has value for r.did .  
  self := r;
	self.uid := 0;
	self.src := '';
end;

withDIDFromHeader := join(rid_data,key_hdr_rid,
                          left.rid < Header.constants.QH_start_rid and
                          keyed(left.rid=right.rid),
                          loadit(LEFT,RIGHT),
                          LIMIT(0),KEEP(1));

withDIDFromQHeader := join(rid_data,key_qhdr_rid,
                            left.rid >= Header.constants.QH_start_rid and
                            keyed(left.rid=right.rid),
                            loadit(LEFT,RIGHT),
                            LIMIT(0),KEEP(1));

withDID := withDIDFromHeader + withDIDFromQHeader;

allRIDs := dedup(withDID,all);

//Pull by RID
key_data_rec getRids(key_data_rec L, recordof(header.Key_Rid_SrcID(pCombo := false)) R) := transform
  self.rid := l.rid;
	self.did := l.did;
	self.first_seen := l.first_seen;
	self.dt_nonglb_last_seen := l.dt_nonglb_last_seen;
  self.uid := r.uid;
  self.src := r.src;
end;

srcIDFromHeader := join(withDIDFromHeader,header.Key_Rid_SrcID(false,false),
                        keyed((unsigned)left.rid=right.rid),
                        getRids(left, right))(src in sources OR 'FI' in sources);

srcIDFromQHeader := join(withDIDFromQHeader,header.Key_Rid_SrcID(true,false),
                          keyed((unsigned)left.rid=right.rid),
                          getRids(left, right))(src in sources OR 'FI' in sources);

with_rid_all := srcIDFromHeader + srcIDFromQHeader;

//filters for GLB, DPPA, headerSourceRestrictions
// with_rid_filtered := with_rid_all((glb_ok or ut.PermissionTools.glb.HeaderIsPreGLB((unsigned3)dt_nonglb_last_seen, (unsigned3)first_seen, src))
//                                    AND
//                                    (~mdr.SourceTools.SourceIsDPPA(src) OR (dppa_ok AND ut.PermissionTools.dppa.state_ok(header.translateSource(src), dppa_purpose, src)))
//                                    AND (NOT doxie.DataRestriction.isHeaderSourceRestricted(src, doxie.DataRestriction.fixed_DRM))
//                                   );
with_rid_filtered := with_rid_all((glb_ok or mod_access.isHeaderPreGLB((unsigned3)dt_nonglb_last_seen, (unsigned3)first_seen, src))
                                   AND
                                   (~mdr.SourceTools.SourceIsDPPA(src) OR (dppa_ok AND 
                                   mod_access.isValidDPPAState (header.translateSource(src), src)))
                                   AND (NOT doxie.DataRestriction.isHeaderSourceRestricted(src, doxie.DataRestriction.fixed_DRM))
                                  );

//pull records with restricted dids
Suppress.MAC_Suppress(with_rid_filtered,with_rid,mod_access.application_type,Suppress.Constants.LinkTypes.DID,did);

// Separate header rids from quick header to do the join
qhdr_rids := with_rid(rid >= Header.constants.QH_start_rid);
hdr_rids := with_rid(rid < Header.constants.QH_start_rid);

// uses maxlength of the report to match the other source doc layouts 
rid_rec := record, maxlength(doxie_crs.maxlength_report)
 unsigned6 did;
 unsigned6 rid;
 Header.Layout_HeaderSource;
end;

Airc_rid := IF('AR' IN sources,
								join(with_rid(src in sources),header.Key_Src_Airc,
                      left.src='AR' and
                      keyed(left.uid=right.uid) and keyed(left.src=right.src),
                      transform(rid_rec, self.airc_child := right.airc_child, self := left, self := []),left outer,
                      LIMIT(ut.limits.CRS_SOURCE_COUNT.DEFAULT,SKIP)),
								PROJECT(with_rid, TRANSFORM(rid_rec, SELF := LEFT, SELF := [])));


Airm_rid := IF ('AM' IN sources,
                join(airc_rid,header.Key_Src_Airm,
                      left.src='AM' and
                      keyed(left.uid=right.uid) and keyed(left.src=right.src),
                      transform(rid_rec, self.airm_child := project(right.airm_child, transform(faa.layout_airmen_data_out, self := left, self := [])), self := left),left outer,
                      LIMIT(ut.limits.CRS_SOURCE_COUNT.DEFAULT,SKIP)),
                Airc_rid);

AK_rid := IF ('AK' IN sources,
              join(Airm_rid,header.Key_Src_AK,
                    left.src='AK' and
                    keyed(left.uid=right.uid) and keyed(left.src=right.src),
                    transform(rid_rec, self.ak_child := right.ak_child, self := left),left outer,
                    LIMIT(ut.limits.CRS_SOURCE_COUNT.DEFAULT,SKIP)),
              Airm_rid);

ATF_rid := IF ('FF' IN sources OR 'FE' IN sources,
                join(AK_rid,header.Key_Src_ATF,
                left.src in ['FF','FE'] and
                keyed(left.uid=right.uid) and keyed(left.src=right.src),
                transform(rid_rec, self.atf_child := right.atf_child, self := left),left outer),
                AK_rid);

BKV2_rid := IF ('BA' IN sources,Header.Mac_QuickHdr_Source_Joins(ATF_rid,'header.Key_Src_BKV2',['BA'],optionsMod),ATF_rid);

Boater_rid := IF ('EB' IN sources,
                  join(BKV2_rid,header.Key_Src_Boater,
                        left.src='EB' and 
                        keyed(left.uid=right.uid) and keyed(left.src=right.src),
                        transform(rid_rec, self.boater_child := right.boater_child, self := left),
                        left outer,LIMIT(ut.limits.CRS_SOURCE_COUNT.DEFAULT,SKIP)),
                  BKV2_rid);

DEA_rid := IF ('DA' IN sources,
                join(Boater_rid,header.Key_Src_DEA,
                      left.src='DA' and 
                      keyed(left.uid=right.uid) and keyed(left.src=right.src),
                      transform(rid_rec, self.dea_child := right.dea_child, self := left),
                      left outer,LIMIT(ut.limits.CRS_SOURCE_COUNT.DEFAULT,SKIP)),
                Boater_rid);

DEAV2_rid := IF ('DA' IN sources,
                  join(DEA_rid,header.Key_Src_DEA,
                        left.src='DA'and
                        keyed(left.uid=right.uid) and keyed(left.src=right.src),
                        transform(rid_rec,
                                  self.dea_v2_child := Doxie_raw.DeaV2_Raw(,,PROJECT(right.dea_child,transform(Deav2_services.assorted_layouts.layout_search_IDs,self := left)),,,,mod_access.application_type),
                                  self := left),
                        left outer,LIMIT(ut.limits.CRS_SOURCE_COUNT.DEFAULT,SKIP)),
                  DEA_rid);

Death_rid := IF ('DE' IN sources,
                  join(DEAV2_rid,header.Key_Src_DEAth,
                        left.src='DE' and 
                        keyed(left.uid=right.uid) and keyed(left.src=right.src),
                        transform(rid_rec,
                                  self.death_child := doxie_raw.Death_Raw(,project(right.death_child, DeathV2_Services.layouts.death_id)),
                                  self := left),
                        left outer,LIMIT(ut.limits.CRS_SOURCE_COUNT.DEFAULT,SKIP)),
                  DEAV2_rid);

Deed_rid := IF ('FP' IN sources OR 'LP' IN sources,Header.Mac_QuickHdr_Source_Joins(Death_rid,'header.Key_Src_Deed',['FP','LP'],optionsMod),Death_rid);

// hack - I know this is the only time I'm interested in this
// Since header file has multiple source codes for dl's, we only show the vehicle sources if nothing is selected or everything is
DLV2_rid := IF (sources=ALL,Header.Mac_QuickHdr_Source_Joins(Deed_rid,'header.Key_Src_DLv2',['DL'],optionsMod),Deed_rid);

em_rid := IF ('EM' IN sources,
              join(DLV2_rid,header.Key_Src_em,
                    left.src='EM' and 
                    keyed(left.uid=right.uid) and keyed(left.src=right.src),
                    transform(rid_rec, self.emerge_child := right.emerge_child, self := left),
                    left outer,LIMIT(ut.limits.CRS_SOURCE_COUNT.DEFAULT,SKIP)),
              DLV2_rid);

// bug #104893: Removing src from keyed condition below. 'EH' records found in src keys will have 'EQ' source. 
//138824  : Adding WH to the join (to enable viewing of WH records in the source key)
// 138824 : New EQ_RID 											
eq_rid := IF ('EQ' IN sources, Header.Mac_QuickHdr_Source_Joins(em_rid,'header.Key_Src_eq',['EQ','WH'],optionsMod),em_rid);

en_rid := IF ('EN' IN sources,Header.Mac_QuickHdr_Source_Joins(eq_rid,'header.key_src_experian',['EN'],optionsMod),eq_rid);

for_rid := IF ('FR' IN sources,
                join(en_rid,header.Key_Src_for,
                      left.src='FR' and 
                      keyed(left.uid=right.uid) and keyed(left.src=right.src),
                      transform(rid_rec, self.for_child := right.for_child, self := left),
                      left outer,LIMIT(ut.limits.CRS_SOURCE_COUNT.DEFAULT,SKIP)),
                en_rid);

nod_rid := IF ('NT' IN sources,
                join(for_rid,header.Key_Src_NOD,left.src='NT' and 
                      keyed(left.uid=right.uid) and keyed(left.src=right.src),
                      transform(rid_rec, self.nod_child := right.nod_child, self := left),
                      left outer,LIMIT(ut.limits.CRS_SOURCE_COUNT.DEFAULT,SKIP)),
                for_rid);

// Liens V2 source key returns TMSIDs, which then need to be used to retrieve data to populate lien_v2_child				
lienV2_rid := IF ('L2' IN sources,Header.Mac_QuickHdr_Source_Joins(nod_rid,'header.Key_Src_Lienv2',['L2'],optionsMod),nod_rid);

lntu_rid := IF ('LT' IN sources,
                join(lienV2_rid,header.Key_Src_lntu,
                      left.src='LT' and 
                      keyed(left.uid=right.uid) and keyed(left.src=right.src),
                      transform(rid_rec, self.tu_child := right.tu_child, self := left),
                      left outer,LIMIT(ut.limits.CRS_SOURCE_COUNT.DEFAULT,SKIP)),
                lienV2_rid);

tn_rid := IF ('TN' IN sources,Header.Mac_QuickHdr_Source_Joins(lntu_rid,'header.Key_Src_Tn',['TN'],optionsMod),lntu_rid);

ms_rid := IF ('MS' IN sources,
              join(tn_rid,header.Key_Src_ms,
                    left.src='MS' and 
                    keyed(left.uid=right.uid) and keyed(left.src=right.src),
                    transform(rid_rec, self.mswork_child := right.mswork_child, self := left),
                    left outer,LIMIT(ut.limits.CRS_SOURCE_COUNT.DEFAULT,SKIP)),
              tn_rid);

prof_rid := IF ('PL' IN sources,
                join(ms_rid,header.Key_Src_prof,
                      left.src='PL' and 
                      keyed(left.uid=right.uid) and keyed(left.src=right.src),
                      transform(rid_rec, self.proflic_child := right.proflic_child, self := left),
                      left outer,LIMIT(ut.limits.CRS_SOURCE_COUNT.DEFAULT,SKIP)),
                ms_rid);

propassess_rid := IF ('FA' IN sources OR 'LA' IN sources,Header.Mac_QuickHdr_Source_Joins(prof_rid,'header.Key_Src_PropAssess',['FA','LA'],optionsMod),prof_rid);

statedeath_rid := IF ('DS' IN sources,
                      join(propassess_rid,header.Key_Src_statedeath,
                            left.src='DS' and 
                            keyed(left.uid=right.uid) and keyed(left.src=right.src),
                            transform(rid_rec, self.state_death_child := right.state_death_child, self := left),
                            left outer,LIMIT(ut.limits.CRS_SOURCE_COUNT.DEFAULT,SKIP)),
                      propassess_rid);

targ_rid := IF ('WP' IN sources,
                join(statedeath_rid,header.Key_Src_Targus,
                      left.src='WP' and 
                      keyed(left.uid=right.uid) and keyed(left.src=right.src),
                      transform(rid_rec, self.targ_child := project(right.targ_child, doxie_raw.Layout_Targus_raw), self := left),
                      left outer,LIMIT(ut.limits.CRS_SOURCE_COUNT.DEFAULT,SKIP)),
                statedeath_rid);
   
util_rid := IF ('UT' IN sources or 'ZT' IN sources,
                join(targ_rid,header.Key_Src_util,
                      mdr.Source_is_Utility(left.src) and 
                      keyed(left.uid=right.uid) and keyed(left.src=right.src),
                      transform(rid_rec, self.util_child := right.util_child, self := left),
                      left outer,LIMIT(ut.limits.CRS_SOURCE_COUNT.DEFAULT,SKIP)),
                targ_rid);

//// hack - I know this is the only time I'm interested in this
// Since header file has multiple source codes for vehicles, we only show the vehicle sources if nothing is selected or everything is
vehV2_rid := IF (sources=ALL,Header.Mac_QuickHdr_Source_Joins(util_rid,'header.Key_Src_vehV2',['VH'],optionsMod),util_rid);

votersV2_rid := IF ('VO' IN sources,
                    join(vehV2_rid,Header.key_src_voters,
                          left.src='VO' and
                          keyed(left.uid=right.uid) and keyed(left.src=right.src),
                          transform(rid_rec,
                                    self.voters_v2_child := Doxie_raw.Votersv2_Raw(,,,project(right.voters_child, transform(VotersV2_services.layout_vtid,self:=left))),
                                    self := left),
                          left outer,LIMIT(ut.limits.CRS_SOURCE_COUNT.DEFAULT,SKIP)),
                    vehV2_rid);	

watercraft.Layout_Watercraft_Full waterSSN(watercraft.Layout_Watercraft_Full L) := transform
 self.src := if(l.src!=mdr.sourceTools.src_Infutor_Watercraft,l.src,if(IncludeNonRegulatedWatercraftSources,l.src,skip));
 self.ssn := if((integer)l.orig_ssn=0,'',l.orig_ssn);
 self := l;
end;


//// hack - I know this is the only time I'm interested in this

out_rid := IF (sources=ALL,
								join(votersV2_rid,header.Key_Src_water,
                      mdr.Source_is_DPPA(left.src) and 
                      mdr.sourceTools.sourceIsWC(left.src) and 
                      keyed(left.uid=right.uid) and keyed(left.src=right.src),
                      transform(rid_rec,
                                self.watercraft_child := project(right.watercraft_child,waterssn(left)),
                                self := left),
                      left outer,LIMIT(ut.limits.CRS_SOURCE_COUNT.DEFAULT,SKIP)),
                votersV2_rid);

rid_rec getleftover(allRIDs L) := transform
 self.did := l.did;
 self.rid := (unsigned) l.rid;
 self := [];
end;

left_over := join(allRIDs,with_rid,
                  (unsigned)left.rid=right.rid,
                  getleftover(left),
                  left only);

//Pull from header
ridDID_rec := record
 key_hdr_rid.rid;
 key_hdr_rid.did;
end;

ridDid_rec getHeader(key_hdr_rid L) := transform
 self := l;
end;

hdr_rid := join(left_over,key_hdr_rid,
                left.rid < Header.constants.QH_start_rid and
                keyed(left.rid=right.rid),
                getHeader(right),
                LIMIT(0),KEEP(1));

qhdr_rid := join(left_over,key_qhdr_rid,
                left.rid >= Header.constants.QH_start_rid and
                keyed(left.rid=right.rid),
                getHeader(right),
                LIMIT(0),KEEP(1));

hdr_rid_all := hdr_rid + qhdr_rid;

doxie_raw.layout_header_raw getHeadAll(doxie.Key_Header L) := transform
 self.did := l.s_did ;  // 138824 : make sure to get the DID
 self := l;
end;

hdr_rec := join(hdr_rid_all,doxie.Key_Header,keyed(left.did=right.s_did) and left.rid=right.rid,getheadall(right),LIMIT(ut.limits.HEADER_PER_DID,SKIP));

// string5 industry_class_value := '';
// boolean probation_override_value := false;
// boolean no_scrub := false;
header.MAC_GlbClean_Header(hdr_rec,hdr_rec_cleaned, , , mod_access);
ut.MAC_Slim_Back(hdr_rec_cleaned, doxie_raw.layout_header_raw, hdr_rec_ready);

census_data.MAC_Fips2County_Keyed(hdr_rec_ready,st,county,county_name,hdr_rec_with_county_name);

rid_rec setFinder(hdr_rec_with_county_name L) := transform
 self.finder_child := L;
 self.src := 'FI';
 self.uid := l.rid;
 self.rid := l.rid;
 self.did := l.did;
 self := [];
end;

hdr_out := IF('FI' IN sources,project(hdr_rec_with_county_name,setFinder(left)));

//Decide if in RID key or DID key
from_rid := hdr_out + out_rid;

return from_rid;
END;