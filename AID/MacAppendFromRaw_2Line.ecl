/**************************************************************************************
 ** MacAppendFromRaw_2Line(	RecSetIn				// Incoming dataset
													 ,Line1Field			// Fieldname of address Line1
													 ,LineLastField		// Fieldname of address LineLast (city, state, zip)
													 ,RawAIDInField		// Fieldname of incoming Raw Address ID
													 ,RecSetOut				// Resulting dataset out-reference
													[,RunFlags]				// Bitmap of options for run and returned dataset (Optional:  Default is AID.Common.eReturnValues.Default)
													[,Metrics]				// Boolean, whether to include metrics output to workunit (Optional:  Default is FALSE)
												);
  
 **************************************************************************************/
export MacAppendFromRaw_2Line(pDatasetIn, pLine1, pLineLast, pRawAID, pDatasetOut, pReturnValues=AID.Common.eReturnValues.Default, pOutputMetrics=false)
 :=
	macro
		#uniquename(rDatasetInPlus)
		#uniquename(tDatasetInPlus)
		#uniquename(dDatasetInPlus)
		#uniquename(dFromAIDMacro)
		#uniquename(rDatasetOut)
		#uniquename(tDatasetOut)
		%rDatasetInPlus%
		 :=
			record
				pDatasetIn;
				string1				AIDWork_FakeLine2	:=	'';
				string1				AIDWork_FakeLine3	:=	'';
			end : onwarning(1041, ignore)
		 ;

		%rDatasetInPlus%	%tDatasetInPlus%(pDatasetIn pInput)
		 :=
			transform
				self	:=	pInput;
			end
		 ;

		%dDatasetInPlus%	:=	project(pDatasetIn,%tDatasetInPlus%(left));
		
		AID.MacAppendFromRaw(%dDatasetInPlus%,pLine1,AIDWork_FakeLine2,AIDWork_FakeLine3,pLineLast,pRawAID,%dFromAIDMacro%,pReturnValues,pOutputMetrics)

		%rDatasetOut%
		 :=
			record
				recordof(%dFromAIDMacro%)	and not [AIDWork_FakeLine2, AIDWork_FakeLine3];
			end
		 ;

		pDatasetOut	:=	project(%dFromAIDMacro%,%rDatasetOut%);
	endmacro
 ;
