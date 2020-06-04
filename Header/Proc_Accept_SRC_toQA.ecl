import STD;
export Proc_Accept_SRC_toQA(string filedate=header.version_build, boolean pFastHeader=false) := function


	MoveToQA(string fname) := function
		b_sf  := fname + '_built';
		b_sf1 := fname + '_built1';
		b_sf2 := fname + '_built2';
		b_sf3 := fname + '_built3';
		b_sf4 := fname + '_built4';
		q_sf  := fname + '_qa';
		b_lf  := nothor(STD.File.SuperFileContents(b_sf)(regexfind(filedate + '::', name)));
		b_lf1 := nothor(STD.File.SuperFileContents(b_sf1)(regexfind(filedate + '::', name)));
		b_lf2 := nothor(STD.File.SuperFileContents(b_sf2)(regexfind(filedate + '::', name)));
		b_lf3 := nothor(STD.File.SuperFileContents(b_sf3)(regexfind(filedate + '::', name)));
		b_lf4 := nothor(STD.File.SuperFileContents(b_sf4)(regexfind(filedate + '::', name)));

		act(string sf, string lf) := function
			return sequential(
				STD.File.StartSuperFileTransaction(),
				STD.File.RemoveSuperFile(sf, lf),
				if(STD.File.FindSuperFileSubName(q_sf, lf) < 1, STD.File.AddSuperFile(q_sf, lf)),
				STD.File.FinishSuperFileTransaction()
				);

		end;

		seq := sequential(
			STD.File.ClearSuperFile(q_sf),
			if(count(b_lf) > 0,  nothor(apply(b_lf,  act(b_sf,  '~' + name)))),
			if(count(b_lf1) > 0, nothor(apply(b_lf1, act(b_sf1, '~' + name)))),
			if(count(b_lf2) > 0, nothor(apply(b_lf2, act(b_sf2, '~' + name)))),
			if(count(b_lf3) > 0, nothor(apply(b_lf3, act(b_sf3, '~' + name)))),
			if(count(b_lf4) > 0, nothor(apply(b_lf3, act(b_sf4, '~' + name)))),
		);
		return seq;
	end;

	return parallel(
		MoveToQA('~thor_data400::key::header.rid_header');
		MoveToQA('~thor_data400::key::header_rid_srid_header');

		MoveToQA('~thor_data400::key::dlv2_src_index_header');
		MoveToQA('~thor_data400::key::bkv2_src_index_header');
		MoveToQA('~thor_data400::key::veh_v2_src_index_header');
		MoveToQA('~thor_data400::key::propasses_src_index_header');
		MoveToQA('~thor_data400::key::propdeed_src_index_header');
		MoveToQA('~thor_data400::key::lienv2_src_index_header');
		MoveToQA('~thor_data400::key::eq_src_index_header');
		MoveToQA('~thor_data400::key::experian_src_index_header');
		MoveToQA('~thor_data400::key::TN_src_index_header');

		MoveToQA('~thor_data400::key::ak_src_index');
		MoveToQA('~thor_data400::key::atf_src_index');
		MoveToQA('~thor_data400::key::em_src_index');
		MoveToQA('~thor_data400::key::ms_src_index');
		MoveToQA('~thor_data400::key::death_src_index');
		MoveToQA('~thor_data400::key::statedeath_src_index');
		MoveToQA('~thor_data400::key::prof_src_index');
		MoveToQA('~thor_data400::key::util_src_index');
		MoveToQA('~thor_data400::key::airm_src_index');
		MoveToQA('~thor_data400::key::for_src_index');
		MoveToQA('~thor_data400::key::dea_src_index');
		MoveToQA('~thor_data400::key::water_src_index');
		MoveToQA('~thor_data400::key::airc_src_index');
		MoveToQA('~thor_data400::key::boater_src_index');
		MoveToQA('~thor_data400::key::targ_src_index');
		MoveToQA('~thor_data400::key::voters_src_index');
		MoveToQA('~thor_data400::key::census_src_index');
		MoveToQA('~thor_data400::key::nod_src_index');
	);

end;