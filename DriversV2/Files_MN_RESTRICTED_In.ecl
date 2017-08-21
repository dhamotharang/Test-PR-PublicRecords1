// Code originally created by Sandy Butler.
// READ ME NOW! READ ME NOW! READ ME NOW!
// All attributes that have the word RESTRICTED contain data for MN from OKC.  This data CANNOT be
//   part of the normal DL base and key files.  It will go through the normal DL process, but be
//   pulled out before the data becomes part of the base file.  Only if you have the LEGAL right to
//   access and use this data, should you even think about using the code or data.  When in doubt,
//   ask someone.
// READ ME NOW! READ ME NOW! READ ME NOW!

import DriversV2, Data_Services, ut, versioncontrol;

export Files_MN_RESTRICTED_In(string pversion = '') := module
   
	 //////////////////////////////////////////////////////////////////
   // -- Input File Versions
   //////////////////////////////////////////////////////////////////
	 versioncontrol.macInputFileVersions(DriversV2.Filenames(pversion,'mn_restricted_address').Input,DriversV2.layouts_dl_mn_restricted_in.address_rec,addr);
	 versioncontrol.macInputFileVersions(DriversV2.Filenames(pversion,'mn_restricted_license').Input,DriversV2.layouts_dl_mn_restricted_in.license_rec,license);
	 versioncontrol.macInputFileVersions(DriversV2.Filenames(pversion,'mn_restricted_misc').Input,DriversV2.layouts_dl_mn_restricted_in.misc_rec,misc);
	 versioncontrol.macInputFileVersions(DriversV2.Filenames(pversion,'mn_restricted_oper').Input,DriversV2.layouts_dl_mn_restricted_in.operator_rec,operator);
	 versioncontrol.macInputFileVersions(DriversV2.Filenames(pversion,'mn_restricted_restrict').Input,DriversV2.layouts_dl_mn_restricted_in.restriction_rec,restriction);
	 versioncontrol.macInputFileVersions(DriversV2.Filenames(pversion,'mn_restricted_viol').Input,DriversV2.layouts_dl_mn_restricted_in.violation_rec,violation);
	 //////////////////////////////////////////////////////////////////
   // -- Input File Versions of the "Rolled Up" file that includes
	 //		 all updates for a given driver that has ever been sent from 
	 //    the vendor (MN OKC).
   //////////////////////////////////////////////////////////////////
	 versioncontrol.macBuildFileVersions(DriversV2.Filenames(pversion,'mn_restricted_raw_common_base').Base,DriversV2.layouts_dl_mn_restricted_in.full_rec,Raw_Common_Base);

	 //////////////////////////////////////////////////////////////////////////
   // -- Alpharetta Base Files used as input in Data Fabrication's DL process
	 //    The files listed below are produced from the following thor file:
	 //    thor::mvr::prescreen::rfi::qa::mnokcrawplusbase.
	 //		 Production names: thor::mvr::prescreen::rfi::qa::mnokcrawplusbase
	 //    The *mnokcrawplusbase file contains all updated driver information;
	 //    no history is stored for a particular driver in the *mnokcrawplusbase
	 //    file.  However,all mn drivers exists within this file even if an update
	 //    wasn't received from OKC.
	 //    	 
	 //    The files below that end with "_poc" exist on Alpharetta's "Test" thor.
   //////////////////////////////////////////////////////////////////////////
	 export addr_alpha_poc 				:= dataset(Data_Services.foreign_poc + 'thor::mvr::prescreen::rfi::qa::mnokcaddressbase',DriversV2.layouts_dl_mn_restricted_in.address_rec,thor);
   export license_alpha_poc 		:= dataset(Data_Services.foreign_poc + 'thor::mvr::prescreen::rfi::qa::mnokclicensebase',DriversV2.layouts_dl_mn_restricted_in.license_rec,thor);
   export misc_alpha_poc 				:= dataset(Data_Services.foreign_poc + 'thor::mvr::prescreen::rfi::qa::mnokcmiscbase',DriversV2.layouts_dl_mn_restricted_in.misc_rec,thor);
   export operator_alpha_poc 		:= dataset(Data_Services.foreign_poc + 'thor::mvr::prescreen::rfi::qa::mnokcoperbase',DriversV2.layouts_dl_mn_restricted_in.operator_rec,thor);
   export restriction_alpha_poc := dataset(Data_Services.foreign_poc + 'thor::mvr::prescreen::rfi::qa::mnokcrestrictbase',DriversV2.layouts_dl_mn_restricted_in.restriction_rec,thor);
   export violation_alpha_poc 	:= dataset(Data_Services.foreign_poc + 'thor::mvr::prescreen::rfi::qa::mnokcviolbase',DriversV2.layouts_dl_mn_restricted_in.violation_rec,thor);
	 
	 export addr_alpha 						:= dataset(ut.foreign_aprod + 'thor::mvr::prescreen::rfi::qa::mnokcaddressbase',DriversV2.layouts_dl_mn_restricted_in.address_rec,thor);
   export license_alpha 				:= dataset(ut.foreign_aprod + 'thor::mvr::prescreen::rfi::qa::mnokclicensebase',DriversV2.layouts_dl_mn_restricted_in.license_rec,thor);
   export misc_alpha 						:= dataset(ut.foreign_aprod + 'thor::mvr::prescreen::rfi::qa::mnokcmiscbase',DriversV2.layouts_dl_mn_restricted_in.misc_rec,thor);
   export operator_alpha 				:= dataset(ut.foreign_aprod + 'thor::mvr::prescreen::rfi::qa::mnokcoperbase',DriversV2.layouts_dl_mn_restricted_in.operator_rec,thor);
   export restriction_alpha 		:= dataset(ut.foreign_aprod + 'thor::mvr::prescreen::rfi::qa::mnokcrestrictbase',DriversV2.layouts_dl_mn_restricted_in.restriction_rec,thor);
   export violation_alpha 			:= dataset(ut.foreign_aprod + 'thor::mvr::prescreen::rfi::qa::mnokcviolbase',DriversV2.layouts_dl_mn_restricted_in.violation_rec,thor);

end;
