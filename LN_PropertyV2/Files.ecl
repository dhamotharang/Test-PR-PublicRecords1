import Data_services, ut; 

EXPORT	Files	:=
module
	// Raw vendor file definitions
	export	In	:=
	module
		// Assessments file
		export	LNAssessment			:=	dataset(ln_propertyV2.filenames.In.LNAssessment			,ln_propertyv2.Layout_Prep.In.AssessmentPayload,thor);
		export	LNAssessmentRepl	:=	dataset(ln_propertyV2.filenames.In.LNAssessmentRepl	,ln_propertyv2.Layout_Prep.In.AssessmentPayload,thor,opt);
		
		// Deeds file
		export	LNDeed						:=	dataset(ln_propertyV2.filenames.In.LNDeed			,ln_propertyv2.Layout_Prep.In.DeedPayload,thor);
		export	LNDeedRepl				:=	dataset(ln_propertyV2.filenames.In.LNDeedRepl	,ln_propertyv2.Layout_Prep.In.DeedPayload,thor,opt);
		
		// Mortgage file
		export	LNMortgage				:=	dataset(ln_propertyV2.filenames.In.LNMortgage			,ln_propertyv2.Layout_Prep.In.MortgagePayload,thor);
		export	LNMortgageRepl		:=	dataset(ln_propertyV2.filenames.In.LNMortgageRepl	,ln_propertyv2.Layout_Prep.In.MortgagePayload,thor,opt);
	end;
	
	// Prep file definitions
	export	Prep	:=
	module
		export	LNAssessment			:=	dataset(ln_propertyV2.filenames.Prep.LNAssessment				,LN_PropertyV2.Layouts.PreProcess_Assessor_Layout,thor);
		export	LNAssessmentRepl	:=	dataset(ln_propertyV2.filenames.Prep.LNAssessmentRepl		,LN_PropertyV2.Layouts.PreProcess_Assessor_Layout,thor);
		
		export	LNDeed     				:=	dataset(ln_propertyV2.filenames.Prep.LNDeed							,LN_PropertyV2.Layouts.PreProcess_Deed_Layout,thor);
		export	LNDeedRepl 				:=	dataset(ln_propertyV2.filenames.Prep.LNDeedRepl					,LN_PropertyV2.Layouts.PreProcess_Deed_Layout,thor);
		
		export	LNMortgage     		:=	dataset(ln_propertyV2.filenames.Prep.LNMortgage					,LN_PropertyV2.Layouts.PreProcess_Deed_Layout,thor);
		export	LNMortgageRepl 		:=	dataset(ln_propertyV2.filenames.Prep.LNMortgageRepl			,LN_PropertyV2.Layouts.PreProcess_Deed_Layout,thor);
		
		// export	LNDeedMortgage		:=	dataset(ln_propertyV2.filenames.Prep.LNDeedMortgage			,LN_PropertyV2.Layout_Deed_Mortgage_Common_Model_BASE,thor);
		// export	LNDeedMortgageRepl:=	dataset(ln_propertyV2.filenames.Prep.LNDeedMortgageRepl	,LN_PropertyV2.Layout_Deed_Mortgage_Common_Model_BASE,thor);
		
		export	LNAddlNames 			:=	dataset(ln_propertyV2.filenames.Prep.LNAddlNames				,LN_PropertyV2.Layout_Addl_Names,thor);
		export	LNAddlNamesRepl		:=	dataset(ln_propertyV2.filenames.Prep.LNAddlNamesRepl		,LN_PropertyV2.Layout_Addl_Names,thor);
		
		export	LNAddllegal 			:=	dataset(ln_propertyV2.filenames.Prep.LNAddllegal				,LN_PropertyV2.Layout_Addl_legal,thor);
		export	LNAddllegalRepl		:=	dataset(ln_propertyV2.filenames.Prep.LNAddllegalRepl		,LN_PropertyV2.Layout_Addl_legal,thor);
		
		export	LNSearch					:=	dataset(ln_propertyV2.filenames.Prep.LNSearch						,LN_PropertyV2.Layout_Deed_Mortgage_Property_Search,thor); 
		export	LNSearchRepl			:=	dataset(ln_propertyV2.filenames.Prep.LNSearchRepl				,LN_PropertyV2.Layout_Deed_Mortgage_Property_Search,thor);
	end;
	
	// Base file definitions
	export	Base	:=
	module
		export	AddlFaresDeed	:=	dataset(ln_propertyV2.filenames.Base.AddlFaresDeed,LN_PropertyV2.Layout_Addl_Fares_Deed									                ,thor);
		export	AddlFaresTax	:=	dataset(ln_propertyV2.filenames.Base.AddlFaresTax	,LN_PropertyV2.Layout_Addl_Fares_Tax									                ,thor);
		export	AddlLegal			:=	dataset(ln_propertyV2.filenames.Base.AddlLegal		,LN_PropertyV2.Layout_Addl_Legal											                ,thor);
		export	AddlNames			:=	dataset(ln_propertyV2.filenames.Base.AddlNames		,LN_PropertyV2.Layout_Addl_Names											                ,thor);
		export	AddlNameInfo	:=	dataset(ln_propertyV2.filenames.Base.AddlNameInfo	,LN_PropertyV2.layout_addl_name_info																	,thor);
		export	Assessment		:=	dataset(ln_propertyV2.filenames.Base.Assessment		,LN_PropertyV2.Layouts.layout_property_common_model_base_scrubs			  ,thor);
	  export	DeedMortgage	:=	dataset(ln_propertyV2.filenames.Base.DeedMortgage	,LN_PropertyV2.Layouts.layout_deed_mortgage_common_model_base_scrubs	,thor);
		export	Search				:=	dataset(ln_propertyV2.filenames.Base.Search				,LN_PropertyV2.Layout_Deed_Mortgage_Property_Search		                ,thor);
	end;

end;