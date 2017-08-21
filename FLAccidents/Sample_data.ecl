import FLAccidents;
BaseFile_FLCrash0_father := dataset('~thor_data400::base::flcrash0_father',FLAccidents.Layout_FLCrash0, flat);
BaseFile_FLCrash1_father := dataset('~thor_data400::base::flcrash1_father',FLAccidents.Layout_FLCrash1, flat);
BaseFile_FLCrash2v_father := dataset('~thor_data400::base::flcrash2v_father',FLAccidents.aid_layouts.flcrash2v, flat);
BaseFile_FLCrash3v_father := dataset('~thor_data400::base::flcrash3v_father',FLAccidents.Layout_FLCrash3v, flat);
BaseFile_FLCrash4_father := dataset('~thor_data400::base::flcrash4_father',FLAccidents.aid_layouts.flcrash4, flat);
BaseFile_FLCrash5_father := dataset('~thor_data400::base::flcrash5_father',FLAccidents.aid_layouts.flcrash5, flat);
BaseFile_FLCrash6_father := dataset('~thor_data400::base::flcrash6_father',FLAccidents.aid_layouts.flcrash6, flat);
BaseFile_FLCrash7_father := dataset('~thor_data400::base::flcrash7_father',FLAccidents.aid_layouts.flcrash7, flat);
BaseFile_FLCrash8_father := dataset('~thor_data400::base::flcrash8_father',FLAccidents.Layout_FLCrash8, flat);
BaseFile_FLCrash_Did_father := dataset('~thor_data400::base::flcrash_did_father',FLAccidents.layout_flcrash_search, flat);

d1:= distribute(BaseFile_FLCrash0_father,hash(accident_nbr));
d2:= distribute(BaseFile_FLCrash1_father,hash(accident_nbr));
d3:= distribute(BaseFile_FLCrash2v_father,hash(accident_nbr));
d4:= distribute(BaseFile_FLCrash3v_father,hash(accident_nbr));
d5:= distribute(BaseFile_FLCrash4_father,hash(accident_nbr));
d6:= distribute(BaseFile_FLCrash5_father,hash(accident_nbr));
d7:= distribute(BaseFile_FLCrash6_father,hash(accident_nbr));
d8:= distribute(BaseFile_FLCrash7_father,hash(accident_nbr));
d9:= distribute(BaseFile_FLCrash8_father,hash(accident_nbr));
d10:= distribute(BaseFile_FLCrash_Did_father,hash(accident_nbr));



d01 := output(choosen(join(distribute(FLAccidents.BaseFile_FLCrash0,hash(accident_nbr)),d1,left.accident_nbr= right.accident_nbr,left only,local),1000),named('FLAccidents_flcrash0_sample_QA'));

d02 := output(choosen(join(distribute(FLAccidents.BaseFile_FLCrash1,hash(accident_nbr)),d2,left.accident_nbr= right.accident_nbr,left only,local),1000),named('FLAccidents_flcrash1_sample_QA'));
d03:= output(choosen(join(distribute(FLAccidents.BaseFile_FLCrash2v,hash(accident_nbr)),d3,left.accident_nbr= right.accident_nbr,left only,local),1000),named('FLAccidents_flcrash2v_sample_QA'));
d04 := output(choosen(join(distribute(FLAccidents.BaseFile_FLCrash3v,hash(accident_nbr)),d4,left.accident_nbr= right.accident_nbr,left only,local),1000),named('FLAccidents_flcrash3v_sample_QA'));
d05 := output(choosen(join(distribute(FLAccidents.BaseFile_FLCrash4,hash(accident_nbr)),d5,left.accident_nbr= right.accident_nbr,left only,local),1000),named('FLAccidents_flcrash4_sample_QA'));
d06 := output(choosen(join(distribute(FLAccidents.BaseFile_FLCrash5,hash(accident_nbr)),d6,left.accident_nbr= right.accident_nbr,left only,local),1000),named('FLAccidents_flcrash5_sample_QA'));
d07 := output(choosen(join(distribute(FLAccidents.BaseFile_FLCrash6,hash(accident_nbr)),d7,left.accident_nbr= right.accident_nbr,left only,local),1000),named('FLAccidents_flcrash6_sample_QA'));
d08 := output(choosen(join(distribute(FLAccidents.BaseFile_FLCrash7,hash(accident_nbr)),d8,left.accident_nbr= right.accident_nbr,left only,local),1000),named('FLAccidents_flcrash7_sample_QA'));
d09 := output(choosen(join(distribute(FLAccidents.BaseFile_FLCrash8,hash(accident_nbr)),d9,left.accident_nbr= right.accident_nbr,left only,local),1000),named('FLAccidents_flcrash8_sample_QA'));
d010 := output(choosen(join(distribute(FLAccidents.BaseFile_FLCrash_did,hash(accident_nbr)),d10,left.accident_nbr= right.accident_nbr,left only,local),1000),named('FLAccidents_flcrash_did_sample_QA'));


export Sample_data := parallel(
								d01
								,d02
								,d03
								,d04
								,d05
								,d06
								,d07
								,d08
								,d09
								,d010
								);
	