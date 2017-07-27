import Address, Ut, lib_stringlib, _Control, business_header,_Validate;

// -- add unique id
// -- standardize name
// -- normalize and slim record for address cleaning, keep unique id
// -- normalize and slim record for date cleaning, keep unique id
// -- match back on unique id to get addresses and dates

export Standardize_Combined := 
module

	//////////////////////////////////////////////////////////////////////////////////////
	// -- fPreProcess
	// -- Get address ready for cleaning
	// -- add unique id
	// -- add proprietary dates
	//////////////////////////////////////////////////////////////////////////////////////
	export fPreProcess(dataset(Layouts.Pre_Standardize.Layout_Combined) pRawFileInput, string pversion) :=
	function
	
		

			//////////////////////////////////////////////////////////////////////////////////////
			// -- Prepare Addresses for Cleaning using macro
			//////////////////////////////////////////////////////////////////////////////////////
	   Layouts.Temporary.Layout_Combined tPreProcessCorpAddr(Layouts.Pre_Standardize.Layout_Combined L,Integer cnt) :=
		   transform	
			    SELF.address1 := CHOOSE(cnt,trim(l.Corporate_Address.Street),trim(l.Mailing_Address.Street));
		    	SELF.address2 := CHOOSE(cnt,trim(l.Corporate_Address.City_1),trim(l.Mailing_Address.City_1)) + ', ' + 
								           CHOOSE(cnt,trim(l.Corporate_Address.state),trim(l.Mailing_Address.state))  + ' ' +
								           CHOOSE(cnt,trim(l.Corporate_Address.uszip),trim(l.Mailing_Address.uszip));			
			    SELF.rawfields := L;								 
			    SELF := [];
       end;
		
		
		
			//////////////////////////////////////////////////////////////////////////////////////
			// -- Map Fields
			//////////////////////////////////////////////////////////////////////////////////////
		  Layouts.Temporary.Layout_Combined tPreProcess(Layouts.Temporary.Layout_Combined L,unsigned8 cnt) :=
		  transform	
				 self.unique_id							:= cnt;
				 self.clean_phone           := ut.CleanPhone(l.rawfields.phone_numbers.nbr1);
			   //self.dt_first_seen						:= fConvDts(l.IssueDate);
			   //self.dt_last_seen						:= fConvDts(l.DateLastRenewal)  ;
			   self.dt_vendor_first_reported		:= (unsigned4)pversion;
			   self.dt_vendor_last_reported			:= (unsigned4)pversion;
			   self.record_type									:= 'C';
			   self.rawfields							      := l;
				 SELF := L;
			   SELF := []; 
		end;
 		
			dPreProcess_Address := NORMALIZE(pRawFileInput,2,tPreProcessCorpAddr(left,counter))(address1 <> '');
	    dPreProcess := PROJECT(dPreProcess_Address,tPreProcess(LEFT,counter));
		return dPreProcess; 
  end;

	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fStandardizeName
	// -- Standardizes names
	//////////////////////////////////////////////////////////////////////////////////////
	export fStandardizeName(dataset(Layouts.Temporary.Layout_Combined) pPreProcessInput) :=
	function

		Layouts.Temporary.Layout_Combined tStandardizeName(Layouts.Temporary.Layout_Combined l) :=
		transform

			//////////////////////////////////////////////////////////////////////////////////////
			// -- Clean Name, determine if it is a person
			//////////////////////////////////////////////////////////////////////////////////////
			name := trim(l.rawfields.executives.executivename);
			self.clean_name	:= Address.Clean_n_Validate_Name(name,'F',,,false).CleanNameRecord;
			
			//////////////////////////////////////////////////////////////////////////////////////
			// -- Map Fields
			//////////////////////////////////////////////////////////////////////////////////////
			self													:= l																			;
		end;
		
		dStandardizedName := project(pPreProcessInput, tStandardizeName(left));
		
		return dStandardizedName;

	end;


	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fStandardizeAddresses
	// -- Standardizes addresses
	//////////////////////////////////////////////////////////////////////////////////////
	export fStandardizeAddresses(dataset(Layouts.Temporary.Layout_Combined) pStandardizeNameInput) :=
	function

		//////////////////////////////////////////////////////////////////////////////////////
		// -- Second, pass addresses to macro for cleaning
		// -- normalize address out into one file with address1, address2, type, and uniqueid, then pass to macro
		//////////////////////////////////////////////////////////////////////////////////////
		addresslayout :=
		record
			unsigned8									unique_id			;	//to tie back to original record
			string1										address_type	    ;   // location or mailing
			string100 								address1			;
			string50									address2			;
		end;
		
		addresslayout tNormalizeAddress(Layouts.Temporary.Layout_Combined l) :=
		transform
			self.unique_id						:= l.unique_id	;
			self.address_type					:= 'M';
			self.address1							:= l.address1;
			self.address2							:= l.address2
		end;
		
		dAddressPrep	:= PROJECT(pStandardizeNameInput, tNormalizeAddress(left));
   
		HasAddress		:= 	trim(dAddressPrep.address1, left,right) != ''
						     	and trim(dAddressPrep.address2, left,right) != '';
				
		dWith_address		:= dAddressPrep(HasAddress);
		dWithout_address	:= dAddressPrep(not(HasAddress));

		// -- Standardize the address 
		/*address.mac_address_clean( dWith_address
															,address1
															,address2
															,true
															,dAddressStandardized
														); */
		//-------------------------------------------------	
		//THIS IS A WORKAROUND. SHOULD USE CACHE MACRO!!!
		 Layout_clean_addr := RECORD
		  addresslayout;
		  string182 clean;
		 end;
		 
		 dAddressStandardized := PROJECT(dAddressPrep, 
		                                 TRANSFORM(Layout_clean_addr,
										                           self.clean := Address.CleanAddress182(LEFT.address1,LEFT.address2);self := left;));
	  //--------------------------------------------------												
		// -- match back to dStandardizedFirstPass and append address
		// dStandardizeNameInput_dist := distribute(pStandardizeNameInput	,unique_id);
		// dAddressStandardized_dist	:= distribute(dAddressStandardized	,unique_id);
		 dStandardizeNameInput_dist := pStandardizeNameInput;
		 dAddressStandardized_dist	:= dAddressStandardized;
		

		Layouts.Temporary.Layout_Combined tGetStandardizedAddress(Layouts.Temporary.Layout_Combined l	
		                                                          ,dAddressStandardized_dist r) :=
		transform
			self.Clean_address	:= Address.CleanAddressFieldsFips(r.clean).addressrecord;
			self := L;
		
		end;
		
		dCleanMailingAddressAppended	:= join( dStandardizeNameInput_dist
											    ,dAddressStandardized_dist
											    ,left.unique_id = right.unique_id
											    ,tGetStandardizedAddress(left,right)
												,HASH
											    //,local
											    ,left outer
											     );

		return dCleanMailingAddressAppended;
		
	end;
	
 	
	
	
	export fAll(dataset(Layouts.Pre_Standardize.Layout_Combined) pRawFileInput, string pversion) :=
	function
	
		dPreprocess				:= fPreProcess					(pRawFileInput,pversion	);
		dStandardizeName		:= fStandardizeName			(dPreprocess						);
		dStandardizeAddress	:= fStandardizeAddresses(dStandardizeName				);
		
		dStandardizedBaseFile := PROJECT(dStandardizeAddress,
		                                 TRANSFORM(Layouts.Base.Layout_Combined,SELF := LEFT;)) 		 
			                                           : persist ('persist::RedBooks::Standardize_All');
		 		                                         //: persist(Persistnames.standardizeAll);
	                                                                                                                             
		return dStandardizedBaseFile;
	
	end;

end;