import Standard,Suppress, driversv2_services, autostandardI;
export fn_dob_mask_Addition(
             dataset( driversV2_services.layouts.result_narrow) pre_dobmasking)
               := function
			
dob_mask_value := AutoStandardI.InterfaceTranslator.dob_mask_value.val(
	                  project(autostandardI.globalmodule(),AutoStandardI.InterfaceTranslator.dob_mask_value.params)); 			

	layout_dobmask := record
		driversV2_services.layouts.result_narrow;
		Standard.Date.Datestr dob_masked;
	end;
	
	layout_dobmask pre_dm_trans(driversV2_services.layouts.result_narrow L) := transform
	  self.dob_masked := ROW ({'', '', ''}, Standard.Date.Datestr);
		self := L;
	end;
	
	pre_dobmask_ready := project(pre_dobmasking,pre_dm_trans(left));
	
	Suppress.MAC_Mask_Date(pre_dobmask_ready, post_dobmasking_ready, dob, dob_masked, dob_mask_value);
	
	return(post_dobmasking_ready);
	
	end;