EXPORT LogicalFile_List(boolean pFCRA = false, string version) := module
	
	shared fcra 	:= if(pFCRA, '::fcra::', '::nonfcra::');

	export accurint 			:= INQL_v2._Constants.PREFIX + 'in::' + INQL_v2._Constants.DatasetName + fcra + version + '::accurint';
	export custom 				:= INQL_v2._Constants.PREFIX + 'in::' + INQL_v2._Constants.DatasetName + fcra + version + '::custom';
	export batch 					:= INQL_v2._Constants.PREFIX + 'in::' + INQL_v2._Constants.DatasetName + fcra + version + '::batch';
	export batchr3 				:= INQL_v2._Constants.PREFIX + 'in::' + INQL_v2._Constants.DatasetName + fcra + version + '::batchr3';
	export banko 					:= INQL_v2._Constants.PREFIX + 'in::' + INQL_v2._Constants.DatasetName + fcra + version + '::banko';
	export bridger 				:= INQL_v2._Constants.PREFIX + 'in::' + INQL_v2._Constants.DatasetName + fcra + version + '::bridger';
	export riskwise 			:= INQL_v2._Constants.PREFIX + 'in::' + INQL_v2._Constants.DatasetName + fcra + version + '::riskwise';	
	export idm		 				:= INQL_v2._Constants.PREFIX + 'in::' + INQL_v2._Constants.DatasetName + fcra + version + '::idm';
	export sba 						:= INQL_v2._Constants.PREFIX + 'in::' + INQL_v2._Constants.DatasetName + fcra + version + '::sba';
	export deconfliction	:= INQL_v2._Constants.PREFIX + '::in::' + INQL_v2._Constants.DatasetName + fcra + version + '::mbs::deconfliction';
	export transaction 		:= INQL_v2._Constants.PREFIX + '::in::' + INQL_v2._Constants.DatasetName + fcra + version + '::mbs::transaction';									
	
	
end;