EXPORT MAC_Consolidate_Files(stdIn, logType, isFcra) := FUNCTIONMACRO
	
	prefix := '~thor_data::in::inql::' + if(isFcra, 'fcra::', 'nonfcra::');		
		
	#uniquename(InLayout)
	%InLayout% := record
			unsigned4 filedate;
		#if(1 = logType)
			INQL_v2.layouts.rAccurint_In_Ext;
		#end
		#if(2 = logType)
			INQL_v2.layouts.rCustom_In_Ext;
		#end
		#if(3 = logType)
			INQL_v2.layouts.rBatch_In_Ext;
		#end
		#if(4 = logType)
			INQL_v2.layouts.rBatchR3_In_Ext;
		#end
		#if(5 = logType)
			INQL_v2.layouts.rBanko_In_Ext;
		#end
		#if(6 = logType)
			INQL_v2.layouts.rBridger_In_Ext;
		#end
		#if(7 = logType)
			INQL_v2.layouts.rRiskwise_In_Ext;
		#end
		#if(8 = logType)
			INQL_v2.layouts.rIDM_In_Ext;
		#end
		#if(9 = logType)
			INQL_v2.layouts.rSBA_In_Ext;
		#end
	end;
	
	#uniquename(logName)
	%logName% := 
		#if(1 = logType)
			'accurint'
		#end
		#if(2 = logType)
			'custom'
		#end
		#if(3 = logType)
			'batch'
		#end
		#if(4 = logType)
			'batchr3'
		#end
		#if(5 = logType)
			'banko'
		#end
		#if(6 = logType)
			'bridger'
		#end
		#if(7 = logType)
			'riskwise'
		#end
		#if(8 = logType)
			'idm'
		#end
		#if(9 = logType)
			'sba'
		#end
		#if(10 = logType)
			'transaction'
		#end
		#if(11 = logType)
			'deconfliction'
		#end;
//		+ '_hist';
	
	#uniquename(Delimiter)
	%Delimiter% := 
		#if(logType in [1,2,4,5,7,9,10,11])
			'~~';
		#end
		#if(3 = logType)	//Batch
			'|';
		#end
		#if(6 = logType)	//BRIDGER
			'\t';
		#end
		#if(8 = logType)	//IDM
			',';
		#end
		
	curr 	:= project(stdIn, recordof(stdIn) - [src_id]);
	hist	:= dataset(prefix + %logName% + '_hist', recordof(stdIn) - [src_id], csv( separator(%Delimiter%), terminator(['\n', '\r\n'])), opt);
	DS		:= hist + curr;
	
	ds t(ds L, ds R) := TRANSFORM
    SELF.vendor_l_rpt_date := if(L.vendor_l_rpt_date > R.vendor_l_rpt_date, L.vendor_l_rpt_date, R.vendor_l_rpt_date);
    SELF := L;
  END; 
    
  rolledDS := ROLLUP(DS, t(LEFT, RIGHT), record, except vendor_f_rpt_date, vendor_l_rpt_date, filedate);
	
	PromoteSupers.MAC_SF_BuildProcess(rolledDS,prefix + %logName% + '_hist',DoIt,2,,true,,%Delimiter%);
	PostIt := sequential(DoIt);
	
	return PostIt;

ENDMACRO;