export	fileNames	:=
module
	//OLD CODE
	export  cluster           := '~thor_data400';

	export inAssessor         := cluster + '::in::ln_propertyV2::assessor';	
	export inDeeds            := cluster + '::in::ln_propertyV2::deed';
	export inSearch           := cluster + '::in::ln_propertyV2::search';
	export inAddlNames        := cluster + '::in::ln_propertyV2::addl_names';
	export inAddllegal        := cluster + '::in::ln_propertyV2::addl_legal';
	export inAssessorRepl     := cluster + '::in::ln_propertyV2::assessor_repl';	
	export inDeedsRepl        := cluster + '::in::ln_propertyV2::deed_repl';
	export inSearchRepl       := cluster + '::in::ln_propertyV2::search_repl';
	export inAddlNamesRepl    := cluster + '::in::ln_propertyV2::addl_names_repl';
	export inAddllegalRepl    := cluster + '::in::ln_propertyV2::addl_legal_repl';	
	////////////////////////////////////////////////////////////////////////////////////////////
	export	In	:=
	module
		export	LNAssessment			:=	LN_Propertyv2.cluster	+	'in::ln_propertyV2::assessor_raw';
		export	LNAssessmentRepl	:=	LN_Propertyv2.cluster	+	'in::ln_propertyV2::assessor_repl_raw';
		export	LNDeed						:=	LN_Propertyv2.cluster	+	'in::ln_propertyV2::deed_raw';
		export	LNDeedRepl				:=	LN_Propertyv2.cluster	+	'in::ln_propertyV2::deed_repl_raw';
		export	LNMortgage				:=	LN_Propertyv2.cluster	+	'in::ln_propertyV2::mortgage_raw';
		export	LNMortgageRepl		:=	LN_Propertyv2.cluster	+	'in::ln_propertyV2::mortgage_repl_raw';
	end;
	
	export	Prep	:=
	module
		export	LNAssessment							:=	LN_Propertyv2.cluster	+	'in::ln_propertyV2::assessor';
		export	LNAssessmentRepl					:=	LN_Propertyv2.cluster	+	'in::ln_propertyV2::assessor_repl';
		
		export	LNDeed										:=	LN_Propertyv2.cluster	+	'in::ln_propertyV2::deed'; // these files contain mortgage records 
		export	LNDeedRepl								:=	LN_Propertyv2.cluster	+	'in::ln_propertyV2::deed_repl'; // these files contain mortgage records 
		
		export	LNMortgage								:=	LN_Propertyv2.cluster	+	'in::ln_propertyV2::mortgage';
		export	LNMortgageRepl						:=	LN_Propertyv2.cluster	+	'in::ln_propertyV2::mortgage_repl';
		
		export	LNAssessmentSearch				:=	LN_Propertyv2.cluster	+	'in::ln_propertyV2::assessor_search';
		export	LNAssessmentReplSearch		:=	LN_Propertyv2.cluster	+	'in::ln_propertyV2::assessor_repl_search';
		export	LNDeedSearch							:=	LN_Propertyv2.cluster	+	'in::ln_propertyV2::deed_search';
		export	LNDeedReplSearch					:=	LN_Propertyv2.cluster	+	'in::ln_propertyV2::deed_repl_search';
		export	LNMortgageSearch					:=	LN_Propertyv2.cluster	+	'in::ln_propertyV2::mortgage_search';
		export	LNMortgageReplSearch			:=	LN_Propertyv2.cluster	+	'in::ln_propertyV2::mortgage_repl_search';
		export	LNSearch									:=	LN_Propertyv2.cluster	+	'in::ln_propertyV2::search';
		export	LNSearchRepl							:=	LN_Propertyv2.cluster	+	'in::ln_propertyV2::search_repl';
		
		export	LNAssessmentAddlNames			:=	LN_Propertyv2.cluster	+	'in::ln_propertyV2::assessor_addl_names';
		export	LNAssessmentReplAddlNames	:=	LN_Propertyv2.cluster	+	'in::ln_propertyV2::assessor_repl_addl_names';
		export	LNDeedAddlNames						:=	LN_Propertyv2.cluster	+	'in::ln_propertyV2::deed_addl_names';
		export	LNDeedReplAddlNames				:=	LN_Propertyv2.cluster	+	'in::ln_propertyV2::deed_repl_addl_names';
		export	LNMortgageAddlNames				:=	LN_Propertyv2.cluster	+	'in::ln_propertyV2::mortgage_addl_names';
		export	LNMortgageReplAddlNames		:=	LN_Propertyv2.cluster	+	'in::ln_propertyV2::mortgage_repl_addl_names';
		export	LNAddlNames								:=	LN_Propertyv2.cluster	+	'in::ln_propertyV2::addl_names';
		export	LNAddlNamesRepl						:=	LN_Propertyv2.cluster	+	'in::ln_propertyV2::addl_names_repl';
		
		export	LNAssessmentAddlLegal			:=	LN_Propertyv2.cluster	+	'in::ln_propertyV2::assessor_addl_legal';
		export	LNAssessmentReplAddlLegal	:=	LN_Propertyv2.cluster	+	'in::ln_propertyV2::assessor_repl_addl_legal';
		export	LNDeedAddlLegal						:=	LN_Propertyv2.cluster	+	'in::ln_propertyV2::deed_addl_legal';
		export	LNDeedReplAddlLegal				:=	LN_Propertyv2.cluster	+	'in::ln_propertyV2::deed_repl_addl_legal';
		export	LNAddlLegal								:=	LN_Propertyv2.cluster	+	'in::ln_propertyV2::addl_legal';
		export	LNAddlLegalRepl						:=	LN_Propertyv2.cluster	+	'in::ln_propertyV2::addl_legal_repl';
	end;
	
	export	Base	:=
	module
		export	AddlFaresDeed			:=	LN_Propertyv2.cluster	+	'base::ln_propertyV2::addl::fares_deed';
		export	AddlFaresTax			:=	LN_Propertyv2.cluster	+	'base::ln_propertyV2::addl::fares_tax';
		export	AddlLegal					:=	LN_Propertyv2.cluster	+	'base::ln_propertyV2::addl::legal';
		export	AddlNames					:=	LN_Propertyv2.cluster	+	'base::ln_propertyV2::addl::ln_names';
		export	AddlNameInfo			:=	LN_Propertyv2.cluster	+	'base::ln_propertyV2::addl::name_info';
		export	Assessment				:=	LN_Propertyv2.cluster	+	'base::ln_propertyV2::assesor';
		export	DeedMortgage			:=	LN_Propertyv2.cluster	+	'base::ln_propertyV2::deed';
		export	Search						:=	LN_Propertyv2.cluster	+	'base::ln_propertyV2::search';
	end;
	
end;