IMPORT LN_PropertyV2_Fast as FP;
IMPORT LN_PropertyV2 as P2;
IMPORT LN_PropertyV2;
IMPORT ut;
EXPORT Files := MODULE

	SHARED getSuperOrBlank(returnDataset, superFileName, layout) := MACRO
			returnDataset := if(count(nothor(FileServices.SuperFileContents(superFileName)))=0,
							dataset([],layout),
							dataset(superFileName,layout,flat));
	ENDMACRO;

	export	oldIn	:= module
		
		export	LNAssessment			:=	PROJECT(dataset(ln_propertyV2.filenames.Prep.LNAssessment,LN_PropertyV2.Layout_Property_Common_Model_BASE
			-LN_PropertyV2_Fast.changeControl.epic.layoutNewFields.assessment,thor),
			TRANSFORM(LN_PropertyV2.Layout_Property_Common_Model_BASE,SELF := LEFT;SELF := []));
		export	LNAssessmentRepl	:=	PROJECT(dataset(ln_propertyV2.filenames.Prep.LNAssessmentRepl		,LN_PropertyV2.Layout_Property_Common_Model_BASE
			-LN_PropertyV2_Fast.changeControl.epic.layoutNewFields.assessment,thor),
			TRANSFORM(LN_PropertyV2.Layout_Property_Common_Model_BASE,SELF := LEFT;SELF := []));
		export	LNDeed     				:=	PROJECT(dataset(ln_propertyV2.filenames.Prep.LNDeed							,LN_PropertyV2.Layout_Deed_Mortgage_Common_Model_BASE
			-LN_PropertyV2_Fast.changeControl.epic.layoutNewFields.deed,thor),
			TRANSFORM(LN_PropertyV2.Layout_Deed_Mortgage_Common_Model_BASE,SELF := LEFT;SELF := []));
		export	LNDeedRepl 				:=	PROJECT(dataset(ln_propertyV2.filenames.Prep.LNDeedRepl					,LN_PropertyV2.Layout_Deed_Mortgage_Common_Model_BASE
			-LN_PropertyV2_Fast.changeControl.epic.layoutNewFields.deed,thor),
			TRANSFORM(LN_PropertyV2.Layout_Deed_Mortgage_Common_Model_BASE,SELF := LEFT;SELF := []));
		export	LNMortgage     		:=	PROJECT(dataset(ln_propertyV2.filenames.Prep.LNMortgage					,LN_PropertyV2.Layout_Deed_Mortgage_Common_Model_BASE
			-LN_PropertyV2_Fast.changeControl.epic.layoutNewFields.deed,thor),
			TRANSFORM(LN_PropertyV2.Layout_Deed_Mortgage_Common_Model_BASE,SELF := LEFT;SELF := []));
		export	LNMortgageRepl 		:=	PROJECT(dataset(ln_propertyV2.filenames.Prep.LNMortgageRepl			,LN_PropertyV2.Layout_Deed_Mortgage_Common_Model_BASE
			-LN_PropertyV2_Fast.changeControl.epic.layoutNewFields.deed,thor),
			TRANSFORM(LN_PropertyV2.Layout_Deed_Mortgage_Common_Model_BASE,SELF := LEFT;SELF := []));
		
		
		
		export	LNAddlNames 			:=	LN_PropertyV2.Files.Prep.LNAddlNames;
		export	LNAddlNamesRepl		:=	LN_PropertyV2.Files.Prep.LNAddlNamesRepl;
		export	LNAddllegal 			:=	LN_PropertyV2.Files.Prep.LNAddllegal;
		export	LNAddllegalRepl		:=	LN_PropertyV2.Files.Prep.LNAddllegalRepl;
				
		export	LNSearch					:=	PROJECT(LN_PropertyV2.Files.Prep.LNSearch, 
																					TRANSFORM(LN_PropertyV2_Fast.Layout_prep_search_prp-Append_ReplRecordInd,
																										SELF.ln_entity_type := ''; SELF.nid :=0; SELF := LEFT));
		export	LNSearchRepl			:=	PROJECT(LN_PropertyV2.Files.Prep.LNSearchRepl, 
																					TRANSFORM(LN_PropertyV2_Fast.Layout_prep_search_prp-Append_ReplRecordInd,
																										SELF.ln_entity_type := ''; SELF.nid :=0; SELF := LEFT));
		
		export 	File_Fares_Search_in := dataset(ut.foreign_prod+'thor_data400::in::ln_propertyv2::fares_search',LN_PropertyV2.Layout_Deed_Mortgage_Property_Search,flat);
		
	end;

	EXPORT raw := MODULE

		l:= LN_PropertyV2_Fast.Layout_Raw_Fares.Deed;
		getSuperOrBlank(d,LN_PropertyV2_Fast.FileNames.raw.frs.deed,l);
		EXPORT frs_deed := project(d,l);

		SHARED LN_PropertyV2_Fast.Layout_Raw_Fares.Assessment assignUpdateType(
						{LN_PropertyV2.Layout_Raw_Fares.Input_Assessor, string100 raw_file_name { virtual(logicalfilename)}} L, string updateType) := TRANSFORM
			SELF.update_type := updateType;
			SELF := L;
		END;
		
		//FARES
		l:= {LN_PropertyV2.Layout_Raw_Fares.Input_Assessor, string100 raw_file_name { virtual(logicalfilename)}};
		getSuperOrBlank(d,LN_PropertyV2_Fast.FileNames.raw.frs.assessment,l);
		EXPORT frs_assessment := project(d,assignUpdateType(LEFT,''));		
		
		l:= {LN_PropertyV2.Layout_Raw_Fares.Input_Assessor, string100 raw_file_name { virtual(logicalfilename)}};
		getSuperOrBlank(d,LN_PropertyV2_Fast.FileNames.raw.frs.assessment_ptu,l);
		EXPORT frs_assessment_ptu := project(d,assignUpdateType(LEFT,'PTU'));
		
		//OKC
		l:= {FP.Layout_raw_okc_deed, string100 raw_file_name { virtual(logicalfilename)}};
		getSuperOrBlank(d,LN_PropertyV2_Fast.FileNames.raw.okc.deed,l);
		EXPORT okc_deed := project(d,l);

		l:= {FP.Layout_raw_okc_deed, string100 raw_file_name { virtual(logicalfilename)}};
		getSuperOrBlank(d,LN_PropertyV2_Fast.FileNames.raw.okc.deed_repl,l);
		EXPORT okc_deed_repl := project(d,l);

		l:= {FP.Layout_raw_okc_mortgage, string100 raw_file_name { virtual(logicalfilename)}};
		getSuperOrBlank(d,LN_PropertyV2_Fast.FileNames.raw.okc.mortgage,l);
		EXPORT okc_mortgage := project(d,l);

		l:= {FP.Layout_raw_okc_mortgage, string100 raw_file_name { virtual(logicalfilename)}};
		getSuperOrBlank(d,LN_PropertyV2_Fast.FileNames.raw.okc.mortgage_repl,l);
		EXPORT okc_mortgage_repl := project(d,l);

		l:= {FP.Layout_raw_okc_assessment, string100 raw_file_name { virtual(logicalfilename)}};
		getSuperOrBlank(d,LN_PropertyV2_Fast.FileNames.raw.okc.assessment,l);
		EXPORT okc_assessment := project(d,l);

		l:= {FP.Layout_raw_okc_assessment, string100 raw_file_name { virtual(logicalfilename)}}; 
		getSuperOrBlank(d,LN_PropertyV2_Fast.FileNames.raw.okc.assessment_repl,l);
		EXPORT okc_assessment_repl := project(d,l);
		

		SHARED dataset getRawData(superFileName, in_layout) := FUNCTIONMACRO
			#uniquename(out_layout);
			%out_layout% := {in_layout, string100 raw_file_name { virtual(logicalfilename)}};
			return if(count(nothor(FileServices.SuperFileContents(superFileName)))=0,
							dataset([],%out_layout%),
							dataset(superFileName,%out_layout%,flat));
		ENDMACRO;
		
		// BK
		EXPORT bk_assessment			:= getRawData(LN_PropertyV2_Fast.FileNames.raw.bk.assessment,
																				 LN_PropertyV2_Fast.Layout_raw_okc_assessment					);
		
		EXPORT bk_assessment_repl	:= getRawData(LN_PropertyV2_Fast.FileNames.raw.bk.assessment_repl,
																				 LN_PropertyV2_Fast.Layout_raw_okc_assessment					);
																				 
		EXPORT bk_deed 						:= getRawData(LN_PropertyV2_Fast.FileNames.raw.bk.deed,
																				 LN_PropertyV2_Fast.Layout_raw_bk_deed								);
																				 
		EXPORT bk_deed_repl				:= getRawData(LN_PropertyV2_Fast.FileNames.raw.bk.deed_repl,
																				 LN_PropertyV2_Fast.Layout_raw_bk_deed								);
																				 
		EXPORT bk_mortgage				:= getRawData(LN_PropertyV2_Fast.FileNames.raw.bk.mortgage,
																				 LN_PropertyV2_Fast.Layout_raw_bk_mortgage						);
																				 
		EXPORT bk_mortgage_repl		:= getRawData(LN_PropertyV2_Fast.FileNames.raw.bk.mortgage_repl,
																				 LN_PropertyV2_Fast.Layout_raw_bk_mortgage						);


	END;
  EXPORT prep := MODULE
		l:= LN_PropertyV2_Fast.Layout_prep_assessment; getSuperOrBlank(d,LN_PropertyV2_Fast.FileNames.prep.assessment,l);
    EXPORT assessment := project(d,l);	
		l:= LN_PropertyV2_Fast.Layout_prep_deed_mortg; getSuperOrBlank(d,LN_PropertyV2_Fast.FileNames.prep.deed_mortg,l);
		EXPORT deed_mortg := project(d,l);
    EXPORT addl_names := dataset(LN_PropertyV2_Fast.FileNames.prep.addl_names,LN_PropertyV2_Fast.Layout_prep_addl_names, flat);
    EXPORT addl_legal := dataset(LN_PropertyV2_Fast.FileNames.prep.addl_legal,LN_PropertyV2_Fast.Layout_prep_addl_legal, flat);
    EXPORT addl_frs_a := dataset(LN_PropertyV2_Fast.FileNames.prep.addl_frs_a,LN_PropertyV2_Fast.Layout_prep_addl_frs_a, flat);
    EXPORT addl_frs_d := dataset(LN_PropertyV2_Fast.FileNames.prep.addl_frs_d,LN_PropertyV2_Fast.Layout_prep_addl_frs_d, flat);
		EXPORT addl_name_info := dataset(LN_PropertyV2_Fast.FileNames.prep.addl_name_info,LN_PropertyV2_Fast.Layout_prep_addl_name_info, flat);
		
		l:= LN_PropertyV2_Fast.Layout_prep_search_prp; getSuperOrBlank(d,LN_PropertyV2_Fast.FileNames.prep.search_prp,l);
		EXPORT search_prp := project(d,l);
		
		search_hst_p := dataset(LN_PropertyV2_Fast.FileNames.prep.search_hst,LN_PropertyV2.Layout_DID_Out, flat);
		EXPORT search_hst := project( search_hst_p, {recordof(search_hst_p),string1		Append_ReplRecordInd := 'N'});
  END;
	
	EXPORT base := MODULE
    EXPORT assessment := project(dataset(LN_PropertyV2_Fast.FileNames.base.assessment,
																				 LN_PropertyV2.Layouts.layout_property_common_model_base_scrubs,flat)
																				 ,LN_PropertyV2.layout_property_common_model_base);
    EXPORT deed_mortg := project(dataset(LN_PropertyV2_Fast.FileNames.base.deed_mortg,
																				 LN_PropertyV2.Layouts.layout_deed_mortgage_common_model_base_scrubs,flat)
																				 ,LN_PropertyV2.layout_deed_mortgage_common_model_base);
    EXPORT addl_names := dataset(LN_PropertyV2_Fast.FileNames.base.addl_names,LN_PropertyV2.layout_addl_names, flat);
    EXPORT addl_legal := dataset(LN_PropertyV2_Fast.FileNames.base.addl_legal,LN_PropertyV2.layout_addl_legal, flat);
    EXPORT addl_frs_a := dataset(LN_PropertyV2_Fast.FileNames.base.addl_frs_a,LN_PropertyV2.layout_addl_fares_tax, flat);
    EXPORT addl_frs_d := dataset(LN_PropertyV2_Fast.FileNames.base.addl_frs_d,LN_PropertyV2.layout_addl_fares_deed, flat);
    EXPORT search_prp := dataset(LN_PropertyV2_Fast.FileNames.base.search_prp,LN_PropertyV2.Layout_Did_Out, flat);
		EXPORT addl_name_info := dataset(LN_PropertyV2_Fast.FileNames.base.addl_name_info,LN_PropertyV2.layout_addl_name_info, flat,opt);
 END;

// DF-27847 basedelta
 	EXPORT basedelta := MODULE
    EXPORT assessment := project(dataset(LN_PropertyV2_Fast.FileNames.basedelta.assessment,
																				 LN_PropertyV2.Layouts.layout_property_common_model_base_scrubs,flat)
																				 ,LN_PropertyV2.layout_property_common_model_base);
    EXPORT deed_mortg := project(dataset(LN_PropertyV2_Fast.FileNames.basedelta.deed_mortg,
																				 LN_PropertyV2.Layouts.layout_deed_mortgage_common_model_base_scrubs,flat)
																				 ,LN_PropertyV2.layout_deed_mortgage_common_model_base);
    EXPORT addl_names := dataset(LN_PropertyV2_Fast.FileNames.basedelta.addl_names,LN_PropertyV2.layout_addl_names, flat);
    EXPORT addl_legal := dataset(LN_PropertyV2_Fast.FileNames.basedelta.addl_legal,LN_PropertyV2.layout_addl_legal, flat);
    EXPORT addl_frs_a := dataset(LN_PropertyV2_Fast.FileNames.basedelta.addl_frs_a,LN_PropertyV2.layout_addl_fares_tax, flat);
    EXPORT addl_frs_d := dataset(LN_PropertyV2_Fast.FileNames.basedelta.addl_frs_d,LN_PropertyV2.layout_addl_fares_deed, flat);
    EXPORT search_prp := dataset(LN_PropertyV2_Fast.FileNames.basedelta.search_prp,LN_PropertyV2.Layout_Did_Out, flat);
		EXPORT addl_name_info := dataset(LN_PropertyV2_Fast.FileNames.basedelta.addl_name_info,LN_PropertyV2.layout_addl_name_info, flat,opt);
 END;
/*
 	EXPORT exprt := MODULE
    EXPORT assessment := project(dataset(LN_PropertyV2_Fast.FileNames.base.assessment,
																				 LN_PropertyV2.Layouts.layout_property_common_model_base_scrubs,flat)
																				 ,LN_PropertyV2.layout_export_assessor_base);
    EXPORT deed_mortg := project(dataset(LN_PropertyV2_Fast.FileNames.base.deed_mortg,
																				 LN_PropertyV2.Layouts.layout_deed_mortgage_common_model_base_scrubs,flat)
																				 ,LN_PropertyV2.layout_export_deed_mortgage_base);
    EXPORT addl_names := dataset(LN_PropertyV2_Fast.FileNames.base.addl_names,LN_PropertyV2.layout_addl_names, flat);
    EXPORT addl_legal := dataset(LN_PropertyV2_Fast.FileNames.base.addl_legal,LN_PropertyV2.layout_addl_legal, flat);
    EXPORT search_prp := dataset(LN_PropertyV2_Fast.FileNames.base.search_prp,LN_PropertyV2.layout_export_property_search, flat);
	END;
*/
END;
