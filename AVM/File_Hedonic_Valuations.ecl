a0 := avm.get_Hedonic_Comps('0') : persist('temp::comps0');
a1 := avm.get_Hedonic_Comps('1') : persist('temp::comps1');
a2 := avm.get_Hedonic_Comps('2') : persist('temp::comps2');
a3 := avm.get_Hedonic_Comps('3') : persist('temp::comps3');
a4 := avm.get_Hedonic_Comps('4') : persist('temp::comps4');
a5 := avm.get_Hedonic_Comps('5') : persist('temp::comps5');
with_all_comps := a0 + a1 + a2 + a3 + a4 + a5;

/*
	//breaking down by state fips
	_01	 := avm.get_Hedonic_Comps('01') : persist('temp::comps_01');
	_02	 := avm.get_Hedonic_Comps('02') : persist('temp::comps_02');
	_04	 := avm.get_Hedonic_Comps('04') : persist('temp::comps_04');
	_05	 := avm.get_Hedonic_Comps('05') : persist('temp::comps_05');
	_06	 := avm.get_Hedonic_Comps('06') : persist('temp::comps_06');
	_08	 := avm.get_Hedonic_Comps('08') : persist('temp::comps_08');
	_09	 := avm.get_Hedonic_Comps('09') : persist('temp::comps_09');
	_10	 := avm.get_Hedonic_Comps('10') : persist('temp::comps_10');
	_11	 := avm.get_Hedonic_Comps('11') : persist('temp::comps_11');
	_12	 := avm.get_Hedonic_Comps('12') : persist('temp::comps_12');
	_13	 := avm.get_Hedonic_Comps('13') : persist('temp::comps_13');
	_15	 := avm.get_Hedonic_Comps('15') : persist('temp::comps_15');
	_16	 := avm.get_Hedonic_Comps('16') : persist('temp::comps_16');
	_17	 := avm.get_Hedonic_Comps('17') : persist('temp::comps_17');
	_18	 := avm.get_Hedonic_Comps('18') : persist('temp::comps_18');
	_19	 := avm.get_Hedonic_Comps('19') : persist('temp::comps_19');
	_20	 := avm.get_Hedonic_Comps('20') : persist('temp::comps_20');
	_21	 := avm.get_Hedonic_Comps('21') : persist('temp::comps_21');
	_22	 := avm.get_Hedonic_Comps('22') : persist('temp::comps_22');
	_23	 := avm.get_Hedonic_Comps('23') : persist('temp::comps_23');
	_24	 := avm.get_Hedonic_Comps('24') : persist('temp::comps_24');
	_25	 := avm.get_Hedonic_Comps('25') : persist('temp::comps_25');
	_26	 := avm.get_Hedonic_Comps('26') : persist('temp::comps_26');
	_27	 := avm.get_Hedonic_Comps('27') : persist('temp::comps_27');
	_28	 := avm.get_Hedonic_Comps('28') : persist('temp::comps_28');
	_29	 := avm.get_Hedonic_Comps('29') : persist('temp::comps_29');
	_30	 := avm.get_Hedonic_Comps('30') : persist('temp::comps_30');
	_31	 := avm.get_Hedonic_Comps('31') : persist('temp::comps_31');
	_32	 := avm.get_Hedonic_Comps('32') : persist('temp::comps_32');
	_33	 := avm.get_Hedonic_Comps('33') : persist('temp::comps_33');
	_34	 := avm.get_Hedonic_Comps('34') : persist('temp::comps_34');
	_35	 := avm.get_Hedonic_Comps('35') : persist('temp::comps_35');
	_36	 := avm.get_Hedonic_Comps('36') : persist('temp::comps_36');
	_37	 := avm.get_Hedonic_Comps('37') : persist('temp::comps_37');
	_38	 := avm.get_Hedonic_Comps('38') : persist('temp::comps_38');
	_39	 := avm.get_Hedonic_Comps('39') : persist('temp::comps_39');
	_40	 := avm.get_Hedonic_Comps('40') : persist('temp::comps_40');
	_41	 := avm.get_Hedonic_Comps('41') : persist('temp::comps_41');
	_42	 := avm.get_Hedonic_Comps('42') : persist('temp::comps_42');
	_44	 := avm.get_Hedonic_Comps('44') : persist('temp::comps_44');
	_45	 := avm.get_Hedonic_Comps('45') : persist('temp::comps_45');
	_46	 := avm.get_Hedonic_Comps('46') : persist('temp::comps_46');
	_47	 := avm.get_Hedonic_Comps('47') : persist('temp::comps_47');
	_48	 := avm.get_Hedonic_Comps('48') : persist('temp::comps_48');
	_49	 := avm.get_Hedonic_Comps('49') : persist('temp::comps_49');
	_50	 := avm.get_Hedonic_Comps('50') : persist('temp::comps_50');
	_51	 := avm.get_Hedonic_Comps('51') : persist('temp::comps_51');
	_53	 := avm.get_Hedonic_Comps('53') : persist('temp::comps_53');
	_54	 := avm.get_Hedonic_Comps('54') : persist('temp::comps_54');
	_55	 := avm.get_Hedonic_Comps('55') : persist('temp::comps_55');
	_56	 := avm.get_Hedonic_Comps('56') : persist('temp::comps_56');

	with_all_comps := 
		( _01
		+ _02
		+ _04
		+ _05
		+ _06
		+ _08
		+ _09
		+ _10
		+ _11
		+ _12
		+ _13
		+ _15
		+ _16
		+ _17
		+ _18
		+ _19
		+ _20
		+ _21
		+ _22
		+ _23
		+ _24
		+ _25
		+ _26
		+ _27
		+ _28
		+ _29
		+ _30
		+ _31
		+ _32
		+ _33
		+ _34
		+ _35
		+ _36
		+ _37
		+ _38
		+ _39
		+ _40
		+ _41
		+ _42
		+ _44
		+ _45
		+ _46
		+ _47
		+ _48
		+ _49
		+ _50
		+ _51
		+ _53
		+ _54
		+ _55
		+ _56 ) : persist('temp::avm::all_comps');
*/

	output(with_all_comps,,'~thor_data400::avm::hedonic_valuations_' + thorlib.WUID(), __compressed__);


export File_Hedonic_Valuations := with_all_comps;


