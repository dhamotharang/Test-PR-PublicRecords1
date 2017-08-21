import lib_stringlib, mdr, ut;

export StandardizeInputFile := module

	export fPreProcess(dataset(CrashCarrier.Layouts.Input.Sprayed) pRawFileInput, string pversion) := function    
	
		carrier_source_code_set := ['1','2','3','4',' ']; //1=Side of Vehicle, 2=Shipping Papers(Truck) or Trip Manifest(Bus), 3=Driver, 4=Log Book or Blank		


		CleanZipCode(string zipcode='0')	:=	function
    //Expecting all numeric data and either a 5 digit zip or a 9 digit zip
    //Otherwise a blank is returned. 
		  Zip := StringLib.StringFilter(zipcode,'0123456789');
			FinalZip := if (length(Zip) = 5
											,Zip
											,if (length(Zip) = 9
													,Zip[1..5] + '-' + Zip[6..9]
													,''
													)
											);									
			return FinalZip;
		end;	//end CleanZipCode function

		CrashCarrier.Layouts.base	trfCrashCarrierFile(Layouts.Input.Sprayed l)	:=	transform
				self.source_rec_id 							:= hash64(ut.CleanSpacesAndUpper(l.carrier_id)						
																								 ,ut.CleanSpacesAndUpper(l.crash_id)					
																								 ,ut.CleanSpacesAndUpper(l.carrier_source_code)
																								 ,ut.CleanSpacesAndUpper(l.carrier_name)		
																								 ,ut.CleanSpacesAndUpper(l.carrier_street)
																								 ,ut.CleanSpacesAndUpper(l.carrier_city)
																								 ,ut.CleanSpacesAndUpper(l.carrier_city_code)
																								 ,ut.CleanSpacesAndUpper(l.carrier_state)		
																								 ,ut.CleanSpacesAndUpper(l.carrier_zip_code)
																								 ,ut.CleanSpacesAndUpper(l.crash_colonia)
																								 ,ut.CleanSpacesAndUpper(l.prefix)
																								 ,ut.CleanSpacesAndUpper(l.docket_number)
																								 ,ut.CleanSpacesAndUpper(l.interstate)
																								 ,ut.CleanSpacesAndUpper(l.no_id_flag)
																								 ,ut.CleanSpacesAndUpper(l.state_number)			
																								 ,ut.CleanSpacesAndUpper(l.state_issuing_number)
																							 );
				self.dt_first_seen 							:= (unsigned4)pversion;
				self.dt_last_seen 							:= (unsigned4)pversion;		
				self.dt_vendor_first_reported		:= (unsigned4)pversion;
				self.dt_vendor_last_reported		:= (unsigned4)pversion;
				self.raw.carrier_id							:= ut.CleanSpacesAndUpper(l.carrier_id); 					//8 digits all numbers
				self.raw.crash_id								:= ut.CleanSpacesAndUpper(l.crash_id);							//8 digits all numbers
			  self.raw.carrier_source_code		:= ut.CleanSpacesAndUpper(l.carrier_source_code);
				self.raw.carrier_name						:= ut.CleanSpacesAndUpper(l.carrier_name);	
				self.raw.carrier_street					:= ut.CleanSpacesAndUpper(l.carrier_street);
				self.raw.carrier_city 					:= ut.CleanSpacesAndUpper(l.carrier_city);
				self.raw.carrier_city_code 			:= ut.CleanSpacesAndUpper(l.carrier_city_code); 		//currently all blanks
				self.raw.carrier_state 					:= ut.CleanSpacesAndUpper(l.carrier_state);
				self.raw.carrier_zip_code				:= ut.CleanSpacesAndUpper(l.carrier_zip_code);
				self.raw.crash_colonia					:= ut.CleanSpacesAndUpper(l.crash_colonia);
				self.raw.prefix									:= ut.CleanSpacesAndUpper(l.prefix);
				self.raw.docket_number					:= ut.CleanSpacesAndUpper(l.docket_number);
				self.raw.interstate							:= ut.CleanSpacesAndUpper(l.interstate);
				self.raw.no_id_flag							:= ut.CleanSpacesAndUpper(l.no_id_flag);
				self.raw.state_number						:= ut.CleanSpacesAndUpper(l.state_number);
				self.raw.state_issuing_number		:= ut.CleanSpacesAndUpper(l.state_issuing_number);
				self.source											:= MDR.sourceTools.src_CrashCarrier;
				//The next statement will eliminate any carrier_name with UNKNOWN (e.g. UNKNOWN CARRIER, UNKNOWN (USE ONLY FOR ACCIDENTS), UNKNOWN, etc.
				self.cleaned_carrier_name				:= if(~regexfind('(UNKNOWN)|(INDIVIDUAL)|(HIT AND RUN)|(NOT AVAILABLE)|(SAME AS OWNER)|(UNKNOKN)|(UKNOWN)|(UNK)', ut.CleanSpacesAndUpper(l.carrier_name)),ut.CleanSpacesAndUpper(l.carrier_name), '');		
				//The next statement will eliminate any carrier_street with UNKNOWN (e.g. UNKNOWN and UNKNOWN ADDRESS
				self.cleaned_carrier_street			:= if(~regexfind('(UNKNOWN)', ut.CleanSpacesAndUpper(l.carrier_street)), ut.CleanSpacesAndUpper(l.carrier_street), '');
				self.cleaned_carrier_city 			:= if(~regexfind('(UNKNOWN)', ut.CleanSpacesAndUpper(l.carrier_city)), ut.CleanSpacesAndUpper(l.carrier_city), '');				
				self.cleaned_carrier_state 			:= if(ut.CleanSpacesAndUpper(l.carrier_state) IN Valid_States,ut.CleanSpacesAndUpper(l.carrier_state),'');
				self.cleaned_carrier_zip_code		:= CleanZipCode(l.carrier_zip_code);
				self.cleaned_prefix							:= if (ut.CleanSpacesAndUpper(l.prefix) IN ['MC','MX','FF'],ut.CleanSpacesAndUpper(l.prefix),'');
				self.carrier_name_source_desc		:= map(ut.CleanSpacesAndUpper(l.carrier_city_code) = '1' => 'SIDE OF VEHICLE',
																							 ut.CleanSpacesAndUpper(l.carrier_city_code) = '2' => 'SHIPPING PAPERS (TRUCK) OR TRIP MANIFEST (BUS)',
																							 ut.CleanSpacesAndUpper(l.carrier_city_code) = '3' => 'DRIVER',
																							 ut.CleanSpacesAndUpper(l.carrier_city_code) = '4' => 'LOG BOOK',
																							 '');
				self.interstate_desc						:= map(ut.CleanSpacesAndUpper(l.interstate) = 'N' => 'INTRASTATE',
																							 ut.CleanSpacesAndUpper(l.interstate) = 'Y' => 'INTERSTATE',
																							 ut.CleanSpacesAndUpper(l.interstate) = 'X' => 'NON-MOTOR CARRIER',
																							 '');																							 
				self.no_census_number_desc			:= map(ut.CleanSpacesAndUpper(l.interstate) = '0' => 'NO ID WAS AVAILABLE',
																							 ut.CleanSpacesAndUpper(l.interstate) = '1' => 'ID IS AVAILABLE',
																							 '');					
		 		self														:= l;
				self														:= [];
		end; //end trfCrashCarrierFile transform

		dRawProj				:=	project(pRawFileInput, trfCrashCarrierFile(left));

		noNameAddress 	:=  dRawProj.cleaned_carrier_name 	= '' and 
												dRawProj.cleaned_carrier_street = '' and
												dRawProj.cleaned_carrier_city 	= '' and
												dRawProj.cleaned_carrier_state  = '';	
		hasNameAddress 	:=  not noNameAddress;
		
		dPreProcess			:=  dRawProj(hasNameAddress);  //Remove records that do not have a business/person name and address
			
		return dPreProcess;

	end; //end fPreProcess function
   
	export fAll( dataset(CrashCarrier.Layouts.Input.Sprayed) pRawFileInput, string pversion) := function
		dPreprocess	:= fPreProcess(pRawFileInput,pversion): persist(Persistnames.StandardizeInput);
		return dPreprocess;
	end; //end fAll

end; //end StandardizeInputFile 