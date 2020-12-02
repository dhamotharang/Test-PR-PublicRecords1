import versioncontrol,tools,std;

export Filenames(string pversion = '', boolean pUseProd = false) := module
  
  shared version:=if(pversion='',(string8)std.date.today(),pversion):INDEPENDENT;

  export lInputTemplate_built       := IDA._Constants().thor_cluster_files   + 'in::'   + IDA._Constants().DatasetName + '::built';
	export lInputTemplate_qa          := IDA._Constants().thor_cluster_files   + 'in::'   + IDA._Constants().DatasetName + '::qa';
	export lInputTemplate_father      := IDA._Constants().thor_cluster_files   + 'in::'   + IDA._Constants().DatasetName + '::father';
	export lInputTemplate_delete      := IDA._Constants().thor_cluster_files   + 'in::'   + IDA._Constants().DatasetName + '::delete';
	export lInputTemplate	            := IDA._Constants().thor_cluster_files   + 'in::'   + IDA._Constants().DatasetName + '::@version@';
	export Input		                  := tools.mod_FilenamesBuild(lInputTemplate, version);
	
	export lBaseTemplateDaily_built   := IDA._Constants().thor_cluster_files   + 'base::' + IDA._Constants().DatasetName + '::daily'     + '::built';
	export lBaseTemplateDaily_qa      := IDA._Constants().thor_cluster_files   + 'base::' + IDA._Constants().DatasetName + '::daily'     + '::qa';
	export lBaseTemplateDaily_father  := IDA._Constants().thor_cluster_files   + 'base::' + IDA._Constants().DatasetName + '::daily'     + '::father';
 	export lBaseTemplateDaily_delete  := IDA._Constants().thor_cluster_files   + 'base::' + IDA._Constants().DatasetName + '::daily'     + '::delete';
	export lBaseTemplateDaily	        := IDA._Constants().thor_cluster_files   + 'base::' + IDA._Constants().DatasetName + '::daily'     + '::@version@';
	export BaseDaily		              := tools.mod_FilenamesBuild(lBaseTemplateDaily, version);	

  export lBaseTemplate_built        := IDA._Constants().thor_cluster_files   + 'base::' + IDA._Constants().DatasetName + '::built';
  export lBaseTemplate_qa           := IDA._Constants().thor_cluster_files   + 'base::' + IDA._Constants().DatasetName + '::qa';
  export lBaseTemplate_father       := IDA._Constants().thor_cluster_files   + 'base::' + IDA._Constants().DatasetName + '::father';
	export lBaseTemplate_delete       := IDA._Constants().thor_cluster_files   + 'base::' + IDA._Constants().DatasetName + '::delete';
	export lBaseTemplate	            := IDA._Constants().thor_cluster_files   + 'base::' + IDA._Constants().DatasetName + '::@version@';
	export Base		                    := tools.mod_FilenamesBuild(lBaseTemplate, version); 
	
	export lBaseChangeTemplate_built  := IDA._Constants().thor_cluster_files   + 'base::change::' + IDA._Constants().DatasetName + '::built';
  export lBaseChangeTemplate_qa     := IDA._Constants().thor_cluster_files   + 'base::change::' + IDA._Constants().DatasetName + '::qa';
  export lBaseChangeTemplate_father := IDA._Constants().thor_cluster_files   + 'base::change::' + IDA._Constants().DatasetName + '::father';
	export lBaseChangeTemplate_delete := IDA._Constants().thor_cluster_files   + 'base::change::' + IDA._Constants().DatasetName + '::delete';
	export lBaseChangeTemplate	      := IDA._Constants().thor_cluster_files   + 'base::change::' + IDA._Constants().DatasetName + '::@version@';
	export BaseChange		              := tools.mod_FilenamesBuild(lBaseChangeTemplate, version); 
	
	export lDesprayTemplate_built     := IDA._Constants().thor_cluster_files   + 'out::' + IDA._Constants().DatasetName + '::despray'     + '::built';
	export lDesprayTemplate_qa        := IDA._Constants().thor_cluster_files   + 'out::' + IDA._Constants().DatasetName + '::despray'     + '::qa';
	export lDesprayTemplate_father    := IDA._Constants().thor_cluster_files   + 'out::' + IDA._Constants().DatasetName + '::despray'     + '::father';
 	export lDesprayTemplate_delete    := IDA._Constants().thor_cluster_files   + 'out::' + IDA._Constants().DatasetName + '::despray'     + '::delete';
	export lDesprayTemplate	          := IDA._Constants().thor_cluster_files   + 'out::' + IDA._Constants().DatasetName + '::despray'     + '::@version@' ;
	export Despray		                := tools.mod_FilenamesBuild(lBaseTemplateDaily, version);
  
	export dAll_inputfilenames        := Input.dAll_filenames;
	export dAll_dailyfilenames        := BaseDaily.dAll_filenames;
	export dAll_filenames             := Base.dAll_filenames;
	export dAll_change                := BaseChange.dAll_filenames;
  export dAll_desprayfilenames      := Despray.dAll_filenames;



end;
