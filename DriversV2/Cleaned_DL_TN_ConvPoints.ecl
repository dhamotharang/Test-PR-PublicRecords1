import ut, _validate;

export Cleaned_DL_TN_ConvPoints(string filedate) := function
  
  conv_file       			:= driversv2.file_dl_tn_conv_raw(filedate);
  layout_all_cln  			:= driversv2.layouts_dl_tn_in.layout_tn_cp_all_cleaned;

	layout_all_cln mapcleanconv(conv_file l) := transform,skip(l.dl_number = '')
	
	  self.process_date   := if(_validate.date.fisvalid(l.process_date),l.process_date,'');
		self.dl_number      := ut.cleanspacesandupper(l.dl_number);
		self.birthdate      := if(_validate.date.fisvalid(l.birthdate) and
	                            _validate.date.fisvalid(l.birthdate,_validate.date.rules.dateinpast),l.birthdate,'');		
		self.action_code 		:= ut.cleanspacesandupper(l.action_code);							   
	  self.event_date     := if(_validate.date.fisvalid(l.event_date) and
	                            _validate.date.fisvalid(l.event_date,_validate.date.rules.dateinpast),l.event_date,'');
		self.post_date      := if(_validate.date.fisvalid(l.post_date) and
	                            _validate.date.fisvalid(l.post_date,_validate.date.rules.dateinpast),l.post_date,'');
		self.last_name      := ut.cleanspacesandupper(l.last_name);
		self.county_code    := ut.cleanspacesandupper(l.county_code);	
		
  end;

	cleaned_tn_conv       := project(conv_file, mapcleanconv(left));			 
	cleaned_tn_dl_cp_all  := sequential(output(cleaned_tn_conv,,driversv2.constants.cluster+'in::dl2::tn_cp_clean_update::'+ filedate,overwrite),
																			fileservices.startsuperfiletransaction(),
																			fileservices.addsuperfile(driversv2.constants.cluster + 'in::dl2::tn_cp_clean_updates::superfile', 
																			driversv2.constants.cluster +'in::dl2::tn_cp_clean_update::'+filedate), 
																			fileservices.finishsuperfiletransaction()
																			);
                  
	return cleaned_tn_dl_cp_all;
	
end;