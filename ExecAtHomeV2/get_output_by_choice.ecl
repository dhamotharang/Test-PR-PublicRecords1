export get_output_by_choice(grouped dataset(execathomev2.layout_bda_premium) f_final_in,
                            boolean prm_eah_flag, 
					   boolean std_bda_flag, 
					   boolean prm_bda_flag) := function
					   
file_eah_std := project(project(f_final_in, transform({execathomev2.layout_eah_standard}, self:=left)),
                                transform({execathomev2.layout_bda_premium}, self := left, self :=[]));

file_both_std := project(project(f_final_in, transform({execathomev2.layout_both_standard}, self:=left)),
                                transform({execathomev2.layout_bda_premium},  
						             self.business_best_fein := '', 
								   self := left, self :=[]));
		   			    
file_eah_prm := project(project(f_final_in, transform({execathomev2.layout_eah_premium}, self:=left)),
                                transform({execathomev2.layout_bda_premium}, self := left, self :=[]));					    
					    
file_bda_std := project(project(f_final_in, transform({execathomev2.layout_bda_standard}, self:=left)),
                                transform({execathomev2.layout_bda_premium}, 
						             self.business_best_fein := '', 
						             self := left, self :=[]));					    					    

file_bda_prm_only := project(project(f_final_in, transform({execathomev2.layout_bda_premium_only}, self:=left)),
                                transform({execathomev2.layout_bda_premium}, self := left, self :=[]));					    					    

file_bda_prm := f_final_in;			
			
return map(prm_eah_flag and std_bda_flag and prm_bda_flag => file_bda_prm,
           prm_eah_flag and ~std_bda_flag and prm_bda_flag => file_bda_prm,
		 prm_eah_flag and std_bda_flag and ~prm_bda_flag => file_bda_std,
		 prm_eah_flag and ~std_bda_flag and ~prm_bda_flag => file_eah_prm,
		 ~prm_eah_flag and std_bda_flag and prm_bda_flag => file_bda_prm_only,
		 ~prm_eah_flag and ~std_bda_flag and prm_bda_flag => file_bda_prm_only,
           ~prm_eah_flag and std_bda_flag and ~prm_bda_flag => file_both_std,
           file_eah_std);					    
					  
end;