IMPORT PRTE2_Common;

FileList := Dataset([
'prct::base::ct::email_data_v2::20171108::alpha_base',
'prct::base::ct::email_data_v2::20171108::alpha_spreadsheet_base',
'prct::base::ct::liensv2_alpha_main_w20161209-110410',
'prct::base::ct::liensv2_alpha_main_w20161214-135721',
'prct::base::ct::liensv2_alpha_party_w20161209-110410',
'prct::base::ct::liensv2_alpha_party_w20161214-135721',
'prct::base::ct::propertyinfo::alpha_final_base_w20170929-174700',
'prct::base::ct::propertyinfo::alpha_mv_base_w20170929-174700',
'prct::in::ct::liensv2_alpha::main_w20161209-110410',
'prct::in::ct::liensv2_alpha::party_w20161209-110410',
'prct::sprayed::ct::email_data_v2::spreadsheet::w20150818-130428'
			], {STRING name});

// stringLayout := {STRING step};
{STRING step} documentSteps	(FileList L) := TRANSFORM
		SELF.step := L.name;
END;
OUTPUT(StringSteps);
TODO := nothor(sequential(StringSteps := NORMALIZE(FileList,1,documentSteps(LEFT));
   											output(StringSteps,named('file_list_to_remove_SF')),
												apply( FileList,
													sequential(PRTE2_Common.SuperFiles.checkSFandDeleteLogical(name))
													)));
TODO;
