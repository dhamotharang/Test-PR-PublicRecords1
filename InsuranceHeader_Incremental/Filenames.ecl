IMPORT InsuranceHeader,ut;
EXPORT Filenames := MODULE
	// prefixes
	EXPORT Prefix_Temp							:= '~thor_data400::temp::insuranceheader_incremental::';
	//EXPORT Prefix_Base							:= ut.foreign_prod+'thor_data400::base::insuranceheader_incremental::';
	// EXPORT Prefix_Base							:= '~thor_data400::base::insuranceheader_incremental::';
	EXPORT Prefix_Base							:= ut.foreign_aprod+'thor_data400::base::insuranceheader_incremental::';
	EXPORT Prefix_In                := '~thor_data400::in::insuranceheader_incremental::';
	EXPORT Prefix_IncSuppression    := Prefix_In +'suppression::';
	EXPORT Prefix_IncCorrection     := Prefix_In +'correction::';
	EXPORT Prefix_IncBase			 			:= Prefix_Base + 'base::';
//	EXPORT Prefix_IncBase			 			:='~thor_data400::base::insuranceheader_incremental::'+ 'base::';
	EXPORT Prefix_IncBaseAll			  := Prefix_Base + 'base_all::';
 //EXPORT Prefix_IncBaseAll			  := '~thor_data400::base::insuranceheader_incremental::'+ 'base_ALL::';
	EXPORT Prefix_IncBase_Archive		:= Prefix_Base + 'base_archive::';
	EXPORT Prefix_BuildDate	        := Prefix_Base + 'BuildDate::';
	EXPORT Prefix_SALT_Input			 	:= Prefix_Base + 'salt_input::';
	EXPORT Prefix_SALT_Output				:= Prefix_Base + 'salt_output::';
	EXPORT Prefix_RawAsHeader_Boca	:= Prefix_Base + 'boca_header::';
	//EXPORT Prefix_RawAsHeader_Boca	:= ut.foreign_prod+'thor_data400::base::insuranceheader_incremental::boca_header::';
	EXPORT Prefix_AsHeader  				:= Prefix_Base + 'as_header::';
	EXPORT Prefix_AsHeaderAll  			:= Prefix_Base + 'as_header_all::';
	EXPORT Prefix_AsHeaderNewOnly		:= Prefix_Base + 'as_header_newonly::';
	EXPORT Prefix_AsHeaderExisting	:= Prefix_Base + 'as_header_existing::';
	//EXPORT Prefix_AsHeaderExisting		:=  '~thor_data400::base::insuranceheader_incremental::as_header_existing::';
	EXPORT Prefix_IncHierarchy 			:= Prefix_Base + 'addrHierarchy::';
	//EXPORT Prefix_IncHierarchy :=  '~thor_data400::base::insuranceheader_incremental::addrHierarchy::'; 
	EXPORT Prefix_Best         			:= Prefix_Base + 'best::';
	//EXPORT Prefix_Best         :=  '~thor_data400::base::insuranceheader_incremental::best::';
	EXPORT Prefix_StatsIngest				:= Prefix_Base + 'stats_ingest::';
	EXPORT Prefix_StatsNewOnly			:= Prefix_Base + 'stats_newonly::';
	EXPORT Prefix_StatsILink				:= Prefix_Base + 'stats_ilink::';
	EXPORT Prefix_StatsIncBase    	:= Prefix_Base + 'stats_incbase::';
	//EXPORT Prefix_StatsIncBase    := '~thor_data400::base::insuranceheader_incremental::'+'stats_incbase::';
	EXPORT Prefix_dsBase    	      := Prefix_Base + 'full::';
	//EXPORT Prefix_dsBase    	      :=ut.foreign_prod+'thor_data400::base::insuranceheader_incremental::full::';
	EXPORT Prefix_FCRA							:= Prefix_Base + 'fcra::';
	// superfile names
	EXPORT IncSuppression_SF		:= InsuranceHeader.mod_FileNames(Prefix_IncSuppression);
	EXPORT IncCorrection_SF			:= InsuranceHeader.mod_FileNames(Prefix_IncCorrection);
	EXPORT IncBase_SF						:= InsuranceHeader.mod_FileNames(Prefix_IncBase);
	EXPORT IncBaseAll_SF				:= InsuranceHeader.mod_FileNames(Prefix_IncBaseAll);
	EXPORT IncBase_Archive_SF		:= InsuranceHeader.mod_FileNames(Prefix_IncBase_Archive);
	EXPORT BuildDate_SF	        := InsuranceHeader.mod_FileNames(Prefix_BuildDate);
	EXPORT SALT_Input_SF				:= InsuranceHeader.mod_FileNames(Prefix_SALT_Input);
	EXPORT SALT_Output_SF				:= InsuranceHeader.mod_FileNames(Prefix_SALT_Output);
	EXPORT RawAsHeader_Boca_SF	:= InsuranceHeader.mod_FileNames(Prefix_RawAsHeader_Boca);
	EXPORT AsHeader_SF				  := InsuranceHeader.mod_FileNames(Prefix_AsHeader);
	EXPORT AsHeaderAll_SF				:= InsuranceHeader.mod_FileNames(Prefix_AsHeaderAll);
	EXPORT AsHeaderNewOnly_SF		:= InsuranceHeader.mod_FileNames(Prefix_AsHeaderNewOnly);
	EXPORT AsHeaderExisting_SF	:= InsuranceHeader.mod_FileNames(Prefix_AsHeaderExisting);
	EXPORT IncHierarchy_SF    	:= InsuranceHeader.mod_FileNames(Prefix_IncHierarchy); 
	EXPORT Best_SF            	:= InsuranceHeader.mod_FileNames(Prefix_Best); 
	EXPORT StatsIngest_SF				:= InsuranceHeader.mod_FileNames(Prefix_StatsIngest);
	EXPORT StatsNewOnly_SF			:= InsuranceHeader.mod_FileNames(Prefix_StatsNewOnly);
	EXPORT StatsILink_SF				:= InsuranceHeader.mod_FileNames(Prefix_StatsILink);
	EXPORT StatsIncBase_SF	    := InsuranceHeader.mod_FileNames(Prefix_StatsIncBase);
	EXPORT dsBase_SF	          := InsuranceHeader.mod_FileNames(Prefix_dsBase);
	EXPORT FCRA_SF							:= InsuranceHeader.mod_FileNames(Prefix_FCRA);
		
	// logical file names
	EXPORT IncSuppression_LF(STRING version, STRING wu)						:= InsuranceHeader.mod_FileNames(Prefix_IncSuppression).logical(version, wu);
	EXPORT IncCorrection_LF(STRING version, STRING wu)						:= InsuranceHeader.mod_FileNames(Prefix_IncCorrection).logical(version, wu);
	EXPORT IncBase_LF(STRING version, STRING wu)									:= InsuranceHeader.mod_FileNames(Prefix_IncBase).logical(version, wu);
	EXPORT IncBaseAll_LF(STRING version, STRING wu)								:= InsuranceHeader.mod_FileNames(Prefix_IncBaseAll).logical(version, wu);
	EXPORT IncBase_Archive_LF(STRING version, STRING wu)					:= InsuranceHeader.mod_FileNames(Prefix_IncBase_Archive).logical(version, wu);
	EXPORT BuildDate_LF(STRING version, STRING wu)				        := InsuranceHeader.mod_FileNames(Prefix_BuildDate).logical(version, wu);
	EXPORT SALT_Input_LF(STRING version, STRING wu, STRING iter)	:= InsuranceHeader.mod_FileNames(Prefix_SALT_Input).logical(version, wu, iter);
	EXPORT SALT_Output_LF(STRING version, STRING wu, STRING iter)	:= InsuranceHeader.mod_FileNames(Prefix_SALT_Output).logical(version, wu, iter);
	EXPORT RawAsHeader_Boca_LF(STRING version, STRING wu)					:= InsuranceHeader.mod_FileNames(Prefix_RawAsHeader_Boca).logical(version, wu);
	EXPORT AsHeader_LF(STRING version, STRING wu)							    := InsuranceHeader.mod_FileNames(Prefix_AsHeader).logical(version, wu);
	EXPORT AsHeaderAll_LF(STRING version, STRING wu)							:= InsuranceHeader.mod_FileNames(Prefix_AsHeaderAll).logical(version, wu);
	EXPORT AsHeaderNewOnly_LF(STRING version, STRING wu)					:= InsuranceHeader.mod_FileNames(Prefix_AsHeaderNewOnly).logical(version, wu);
	EXPORT AsHeaderExisting_LF(STRING version, STRING wu)					:= InsuranceHeader.mod_FileNames(Prefix_AsHeaderExisting).logical(version, wu);
	EXPORT IncHierarchy_LF(STRING version, STRING wu)							:= InsuranceHeader.mod_FileNames(Prefix_IncHierarchy).logical(version, wu);
	EXPORT BEST_LF(STRING version, STRING wu)											:= InsuranceHeader.mod_FileNames(Prefix_best).logical(version, wu);
	EXPORT FCRA_LF(STRING version, STRING wu)											:= InsuranceHeader.mod_FileNames(Prefix_FCRA).logical(version, wu);

	EXPORT StatsIngest_LF(STRING version, STRING wu)							:= InsuranceHeader.mod_FileNames(Prefix_StatsIngest).logical(version, wu);
	EXPORT StatsNewOnly_LF(STRING version, STRING wu)							:= InsuranceHeader.mod_FileNames(Prefix_StatsNewOnly).logical(version, wu);
	EXPORT StatsILink_LF(STRING version, STRING wu, STRING iter)	:= InsuranceHeader.mod_FileNames(Prefix_StatsILink).logical(version, wu, iter);
	EXPORT StatsIncBase_LF(STRING version, STRING wu)				      := InsuranceHeader.mod_FileNames(Prefix_StatsIncBase).logical(version, wu);
	
	// temporary files
	EXPORT IlinkStatsFileTemp := Prefix_Temp + 'ilink_stats_temp';
	
	// persist files
	EXPORT Persist_BaseDedup    := Prefix_Temp + 'existingbasededup';
	EXPORT Persist_DIDAppend    := Prefix_Temp + 'newrecdidappend';
	EXPORT Persist_DIDAppendExisting := Prefix_Temp + 'existingdidappend';
	EXPORT Persist_AddrLinkPreprocess := Prefix_Temp + 'addresslinkingpreprocess'; 
	EXPORT Persist_IngestInput  := Prefix_Temp + 'Ingestinput';
	EXPORT Persist_DidChangeAll := Prefix_Temp + 'DidChangeAll0';
	// workman files
	EXPORT Prefix_Workman						:= '~thor_data400::workman::insuranceheader_incremental::';
	EXPORT MasterWorkmanOutputSF  	:= Prefix_Workman + 'WUInfo';
	
END;
