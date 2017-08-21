export files := 
MODULE

	export base_name 		:= '~thor_data400::base::header::Overlink';
	export newfile_name := base_name + thorlib.wuid();

	export Overlink_QA_name := 			base_name + '_QA';
	export Overlink_QA := 					dataset(Overlink_QA_name, 					ManualLink_Services.layouts.Overlink, thor);
	export Overlink_father_name := 	base_name + '_father';
	export Overlink_father := 			dataset(Overlink_father_name, 			ManualLink_Services.layouts.Overlink, thor);
	export Overlink_grandfather_name := base_name + '_grandfather';
	export Overlink_grandfather := 	dataset(Overlink_grandfather_name, ManualLink_Services.layouts.Overlink, thor);
	export Overlink_delete_name :=	base_name + '_delete';
	export Overlink_delete := 			dataset(Overlink_delete_name, 			ManualLink_Services.layouts.Overlink, thor);
	
	export UnApplied := Overlink_QA(date_applied_to_header = '');

END;