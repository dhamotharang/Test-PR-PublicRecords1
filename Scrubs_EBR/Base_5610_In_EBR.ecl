import Scrubs_EBR, EBR, Data_Services, Tools;

dl_or_prod := if(Tools._Constants.IsDataland, data_services.foreign_prod, '~'); 

dBase := dataset(dl_or_prod + 'thor_data400::base::ebr_5610_Demographic_Data', EBR.layout_5610_Demographic_Data_base,thor); 
	
	// Transform to flatten the file due to nested fields in the Base layout
	Scrubs_EBR.Base_5610_Layout_EBR trf(EBR.Layout_5610_Demographic_Data_Base l):= transform
		  self.clean_officer_name_title       := l.clean_officer_name.title;
			self.clean_officer_name_fname       := l.clean_officer_name.fname;
			self.clean_officer_name_mname       := l.clean_officer_name.mname;
			self.clean_officer_name_lname       := l.clean_officer_name.lname;
			self.clean_officer_name_name_suffix := l.clean_officer_name.name_suffix;
			self.clean_officer_name_name_score  := l.clean_officer_name.name_score;
			self                          	    := l;																				
			self														    := [];
	end; 

  EXPORT Base_5610_In_EBR := project(dBase, trf(left));
