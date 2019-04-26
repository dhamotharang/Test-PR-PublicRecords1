import _Validate, Corp2_Raw_MS, Scrubs, Scrubs_Corp2_mapping_MS_Main, Scrubs_Corp2_mapping_MS_Event, Scrubs_Corp2_mapping_MS_Stock, Corp2, tools, std, UT, versioncontrol;
 
export MS := module;  
 	
	export Update(string fileDate, string version, boolean pShouldSpray = _Dataset().bShouldSpray, boolean pOverwrite = false, boolean pUseProd = Tools._Constants.IsDataland) := function
 		
		state_origin := 'MS';
		state_fips	 := '28';	
		state_desc	 := 'MISSISSIPPI';
		
 		// Vendor Input Files 	
		inProfiles := dedup(sort(distribute(Corp2_Raw_MS.Files(filedate,pUseProd).Input.Profiles.logical,hash(EntityID)),record,local), record,local) : independent;	
		inForms    := dedup(sort(distribute(Corp2_Raw_MS.Files(filedate,pUseProd).Input.Forms.logical,hash(EntityID)),record,local), record,local) : independent;	

	 //------- Begin MAIN mapping ---------------------------------------------------------------------//
	 
	 //------- Begin CORP mapping ---------------------------------------------------------------------//		
	 Filing_Date_Desc := ['AMENDMENTADOPTEDDATE','FILED','SUBMITTED'];	
	 
	 // Create Corp records from Entity fields  (Note: Per Legal FEIN cannot be mapped/displayed)
   Corp2_mapping.LayoutsCommon.Main trfBase(Corp2_Raw_MS.Layouts.ProfilesLayoutIN l, integer c) := transform
			self.corp_Key                            := state_fips + '-' + corp2.t2u(l.EntityID);
			self.corp_orig_sos_charter_nbr 	         := corp2.t2u(l.EntityID);
		  self.Corp_Phone_Number                   := Corp2_Raw_MS.Functions.FormatPhone(l.Entity_PhoneNum);
		  self.Corp_Fax_Nbr                        := Corp2_Raw_MS.Functions.FormatPhone(l.Entity_FaxNum);
		  self.Corp_Email_Address             		 := corp2.t2u(l.Entity_Email);
			
      //There can be up to 3 Entity Dates			
			//if the record is determined to be a foreign entity (i.e. Domicile State <> state_origin) then:
			//  - the 1st Date Type that is found to be a Date of Incorporation becomes a filing date with the description of HOME STATE 
			//  - since there could be 3 Dates, the 1st Date of Incorporation can be found in Data Type 1 or Date Type 2 
			//2 Examples of having 3 dates:  <Date Type="FutureEffectiveDate">2014-08-27T00:00:00</Date>      <Date Type="DateOfIncorporation">1998-12-07T00:00:00</Date>
			//                               <Date Type="DateOfIncorporation">1998-12-07T00:00:00</Date>      <Date Type="DateOfIncorporation">2014-08-27T00:00:00</Date>
			//                               <Date Type="DateOfIncorporation">2014-08-27T00:00:00</Date>      <Date Type="Filed">2014-08-27T00:00:00</Date>
			
			fEntDate1 															 := Corp2_mapping.fValidateDate(l.Entity_date1[1..10],'CCYY-MM-DD').PastDate;
			fEntDate2 															 := Corp2_mapping.fValidateDate(l.Entity_date2[1..10],'CCYY-MM-DD').PastDate;
			fEntDate3 															 := Corp2_mapping.fValidateDate(l.Entity_date3[1..10],'CCYY-MM-DD').PastDate;	
			
			string Home_St_Inc                       := map(corp2.t2u(l.Entity_Dom_St) <> state_origin and corp2.t2u(l.Entity_Date_Type1) = 'DATEOFINCORPORATION' and corp2.t2u(l.Entity_Date_Type2) = 'DATEOFINCORPORATION' => fEntDate1,
																										  corp2.t2u(l.Entity_Dom_St) <> state_origin and corp2.t2u(l.Entity_Date_Type2) = 'DATEOFINCORPORATION' and corp2.t2u(l.Entity_Date_Type3) = 'DATEOFINCORPORATION' => fEntDate2,
																										  '');	
			
			//if there are 2 filing dates then there needs to be 2 separate records for this entity i.e. C=1 or 2
			//When C=1 we are looking to see if there is a HOME STATE date.  if not then the entity is domestic and here we will only map
			//Data Types that are in the Filing_Date_Desc.  in this case the Date of Incorporation will be mapped to CORP_INC_DATE.
			//When C=2 we have mapped the HOME STATE already and need to map a date that has been identified to be in Filing_Date_Desc
			self.Corp_Filing_Date                    := choose(c,map(corp2.t2u(Home_St_Inc) <> ''                        => corp2.t2u(Home_St_Inc),
																															 corp2.t2u(l.Entity_Date_Type1) in Filing_Date_Desc  => fEntDate1,
																															 corp2.t2u(l.Entity_Date_Type2) in Filing_Date_Desc  => fEntDate2, //C = 1
																															 ''),             
																													 map(corp2.t2u(l.Entity_Date_Type1) in Filing_Date_Desc  => fEntDate1,
																														   corp2.t2u(l.Entity_Date_Type2) in Filing_Date_Desc  => fEntDate2,
																															 corp2.t2u(l.Entity_Date_Type3) in Filing_Date_Desc  => fEntDate3,
																															 ''));
			
			self.Corp_Filing_Desc                     := choose(c,map(corp2.t2u(Home_St_Inc) <> ''                        => 'HOME STATE',
																																corp2.t2u(l.Entity_Date_Type1) in Filing_Date_Desc  => Corp2_Raw_MS.functions.Date_Type_Desc(l.Entity_Date_Type1),
																																corp2.t2u(l.Entity_Date_Type2) in Filing_Date_Desc  => Corp2_Raw_MS.functions.Date_Type_Desc(l.Entity_Date_Type2),
																																''),    
																														map(corp2.t2u(l.Entity_Date_Type1) in Filing_Date_Desc => Corp2_Raw_MS.functions.Date_Type_Desc(l.Entity_Date_Type1),  
																																corp2.t2u(l.Entity_Date_Type2) in Filing_Date_Desc => Corp2_Raw_MS.functions.Date_Type_Desc(l.Entity_Date_Type2),
																																corp2.t2u(l.Entity_Date_Type3) in Filing_Date_Desc => Corp2_Raw_MS.functions.Date_Type_Desc(l.Entity_Date_Type3),
																																''));
		  self.Corp_Standing                				:= if (corp2.t2u(l.Entity_Standing) = 'GOOD', 'Y', '');
			self.Corp_Status_Desc             				:= Corp2_Raw_MS.functions.Entity_Standing(l.Entity_Standing);
			self.Corp_Dissolved_Date                  := map(corp2.t2u(l.Entity_Date_Type1) = 'DATEOFDISSOLUTION' => fEntDate1,
																											 corp2.t2u(l.Entity_Date_Type2) = 'DATEOFDISSOLUTION' => fEntDate2,
																											 corp2.t2u(l.Entity_Date_Type3) = 'DATEOFDISSOLUTION' => fEntDate3,
																											 '');
			self.Corp_Status_Date                     := self.Corp_Dissolved_Date; //keeping because corp_dissolved_date is a new field in the layout																								 
			self.Corp_Delayed_Effective_Date          := map(corp2.t2u(l.Entity_Date_Type1) = 'FUTUREEFFECTIVEDATE' => fEntDate1,
																											 corp2.t2u(l.Entity_Date_Type2) = 'FUTUREEFFECTIVEDATE' => fEntDate2,
																											 corp2.t2u(l.Entity_Date_Type3) = 'FUTUREEFFECTIVEDATE' => fEntDate3,
																											 '');
			self.Corp_Fiscal_Year_Month               := 	map(corp2.t2u(l.Entity_Date_Type1) = 'FISCALORTAXYEAR' => fEntDate1,
																												corp2.t2u(l.Entity_Date_Type2) = 'FISCALORTAXYEAR' => fEntDate2,
																												corp2.t2u(l.Entity_Date_Type3) = 'FISCALORTAXYEAR' => fEntDate3,
																												'');	// None populated in sample input																	 
		  self.Corp_Inc_county              				:= if (corp2.t2u(l.Entity_Dom_Cnty) in ['','UNKNOWN','USA','ENTER YOUR ADDRESS LINE 1 HERE'] ,'' ,corp2.t2u(l.Entity_Dom_Cnty));
		  // Date Type can appear up to 3 times within one record. This field will only be populated if the entity is domestic.  
			self.Corp_Inc_Date                        := map(corp2.t2u(l.Entity_Dom_St) in [state_origin,''] and corp2.t2u(l.Entity_Date_Type1)  = 'DATEOFINCORPORATION' => fEntDate1,
																											 corp2.t2u(l.Entity_Dom_St) in [state_origin,''] and corp2.t2u(l.Entity_Date_Type2)  = 'DATEOFINCORPORATION' => fEntDate2,
																											 corp2.t2u(l.Entity_Dom_St) in [state_origin,''] and corp2.t2u(l.Entity_Date_Type3)  = 'DATEOFINCORPORATION' => fEntDate3,
																											 '');
			self.Corp_Foreign_Domestic_Ind            := case(corp2.t2u(l.Entity_Domicile_Type) ,'DOMESTIC'=>'D' ,'FOREIGN'=>'F' ,'');
			self.Corp_country_of_Formation            := Corp2_Raw_MS.functions.decode_country(l.Entity_Dom_country);
			self.corp_forgn_state_cd 			            := if(corp2.t2u(l.Entity_Dom_St) not in [state_origin,'UND','UNDEFINED','OUTOFCOUNTRY','']
																										 ,corp2.t2u(l.Entity_Dom_St),'');
			self.corp_forgn_state_desc       					:= Corp2_Raw_MS.functions.decode_state(self.corp_forgn_state_cd); 
			self.Corp_Forgn_Date                      := map(corp2.t2u(l.Entity_Dom_St) not in [state_origin,''] and corp2.t2u(l.Entity_Date_Type1) = 'DATEOFINCORPORATION' and corp2.t2u(l.Entity_Date_Type2) <> 'DATEOFINCORPORATION' => fEntDate1,
																											 corp2.t2u(l.Entity_Dom_St) not in [state_origin,''] and corp2.t2u(l.Entity_Date_Type2) = 'DATEOFINCORPORATION' and corp2.t2u(l.Entity_Date_Type1) = 'DATEOFINCORPORATION'  => fEntDate2,
																											 corp2.t2u(l.Entity_Dom_St) not in [state_origin,''] and corp2.t2u(l.Entity_Date_Type3) = 'DATEOFINCORPORATION' and corp2.t2u(l.Entity_Date_Type2) = 'DATEOFINCORPORATION'  => fEntDate3,
																											 '');
			self.Corp_For_Profit_Ind                  := case(corp2.t2u(l.Entity_Type), 'PROFITCORPORATION'=>'Y' ,'NONPROFITCORPORATION'=>'N' ,'');
		  
			// Old mapper used Entity_Nature, PurposeType, Purpose, and NonProfIRSApprvPurp to map Corp_Orig_Bus_Type_Desc
			// New CI says to use only Entity_Nature for Corp_Orig_Bus_Type_Desc.  And to map the other vendor fields to:
			// corp_entity_desc, corp_purpose, and corp_non_profit_IRS_approved_purpose.
			// Corp_purpose and corp_non_profit_IRS_approved_purpose are new fields, so Purpose and NonProfIRSApprvPurp need to stay in Corp_Orig_Bus_Type_Desc
	    ConcatOrigBusType                         := corp2.t2u(if(corp2.t2u(l.Entity_Nature)       <> '',corp2.t2u(l.Entity_Nature) + '; ', '') + 
																														 if(corp2.t2u(l.Purpose)             <> '',corp2.t2u(l.Purpose)       + '; ', '') +
																														 if(corp2.t2u(l.NonProfIRSApprvPurp) <> '',corp2.t2u(l.NonProfIRSApprvPurp), ''));
			integer BT_Len                            := length(ConcatOrigBusType);
			self.Corp_Orig_Bus_Type_Desc              := if(trim(ConcatOrigBusType)[BT_Len] = ';',trim(ConcatOrigBusType)[1..BT_Len-1],TRIM(ConcatOrigBusType)); 
			self.Corp_Entity_Desc               			:= Corp2_Raw_MS.functions.PurposeType_Desc(l.PurposeType);
			self.Corp_Purpose                   			:= corp2.t2u(l.Purpose);
			self.Corp_Non_Profit_IRS_Approved_Purpose := corp2.t2u(l.NonProfIRSApprvPurp);
			
			self.Corp_Has_Vested_Managers             := case(corp2.t2u(l.HasVestedManagers)  ,'YES'=>'Y' ,'NO'=>'N' ,'');
			self.Corp_Has_Members                     := case(corp2.t2u(l.HasMembers)         ,'YES'=>'Y' ,'NO'=>'N' ,'');
			self.Corp_Operating_Agreement             := case(corp2.t2u(l.OperAgreement)      ,'YES'=>'Y' ,'NO'=>'N' ,'');
			self.Corp_Is_Non_Profit_IRS_Approved      := case(corp2.t2u(l.IsNonProfIRSApprv)  ,'YES'=>'Y' ,'NO'=>'N' ,'');	
			self.Corp_Non_Profit_Solicit_Donations    := case(corp2.t2u(l.NonProfSolDonations),'YES'=>'Y' ,'NO'=>'N' ,'');
			string ConcatAddlInfo					  	        := corp2.t2u(if(corp2.t2u(l.Entity_LLCMngd_By)   <> '' and corp2.t2u(l.Entity_LLCMngd_By) <> 'UNDEFINED', 'LLC MANAGED BY: '+ corp2.t2u(l.Entity_LLCMngd_By) +'; ','') + 
																														 if(corp2.t2u(l.HasVestedManagers)   <> '', 'HAS VESTED MANAGERS: ' + corp2.t2u(l.HasVestedManagers) + '; ','') +
																														 if(corp2.t2u(l.HasMembers)          <> '', 'HAS MEMBERS: ' + corp2.t2u(l.HasMembers) + '; ','') +
																														 if(corp2.t2u(l.OperAgreement)       <> '', 'OPERATING AGREEMENT: ' + corp2.t2u(l.OperAgreement) + '; ','') +
																														 if(corp2.t2u(l.IsNonProfIRSApprv)   <> '', 'NONPROFIT IS IRS APPROVED: ' + corp2.t2u(l.IsNonProfIRSApprv) + '; ','') +
																														 if(corp2.t2u(l.NonProfSolDonations) <> '', 'NONPROFIT SOLICIT DONATIONS: ' + corp2.t2u(l.NonProfSolDonations) + '; ','') +
																														 if(corp2.t2u(l.ShrsOfBeneficialInt) <> '', 'SHARES OF BENEFICIAL INTEREST: ' + corp2.t2u(l.ShrsOfBeneficialInt) + '; ','') +
																														 if(corp2.t2u(l.BeneficialShrVal)    <> '', 'BENEFICIAL SHARE VALUE: ' + corp2.t2u(l.BeneficialShrVal) + '; ','') +
																														 if(corp2.t2u(l.Restrictions)        <> '', 'RESTRICTIONS: ' + corp2.t2u(l.Restrictions) + '; ',''));
			integer AI_Len                            := length(corp2.t2u(ConcatAddlInfo));
			self.Corp_Addl_Info                       := if(trim(ConcatAddlInfo)[AI_Len] = ';',trim(ConcatAddlInfo)[1..AI_Len-1],trim(ConcatAddlInfo)); 
			STRING RA_full_Name                       := Corp2_Raw_MS.Functions.RemoveQuotes(l.RA_FirstName + ' ' + l.RA_MiddleName + ' ' + l.RA_LastName + ' ' + l.RA_Suffix);
			SELF.Corp_RA_full_Name                    := if(Corp2_Raw_MS.Functions.Format_RA_Entity(l.RA_EntName) <> ''
																											,Corp2_mapping.fCleanBusinessName(state_origin,state_desc,Corp2_Raw_MS.Functions.Format_RA_Entity(l.RA_EntName)).BusinessName
																							        ,Corp2_mapping.fCleanBusinessName(state_origin,state_desc,corp2.t2u(RA_full_Name)).BusinessName);
			self.Corp_llc_managed_desc                := if(corp2.t2u(l.Entity_LLCMngd_By) in ['MANAGER','MEMBER'] ,corp2.t2u(l.Entity_LLCMngd_By) ,''); // None populated in sample input
			self.Corp_RA_Phone_Number                 := Corp2_Raw_MS.Functions.FormatPhone(l.RA_PhoneNum);  // None populated in sample input
			self.Corp_RA_Fax_Nbr                      := Corp2_Raw_MS.Functions.FormatPhone(l.RA_FaxNum);  // None populated in sample input
			self.Corp_RA_Email_Address                := corp2.t2u(l.RA_Email);
			self.recordOrigin                         := 'C';
			self                                      := [];
		end; 
	 
	  // Information that is applied to all records
		// Here the only time the counter will be 1 is when there is only 1 date type/date.
	  NormBase := normalize(inProfiles,if(corp2.t2u(left.Entity_Date_Type1) in Filing_Date_Desc OR
		                                    corp2.t2u(left.Entity_Date_Type2) in Filing_Date_Desc OR
																			  corp2.t2u(left.Entity_Date_Type3) in Filing_Date_Desc ,2 ,1)
																			  ,trfBase(left,counter),local);
		
		Base_Recs := dedup(sort(distribute(NormBase,hash(corp_orig_sos_charter_nbr)),record,local),record,local);
		 
    //NAICS Codes - Remove NAIC_Code1 if found in Additional Codes
		Corp2_Raw_MS.Layouts.Lay_Temp_NAICS trfNormNAICS(Corp2_Raw_MS.Layouts.ProfilesLayoutIN l, Corp2_Raw_MS.Layouts.Lay_NAICS_Codes_In r) := transform
      self.EntityId     := corp2.t2u(l.EntityID); 
	    self.NAICS_Code1  := trim(l.NAICS_Code1);
	    self.Code         := if('<Code>' + corp2.t2u(l.NAICS_Code1) +'</Code>' <> corp2.t2u(r.Code)
															,trim(r.Code,left,right) ,'');
    end;

    NormNAICS   := normalize(inProfiles,left.NAICS_Codes,trfNormNAICS(left,right),local);
    dedupNAICS  := dedup(sort(distribute(NormNAICS(EntityID <> ''),hash(EntityID)),record,local),record,local);
		
		//map Corp_NAIC_Code & Corp_NAICS_Desc from Code
		Corp2_mapping.LayoutsCommon.Main joinNAICS(Base_recs l, dedupNAICS r) := transform
			NAIC_NoTags          := StringLib.StringFindReplace(StringLib.StringFindReplace(r.Code,'<Code>',''),'</Code>','');
			NAIC_Desc_start      := StringLib.StringFind(NAIC_NoTags,'-',1) + 2;	
			self.Corp_NAIC_Code  := stringlib.stringfilter(NAIC_NoTags,'0123456789');
   		self.Corp_NAICS_Desc := corp2.t2u(NAIC_NoTags[NAIC_Desc_start..]);
			self                 := l;
    end;
 

		NAIC_Base := join(Base_Recs,dedupNAICS,
								      corp2.t2u(left.corp_orig_sos_charter_nbr) = corp2.t2u(right.EntityId), 
										  joinNAICS(left,right), left outer, local);
		
    // Authorized Partners
		Corp2_Raw_MS.Layouts.Lay_Temp_AP trfNormap(Corp2_Raw_MS.Layouts.ProfilesLayoutIN l, Corp2_Raw_MS.Layouts.Lay_Auth_Prtnrs_In r) := transform
			self.EntityId  := corp2.t2u(l.EntityID); 
			self.AP_str    := corp2.t2u(r.AP_FirstName + ' ' + r.AP_MiddleName + ' ' +  r.AP_LastName + ' ' + r.AP_Suffix);
		end;

		Normap     := normalize(inProfiles,left.AP_Names,trfNormap(left,right),local);
		dedupAP    := dedup(sort(distribute(Normap(EntityID <> ''),hash(EntityID)),record,local),record,local);

		// Concatenate Authorized Partners 
  	Corp2_Raw_MS.Layouts.Lay_Temp_AP concatAP(Corp2_Raw_MS.Layouts.Lay_Temp_AP l, Corp2_Raw_MS.Layouts.Lay_Temp_AP r, integer C) := transform
			self.EntityId := corp2.t2u(l.EntityId);
			self.AP_str   := if(C=1,corp2.t2u(r.AP_str),if(corp2.t2u(r.AP_str) <> '',if(corp2.t2u(l.AP_str) <> '',corp2.t2u(l.AP_str) + ', '+ corp2.t2u(r.AP_str),corp2.t2u(r.AP_str)),''));
		end;

		Denormap     := denormalize(dedupAP, dedupAP,
										             left.EntityId = right.EntityId, 
											           concatAP(left,right,counter));
 		dedupDenormap := dedup(sort(distribute(Denormap,hash(EntityID)),record,local),record,local);

		Corp2_mapping.LayoutsCommon.Main join_AP(NAIC_Base l, dedupDenormap r) := transform
      self.Corp_Authorized_Partners := corp2.t2u(r.AP_str);			
			self.Corp_Addl_Info           := if(corp2.t2u(r.AP_str) = '',trim(l.Corp_Addl_Info),'AUTHORIZED PARTNERS: ' + if(l.Corp_Addl_Info = '',corp2.t2u(r.AP_str),corp2.t2u(r.AP_str) + '; ' + trim(l.Corp_Addl_Info)));
			self                          := l;
			self                          := [];
		end;

		AP_Base := join(NAIC_Base,dedupDenormap,
										corp2.t2u(left.corp_orig_sos_charter_nbr) = corp2.t2u(right.EntityId),
										join_AP(left,right), left outer, local);		
			
		// Additional Entity Names
	  Corp2_Raw_MS.Layouts.Lay_Temp_Names trfNormAddl(Corp2_Raw_MS.Layouts.ProfilesLayoutIN l, Corp2_Raw_MS.Layouts.Lay_Ent_AddlNames r) := transform
			self.EntityId          := corp2.t2u(l.EntityID);  
			string fullname        := Corp2_Raw_MS.Functions.RemoveQuotes(r.Ent_AddlName_FName + ' ' + r.Ent_AddlName_MName + ' ' + r.Ent_AddlName_LName + ' ' + r.Ent_AddlName_Suffix);
			self.Ent_Name          := if(corp2.t2u(r.Ent_AddlName_EntName) <> '',corp2.t2u(r.Ent_AddlName_EntName),
														       if(corp2.t2u(fullname) <> '', corp2.t2u(fullname), ''));
			self.Ent_Address       := r.Ent_AddlName_Addr;
			self.Ent_NameType      := r.Ent_AddlName_NameType;
			self.Ent_NameType_CD   := Corp2_Raw_MS.functions.Name_Type_Code(r.Ent_AddlName_NameType);
			self.Ent_NameType_Desc := Corp2_Raw_MS.functions.Name_Type_Desc(r.Ent_AddlName_NameType);
			self.Ent_OrgStruc_Desc := Corp2_Raw_MS.functions.Entity_Type_Code(l.Entity_Type);
			self.Ent_SIC           := r.Ent_AddlName_SIC;
		end;	
			
		NormAddlNames := normalize(inProfiles,left.Ent_AddlNames,trfNormAddl(left,right),local);

		// Norm the addresses of Additional Names   
		Corp2_Raw_MS.Layouts.Lay_Temp_NamesAddr trfNormAddr(NormAddlNames l, Corp2_Raw_MS.Layouts.Lay_Address_In r) := transform
				self.Ent_AddrType := trim(r.AddrType);
				self.Ent_Address1 := corp2.t2u(r.Address1);
				self.Ent_Address2 := corp2.t2u(r.Address2);
				self.Ent_City     := corp2.t2u(r.City);
				self.Ent_State    := corp2.t2u(r.State);
				self.Ent_Zip      := corp2.t2u(r.Zip);
				self.Ent_county   := corp2.t2u(r.county);
				self.Ent_country  := corp2.t2u(r.country);
				self              := l;
			end;

			NormAddlAddr := normalize(NormAddlNames,left.Ent_Address,trfNormAddr(left,right),local);

			Corp2_Raw_MS.Layouts.Lay_Temp_NamesAddr join_NamesAddr(NormAddlNames l, NormAddlAddr r) := transform
				self.Ent_AddrType := trim(r.Ent_AddrType);
				self.Ent_Address1 := Corp2_Raw_MS.Functions.PreCleanAddr(r.Ent_Address1);
				self.Ent_Address2 := Corp2_Raw_MS.Functions.PreCleanAddr(r.Ent_Address2);
				self.Ent_City     := Corp2_Raw_MS.Functions.PreCleanAddr(r.Ent_City);
				self.Ent_State    := Corp2_Raw_MS.Functions.PreCleanAddr(r.Ent_State);
				self.Ent_Zip      := Corp2_Raw_MS.Functions.PreCleanAddr(r.Ent_Zip);
				self.Ent_county   := Corp2_Raw_MS.Functions.PreCleanAddr(r.Ent_county);
				self.Ent_country  := Corp2_Raw_MS.Functions.PreCleanAddr(r.Ent_country);
				self := l;
			end;

			jAddlNames := join(NormAddlNames(EntityID <> ''),NormAddlAddr(EntityID <> ''),
										  	 left.EntityId = right.EntityId and
												 left.Ent_Name  = right.Ent_Name,
												 join_NamesAddr(left,right), left outer, local);
			
		 // Norm Entity Names & Aliases  
		 Corp2_Raw_MS.Layouts.Lay_Temp_Names trfNormAlias(Corp2_Raw_MS.Layouts.ProfilesLayoutIN l, integer C) := transform
				 self.EntityID          := corp2.t2u(l.EntityID);
				 self.Ent_Name          := choose(C,corp2.t2u(l.Entity_Alias)
																					 ,corp2.t2u(l.Entity_Name)
																					 ,if(corp2.t2u(l.Entity_Name) <> ''
																							,''
																							,corp2.t2u(corp2.t2u(l.Entity_FirstName) + ' ' + corp2.t2u(l.Entity_MiddleName) + ' ' + corp2.t2u(l.Entity_LastName) + ' ' + corp2.t2u(l.Entity_Suffix))));
				 self.Ent_NameType      := '';
				 self.Ent_NameType_CD   := if(C=1
																			,'06',if(corp2.t2u(l.Entity_Type) = 'NAMERESERVATION'
																							,'07',if(self.Ent_Name <> ''
																											,'01','')));
				 self.Ent_NameType_Desc := map(self.Ent_NameType_CD = '01' => 'LEGAL',
																			 self.Ent_NameType_CD = '06' => 'ASSUMED',
																			 self.Ent_NameType_CD = '07' => 'RESERVED',
																			 '');
				 self.Ent_OrgStruc_Desc := if(self.Ent_NameType_CD <> '07',Corp2_Raw_MS.functions.Entity_Type_Code(l.Entity_Type),'');
				 self.Ent_SIC           := corp2.t2u(l.Entity_SIC);
				 self.Ent_Address       := l.Ent_Address;
			end;

			NormAlias := normalize(inProfiles,3,trfNormAlias(left,counter),local);
			
			// Norm Addresses for Entity Names & Aliases 
			NormAliasAddr      := normalize(NormAlias,left.Ent_Address,trfNormAddr(left,right),local);
			
			jAddlNames2   := join(NormAlias(EntityID <> ''),NormAliasAddr(EntityID <> ''),
											      left.EntityId  = right.EntityId and
												    left.Ent_Name  = right.Ent_Name,
												    join_NamesAddr(left,right), left outer, local);
			
			EntNames       := jAddlNames(Ent_Name <> '') + jAddlNames2(Ent_Name <> '');
			dedupEntNames  := dedup(sort(distribute(EntNames,HASH(EntityID)),EntityID,local),local);
			
			Corp2_mapping.LayoutsCommon.Main join_EntNames(AP_Base l, dedupEntNames r) := transform
				self.Corp_Legal_Name              := Corp2_mapping.fCleanBusinessName(state_origin,state_desc,r.Ent_Name).BusinessName;
				self.Corp_SIC_Code                := stringlib.stringfilter(r.Ent_SIC,'0123456789');
				self.Corp_LN_Name_Type_CD         := corp2.t2u(r.Ent_NameType_CD); 
				self.Corp_LN_Name_Type_Desc       := corp2.t2u(r.Ent_NameType_Desc); 
				self.Corp_Orig_Org_Structure_Desc := corp2.t2u(r.Ent_OrgStruc_Desc);
				self.Corp_Address1_Type_CD        := if (Corp2_mapping.fAddressExists(state_origin,state_desc,r.Ent_Address1,r.Ent_Address2,r.Ent_City,r.Ent_State,r.Ent_Zip,r.Ent_country).ifAddressExists,Corp2_Raw_MS.functions.Addr_Type_Code(r.Ent_AddrType),'');				
				self.Corp_Address1_Type_Desc      := if (Corp2_mapping.fAddressExists(state_origin,state_desc,r.Ent_Address1,r.Ent_Address2,r.Ent_City,r.Ent_State,r.Ent_Zip,r.Ent_country).ifAddressExists,Corp2_Raw_MS.functions.Addr_Type_Desc(r.Ent_AddrType),'');
				self.Corp_Address1_Line1			    := Corp2_mapping.fCleanAddress (state_origin,state_desc,r.Ent_Address1,r.Ent_Address2,r.Ent_City,r.Ent_State,r.Ent_Zip,r.Ent_country).AddressLine1;
				self.Corp_Address1_Line2  			  := Corp2_mapping.fCleanAddress (state_origin,state_desc,r.Ent_Address1,r.Ent_Address2,r.Ent_City,r.Ent_State,r.Ent_Zip,r.Ent_country).AddressLine2;
				self.Corp_Address1_Line3  			  := Corp2_mapping.fCleanAddress (state_origin,state_desc,r.Ent_Address1,r.Ent_Address2,r.Ent_City,r.Ent_State,r.Ent_Zip,r.Ent_country).AddressLine3;			
				self.Corp_prep_addr1_line1		    := Corp2_mapping.fCleanAddress (state_origin,state_desc,r.Ent_Address1,r.Ent_Address2,r.Ent_City,r.Ent_State,r.Ent_Zip,r.Ent_country).PrepAddrLine1;			
				self.Corp_prep_addr1_last_line    := Corp2_mapping.fCleanAddress (state_origin,state_desc,r.Ent_Address1,r.Ent_Address2,r.Ent_City,r.Ent_State,r.Ent_Zip,r.Ent_country).PrepAddrLastLine;
				self.Corp_Inc_county              := if (corp2.t2u(r.Ent_county) in ['','UNKNOWN','USA','ENTER YOUR ADDRESS LINE 1 HERE'] ,'' ,corp2.t2u(r.Ent_county)); 
				self                              := l;
				self                              := [];
			end;

			EntName_Base := join(AP_Base,dedupEntNames,
												   corp2.t2u(left.corp_orig_sos_charter_nbr) = corp2.t2u(right.EntityId),
											     join_EntNames(left,right), left outer, local);
																		
		 // Add CORP_TERM_EXIST info to records
	   Corp2_Raw_MS.Layouts.Lay_Temp_Term trfNormTerm(inProfiles l, integer C) := transform,
		         skip( (l.EntityID = '')                                        or
						       (c = 1 and corp2.t2u(l.Entity_Date_Type1) <> 'DURATION') or
									 (c = 2 and corp2.t2u(l.Entity_Date_Type1) <> 'EXPIRE')   or
									 (c = 3 and (integer)trim(l.Duration) = 0)                or
									 (c = 4 and corp2.t2u(l.Perpetual) <> 'YES'))
				 self.EntityID        := corp2.t2u(l.EntityID);
				 self.Term_Exist_Exp  := choose(C,map(corp2.t2u(l.Entity_Date_Type1) = 'DURATION' => Corp2_mapping.fValidateDate(l.Entity_date1[1..10],'CCYY-MM-DD').PastDate,
																					    corp2.t2u(l.Entity_Date_Type2) = 'DURATION' => Corp2_mapping.fValidateDate(l.Entity_date2[1..10],'CCYY-MM-DD').PastDate,
																							corp2.t2u(l.Entity_Date_Type3) = 'DURATION' => Corp2_mapping.fValidateDate(l.Entity_date3[1..10],'CCYY-MM-DD').PastDate,
																							''),
																					map(corp2.t2u(l.Entity_Date_Type1) = 'EXPIRE'   => Corp2_mapping.fValidateDate(l.Entity_date1[1..10],'CCYY-MM-DD').PastDate,
																							corp2.t2u(l.Entity_Date_Type2) = 'EXPIRE'   => Corp2_mapping.fValidateDate(l.Entity_date2[1..10],'CCYY-MM-DD').PastDate,
																						  corp2.t2u(l.Entity_Date_Type3) = 'EXPIRE'   => Corp2_mapping.fValidateDate(l.Entity_date3[1..10],'CCYY-MM-DD').PastDate,
																							''),
																					map((integer)trim(l.Duration) > 0                     => trim(l.Duration,left,right),
																					    ''));
																						
				 self.Term_Exist_CD   := map(C=1 and self.Term_Exist_Exp <> ''       => 'D',
				                             C=2 and self.Term_Exist_Exp <> ''       => 'D',
															  		 C=3 and (integer)trim(l.Duration) > 0   => 'N',
																  	 C=4 and corp2.t2u(l.Perpetual) = 'YES'  => 'P',
																		 '');
				 self.Term_Exist_Desc := map(C=1 and self.Term_Exist_Exp <> ''       => 'DURATION DATE',
				                             C=2 and self.Term_Exist_Exp <> ''       => 'EXPIRATION DATE',
															  		 C=3 and (integer)trim(l.Duration) > 0   => 'NUMBER OF YEARS',
																  	 C=4 and corp2.t2u(l.Perpetual) = 'YES'  => 'PERPETUAL',
																		 '');					
			end;

			normTerm := normalize(inProfiles,4,trfNormTerm(left,counter),local);
			
			Corp2_mapping.LayoutsCommon.Main join_Term(EntName_Base l, NormTerm r) := transform
				self.Corp_Term_Exist_Exp  := corp2.t2u(r.Term_Exist_Exp);
				self.Corp_Term_Exist_CD   := corp2.t2u(r.Term_Exist_CD); 
				self.Corp_Term_Exist_Desc := corp2.t2u(r.Term_Exist_Desc); 
				self                      := l;
      end;
       
			//records were created with blank Cd, Exp, & Desc fields.  Remove records with blank Term_Exist_CD fields. 
			 EntTerm_Base := join(EntName_Base,NormTerm(Term_Exist_CD <> ''),
												    corp2.t2u(left.corp_orig_sos_charter_nbr) = corp2.t2u(right.EntityId),
												    join_Term(left,right), left outer, local);

		  // Norm REGISTERED AGENTS 
		  Corp2_Raw_MS.Layouts.Lay_Temp_RA trfNormRA(inProfiles l, Corp2_Raw_MS.Layouts.Lay_Address_In r) := transform
				SELF.EntityId     := corp2.t2u(l.EntityID); 
				STRING fullName   := Corp2_Raw_MS.Functions.RemoveQuotes(l.RA_FirstName + ' ' + l.RA_MiddleName + ' ' + l.RA_LastName + ' ' + l.RA_Suffix);
				SELF.Ent_Name     := if(Corp2_Raw_MS.Functions.Format_RA_Entity(l.RA_EntName) <> ''
															 ,Corp2_Raw_MS.Functions.Format_RA_Entity(l.RA_EntName) ,corp2.t2u(fullName));
				SELF.Ent_AddrType := trim(r.AddrType);
				SELF.Ent_Address1 := Corp2_Raw_MS.Functions.PreCleanAddr(r.Address1);
				SELF.Ent_Address2 := Corp2_Raw_MS.Functions.PreCleanAddr(r.Address2);
				SELF.Ent_City     := Corp2_Raw_MS.Functions.PreCleanAddr(r.City);
				SELF.Ent_State    := Corp2_Raw_MS.Functions.PreCleanAddr(r.State);
				SELF.Ent_Zip      := Corp2_Raw_MS.Functions.PreCleanAddr(r.Zip);
				SELF.Ent_county   := Corp2_Raw_MS.Functions.PreCleanAddr(r.county);
				SELF.Ent_country  := Corp2_Raw_MS.Functions.PreCleanAddr(r.country);
			end;

			NormRA := normalize(inProfiles,left.RA_Address,trfNormRA(left,right),local);
		
			Corp2_mapping.LayoutsCommon.Main join_RAs(EntTerm_Base l, NormRA r) := transform
				self.Corp_RA_Address_Type_CD    := if (Corp2_mapping.fAddressExists(state_origin,state_desc,r.Ent_Address1,r.Ent_Address2,r.Ent_City,r.Ent_State,r.Ent_Zip,r.Ent_country).ifAddressExists,Corp2_Raw_MS.functions.Addr_Type_Code(r.Ent_AddrType),'');
				self.Corp_RA_Address_Type_Desc  := if (Corp2_mapping.fAddressExists(state_origin,state_desc,r.Ent_Address1,r.Ent_Address2,r.Ent_City,r.Ent_State,r.Ent_Zip,r.Ent_country).ifAddressExists,Corp2_Raw_MS.functions.Addr_Type_Desc(r.Ent_AddrType),'');
  			self.Corp_RA_Address_Line1			:= Corp2_mapping.fCleanAddress(state_origin,state_desc,r.Ent_Address1,r.Ent_Address2,r.Ent_City,r.Ent_State,r.Ent_Zip,r.Ent_country).AddressLine1;
				self.Corp_RA_Address_Line2			:= Corp2_mapping.fCleanAddress(state_origin,state_desc,r.Ent_Address1,r.Ent_Address2,r.Ent_City,r.Ent_State,r.Ent_Zip,r.Ent_country).AddressLine2;
				self.Corp_RA_Address_Line3			:= Corp2_mapping.fCleanAddress(state_origin,state_desc,r.Ent_Address1,r.Ent_Address2,r.Ent_City,r.Ent_State,r.Ent_Zip,r.Ent_country).AddressLine3;			
				self.RA_Prep_Addr_Line1				  := Corp2_mapping.fCleanAddress(state_origin,state_desc,r.Ent_Address1,r.Ent_Address2,r.Ent_City,r.Ent_State,r.Ent_Zip,r.Ent_country).PrepAddrLine1;			
				self.RA_Prep_Addr_Last_Line	    := Corp2_mapping.fCleanAddress(state_origin,state_desc,r.Ent_Address1,r.Ent_Address2,r.Ent_City,r.Ent_State,r.Ent_Zip,r.Ent_country).PrepAddrLastLine;
				self.Corp_Agent_county          := corp2.t2u(r.Ent_county);
				self                            := l;
      end;
 
			mapCorp := join(EntTerm_Base,NormRA(EntityID <> ''),
											left.corp_orig_sos_charter_nbr = right.EntityId and
											left.Corp_RA_full_Name  = right.Ent_Name,
											join_RAs(left,right), left outer, local);

		//------- End CORP mapping ---------------------------------------------------------------------------//

    
		//------- Begin CONTACTS mapping ---------------------------------------------------------------------//	
 		
		// map Party information 
    Corp2_mapping.LayoutsCommon.Main NormParty(inProfiles l, Corp2_Raw_MS.Layouts.Lay_Party_In r) := transform
		    ,skip(corp2.t2u(r.Party_EntName) in ['','N/A','NA','NONE','NO OFFICER RECORD AVAILABLE'] and 
						  corp2.t2u(r.Party_FirstName + r.Party_MiddleName + r.Party_LastName) in ['','N/A','NA','NONE','NO OFFICER RECORD AVAILABLE'])
			self.corp_key                   := state_fips + '-' + corp2.t2u(l.EntityID);  
			self.corp_orig_sos_charter_nbr 	:= corp2.t2u(l.EntityID);
			self.Cont_Type_Desc             := Corp2_Raw_MS.functions.Cont_Type_Desc(r.Party_Type);
			self.Cont_full_Name             := if(corp2.t2u(r.Party_EntName) not in ['','N/A','NA','NONE','NO OFFICER RECORD AVAILABLE']
																           ,Corp2_mapping.fCleanBusinessName(state_origin,state_desc,r.Party_EntName).BusinessName
																		  		 ,Corp2_mapping.fCleanBusinessName(state_origin,state_desc,r.Party_FirstName + ' ' + r.Party_MiddleName + ' ' + r.Party_LastName + ' ' + r.Party_Suffix).BusinessName);
			self.Cont_Title1_Desc           := Corp2_Raw_MS.functions.Cont_Title_Desc(r.Party_Title1);  
			self.Cont_Title2_Desc           := Corp2_Raw_MS.functions.Cont_Title_Desc(r.Party_Title2);
			self.Cont_Title3_Desc           := Corp2_Raw_MS.functions.Cont_Title_Desc(r.Party_Title3);
			self.Cont_Title4_Desc           := Corp2_Raw_MS.functions.Cont_Title_Desc(r.Party_Title4);
			self.Cont_Title5_Desc           := Corp2_Raw_MS.functions.Cont_Title_Desc(r.Party_Title5);
			self.Cont_Status_Desc           := if (corp2.t2u(r.Party_Status) in ['CURRENT','PRIOR','NEW'], corp2.t2u(r.Party_Status), ''); // None populated in sample input
			self.Cont_Effective_Date        := map(r.Party_Elect_Date[1..10] <> '' => Corp2_mapping.fValidateDate(r.Party_Elect_Date[1..10],'CCYY-MM-DD').GeneralDate,
																						 r.Party_Exp_Date[1..10]   <> '' => Corp2_mapping.fValidateDate(r.Party_Exp_Date[1..10]  ,'CCYY-MM-DD').GeneralDate,
																						 ''); // None populated in sample input data
      self.Cont_Effective_CD          := map(r.Party_Elect_Date <> '' and self.Cont_Effective_Date <> '' => 'E',
																						 r.Party_Exp_Date   <> '' and self.Cont_Effective_Date <> '' => 'T',
																						 ''); // None populated in sample input data
      self.Cont_Effective_Desc        := map(self.Cont_Effective_CD = 'E' => 'ELECTION',
																						 self.Cont_Effective_CD = 'T' => 'TERMINATION',
																						 ''); // None populated in sample input data
			self.Cont_Owner_Percentage      := (integer)corp2.t2u(r.Party_Perc_Own);	// None populated in sample input		
			self.Cont_Addl_Info             := if (corp2.t2u(r.Party_Exemption) <> '' , 'EXEMPTION: ' + corp2.t2u(r.Party_Exemption), '');  // None populated in sample input
			self.cont_address_type_cd       := if (Corp2_mapping.fAddressExists(state_origin,state_desc,Corp2_Raw_MS.Functions.PreCleanAddr(r.Party_Address1),Corp2_Raw_MS.Functions.PreCleanAddr(r.Party_Address2),Corp2_Raw_MS.Functions.PreCleanAddr(r.Party_City),Corp2_Raw_MS.Functions.PreCleanAddr(r.Party_State),Corp2_Raw_MS.Functions.PreCleanAddr(r.Party_Zip),Corp2_Raw_MS.Functions.PreCleanAddr(r.Party_country)).ifAddressExists,Corp2_Raw_MS.functions.Addr_Type_Code(r.Party_AddrType),'');
			self.cont_address_type_desc     := if (Corp2_mapping.fAddressExists(state_origin,state_desc,Corp2_Raw_MS.Functions.PreCleanAddr(r.Party_Address1),Corp2_Raw_MS.Functions.PreCleanAddr(r.Party_Address2),Corp2_Raw_MS.Functions.PreCleanAddr(r.Party_City),Corp2_Raw_MS.Functions.PreCleanAddr(r.Party_State),Corp2_Raw_MS.Functions.PreCleanAddr(r.Party_Zip),Corp2_Raw_MS.Functions.PreCleanAddr(r.Party_country)).ifAddressExists,Corp2_Raw_MS.functions.Addr_Type_Desc(r.Party_AddrType),'');
			self.cont_address_line1					:= Corp2_mapping.fCleanAddress(state_origin,state_desc,Corp2_Raw_MS.Functions.PreCleanAddr(r.Party_Address1),Corp2_Raw_MS.Functions.PreCleanAddr(r.Party_Address2),Corp2_Raw_MS.Functions.PreCleanAddr(r.Party_City),Corp2_Raw_MS.Functions.PreCleanAddr(r.Party_State),Corp2_Raw_MS.Functions.PreCleanAddr(r.Party_Zip),Corp2_Raw_MS.Functions.PreCleanAddr(r.Party_country)).AddressLine1;
			self.cont_address_line2					:= Corp2_mapping.fCleanAddress(state_origin,state_desc,Corp2_Raw_MS.Functions.PreCleanAddr(r.Party_Address1),Corp2_Raw_MS.Functions.PreCleanAddr(r.Party_Address2),Corp2_Raw_MS.Functions.PreCleanAddr(r.Party_City),Corp2_Raw_MS.Functions.PreCleanAddr(r.Party_State),Corp2_Raw_MS.Functions.PreCleanAddr(r.Party_Zip),Corp2_Raw_MS.Functions.PreCleanAddr(r.Party_country)).AddressLine2;
			self.cont_address_line3					:= Corp2_mapping.fCleanAddress(state_origin,state_desc,Corp2_Raw_MS.Functions.PreCleanAddr(r.Party_Address1),Corp2_Raw_MS.Functions.PreCleanAddr(r.Party_Address2),Corp2_Raw_MS.Functions.PreCleanAddr(r.Party_City),Corp2_Raw_MS.Functions.PreCleanAddr(r.Party_State),Corp2_Raw_MS.Functions.PreCleanAddr(r.Party_Zip),Corp2_Raw_MS.Functions.PreCleanAddr(r.Party_country)).AddressLine3;			
			self.cont_prep_addr_line1				:= Corp2_mapping.fCleanAddress(state_origin,state_desc,Corp2_Raw_MS.Functions.PreCleanAddr(r.Party_Address1),Corp2_Raw_MS.Functions.PreCleanAddr(r.Party_Address2),Corp2_Raw_MS.Functions.PreCleanAddr(r.Party_City),Corp2_Raw_MS.Functions.PreCleanAddr(r.Party_State),Corp2_Raw_MS.Functions.PreCleanAddr(r.Party_Zip),Corp2_Raw_MS.Functions.PreCleanAddr(r.Party_country)).PrepAddrLine1;			
			self.cont_prep_addr_last_line	  := Corp2_mapping.fCleanAddress(state_origin,state_desc,Corp2_Raw_MS.Functions.PreCleanAddr(r.Party_Address1),Corp2_Raw_MS.Functions.PreCleanAddr(r.Party_Address2),Corp2_Raw_MS.Functions.PreCleanAddr(r.Party_City),Corp2_Raw_MS.Functions.PreCleanAddr(r.Party_State),Corp2_Raw_MS.Functions.PreCleanAddr(r.Party_Zip),Corp2_Raw_MS.Functions.PreCleanAddr(r.Party_country)).PrepAddrLastLine;
			self                            := [];
		end;

    Cont_Party := normalize(inProfiles,left.Party_Names,NormParty(left,right),local);

		// map Entity Individuals not used as Corp_Legal_Names  
    Corp2_mapping.LayoutsCommon.Main NormEnt(inProfiles l, Corp2_Raw_MS.Layouts.Lay_Address_In r) := transform
		           , skip(corp2.t2u(l.Entity_FirstName + l.Entity_MiddleName + l.Entity_LastName) in ['','N/A','NA','NONE','NO OFFICER RECORD AVAILABLE'])
		  self.corp_key                 := state_fips + '-' + corp2.t2u(l.EntityID);
			self.corp_orig_sos_charter_nbr:= corp2.t2u(l.EntityID);
			self.Cont_Type_CD             := 'O';
      self.Cont_Type_Desc           := 'OWNER';
			self.Cont_full_Name           := Corp2_mapping.fCleanBusinessName(state_origin,state_desc,Corp2_Raw_MS.Functions.RemoveQuotes(l.Entity_FirstName + ' ' + l.Entity_MiddleName + ' ' + l.Entity_LastName + ' ' + l.Entity_Suffix)).BusinessName;
			self.cont_address_type_cd     := if (Corp2_mapping.fAddressExists(state_origin,state_desc,Corp2_Raw_MS.Functions.PreCleanAddr(r.Address1),Corp2_Raw_MS.Functions.PreCleanAddr(r.Address2),Corp2_Raw_MS.Functions.PreCleanAddr(r.City),Corp2_Raw_MS.Functions.PreCleanAddr(r.State),Corp2_Raw_MS.Functions.PreCleanAddr(r.Zip)).ifAddressExists,Corp2_Raw_MS.functions.Addr_Type_Code(r.AddrType),'');
			self.cont_address_type_desc   := if (Corp2_mapping.fAddressExists(state_origin,state_desc,Corp2_Raw_MS.Functions.PreCleanAddr(r.Address1),Corp2_Raw_MS.Functions.PreCleanAddr(r.Address2),Corp2_Raw_MS.Functions.PreCleanAddr(r.City),Corp2_Raw_MS.Functions.PreCleanAddr(r.State),Corp2_Raw_MS.Functions.PreCleanAddr(r.Zip)).ifAddressExists,Corp2_Raw_MS.functions.Addr_Type_Desc(r.AddrType),'');
			self.cont_address_line1				:= Corp2_mapping.fCleanAddress(state_origin,state_desc,Corp2_Raw_MS.Functions.PreCleanAddr(r.Address1),Corp2_Raw_MS.Functions.PreCleanAddr(r.Address2),Corp2_Raw_MS.Functions.PreCleanAddr(r.City),Corp2_Raw_MS.Functions.PreCleanAddr(r.State),Corp2_Raw_MS.Functions.PreCleanAddr(r.Zip)).AddressLine1;
			self.cont_address_line2				:= Corp2_mapping.fCleanAddress(state_origin,state_desc,Corp2_Raw_MS.Functions.PreCleanAddr(r.Address1),Corp2_Raw_MS.Functions.PreCleanAddr(r.Address2),Corp2_Raw_MS.Functions.PreCleanAddr(r.City),Corp2_Raw_MS.Functions.PreCleanAddr(r.State),Corp2_Raw_MS.Functions.PreCleanAddr(r.Zip)).AddressLine2;
			self.cont_address_line3				:= Corp2_mapping.fCleanAddress(state_origin,state_desc,Corp2_Raw_MS.Functions.PreCleanAddr(r.Address1),Corp2_Raw_MS.Functions.PreCleanAddr(r.Address2),Corp2_Raw_MS.Functions.PreCleanAddr(r.City),Corp2_Raw_MS.Functions.PreCleanAddr(r.State),Corp2_Raw_MS.Functions.PreCleanAddr(r.Zip)).AddressLine3;			
			self.cont_prep_addr_line1			:= Corp2_mapping.fCleanAddress(state_origin,state_desc,Corp2_Raw_MS.Functions.PreCleanAddr(r.Address1),Corp2_Raw_MS.Functions.PreCleanAddr(r.Address2),Corp2_Raw_MS.Functions.PreCleanAddr(r.City),Corp2_Raw_MS.Functions.PreCleanAddr(r.State),Corp2_Raw_MS.Functions.PreCleanAddr(r.Zip)).PrepAddrLine1;			
			self.cont_prep_addr_last_line	:= Corp2_mapping.fCleanAddress(state_origin,state_desc,Corp2_Raw_MS.Functions.PreCleanAddr(r.Address1),Corp2_Raw_MS.Functions.PreCleanAddr(r.Address2),Corp2_Raw_MS.Functions.PreCleanAddr(r.City),Corp2_Raw_MS.Functions.PreCleanAddr(r.State),Corp2_Raw_MS.Functions.PreCleanAddr(r.Zip)).PrepAddrLastLine;
			self                          := [];
		end;
		
		Cont_Entity := normalize(inProfiles,left.Ent_Address,NormEnt(left,right),local);
		
		// map Authorized Partners  
  	Corp2_mapping.LayoutsCommon.Main tContAP(Corp2_Raw_MS.Layouts.Lay_Temp_AP l) := transform
		    ,skip(corp2.t2u(l.AP_str) in ['','N/A','NA','NONE','NO OFFICER RECORD AVAILABLE'])
		  self.corp_key                 := state_fips + '-' + corp2.t2u(l.EntityID);
			self.corp_orig_sos_charter_nbr:= corp2.t2u(l.EntityID);
			self.Cont_Type_Desc           := 'AUTHORIZED PARTNER';
			self.Cont_full_Name           := Corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.AP_str).BusinessName;
			self                          := [];
		end;
		
		Cont_AP    := project(dedupAP, tContAP(left));
		
		sortCont   := distribute(Cont_Party(corp_key <> '') + Cont_Entity(corp_key <> '') + Cont_AP, HASH(corp_orig_sos_charter_nbr));
		
		// join with mapCorp to get base info
		Corp2_mapping.LayoutsCommon.Main joinCorpInfo(mapCorp l, sortCont r) := transform
			self.Corp_Key                   := if(corp2.t2u(l.Corp_Key) <> '',corp2.t2u(l.Corp_Key),corp2.t2u(r.Corp_Key));
			self.Corp_Orig_SOS_Charter_Nbr  := if(corp2.t2u(l.Corp_Orig_SOS_Charter_Nbr)<> '',corp2.t2u(l.Corp_Orig_SOS_Charter_Nbr),corp2.t2u(r.Corp_Orig_SOS_Charter_Nbr));
			self.Corp_Legal_Name            := if(corp2.t2u(l.Corp_Legal_Name)<> '',corp2.t2u(l.Corp_Legal_Name),corp2.t2u(r.Corp_Legal_Name));
			self.recordOrigin               := 'T';
			self                            := r;
		end;
				
		jCont      := join(mapCorp,sortCont,
						  	       left.corp_orig_sos_charter_nbr  = right.corp_orig_sos_charter_nbr, 
										   joinCorpInfo(left,right), right outer, local);
											
		mapCont  := dedup(sort(distribute(jCont,HASH(Corp_Key)),record,local),record,local);

    //---------- End CONTACTS mapping --------------------------------------------------------------//
		
		//map hardcoded values
		 Corp2_mapping.LayoutsCommon.Main trfCorpCont(Corp2_mapping.LayoutsCommon.Main l) := transform
        self.dt_vendor_first_reported	      := (integer)fileDate;
				self.dt_vendor_last_reported	      := (integer)fileDate;
				self.dt_first_seen				          := (integer)fileDate;
				self.dt_last_seen				            := (integer)fileDate;
				self.corp_ra_dt_first_seen		      := (integer)fileDate;
				self.corp_ra_dt_last_seen		        := (integer)fileDate;
				self.corp_vendor 					          := state_fips;
				self.corp_state_origin 			        := state_origin;
				self.corp_inc_state				          := state_origin;
				self.corp_process_date 			        := filedate;
				self                                := l;
				self                                := [];
		 end;
		 
		 mapCorpCont  := project(mapCorp + mapCont, trfCorpCont(left));		 
	  //---------- End MAIN mapping ------------------------------------------------------------------//
	
	  
		//---------- Begin EVENTS mapping --------------------------------------------------------------//	
		
		 //map Event records from FORMS file
		 Corp2_mapping.LayoutsCommon.Events transEvent1(Corp2_Raw_MS.Layouts.FormsLayoutIN l) := transform
						,skip(corp2.t2u(l.DocumentType)[1..13] = 'ANNUAL REPORT' or l.EntityID = '')
       self.Corp_Key             := state_fips + '-' + trim(l.EntityID,left,right);
  	   self.Corp_Vendor          := state_fips;
	     self.Corp_State_Origin    := state_origin;
    	 self.Corp_SOS_Charter_Nbr := corp2.t2u(l.EntityID);
	     self.Corp_Process_Date    := fileDate;
			 self.Event_Filing_Date    := Corp2_mapping.fValidateDate(regexreplace('[ ]?\\d{1,2}([:.]?\\d{1,2})*([ ]?[A|P]M)?$',l.DateFiled,'')).GeneralDate;
			 self.Event_Filing_Desc    := Corp2_Raw_MS.functions.Event_Type_Desc(l.DocumentType);
			 self                      := [];
		 end;
		 
		 Event_Recs1 := project(inForms, transEvent1(left));
		 
		 
		 Event_Filing     := ['APPROVED','ANNUALMEETINGDATE','SUBMITTED','AMENDMENTADOPTEDDATE'];
		 
		 //map Event records from PROFILES file (none were found in sample data, but coding per the CI
		 Corp2_mapping.LayoutsCommon.Events transEvent2(Corp2_Raw_MS.Layouts.ProfilesLayoutIN l) := transform,
		      skip(l.EntityID = '' or
							(corp2.t2u(l.Entity_Date_Type1) not in Event_Filing and
							 corp2.t2u(l.Entity_Date_Type2) not in Event_Filing and
							 corp2.t2u(l.Entity_Date_Type3) not in Event_Filing))
		   self.Corp_Key             := state_fips + '-' + corp2.t2u(l.EntityID);
  	   self.Corp_Vendor          := state_fips;
	     self.Corp_State_Origin    := state_origin;
   		 self.Corp_SOS_Charter_Nbr := corp2.t2u(l.EntityID);
	     self.Corp_Process_Date    := fileDate; 
			 self.Event_Filing_Date    := map(corp2.t2u(l.Entity_Date_Type1) in Event_Filing => Corp2_mapping.fValidateDate(l.Entity_date1[1..10],'CCYY-MM-DD').PastDate,
																				corp2.t2u(l.Entity_Date_Type2) in Event_Filing => Corp2_mapping.fValidateDate(l.Entity_date2[1..10],'CCYY-MM-DD').PastDate,
																		    corp2.t2u(l.Entity_Date_Type3) in Event_Filing => Corp2_mapping.fValidateDate(l.Entity_date3[1..10],'CCYY-MM-DD').PastDate,
																					  '');
			 self.Event_Filing_Desc    := map(corp2.t2u(l.Entity_Date_Type1) in Event_Filing => Corp2_Raw_MS.functions.Date_Type_Desc(l.Entity_Date_Type1),
																				corp2.t2u(l.Entity_Date_Type2) in Event_Filing => Corp2_Raw_MS.functions.Date_Type_Desc(l.Entity_Date_Type2),
																	      corp2.t2u(l.Entity_Date_Type3) in Event_Filing => Corp2_Raw_MS.functions.Date_Type_Desc(l.Entity_Date_Type3),
																			  '');
			 self                      := [];
		 end;
		 
		 Event_Recs2 := project(inProfiles, transEvent2(left));
		 		 
		 all_Event   := Event_Recs1 + Event_Recs2;
	   //---------- End EVENTS mapping ----------------------------------------------------------------//	
		 
		 
		 //---------- Begin AR mapping ------------------------------------------------------------------//	
		 
		 //ANNUAL REPORT information from Forms records
		 Corp2_mapping.LayoutsCommon.AR trfFormsAR(Corp2_Raw_MS.Layouts.FormsLayoutIN l) := transform
						,skip(corp2.t2u(l.DocumentType)[1..13] <> 'ANNUAL REPORT' or corp2.t2u(l.EntityID) = '')
       self.Corp_key             := state_fips + '-' + corp2.t2u(l.EntityID);
  	   self.Corp_SOS_Charter_Nbr := corp2.t2u(l.EntityID);
			 self.AR_Filed_dt          := Corp2_mapping.fValidateDate(regexreplace('[ ]?\\d{1,2}([:.]?\\d{1,2})*([ ]?[A|P]M)?$',l.DateFiled,'')).PastDate;		 
			 self                      := [];
		 end;									
		 
		 FormsAR := project(inForms,trfFormsAR(left));
		 
		 //ANNUAL REPORT information from Profiles records
		 Corp2_mapping.LayoutsCommon.AR trfProfAR(Corp2_Raw_MS.Layouts.ProfilesLayoutIN l) := transform
					,skip(corp2.t2u(l.EntityID) = '')
       self.Corp_Key             := state_fips + '-' + corp2.t2u(l.EntityID);
  	   self.Corp_SOS_Charter_Nbr := corp2.t2u(l.EntityID);
			 self.AR_Year								:= if (_validate.date.fIsValid(stringlib.stringfilter(l.ReportYear,'0123456789'),_validate.date.Rules.YearValid)
																					,corp2.t2u(l.ReportYear),''); 
			 self.AR_Due_dt            := Corp2_mapping.fValidateDate(l.DueDate[1..10],'CCYY-MM-DD').PastDate; // None populated in sample input data
			 self                      := [];
		 end;
		 
		 ProfilesAR := project(inProfiles, trfProfAR(left));		 

		 // join Forms AR recs with Profiles AR recs
		 Corp2_mapping.LayoutsCommon.AR joinARs(ProfilesAR l, FormsAR r) := transform
  	   self.Corp_Vendor          := state_fips;
	     self.Corp_State_Origin    := state_origin;
			 self.Corp_Process_Date    := filedate;
   		 self.Corp_Key             := if(l.Corp_Key <> '', l.Corp_Key, r.Corp_Key);
			 self.Corp_SOS_Charter_Nbr := if(l.Corp_SOS_Charter_Nbr <> '', l.Corp_SOS_Charter_Nbr, r.Corp_SOS_Charter_Nbr);
			 self.AR_Filed_dt          := r.AR_Filed_dt;
			 self.AR_Year              := l.AR_Year;
			 self.AR_Due_dt            := l.AR_Due_dt;
			 self                      := [];
		 end;
		 
		 all_AR  := join(ProfilesAR(AR_Year <> '' or AR_Due_dt <> ''), FormsAR(AR_Filed_dt <> ''),
							         left.Corp_SOS_Charter_Nbr  = right.Corp_SOS_Charter_Nbr,  
											 joinARs(left,right), full outer, local);
											
		//---------- End AR mapping --------------------------------------------------------------------//									
	
		 
    //---------- Begin STOCKS mapping --------------------------------------------------------------//	
		Corp2_mapping.LayoutsCommon.Stock NormStock(inProfiles l, Corp2_Raw_MS.Layouts.Lay_Stocks_In r) := transform
			    ,skip(corp2.t2u(l.EntityID) = '')
			self.Corp_Key                         := state_fips + '-' + corp2.t2u(l.EntityID);
	    self.Corp_Vendor                      := state_fips;
	    self.Corp_State_Origin                := state_origin;
	    self.Corp_Process_Date                := fileDate;
			self.Corp_SOS_Charter_Nbr             := corp2.t2u(l.EntityID);
			self.Stock_Authorized_Nbr             := if(trim(r.Shares) <> '9999999999',stringlib.stringfilter(r.Shares,'0123456789'),'');
			self.Stock_Par_Value                  := if((integer)r.ParValue <> 0,stringlib.stringfilter(r.ParValue,'0123456789'),'');  // None populated in sample input data
			self.Stock_Class                      := Corp2_Raw_MS.functions.Stock_Class_Desc(r.ShareClass);
			self.Stock_Stock_Series               := corp2.t2u(r.ShareSeries);
			self.Stock_Shares_Issued              := if(trim(r.SharesIssued) <> '9999999999',stringlib.stringfilter(r.SharesIssued,'0123456789'),'');  
      self.Stock_SharesOfBeneficialInterest := (integer)trim(l.ShrsOfBeneficialInt); // None populated in sample input data
			self.Stock_BeneficialShareValue       := (integer)trim(l.BeneficialShrVal);    // None populated in sample input data
						
			Addl1 																:= if (corp2.t2u(r.ShareSeries)  <> '','STOCK SERIES: ' + corp2.t2u(r.ShareSeries), '');  // Keeping this since stock_stock_series is a new field in the layout
			Addl2 																:= if (corp2.t2u(l.Restrictions) <> '','RESTRICTIONS: ' + corp2.t2u(l.Restrictions),'');  // None populated in sample input data
			self.Stock_Addl_Info                  := map(Addl1 <> '' and Addl2 <> '' => corp2.t2u(Addl1 + '; ' + Addl2),
			                                             Addl1 <> '' and Addl2 = ''  => Addl1,
																									 Addl1 = ''  and Addl2 <> '' => Addl2,
																									 '');

			self                                  := [];
		end;
	
		norm_Stock  := normalize(inProfiles,left.Stock,NormStock(left,right),local);
		//---------- End STOCKS mapping -----------------------------------------------------------------//	
	  	 
	 
	 	//-------------------------------------------------------------------------------------------------------//
		// Build the Final mapped Files
		//-------------------------------------------------------------------------------------------------------//
	 	mapMain   := dedup(sort(distribute(mapCorpCont,hash(corp_key)),record,local),record,local) : independent;
		mapEvent  := dedup(sort(distribute(all_Event,hash(corp_key))  ,record,local),record,local) : independent;
		mapAR     := dedup(sort(distribute(all_AR,hash(corp_key))     ,record,local),record,local) : independent;
	  mapStock  := dedup(sort(distribute(norm_Stock,hash(corp_key)) ,record,local),record,local) : independent;
	  

	//======================SCRUBS LOGIC=====================================
	//--------------------------------------------------------------------	
  // Scrubs for MAIN
  //--------------------------------------------------------------------
		Main_F := MapMain;
		Main_S := Scrubs_Corp2_Mapping_MS_Main.Scrubs;        // Scrubs module
		Main_N := Main_S.FromNone(Main_F); 										// Generate the error flags
		Main_T := Main_S.FromBits(Main_N.BitmapInfile);     	// Use the FromBits module; makes my bitmap datafile easier to get to
		Main_U := Main_S.FromExpanded(Main_N.ExpandedInFile); // Pass the expanded error flags into the Expanded module

	//Outputs reports
		Main_ErrorSummary					:= output(Main_U.SummaryStats, named('Main_ErrorSummary_MS'+filedate));
		Main_ScrubErrorReport 		:= output(choosen(Main_U.AllErrors, 1000), named('Main_ScrubErrorReport_MS'+filedate));
		Main_SomeErrorValues			:= output(choosen(Main_U.BadValues, 1000), named('Main_SomeErrorValues_MS'+filedate));
		Main_IsScrubErrors		 		:= IF(count(Main_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Main_OrbitStats						:= Main_U.OrbitStats();
		
		//Outputs files
		Main_CreateBitMaps				:= output(Main_N.BitmapInfile,,'~thor_data::corp_MS_main_scrubs_bits',overwrite,compressed);	//long term storage
		Main_TranslateBitMap			:= output(Main_T);
		
	  //Submits Profile's stats to Orbit
    Main_SubmitStats          := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_MS_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp_MS_Main').SubmitStats;
			
		Main_ScrubsWithExamples		:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_MS_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp_MS_Main').CompareToProfile_with_Examples;
		
		Main_ScrubsAlert					:= Main_ScrubsWithExamples(RejectWarning = 'Y');
		Main_ScrubsAttachment			:= Scrubs.fn_email_attachment(Main_ScrubsAlert);
		Main_SendEmailFile				:= FileServices.SendEmailAttachData( corp2.Email_Notification_Lists.AttachedList
																																	 ,'Scrubs CorpMain_MS Report' //subject
																																	 ,'Scrubs CorpMain_MS Report' //body
																																	 ,(data)Main_ScrubsAttachment
																																	 ,'text/csv'
																																	 ,'CorpMSMainScrubsReport.csv'
																																	);		
																																 
		Main_BadRecords := Main_T.ExpandedInFile(	dt_vendor_first_reported_invalid	   <> 0 or 
																							dt_vendor_last_reported_invalid	     <> 0 or 
																							dt_first_seen_invalid	               <> 0 or 
																							dt_last_seen_invalid	               <> 0 or 
																							corp_ra_dt_first_seen_invalid	       <> 0 or 
																							corp_ra_dt_last_seen_invalid	       <> 0 or 
																							corp_process_date_invalid	           <> 0 or 
																							corp_filing_date_invalid	           <> 0 or 
																							corp_delayed_effective_date_invalid	 <> 0 or 
																							corp_forgn_date_invalid	             <> 0 or 
																							corp_dissolved_date_invalid	         <> 0 or 
																							corp_inc_date_invalid	               <> 0 or 
																							corp_key_invalid	                   <> 0 or 
																							corp_vendor_invalid	                 <> 0 or 
																							corp_state_origin_invalid	           <> 0 or 
																							corp_orig_sos_charter_nbr_invalid	   <> 0 or 
																							corp_legal_name_invalid	             <> 0 or 
																							corp_inc_state_invalid	             <> 0 or 
																							corp_foreign_domestic_ind_invalid	   <> 0 or 
																							corp_forgn_state_desc_invalid	 			 <> 0 or 
																							corp_for_profit_ind_invalid	   			 <> 0 or 
																							corp_status_desc_invalid	   				 <> 0 or 
																							corp_ln_name_type_cd_invalid	       <> 0 or 
																							corp_orig_org_structure_desc_invalid <> 0 or 
																							corp_filing_desc_invalid	           <> 0 or 
																							corp_country_of_formation_invalid    <> 0 or
																							cont_type_desc_invalid	             <> 0 or 
																							cont_title1_desc_invalid	           <> 0 or 
																							cont_title2_desc_invalid	           <> 0 or  
																							cont_title3_desc_invalid	           <> 0 or 
																							cont_title4_desc_invalid	           <> 0 or
																							cont_title5_desc_invalid	           <> 0 );

		Main_GoodRecords	:= Main_T.ExpandedInFile(  dt_vendor_first_reported_invalid	   = 0 and 
																								dt_vendor_last_reported_invalid	     = 0 and 
																								dt_first_seen_invalid	               = 0 and 
																								dt_last_seen_invalid	               = 0 and 
																								corp_ra_dt_first_seen_invalid	       = 0 and 
																								corp_ra_dt_last_seen_invalid	       = 0 and 
																								corp_process_date_invalid	           = 0 and 
																								corp_filing_date_invalid	           = 0 and 
																								corp_delayed_effective_date_invalid	 = 0 and 
																								corp_forgn_date_invalid	             = 0 and 
																								corp_dissolved_date_invalid	         = 0 and 
																								corp_inc_date_invalid	               = 0 and 
																								corp_key_invalid	                   = 0 and 
																								corp_vendor_invalid	                 = 0 and 
																								corp_state_origin_invalid	           = 0 and 
																								corp_orig_sos_charter_nbr_invalid	   = 0 and 
																								corp_legal_name_invalid	             = 0 and 
																								corp_inc_state_invalid	             = 0 and 
																								corp_foreign_domestic_ind_invalid	   = 0 and 
																								corp_forgn_state_desc_invalid	 			 = 0 and 
																								corp_for_profit_ind_invalid	   			 = 0 and 
																								corp_status_desc_invalid	   				 = 0 and 
																								corp_ln_name_type_cd_invalid	       = 0 and 
																								corp_orig_org_structure_desc_invalid = 0 and 
																								corp_filing_desc_invalid	           = 0 and 
																								corp_country_of_formation_invalid    = 0 and 
																								cont_type_desc_invalid	             = 0 and 
																								cont_title1_desc_invalid	           = 0 and 
																								cont_title2_desc_invalid	           = 0 and  
																								cont_title3_desc_invalid	           = 0 and 
																								cont_title4_desc_invalid	           = 0 and 
																								cont_title5_desc_invalid	           = 0 );																								 																	
		
		Main_FailBuild	:= map(corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_orig_sos_charter_nbr_invalid<>0)),count(Main_N.ExpandedInFile),false) > Scrubs_Corp2_Mapping_MS_Main.Threshold_Percent.CORP_ORIG_SOS_CHARTER_NBR => true,
													 corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_legal_name_invalid<>0)),					 count(Main_N.ExpandedInFile),false) > Scrubs_Corp2_Mapping_MS_Main.Threshold_Percent.CORP_LEGAL_NAME 					=> true,
													 corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_key_invalid<>0)),						     count(Main_N.ExpandedInFile),false) > Scrubs_Corp2_Mapping_MS_Main.Threshold_Percent.CORP_KEY      						=> true,
													 count(Main_GoodRecords) = 0																																																																																				          => true,
													 false );

		Main_ApprovedRecords := project(Main_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.Main,self := left));
	
		Main_RejFile_Exists		:= IF(FileServices.FileExists(Corp2_Mapping._dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_' + state_origin),true,false);			
	  Main_ALL		 					:= sequential(IF(count(Main_BadRecords) <> 0
																					,IF (poverwrite
																							,OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_MS',overwrite,__compressed__,named('Sample_Rejected_MainRecs_MS'+filedate))
																							,sequential (IF(Main_RejFile_Exists,fileservices.deletelogicalfile(Corp2_Mapping._dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+ state_origin)),
																													 OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+ state_origin,__compressed__,named('Sample_Rejected_MainRecs_MS'+filedate)))))
																		,output(Main_ScrubsWithExamples, ALL, NAMED('CorpMainMSScrubsReportWithExamples'+filedate))																		
																		//Send Alerts if Scrubs exceeds thresholds
																		,IF(COUNT(Main_ScrubsAlert) > 0, Main_SendEmailFile, OUTPUT('CORP2_MAPPING.MS - No "MAIN" Corp Scrubs Alerts'))
																		,Main_ErrorSummary
																		,Main_ScrubErrorReport
																		,Main_SomeErrorValues
																		,Main_SubmitStats);
																		
	//--------------------------------------------------------------------	
  // Scrubs for Event
  //--------------------------------------------------------------------
		Event_F := MapEvent;
		Event_S := Scrubs_Corp2_Mapping_MS_Event.Scrubs;        // MS scrubs module
		Event_N := Event_S.FromNone(Event_F); 									// Generate the error flags
		Event_T := Event_S.FromBits(Event_N.BitmapInfile);     	// Use the FromBits module; mMSes my bitmap datafile easier to get to
		Event_U := Event_S.FromExpanded(Event_N.ExpandedInFile);// Pass the expanded error flags into the Expanded module

	//Outputs reports
		Event_ErrorSummary				:= output(Event_U.SummaryStats, named('Event_ErrorSummary_MS'+filedate));
		Event_ScrubErrorReport 		:= output(choosen(Event_U.AllErrors, 1000), named('Event_ScrubErrorReport_MS'+filedate));
		Event_SomeErrorValues			:= output(choosen(Event_U.BadValues, 1000), named('Event_SomeErrorValues_MS'+filedate));
		Event_IsScrubErrors		 		:= IF(count(Event_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Event_OrbitStats						:= Event_U.OrbitStats();
		
		//Outputs files
		Event_CreateBitMaps				:= output(Event_N.BitmapInfile,,'~thor_data::corp_MS_Event_scrubs_bits',overwrite,compressed);	//long term storage
		Event_TranslateBitMap			:= output(Event_T);
		
		//Submits Profile's stats to Orbit
    Event_SubmitStats         := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_MS_Event','ScrubsAlerts', Event_OrbitStats, version,'Corp_MS_Event').SubmitStats;
		
	  Event_ScrubsWithExamples	:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_MS_Event','ScrubsAlerts', Event_OrbitStats, version,'Corp_MS_Event').CompareToProfile_with_Examples;
		
		Event_ScrubsAlert					:= Event_ScrubsWithExamples(RejectWarning = 'Y');
		Event_ScrubsAttachment		:= Scrubs.fn_email_attachment(Event_ScrubsAlert);
		Event_SendEmailFile				:= FileServices.SendEmailAttachData( corp2.Email_Notification_Lists.AttachedList
																																	 ,'Scrubs CorpEvent_MS Report' //subject
																																	 ,'Scrubs CorpEvent_MS Report' //body
																																	 ,(data)Event_ScrubsAttachment
																																	 ,'text/csv'
																																	 ,'CorpMSEventScrubsReport.csv'
																																);		
																																 
		Event_BadRecords := Event_T.ExpandedInFile(	corp_key_invalid  		         <> 0 or
																								Event_Filing_Desc_invalid 		 <> 0 );	

		Event_GoodRecords	:= Event_T.ExpandedInFile(corp_key_invalid  		         = 0 and
																								Event_Filing_Desc_invalid		 = 0 );																					 																	
		
		Event_FailBuild	:= if(count(Event_GoodRecords) = 0,true,false);

		Event_ApprovedRecords := project(Event_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.Events,self := left));		
		
		Event_RejFile_Exists			:= IF(FileServices.FileExists(Corp2_Mapping._dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::event_' + state_origin),true,false);			
	  Event_ALL									:= sequential(IF(count(Event_BadRecords)<> 0
																						 ,if(poverwrite
																								,OUTPUT(Event_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::event_MS',overwrite,__compressed__,named('Sample_Rejected_Event_Recs_MS'+filedate))
																								,sequential (IF(Event_RejFile_Exists,fileservices.deletelogicalfile(Corp2_Mapping._dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::event_'+ state_origin)),
																														 OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::event_'+ state_origin,__compressed__,named('Sample_Rejected_Event_Recs_MS'+filedate)))))
																					 ,output(Event_ScrubsWithExamples, ALL, NAMED('CorpEventMSScrubsReportWithExamples'+filedate))
																					 //Send Alerts if Scrubs exceeds thresholds
																					 ,IF(COUNT(Event_ScrubsAlert) > 0, Event_SendEmailFile, OUTPUT('CORP2_MAPPING.MS - No "EVENT" Corp Scrubs Alerts'))
																					 ,Event_ErrorSummary
																					 ,Event_ScrubErrorReport
																					 ,Event_SomeErrorValues
																					 ,Event_SubmitStats);
																				 
	//--------------------------------------------------------------------	
  // Scrubs for Stock
  //--------------------------------------------------------------------
		Stock_F := MapStock;
		Stock_S := Scrubs_Corp2_Mapping_MS_Stock.Scrubs;        // MS scrubs module
		Stock_N := Stock_S.FromNone(Stock_F); 									// Generate the error flags
		Stock_T := Stock_S.FromBits(Stock_N.BitmapInfile);     	// Use the FromBits module; makes my bitmap datafile easier to get to
		Stock_U := Stock_S.FromExpanded(Stock_N.ExpandedInFile);// Pass the expanded error flags into the Expanded module

	//Outputs reports
		Stock_ErrorSummary				:= output(Stock_U.SummaryStats, named('Stock_ErrorSummary_MS'+filedate));
		Stock_ScrubErrorReport 		:= output(choosen(Stock_U.AllErrors, 1000), named('Stock_ScrubErrorReport_MS'+filedate));
		Stock_SomeErrorValues			:= output(choosen(Stock_U.BadValues, 1000), named('Stock_SomeErrorValues_MS'+filedate));
		Stock_IsScrubErrors		 		:= IF(count(Stock_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Stock_OrbitStats						:= Stock_U.OrbitStats();
		
		//Outputs files
		Stock_CreateBitMaps				:= output(Stock_N.BitmapInfile,,'~thor_data::corp_MS_Stock_scrubs_bits',overwrite,compressed);	//long term storage
		Stock_TranslateBitMap			:= output(Stock_T);

		//Submits Profile's stats to Orbit
    Stock_SubmitStats         := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_MS_Stock','ScrubsAlerts', Stock_OrbitStats, version,'Corp_MS_Stock').SubmitStats;

		Stock_ScrubsWithExamples	:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_MS_Stock','ScrubsAlerts', Stock_OrbitStats, version,'Corp_MS_Stock').CompareToProfile_with_Examples;
		
		Stock_ScrubsAlert					:= Stock_ScrubsWithExamples(RejectWarning = 'Y');
		Stock_ScrubsAttachment		:= Scrubs.fn_email_attachment(Stock_ScrubsAlert);
		Stock_SendEmailFile				:= FileServices.SendEmailAttachData( corp2.Email_Notification_Lists.AttachedList
																																	 ,'Scrubs CorpStock_MS Report' //subject
																																	 ,'Scrubs CorpStock_MS Report' //body
																																	 ,(data)Stock_ScrubsAttachment
																																	 ,'text/csv'
																																	 ,'CorpMSStockScrubsReport.csv'
																																	);		
																																 
		Stock_BadRecords := Stock_T.ExpandedInFile(	corp_key_invalid  	  <> 0 or
																								Stock_class_invalid 	<> 0 );	

		Stock_GoodRecords	:= Stock_T.ExpandedInFile(corp_key_invalid  		 = 0 and
																								Stock_class_invalid		 = 0 );																					 																	
		
		Stock_FailBuild	:= if(count(Stock_GoodRecords) = 0,true,false);

		Stock_ApprovedRecords := project(Stock_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.Stock,self := left));		
		
		Stock_RejFile_Exists			:= IF(FileServices.FileExists(Corp2_Mapping._dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::stock_' + state_origin),true,false);			
	  Stock_ALL									:= sequential(IF(count(Stock_BadRecords)<> 0
																						 ,if(poverwrite
																								,OUTPUT(Stock_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::stock_MS',overwrite,__compressed__,named('Sample_Rejected_Stock_Recs_MS'+filedate))
																								,sequential (IF(Stock_RejFile_Exists,fileservices.deletelogicalfile(Corp2_Mapping._dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::stock_'+ state_origin)),
																														 OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::stock_'+ state_origin,__compressed__,named('Sample_Rejected_Stock_Recs_MS'+filedate)))))
																					 ,output(Stock_ScrubsWithExamples, ALL, NAMED('CorpStockMSScrubsReportWithExamples'+filedate))
																					 //Send Alerts if Scrubs exceeds thresholds
																					 ,IF(COUNT(Stock_ScrubsAlert) > 0, Stock_SendEmailFile, OUTPUT('CORP2_MAPPING.MS - No "STOCK" Corp Scrubs Alerts'))
																					 ,Stock_ErrorSummary
																					 ,Stock_ScrubErrorReport
																					 ,Stock_SomeErrorValues	
																					 ,Stock_SubmitStats);
																					 
 //-------------------- Version Control -----------------------------------------------------//	
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::main_ms'			,Main_ApprovedRecords ,main_out		     ,,,pOverwrite);		
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::stock_ms'			,Stock_ApprovedRecords,stock_out	     ,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::event_ms'			,Event_ApprovedRecords,event_out	     ,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::ar_ms'				,MapAR		            ,ar_out			     ,,,pOverwrite);
	
	VersionControl.macBuildNewLogicalFile('~thor_data400::failed::corp2::'+version+'::main_ms'	,MapMain              ,write_fail_main ,,,pOverwrite);		
	VersionControl.macBuildNewLogicalFile('~thor_data400::failed::corp2::'+version+'::stock_ms'	,MapStock             ,write_fail_stock,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile('~thor_data400::failed::corp2::'+version+'::event_ms'	,MapEvent	            ,write_fail_event,,,pOverwrite);
		
	mapMS:= sequential(   if(pshouldspray = true,Corp2_mapping.fSprayFiles(state_origin ,version,pOverwrite := pOverwrite))
											  // ,Corp2_Raw_MS.Build_Bases(filedate,version,pUseProd).All  // Determined building bases is not needed
												,main_out
												,event_out
												,ar_out
												,stock_out										
												,IF(Main_FailBuild <> true or Event_FailBuild <> true or Stock_FailBuild <> true
														,sequential( fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped+'::sprayed::ar'		,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::ar_MS')
																				,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped+'::sprayed::event',Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::event_MS')
																				,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped+'::sprayed::main'	,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::main_MS')																		 
																				,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped+'::sprayed::stock',Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::stock_MS')
																				,if (count(Main_BadRecords) <> 0 or  count(Event_BadRecords) <> 0 
																						 ,Corp2_Mapping.Send_Email(state_origin ,version,count(Main_BadRecords)<>0,,count(Event_BadRecords)<>0,count(Stock_BadRecords)<>0,count(Main_BadRecords),,count(Event_BadRecords),count(Stock_BadRecords),count(Main_ApprovedRecords),count(mapAR),count(Event_ApprovedRecords),count(Stock_ApprovedRecords)).RecordsRejected																				 
																						 ,Corp2_Mapping.Send_Email(state_origin ,version,count(Main_BadRecords)<>0,,count(Event_BadRecords)<>0,count(Stock_BadRecords)<>0,count(Main_BadRecords),,count(Event_BadRecords),count(Stock_BadRecords),count(Main_ApprovedRecords),count(mapAR),count(Event_ApprovedRecords),count(Stock_ApprovedRecords)).MappingSuccess	
																						 )	 
																			)
														 ,sequential( write_fail_main//if it fails on  main file threshold ,still writing mapped files!
																				 ,write_fail_stock 
																				 ,write_fail_event
																				 ,Corp2_Mapping.Send_Email(state_origin ,version).MappingFailed
																				)
													)
												,if (Main_IsScrubErrors or Event_IsScrubErrors or Stock_IsScrubErrors
														,Corp2_Mapping.Send_Email(state_origin ,version,Main_IsScrubErrors,false,Event_IsScrubErrors,Stock_IsScrubErrors).FieldsInvalidPerScrubs)
												,Event_All
												,Stock_All
												,Main_All	
										);
															
 		isFileDateValid := if((string)Std.Date.Today() between ut.date_math(filedate,-31) and ut.date_math(filedate,31),true,false);
		return sequential (if (isFileDateValid
														,mapMS
														,sequential (Corp2_Mapping.Send_Email(state_origin,filedate).InvalidFileDateParm
																				,FAIL('Corp2_Mapping.MS failed.  An invalid filedate was passed in as a parameter.')))); 	

 End; //Update Function

End;//End MS Module