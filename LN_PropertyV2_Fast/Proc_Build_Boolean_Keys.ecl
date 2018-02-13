import text_search,ln_propertyv2,roxiekeybuild;

//DF-20926 - Build boolean keys with dummy assessment base file w/ 1 record when PropertyV2 delta build creates an empty assessment base file.
MAC_Setup_InputFile(isFast, useDummyFile):= FUNCTIONMACRO

	#UNIQUENAME(Layout_Property_A_Extract)
	#UNIQUENAME(main_rec)
	
			%Layout_Property_A_Extract% := LN_PropertyV2.Layout_Property_A_Extract;
			%main_rec% := record
					LN_PropertyV2.layout_property_common_model_base;
					string5 source_code;
					%Layout_Property_A_Extract%.legal_lot_desc;
					%Layout_Property_A_Extract%.ownership_type_desc;
					%Layout_Property_A_Extract%.standardized_land_use_desc;
					%Layout_Property_A_Extract%.mortgage_loan_type_desc;
					%Layout_Property_A_Extract%.mortgage_lender_type_desc;
					%Layout_Property_A_Extract%.tax_exemption1_desc;
					%Layout_Property_A_Extract%.tax_exemption2_desc;
					%Layout_Property_A_Extract%.tax_exemption3_desc;
					%Layout_Property_A_Extract%.tax_exemption4_desc;
					%Layout_Property_A_Extract%.neighborhood_desc;
					%Layout_Property_A_Extract%.document_type_desc;
					%Layout_Property_A_Extract%.sales_price_desc;
			end;
		#UNIQUENAME(ds_main)
			
			%ds_main% := 	DATASET([{'X','','F'/*vendor_source_flag*/,'','','','','','','','','','',''/*assessee_ownership_rights_code;*/,
															'','','','','','','','','','','','','','','','','X'/*legal_lot_code*/,'',
															'','','','','','','','','','','','','','','X'/*ownership_type_code*/,'','','','','X'/*standardized_land_use_code*/,
															'','','','','','','','','','X'/*document_type*/,'','X'/*sales_price_code*/,'','X'/*mortgage_loan_type_code*/,
															'','X'/*mortgage_lender_type_code*/,'','','','','','','','','','','','','','X'/*tax_exemption1_code*/,
															'X'/*tax_exemption2_code*/,'X'/*tax_exemption3_code*/,'X'/*tax_exemption4_code*/,'','','',''/*tax_delinquent_year*/,
															'','','','','','','','','','','','',''/*land_dimensions*/,'','','','','','','','','','','',''/*building_area5_indicator*/,
															'','','','','','','','','','','','','','','','','','','','','','','','','','','','',''/*sewer_code*/,
															'','','','','','','','','',''/*site_influence1_code*/,
															'','','','','','','','','',''/*amenities2_code1*/,
															'','','','','','','','','',''/*extra_features3_indicator*/,
															'','','','','','','','','',''/*other_impr_building3_indicator*/,
															'','','','','','','','','X'/*neighborhood_code*/,''/*condo_project_or_building_name*/,
															'','','','','','','','','',''/*ln_ownership_rights*/,
															'','','','','','','','','',''/*ln_floor_cover*/,
															'','','','',''/*ln_old_apn_indicator*/,
															'OKCTY'/*source_code*/,
															'','','','','','','','','','','',''}],
														// '','','','TRADE','','RAILROAD','RAILROAD','RAILROAD','RAILROAD','','','PRICE NOT AVAILABLE'}],
														%main_rec%);

		#UNIQUENAME(ds)

	#IF(useDummyFile)  																							
			%ds% := project(%ds_main%, transform(%Layout_Property_A_Extract%, self:=left, self:=[]));
	#ELSE
			%ds% := LN_PropertyV2_Fast.File_Property_A_Extract(isFast); 
	#END

	RETURN %ds%;
	
ENDMACRO;


EXPORT Proc_Build_Boolean_Keys(string filedate, boolean isFast) := FUNCTION

	delta_rec_exist := exists(LN_PropertyV2_Fast.Files.base.assessment);
	useDummyFile := IF(isFast AND NOT delta_rec_exist, TRUE, FALSE);
	superKeyPrefix := if (isFast,'property_fast','ln_propertyV2');	
	STRING stem := '~THOR_DATA400';
	STRING sourceType := superKeyPrefix+'::assessment';
	info := Text_Search.FileName_Info_Instance(stem, sourceType, filedate);

	ds := IF(useDummyFile,MAC_Setup_InputFile(isFast,TRUE),MAC_Setup_InputFile(isFast,FALSE));

	APost := LN_PropertyV2.Property_APosting(ds); 
	AFile := APost.Prop_A_File; 
	posting := 	APost.postings;
	segList := 	APost.SegmentMetaData;
	externalKeys :=APost.ExternalKeys;
	
	kwd  := Text_Search.KeywordingFunc(info);
	bld := Text_Search.Build_From_Inversion(info, posting, kwd, FALSE, FALSE, TRUE, segList,externalKeys);

	inlkeyname := '~thor_data400::key::'+superKeyPrefix+'::assessment::'+filedate+'::doc.fares_id';
	inskeyname := '~thor_data400::key::'+superKeyPrefix+'::assessment::qa::doc.fares_id';
	
	Roxiekeybuild.Mac_SK_BuildProcess_v2_local(
												LN_PropertyV2_Fast.Key_Assessment_Map(AFile),
												'superkey',
												inlkeyname,
												build_key
												);
												
	retval := sequential(
									bld,
									build_key,
									Text_Search.Boolean_Move_To_QA(inskeyname,inlkeyname)
									);
	return retval;
	
	END; 