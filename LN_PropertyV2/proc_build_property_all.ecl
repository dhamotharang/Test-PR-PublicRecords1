export proc_build_property_all(filedate)	:=
macro

	import LN_PropertyV2,RoxieKeyBuild,orbit_report;

	LN_PropertyV2.proc_build_stats(filedate,zRunStatsReference)
	
	Proc_Validate_FID         :=  LN_PropertyV2.Valid_fid : success(output('PropertyV2 fid validated successfully'));
	Proc_Build_Base						:=	LN_PropertyV2.Proc_build_base(filedate)	:	success(output('PropertyV2 Base Files created successfully.'));
	Proc_Build_Keys						:=	LN_PropertyV2.proc_build_keys(filedate)	:	success(LN_PropertyV2.Mac_Email_Local(filedate)), failure(FileServices.sendemail('kgummadi@seisint.com;akayttala@seisint.com', 'PropertyV2 roxie Build Failure', failmessage));
	Proc_Create_Relationships	:=	LN_PropertyV2.Proc_Create_Relationships(filedate)	:	success(output('PropertyV2 Key Relationships created successfully.'));
  clickdata_merged					:=	LN_PropertyV2.Clickdata_merge_file;
	clickdata_files						:=	LN_PropertyV2.Proc_Initial_load_clickdata(filedate)	:	success(output('Click data files generated')), failure(output('Click data process for LN Property V2 failed'));
	proc_propertyV2_Stats			:=	zRunStatsReference	:	success(output('Stats created successfully.'));
	new_records_sample_for_qa	:=	LN_PropertyV2.New_records_sample	:	success(LN_PropertyV2.Email_notification_lists(filedate));
	
	orbit_report.Property_Stats(getretval);
	
    sequential(	Proc_Validate_FID,
		            Proc_Build_Base,
								Proc_Build_Keys,
								Proc_Create_Relationships,
								proc_propertyV2_Stats,
								new_records_sample_for_qa,
								getretval
							);

endmacro;