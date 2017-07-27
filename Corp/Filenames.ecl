export Filenames(integer cnt = 0) :=
module
	//////////////////////////////////////////////////////////////////
	// -- Declaration of Value Types
	//////////////////////////////////////////////////////////////////
	
	
	
	export ContUpdate		:= thor_cluster + 'in::' + Dataset_Name + '::cont';
	export EventUpdate	:= thor_cluster + 'in::' + Dataset_Name + '::event';
	export SuppUpdate		:= thor_cluster + 'in::' + Dataset_Name + '::supp';
	export CorpUpdate		:= thor_cluster + 'in::' + Dataset_Name + '::corp';

	export ContUpdate_father	:= thor_cluster + 'in::' + Dataset_Name + '::cont_father';
	export EventUpdate_father	:= thor_cluster + 'in::' + Dataset_Name + '::event_father';
	export SuppUpdate_father	:= thor_cluster + 'in::' + Dataset_Name + '::supp_father';
	export CorpUpdate_father	:= thor_cluster + 'in::' + Dataset_Name + '::corp_father';

	shared layout_superfiles := 
	record
		string superfile;
	end;

	export input_superfiles := DATASET([
		 (ContUpdate),
		 (EventUpdate),
		 (SuppUpdate),
		 (CorpUpdate)], layout_superfiles);


end;