import iesp, internetdomain_services;
export functions := module

		 	 export params := interface
		   end;
				 			 
	export	unsigned2 ConvertMonth(string3 mname) := map(mname = 'JAN' => 01,
                                          mname = 'FEB' => 02,
                                          mname = 'MAR' => 03,
                                          mname = 'APR' => 04,
                                          mname = 'MAY' => 05,
                                          mname = 'JUN' => 06,
                                          mname = 'JUL' => 07,
                                          mname = 'AUG' => 08,
                                          mname = 'SEP' => 09,
                                          mname = 'OCT' => 10,
                                          mname = 'NOV' => 11,
                                          mname = 'DEC' => 12,
																					00);
																																						
   export fnInternetServicesSearchVal(dataset(InternetDomain_services.Layouts.rawrec) 
			                      in_recs, params in_mod) := function

		    InternetDomain_services.layouts.InetDomainRecordWithPenalty  
						              xform(Internetdomain_services.Layouts.rawrec l
																	) := TRANSFORM
				self.domainName            := l.domain_name,																												
				self.DateLastSeen          := iesp.ECL2ESP.toDate((integer4) l.Date_Last_Seen),
				self.DateLastUpdated.day   := (integer) l.update_date[1..2],
				self.DateLastUpdated.Month := ConvertMonth(stringlib.StringToUpperCase(l.update_date[4..6])),
				self.DateLastUpdated.Year  := (integer) l.update_date[8..11],
				self.DateExpires.Day       := (integer) l.expire_date[1..2],
				self.DateExpires.month     := ConvertMonth(stringlib.StringToUpperCase(l.expire_date[4..6])),
				self.DateExpires.Year      :=  (integer) l.expire_date[8..11],
				self.DateCreated.Day       :=  (integer) l.create_date[1..2],
				self.DateCreated.month     := ConvertMonth(stringlib.StringToUpperCase(l.create_date[4..6])),
				self.DateCreated.Year      := (integer) l.create_date[8..11],
				
				self.DateDatabase.Day      := (integer) l.database_date[1..2],
				self.DateDatabase.month    := ConvertMonth(stringlib.StringToUpperCase(l.database_date[4..6])),
				self.DateDatabase.Year     := (integer) l.database_date[8..11],
				self.Registrant.Name       := l.registrant_name,
				self.Registrant.Email      := '',   
				self.Registrant.InetDomainAddress := dataset([{l.registrant_address1},
				                                              {l.registrant_address2},
																											{l.registrant_address3},
																											{l.registrant_address4},
																											{l.registrant_address5},
																											{l.registrant_address6},
																											{l.registrant_address7}], iesp.share.t_StringArrayItem),
				                                               
				self.AdministrativeContact.Name  := l.admin_name,
				self.AdministrativeContact.Email := l.admin_email,
				self.AdministrativeContact.InetDomainAddress := dataset([{l.admin_address1},
				                                              {l.admin_address2},
																											{l.admin_address3},
																											{l.admin_address4},
																											{l.admin_address5},
																											{l.admin_address6},
																											{l.admin_address7}], iesp.share.t_StringArrayItem),
				self.TechnicalContact.Name       := l.tech_name,
				self.TechnicalContact.Email      := l.tech_email,
				self.TechnicalContact.InetDomainAddress := dataset([{l.tech_address1},
				                                              {l.tech_address2},
																											{l.tech_address3},
																											{l.tech_address4},
																											{l.tech_address5},
																											{l.tech_address6},
																											{l.tech_address7}], iesp.share.t_StringArrayItem),
			
			  self._penalty                    := l.penalt,
				self.IsDeepDive                  := l.isDeepDive		
			end;          		
		
		  temp_filter := project(in_recs, xform(left));
			filter := dedup(sort(temp_filter,record), record);
			
	    return(filter);         
	end;
end;