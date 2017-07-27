import iesp, ut, codes, STD;

export Functions := module

	export fnHuntFishVal(dataset(hunting_fishing_services.Layouts.raw_rec) in_recs, string in_city = '') := function
	
		ms(string70 a, string70 b, string70 c) :=
			map(a = '' => b,
					b = '' => a,
					ut.StringSimilar(a,c) <= ut.StringSimilar(b,c) => a,b);

    // Used to replace spaces in date strings with zeroes so cast to integer works Ok
	  fixed_date(string8 dtin) := STD.Str.FindReplace(dtin, ' ', '0');
						 
	  iesp.huntingfishing_fcra.t_FcraHuntFishRecord xform(hunting_fishing_services.Layouts.raw_rec l, codes.key_Codes_V3 r) := TRANSFORM		
			self.Name.Full   		:= '',
			self.Name.First  		:= l.fname,
			self.Name.Middle 		:= l.mname,
			self.Name.Last   		:= l.lname,
			self.Name.Suffix 		:= l.name_suffix,
			self.Name.Prefix 		:= l.title,

			// ouput residence address fields first		
			self.Address.StreetNumber        		:= l.prim_range,
			self.Address.StreetPreDirection  		:= l.predir,
			self.Address.StreetName          		:= l.prim_name,
			self.Address.StreetSuffix       		:= l.suffix,
			self.Address.StreetPostDirection 		:= l.postdir,
			self.Address.UnitDesignation     		:= l.unit_desig,
			self.Address.UnitNumber         		:= l.sec_range,
			self.Address.StreetAddress1      		:= '',
			self.Address.StreetAddress2      		:= '',
			self.Address.State        					:= l.st,
			self.Address.City            				:= trim(ms(l.p_city_name, l.city_name, in_city),left,right),
			self.Address.Zip5             			:= l.zip,
			self.Address.Zip4              			:= l.zip4,
			self.Address.County            			:= l.county_name,
			self.Address.PostalCode         		:= '',
			self.Address.StateCityZip      			:= '',

			// output mail address fields next
			self.MailAddress.StreetNumber      		:= l.mail_prim_range,
			self.MailAddress.StreetPreDirection 	:= l.mail_predir,
			self.MailAddress.StreetName        		:= l.mail_prim_name,
			self.MailAddress.StreetSuffix      		:= l.mail_addr_suffix,
			self.MailAddress.StreetPostDirection 	:= l.mail_postdir,
			self.MailAddress.UnitDesignation 			:= l.mail_unit_desig,
			self.MailAddress.UnitNumber      			:= l.mail_sec_range,
			self.MailAddress.StreetAddress1    		:= '',
			self.MailAddress.StreetAddress2    		:= '',
			self.MailAddress.State           			:= l.mail_st,
			self.MailAddress.City             		:= trim(ms(l.mail_p_city_name, l.mail_v_city_name, in_city),left,right),
			self.MailAddress.Zip5             		:= l.mail_ace_zip,
			self.MailAddress.Zip4               	:= l.mail_zip4,
			self.MailAddress.County             	:= l.mail_county_name,
			self.MailAddress.PostalCode          	:= '',
			self.MailAddress.StateCityZip        	:= '',
			
			self.LicenseDate       := iesp.ECL2ESP.toDate ((integer4) fixed_date(l.DateLicense)),
			self.DOB               := iesp.ECL2ESP.toDate ((integer4) fixed_date(l.dob)),
			self.LicenseNumber     := l.HuntFishPerm,
			self.LicenseType       := l.License_type_Mapped,
			self.LicenseState      := codes.St2Name(l.source_state),
			self.HomeState         := codes.St2Name(l.HomeState),
			self.Occupation        := l.occupation,
			self.Sex               := Codes.General.Gender(l.gender),
			self.SSN               := l.best_ssn,
			self.UniqueId          := l.did_out,
			/*   As of July 2012, analysis showed that no base file records existed that 
				 had any non-blank value in the Race field, but since that could change in the 
				 future, this join to the code_v3 key is included. */
			self.Race		      	   := if(r.long_desc <> '', r.long_desc, l.race);
			self._penalty          := l.penalt;
			self.AlsoFound         := l.isDeepDive;
			self.StatementIDs 		 := l.StatementIDs;
			self.isDisputed        := l.isDisputed;
	  END;
	  		
		temp_filter := join(in_recs, codes.key_Codes_V3, 
												keyed(right.file_name = 'EMERGES_HVC'
												AND right.field_name = 'RACEETHNICITY' 
												AND right.field_name2 = '' AND right.code = left.race),
												xform(left, right), 
												limit(0), keep(1), LEFT OUTER);
				
		// sort and dedup temp_filter on entire record
		filter := dedup(sort(temp_filter,record), record);
		
	  return(filter);         	
		
	end;
	
end;
