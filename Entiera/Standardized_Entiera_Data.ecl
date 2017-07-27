import Address,Ut,_Validate,did_add,header,header_slimsort, didville, did_add,watchdog;

 
// this function sets up the dataset so that its ready to be processed
// going to use this dataset to run through name/address/date standization first. 
 fPreProcess(dataset(entiera.All_Entiera_Layouts.Entiera_Raw_Data_In) pRawFileInput) :=
	function
	
		entiera.All_Entiera_Layouts.Entiera_preprocess_layout tPreProcess(entiera.All_Entiera_Layouts.Entiera_Raw_Data_In l, unsigned8 cnt) :=
		transform
    //set up address fields to be passed into address cleaning macro.
	       
		v_address1 := trim(l.orig_address);
		v_address2 :=	trim(l.orig_city) + ', '+ trim(l.orig_state) + ' ' + trim(l.orig_zip) + ' ';
		
		self.address1 := v_address1;
		self.address2 := v_address2;
		
		//need this to normalize records. this is essentially used to send to the cleaner just
		//information it needs and not the whole record for efficiency as well as to reconstruct
		//the record again.
		self.unique_id:= cnt;
    
		//cleaned data. Its done this way so that the clean name and clean addresses can be mapped automatically
		//rather than being individudally mapped.
		self.clean_name :=[];
    self.clean_address:=[];
 
    //set fields to uppercase.
		self.orig_first_name:=stringlib.stringtouppercase(trim(l.orig_first_name));
		self.orig_last_name:=stringlib.stringtouppercase(trim(l.orig_last_name));
		self.orig_address:=stringlib.stringtouppercase(trim(l.orig_address));
		self.orig_city:=stringlib.stringtouppercase(trim(l.orig_city));
		self.orig_state:=stringlib.stringtouppercase(trim(l.orig_state));
		self.orig_email:=stringlib.stringtouppercase(trim(l.orig_email));
		self.orig_site:=stringlib.stringtouppercase(trim(l.orig_site));
		self:=l;
		end;

   dPreProcess := project(pRawFileInput, tPreProcess(left,counter));
	
		return dPreProcess;

	end;


	 fStandardizeName(dataset(entiera.All_Entiera_Layouts.Entiera_preprocess_layout) pPreProcessInput) :=
	function

		entiera.All_Entiera_Layouts.Entiera_preprocess_layout tStandardizeName(entiera.All_Entiera_Layouts.Entiera_preprocess_layout l) :=
		transform
			
			//Name cleaning
			v_assembled_name 	:=	trim(l.orig_last_name) + ', ' +	trim(l.orig_first_name);
			v_clean_name			:= Address.CleanPersonLFM73_fields(v_assembled_name).CleanNameRecord;
		  
			//mapping                                                                
			self.clean_name		:= v_clean_name;
			self							:= l;
		end;
		
		dStandardizedName := project(pPreProcessInput, tStandardizeName(left));
		
		return dStandardizedName;

	end;


//standardize addresses
fStandardizeAddresses(dataset(entiera.All_Entiera_Layouts.Entiera_preprocess_layout) pStandardizeNameInput) :=
	function

		//////////////////////////////////////////////////////////////////////////////////////
		// -- Second, pass addresses to macro for cleaning
		// -- normalize address out into one file with address1, address2, type, and uniqueid, then pass to macro
		//////////////////////////////////////////////////////////////////////////////////////
		addresslayout :=
		record
			unsigned8										unique_id			;	//to tie back to original record
			string100 									address1			;
			string50										address2			;
		end;
		
		addresslayout tProjectAddress(entiera.All_Entiera_Layouts.Entiera_preprocess_layout l) :=
		transform

			self.unique_id							:= l.unique_id	;
			self.address1								:= l.address1		;
			self.address2								:= l.address2		;
			
		end;
		
		dAddressPrep	:= project(pStandardizeNameInput, tProjectAddress(left));

	//output(dAddressPrep);
	
	HasAddress		:= 		trim(dAddressPrep.address1, left,right) != ''
										and trim(dAddressPrep.address2, left,right) != '';
										
		dWith_address			:= dAddressPrep(HasAddress);
		dWithout_address	:= dAddressPrep(not(HasAddress));

		// -- Standardize the address 
		address.mac_address_clean( dWith_address
															,address1
															,address2
															,true
															,dAddressStandardized
														);
														
		// -- match back to dStandardizedFirstPass and append address
		dStandardizeNameInput_dist 	:= sort(distribute(pStandardizeNameInput	,unique_id),unique_id,local);//orig ds coming in
		dAddressStandardized_dist		:= sort(distribute(dAddressStandardized	,unique_id),unique_id,local);//ds after cleaning

		entiera.All_Entiera_Layouts.Entiera_preprocess_layout tGetStandardizedAddress(entiera.All_Entiera_Layouts.Entiera_preprocess_layout l	,dAddressStandardized_dist r) :=
		transform

			v_clean_address	:= Address.CleanAddressFieldsFips(r.clean).addressrecord;

			self.clean_address	:= v_clean_address;

			self 								:= l;
		
		end;
		
		dCleancontactAddressAppended	:= join(
																 dStandardizeNameInput_dist
																,dAddressStandardized_dist
																,left.unique_id = right.unique_id
																,tGetStandardizedAddress(left,right)
																,local
																,left outer
															);

		return dCleancontactAddressAppended;
		
	end;



// run all functions above and get ready to did.
ds_preprocess := fPreProcess(entiera.file_entiera_data_supply_in);
ds1:=fStandardizeName(ds_preprocess);
ds2:=fStandardizeAddresses(ds1);


//layout
did_rec_layout:=record
string20 fname;
string20 mname;
string20 lname;
string10 prim_range; 	// [1..10]
string28 prim_name;
string5  name_suffix;	// [13..40]
string8  sec_range;	// [57..64]
string2  st;			// [115..116]
string5  zip;		// [117..121]
unsigned6 did       :=0;
unsigned	did_score :=0;
unsigned8 unique_id;
end;

// need to do this so that the macro can read the fields in properly. 
// also sending only the required fields and not the whole record for efficiency.
 did_rec_layout tStandardizeDate(ds2 l) := transform
 self.fname := l.clean_name.fname;
 self.mname := l.clean_name.mname;
 self.lname := l.clean_name.lname;
 self.name_suffix :=l.clean_name.name_suffix;
 self.prim_range := l.clean_address.prim_range;
 self.prim_name := l.clean_address.prim_name;
 self.sec_range := l.clean_address.sec_range;
 self.st			  :=l.clean_address.st;
 self.zip				:=l.clean_address.zip;
 self.did		    :=l.did;
 self.did_score :=l.did_score;
 self.unique_id :=l.unique_id;
 self := l;
 end;
 prep_did_ds := project(ds2, tStandardizeDate(left));



matchset :=['A','Z'];
did_add.MAC_Match_Flex
	(prep_did_ds, matchset,					
	 '', '', fname, mname, lname, name_suffix, 
	 prim_range, prim_name, sec_range, zip, st,'', 
	 did, did_rec_layout, true, did_score,
	 75, outfile)


    did_dupd := dedup(outfile,record);

    origds_withoutdid   := sort(distribute(ds2,unique_id),unique_id,local);
    did_dupd_distrib    := sort(distribute(did_dupd,unique_id),unique_id,local);
		
		entiera.All_Entiera_Layouts.Entiera_preprocess_layout tGetStandardizedDates(entiera.All_Entiera_Layouts.Entiera_preprocess_layout l	,did_rec_layout r) :=
		transform

			self.did						  := r.did;
			self.did_score				:= r.did_score;
			self 									:= l;

		end;
		
		//make sure you do not lose records that do not get did'ed.
		dDID_records	:= join(
																 origds_withoutdid
																,did_dupd_distrib
																,left.unique_id = right.unique_id
																,tGetStandardizedDates(left,right)
																,local
																,left outer
															);




// need to append ssn. might as well add the process date here.
entiera.All_Entiera_Layouts.Entiera_final_layout tDefault_ssn(dDID_records l) := transform
self:=l;
end;

entiera_did_emptySSN := project(dDID_records, tDefault_ssn(left));

//append SSN
did_add.MAC_Add_SSN_By_DID(entiera_did_emptySSN, did, best_ssn, entiera_did_withSSN);


//append DOB
recordof(entiera_did_withSSN) append_dob (recordof(entiera_did_withSSN) l	,recordof(watchdog.File_Best) r) :=
		transform
	self.best_dob := r.dob;
	self := l;
end;
entiera_did_withSSNDOB:= JOIN(entiera_did_withSSN, watchdog.File_Best, LEFT.did=RIGHT.did, append_dob(LEFT,RIGHT), LEFT OUTER, LOCAL);
		

export Standardized_Entiera_Data := entiera_did_withSSNDOB:persist('Standardized_Entiera_Data');



