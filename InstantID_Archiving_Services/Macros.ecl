IMPORT Doxie, ut;
EXPORT Macros := MODULE

	EXPORT mac_build_GetAndMassageSoapCall(selectStmt, ds_single_value, response_layout,  
						 record_layout, dGateways) := FUNCTIONMACRO 
						
		ds_delta_qry := dataset([{selectStmt, ds_single_value, false}], {Layouts.delta_input});

		response_layout FailSoapY(Layouts.delta_input  ds) := TRANSFORM
				self.ExceptionMessage := FAILMESSAGE;
				self := ds ;
				self := [];
		END;
		gateway_url := dGateways(StringLib.StringToLowerCase(servicename) = 'iid_archive')[1].url;
		
		soap_results := SOAPCALL(ds_delta_qry,
										gateway_url,
										'DeltaBasePreparedSql',
										{ds_delta_qry},
										Transforms.xToSelf(left , dGateways),
										DATASET(response_layout),
										xpath('DeltaBaseSelectResponse'),
										onFail(FailSoapY(left)),
										RETRY(0), TIMEOUT(60));
		
    response_layout blankrow() := transform
			SELF.exceptionmessage := 'no url';
			self := [];
		end;
	
	  soap_info := MAP(gateway_url != '' => soap_results, DATASET([blankrow()]));
		
		iesp.share.t_WsException exceptionsS(response_layout l) := TRANSFORM
				SELF.source := 'ROXIE';
				SELF.code := 0;
				SELF.location := 'WsDeltaBase';
				url_error := if(gateway_url = '',  Doxie.ErrorCodes(301), '');
				db_error := if(l.ExceptionMessage != '', Doxie.ErrorCodes(0), '');
				SELF.message := if(url_error != '', url_error, if(db_error != '', db_error, ''));//USE l.ExceptionMessage for debugging to see actual SQL error
				self := [];
			END;		
		record_layout xfm_soapErrors(response_layout L) := TRANSFORM
						SELF.Exceptions :=PROJECT( project(l, exceptionsS(LEFT)), 
								TRANSFORM(iesp.share.t_ResponseHeader, SELF.exceptions := LEFT, SELF := []));
						SELF := []; 
		END;

		ds_records :=
			NORMALIZE(
				soap_info,
				LEFT.Response,
				TRANSFORM( record_layout,
					SELF :=RIGHT,
					SELF := [] //exceptions
					));			
		ds_of_Exceptions :=	DATASET(PROJECT(soap_info[1], xfm_soapErrors(LEFT)));	
		
		ErrMsg := soap_info[1].exceptionmessage != '';
		
		ds_output := map(ErrMsg = TRUE => ds_of_Exceptions, ds_records);
		Return ds_output;
	ENDMACRO;	
	
	EXPORT mac_build_GetAndMassageIIDI2SoapCall(selectStmt, ds_single_value, response_layout,
						 record_layout, dGateways) := FUNCTIONMACRO 
						
		ds_delta_qry := dataset([{selectStmt, ds_single_value, false}], {Layouts.uni_delta_input});

		response_layout FailSoapY(Layouts.uni_delta_input  ds) := TRANSFORM
				self.ExceptionMessage := FAILMESSAGE;
				self := ds ;
				self := [];
		END;
		gateway_url := dGateways(StringLib.StringToLowerCase(servicename) = 'iid_archive')[1].url;
		
		soap_results := SOAPCALL(ds_delta_qry,
										gateway_url,
										'DeltaBasePreparedSql',
										{ds_delta_qry},
										Transforms.iidi2_xToSelf(left , dGateways),                          
										DATASET(response_layout),
										xpath('DeltaBaseSelectResponse'),
										onFail(FailSoapY(left)),
										RETRY(0), TIMEOUT(60)); 	
		
    response_layout blankrow() := transform
			SELF.exceptionmessage := 'no url';
			self := [];
		end;
	
	  soap_info := MAP(gateway_url != '' => soap_results, DATASET([blankrow()]));
		
		iesp.share.t_WsException exceptionsS(response_layout l) := TRANSFORM
				SELF.source := 'ROXIE';
				SELF.code := 0;
				SELF.location := 'WsDeltaBase';
				url_error := if(gateway_url = '',  Doxie.ErrorCodes(301), '');
				db_error := if(l.ExceptionMessage != '', Doxie.ErrorCodes(0), '');
				SELF.message := if(url_error != '', url_error, if(db_error != '', db_error, ''));//USE l.ExceptionMessage for debugging to see actual SQL error
				self := [];
			END;		
		record_layout xfm_soapErrors(response_layout L) := TRANSFORM
						SELF.Exceptions :=PROJECT( project(l, exceptionsS(LEFT)), 
								TRANSFORM(iesp.share.t_ResponseHeader, SELF.exceptions := LEFT, SELF := []));
						SELF := []; 
		END;

		ds_records :=
			NORMALIZE(
				soap_info,
				LEFT.Response,
				TRANSFORM( record_layout,
					SELF :=RIGHT,
					SELF := [] //exceptions
					));			
		ds_of_Exceptions :=	DATASET(PROJECT(soap_info[1], xfm_soapErrors(LEFT)));	
		
		ErrMsg := soap_info[1].exceptionmessage != '';
		
		ds_output := map(ErrMsg = TRUE => ds_of_Exceptions, ds_records);

		// output(soap_results);

		Return ds_output;
	ENDMACRO;

	EXPORT DATASET mac_GetCVISummary(ds_deduped, iesp_out_layout ) := FUNCTIONMACRO

		ds_cvi_cnts := table(ds_deduped, {cvi, cvicnt:=count(group)}, cvi); 
		cvi_tot := SUM(ds_cvi_cnts, cvicnt);		
		ds_all_cvi_types :=	 join(Constants.cviTypes, ds_cvi_cnts, 
		  left.cvi = (string3) RIGHT.cvi,
		 TRANSFORM(Layouts.cviInfo, 
										SELF.cvi := (STRING) LEFT.cvi, 
										SELF.cvi_cnt := if(LEFT.cvi = Constants.ForAll, cvi_tot, RIGHT.cvicnt),
										SELF.cvi_total := cvi_tot,
										SELF.order := LEFT.order),
		 LEFT OUTER, ATMOST(Constants.MAX_COUNT_RECORDS));
		ds_all_cvi_types_sorted := SORT(ds_all_cvi_types, order);	
		ds_cvi_base := project(ds_all_cvi_types_sorted, transform(iesp_out_layout, 
					SELF.Percent := (LEFT.cvi_cnt / LEFT.cvi_total) *100; 
					SELF.NumberOfCases := LEFT.cvi_cnt,
					SELF.ComprehensiveVerificationIndex := (string3) LEFT.cvi,
					self := [];));	
		RETURN ds_cvi_base;
	ENDMACRO;		

	EXPORT mac_GetCnts_withOrder(ds_just_type_cnts, ds_cvi_cnts, iesp_out_layout, ds_cvi_base, trans_cnt ) := FUNCTIONMACRO	
		//get the ALL row information and then SORT based on the percentages. The rest of rows will follow this sort
		ds_ALL_percents := PROJECT(ds_just_type_cnts,			
			TRANSFORM(iesp_out_layout, 
				SELF.CVI := Constants.ForAll,
				SELF.CNT := (INTEGER) LEFT.cnt,
				SELF.VALUE := LEFT.value,
				SELF.Percent := ((INTEGER) LEFT.Cnt / trans_cnt) *100,
				SELF.Order := 0,
				SELF.Description := LEFT.Description));
		//Need ALL to be ordered by Percent Descending
		ds_ALL_percents_sorted := SORT(ds_ALL_percents, -Percent, RECORD);
		//Set the order field
		iesp_out_layout AddIID_Order(iesp_out_layout L, INTEGER C):= TRANSFORM
				SELF.Order := c;
				SELF := L;
		END;
		//Add order to output
		ds_All_PercentsGetOrder := PROJECT(ds_ALL_percents_sorted, AddIID_Order(LEFT, COUNTER));
		//get all values from ALL and add them to all possible CVI values
		ds_All_output := JOIN(ds_All_PercentsGetOrder, Constants.cviTypes,
			TRUE,
			TRANSFORM(iesp_out_layout,
				SELF.CVI := RIGHT.cvi,
				SELF.Value := LEFT.Value,
				SELF.Percent := if(RIGHT.CVI = Constants.ForAll, LEFT.Percent, 0);
				SELF.Cnt := 0,
				self := left),
				LEFT OUTER, ALL, KEEP(Constants.MAX_COUNT_RECORDS));
		//Get Rows and make them in same sort order using the ALL sort 		
		ds_rowsWithOrder := JOIN(ds_cvi_cnts, ds_All_output,
			RIGHT.Cvi = LEFT.CVI AND 
			StringLib.StringToUppercase(RIGHT.Value) = StringLib.StringToUppercase(LEFT.Value),
				TRANSFORM(iesp_out_layout,
					SELF.Order := RIGHT.Order,
					SELF.Percent := if(RIGHT.CVI = Constants.ForAll, RIGHT.Percent,0);
					SELF.Cnt := LEFT.cvi_cnt,
					SELF.Description := RIGHT.Description,
					SELF.Value := RIGHT.Value,
					SELF.cvi := RIGHT.cvi),
					RIGHT OUTER);		
		//gets the percents for all the nonALL IVI values		
		ds_row_percents := JOIN(ds_cvi_base(ComprehensiveVerificationIndex != Constants.ForAll),	ds_rowsWithOrder(Cvi != Constants.ForAll),
			LEFT.ComprehensiveVerificationIndex = RIGHT.CVI,
			TRANSFORM(iesp_out_layout, 
				SELF.percent := ((INTEGER) RIGHT.cnt / (INTEGER) LEFT.NumberOfCases) *100,
				SELF := RIGHT),
				RIGHT OUTER);					
		//get the output together	
		ds_percent_for_all_rows := SORT(ds_All_PercentsGetOrder, cvi, order) + SORT(ds_row_percents, cvi, order);	
		//sort by order	
		//ds_rowsWithOrder_sorted := SORT(ds_percent_for_all_rows, cvi, order);			
		RETURN ds_percent_for_all_rows;
	ENDMACRO;	

EXPORT mac_GetCnts_nonRisk(ds_just_type_cnts, ds_cvi_cnts, iesp_out_layout, 
					ds_cvi_base, trans_cnt, ds_elements, ds_cvis ) := FUNCTIONMACRO	
		ds_ALL_percents := PROJECT(ds_just_type_cnts,			
			TRANSFORM(iesp_out_layout, 
				SELF.CVI := Constants.ForAll,
				SELF.CNT := (INTEGER) LEFT.cnt,
				SELF.VALUE := LEFT.value,
				SELF.Percent := ((INTEGER) LEFT.Cnt / trans_cnt) *100));
		//gets the percents for all the nonALL IVI values
		ds_row_percents := JOIN(ds_cvi_base(ComprehensiveVerificationIndex != Constants.ForAll),	ds_cvi_cnts	,
			left.ComprehensiveVerificationIndex = RIGHT.CVI,
			TRANSFORM(iesp_out_layout, 
				SELF.CVI := RIGHT.CVI,
				self.value := RIGHT.value;
				SELF.CNT := LEFT.NumberOfCases;
				SELF.percent := ((INTEGER) RIGHT.CVI_cnt / (INTEGER) LEFT.NumberOfCases) *100;
				), RIGHT OUTER);					
		ds_percent_for_all_rows := ds_ALL_percents + ds_row_percents;	
		//get all possiblities for the elements and CVI types
		ds_all_possibilities := JOIN(ds_elements, ds_cvis,
				TRUE,
				TRANSFORM(iesp_out_layout,
					SELF.CVI := RIGHT.cvi,
					SELF.Value := LEFT.Value,
					SELF.Description := LEFT.description,
					SELF.Order := RIGHT.Order,
					SELF := []),
					LEFT OUTER, ALL, KEEP(Constants.MAX_COUNT_RECORDS));
		//join all possibilites with actual data
		ds_output := JOIN(ds_all_possibilities, ds_percent_for_all_rows,
								LEFT.Value =  RIGHT.VALUE AND LEFT.Cvi = RIGHT.Cvi,
									TRANSFORM(iesp_out_layout, 
										SELF.Percent := Right.Percent,
										SELF.Description := LEFT.Description,
										SELF.CVI := LEFT.cvi,
										SELF.Order := LEFT.order,
										SELF.Value := LEFT.Value,
										SELF := [];),
								LEFT OUTER, ATMOST(Constants.MAX_COUNT_RECORDS));
		ds_output_sorted :=	SORT(ds_output, order, (INTEGER) value);			
			
		RETURN ds_output_sorted;
	ENDMACRO;	

	//gets the counts for the flexid verified report	
	EXPORT mac_GetVerfiedCnts(ds_verified_type, verified_type, verified_value, transactionCnt, ds_cvi_totals ) := FUNCTIONMACRO
		//total number of verified = 1 for this type
		tot := SUM(ds_verified_type, verified_type); 
		ds_outForVerifiedType_tmp := join(ds_verified_type, Constants.cviTypes,
			LEFT.CVI = (STRING3) RIGHT.CVI, 
			TRANSFORM(Layouts.rec_verify_summ,
				SELF.cvi := RIGHT.cvi,
				SELF.IdentityElementVerification := verified_value,
				self.cnt := if(RIGHT.CVI = Constants.ForAll, tot , LEFT.verified_type),
				self.percent := 0),
				RIGHT OUTER);
			ds_outForVerifiedType := JOIN(ds_outForVerifiedType_tmp, ds_cvi_totals,
				LEFT.CVI = RIGHT.ComprehensiveVerificationIndex,
				TRANSFORM(Layouts.rec_verify_summ, SELF.Percent := (LEFT.Cnt / RIGHT.NumberOfCases) * 100, SELF := LEFT),
				ATMOST(Constants.MAX_COUNT_RECORDS));
		RETURN ds_outForVerifiedType;
	ENDMACRO;
	
	EXPORT mac_GetiidiCounts(ds_src_info, transCnt, matching_sourceType) := FUNCTIONMACRO
		ds_src_counts := JOIN(ds_src_info, Constants.iidi_verifiedElements,
			 StringLib.StringToUppercase(LEFT.Name) = StringLib.StringToUppercase(RIGHT.Description),
				TRANSFORM(Layouts.rec_src_cnts, 
					SELF.FieldVerification := RIGHT.description, 
					//total number of verified = 1 for this type
					SELF.Percent := (LEFT.src_cnt / transCnt) * 100,
					SELF.Description := '';
					SELF.Value := matching_sourceType),
					RIGHT OUTER);
			RETURN 	ds_src_counts;
	ENDMACRO;
	
	EXPORT mac_GetIIDI2Counts(ds_src_info, transCnt, matching_sourceType, VerifiedLayout) := FUNCTIONMACRO
		ds_src_counts := JOIN(ds_src_info, VerifiedLayout,
			 StringLib.StringToUppercase(LEFT.Name) = StringLib.StringToUppercase(RIGHT.Description),
				TRANSFORM(Layouts.rec_src_cnts, 
					SELF.FieldVerification := RIGHT.description, 
					//total number of verified = 1 for this type
					SELF.Percent := (LEFT.src_cnt / transCnt) * 100,
					SELF.Description := '';
					SELF.Value := matching_sourceType),
					RIGHT OUTER);
			RETURN 	ds_src_counts;
	ENDMACRO;
	
	EXPORT mac_GetDisplayErrors(errorCode, output_layout) := FUNCTIONMACRO
		iesp.share.t_WsException SetException() := TRANSFORM
				SELF.source := 'ROXIE';
				SELF.message := doxie.ErrorCodes(errorCode);
				self := [];
			END;	
			
		iesp.share.t_ResponseHeader SetHeaderWithException() := TRANSFORM
				SELF.Exceptions := DATASET([SetException()]);
				SELF := []; 
		END;			
		ds_err_header := DATASET([SetHeaderWithException()]);		
		ds_err_headerResponse := PROJECT(ds_err_header, 
				TRANSFORM(output_layout, SELF._Header := LEFT, SELF := []));	
		RETURN ds_err_headerResponse;
	ENDMACRO;
		
	EXPORT mac_GetDisplayRowErrors(errorCode, output_layout) := FUNCTIONMACRO
		iesp.share.t_WsException SetException() := TRANSFORM
				SELF.source := 'ROXIE';
				SELF.message := errorCode;
				self := [];
			END;	
			
		iesp.share.t_ResponseHeader SetHeaderWithException() := TRANSFORM
				SELF.Exceptions := ROW(SetException());
				SELF := []; 
		END;			
		ds_err_header := ROW(SetHeaderWithException());		
			
		output_layout SetLayoutWithException() := TRANSFORM
				SELF._Header := ds_err_header;
				SELF := []; 
		END;			
		ds_err_layout := ROW(SetLayoutWithException());				
			
		RETURN ds_err_layout;
	ENDMACRO;	
		
	EXPORT mac_GetDisplayRowErrorsExceptions(errorCode, output_layout) := FUNCTIONMACRO
import Risk_Indicators;		
		iesp.share.t_WsException exceptionsS(output_layout l) := TRANSFORM
				SELF.source := 'ROXIE';
				SELF.code := 0;
				SELF.message := errorCode;//USE l.ExceptionMessage for debugging to see actual SQL error
				self := [];
			END;		
		output_layout xfm_soapErrors(output_layout L) := TRANSFORM
						SELF.Exceptions :=PROJECT( project(l, exceptionsS(LEFT)), 
								TRANSFORM(iesp.share.t_ResponseHeader, SELF.exceptions := LEFT, SELF := []));
						SELF := []; 
		END;
		DS := project(Risk_Indicators.iid_constants.ds_Record, transform(output_layout, self := []));
		ds_of_Exceptions :=	DATASET(PROJECT(DS[1], xfm_soapErrors(LEFT)));	
		
		ds_output := ds_of_Exceptions;
		RETURN  ds_output;
	ENDMACRO;
		
END;