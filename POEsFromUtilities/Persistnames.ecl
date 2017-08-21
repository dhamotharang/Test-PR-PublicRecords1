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
	export MapUtility						:= Root + 'Map_Utility'						;
	export AppendEDA						:= Root + 'Append_EDA'						;
	export AppendAID						:= Root + 'Append_AID'						;
	export AppendYellowpages		:= Root + 'Append_YellowPages'		;
				 
	export dAll_Filenames :=
	dataset([
	
				 {AppendIdsfAppendDid		}							
        ,{AppendIdsfAppendBdid	}							
        ,{AppendIdsfAppendSSN		}							
        ,{AppendIdsfAppendFein	}							
        ,{MapUtility						}							
        ,{AppendEDA							}							
        ,{AppendAID							}							
        ,{AppendYellowpages			}							
          
	], tools.Layout_Names)
	;
end;