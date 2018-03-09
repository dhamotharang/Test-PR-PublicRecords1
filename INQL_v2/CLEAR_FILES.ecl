export CLEAR_FILES(boolean fcra = false) := module
	
	shared FS 		:= fileservices;
	shared BaseFL	:=	nothor(FS.LogicalFileList('*base::*' + if(fcra, '::fcra', '::nonfcra') + '*built*',false,true))(~regexfind('history',name));
		
	shared In_SF 			:= nothor(FS.LogicalFileList('thor_data::in::inql*' + if(fcra, '::fcra*', '::nonfcra*'),false,true))(~regexfind('_bldg|_sl|_cc|_fdn|_hist', name));
	shared In_Bldg_SF := nothor(FS.LogicalFileList('thor_data::in::inql*' + if(fcra, '::fcra*', '::nonfcra*') + '_bldg',false,true))(~regexfind('_sl|_cc|_fdn', name));
	shared Hist_SF 		:= nothor(FS.LogicalFileList('thor_data::in::inql*' + if(fcra, '::fcra*', '::nonfcra*') + '_hist',false,true))(~regexfind('_sl|_cc|_fdn', name));
	
	export Current := sequential(
					FS.StartSuperFileTransaction(),
						nothor(apply(In_SF, FS.ClearSuperFile('~' + name, true))),
					FS.FinishSuperFileTransaction()
						);
	
	export In_Bldg := sequential(
					FS.StartSuperFileTransaction(),
						nothor(apply(In_Bldg_SF, FS.ClearSuperFile('~' + name, true))),
					FS.FinishSuperFileTransaction()
						);
						
	export Hist := sequential(
					FS.StartSuperFileTransaction(),
						nothor(apply(Hist_SF, FS.ClearSuperFile('~' + name, true))),
					FS.FinishSuperFileTransaction()
						);
end;