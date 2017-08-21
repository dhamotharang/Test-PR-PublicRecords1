import Address, Ut, lib_stringlib, _Control, _Validate,aid;

// -- Merge Entity and SVCAddr file 
// -- normalize and slim record for date cleaning, keep unique id
// -- match back on unique id to get addresses and dates
export Standardize_Input := module

	//////////////////////////////////////////////////////////////////////////////////////
	// -- fPreProcess
	// -- Get address ready for cleaning
	// -- add unique id
	// -- add proprietary dates
	//////////////////////////////////////////////////////////////////////////////////////
	
	//////////////////////////////////////////////////////////////////////////////////////////
	// - Standardize the address and join name parts to make the company name
	//////////////////////////////////////////////////////////////////////////////////////////
	export fPreProcess(dataset(Layouts.Input.Sprayed) pInput
										 ,string 												pversion) :=
	function
		
		Layouts.Temporary.teletrack tCleanFields(Layouts.Input.Sprayed l) :=	transform
			//////////////////////////////////////////////////////////////////////////////////////
			// -- Prepare Addresses for AID Cleaning using macro
			//////////////////////////////////////////////////////////////////////////////////////
			address1 :=	Address.Addr1FromComponents(
										stringlib.stringtouppercase(
										lib_StringLib.StringLib.StringCleanSpaces(
											regexreplace('NULL',trim(l.Street_Num,left,right),'',NOCASE) + ' ' + 
											regexreplace('NULL',trim(l.Street_Name,left,right),'',NOCASE) + ' ' + 
											regexreplace('NULL',trim(l.Street_type,left,right),'',NOCASE)	+ ' ' + 
											regexreplace('NULL',trim(l.Street_Direction,left,right),'',NOCASE) + ' ' + 
											regexreplace('NULL',trim(l.Apartment,left,right),'',NOCASE)))
										,''
										,''
										,''
										,''
										,''
										,''
									);        
			address2 :=	Address.Addr2FromComponents(
										stringlib.stringtouppercase(regexreplace('NULL',trim(l.City,left,right),'',NOCASE))
									 ,stringlib.stringtouppercase(regexreplace('NULL',trim(l.State,left,right),'',NOCASE))
									 ,regexreplace('NULL',trim(l.Zip_Code,left,right)[1..5],'',NOCASE)
									);                

			//*** Clean Name
			string73 tempname 	:= if(trim(trim(l.first_name,left,right) + ' ' +
																	trim(l.last_name,left,right),left,right) <> '',
																			stringlib.StringToUpperCase(
																				Address.CleanPersonFML73(trim(regexreplace('NULL',trim(l.first_name,left,right),'',NOCASE) + ' ' +
																																			regexreplace('NULL',trim(l.middle_name,left,right),'',NOCASE) + ' ' +
																																			regexreplace('NULL',trim(l.last_name,left,right),'',NOCASE) + ' ' +
																																			regexreplace('NULL',trim(l.generation,left,right),'',NOCASE),left,right))
																		),'');
																				
			pname 							:= Address.CleanNameFields(tempname);
			HPhone							:= 	ut.CleanPhone(trim(l.Home_Phone,left,right)		);
			WPhone							:= 	ut.CleanPhone(trim(l.Work_Phone,left,right)		);
																										
                                
			//////////////////////////////////////////////////////////////////////////////////////
			// -- Map Fields
			//////////////////////////////////////////////////////////////////////////////////////
			self.raw_aid										:= 0;
			self.ace_aid										:= 0;
			self.address1 									:= address1;
			self.address2 									:= address2;
			self.dt_first_seen							:= (integer)regexreplace('-',l.time_stamp[1..10],'') ;												;	
			self.dt_last_seen								:= (integer)regexreplace('-',l.time_stamp[1..10],'')  ;
			self.dt_vendor_first_reported		:= (unsigned4)pversion			;
			self.dt_vendor_last_reported		:= (unsigned4)pversion			;
			self.clean_hphone								:= if((integer)HPhone <> 0, HPhone, '');
			self.clean_wphone								:= if((integer)WPhone <> 0, WPhone, '');
			
			self.Clean_name.title			      := pname.title;
			self.Clean_name.fname			      := pname.fname;
			self.Clean_name.mname			      := pname.mname;
			self.Clean_name.lname			      := pname.lname;
			self.Clean_name.name_suffix	    := pname.name_suffix;
			self.Clean_name.name_score			:= pname.name_score;
			
   		self.rawfields.Work_Place				:= regexreplace('NULL',stringlib.StringToUpperCase(trim(l.work_place,left,right)),'');
			self.rawfields.Work_city				:= regexreplace('NULL',stringlib.StringToUpperCase(trim(l.work_city,left,right)),'');
			self.rawfields.Work_state				:= regexreplace('NULL|--',stringlib.StringToUpperCase(trim(l.work_state,left,right)),'');
			self.rawfields.time_stamp				:= trim(l.time_stamp,left,right);
			self.rawfields.ssn							:= regexreplace('NULL|null|Null',trim(l.ssn,left,right),'');
			self.rawfields									:= l;
			
			//**
			/*
			self.Work_Place				:= regexreplace('NULL',stringlib.StringToUpperCase(trim(l.work_place,left,right)),'');
			self.Work_city				:= regexreplace('NULL',stringlib.StringToUpperCase(trim(l.work_city,left,right)),'');
			self.Work_state				:= regexreplace('NULL',stringlib.StringToUpperCase(trim(l.work_state,left,right)),'');
			self.time_stamp				:= trim(l.time_stamp,left,right);
			self.ssn							:= trim(l.ssn,left,right);
			//self.Clean_name.title						:= Address.CleanNameFields(tempname);
			self.title			      := pname.title;
			self.fname			      := pname.fname;
			self.mname			      := pname.mname;
			self.lname			      := pname.lname;
			self.name_suffix	    := pname.name_suffix;
			self.name_score				:= pname.name_score;
			self									:=  l;
			//**
			*/
			self														:= [];
		end;
		
		dCleaned := project(pInput, tCleanFields(left));
		
		return dCleaned;

	end;
	

	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fStandardizeAddresses
	// -- Standardizes addresses
	//////////////////////////////////////////////////////////////////////////////////////
	export fStandardizeAddresses(dataset(Layouts.Temporary.Teletrack) pStandardizeNameInput) :=
	function

		HasAddress	:=	trim(pStandardizeNameInput.address1, left,right) != ''
								and trim(pStandardizeNameInput.address2, left,right) != '';
										
		dWith_address			:= pStandardizeNameInput(HasAddress);
		dWithout_address	:= pStandardizeNameInput(not(HasAddress));

		unsigned4	lFlags 	:= AID.Common.eReturnValues.ACEAIDs | AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;	

		AID.MacAppendFromRaw_2Line(dWith_address, Address1, Address2, Raw_AID, dwithAID, lFlags);
		
		dCommon := project(
			dwithAID
			,transform(
				Layouts.Base
				,
				self.ace_aid										:= left.aidwork_acecache.aid					;
				self.raw_aid										:= left.aidwork_rawaid								;
				
				self.clean_address.fips_state 	:= left.aidwork_acecache.county[1..2]	;
				self.clean_address.fips_county	:= left.aidwork_acecache.county[3..]	;
				self.clean_address.zip					:= left.aidwork_acecache.zip5					;
				self.clean_address							:= left.aidwork_acecache							;
				/*
				//**
				self.prim_range									:= left.aidwork_acecache.prim_range;
				self.predir 	            			:= left.aidwork_acecache.predir;
				self.prim_name 	  	        		:= left.aidwork_acecache.prim_name;
				self.addr_suffix   	       			:= left.aidwork_acecache.addr_suffix;
				self.postdir 	    	    				:= left.aidwork_acecache.postdir;
				self.unit_desig 	        			:= left.aidwork_acecache.unit_desig;
				self.sec_range 	  	        		:= left.aidwork_acecache.sec_range;
				self.p_city_name	        			:= left.aidwork_acecache.p_city_name;
				self.v_city_name	      				:= left.aidwork_acecache.v_city_name;
				self.st		 			       					:= left.aidwork_acecache.st;
				self.zip												:= left.aidwork_acecache.zip5;
				self.zip4 		           				:= left.aidwork_acecache.zip4;
				self.cart 		            			:= left.aidwork_acecache.cart;
				self.cr_sort_sz 	 	    				:= left.aidwork_acecache.cr_sort_sz;
				self.lot 		      	    				:= left.aidwork_acecache.lot;
				self.lot_order 	  	        		:= left.aidwork_acecache.lot_order;
				self.dbpc 		            			:= left.aidwork_acecache.dbpc;
				self.chk_digit 	  	       			:= left.aidwork_acecache.chk_digit;
				self.rec_type		  	    				:= left.aidwork_acecache.rec_type;
				self.fips_state 								:= left.aidwork_acecache.county[1..2]	;
				self.fips_county								:= left.aidwork_acecache.county[3..]	;
				self.geo_lat 	    	    				:= left.aidwork_acecache.geo_lat;
				self.geo_long 	           			:= left.aidwork_acecache.geo_long;
				self.msa 		      	    				:= left.aidwork_acecache.msa;
				self.geo_blk										:= left.aidwork_acecache.geo_blk;
				self.geo_match 	  	        		:= left.aidwork_acecache.geo_match;
				self.err_stat 	            		:= left.aidwork_acecache.err_stat;								
				//**
				*/
				self														:= left;
				self														:= [];
			)
		)
		+ project(dWithout_address,transform(Layouts.Base, self := left, self := []));

		return dCommon;
		
	end;

	
	
	export fAll( dataset(Layouts.input.Sprayed)	pInput
							,string															pversion
	) :=
	function
	
		dPreprocess						:= fPreProcess(pInput, pversion);
		dStandardizeAddress		:= fStandardizeAddresses(dPreprocess);// : persist(persistnames().StandardizeTeletrack);
			
  	return dStandardizeAddress;
	
	end;

end;