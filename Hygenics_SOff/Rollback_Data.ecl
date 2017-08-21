import ut;


export Rollback_Data(string state,string current_version,string prev_version,string current_thorname,string prev_thorname) := function


string current_DefFile := current_thorname+'::'+state+'_sex_offender_registry_defendant.csv_'+current_version;
string current_OffFile := current_thorname+'::'+state+'_sex_offender_registry_offense.csv_'+current_version;
string current_chargeFile := current_thorname+'::'+state+'_sex_offender_registry_charge.csv_'+current_version;
string current_aliasFile := current_thorname+'::'+state+'_sex_offender_registry_alias.csv_'+current_version;
string current_priorFile := current_thorname+'::'+state+'_sex_offender_registry_prior.csv_'+current_version;
string current_otherFile := current_thorname+'::'+state+'_sex_offender_registry_other.csv_'+current_version;
string current_addHisFile := current_thorname+'::'+state+'_sex_offender_registry_address_history.csv_'+current_version;
string current_sentFile := current_thorname+'::'+state+'_sex_offender_registry_sentence.csv_'+current_version;

string prev_DefFile := prev_thorname+'::'+state+'_sex_offender_registry_defendant.csv_'+prev_version;
string prev_OffFile := prev_thorname+'::'+state+'_sex_offender_registry_offense.csv_'+prev_version;
string prev_chargeFile := prev_thorname+'::'+state+'_sex_offender_registry_charge.csv_'+prev_version;
string prev_aliasFile := prev_thorname+'::'+state+'_sex_offender_registry_alias.csv_'+prev_version;
string prev_priorFile := prev_thorname+'::'+state+'_sex_offender_registry_prior.csv_'+prev_version;
string prev_otherFile := prev_thorname+'::'+state+'_sex_offender_registry_other.csv_'+prev_version;
string prev_addHisFile := prev_thorname+'::'+state+'_sex_offender_registry_address_history.csv_'+prev_version;
string prev_sentFile := prev_thorname+'::'+state+'_sex_offender_registry_sentence.csv_'+prev_version;


remove_lf_from_qa := parallel(
										IF (FileServices.FileExists (current_DefFile),	FileServices.RemoveSuperFile('~thor200_144::in::sex_offender::hd::DEFENDANT', current_DefFile)),
										IF (FileServices.FileExists (current_OffFile),	FileServices.RemoveSuperFile('~thor200_144::in::sex_offender::hd::OFFENSE', current_OffFile)),
										IF (FileServices.FileExists (current_chargeFile),	FileServices.RemoveSuperFile('~thor200_144::in::sex_offender::hd::CHARGE', current_chargeFile)),
										IF (FileServices.FileExists (current_aliasFile),	FileServices.RemoveSuperFile('~thor200_144::in::sex_offender::hd::ALIAS', current_aliasFile)),
										IF (FileServices.FileExists (current_priorFile),	FileServices.RemoveSuperFile('~thor200_144::in::sex_offender::hd::PRIOR', current_priorFile)),
										IF (FileServices.FileExists (current_otherFile),	FileServices.RemoveSuperFile('~thor200_144::in::sex_offender::hd::OTHER', current_otherFile)),
										IF (FileServices.FileExists (current_addHisFile),	FileServices.RemoveSuperFile('~thor200_144::in::sex_offender::hd::ADDRESS_HISTORY', current_addHisFile)),
										IF (FileServices.FileExists (current_sentFile),	FileServices.RemoveSuperFile('~thor200_144::in::sex_offender::hd::SENTENCE', current_sentFile)));

remove_lf_from_father := parallel(
										IF (FileServices.FileExists (prev_DefFile),	FileServices.RemoveSuperFile('~thor200_144::in::sex_offender::hd::DEFENDANT_father', prev_DefFile)),
										IF (FileServices.FileExists (prev_OffFile),	FileServices.RemoveSuperFile('~thor200_144::in::sex_offender::hd::OFFENSE_father', prev_OffFile)),
										IF (FileServices.FileExists (prev_chargeFile),	FileServices.RemoveSuperFile('~thor200_144::in::sex_offender::hd::CHARGE_father', prev_chargeFile)),
										IF (FileServices.FileExists (prev_aliasFile),	FileServices.RemoveSuperFile('~thor200_144::in::sex_offender::hd::ALIAS_father', prev_aliasFile)),
										IF (FileServices.FileExists (prev_priorFile),	FileServices.RemoveSuperFile('~thor200_144::in::sex_offender::hd::PRIOR_father', prev_priorFile)),
										IF (FileServices.FileExists (prev_otherFile),	FileServices.RemoveSuperFile('~thor200_144::in::sex_offender::hd::OTHER_father', prev_otherFile)),
										IF (FileServices.FileExists (prev_addHisFile),	FileServices.RemoveSuperFile('~thor200_144::in::sex_offender::hd::ADDRESS_HISTORY_father', prev_addHisFile)),
										IF (FileServices.FileExists (prev_sentFile),	FileServices.RemoveSuperFile('~thor200_144::in::sex_offender::hd::SENTENCE_father', prev_sentFile)));
										
move_prevlf_to_qa := parallel(
										IF (FileServices.FileExists (prev_DefFile),	FileServices.AddSuperFile('~thor200_144::in::sex_offender::hd::DEFENDANT', prev_DefFile)),
										IF (FileServices.FileExists (prev_OffFile),	FileServices.AddSuperFile('~thor200_144::in::sex_offender::hd::OFFENSE', prev_OffFile)),
										IF (FileServices.FileExists (prev_chargeFile),	FileServices.AddSuperFile('~thor200_144::in::sex_offender::hd::CHARGE', prev_chargeFile)),
										IF (FileServices.FileExists (prev_aliasFile),	FileServices.AddSuperFile('~thor200_144::in::sex_offender::hd::ALIAS', prev_aliasFile)),
										IF (FileServices.FileExists (prev_priorFile),	FileServices.AddSuperFile('~thor200_144::in::sex_offender::hd::PRIOR', prev_priorFile)),
										IF (FileServices.FileExists (prev_otherFile),	FileServices.AddSuperFile('~thor200_144::in::sex_offender::hd::OTHER', prev_otherFile)),
										IF (FileServices.FileExists (prev_addHisFile),	FileServices.AddSuperFile('~thor200_144::in::sex_offender::hd::ADDRESS_HISTORY', prev_addHisFile)),
										IF (FileServices.FileExists (prev_sentFile),	FileServices.AddSuperFile('~thor200_144::in::sex_offender::hd::SENTENCE', prev_sentFile)));
										

rollback := sequential(FileServices.StartSuperFileTransaction(),
												remove_lf_from_qa, 
												remove_lf_from_father,
												move_prevlf_to_qa,
												FileServices.FinishSuperFileTransaction());
												
return rollback;

END;