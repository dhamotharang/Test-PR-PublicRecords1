import Address, Ut, lib_stringlib, _Control, business_header,_Validate,aid;

// -- prep address for cleaning
// -- map data to the base layout

export Standardize_Input :=
module

	//////////////////////////////////////////////////////////////////////////////////////
	// -- fPreProcess
	// -- Get address ready for cleaning
	// -- add proprietary dates
	//////////////////////////////////////////////////////////////////////////////////////
	export fPreProcess(
		 dataset(Layouts.Input.Sprayed	)	pSprayedFile
		,string														pversion
	) :=
	function
	
		dconcatsprayedfiles := 
			pSprayedFile
		;
	
		Layouts.Base tPreProcess(Layouts.Input.Sprayed l) :=
		transform

			//////////////////////////////////////////////////////////////////////////////////////
			// -- Map Fields
			//////////////////////////////////////////////////////////////////////////////////////
			self.dt_first_seen								:= (unsigned4)l.LastInquiryDate				;	
			self.dt_last_seen									:= (unsigned4)l.LastInquiryDate				;
			self.dt_vendor_first_reported			:= (unsigned4)pversion								;
			self.dt_vendor_last_reported			:= (unsigned4)pversion								;
			self.record_type				    			:= 'C'																;
			self.Clean_phones.HomePhone		  	:= (unsigned5)Address.CleanPhone(l.HomePhone	);           
			self.Clean_phones.MobilePhone	  	:= (unsigned5)Address.CleanPhone(l.MobilePhone);           
			self.Clean_phones.WorkPhone		  	:= (unsigned5)Address.CleanPhone(l.WorkPhone	);           
			self.Clean_phones.Ref1Phone		  	:= (unsigned5)Address.CleanPhone(l.Ref1Phone	);           
			self.Clean_dates.DOB							:= (unsigned4)l.DOB													;           
			self.Clean_dates.LastInquiryDate	:= (unsigned4)l.LastInquiryDate							;           
			self.rawfields										:= l																				;
			self.raw_home_aid									:= 0																				;
			self.ace_home_aid									:= 0																				;
			self.raw_work_aid									:= 0																				;
			self.ace_work_aid									:= 0																				;
			self.prep_home_addr_line1 		 	  := ''                                       ;
		  self.prep_home_addr_line_last	   	:= ''                                       ;
		  self.prep_work_addr_line1				 	:= ''                                       ;
		  self.prep_work_addr_line_last	   	:= ''                                       ;
			self.global_sid 									:= 25721;
			SELF															:= []		  																	; 
		end;
 		
		
		dPreProcess := project(dconcatsprayedfiles, tPreProcess(left));
	
		return dPreProcess; 
	end;

     
	export fAll(
		 dataset(Layouts.Input.Sprayed	)	pSprayedFile
		,string														pversion
	) :=
	function
	  
		dPreprocess					:= fPreProcess(pSprayedFile,pversion)	: persist(persistnames().StandardizeInput);
	                                                                                                                             
		return dPreprocess;
	
	end;

end;