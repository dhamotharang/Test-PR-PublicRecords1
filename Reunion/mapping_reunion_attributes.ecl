import std, PromoteSupers;

EXPORT mapping_reunion_attributes(unsigned1 mode, STRING sVersion) := MODULE

input := if(mode = 1, reunion.various_appends(mode, sVersion).all, reunion.various_appends_core(mode, sVersion).all);
input_cnt := count(input);

append_aml_attr := reunion.fn_call_aml_batch_service(input);
append_bs_attr  := reunion.fn_call_bocashell_batch_service(append_aml_attr);
wAcctNo := project(append_bs_attr, transform({append_bs_attr}, self.AccountNumber := counter; self := left;)) : PERSIST('~thor::persist::mylife::append_aml_d2c_bs_attr::' + reunion.Constants.sMode(mode), EXPIRE(10), REFRESH(FALSE));

sPrefix := '~thor::base::mylife::' + reunion.Constants.sMode(mode) + '::';
pbSF := sPrefix + 'append_attributes_pb';
liSF := sPrefix + 'append_attributes_li';
attrSF := sPrefix + 'append_attributes';

add_pb_attrs(unsigned1 seg) := FUNCTION
	inDS  := if(seg = 1, wAcctNo, dataset(pbSF,reunion.layouts.lMainRaw,thor));
	outDS := reunion.fn_call_profilebooster_batch_service(inDS, seg);
	PromoteSupers.Mac_SF_BuildProcess(outDS,pbSF,pb,2,,true,pVersion:=sVersion + '_' + seg);
	return pb;
END;

add_li_attrs(unsigned1 seg) := FUNCTION
	inDS  := if(seg = 1, 
				dataset(pbSF,reunion.layouts.lMainRaw,thor),
				dataset(liSF,reunion.layouts.lMainRaw,thor)
				);
	outDS := reunion.fn_call_leadintegrity_batch_service(inDS, seg);
	PromoteSupers.Mac_SF_BuildProcess(outDS,liSF,li,2,,true,pVersion:=sVersion + '_' + seg);
	return li;
END;

add_comp_rpt_attrs() := FUNCTION
	dsLI  := dataset(liSF,reunion.layouts.lMainRaw,thor);
	append_d2c_attr := reunion.fn_add_comprehensive_rpt_attributes(dsLI);
	PromoteSupers.Mac_SF_BuildProcess(append_d2c_attr,attrSF,attr,2,,true,pVersion:=sVersion);
	return attr;
END;

seq_pb := sequential(
	Reunion.mac_runIfNotCompleted ('Reunion',sVersion, add_pb_attrs(1),122), //1 seg = 10M records
	if(input_cnt > 1*reunion.constants.Seg_size, Reunion.mac_runIfNotCompleted ('Reunion',sVersion, add_pb_attrs(2),123)),
	if(input_cnt > 2*reunion.constants.Seg_size, Reunion.mac_runIfNotCompleted ('Reunion',sVersion, add_pb_attrs(3),124)),
	if(input_cnt > 3*reunion.constants.Seg_size, Reunion.mac_runIfNotCompleted ('Reunion',sVersion, add_pb_attrs(4),125)),
	if(input_cnt > 4*reunion.constants.Seg_size, Reunion.mac_runIfNotCompleted ('Reunion',sVersion, add_pb_attrs(5),126)),
	if(input_cnt > 5*reunion.constants.Seg_size, Reunion.mac_runIfNotCompleted ('Reunion',sVersion, add_pb_attrs(6),127)),
	if(input_cnt > 6*reunion.constants.Seg_size, Reunion.mac_runIfNotCompleted ('Reunion',sVersion, add_pb_attrs(7),128)),
	if(input_cnt > 7*reunion.constants.Seg_size, Reunion.mac_runIfNotCompleted ('Reunion',sVersion, add_pb_attrs(8),129)),
	if(input_cnt > 8*reunion.constants.Seg_size, Reunion.mac_runIfNotCompleted ('Reunion',sVersion, add_pb_attrs(9),130)),
	if(input_cnt > 9*reunion.constants.Seg_size, Reunion.mac_runIfNotCompleted ('Reunion',sVersion, add_pb_attrs(10),131)),
	if(input_cnt > 10*reunion.constants.Seg_size, Reunion.mac_runIfNotCompleted ('Reunion',sVersion, add_pb_attrs(11),132)), 
	if(input_cnt > 11*reunion.constants.Seg_size, Reunion.mac_runIfNotCompleted ('Reunion',sVersion, add_pb_attrs(12),133)),
	if(input_cnt > 12*reunion.constants.Seg_size, Reunion.mac_runIfNotCompleted ('Reunion',sVersion, add_pb_attrs(13),134)),
	if(input_cnt > 13*reunion.constants.Seg_size, Reunion.mac_runIfNotCompleted ('Reunion',sVersion, add_pb_attrs(14),135)),
	if(input_cnt > 14*reunion.constants.Seg_size, Reunion.mac_runIfNotCompleted ('Reunion',sVersion, add_pb_attrs(15),136)),
	if(input_cnt > 15*reunion.constants.Seg_size, Reunion.mac_runIfNotCompleted ('Reunion',sVersion, add_pb_attrs(16),137)),
	if(input_cnt > 16*reunion.constants.Seg_size, Reunion.mac_runIfNotCompleted ('Reunion',sVersion, add_pb_attrs(17),138)),
	if(input_cnt > 17*reunion.constants.Seg_size, Reunion.mac_runIfNotCompleted ('Reunion',sVersion, add_pb_attrs(18),139)),
	if(input_cnt > 18*reunion.constants.Seg_size, Reunion.mac_runIfNotCompleted ('Reunion',sVersion, add_pb_attrs(19),140)),
	if(input_cnt > 19*reunion.constants.Seg_size, Reunion.mac_runIfNotCompleted ('Reunion',sVersion, add_pb_attrs(20),141)),
	if(input_cnt > 20*reunion.constants.Seg_size, Reunion.mac_runIfNotCompleted ('Reunion',sVersion, add_pb_attrs(21),142)), 
	if(input_cnt > 21*reunion.constants.Seg_size, Reunion.mac_runIfNotCompleted ('Reunion',sVersion, add_pb_attrs(22),143)),
	if(input_cnt > 22*reunion.constants.Seg_size, Reunion.mac_runIfNotCompleted ('Reunion',sVersion, add_pb_attrs(23),144)),
	if(input_cnt > 23*reunion.constants.Seg_size, Reunion.mac_runIfNotCompleted ('Reunion',sVersion, add_pb_attrs(24),145)),
	if(input_cnt > 24*reunion.constants.Seg_size, Reunion.mac_runIfNotCompleted ('Reunion',sVersion, add_pb_attrs(25),146)),
	if(input_cnt > 25*reunion.constants.Seg_size, Reunion.mac_runIfNotCompleted ('Reunion',sVersion, add_pb_attrs(26),147)),
	if(input_cnt > 26*reunion.constants.Seg_size, Reunion.mac_runIfNotCompleted ('Reunion',sVersion, add_pb_attrs(27),148)),
	if(input_cnt > 27*reunion.constants.Seg_size, Reunion.mac_runIfNotCompleted ('Reunion',sVersion, add_pb_attrs(28),149)),
	if(input_cnt > 28*reunion.constants.Seg_size, Reunion.mac_runIfNotCompleted ('Reunion',sVersion, add_pb_attrs(29),150)),
	if(input_cnt > 29*reunion.constants.Seg_size, Reunion.mac_runIfNotCompleted ('Reunion',sVersion, add_pb_attrs(30),151)),
	if(input_cnt > 30*reunion.constants.Seg_size, Reunion.mac_runIfNotCompleted ('Reunion',sVersion, add_pb_attrs(31),152)), 
	if(input_cnt > 31*reunion.constants.Seg_size, Reunion.mac_runIfNotCompleted ('Reunion',sVersion, add_pb_attrs(32),153)),
	if(input_cnt > 32*reunion.constants.Seg_size, Reunion.mac_runIfNotCompleted ('Reunion',sVersion, add_pb_attrs(33),154)),
	if(input_cnt > 33*reunion.constants.Seg_size, Reunion.mac_runIfNotCompleted ('Reunion',sVersion, add_pb_attrs(34),155)),
	if(input_cnt > 34*reunion.constants.Seg_size, Reunion.mac_runIfNotCompleted ('Reunion',sVersion, add_pb_attrs(35),156)),
	if(input_cnt > 35*reunion.constants.Seg_size, Reunion.mac_runIfNotCompleted ('Reunion',sVersion, add_pb_attrs(36),157)),
	if(input_cnt > 36*reunion.constants.Seg_size, Reunion.mac_runIfNotCompleted ('Reunion',sVersion, add_pb_attrs(37),158)),
	if(input_cnt > 37*reunion.constants.Seg_size, Reunion.mac_runIfNotCompleted ('Reunion',sVersion, add_pb_attrs(38),159)),
	if(input_cnt > 38*reunion.constants.Seg_size, Reunion.mac_runIfNotCompleted ('Reunion',sVersion, add_pb_attrs(39),160)),
	if(input_cnt > 39*reunion.constants.Seg_size, Reunion.mac_runIfNotCompleted ('Reunion',sVersion, add_pb_attrs(40),161)),
);

seq_li := sequential(
	Reunion.mac_runIfNotCompleted ('Reunion',sVersion, add_li_attrs(1),162), 
	if(input_cnt > 1*reunion.constants.Seg_size, Reunion.mac_runIfNotCompleted ('Reunion',sVersion, add_li_attrs(2),163)),
	if(input_cnt > 2*reunion.constants.Seg_size, Reunion.mac_runIfNotCompleted ('Reunion',sVersion, add_li_attrs(3),164)),
	if(input_cnt > 3*reunion.constants.Seg_size, Reunion.mac_runIfNotCompleted ('Reunion',sVersion, add_li_attrs(4),165)),
	if(input_cnt > 4*reunion.constants.Seg_size, Reunion.mac_runIfNotCompleted ('Reunion',sVersion, add_li_attrs(5),166)),
	if(input_cnt > 5*reunion.constants.Seg_size, Reunion.mac_runIfNotCompleted ('Reunion',sVersion, add_li_attrs(6),167)),
	if(input_cnt > 6*reunion.constants.Seg_size, Reunion.mac_runIfNotCompleted ('Reunion',sVersion, add_li_attrs(7),168)),
	if(input_cnt > 7*reunion.constants.Seg_size, Reunion.mac_runIfNotCompleted ('Reunion',sVersion, add_li_attrs(8),169)),
	if(input_cnt > 8*reunion.constants.Seg_size, Reunion.mac_runIfNotCompleted ('Reunion',sVersion, add_li_attrs(9),170)),
	if(input_cnt > 9*reunion.constants.Seg_size, Reunion.mac_runIfNotCompleted ('Reunion',sVersion, add_li_attrs(10),171)),
	if(input_cnt > 10*reunion.constants.Seg_size, Reunion.mac_runIfNotCompleted ('Reunion',sVersion, add_li_attrs(11),172)), 
	if(input_cnt > 11*reunion.constants.Seg_size, Reunion.mac_runIfNotCompleted ('Reunion',sVersion, add_li_attrs(12),173)),
	if(input_cnt > 12*reunion.constants.Seg_size, Reunion.mac_runIfNotCompleted ('Reunion',sVersion, add_li_attrs(13),174)),
	if(input_cnt > 13*reunion.constants.Seg_size, Reunion.mac_runIfNotCompleted ('Reunion',sVersion, add_li_attrs(14),175)),
	if(input_cnt > 14*reunion.constants.Seg_size, Reunion.mac_runIfNotCompleted ('Reunion',sVersion, add_li_attrs(15),176)),
	if(input_cnt > 15*reunion.constants.Seg_size, Reunion.mac_runIfNotCompleted ('Reunion',sVersion, add_li_attrs(16),177)),
	if(input_cnt > 16*reunion.constants.Seg_size, Reunion.mac_runIfNotCompleted ('Reunion',sVersion, add_li_attrs(17),178)),
	if(input_cnt > 17*reunion.constants.Seg_size, Reunion.mac_runIfNotCompleted ('Reunion',sVersion, add_li_attrs(18),179)),
	if(input_cnt > 18*reunion.constants.Seg_size, Reunion.mac_runIfNotCompleted ('Reunion',sVersion, add_li_attrs(19),180)),
	if(input_cnt > 19*reunion.constants.Seg_size, Reunion.mac_runIfNotCompleted ('Reunion',sVersion, add_li_attrs(20),181)),
	if(input_cnt > 20*reunion.constants.Seg_size, Reunion.mac_runIfNotCompleted ('Reunion',sVersion, add_li_attrs(21),182)), 
	if(input_cnt > 21*reunion.constants.Seg_size, Reunion.mac_runIfNotCompleted ('Reunion',sVersion, add_li_attrs(22),183)),
	if(input_cnt > 22*reunion.constants.Seg_size, Reunion.mac_runIfNotCompleted ('Reunion',sVersion, add_li_attrs(23),184)),
	if(input_cnt > 23*reunion.constants.Seg_size, Reunion.mac_runIfNotCompleted ('Reunion',sVersion, add_li_attrs(24),185)),
	if(input_cnt > 24*reunion.constants.Seg_size, Reunion.mac_runIfNotCompleted ('Reunion',sVersion, add_li_attrs(25),186)),
	if(input_cnt > 25*reunion.constants.Seg_size, Reunion.mac_runIfNotCompleted ('Reunion',sVersion, add_li_attrs(26),187)),
	if(input_cnt > 26*reunion.constants.Seg_size, Reunion.mac_runIfNotCompleted ('Reunion',sVersion, add_li_attrs(27),188)),
	if(input_cnt > 27*reunion.constants.Seg_size, Reunion.mac_runIfNotCompleted ('Reunion',sVersion, add_li_attrs(28),189)),
	if(input_cnt > 28*reunion.constants.Seg_size, Reunion.mac_runIfNotCompleted ('Reunion',sVersion, add_li_attrs(29),190)),
	if(input_cnt > 29*reunion.constants.Seg_size, Reunion.mac_runIfNotCompleted ('Reunion',sVersion, add_li_attrs(30),191)),
	if(input_cnt > 30*reunion.constants.Seg_size, Reunion.mac_runIfNotCompleted ('Reunion',sVersion, add_li_attrs(31),192)), 
	if(input_cnt > 31*reunion.constants.Seg_size, Reunion.mac_runIfNotCompleted ('Reunion',sVersion, add_li_attrs(32),193)),
	if(input_cnt > 32*reunion.constants.Seg_size, Reunion.mac_runIfNotCompleted ('Reunion',sVersion, add_li_attrs(33),194)),
	if(input_cnt > 33*reunion.constants.Seg_size, Reunion.mac_runIfNotCompleted ('Reunion',sVersion, add_li_attrs(34),195)),
	if(input_cnt > 34*reunion.constants.Seg_size, Reunion.mac_runIfNotCompleted ('Reunion',sVersion, add_li_attrs(35),196)),
	if(input_cnt > 35*reunion.constants.Seg_size, Reunion.mac_runIfNotCompleted ('Reunion',sVersion, add_li_attrs(36),197)),
	if(input_cnt > 36*reunion.constants.Seg_size, Reunion.mac_runIfNotCompleted ('Reunion',sVersion, add_li_attrs(37),198)),
	if(input_cnt > 37*reunion.constants.Seg_size, Reunion.mac_runIfNotCompleted ('Reunion',sVersion, add_li_attrs(38),199)),
	if(input_cnt > 38*reunion.constants.Seg_size, Reunion.mac_runIfNotCompleted ('Reunion',sVersion, add_li_attrs(39),200)),
	if(input_cnt > 39*reunion.constants.Seg_size, Reunion.mac_runIfNotCompleted ('Reunion',sVersion, add_li_attrs(40),201)),
);

seq_comp_rpt := sequential(
	Reunion.mac_runIfNotCompleted ('Reunion',sVersion, add_comp_rpt_attrs(),201)
);

clearAttributeSF := sequential(
	STD.File.StartSuperFileTransaction(),
	STD.File.ClearSuperFile(pbSF),
	STD.File.ClearSuperFile(liSF),
	STD.File.ClearSuperFile(attrSF),
	STD.File.FinishSuperFileTransaction()
	);

EXPORT all := sequential(
		Reunion.mac_runIfNotCompleted('Reunion',sVersion, clearAttributeSF,121),
 		seq_pb,
		seq_li,
		seq_comp_rpt
		);

END;