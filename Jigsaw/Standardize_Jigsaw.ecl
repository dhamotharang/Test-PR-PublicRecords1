import Address, Ut, lib_stringlib, _Control, business_header,_Validate, idl_header;

// -- standardize name
export Standardize_Jigsaw :=
module

	//////////////////////////////////////////////////////////////////////////////////////
	// -- fPreProcess
	// -- add proprietary dates
	//////////////////////////////////////////////////////////////////////////////////////
	export fPreProcess(
		 dataset(Layouts.Input.Sprayed	)	pLiveSprayedFile
		,dataset(Layouts.Input.Sprayed	)	pDeadSprayedFile
	
		,string pversion
	) :=
	function
	
		dconcatsprayedfiles := 
			pLiveSprayedFile
		+ pDeadSprayedFile
		;
	
		Layouts.Base tPreProcessJigsaw(Layouts.Input.Sprayed l) :=
		transform

			//////////////////////////////////////////////////////////////////////////////////////
			// -- Map Fields
			//////////////////////////////////////////////////////////////////////////////////////
			self.dt_first_seen							:= (integer)regexreplace('-',l.updatetimestamp[1..10],'') ;												;	
			self.dt_last_seen								:= (integer)regexreplace('-',l.updatetimestamp[1..10],'')  ;
			self.dt_vendor_first_reported		:= (unsigned4)pversion			;
			self.dt_vendor_last_reported		:= (unsigned4)pversion			;
			self.record_type				    		:= 'C'							;
			self.rawfields.phone            := Address.CleanPhone(l.phone[2..])  ;           
			self.rawfields									:= l;							
			self.raw_aid										:= 0;
			self.ace_aid										:= 0;
			SELF														:= []; 
		end;
 		
		
		dPreProcess := project(dconcatsprayedfiles, tPreProcessJigsaw(left));
	
		return dPreProcess; 
     
	end;

	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fStandardizeName
	// -- Standardizes names
	//////////////////////////////////////////////////////////////////////////////////////
	export fStandardizeName(dataset(Layouts.Base) pPreProcessInput) :=
	function

		Layouts.Base tStandardizeName(Layouts.Base l) :=
		transform

			//////////////////////////////////////////////////////////////////////////////////////
			// -- Clean Name, determine if it is a person
			//////////////////////////////////////////////////////////////////////////////////////
			name := trim(l.rawfields.firstname) + ' ' + trim(l.rawfields.lastname) ;
			self.clean_name	:= Address.Clean_n_Validate_Name(name,'F',0).CleanNameRecord;
			
			//////////////////////////////////////////////////////////////////////////////////////
			// -- Map Fields
			//////////////////////////////////////////////////////////////////////////////////////
			self													:= l																			;
		end;
		
		dStandardizedName := project(pPreProcessInput, tStandardizeName(left));
		
		//** Flipping the names that are wrongly cleaned by name cleaner.
		ut.mac_flipnames(dStandardizedName, clean_name.fname, clean_name.mname, clean_name.lname, dStandardizedName_flipnames)
			
		return dStandardizedName_flipnames;

	end;

	export fAll(
		 dataset(Layouts.Input.Sprayed	)	pLiveSprayedFile
		,dataset(Layouts.Input.Sprayed	)	pDeadSprayedFile
		,string pversion
	) :=
	function
	  
		dPreprocess					:= fPreProcess			 		(pLiveSprayedFile,pDeadSprayedFile,pversion);
		dStandardizeName		:= fStandardizeName		 	(dPreprocess)			: persist(persistnames().StandardizeJigsaw);

		return dStandardizeName;

	end;

end;
