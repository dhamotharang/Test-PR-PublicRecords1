EXPORT MAC_Consolidate_Files(stdIn, source, isFcra) := FUNCTIONMACRO
	
	prefix := '~thor_data::in::inql::' + if(isFcra, 'fcra::', 'nonfcra::');		
		
	#uniquename(InLayout)
	%InLayout% := record
		#if(source = 'Accurint')
			INQL_v2.layouts.rAccurint_In_Ext;
		#end
		#if(source = 'Custom')
			INQL_v2.layouts.rCustom_In_Ext;
		#end
		#if(source = 'Batch')
			INQL_v2.layouts.rBatch_In_Ext;
		#end
		#if(source = 'BatchR3')
			INQL_v2.layouts.rBatchR3_In_Ext;
		#end
		#if(source = 'Banko')
			INQL_v2.layouts.rBanko_In_Ext;
		#end
		#if(source = 'Bridger')
			INQL_v2.layouts.rBridger_In_Ext;
		#end
		#if(source = 'Riskwise')
			INQL_v2.layouts.rRiskwise_In_Ext;
		#end
		#if(source = 'IDM')
			INQL_v2.layouts.rIDM_In_Ext;
		#end
		#if(source = 'SBA')
			INQL_v2.layouts.rSBA_In_Ext;
		#end
	end;
	
	#uniquename(Delimiter)
	%Delimiter% := 
		#if(source in ['Accurint','BatchR3','Custom','Banko','Riskwise','SBA'])
			'~~';
		#end
		#if(source = 'Batch')
			'|';
		#end
		#if(source = 'Bridger')
			'\t';
		#end
		#if(source = 'IDM')
			',';
		#end
	
	hist_filename := prefix + source + '_hist';
	curr 	:= stdIn; //project(stdIn, recordof(stdIn));// - [src_id]);
	hist	:= dataset(hist_filename,%InLayout% , csv( separator(%Delimiter%), terminator(['\n', '\r\n'])), opt);
	DS		:= hist + curr;
	
	ds t(ds L, ds R) := TRANSFORM
    SELF.vendor_l_rpt_date := if(L.vendor_l_rpt_date > R.vendor_l_rpt_date, L.vendor_l_rpt_date, R.vendor_l_rpt_date);
    SELF := L;
  END; 
    
  rolledDS := ROLLUP(DS, t(LEFT, RIGHT), record, except vendor_f_rpt_date, vendor_l_rpt_date, filedate);
	
	PromoteSupers.MAC_SF_BuildProcess(
																	rolledDS 																					 	//thedataset
																 ,hist_filename																				//basename
																 ,DoIt 																								//seq_name
																 ,2 																									//numgenerations
																 ,true 																								//csvout
																 ,true 																								//pCompress
																 ,				 																						//pVersion
																 ,%Delimiter%																					//pSeparator
																 ,       																							//pQuote
																 ,'|\n'  																							//pTerminator
																 ,0      																							//pHeading
																 );	
	
	PostIt := sequential(DoIt);
	
	return PostIt;

ENDMACRO;