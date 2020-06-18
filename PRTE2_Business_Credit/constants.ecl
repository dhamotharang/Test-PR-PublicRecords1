import prte2_business_credit, prte2, mdr;


EXPORT constants := module
		
		EXPORT in_prefix							:= prte2.constants.prefix + 'in::sbfe::';
		EXPORT base_prefix						:= prte2.constants.prefix + 'base::sbfe::';
		
		//Base/Input/Key Prefix
		EXPORT KEY_PREFIX							:= prte2.constants.prefix + 'key::sbfe::';
		EXPORT SuperKeyName 					:= KEY_PREFIX+'@version@::';

		EXPORT KEY_PREFIX_scoring			:= prte2.constants.prefix + 'key::sbfescoring::';
		EXPORT SuperKeyName_scoring 	:= KEY_PREFIX_scoring+'@version@::';
		
		EXPORT dataset_name						:= 'SBFECVKeys';
		EXPORT dataset_name_scoring		:= 'SBFECVScoringKeys';
		
		EXPORT	source								:=	MDR.sourceTools.src_Business_Credit;
 		
END;