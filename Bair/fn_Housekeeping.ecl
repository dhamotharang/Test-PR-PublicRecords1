import lib_FileServices,ut,std;

export fn_Housekeeping(boolean pReportOnly=true):=function

lClusterFilter  :=  'thor40';
lCount          :=  1000;

FsLogicalSuperSubRecordBig := record
   string supername{maxlength(4096)};
   string subname{maxlength(4096)};
end;

MyFileServices := SERVICE
  dataset(FsLogicalSuperSubRecordBig) LogicalFileSuperSubListBig() :  library='plugins/libfileservices', c,context,entrypoint='fsLogicalFileSuperSubList';
END;

dSuperSubList     :=  nothor(MyFileServices.LogicalFileSuperSubListBig());
dLogicalFileList  :=  nothor(lib_FileServices.FileServices.LogicalFileList(unknownszero := true));

dList				      :=  join(dLogicalFileList, dSuperSubList,
                           left.Name = right.SubName,
													 left outer
                          ):global(few);

days:=0;
dt:=ut.date_math((STRING8)Std.Date.Today(),days);

skipThese:=dataset(
[
 {'thor400_data::base::composite_public_safety_data_delta_temp'}
,{'thor400_data::base::composite_public_safety_data_delta_delete'}
,{'thor_data400::in::bair::dbo::intersectioncoordinates'}
,{'thor_data400::in::bair::event::helper::ucr_group_classifications'}
,{'thor_data400::out::bair_flush_vers'}
,{'thor_data400::out::bair_bldsegment_status_full'}
,{'thor_data400::out::bair_files_snap'}
,{'thor_data400::out::bair_newheader_flag'}
,{'thor_data400::out::bair_lastfullpkg_flag'}
,{'thor400_data::base::composite_public_safety_data_full'}
,{'thor400_data::base::composite_public_safety_data_delta'}
,{'thor400_data::base::composite_public_safety_data_curr_delta'}
,{'thor400_data::base::composite_public_safety_data_delta_building'}
,{'thor_data::key::city_state_to_county'}
,{'thor_data400::out::bair_bldchkpt_full'}
,{'thor_data400::base::bair::agency_removed::dbo::agency_deletes'}
],{string lfn});

skipThese1:='backup|intermediate|building|built|qa|agency_layers';
skipThese2:='2.*w';
old:='::history$';
// old:='::history$|::delete$|::delete::';

l1:=dList(
					regexreplace('-',modified[..10],'')<dt  // skip less than a day old
					and
					supername NOT in set(skipThese,lfn)  // skip in whiteboard list
					and
					NOT regexfind(skipThese1,supername,nocase)  // skip in use
					and
					(
					regexfind(old,supername,nocase)  // not in use
					or
					NOT regexfind(skipThese2,name,nocase)  //  not a full build
					or
					supername=''  // file is orphan
					)
					);

l2:=dList(
					regexreplace('-',modified[..10],'')<dt  // skip less than a day old
					and
					regexfind('frags',supername,nocase)  // boolean only
					and
					NOT regexfind(skipThese2,name,nocase)  //  not a full build
					);

l3:=dList(
					regexreplace('-',modified[..10],'')<ut.date_math((STRING8)Std.Date.Today(),-1)  // skip less than 2 days old
					and
					regexfind('frags|bair_externallinkkeys',supername,nocase)  // boolean and linking keys only
					and
					regexfind('2.*w::',name,nocase)  //  full build only
					);
					
r:= SEQUENTIAL(
			OUTPUT(pReportOnly,named('ReportOnly')),
			OUTPUT(count(l1),named('candidates_for_deletion_count')),
			OUTPUT(sum(l1,size),named('candidates_for_deletion_space')),
			OUTPUT(sort(l1,supername,modified),{supername,name,size,mod:=regexreplace('-',modified[1..10],''),owner},named('candidates_for_deletion_list'),all),
			NOTHOR(APPLY(l1
			,IF(NOT pReportOnly and supername<>'',FileServices.RemoveSuperFile('~'+trim(supername),'~'+trim(name),true))
			,IF(NOT pReportOnly and supername='',FileServices.DeleteLogicalFile('~'+trim(name)))
			)),
			OUTPUT(count(l2),named('candidates2_for_deletion_count')),
			OUTPUT(sum(l2,size),named('candidates2_for_deletion_space')),
			OUTPUT(sort(l2,supername,modified),{supername,name,size,mod:=regexreplace('-',modified[1..10],''),owner},named('candidates2_for_deletion_list'),all),
			NOTHOR(APPLY(l2
			,IF(NOT pReportOnly and supername<>'',FileServices.RemoveSuperFile('~'+trim(supername),'~'+trim(name),true))
			)),
			OUTPUT(count(l3),named('candidates3_for_deletion_count')),
			OUTPUT(sum(l3,size),named('candidates3_for_deletion_space')),
			OUTPUT(sort(l3,supername,modified),{supername,name,size,mod:=regexreplace('-',modified[1..10],''),owner},named('candidates3_for_deletion_list'),all),
			NOTHOR(APPLY(l3
			,IF(NOT pReportOnly and supername<>'',FileServices.RemoveSuperFile('~'+trim(supername),'~'+trim(name),true))
			))
			);

return r;
end;