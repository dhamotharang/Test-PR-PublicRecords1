clear_father := parallel(
										FileServices.ClearSuperFile('~thor200_144::in::sex_offender::hd::defendant_father_cw'),
										FileServices.ClearSuperFile('~thor200_144::in::sex_offender::hd::offense_father_cw'),
										FileServices.ClearSuperFile('~thor200_144::in::sex_offender::hd::alias_father_cw'),
										FileServices.ClearSuperFile('~thor200_144::in::sex_offender::hd::address_history_father_cw'));
	
move_to_father := parallel(
										FileServices.AddSuperFile('~thor200_144::in::sex_offender::hd::defendant_father_cw', '~thor200_144::in::sex_offender::hd::defendant_cw',, true),
										FileServices.AddSuperFile('~thor200_144::in::sex_offender::hd::offense_father_cw', '~thor200_144::in::sex_offender::hd::offense_cw',, true),
										FileServices.AddSuperFile('~thor200_144::in::sex_offender::hd::alias_father_cw', '~thor200_144::in::sex_offender::hd::alias_cw',, true),
										FileServices.AddSuperFile('~thor200_144::in::sex_offender::hd::address_history_father_cw', '~thor200_144::in::sex_offender::hd::address_history_cw',, true));

export Move_Files_CW := sequential(FileServices.StartSuperFileTransaction(),
												clear_father, 
												move_to_father,
												FileServices.FinishSuperFileTransaction());