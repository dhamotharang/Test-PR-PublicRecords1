import BIPV2,BIPV2_DotID,BIPV2_Build, DCAV2,DNB_DMI,frandx,BIPv2_HRCHY,BIPV2_LGID3,BIPV2_Files,BIPV2_Tools,BIPV2_ProxID, SALT30;

  cb := bipv2.CommonBase.ds_prod;
	//Infile0 := dataset('~thor::cemtemp::myrecs.dl2', recordof(cb), thor);
	infile  := dataset('~thor::cemtemp::myrecs2', recordof(cb), thor);
	mylncad  := dataset('~thor::persist.cemtemp.mylncad', DCAV2.layouts.Base.companies, thor);
	mydunsd  := dataset('~thor::persist.cemtemp.mydunsd', DNB_DMI.layouts.base.CompaniesForBIP2, thor);
	myfrand  := dataset('~thor::persist.cemtemp.myfrand', frandx.layouts.Base, thor);

		Infile_Layout_Dot 			:= project(Infile, BIPV2_DotID.Layout_DOT);
	  Infile_Layout_Dot_Base 	:= project(Infile, BIPV2_ProxID.Layout_DOT_Base);
	  Infile_Layout_LGID3 := project(Infile, BIPV2_LGID3.Layout_LGID3);
	  BIPV2_DotID.specificities(Infile_Layout_Dot).Build;
	  BIPV2_ProxID.specificities(Infile_Layout_Dot_Base).Build;
	  BIPV2_LGID3.specificities(Infile_Layout_LGID3).Build;