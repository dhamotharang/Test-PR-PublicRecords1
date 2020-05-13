IMPORT	versioncontrol, data_services;
EXPORT	Filenames(STRING	pversion	=	'')	:=	MODULE

	EXPORT OptOut := MODULE	
		EXPORT STRING thorCluster			:= 'thor::';
		EXPORT STRING name 					:= 'new_suppression::opt_out'; 
		EXPORT STRING lInputTemplate		:=	'~' + thorCluster + 'in::'	 +	name 		 +	'::@version@::data';

		EXPORT	Input						:=	versioncontrol.mInputFilenameVersions(lInputTemplate);
		EXPORT	Base						:=	'~' + thorCluster + 'base::' +	name;
		EXPORT	Base_FCRA					:=	'~' + thorCluster + 'base::' +	name + '_fcra';

		EXPORT OutFileToRBI					:= '~'	+ thorCluster + 'out::'	 +	name + '::' + pversion + '::opt_out_rbi.csv';
		
	END;
	
	EXPORT Exemptions := MODULE
		EXPORT STRING thorCluster			:= 'thor::';
		EXPORT STRING name 					:= 'new_suppression::exemptions'; 
		EXPORT STRING lGlobalSidPRTemplate	:=	'~' + thorCluster + 'in::'	 +	'exemptions_pr' +	'::@version@::data';
		EXPORT STRING lGlobalSidHCTemplate	:=	'~' + thorCluster + 'in::'	 +	'exemptions_hc' +	'::@version@::data';
		EXPORT STRING lGlobalSidInsTemplate	:=	'~' + thorCluster + 'in::'	 +	'exemptions_ins' +	'::@version@::data';

		EXPORT	Input_PR					:=	versioncontrol.mInputFilenameVersions(lGlobalSidPRTemplate);
		EXPORT	Input_HC					:=	versioncontrol.mInputFilenameVersions(lGlobalSidHCTemplate);
		EXPORT	Input_Ins					:=	versioncontrol.mInputFilenameVersions(lGlobalSidInsTemplate);
		EXPORT	Base						:=	'~' + thorCluster + 'base::' +	name;
	END;

	EXPORT Global_Sid := MODULE
		EXPORT STRING thorCluster			:= 'thor::';
		EXPORT STRING name 					:= 'new_suppression::global_sids'; 
		EXPORT	Base						:=	'~' + thorCluster + 'base::' +	name;
	END;

END;