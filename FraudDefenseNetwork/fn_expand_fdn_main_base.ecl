IMPORT Data_Services, RoxieKeyBuild;
EXPORT fn_expand_fdn_main_base(string pdate) := FUNCTION
 
	old_fdn_base := dataset(Data_Services.foreign_prod+'thor_data400::base::fdn::qa::main',Exp_Base_Layouts.main, thor); 

	old_base_conv := project(old_fdn_base, transform(Layouts.Base.Main,
																										self := left;
																										self := []));
	old_base_conv_dist := distribute(old_base_conv, hash32(record_id));	 

	RoxieKeyBuild.Mac_SF_BuildProcess_V2(old_base_conv_dist,'~thor_data400::base::fdn','main', pdate, new_fdn_base,3,false,true);
	
 RETURN new_fdn_base;
END;