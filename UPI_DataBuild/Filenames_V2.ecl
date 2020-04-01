import versioncontrol,tools,Data_Services;

export Filenames_V2(string pVersion = '', boolean pUseProd = false, string gcid, string pHistMode) := module

	// this version does not use pServiceName parameter, which seems to have been dropped from tools.mod_FilenamesBuild attribute
	
	// pHistMode = 'A' means save all data for the customer
	// pHistMode = 'N' means save none of the data
	// there is a lag of (TBD) days of when the data is processed, results and output generated, and when the data is to be deleted
	// a separate clean up process will run daily for the customers who have requested that we do not store data - this will be
	// identifiable in the superfile name, to indicate that the data for *this* customer is eligible to be deleted
	
  export member_lBaseTemplate_built				:= if(pHistMode = 'A', _Dataset(pUseProd).thor_cluster_files + 'base::' + gcid + '::built',
																																 _Dataset(pUseProd).thor_cluster_files + 'base::' + gcid + '::built_nosave');
	export member_lBaseTemplate							:= if(pHistMode = 'A', _Dataset(pUseProd).thor_cluster_files + 'base::' + gcid + '::@version@',
																																 _Dataset(pUseProd).thor_cluster_files + 'base::' + gcid + '::@version@_nosave');
	export member_lInputTemplate 						:= if(pHistMode = 'A', _Dataset(pUseProd).thor_cluster_files + 'in::'   + gcid,
																																 _Dataset(pUseProd).thor_cluster_files + 'in::'   + gcid + '_nosave');
	export member_lInputHistTemplate 				:= if(pHistMode = 'A', _Dataset(pUseProd).thor_cluster_files + 'in::'   + gcid + '::history',
																																 _Dataset(pUseProd).thor_cluster_files + 'in::'   + gcid + '::history_nosave');
	export raw_lInputTemplate 							:= if(pHistMode = 'A', _Dataset(pUseProd).thor_cluster_files + 'in_raw::'   + gcid,
																																 _Dataset(pUseProd).thor_cluster_files + 'in_raw::'   + gcid + '_nosave');
	export raw_lInputHistTemplate 					:= if(pHistMode = 'A', _Dataset(pUseProd).thor_cluster_files + 'in_raw::'   + gcid + '::history',
																																 _Dataset(pUseProd).thor_cluster_files + 'in_raw::'   + gcid + '::history_nosave');
	export batch_lInputTemplate							:= if(pHistMode = 'A', _Dataset(pUseProd).thor_cluster_files + 'from_batch::' + gcid,
																																 _Dataset(pUseProd).thor_cluster_files + 'from_batch::' + gcid + '_nosave');
	export batch_lInputHistTemplate					:= if(pHistMode = 'A', _Dataset(pUseProd).thor_cluster_files + 'from_batch::' + gcid + '::history',
																																 _Dataset(pUseProd).thor_cluster_files + 'from_batch::' + gcid + '::history_nosave');
	export member_Base		  								:= tools.mod_FilenamesBuild(member_lBaseTemplate, pVersion);
	
	export tobatch_lOutputTemplate_built		:= if(pHistMode = 'A', _Dataset(pUseProd).thor_cluster_files + 'to_batch::' + gcid + '::built',
																																 _Dataset(pUseProd).thor_cluster_files + 'to_batch::' + gcid + '::built_nosave');
	export tobatch_lOutputTemplate					:= if(pHistMode = 'A', _Dataset(pUseProd).thor_cluster_files + 'to_batch::' + gcid + '::@version@',
																																 _Dataset(pUseProd).thor_cluster_files + 'to_batch::' + gcid + '::@version@_nosave');
	export tobatch_file											:= tools.mod_FilenamesBuild(tobatch_lOutputTemplate, pVersion);
	
	export processed_input_lBaseTemplate_built	:= if(pHistMode = 'A', _Dataset(pUseProd).thor_cluster_files + 'processed_input::' + gcid + '::built',
																																 _Dataset(pUseProd).thor_cluster_files + 'processed_input::' + gcid + '::built_nosave');
	
	export processed_input_lBaseTemplate				:= if(pHistMode = 'A', _Dataset(pUseProd).thor_cluster_files + 'processed_input::' + gcid + '::@version@',
																																 _Dataset(pUseProd).thor_cluster_files + 'processed_input::' + gcid + '::@version@_nosave');
	export processed_input											:= tools.mod_FilenamesBuild(processed_input_lBaseTemplate, pVersion);
		
	export asHeader_lBaseTemplate  					:= if(pHistMode = 'A', _Dataset(pUseProd).thor_cluster_files + 'asHeader::' + gcid + '::@version@',
																																 _Dataset(pUseProd).thor_cluster_files + 'asHeader::' + gcid + '::@version@_nosave');
	export asHeader					     		 				:= tools.mod_FilenamesBuild(asHeader_lBaseTemplate, pVersion);
	
	export temp_header_lBaseTemplate 				:= if(pHistMode = 'A', _Dataset(pUseProd).thor_cluster_files + 'temp_header::' + gcid + '::@version@',
																																 _Dataset(pUseProd).thor_cluster_files + 'temp_header::' + gcid + '::@version@_nosave');
	export temp_header					     				:= tools.mod_FilenamesBuild(temp_header_lBaseTemplate, pVersion);

	export tobatch_metrics_lOutputTemplate_built		:= if(pHistMode = 'A', _Dataset(pUseProd).thor_cluster_files + 'to_batch_metrics::' + gcid + '::built',
																																				 _Dataset(pUseProd).thor_cluster_files + 'to_batch_metrics::' + gcid + '::built_nosave');
	export tobatch_metrics_lOutputTemplate					:= if(pHistMode = 'A', _Dataset(pUseProd).thor_cluster_files + 'to_batch_metrics::' + gcid + '::@version@',
																																				 _Dataset(pUseProd).thor_cluster_files + 'to_batch_metrics::' + gcid + '::@version@_nosave');
	
	export tobatch_metrics_file							:= tools.mod_FilenamesBuild(tobatch_metrics_lOutputTemplate, pVersion);
	
	export slim_history_lOutputTemplate_built:= if(pHistMode = 'A', _Dataset(pUseProd).thor_cluster_files + 'slim_history::' + gcid + '::built',
																																 _Dataset(pUseProd).thor_cluster_files + 'slim_history::' + gcid + '::built_nosave');
	export slim_history_lOutputTemplate			:= if(pHistMode = 'A', _Dataset(pUseProd).thor_cluster_files + 'slim_history::' + gcid + '::@version@',
																																 _Dataset(pUseProd).thor_cluster_files + 'slim_history::' + gcid + '::@version@_nosave');
	
	export slim_history_file									:= tools.mod_FilenamesBuild(slim_history_lOutputTemplate, pVersion);
	
	export aggregate_report_lOutputTemplate_built	:= if(pHistMode = 'A', _Dataset(pUseProd).thor_cluster_files + 'aggregate_report::' + gcid + '::built',
																																 _Dataset(pUseProd).thor_cluster_files + 'aggregate_report::' + gcid + '::built_nosave');
	export aggregate_report_lOutputTemplate				:= if(pHistMode = 'A', _Dataset(pUseProd).thor_cluster_files + 'aggregate_report::' + gcid + '::@version@',
																																 _Dataset(pUseProd).thor_cluster_files + 'aggregate_report::' + gcid + '::@version@_nosave');
	
	export aggregate_report_file									:= tools.mod_FilenamesBuild(aggregate_report_lOutputTemplate, pVersion);
	
	EXPORT  IsDataland          :=  tools._Constants.IsDataland;
	EXPORT  foreign_environment :=  '~';//IF(IsDataland,'~',Data_Services.foreign_prod);
  EXPORT  cluster_name        :=  'ushc::crk::';
	EXPORT  prefix              :=  foreign_environment + cluster_name;
	
  // workman files
  EXPORT  WUPrefix              :=  prefix    + gcid  + '::' + pVersion + '::';
  EXPORT  MasterWUOutput_SF     :=  WUPrefix  + 'UPI_DataBuild_CRK::qa::workunit_history';

end;