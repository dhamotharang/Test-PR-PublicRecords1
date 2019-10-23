EXPORT Constants := Module

	export SetRequireLinkingId:=['SSN','DID','BDID','RDID'];
	export SetRequireDocumentId:=['FARES ID','OFFENDER KEY','OFFICIAL RECORD','FDN ID'];

	export KEY_PREFIX 							:= '~prte::key::new_suppression::';
	export KEY_PREFIX_FCRA 		:= '~prte::key::new_suppression::fcra::';
	export SuperKeyName 					:= KEY_PREFIX+'@version@::';
	export SuperKeyName_FCRA := KEY_PREFIX_FCRA+'@version@::';

end;