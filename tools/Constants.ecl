﻿import tools,ut;
export Constants(

	 string					pDatasetName
	,boolean				pUseOtherEnvironment	= false
	,string					pGroupname						= ''
	,unsigned8			pMaxRecordSize				= 4096
	,boolean				pIsTesting						= Tools._Constants.IsDataland
	,set of string1	pAutokey_Skipset			= []
	,string					pAutokey_typestr			= ''
  ,boolean        pAdd_Eclcc            = false

) :=
module, virtual
												
	export Name										:= pDatasetName		;
	export IsTesting 							:= pIsTesting			;
	export IsDataland 						:= pIsTesting			;
	export foreign_environment		:= if(IsDataland						,ut.foreign_prod													,ut.foreign_dataland);
	export prefix           			:= if(pUseOtherEnvironment 	,foreign_environment 		                  ,'~'	              );
	export thor_cluster_Files			:= if(pUseOtherEnvironment 	,foreign_environment + 'thor_data400::'		,'~thor_data400::'	);
	export thor_cluster_Persists	:= thor_cluster_Files		;

	shared lTemplate(string ptype)		:= thor_cluster_files		+ ptype + '::'	+ Name + '::@version@::'	;
	shared lOldTemplate(string ptype)	:= thor_cluster_files		+ ptype + '::'	+ Name ;
	shared lwildcard(string ptype)		:= thor_cluster_files		+ ptype + '::'	+ Name + '::*::'	;
	shared lGenericTemplate           := prefix		            + Name  + '::@version@::'	;

	export InputTemplate					:= lTemplate('in'		);
	export InputRollingTemplate		:= lTemplate('in_rolling'		);
	export FileTemplate						:= lTemplate('base'	);
	export keyTemplate						:= lTemplate('key'	);
	export outTemplate						:= lTemplate('out'	);
	export GenericTemplate			  := lGenericTemplate;
	export oldkeyTemplate					:= lOldTemplate('key'	);
	export persistTemplate				:= lOldTemplate('persist'	) + '::';
	export autokeytemplate				:= keyTemplate + 'autokey::';
	export altautokeytemplate			:= lOldTemplate('key') + '::autokey::@version@::';
	export statsTemplate					:= lTemplate('stats');
	export OldFileTemplate				:= lOldTemplate('base'	);
	export max_record_size				:= pMaxRecordSize				;
	export Groupname							:= tools.fun_Groupname(pGroupname,,pAdd_Eclcc);
	export autokey_buildskipset 	:= pAutokey_Skipset;
	export ak_skipSet							:= pAutokey_Skipset;
	export ak_typeStr							:= pAutokey_typestr;
	export InputWild							:= lwildcard('in'		);
	export FileWild								:= lwildcard('base'	);
	export keyWild								:= lwildcard('key'	);

end;