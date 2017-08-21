import tools;
export PersistNames(

	boolean	pUseOtherEnvironment = false	//if true on dataland, use prod, if true on prod, use dataland

):=
module

	export Root 	:= _dataset(pUseOtherEnvironment).thor_cluster_persists + 'persist::' + _Dataset().Name + '::';

	export AppendIdsfAppendDid	:= Root + 'AppendIds.fAppendDid'	;
	export AppendIdsfAppendBdid	:= Root + 'AppendIds.fAppendBdid'	;
	export AppendIdsfAppendSSN	:= Root + 'AppendIds.fAppendSSN'	;
	export AppendIdsfAppendFein	:= Root + 'AppendIds.fAppendFein'	;
	export Preprocess						:= Root + 'Preprocess'						;
	export PropagateIds					:= Root + 'Propagate_Ids'					;
	export RollupBase						:= Root + 'Rollup_Base'						;

	export dAll_Filenames :=
	dataset([
	
				 {AppendIdsfAppendDid		}							
        ,{AppendIdsfAppendBdid	}							
        ,{AppendIdsfAppendSSN		}							
        ,{AppendIdsfAppendFein	}							
        ,{Preprocess						}							
        ,{PropagateIds					}							
        ,{RollupBase						}							
          
	], tools.Layout_Names)
	;
end;