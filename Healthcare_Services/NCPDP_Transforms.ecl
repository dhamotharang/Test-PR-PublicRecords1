Import iesp,Address,std;
EXPORT NCPDP_Transforms := MODULE

	export NCPDP_Layouts.autokeyInput convertIESPtoSearchInput(iesp.ncpdp.t_PharmacySearchBy inRecs):= TRANSFORM
				cleanAddr := inRecs.Address.StreetAddress1 <> '';
				testInput:=stringlib.StringFind(inRecs.Address.StreetAddress1,',',1);
				splitRaw1 := if(testInput>0,inRecs.Address.StreetAddress1[1..testInput-1],inRecs.Address.StreetAddress1);
				splitRaw2 := if(testInput>0,inRecs.Address.StreetAddress1[testInput+1..],'');
				tmpCity := If(inRecs.Address.city ='' and inRecs.Address.zip5 ='', 'ANYTOWN',inRecs.Address.city);
				line2:=if(inRecs.Address.City <>'' or inRecs.Address.State <>'' or inRecs.Address.Zip5 <>'',tmpCity+' '+inRecs.Address.state+' '+inRecs.Address.zip5,splitRaw2);
				clnAddr := Address.CleanFields(Address.GetCleanAddress(splitRaw1,line2,address.Components.Country.US).str_addr);

				self.acctno := '1';
				self.comp_name:= inRecs.CompanyName;
				self.prim_range := if(cleanAddr and clnAddr.prim_range <> '',clnAddr.prim_range,inRecs.Address.StreetNumber);
				self.predir := if(cleanAddr and clnAddr.predir <> '',clnAddr.predir,inRecs.Address.StreetPreDirection);
				self.prim_name := if(cleanAddr and clnAddr.prim_name <> '',clnAddr.prim_name,inRecs.Address.StreetName);
				self.addr_suffix := if(cleanAddr and clnAddr.addr_suffix <> '',clnAddr.addr_suffix,inRecs.Address.StreetSuffix);
				self.postdir := if(cleanAddr and clnAddr.postdir <> '',clnAddr.postdir,inRecs.Address.StreetPostDirection);
				self.unit_desig:= inRecs.Address.UnitDesignation;
				self.sec_range := if(cleanAddr and clnAddr.sec_range <> '',clnAddr.sec_range,inRecs.Address.UnitNumber);
				self.p_city_name := if(cleanAddr and clnAddr.p_city_name <> '',clnAddr.p_city_name,inRecs.Address.City);
				self.st := if(cleanAddr and clnAddr.st <> '',clnAddr.st,inRecs.Address.State);
				self.z5 := if(cleanAddr and clnAddr.zip <> '',clnAddr.zip,inRecs.Address.Zip5);
				self.zip4:= inRecs.Address.Zip4;
				self.fein:= inRecs.FEIN;
				self.bdid:= (integer)inRecs.BusinessId;
				self.NCPDP_ProviderID := inRecs.PharmacyProviderID;
				self.license_number := inRecs.LicenseNumber;
				self.license_state := inRecs.LicenseState;
				self.NPI := inRecs.NpiNumber;	
				self.DEA := inRecs.DEANumber;	
				self := [];
	end;
	export NCPDP_Layouts.autokeyInput convertIESPtoReportInput(iesp.ncpdp.t_PharmacyReportBy inRecs):= TRANSFORM
				cleanAddr := inRecs.Address.StreetAddress1 <> '';
				testInput:=stringlib.StringFind(inRecs.Address.StreetAddress1,',',1);
				splitRaw1 := if(testInput>0,inRecs.Address.StreetAddress1[1..testInput-1],inRecs.Address.StreetAddress1);
				splitRaw2 := if(testInput>0,inRecs.Address.StreetAddress1[testInput+1..],'');
				tmpCity := If(inRecs.Address.city ='' and inRecs.Address.zip5 ='', 'ANYTOWN',inRecs.Address.city);
				line2:=if(inRecs.Address.City <>'' or inRecs.Address.State <>'' or inRecs.Address.Zip5 <>'',tmpCity+' '+inRecs.Address.state+' '+inRecs.Address.zip5,splitRaw2);
				clnAddr := Address.CleanFields(Address.GetCleanAddress(splitRaw1,line2,address.Components.Country.US).str_addr);

				self.acctno := '1';
				self.comp_name:= inRecs.CompanyName;
				self.prim_range := if(cleanAddr and clnAddr.prim_range <> '',clnAddr.prim_range,inRecs.Address.StreetNumber);
				self.predir := if(cleanAddr and clnAddr.predir <> '',clnAddr.predir,inRecs.Address.StreetPreDirection);
				self.prim_name := if(cleanAddr and clnAddr.prim_name <> '',clnAddr.prim_name,inRecs.Address.StreetName);
				self.addr_suffix := if(cleanAddr and clnAddr.addr_suffix <> '',clnAddr.addr_suffix,inRecs.Address.StreetSuffix);
				self.postdir := if(cleanAddr and clnAddr.postdir <> '',clnAddr.postdir,inRecs.Address.StreetPostDirection);
				self.unit_desig:= inRecs.Address.UnitDesignation;
				self.sec_range := if(cleanAddr and clnAddr.sec_range <> '',clnAddr.sec_range,inRecs.Address.UnitNumber);
				self.p_city_name := if(cleanAddr and clnAddr.p_city_name <> '',clnAddr.p_city_name,inRecs.Address.City);
				self.st := if(cleanAddr and clnAddr.st <> '',clnAddr.st,inRecs.Address.State);
				self.z5 := if(cleanAddr and clnAddr.zip <> '',clnAddr.zip,inRecs.Address.Zip5);
				self.zip4:= inRecs.Address.Zip4;
				self.fein:= inRecs.FEIN;
				self.bdid:= (integer)inRecs.BusinessId;
				self.did:= (integer)inRecs.UniqueID;
				self.NCPDP_ProviderID := inRecs.PharmacyProviderID;
				self.license_number := inRecs.LicenseNumber;
				self.license_state := inRecs.LicenseState;
				self.NPI := inRecs.NpiNumber;	
				self.DEA := inRecs.DEANumber;	
				self := [];
	end;
	Export cleanOnlyNumbers (string inStr) := function
		return stringlib.stringfilter(inStr,'0123456789');
	end;
	Export mac_EntityInformation():= macro
			self.EntityInformation.PharmacyProviderID :=outRecs.NCPDP_provider_id;
			self.EntityInformation.BusinessId := (String)outRecs.bdid;
			self.EntityInformation.CompanyName :=outRecs.legal_business_name;
			self.EntityInformation.DBAName :=outRecs.DBA;
			self.EntityInformation.StoreNumber :=if(hasFullNCPDP,outRecs.store_number,'');
			self.EntityInformation.FEIN :=if(hasFullNCPDP,outRecs.federal_tax_id,'');
			self.EntityInformation.DEANumber :=if(hasFullNCPDP,outRecs.DEA_registration_id,'');
			self.EntityInformation.NpiNumber :=if(hasFullNCPDP,outRecs.national_provider_id,'');
			self.EntityInformation.LicenseNumber :=if(hasFullNCPDP,outRecs.state_license_number,'');
			self.EntityInformation.MedicareProviderID :=if(hasFullNCPDP,outRecs.medicare_provider_id,'');
			self.EntityInformation.DispenserClass :=if(hasFullNCPDP,outRecs.dispensingClassDesc,'');
			self.EntityInformation.DispenserType :=if(hasFullNCPDP,outRecs.PrimaryDispensingTypeDesc,'');
			self.EntityInformation.SecondaryDispenserType :=if(hasFullNCPDP,outRecs.SecondaryDispensingTypeDesc,'');
			self.EntityInformation.TertiaryDispenserType :=if(hasFullNCPDP,outRecs.TertiaryDispensingTypeDesc,'');
			od := if(hasFullNCPDP,outRecs.phys_loc_store_open_date,'');//Data format MMDDYYYY
			self.EntityInformation.OpenDate := iesp.ECL2ESP.toDatestring8MMDDYYYY(od);
			cd := if(hasFullNCPDP,outRecs.phys_loc_store_close_date,'');//Data format MMDDYYYY
			self.EntityInformation.ClosureDate :=iesp.ECL2ESP.toDatestring8MMDDYYYY(cd);
			self.EntityInformation.DateFirstReported :=iesp.ECL2ESP.toDate(outRecs.Dt_First_Seen);
			self.EntityInformation.DateLastReported :=iesp.ECL2ESP.toDate(outRecs.Dt_Last_Seen);
	endMacro;

	Export mac_ConsolidatedEntityInformation():= macro
			self.EntityInformation.PharmacyProviderID :=outRecs.NCPDP_provider_id;
			self.EntityInformation.BusinessId := (String)outRecs.bdid;
			self.EntityInformation.CompanyName :=outRecs.legal_business_name;
			self.EntityInformation.DBAName :=outRecs.DBA;
			self.EntityInformation.StoreNumber := if(hasFullNCPDP,outRecs.store_number,'');
			self.EntityInformation.DispenserClass :=if(hasFullNCPDP,outRecs.dispensingClassDesc,'');
			self.EntityInformation.DispenserType :=if(hasFullNCPDP,outRecs.PrimaryDispensingTypeDesc,'');
			self.EntityInformation.SecondaryDispenserType :=if(hasFullNCPDP,outRecs.SecondaryDispensingTypeDesc,'');
			self.EntityInformation.TertiaryDispenserType :=if(hasFullNCPDP,outRecs.TertiaryDispensingTypeDesc,'');
			od := if(hasFullNCPDP,outRecs.phys_loc_store_open_date,'');//Data format MMDDYYYY
			self.EntityInformation.OpenDate :=iesp.ECL2ESP.toDatestring8MMDDYYYY(od);
			cd := if(hasFullNCPDP,outRecs.phys_loc_store_close_date,'');//Data format MMDDYYYY
			self.EntityInformation.ClosureDate :=iesp.ECL2ESP.toDatestring8MMDDYYYY(cd);
	endMacro;

	Export mac_PharmacyLocationAddress():= macro
			self.PharmacyLocationAddress.StreetNumber :=outRecs.Phys_prim_range;
			self.PharmacyLocationAddress.StreetPreDirection :=outRecs.Phys_predir;
			self.PharmacyLocationAddress.StreetName :=outRecs.Phys_prim_name;
			self.PharmacyLocationAddress.StreetSuffix :=outRecs.Phys_addr_suffix;
			self.PharmacyLocationAddress.StreetPostDirection :=outRecs.Phys_postdir;
			self.PharmacyLocationAddress.UnitDesignation :=outRecs.Phys_unit_desig;
			self.PharmacyLocationAddress.UnitNumber :=outRecs.Phys_sec_range;
			self.PharmacyLocationAddress.StreetAddress1 :=outRecs.Append_PhyAddr1;
			self.PharmacyLocationAddress.StreetAddress2 :='';
			self.PharmacyLocationAddress.City :=outRecs.Phys_p_city_name;
			self.PharmacyLocationAddress.State :=outRecs.Phys_state;
			self.PharmacyLocationAddress.Zip5 :=outRecs.Phys_zip5;
			self.PharmacyLocationAddress.Zip4 :=outRecs.Phys_zip4;
			self.PharmacyLocationAddress.County :='';
			self.PharmacyLocationAddress.PostalCode :='';
			self.PharmacyLocationAddress.StateCityZip :='';
			self.PharmacyLocationAddress.Phone10 :=outRecs.phys_loc_phone;
			self.PharmacyLocationAddress.FaxNumber :=outRecs.phys_loc_fax_number;
			self.PharmacyLocationAddress.Email :=if(hasFullNCPDP,outRecs.phys_loc_email,'');
	endMacro;

	Export mac_PharmacyMailingAddress():= macro
			self.PharmacyMailingAddress.StreetNumber :=outRecs.Mail_prim_range;
			self.PharmacyMailingAddress.StreetPreDirection :=outRecs.Mail_predir;
			self.PharmacyMailingAddress.StreetName :=outRecs.Mail_prim_name;
			self.PharmacyMailingAddress.StreetSuffix :=outRecs.Mail_addr_suffix;
			self.PharmacyMailingAddress.StreetPostDirection :=outRecs.Mail_postdir;
			self.PharmacyMailingAddress.UnitDesignation :=outRecs.Mail_unit_desig;
			self.PharmacyMailingAddress.UnitNumber :=outRecs.Mail_sec_range;
			self.PharmacyMailingAddress.StreetAddress1 :=outRecs.Append_MailAddr1;
			self.PharmacyMailingAddress.StreetAddress2 :='';
			self.PharmacyMailingAddress.City :=outRecs.Mail_p_city_name;
			self.PharmacyMailingAddress.State :=outRecs.Mail_state;
			self.PharmacyMailingAddress.Zip5 :=outRecs.Mail_zip5;
			self.PharmacyMailingAddress.Zip4 :=outRecs.Mail_zip4;
			self.PharmacyMailingAddress.County :='';
			self.PharmacyMailingAddress.PostalCode :='';
			self.PharmacyMailingAddress.StateCityZip :='';
			self.PharmacyMailingAddress.Phone10 :=if(hasFullNCPDP,outRecs.contact_phone,'');
			self.PharmacyMailingAddress.FaxNumber :='';
			self.PharmacyMailingAddress.Email :=if(hasFullNCPDP,outRecs.contact_email,'');
			self.PharmacyMailingAddress.UniqueID :=if(hasFullNCPDP,(string)outRecs.did,'');
			self.PharmacyMailingAddress.ContactTitle :=if(hasFullNCPDP,outRecs.contact_title,'');
			self.PharmacyMailingAddress.ContactName.full :=if(hasFullNCPDP,STD.str.cleanspaces(outRecs.contact_first_name+' '+outRecs.contact_middle_initial+' '+outRecs.contact_last_name),'');
			self.PharmacyMailingAddress.ContactName.First :=if(hasFullNCPDP,outRecs.contact_first_name,'');
			self.PharmacyMailingAddress.ContactName.Middle :=if(hasFullNCPDP,outRecs.contact_middle_initial,'');
			self.PharmacyMailingAddress.ContactName.Last :=if(hasFullNCPDP,outRecs.contact_last_name,'');
			self.PharmacyMailingAddress.ContactName.Suffix :='';
			self.PharmacyMailingAddress.ContactName.Prefix :='';
	endMacro;

	Export mac_ConsolidatedPharmacyMailingAddress():= macro
			self.PharmacyMailingAddress.StreetNumber :=outRecs.Mail_prim_range;
			self.PharmacyMailingAddress.StreetPreDirection :=outRecs.Mail_predir;
			self.PharmacyMailingAddress.StreetName :=outRecs.Mail_prim_name;
			self.PharmacyMailingAddress.StreetSuffix :=outRecs.Mail_addr_suffix;
			self.PharmacyMailingAddress.StreetPostDirection :=outRecs.Mail_postdir;
			self.PharmacyMailingAddress.UnitDesignation :=outRecs.Mail_unit_desig;
			self.PharmacyMailingAddress.UnitNumber :=outRecs.Mail_sec_range;
			self.PharmacyMailingAddress.StreetAddress1 :=outRecs.Append_MailAddr1;
			self.PharmacyMailingAddress.StreetAddress2 :='';
			self.PharmacyMailingAddress.City :=outRecs.Mail_p_city_name;
			self.PharmacyMailingAddress.State :=outRecs.Mail_state;
			self.PharmacyMailingAddress.Zip5 :=outRecs.Mail_zip5;
			self.PharmacyMailingAddress.Zip4 :=outRecs.Mail_zip4;
			self.PharmacyMailingAddress.County :='';
			self.PharmacyMailingAddress.PostalCode :='';
			self.PharmacyMailingAddress.StateCityZip :='';
			self.PharmacyMailingAddress.Phone10 :=if(hasFullNCPDP,outRecs.contact_phone,'');
			self.PharmacyMailingAddress.FaxNumber :='';
			self.PharmacyMailingAddress.Email :=if(hasFullNCPDP,outRecs.contact_email,'');
			self.PharmacyMailingAddress.ContactTitle :=if(hasFullNCPDP,outRecs.contact_title,'');
			self.PharmacyMailingAddress.ContactName.full :=if(hasFullNCPDP,trim(outRecs.contact_first_name,all)+' '+trim(outRecs.contact_middle_initial,all)+' '+Trim(outRecs.contact_last_name,all),'');
			self.PharmacyMailingAddress.ContactName.First :=if(hasFullNCPDP,outRecs.contact_first_name,'');
			self.PharmacyMailingAddress.ContactName.Middle :=if(hasFullNCPDP,outRecs.contact_middle_initial,'');
			self.PharmacyMailingAddress.ContactName.Last :=if(hasFullNCPDP,outRecs.contact_last_name,'');
			self.PharmacyMailingAddress.ContactName.Suffix :='';
			self.PharmacyMailingAddress.ContactName.Prefix :='';
	endMacro;

	Export mac_PharmacyServices():= macro
			self.PharmacyServices.Open24Hours :=if(hasFullNCPDP,outRecs.phys_loc_24hr_operation,'');
			self.PharmacyServices.AcceptsEPrescriptions :=if(hasFullNCPDP,outRecs.phys_loc_accepts_ePrescriptions,'');
			self.PharmacyServices.DeliveryService :=if(hasFullNCPDP,outRecs.phys_loc_delivery_service,'');
			self.PharmacyServices.CompoundingService :=if(hasFullNCPDP,outRecs.phys_loc_compounding_service,'');
			self.PharmacyServices.DriveupWindow :=if(hasFullNCPDP,outRecs.phys_loc_driveup_window,'');
			self.PharmacyServices.DurableMedicalEquipment :=if(hasFullNCPDP,outRecs.phys_loc_durable_med_equip,'');
			self.PharmacyServices.HandicapAccess :=if(hasFullNCPDP,outRecs.phys_loc_handicap_access,'');
			self.PharmacyServices.Hours :=if(hasFullNCPDP,dataset([{'SUNDAY',outRecs.SundayHours},
																						 {'MONDAY',outRecs.MondayHours},
																						 {'TUESDAY',outRecs.TuesdayHours},
																						 {'WEDNESDAY',outRecs.WednesdayHours},
																						 {'THURSDAY',outRecs.ThursdayHours},
																						 {'FRIDAY',outRecs.FridayHours},
																						 {'SATURDAY',outRecs.SaturdayHours}],iesp.ncpdp.t_PharmacyHours),dataset([],iesp.ncpdp.t_PharmacyHours))(Hours<>'');
			self.PharmacyServices.Languages :=if(hasFullNCPDP,dataset([{outRecs.languageCode1Desc},
																								 {outRecs.languageCode2Desc},
																								 {outRecs.languageCode3Desc},
																								 {outRecs.languageCode4Desc},
																								 {outRecs.languageCode5Desc}],iesp.ncpdp.t_PharmacyLanguage),dataset([],iesp.ncpdp.t_PharmacyLanguage))(Language<>'');
	endMacro;

	export iesp.ncpdp.t_PharmacySearch fmtSearchResults(NCPDP_Layouts.LayoutOutput outRecs,boolean hasFullNCPDP=false):= TRANSFORM
				mac_EntityInformation()	
				mac_PharmacyLocationAddress()
				mac_PharmacyMailingAddress()
				self := [];
	end;
	export iesp.ncpdp.t_PharmacyReport fmtReportResults(NCPDP_Layouts.LayoutOutput outRecs,boolean hasFullNCPDP=false):= TRANSFORM
				mac_EntityInformation()	
				mac_PharmacyLocationAddress()
				mac_PharmacyMailingAddress()
				mac_PharmacyServices()
				self := [];
	end;
	export iesp.ncpdp.t_PharmacyReportConsolidatedSearch fmtConsolidateSearchResults(NCPDP_Layouts.LayoutOutput outRecs, boolean hasFullNCPDP=false):= TRANSFORM
				mac_ConsolidatedEntityInformation()	
				mac_PharmacyLocationAddress()
				mac_ConsolidatedPharmacyMailingAddress()
				mac_PharmacyServices()
				self := [];
	end;
	export NCPDP_Layouts.LayoutOutputBatch fmtBatchResults(NCPDP_Layouts.LayoutOutput outRecs, boolean hasFullNCPDP=false):= TRANSFORM
				self.NCPDP_provider_id:=outRecs.NCPDP_provider_id;
				self.legal_business_name:=outRecs.legal_business_name;                       
				self.DBA:=outRecs.DBA;                                       
				self.phys_loc_address1:=outRecs.phys_loc_address1;                         
				self.phys_loc_address2:=outRecs.phys_loc_address2;                         
				self.phys_loc_city:=outRecs.phys_loc_city;                             
				self.phys_loc_state:=outRecs.phys_loc_state;                            
				self.phys_loc_full_zip:=outRecs.phys_loc_full_zip;                         
				self.address1:=outRecs.address1;                                  
				self.address2:=outRecs.address2;                                  
				self.city:=outRecs.city;                                      
				self.state:=outRecs.state;                                     
				self.full_zip:=outRecs.full_zip;                                  
				self.bdid:=outRecs.bdid;
				self.did:=outRecs.did;        
				self.Dt_First_Seen:=outRecs.Dt_First_Seen;
				self.Dt_Last_Seen:=outRecs.Dt_Last_Seen;                
				self.Append_PhyAddr1:=outRecs.Append_PhyAddr1;
				self.Append_PhyAddrLast:=outRecs.Append_PhyAddrLast;
				self.Append_PhyRawAID:=outRecs.Append_PhyRawAID;
				self.Append_PhyAceAID:=outRecs.Append_PhyAceAID;            
				self.Append_MailAddr1:=outRecs.Append_MailAddr1;
				self.Append_MailAddrLast:=outRecs.Append_MailAddrLast;
				self.Append_MailRawAID:=outRecs.Append_MailRawAID;
				self.Append_MailAceAID:=outRecs.Append_MailAceAID;    
				self := if(hasFullNCPDP,outRecs);
				self := [];
	end;
end;