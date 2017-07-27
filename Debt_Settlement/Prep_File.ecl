import ut,business_header,address;

export Prep_File(
	 string															pfileversion			= 'using'
	,boolean														pUseOtherEnviron	= _Constants().isdataland) := module
	
	export CC(
			dataset(Layouts.Input.CC)	pSprayedCCFile = Files(pfileversion,pUseOtherEnviron).InputCC.logical) := function
			
			Layouts.Input.CC CleanCCRec(Layouts.Input.CC l) := transform
			
				wzip  := regexreplace('[^0-9]',l.zip,''); // Remove all non numerics
				wzip4 := regexreplace('[^0-9]',l.zip4,''); // Remove all non numerics
			
				/* If the zip is empty, check for the zip in the zip4 field */
				self.zip := if (wzip != '', 
															wzip,case(length(wzip4),
																		5 => wzip4,
																		9 => wzip4[1..5],
																		''));
																				
				/* If the zip4 field length is 5, assume zip5 field, if length is nine, use last 4 digits */
				self.zip4 := case(length(wzip4),
																	5 => '',
																	9 => wzip4[5..9],
																	wzip4);
				
				/* Convert state name to code */
				LookupState := ut.st2abbrev(StringLib.StringToUpperCase(l.state));
				self.state := if(LookupState != '',LookupState,l.state);
				
				self := l;
				self := [];
			end;
		
			return(project(pSprayedCCFile,CleanCCRec(left)));
	
	end;

	export RSIH(
			dataset(Layouts.Input.RSIH)	pSprayedRSIHFile = Files(pfileversion,pUseOtherEnviron).InputRSIH.logical) := function
			
			Layouts.Prep.RSIH CleanRSIHRec(Layouts.Input.RSIH l) := transform
					
					unsigned EmailPos := StringLib.StringFind(l.email,'Email:',1);
					wEmail := if (EmailPos = 0, trim(l.email),trim(l.email[EmailPos+6..]));
					self.email := if(StringLib.StringFind(wEmail,'@',1) != 0,wEmail,'');
					self.Miscellaneous := if(StringLib.StringFind(wEmail,'@',1) = 0,wEmail,'');
					self.Source := 'RSIH';
					
					self.BusinessName := if(l.BusinessName = '',l.AttorneyName,l.BusinessName);
								
					self := l;
					self := [];
			end;
			
			return(project(pSprayedRSIHFile,CleanRSIHRec(left)));
	end;
	
	export BusHeader(
			boolean																			pUseOtherEnvironment	= false	//if true on dataland, use prod, if true on prod, use dataland
			,dataset(Business_Header.Layout_BH_Best)		pBusHeaderBestFile 		= Business_Header.Files(,pUseOtherEnvironment).Base.Business_Header_Best.QA
			,dataset(Business_Header.Layout_SIC_Code)		pBusSICRecs 					= Business_Header.Persists(pUseOtherEnvironment).BHBDIDSIC
			) := function
			
			BusSICRecs := pBusSICRecs(sic_code = '72991001');
						
			layouts.base CreateBaseRecs(business_header.Layout_BH_Best bhrec) := transform
					
					self.bdid												:= bhrec.bdid;
					self.raw_aid										:= bhrec.RawAID;
					self.record_type								:= 'C';
					self.dt_vendor_last_reported		:= bhrec.dt_last_seen;
					self.rawfields.BusinessName 		:= bhrec.company_name;
					self.rawfields.Address1 				:= Address.Addr1FromComponents(bhrec.prim_range,bhrec.predir,bhrec.prim_name,
																																				bhrec.addr_suffix,bhrec.postdir,
																																				bhrec.unit_desig,bhrec.sec_range);
					self.rawfields.city							:= bhrec.city;
					self.rawfields.state						:= bhrec.state;
					self.rawfields.zip							:= (string) bhrec.zip;
					self.rawfields.zip4							:= (string) bhrec.zip4;
					self.rawfields.phone						:= (string) bhrec.phone;
					self.rawfields.Source						:= 'BusinessHeader';
					self.rawfields 									:= [];
					self.clean_attorney_name				:= [];
					self.clean_address.prim_range		:= bhrec.prim_range;
					self.clean_address.predir				:= bhrec.predir;
					self.clean_address.prim_name		:= bhrec.prim_name;
					self.clean_address.addr_suffix	:= bhrec.addr_suffix;
					self.clean_address.postdir			:= bhrec.postdir;
					self.clean_address.unit_desig		:= bhrec.unit_desig;
					self.clean_address.sec_range		:= bhrec.sec_range;
					self.clean_address.p_city_name	:= bhrec.city;
					self.clean_address.st						:= bhrec.state;
					self.clean_address.zip					:= (string) bhrec.zip;
					self.clean_address.zip4					:= (string) bhrec.zip4;
					self.clean_address							:= [];
					self := [];
			end;
			
			BusBaseSicRecs := join(pBusHeaderBestFile,BusSICRecs,left.bdid = right.bdid,CreateBaseRecs(left),ALL);
			
			/* Pull out all records that have Debt within the company name */
			DebtCompRecs := pBusHeaderBestFile(regexfind('.* Debt |^Debt | Debt$',company_name,NOCASE));
			BaseDebtCompRecs := project(DebtCompRecs,CreateBaseRecs(left));
			
			// Combine the company recs with matching SIC codes and matching Name 
			CombinedSICDebtCompRecs := dedup(sort(BusBaseSicRecs+BaseDebtCompRecs,record),record);
					
			return(CombinedSICDebtCompRecs);
	end;
end;