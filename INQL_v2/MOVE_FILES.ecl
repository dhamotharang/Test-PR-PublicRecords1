export MOVE_FILES(boolean fcra = false) := module
	
	shared FS 		:= fileservices;
	// shared BaseFL	:= nothor(FS.LogicalFileList('*base::*' + if(fcra, '::fcra', '::nonfcra') + '*built*',false,true))(~regexfind('history',name));
	
	shared Daily_Base_SF	:= nothor(FS.LogicalFileList('*base::*' + if(fcra, '::fcra::daily', '::nonfcra::daily') + '*built*',false,true))(~regexfind('_bldg',name));
	shared Weekly_Base_SF	:= nothor(FS.LogicalFileList('*base::*' + if(fcra, '::fcra::weekly', '::nonfcra::weekly') + '*built*',false,true))(~regexfind('_bldg',name));
		
	shared In_SF 			:= nothor(FS.LogicalFileList('thor_data::in::inql*' + if(fcra, '::fcra*', '::nonfcra*'),false,true))(~regexfind('_bldg|_sl|_cc|_fdn|_hist', name));
	shared In_Bldg_SF := nothor(FS.LogicalFileList('thor_data::in::inql*' + if(fcra, '::fcra*', '::nonfcra*') + '_bldg',false,true))(~regexfind('_sl|_cc|_fdn', name));
	shared Hist_SF 		:= nothor(FS.LogicalFileList('thor_data::in::inql*' + if(fcra, '::fcra*', '::nonfcra*') + '_hist',false,true))(~regexfind('_sl|_cc|_fdn', name));
	
	export Current_To_In_Bldg := sequential(
					FS.StartSuperFileTransaction(),
						nothor(apply(In_SF, FS.PromoteSuperFileList(['~' + name, '~' + name + '_bldg']))),
					FS.FinishSuperFileTransaction()
						);
	
	export In_Bldg_To_Current := sequential(
					FS.StartSuperFileTransaction(),
						nothor(apply(In_SF, FS.PromoteSuperFileList(['~' + name + '_bldg', '~' + name]))),
					FS.FinishSuperFileTransaction()
						);
						
	export In_Bldg_To_Hist := sequential(
					FS.StartSuperFileTransaction(),
						nothor(apply(In_Bldg_SF, FS.PromoteSuperFileList(['~' + name, regexreplace('_bldg', name, '_hist')]))),
					FS.FinishSuperFileTransaction()
						);
	
	export Built_To_DailyBase_Bldg := sequential(
					FS.StartSuperFileTransaction(),
						nothor(apply(Daily_Base_SF, FS.ClearSuperFile('~' + regexreplace('::built', name, '_bldg')))),
						nothor(apply(Daily_Base_SF, FS.AddSuperFile('~' + regexreplace('::built', name, '_bldg'), '~' + name, addcontents := true))),
					FS.FinishSuperFileTransaction()
						);
	
	export Built_To_WeeklyBase_Bldg := sequential(
					FS.StartSuperFileTransaction(),
						nothor(apply(Weekly_Base_SF, FS.ClearSuperFile('~' + regexreplace('::built', name, '_bldg')))),
						nothor(apply(Weekly_Base_SF, FS.AddSuperFile('~' + regexreplace('::built', name, '_bldg'), '~' + name, addcontents := true))),
					FS.FinishSuperFileTransaction()
						);
end;