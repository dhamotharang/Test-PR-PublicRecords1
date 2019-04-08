import Liensv2,ut, STD;


main_dataset := dataset('~thor_data400::in::liensv2::main::dummy_irs',liensv2.layout_liens_main_module.layout_liens_main,flat);

LiensV2.Layout_liens_main_module_for_hogan.layout_liens_main change_dummy_ver(main_dataset d) := transform
	self.process_date := (string8)STD.Date.Today();
	self.orig_rmsid := '';
	self.agency_id_src := '';
	self := d;
end;

dummy_project := project(main_dataset,change_dummy_ver(left));

export File_Dummy_Main := dummy_project;