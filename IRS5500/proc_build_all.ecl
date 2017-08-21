import Roxiekeybuild, _Control;
export proc_build_all(string filedate, string pFormYear) := 
module

	export build_base		:= Make_IRS5500_Company_Base(filedate, pFormYear ) : success(output('IRS 5500 Base File created.')), failure(send_email(filedate).BuildFailure);
	export build_key		:= proc_build_keys;
	export rename_key	:= proc_rename_key(filedate);
	
	export build_stuff :=
	sequential(
	
		 build_base
		,build_key
		,rename_key
	
	) : success(send_email(filedate).buildsuccess), failure(send_email(filedate).BuildFailure);
	
	export asbh			:= output(enth(fIRS5500_As_Business_Contact(File_IRS5500_Base_AID), 100), named(Dataset_Name + 'As_Business_Header'), all);
	export asbc			:= output(enth(fIRS5500_As_Business_Header (File_IRS5500_Base_AID), 100), named(Dataset_Name + 'As_Business_Contact'), all);
	export asbl			:= output(enth(fIRS5500_As_Business_Linking(File_IRS5500_Base_AID), 100), named(Dataset_Name + 'As_Business_Linking'), all);

	export asbh_stuff :=
	sequential(

		 asbh
		,asbc
		,asbl

	);

	export All :=
	sequential(

		 build_stuff
		,Strata_Grid_Stats(filedate)
		,asbh_stuff

	) : success(send_email(filedate).buildsuccess), failure(send_email(filedate).buildfailure);

end;
