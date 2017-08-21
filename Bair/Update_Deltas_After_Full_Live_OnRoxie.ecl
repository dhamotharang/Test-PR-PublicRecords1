import std;
/*
Following function is called when a DELTA build is scheduled after a FULL package is deployed in ROXIE.
*/

EXPORT Update_Deltas_After_Full_Live_OnRoxie(string pversion, boolean pUseProd = false) := function

	version 				 			:= pversion + '_T';
	pDelta 			 					:= true;	
	delta_files_modname 	:= Bair.Files('', pUseProd, pDelta);
	int_files_modname 		:= Bair.Files_Intermediary(pUseProd);
	promote_modname				:= Bair.Promote(version, pUseProd, pDelta, true, '', false);
	promote_modname_w_del	:= Bair.Promote(version, pUseProd, pDelta, true, '', true);
	
	cfs_d 		:= delta_files_modname.cfs_Base.built;
	mo_d  		:= delta_files_modname.mo_Base.built; 
	mo_udf_d  := delta_files_modname.mo_udf_Base.built; 
	per_d 		:= delta_files_modname.persons_Base.built; 
	per_udf_d := delta_files_modname.persons_udf_Base.built; 
	veh_d 		:= delta_files_modname.vehicle_Base.built; 
	cra_d 		:= delta_files_modname.crash_Base.built; 
	off_d 		:= delta_files_modname.offenders_Base.built; 
	off_pic_d := delta_files_modname.offenders_picture_Base.built; 
	int_d 		:= delta_files_modname.intel_Base.built; 
	lpr_d 		:= delta_files_modname.lpr_Base.built; 
	shot_d 		:= delta_files_modname.shotspotter_Base.built;
	
	agency_deletes := bair.files().AgencyDeletes_base.built;

	cfs 		:= join(DISTRIBUTED(cfs_d, hash(eid)), DISTRIBUTED(int_files_modname.cfs_d, hash(eid)), left.eid = right.eid, transform({cfs_d}, self.ts := if(left.ts = right.ts, skip, left.ts); self := left), keep(1), left outer, local);
	mo  		:= join(DISTRIBUTED(mo_d, hash(eid)), DISTRIBUTED(int_files_modname.mo_d, hash(eid)), left.eid = right.eid, transform({mo_d}, self.ts := if(left.ts = right.ts, skip, left.ts); self := left), keep(1), left outer, local);
	mo_udf 	:= join(DISTRIBUTED(mo_udf_d, hash(eid)), DISTRIBUTED(int_files_modname.mo_udf_d, hash(eid)), left.eid = right.eid, transform({mo_udf_d}, self.ts := if(left.ts = right.ts, skip, left.ts); self := left), keep(1), left outer, local);
	//persons dataset has uneven distribution, so we are using random distribution.
	per 		:= join(distribute(per_d, random()), table(int_files_modname.per_d, {eid,ts}, eid,ts, few, merge), left.eid = right.eid, transform({per_d}, self.ts := if(left.ts = right.ts, skip, left.ts); self := left), left outer, lookup);
	per_udf := join(DISTRIBUTED(per_udf_d, hash(eid)), DISTRIBUTED(int_files_modname.per_udf_d, hash(eid)), left.eid = right.eid, transform({per_udf_d}, self.ts := if(left.ts = right.ts, skip, left.ts); self := left), keep(1), left outer, local);
	veh 		:= join(DISTRIBUTED(veh_d, hash(eid)), DISTRIBUTED(int_files_modname.veh_d, hash(eid)), left.eid = right.eid, transform({veh_d}, self.ts := if(left.ts = right.ts, skip, left.ts); self := left), keep(1), left outer, local);
	cra 		:= join(DISTRIBUTED(cra_d, hash(eid)), DISTRIBUTED(int_files_modname.cra_d, hash(eid)), left.eid = right.eid, transform({cra_d}, self.ts := if(left.ts = right.ts, skip, left.ts); self := left), keep(1), left outer, local);
	off 		:= join(DISTRIBUTED(off_d, hash(eid)), DISTRIBUTED(int_files_modname.off_d, hash(eid)), left.eid = right.eid, transform({off_d}, self.ts := if(left.ts = right.ts, skip, left.ts); self := left), keep(1), left outer, local);
	off_pic	:= join(DISTRIBUTED(off_pic_d, hash(eid)), DISTRIBUTED(int_files_modname.off_pic_d, hash(eid)), left.eid = right.eid, transform({off_pic_d}, self.ts := if(left.ts = right.ts, skip, left.ts); self := left), keep(1), left outer, local);
	int 		:= join(DISTRIBUTED(int_d, hash(eid)), DISTRIBUTED(int_files_modname.int_d, hash(eid)), left.eid = right.eid, transform({int_d}, self.ts := if(left.ts = right.ts, skip, left.ts); self := left), keep(1), left outer, local);
	lpr 		:= join(DISTRIBUTED(lpr_d, hash(eid)), DISTRIBUTED(int_files_modname.lpr_d, hash(eid)), left.eid = right.eid, transform({lpr_d}, self.ts := if(left.ts = right.ts, skip, left.ts); self := left), keep(1), left outer, local);
	shot 		:= join(DISTRIBUTED(shot_d, hash(eid)), DISTRIBUTED(int_files_modname.shot_d, hash(eid)), left.eid = right.eid, transform({shot_d}, self.ts := if(left.ts = right.ts, skip, left.ts); self := left), keep(1), left outer, local);
	deletes := join(agency_deletes, int_files_modname.deletes_d, left.eid = right.eid, transform({agency_deletes}, self.ts := if(left.ts = right.ts, skip, left.ts); self := left), keep(1), left outer);
	
	del_inter_has_owner_delete := nothor(bair.util().dintermediate_super_owners(regexfind('::agency_removed::', name, nocase))[1].has_owner_delete);
	
	return sequential(
						parallel(
								output(cfs,,Bair.Filenames(version, pUseProd, pDelta).dbo_cfs_Base.new,__compressed__,overwrite),
								output(mo,,Bair.Filenames(version, pUseProd, pDelta).Dbo_event_mo_Base.new,__compressed__,overwrite),
								output(mo_udf,,Bair.Filenames(version, pUseProd, pDelta).event_dbo_mo_udf_Base.new,__compressed__,overwrite),
								output(distribute(per, hash(eid)),,Bair.Filenames(version, pUseProd, pDelta).Dbo_event_persons_Base.new,__compressed__,overwrite),
								output(per_udf,,Bair.Filenames(version, pUseProd, pDelta).event_dbo_persons_udf_Base.new,__compressed__,overwrite),
								output(veh,,Bair.Filenames(version, pUseProd, pDelta).Dbo_event_vehicle_Base.new,__compressed__,overwrite),
								output(cra,,Bair.Filenames(version, pUseProd, pDelta).Dbo_crash_Base.new,__compressed__,overwrite),
								output(off,,Bair.Filenames(version, pUseProd, pDelta).Dbo_offenders_Base.new,__compressed__,overwrite),
								output(off_pic,,Bair.Filenames(version, pUseProd, pDelta).Dbo_offenders_picture_Base.new,__compressed__,overwrite),
								output(int,,Bair.Filenames(version, pUseProd, pDelta).dbo_intel_Base.new,__compressed__,overwrite),
								output(lpr,,Bair.Filenames(version, pUseProd, pDelta).lpr_Dbo_licenseplateevent_Base.new,__compressed__,overwrite),
								output(shot,,Bair.Filenames(version, pUseProd, pDelta).gunop_Dbo_shot_incident_Base.new,__compressed__,overwrite),
								output(deletes,,Bair.Filenames(version, pUseProd, false).agency_deletes_Base.new,__compressed__,overwrite),
								),
						parallel(								
								promote_modname.promote_cfs.buildfiles.New2Built,
								promote_modname.promote_mo.buildfiles.New2Built,
								promote_modname.promote_mo_udf.buildfiles.New2Built,
								promote_modname.promote_persons.buildfiles.New2Built,
								promote_modname.promote_persons_udf.buildfiles.New2Built,
								promote_modname.promote_vehicle.buildfiles.New2Built,
								promote_modname.promote_crash.buildfiles.New2Built,
								promote_modname.promote_offenders.buildfiles.New2Built,
								promote_modname.promote_offenders_picture.buildfiles.New2Built,
								promote_modname.promote_intel.buildfiles.New2Built,
								promote_modname.promote_LPR.buildfiles.New2Built,
								promote_modname.promote_Shotspotter.buildfiles.New2Built,
								Bair.Promote(version, pUseProd, false, true, '', false).promote_AgencyDeletes.buildfiles.New2Built,
								),
								Bair.Build_Updates(version, pUseProd).process_incremental_promote(true, true),
								if(del_inter_has_owner_delete, Bair.Promote(version, pUseProd, false, true, '', false).promote_AgencyDeletes.buildfiles.Built2QA, Bair.Promote(version, pUseProd, false, true, '', true).promote_AgencyDeletes.buildfiles.Built2QA),
						);	
	
End;