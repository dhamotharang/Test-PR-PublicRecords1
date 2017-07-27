import ut;
export Superfile_list := MODULE
	EXPORT Load            := '~thor_data400::in::TransunionCred_load';
	EXPORT Load_father     := '~thor_data400::in::TransunionCred_load_father';
	EXPORT Updates         := '~thor_data400::in::TransunionCred_updates';
	EXPORT Updates_history := '~thor_data400::in::TransunionCred_updates_history';
	EXPORT Updates_history_compressed := '~thor_data400::in::TransunionCred_updates_history_compressed';
	EXPORT Updates_father  := '~thor_data400::in::TransunionCred_updates_father';
	EXPORT Base            := '~thor_data400::base::TransunionCred';
	EXPORT Base_prev       := '~thor_data400::base::TransunionCred_father';
	EXPORT Deletes         := '~thor_data400::in::TransunionCred_deletes';
	EXPORT Deletes_father  := '~thor_data400::in::TransunionCred_deletes_father';
END;