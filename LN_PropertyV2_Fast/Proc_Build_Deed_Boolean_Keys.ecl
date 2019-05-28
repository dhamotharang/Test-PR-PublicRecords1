import text_search,ln_propertyv2,roxiekeybuild;

//DF-23330 - Build boolean keys with dummy deed base file w/ 1 record when PropertyV2 delta build creates an empty deed base file.
MAC_Setup_InputFile_Deed(isFast, useDummyFile):= FUNCTIONMACRO

			#UNIQUENAME(Layout_Property_DM_Extract)
			#UNIQUENAME(main_rec)
	
			%Layout_Property_DM_Extract% := LN_PropertyV2.Layout_Property_DM_Extract;
			%main_rec% := record
					string5 source_code;
					%Layout_Property_DM_Extract%.legal_lot_desc;
					%Layout_Property_DM_Extract%.document_type_desc;
					%Layout_Property_DM_Extract%.hawaii_condo_cpr_desc;
					%Layout_Property_DM_Extract%.sales_price_desc;
					%Layout_Property_DM_Extract%.assessment_match_land_use_desc;
					%Layout_Property_DM_Extract%.property_use_desc;
					%Layout_Property_DM_Extract%.condo_desc_in;
					%Layout_Property_DM_Extract%.first_td_lender_type_desc;
					%Layout_Property_DM_Extract%.second_td_lender_type_desc;
					%Layout_Property_DM_Extract%.first_td_loan_type_desc;
					%Layout_Property_DM_Extract%.record_type_desc;
					%Layout_Property_DM_Extract%.type_financing_desc;		
					%Layout_Property_DM_Extract%.buyer_vesting_desc;
					%Layout_Property_DM_Extract%.buyer_1_id_desc;
					%Layout_Property_DM_Extract%.buyer_2_id_desc;
					%Layout_Property_DM_Extract%.borrower_vesting_desc;
					%Layout_Property_DM_Extract%.borrower_1_id_desc;
					%Layout_Property_DM_Extract%.borrower_2_id_desc;
					%Layout_Property_DM_Extract%.seller_1_id_desc;
					%Layout_Property_DM_Extract%.seller_2_id_desc;
			end;
			
			#UNIQUENAME(ds_main)			
			%ds_main% := 	DATASET([{	'X','X','X','X','X','X','X','X','X','X'/*second_td_lender_type_desc*/,
																			'X','X','X','X','X','X','X','X','X','X'/*seller_1_id_desc*/,
																			'X'}],
																	%main_rec%);

		#UNIQUENAME(ds)
		#IF(useDummyFile)  																							
				%ds% := project(%ds_main%, transform(%Layout_Property_DM_Extract%, self:=left, self:=[]));
		#ELSE
				%ds% := LN_PropertyV2_Fast.File_Property_DM_Extract(isFast); 
		#END

		RETURN %ds%;
	
ENDMACRO;

export Proc_Build_Deed_Boolean_Keys(string filedate, boolean isFast) := function

	//DF-23330 determine if there is a deed base file
	delta_rec_exist := exists(LN_PropertyV2_Fast.Files.base.deed_mortg);
	useDummyFile := IF(isFast AND NOT delta_rec_exist, TRUE, FALSE);
	
	superKeyPrefix := if (isFast,'property_fast','ln_propertyV2');
	
	STRING stem := '~THOR_DATA400';
	STRING sourceType := superKeyPrefix+'::deeds';	
	info := Text_Search.FileName_Info_Instance(stem, sourceType, filedate);

	//Cannot pass in useDummy as input file b/c it causes compilation error
	ds := IF(useDummyFile,MAC_Setup_InputFile_Deed(isFast,TRUE),MAC_Setup_InputFile_Deed(isFast,FALSE));

	DMPost := LN_PropertyV2.Property_DMPosting(ds); // no reference to specific input files
	dmFile := DMPost.Prop_DM_File;
	posting := DMPost.postings;
	segList := DMPost.SegmentMetaData;
	externalKeys :=DMPost.ExternalKeys;
	
	kwd  := Text_Search.KeywordingFunc(info);
	bld := Text_Search.Build_From_Inversion(info, posting, kwd, FALSE, FALSE, TRUE, segList,externalKeys);
	
	inlkeyname := '~thor_data400::key::'+superKeyPrefix+'::deeds::'+filedate+'::doc.fares_id';
	inskeyname := '~thor_data400::key::'+superKeyPrefix+'::deeds::qa::doc.fares_id';
	
	Roxiekeybuild.Mac_SK_BuildProcess_v2_local(
												LN_PropertyV2_Fast.Key_DM_Map(dmFile),
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
end;
