import ut;
export Superfile_list := MODULE
	EXPORT Load             := '~thor_data400::in::fcra::experiancred_load';
	EXPORT Load_father      := '~thor_data400::in::fcra::experiancred_load_father';
	EXPORT Updates          := '~thor_data400::in::FCRA::ExperianCred_updates';
	EXPORT Updates_father   := '~thor_data400::in::FCRA::ExperianCred_updates_father';
	EXPORT Updates_history  := '~thor_data400::in::FCRA::ExperianCred_updates_history';
	EXPORT Deletes          := '~thor_data400::in::FCRA::ExperianCred_deletes';
	EXPORT Deletes_father   := '~thor_data400::in::FCRA::ExperianCred_deletes_father';
	EXPORT Deletes_history  := '~thor_data400::in::FCRA::ExperianCred_deletes_history';
	EXPORT Deceased         := '~thor_data400::in::FCRA::ExperianCred_Deceased';
	EXPORT Deceased_father  := '~thor_data400::in::FCRA::ExperianCred_Deceased_father';
	EXPORT Deceased_history := '~thor_data400::in::FCRA::ExperianCred_Deceased_history';
	EXPORT Base             := '~thor_data400::base::FCRA::ExperianCred';
	EXPORT Base_prev        := '~thor_data400::base::FCRA::ExperianCred_father';
END;