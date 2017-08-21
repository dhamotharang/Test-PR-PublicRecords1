export MacLegacyClean2Line(pDatasetIn, pLine1, pLineLast, pCleanMisses=true, pDatasetOut)
 :=
  macro
		import AID;

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
				string1					AIDWork_FakeLine2	:=	'';
				string1					AIDWork_FakeLine3	:=	'';
				AID.Common.xAID			AIDWork_FakeRawAID	:=	0;
			end
		 ;

		%rDatasetInPlus%	%tDatasetInPlus%(pDatasetIn pInput)
		 :=
			transform
				self	:=	pInput;
			end
		 ;

		%dDatasetInPlus%	:=	project(pDatasetIn,%tDatasetInPlus%(left));
		
		AID.MacAppendFromRaw(%dDatasetInPlus%,pLine1,AIDWork_FakeLine2,AIDWork_FakeLine3,pLineLast,AIDWork_FakeRawAID,%dFromAIDMacro%,AID.Common.eReturnValues.ACECacheRecords)

		%rDatasetOut%
		 :=
			record
				pDatasetIn;
				string182				Clean;
			end
		 ;

		%rDatasetOut%	%tDatasetOut%(%dFromAIDMacro% pInput)
		 :=
			transform
				self.Clean		:=	pInput.AIDWork_ACECache.prim_range
											+		pInput.AIDWork_ACECache.predir
											+		pInput.AIDWork_ACECache.prim_name
											+		pInput.AIDWork_ACECache.addr_suffix
											+		pInput.AIDWork_ACECache.postdir
											+		pInput.AIDWork_ACECache.unit_desig
											+		pInput.AIDWork_ACECache.sec_range
											+		pInput.AIDWork_ACECache.p_city_name
											+		pInput.AIDWork_ACECache.v_city_name
											+		pInput.AIDWork_ACECache.st
											+		pInput.AIDWork_ACECache.zip5
											+		pInput.AIDWork_ACECache.zip4
											+		pInput.AIDWork_ACECache.cart
											+		pInput.AIDWork_ACECache.cr_sort_sz
											+		pInput.AIDWork_ACECache.lot
											+		pInput.AIDWork_ACECache.lot_order
											+		pInput.AIDWork_ACECache.dbpc
											+		pInput.AIDWork_ACECache.chk_digit
											+		pInput.AIDWork_ACECache.rec_type
											+		pInput.AIDWork_ACECache.county
											+		pInput.AIDWork_ACECache.geo_lat
											+		pInput.AIDWork_ACECache.geo_long
											+		pInput.AIDWork_ACECache.msa
											+		pInput.AIDWork_ACECache.geo_blk
											+		pInput.AIDWork_ACECache.geo_match
											+		pInput.AIDWork_ACECache.err_stat
											;
				self			:=	pInput;
			end
		 ;
		
		pDatasetOut	:=	project(%dFromAIDMacro%,%tDatasetOut%(left));
	
  endmacro
 ;