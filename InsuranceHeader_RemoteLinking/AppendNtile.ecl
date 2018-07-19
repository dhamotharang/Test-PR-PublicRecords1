EXPORT AppendNtile := MODULE
/*---------------------------------------------------------------------------------------*/ 
/* MODULE - AppendNtile                                                                  */
/*          Created By: Yesheng Guo                                                      */
/*          Created On: 20150908                                                         */
/*          Last Modified By: Yesheng Guo                                                */
/*          Last Modified On: 20150909                                                   */
/*---------------------------------------------------------------------------------------*/
/*---------------------------------------------------------------------------------------*/
/* INPUT   - InData:        recordset of any record structure                            */
/*         - FieldName:     name of the field in InData to create N-tile                 */
/*         - N:             number of tiles, eg. 100 for percentile, 4 for quartile, etc */
/*         - OutData:       name of output recordset                                     */
/*         - SummaryTable:  name of n-tile summary table based on record cnt             */
/* OUTPUT  - OutData:       InData with N-tile appended as the last fields               */
/*         - SummaryTable:  summary table shows cnt of records in each N-tile,           */
/*                          lower cut and upper cut of Field for each N-tile             */
/*---------------------------------------------------------------------------------------*/
	
	// This Macro returns n-tile based on sample rank order of the field. 
	EXPORT SampleCnt(InData, FieldName, N, OutData, SummaryTable) := MACRO
		#UNIQUENAME(InDataSorted)  %InDataSorted%  := SORT(InData,FieldName);
		#UNIQUENAME(InDataCount)   %InDataCount%   := COUNT(%InDataSorted%);
		#UNIQUENAME(OutDataLayout) %OutDataLayout% := RECORD RECORDOF(InData); unsigned2 Ntile_SampleCnt; END;
		#UNIQUENAME(AppendTSFM) %OutDataLayout% %AppendTSFM%(%InDataSorted% L, integer C) := TRANSFORM
			SELF.Ntile_SampleCnt := ROUNDUP(N*C/%InDataCount%);
			SELF := L;
		END;
		OutData := PROJECT(%InDataSorted%,%AppendTSFM%(LEFT,COUNTER));
		SummaryTable := SORT(TABLE(OutData,{Ntile_SampleCnt,cnt:= COUNT(GROUP),lowercut:=min(GROUP,FieldName),uppercut:=max(GROUP,FieldName)},Ntile_SampleCnt),Ntile_SampleCnt);
	ENDMACRO;
  
	// This Macro returns n-tile based on range of value in the field.
	EXPORT ValueRange(InData, FieldName, N, OutData, SummaryTable) := MACRO
		// #UNIQUENAME(InDataSorted)  %InDataSorted%  := SORT(InData,FieldName);
		#UNIQUENAME(FieldMax)      %FieldMax%      := MAX(InData,FieldName);
		#UNIQUENAME(FieldMin)      %FieldMin%      := MIN(InData,FieldName);
		#UNIQUENAME(FieldRange)    %FieldRange%    := %FieldMax%-%FieldMin%;
		#UNIQUENAME(OutDataLayout) %OutDataLayout% := RECORD RECORDOF(InData); unsigned2 Ntile_ValueRange; END;
		#UNIQUENAME(AppendTSFM) %OutDataLayout% %AppendTSFM%(InData L) := TRANSFORM
			SELF.Ntile_ValueRange := MIN(IF(ROUNDUP(N*(L.FieldName-%FieldMin%)/%FieldRange%)=0,1,ROUNDUP(N*(L.FieldName-%FieldMin%)/%FieldRange%)),N);
			SELF := L;
		END;
		OutData := PROJECT(InData,%AppendTSFM%(LEFT));
		SummaryTable := SORT(TABLE(OutData,{Ntile_ValueRange,cnt:= COUNT(GROUP),lowercut:=min(GROUP,FieldName),uppercut:=max(GROUP,FieldName)},Ntile_ValueRange),Ntile_ValueRange);
	ENDMACRO;
  
	// This Macro returns n-tile based on cumulative sum of the field.
	EXPORT CumSum(InData, FieldName, N, OutData, SummaryTable) := MACRO
		#UNIQUENAME(InDataSorted)  %InDataSorted%  := SORT(InData,FieldName);
		#UNIQUENAME(FieldMax)      %FieldMax%      := MAX(%InDataSorted%,FieldName);
		#UNIQUENAME(FieldMin)      %FieldMin%      := MIN(%InDataSorted%,FieldName);
		#UNIQUENAME(FieldRange)    %FieldRange%    := %FieldMax%-%FieldMin%;
		#UNIQUENAME(FieldSum)      %FieldSum%      := SUM(%InDataSorted%,(FieldName-%FieldMin%)/%FieldRange%);
		#UNIQUENAME(OutDataLayout) %OutDataLayout% := RECORD RECORDOF(InData); unsigned2 Ntile_CumSum; END;
		#UNIQUENAME(InitializeTSFM) {%OutDataLayout%; real Cumulative_Sum;} %InitializeTSFM%(%InDataSorted% L, integer C) := TRANSFORM
			SELF.Cumulative_Sum := 0;
			SELF.Ntile_CumSum := 0;
			SELF := L;
		END;
		#UNIQUENAME(OutDataAInitialized) %OutDataAInitialized% := PROJECT(%InDataSorted%,%InitializeTSFM%(LEFT,COUNTER));	
		#UNIQUENAME(IterateTSFM) {%OutDataLayout%; real Cumulative_Sum;} %IterateTSFM%(%OutDataAInitialized% L, %OutDataAInitialized% R) := TRANSFORM
			SELF.Cumulative_Sum := L.Cumulative_Sum + (R.FieldName-%FieldMin%)/%FieldRange%;
			SELF := R;
		END;
		#UNIQUENAME(OutDataIterated) %OutDataIterated% := ITERATE(%OutDataAInitialized%,%IterateTSFM%(LEFT,RIGHT));
		
		#UNIQUENAME(AppendTSFM) %OutDataLayout% %AppendTSFM%( %OutDataIterated% L) := TRANSFORM
			SELF.Ntile_CumSum := MIN(IF(ROUNDUP(N*L.Cumulative_Sum/%FieldSum%)=0,1,ROUNDUP(N*L.Cumulative_Sum/%FieldSum%)),N);
			SELF := L;
		END;
		OutData := PROJECT(%OutDataIterated%,%AppendTSFM%(LEFT));
		SummaryTable := SORT(TABLE(OutData,{Ntile_CumSum,cnt:= COUNT(GROUP),lowercut:=min(GROUP,FieldName),uppercut:=max(GROUP,FieldName)},Ntile_CumSum),Ntile_CumSum);
	ENDMACRO;
	
	// This Macro returns n-tile based on cumulative response in data sorted by the field.
	EXPORT CumResponse(InData, ResponseFieldName, SortFieldName, N, OutData, SummaryTable) := MACRO
		#UNIQUENAME(InDataSorted)  %InDataSorted%  := SORT(InData,SortFieldName);
		#UNIQUENAME(TotalResponse) %TotalResponse% := SUM(%InDataSorted%,ResponseFieldName);
		#UNIQUENAME(OutDataLayout) %OutDataLayout% := RECORD RECORDOF(InData); unsigned2 Ntile_Response; END;
		#UNIQUENAME(InitializeTSFM) {%OutDataLayout%; real Cumulative_Sum;} %InitializeTSFM%(%InDataSorted% L, integer C) := TRANSFORM
			SELF.Cumulative_Sum := 0;
			SELF.Ntile_Response := 0;
			SELF := L;
		END;
		#UNIQUENAME(OutDataAInitialized) %OutDataAInitialized% := PROJECT(%InDataSorted%,%InitializeTSFM%(LEFT,COUNTER));	
		#UNIQUENAME(IterateTSFM) {%OutDataLayout%; real Cumulative_Sum;} %IterateTSFM%(%OutDataAInitialized% L, %OutDataAInitialized% R) := TRANSFORM
			SELF.Cumulative_Sum := L.Cumulative_Sum + R.ResponseFieldName;
			SELF := R;
		END;
		#UNIQUENAME(OutDataIterated) %OutDataIterated% := ITERATE(%OutDataAInitialized%,%IterateTSFM%(LEFT,RIGHT));
		
		#UNIQUENAME(AppendTSFM) %OutDataLayout% %AppendTSFM%( %OutDataIterated% L) := TRANSFORM
			SELF.Ntile_Response := MIN(IF(ROUNDUP(N*L.Cumulative_Sum/%TotalResponse%)=0,1,ROUNDUP(N*L.Cumulative_Sum/%TotalResponse%)),N);
			SELF := L;
		END;
		OutData := PROJECT(%OutDataIterated%,%AppendTSFM%(LEFT));
		SummaryTable := SORT(TABLE(OutData,{Ntile_Response,cnt:= COUNT(GROUP),lowercut:=min(GROUP,SortFieldName),uppercut:=max(GROUP,SortFieldName)},Ntile_Response),Ntile_Response);
	ENDMACRO;
END;