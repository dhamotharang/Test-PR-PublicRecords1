clear_father := parallel(
										FileServices.ClearSuperFile('~thor200_144::in::sex_offender::hd::DEFENDANT_father'),
										FileServices.ClearSuperFile('~thor200_144::in::sex_offender::hd::OFFENSE_father'),
										FileServices.ClearSuperFile('~thor200_144::in::sex_offender::hd::CHARGE_father'),
										FileServices.ClearSuperFile('~thor200_144::in::sex_offender::hd::ALIAS_father'),
										FileServices.ClearSuperFile('~thor200_144::in::sex_offender::hd::PRIOR_father'),
										FileServices.ClearSuperFile('~thor200_144::in::sex_offender::hd::OTHER_father'),
										FileServices.ClearSuperFile('~thor200_144::in::sex_offender::hd::ADDRESS_HISTORY_father'),
										FileServices.ClearSuperFile('~thor200_144::in::sex_offender::hd::SENTENCE_father'));
	
move_to_father := parallel(
										FileServices.AddSuperFile('~thor200_144::in::sex_offender::hd::DEFENDANT_father', '~thor200_144::in::sex_offender::hd::DEFENDANT',, true),
										FileServices.AddSuperFile('~thor200_144::in::sex_offender::hd::OFFENSE_father', '~thor200_144::in::sex_offender::hd::OFFENSE',, true),
										FileServices.AddSuperFile('~thor200_144::in::sex_offender::hd::CHARGE_father', '~thor200_144::in::sex_offender::hd::CHARGE',, true),
										FileServices.AddSuperFile('~thor200_144::in::sex_offender::hd::ALIAS_father', '~thor200_144::in::sex_offender::hd::ALIAS',, true),
										FileServices.AddSuperFile('~thor200_144::in::sex_offender::hd::PRIOR_father', '~thor200_144::in::sex_offender::hd::PRIOR',, true),
										FileServices.AddSuperFile('~thor200_144::in::sex_offender::hd::OTHER_father', '~thor200_144::in::sex_offender::hd::OTHER',, true),
										FileServices.AddSuperFile('~thor200_144::in::sex_offender::hd::ADDRESS_HISTORY_father', '~thor200_144::in::sex_offender::hd::ADDRESS_HISTORY',, true),
										FileServices.AddSuperFile('~thor200_144::in::sex_offender::hd::SENTENCE_father', '~thor200_144::in::sex_offender::hd::SENTENCE',, true));

							
export Move_Files := sequential(FileServices.StartSuperFileTransaction(),
												clear_father, 
												move_to_father,
												FileServices.FinishSuperFileTransaction());