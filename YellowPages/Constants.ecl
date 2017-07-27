import tools;
export Constants(

	boolean	pUseOtherEnvironment	= false

) :=
module(tools.Constants(

	 pDatasetName					:= 'YellowPages'
	,pUseOtherEnvironment	:= pUseOtherEnvironment
	,pGroupname						:= ''
	,pMaxRecordSize				:= 4096
	,pIsTesting						:= Tools._Constants.IsDataland
	,pAutokey_Skipset			:= ['F','S']
	,pAutokey_typestr			:= 'BC'
))

	export oldautokeytemplate			:= lOldTemplate('key'	) + '::autokey::';
	export oldkeytemplate					:= lOldTemplate('key'	);

end;