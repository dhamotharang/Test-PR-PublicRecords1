export File_Hedonic_Valuations(string8 history_date) := function

	a0 := avm_v2.get_Hedonic_Comps('0', history_date) : persist('temp::avm_v2::comps0');
	a1 := avm_v2.get_Hedonic_Comps('1', history_date) : persist('temp::avm_v2::comps1');
	a2 := avm_v2.get_Hedonic_Comps('2', history_date) : persist('temp::avm_v2::comps2');
	a3 := avm_v2.get_Hedonic_Comps('3', history_date) : persist('temp::avm_v2::comps3');
	a4 := avm_v2.get_Hedonic_Comps('4', history_date) : persist('temp::avm_v2::comps4');
	a5 := avm_v2.get_Hedonic_Comps('5', history_date) : persist('temp::avm_v2::comps5');
	with_all_comps := a0 + a1 + a2 + a3 + a4 + a5;

	output(with_all_comps,,'~thor_data400::avm_v2::hedonic_valuations', __compressed__, overwrite);

	return with_all_comps;

end;



