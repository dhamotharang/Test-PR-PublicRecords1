import FLAccidents, ut,VehLic;

ds_FLCrash0_in	:=	FLAccidents.InFile_FLCrash0_v4;
ds_FLCrash1_in	:=	FLAccidents.InFile_FLCrash1_v4;

ds_FLCrash2v_in	:=	FLAccidents.FLAccidents_vina_append	(
						FLAccidents.InFile_FLCrash2v_v4,
						FLAccidents.InFile_FLCrash3v_v4
														).FLCrash2_layout;

ds_FLCrash3v_in	:=	FLAccidents.FLAccidents_vina_append	(
						FLAccidents.InFile_FLCrash2v_v4
						,FLAccidents.InFile_FLCrash3v_v4
														).FLCrash3_layout;

ds_FLCrash4_in	:=	FLAccidents.InFile_FLCrash4_v4;
ds_FLCrash5_in	:=	FLAccidents.InFile_FLCrash5_v4;
ds_FLCrash6_in	:=	FLAccidents.InFile_FLCrash6_v4;
ds_FLCrash7_in	:=	FLAccidents.InFile_FLCrash7_v4;
ds_FLCrash8_in	:=	FLAccidents.InFile_FLCrash8_v4;
ds_FLCrash9_in	:= 	FLAccidents.InFile_FLCrash9_v4;		//New witness file


r_FLCrash2v_out	:=	FLAccidents.Layout_FLCrash2v_v2;
r_FLCrash2v_out	tr_FLCrash2v_out(ds_FLCrash2v_in le) := transform
	self   				:= le;
	self   				:= [];
end;

ds_FLCrash2v_temp := project(ds_FLCrash2v_in,tr_FLCrash2v_out(left),local);
flaccidents.mac_fixMakeModel(ds_FLCrash2v_temp,vehicle_id_nbr,ds_FLCrash2v_out);


r_FLCrash3v_out	:=	FLAccidents.Layout_FLCrash3v_v2;
r_FLCrash3v_out	tr_FLCrash3v_out(ds_FLCrash3v_in le) := transform
	self   				:= le;
	self   				:= [];
end;

ds_FLCrash3v_temp := project(ds_FLCrash3v_in,tr_FLCrash3v_out(left),local);
flaccidents.mac_fixMakeModel(ds_FLCrash3v_temp,towed_trlr_veh_id_nbr,ds_FLCrash3v_out);


prod_FLCrash0 := dataset('~thor_data400::in::flcrash0_father',
                                    FLAccidents.Layout_FLCrash0_v2, flat);

//////////////////////

prod_FLCrash1 := dataset('~thor_data400::in::flcrash1_father',
                                    FLAccidents.Layout_FLCrash1, flat);

//////////////////////

prod_FLCrash2v_temp := dataset('~thor_data400::in::flcrash2v_father',
                                    FLAccidents.Layout_FLCrash2v_v2, flat);
mac_fixMakeModel(prod_FLCrash2v_temp,vehicle_id_nbr,prod_FLCrash2v);
//////////////////////

prod_FLCrash3v_temp := dataset('~thor_data400::in::flcrash3v_father',
                                    FLAccidents.Layout_FLCrash3v_v2, flat);
mac_fixMakeModel(prod_FLCrash3v_temp,towed_trlr_veh_id_nbr,prod_FLCrash3v);
//////////////////////

prod_FLCrash4 := dataset( '~thor_data400::in::flcrash4_father',
                                    FLAccidents.Layout_FLCrash4_v2, flat);

//////////////////////

prod_FLCrash5 := dataset( '~thor_data400::in::flcrash5_father',
                                    FLAccidents.Layout_FLCrash5_v2, flat);

//////////////////////

prod_FLCrash6 := dataset('~thor_data400::in::flcrash6_father',
                                    FLAccidents.Layout_FLCrash6_v2, flat);
//////////////////////
prod_FLCrash7 := dataset('~thor_data400::in::flcrash7_father',
                                    FLAccidents.Layout_FLCrash7_v2, flat);

/////////////////////////

prod_FLCrash8 := dataset('~thor_data400::in::flcrash8_father',
										FLAccidents.Layout_FLCrash8, flat);

/////////////////////////
prod_FLCrash9 := dataset(ut.foreign_prod+'thor_data400::in::flcrash9_father',
										FLAccidents.Layout_FLCrash9, flat);

EXPORT Proc_build_input  :=
parallel(
		sequential	(
			output(dedup(ds_FLCrash0_in + prod_FLCrash0(rec_type_o='0'),all),,'~thor_data400::in::FLCrash0_'+ FLAccidents.Version_Development,compressed,overwrite),
						FileServices.ClearSuperFile('~thor_data400::in::FLCrash0'),

			FileServices.AddSuperfile('~thor_data400::in::flcrash0'
										,'~thor_data400::in::FLCrash0_'+ FLAccidents.Version_Development)),
		sequential	(
			output(dedup(ds_FLCrash1_in + prod_FLCrash1(rec_type_1='1'),all),,'~thor_data400::in::FLCrash1_'+ FLAccidents.Version_Development,compressed,overwrite),
						FileServices.ClearSuperFile('~thor_data400::in::FLCrash1'),

			FileServices.AddSuperfile('~thor_data400::in::FLCrash1'
										,'~thor_data400::in::FLCrash1_'+ FLAccidents.Version_Development)),
		sequential	(
			output(dedup(ds_FLCrash2v_out  + prod_FLCrash2v(rec_type_2='2'),all),,'~thor_data400::in::FLCrash2v_'+ FLAccidents.Version_Development,compressed,overwrite),
						FileServices.ClearSuperFile('~thor_data400::in::FLCrash2v'),

			FileServices.AddSuperfile('~thor_data400::in::FLCrash2v'
										,'~thor_data400::in::FLCrash2v_'+ FLAccidents.Version_Development)),
		sequential	(
			output(dedup(ds_FLCrash3v_out + prod_FLCrash3v(rec_type_3='3'),all),,'~thor_data400::in::FLCrash3v_'+ FLAccidents.Version_Development,compressed,overwrite),
			FileServices.ClearSuperFile('~thor_data400::in::FLCrash3v'),
			FileServices.AddSuperfile('~thor_data400::in::FLCrash3v'
										,'~thor_data400::in::FLCrash3v_'+ FLAccidents.Version_Development)),
										
		sequential	(
			output(dedup(ds_FLCrash4_in + prod_FLCrash4(rec_type_4='4'),all),,'~thor_data400::in::FLCrash4_'+ FLAccidents.Version_Development,compressed,overwrite),
			FileServices.ClearSuperFile('~thor_data400::in::FLCrash4'),
			FileServices.AddSuperfile('~thor_data400::in::FLCrash4'
										,'~thor_data400::in::FLCrash4_'+ FLAccidents.Version_Development)),
		sequential	(
			output(dedup(ds_FLCrash5_in + prod_FLCrash5(rec_type_5='5'),all),,'~thor_data400::in::FLCrash5_'+ FLAccidents.Version_Development,compressed,overwrite),
			FileServices.ClearSuperFile('~thor_data400::in::FLCrash5'),
			FileServices.AddSuperfile('~thor_data400::in::FLCrash5'
										,'~thor_data400::in::FLCrash5_'+ FLAccidents.Version_Development)),
		sequential	(
			output(dedup(ds_FLCrash6_in + prod_FLCrash6(rec_type_6='6'),all),,'~thor_data400::in::FLCrash6_'+ FLAccidents.Version_Development,compressed,overwrite),
			FileServices.ClearSuperFile('~thor_data400::in::FLCrash6'),
			FileServices.AddSuperfile('~thor_data400::in::FLCrash6'
										,'~thor_data400::in::FLCrash6_'+ FLAccidents.Version_Development)),
		sequential	(
			output(dedup(ds_FLCrash7_in + prod_FLCrash7(rec_type_7='7'),all),,'~thor_data400::in::FLCrash7_'+ FLAccidents.Version_Development,compressed,overwrite),
			FileServices.ClearSuperFile('~thor_data400::in::FLCrash7'),
			FileServices.AddSuperfile('~thor_data400::in::FLCrash7'
										,'~thor_data400::in::FLCrash7_'+ FLAccidents.Version_Development)),
		sequential	(
			output(dedup(ds_FLCrash8_in + prod_FLCrash8(rec_type_8='8'),all),,'~thor_data400::in::FLCrash8_'+ FLAccidents.Version_Development,compressed,overwrite),
			FileServices.ClearSuperFile('~thor_data400::in::FLCrash8'),
			FileServices.AddSuperfile('~thor_data400::in::FLCrash8'
										,'~thor_data400::in::FLCrash8_'+ FLAccidents.Version_Development)),
		sequential	(
			output(dedup(ds_FLCrash9_in + prod_FLCrash9(rec_type_9='9'),all),,'~thor_data400::in::FLCrash9_'+ FLAccidents.Version_Development,compressed,overwrite),
			FileServices.ClearSuperFile('~thor_data400::in::FLCrash9'),
			FileServices.AddSuperfile('~thor_data400::in::FLCrash9'
										,'~thor_data400::in::FLCrash9_'+ FLAccidents.Version_Development))
										
		);