IMPORT ut;
EXPORT FileNames := MODULE
	
	EXPORT rawCluster 	:= 	'~';//ut.foreign_prod;
	EXPORT prepCluster	:= 	'~thor_data400::';
	EXPORT baseCluster	:=	'~thor_data400::';
	EXPORT keyCluster		:=  '~';
	EXPORT exprtCluster := 	'~thor_data400::';
	
	EXPORT fullKeyBuildPrefix := //'ln_propertyv2';			//Option 1
														   'property_fast';			 //Option 2 (use for testing!)
														
	EXPORT raw	:= MODULE
			EXPORT OKC := MODULE
				EXPORT prefix						:= 'thor_data::in::ln_propertyv2::raw::okc::';
				EXPORT assessment				:= rawCluster + prefix + 'assessment';
				EXPORT assessment_repl	:= rawCluster + prefix + 'assessment_repl';
				EXPORT deed							:= rawCluster + prefix + 'deed';
				EXPORT deed_repl				:= rawCluster + prefix + 'deed_repl';
				EXPORT mortgage					:= rawCluster + prefix + 'mortgage';
				EXPORT mortgage_repl		:= rawCluster + prefix + 'mortgage_repl';
			END;
			EXPORT BK := MODULE
				EXPORT prefix						:= 'thor_data::in::ln_propertyv2::raw::bk::';
				EXPORT assessment				:= rawCluster + prefix + 'assessment';
				EXPORT assessment_repl	:= rawCluster + prefix + 'assessment_repl';
				EXPORT deed							:= rawCluster + prefix + 'deed';
				EXPORT deed_repl				:= rawCluster + prefix + 'deed_repl';
				EXPORT mortgage					:= rawCluster + prefix + 'mortgage';
				EXPORT mortgage_repl		:= rawCluster + prefix + 'mortgage_repl';
			END;
			EXPORT FRS := MODULE
				EXPORT prefix						:= 'thor_data400::in::property::raw::frs::';
				EXPORT assessment				:= rawCluster + prefix + 'assessment';
				EXPORT assessment_ptu		:= rawCluster + prefix + 'assessment_ptu';
				EXPORT deed							:= rawCluster + prefix + 'deed';
			END;
	//Black Knight Assignments and Release		
			EXPORT BK_AR	:= MODULE
				EXPORT prefix						:= 'thor_data400::base::BKMortgage::';
				EXPORT assignment				:= rawCluster + prefix + 'Assignment';
				EXPORT release					:= rawCluster + prefix + 'Release';
			END;
	END;
	EXPORT prep := MODULE
			EXPORT prefix 		:= 'prep::property_fast::';
			EXPORT assessment	:= prepCluster + prefix+ 'assessment';
			EXPORT deed_mortg	:= prepCluster + prefix+ 'deed_mortage';
			EXPORT addl_names	:= prepCluster + prefix+ 'addl_names';
			EXPORT addl_legal	:= prepCluster + prefix+ 'addl_legal';
			EXPORT addl_frs_a	:= prepCluster + prefix+ 'addl_frs_assessment';
			EXPORT addl_frs_d	:= prepCluster + prefix+ 'addl_frs_deed_mortgage';
			EXPORT search_prp	:= prepCluster + prefix+ 'search';
			EXPORT search_hst	:= prepCluster + prefix+ 'hist_search_reclean';
			EXPORT addl_name_info	:= prepCluster + prefix+ 'addl_name_info';
	END;
	EXPORT base := MODULE // These are the QA / latest delta base files. See below "baseFull"
			EXPORT prefix			:= 'base::property_fast::';
			EXPORT assessment	:= baseCluster + prefix+ 'assessment';
			EXPORT deed_mortg	:= baseCluster + prefix+ 'deed_mortgage';
			EXPORT addl_names	:= baseCluster + prefix+ 'addl::ln_names';
			EXPORT addl_legal	:= baseCluster + prefix+ 'addl::legal';
			EXPORT addl_frs_a	:= baseCluster + prefix+ 'addl_frs_assessment';
			EXPORT addl_frs_d	:= baseCluster + prefix+ 'addl_frs_deed_mortgage';
			EXPORT search_prp	:= baseCluster + prefix+ 'search';
			EXPORT addl_name_info	:= baseCluster + prefix+ 'addl::name_info';
	END;
	  EXPORT baseFull := MODULE
			SHARED versionSuffix := ''
						  //+ '_20150312' // comment or use this line to sandbox a referenes to a specific FULL build version
							;
      EXPORT prefix     := 'base::ln_propertyv2::';
      EXPORT assessment := baseCluster + prefix+ 'assesor'+versionSuffix;
      EXPORT deed_mortg	:= baseCluster + prefix+ 'deed'+versionSuffix;
			EXPORT addl_names	:= baseCluster + prefix+ 'addl::ln_names'+versionSuffix;
			EXPORT addl_legal	:= baseCluster + prefix+ 'addl::legal'+versionSuffix;
			EXPORT addl_frs_a	:= baseCluster + prefix+ 'addl::fares_tax'+versionSuffix;
			EXPORT addl_frs_d	:= baseCluster + prefix+ 'addl::fares_deed'+versionSuffix;
			EXPORT search_prp	:= baseCluster + prefix+ 'search'+versionSuffix;
			EXPORT addl_name_info	:= baseCluster + prefix+ 'addl::name_info'+versionSuffix;
			//EXAMPLE '~thor_data400::base::ln_propertyv2::search_20150121'
  END;
	EXPORT exprt := MODULE
			EXPORT prefix 		:= 'out::property_fast::export::';
			EXPORT assessment	:= exprtCluster + prefix+ 'assessment';
			EXPORT deed_mortg	:= exprtCluster + prefix+ 'deed_mortage';
			EXPORT addl_names	:= exprtCluster + prefix+ 'addl_names';
			EXPORT addl_legal	:= exprtCluster + prefix+ 'addl_legal';
			EXPORT search_prp	:= exprtCluster + prefix+ 'search';
			EXPORT addl_name_info	:= exprtCluster + prefix+ 'addl_name_info';
	END;
	EXPORT basedelta := MODULE // These are the QA / latest delta base files. See below "baseFull"
			EXPORT prefix			:= 'base::property_fast::';
			EXPORT assessment	:= baseCluster + prefix+ 'assessment::delta';
			EXPORT deed_mortg	:= baseCluster + prefix+ 'deed_mortgage::delta';
			EXPORT addl_names	:= baseCluster + prefix+ 'addl::ln_names::delta';
			EXPORT addl_legal	:= baseCluster + prefix+ 'addl::legal::delta';
			EXPORT addl_frs_a	:= baseCluster + prefix+ 'addl_frs_assessment::delta';
			EXPORT addl_frs_d	:= baseCluster + prefix+ 'addl_frs_deed_mortgage::delta';
			EXPORT search_prp	:= baseCluster + prefix+ 'search::delta';
			EXPORT addl_name_info	:= baseCluster + prefix+ 'addl::name_info::delta';
	END;
END;
//LN_PropertyV2.File_Assessment
//LN_PropertyV2.File_Deed
//LN_PropertyV2.File_addl_Fares_tax
//LN_PropertyV2.File_addl_legal
//LN_PropertyV2.File_addl_fares_deed
//LN_PropertyV2.File_ln_deed_addlnames
//LN_PropertyV2.File_Search_DID