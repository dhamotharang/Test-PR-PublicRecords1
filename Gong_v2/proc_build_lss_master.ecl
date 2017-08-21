export proc_build_lss_master(rundate,outfile) := macro
import Address, did_add, ut, header_slimsort, business_header_ss;
#uniquename(adds)
#uniquename(deletes)
#uniquename(t_flagDeletes)
#uniquename(flaggedGong)
#uniquename(upcase)
#uniquename(p_upcase)

%adds% := distribute(Gong_v2.file_DailyAdditions,
	hash(trim(seisintid,left,right)))(not(lststy = '8') and
									  not(lststy = '9') and  
									  not(lststy = '2' and telno = '0000000'));

	
								
%deletes% := distribute(Gong_v2.file_DailyDeletions,hash(recordid));


// ////////////////////////////////////////////////////////////////////////////////////////////////////
%adds% %t_flagDeletes%(%adds% L ,%deletes% R) := transform

precleanName        		:= if(length(L.lstnm) = 1 and
								 L.lstnm[1] = L.lstgn[1],
								 stringlib.stringtouppercase(L.lstgn),
							     trim(stringlib.stringtouppercase(L.lstnm),left,right) + ' ' + trim(stringlib.stringtouppercase(L.lstgn),left,right));
								 
self.dt_first_seen:= L.last_udt_date[5..8]+L.last_udt_date[1..4];
self.dt_last_seen:= if(trim(R.recordid,left,right) = trim(L.seisintid,left,right),R.filedate[1..8],'');
self.current_record_flag:= if(trim(R.recordid,left,right) = trim(L.seisintid,left,right),'','Y');  
self.deletion_date:= if(trim(R.recordid,left,right) = trim(L.seisintid,left,right),R.filedate[1..8],'');
self := L;
end;

%flaggedGong%	:= join(%adds%,%deletes%,
					trim(left.seisintid,left,right) = trim(right.recordid,left,right),
					%t_flagDeletes%(left,right),left outer,local);

// ////////////////////////////////////////////////////////////////////////////////////////////////////
//Populate prior area codes
// ////////////////////////////////////////////////////////////////////////////////////////////////////

#uniquename(acChange)
#uniquename(tChange)
#uniquename(j_acChange)

%acChange% := Risk_Indicators.File_AreaCode_Change;

%flaggedGong% %tChange%(%flaggedGong% L, %acChange% R) := transform
self.prior_area_code 	:= map(L.phone10[1..6] = R.new_npa+R.new_nxx
								and ut.GetDate < 
								if(R.permissive_end[5]='9','19'+R.permissive_end[5..6]+R.permissive_end[1..4],'20'+R.permissive_end[5..6]+R.permissive_end[1..4])
								=> R.old_npa,'');
								
self 					:= L;

end;

%j_acChange% := join(%flaggedGong%,%acChange%,
					left.phone10[1..6] = right.new_npa+right.new_nxx,
					%tChange%(left,right), left outer,lookup);

// ////////////////////////////////////////////////////////////////////////////////////////////////////
//Populate Blank Address Fields
// ////////////////////////////////////////////////////////////////////////////////////////////////////

#uniquename(dd_Targus)
#uniquename(dist_gong)
#uniquename(taddr)
#uniquename(isJoin)
#uniquename(appndedAddr)

%dd_Targus% := dedup(sort(distribute(Targus.File_consumer_base,hash(phone_number,lname,fname))
							,phone_number,lname,fname,dt_last_seen,local)
							,phone_number,lname,fname,right,local);

%dist_gong% := distribute(%j_acChange%,hash(phone10,name_last,name_first));

%dist_gong%  %taddr%(%dist_gong% L, %dd_Targus% R):= transform

%isJoin% := (R.phone_number= L.phone10 and
		   R.lname   	 = L.name_last and
		   R.fname   	 = L.name_first and
		   L.current_record_flag = 'Y');


	
self.appnd_prim_range   := if(L.prim_name    = '' ,
							map(%isJoin% and 
							   L.prim_range  = ''=> R.prim_range,''),
							map(%isJoin% and 
							   L.prim_name   = R.prim_name and L.prim_range  = '' => R.prim_range,''));

self.appnd_predir		:= if(L.prim_name    = '' ,
							map(%isJoin% and 
							   L.predir      = ''=> R.predir,''),
							map(%isJoin% and 
							   L.prim_name   = R.prim_name and L.predir      = '' => R.predir,''));

self.appnd_prim_name	:= if(L.prim_range   = '' ,
							map(%isJoin% and 
							   L.prim_name   = ''=> R.prim_name,''),
							map(%isJoin% and 
							   L.prim_range  = R.prim_range and L.prim_name   = ''=> R.prim_name,''));

self.appnd_suffix		:= if(L.prim_name    = '' ,
							map(%isJoin% and 
							   L.suffix      = ''=> R.suffix,''),
							map(%isJoin% and 
							   L.prim_name   = R.prim_name and L.suffix      = '' => R.suffix,''));

self.appnd_postdir		:= if(L.prim_name    = '' ,
							map(%isJoin% and 
							   L.postdir     = ''=> R.postdir,''),
							map(%isJoin% and 
							   L.prim_name   = R.prim_name and L.postdir     = '' => R.postdir,''));

self.appnd_unit_desig	:= if(L.prim_name    = '' ,
							map(%isJoin% and 
							   L.unit_desig  = ''=> R.unit_desig,''),
							map(%isJoin% and 
							   L.prim_name   = R.prim_name and L.unit_desig  = '' => R.unit_desig,''));

self.appnd_sec_range	:= if(L.prim_name    = '' ,
							map(%isJoin% and 
							   L.sec_range   = ''=> R.sec_range,''),
							map(%isJoin% and 
							   L.prim_name   = R.prim_name and L.sec_range   = '' => R.sec_range,''));

self.appnd_p_city_name	:= if(L.prim_name    = '' ,
							map(%isJoin% and 
							   L.p_city_name = ''=> R.city_name,''),
							map(%isJoin% and 
							   L.prim_name   = R.prim_name and L.p_city_name = '' => R.city_name,''));

self.appnd_st			:= if(L.prim_name    = '' ,
							map(%isJoin% and 
							   L.st  		 = ''=> R.st,''),
							map(%isJoin% and 
							   L.prim_name   = R.prim_name and L.st  		 = '' => R.st,''));

self.appnd_z5			:= if(L.prim_name    = '' ,
							map(%isJoin% and 
							   L.z5  = ''=> R.z5,''),
							map(%isJoin% and 
							   L.prim_name   = R.prim_name and L.z5  		 = ''=> R.z5,''));

self.appnd_z4			:= if(L.prim_name    = '' ,
							map(%isJoin% and 
							   L.z4  = ''=> R.zip4,''),
							map(%isJoin% and 
							   L.prim_name   = R.prim_name and L.z4  		 = '' => R.zip4,''));

self := L;
end;

%appndedAddr% := join(%dist_gong%,%dd_Targus%,
				left.phone10 = right.phone_number and
				left.name_last = right.lname and
				left.name_first = right.fname,

				%taddr%(left,right),left outer,local);

// ////////////////////////////////////////////////////////////////////////////////////////////////////
//Combine QSENT and LSS Master Files
// ////////////////////////////////////////////////////////////////////////////////////////////////////

#uniquename(combinedFiles)
%combinedFiles% := %appndedAddr%;
//+ Gong_v2.File_QsentMaster;

// ////////////////////////////////////////////////////////////////////////////////////////////////////
//Append DID & HHID
// ////////////////////////////////////////////////////////////////////////////////////////////////////

#uniquename(history_did_hhid)
Gong_v2.MAC_Did_Hhid_Append(%combinedFiles%,%history_did_hhid%);
per_history := %history_did_hhid% : persist('~thor_dell400_2::persist::gongmaster_did'/*,_Control.TargetQueue.ADL_2_400*/);

// ////////////////////////////////////////////////////////////////////////////////////////////////////
//Append months disconnect
// ////////////////////////////////////////////////////////////////////////////////////////////////////

Gong_v2.mac_add_disc_cnt(per_history,cmplt_history);

outfile := 			
sequential(
	output(cmplt_history,,Gong_v2.thor_cluster+'base::'+rundate+'::lss_master',overwrite),
			fileServices.StartSuperFileTransaction(),
			fileservices.clearsuperfile(gong_v2.thor_cluster+'base::gongv2_master'),
			
			fileServices.AddSuperFile(gong_v2.thor_cluster+'base::gongv2_master',
									  gong_v2.thor_cluster+'base::'+rundate+'::lss_master',,,),
			
			fileServices.FinishSuperFileTransaction());
endmacro;
