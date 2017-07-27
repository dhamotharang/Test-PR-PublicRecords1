//WARNING: THIS KEY IS AN FCRA KEY...

import doxie, ut, doxie_files;

o6 := DriversV2.DL_Decoded (IsFCRA := true);

//Old name: '~thor_data400::key::dl_number_FCRA_'+doxie_build.buildstate+'_'+doxie.Version_SuperKey);
export Key_DL_Number_FCRA := 
  INDEX (O6, {s_dl := o6.dl_number}, 
         {dt_first_seen, source_code, orig_state, dl_number, lname, fname,
		  prim_range, prim_name, sec_range, orig_issue_date, lic_issue_date, orig_expiration_date},
		  '~thor_data400::key::dl2::fcra::'+ doxie.Version_SuperKey +'::dl_number');
          //'~thor_data400::key::dl2::fcra::dl_number_' + doxie.Version_SuperKey);

