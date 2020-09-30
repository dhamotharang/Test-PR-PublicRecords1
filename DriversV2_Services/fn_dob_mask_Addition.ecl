IMPORT Standard,Suppress, driversv2_services, autostandardI;
EXPORT fn_dob_mask_Addition(
             DATASET( driversV2_services.layouts.result_narrow) pre_dobmasking)
               := FUNCTION
      
dob_mask_value := AutoStandardI.InterfaceTranslator.dob_mask_value.val(
                    PROJECT(autostandardI.globalmodule(),AutoStandardI.InterfaceTranslator.dob_mask_value.params));

  layout_dobmask := RECORD
    driversV2_services.layouts.result_narrow;
    Standard.Date.Datestr dob_masked;
  END;
  
  layout_dobmask pre_dm_trans(driversV2_services.layouts.result_narrow L) := TRANSFORM
    SELF.dob_masked := ROW ({'', '', ''}, Standard.Date.Datestr);
    SELF := L;
  END;
  
  pre_dobmask_ready := PROJECT(pre_dobmasking,pre_dm_trans(LEFT));
  
  Suppress.MAC_Mask_Date(pre_dobmask_ready, post_dobmasking_ready, dob, dob_masked, dob_mask_value);
  
  RETURN(post_dobmasking_ready);
  
  END;
