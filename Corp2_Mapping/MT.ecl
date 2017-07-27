import Corp2, _validate, Address, lib_stringlib, _control, versioncontrol;

export MT := module

    export constants := module
	   export cluster := '~thor_data400::';
	end;
	
	export Layouts_Raw_Input := module
		
		// Record length 200
		export Vendor_Raw := record
		   ebcdic string1    BusinessEntityID;
		   ebcdic string6    BusinessEntityNo;
		   ebcdic string1    RecordType;
		   ebcdic string192  blob;
		end;
		
		// Record_Type = 1
		export Bus_Rec := record
			string1	BusinessEntityID;
			string6	BusinessEntityNo;
			string1	RecordType;
			string5	NonReadableText;
			string1	StatCode;
			string1	BusinessEntityCode;
			string6	BusinessEntityNum;
			string8	IncorporateDate;
			string4	TermofExistence;
			string8	ExpirationDate;
			string3	StatusCode;
			string3	StatusReasonCode;
			string8	FilingDate;
			string1	InactiveReasonCode;
			string8	InactiveDate;
			string8	ReviverReinstateDate;
			string2	CorporationType;
			string3	BusinessPurposeCD;
			string9	MontanaCodeStatute;
			string2	StateOfJurisdiction;
			string8	NoticeDate;
			string8	InvolDissolIntentDate;
			string8	VolunDissolIntentDate;
			string8	ARLastGenDate;
			string8	ARLastFiledDate;
			string8	SuspensionDate;
			string8	SuspensionIntentDate;
			string8	SuspensionDissolDate;
        end;
		
		// Record_Type = 2
		export Bus_Name_Rec := record
			string1   BusinessEntityID;
			string6   BusinessEntityNo;
			string1   RecordType;
			string5   NonReadableText;
			string1   StatusCode;
			string1   ReasonCode;
			string8   InactiveDate;
			string2   Filler;
			string144 BusinessName;			
		end;
		
		// Record_Type = 3
		export Off_Patner_Rec := record
			string1  BusinessEntityID;
			string6  BusinessEntityNo;
			string1  RecordType;
			string5  NonReadableText;
			string1  StatusCode;
			string1  OfficerNmTypeCD;
			string12 OfficerFirstNm;
			string2  OfficerInitial;
			string16 OfficerLastNm;
			string30 OfficerStreetAddr;
			string22 OfficerCity;
			string2  OfficerState;
			string9  OfficerZip;
			string30 OfficerCountry;
			string8  ManagerDissocDate;
		end;
		
		// Record_Type = 4
		export Off_Share_Rec := record
			string1  BusinessEntityID;
			string6  BusinessEntityNo;
			string1  RecordType;
			string5  NonReadableText;
			string1  StatusCode;
			string8  AuthorizedNbr;
			string1  Class;
			string15 Series;
			string8  SharesIssued;
			string1  ParValue;
			string9  ParValueAmnt;
		end;
		
		// Record_Type = 5
		export Rel_Bus_Rec := record
			string1  BusinessEntityID;
			string6  BusinessEntityNo;
			string1  RecordType;
			string5  NonReadableText;
			string1  StatusCode;
			string7  RelatedBusinessID;
			string1  RelationshipType;
			string8  RegMgrDissocDt;
			string30 RegMgrAddrLine1;
			string30 RegMgrAddrLine2;
			string22 RegMgrCity;
			string2  RegMgrState;
			string9  RegMgrZip;
			string30 RegMgrCountry;
		end;
		
		// Record_Type = 6
		export Agent_Own_Rec := record
			string1  BusinessEntityID;
			string6  BusinessEntityNo;
			string1  RecordType;
			string5  NonReadableText;
			string1  StatusCode;
			string1  OwnerTypeCD;
			string35 RAName;
			string30 RAAddrLine1;
			string30 RAAddrLine2;
			string22 RACity;
			string2  RAState;
			string9  RAZip;
		end;
		
		// Record_Type = 7
		export Rel_Bus_ABN_Rec := record
			string1  BusinessEntityID;
			string6  BusinessEntityNo;
			string1  RecordType;
			string5  NonReadableText;
			string1  StatusCode;
			string57 Counties;
			string8  DateFirstUse;
			string7  FolderLocation;
			string35 Purpose;
		end;
		
		// Record_Type = 8
		export Rel_Bus_FRGN_Rec := record
			string1  BusinessEntityID;
			string6  BusinessEntityNo;
			string1  RecordType;
			string5  NonReadableText;
			string1  StatusCode;
			string8  QualificationFilingDt;
			string30 PrincipleOfficeStreetAddr;
			string22 PrincipleOfficeCity;
			string2  PrincipleOfficeSt;
			string9  PrincipleOfficeZip;
			string20 PrincipleOfficeCountry;
			string30 CountryofJurisdiction;
			string15 TotalReceipts;
			string15 MontanaReceipts;
			string15 TotalValue;
			string15 MontanaValue;
			string3  PercentageEmploymentMT;
		end;
		
		// Record_Type = 9
		export Rel_Bus_TM_Rec := record
			string1  BusinessEntityID;
			string6  BusinessEntityNo;
			string1  RecordType;
			string5  NonReadableText;
			string1  StatusCode;
			string8  DateOfFirstUseMT;
			string8  DateOfFirstUseAnywhere;
			string8  RenewalDate;
			string3  ClassCD;
			string35 DescriptionOfGoods;
			string35 MannerOfUse;
			string6  FolderLocation;
		end;
	end;
	
	export Layouts_Lookup := module
	    
		export Lookup_Common := record
		   string blob;
		end;
		
	    export Layout_bus_entity_type := record
		    string1   code;
			string100 desc;			
		end;
		
	    export Layout_rec_type := record
		    string1   code;
			string100 desc;
		end;
		
	    export Layout_activity_type := record
		    string3   code;
			string100 desc;
		end;
		
		export Layout_purpose_code := record
		    string3   code;
			string100 desc;
		end;

		export Layout_change_code := record
		    string3   code;
			string100 desc;
		end;
		
		export Layout_corp_type := record
		    string2   code;
			string100 desc;
		end;

		export Layout_owner_type := record
		    string2   code;
			string100 desc;
		end;

		export Layout_status_reason := record
		    string3   code;
			string100 desc;
		end;

		export Layout_trademark_class := record
		    string3   code;
			string100 desc;
		end;

	    export Layout_iso_state := record
			string2  code;
			string30 desc;
			string2  fips_code;
		end;		
	end;

	
	export Files_Raw_Input := module
	    // vendor file definition
		export VendorSource(string fileDate)     :=  dataset(Constants.cluster + 'in::corp2::'+fileDate+'::vendor_raw::MT',
													          Layouts_Raw_Input.Vendor_Raw,thor);
	end;
	
	// file Lookup tables definition
	export File_Lookups := module
	    
		export bus_entity_Type_code              := dataset(_dataset().foreign_prod + Constants.cluster[2..] + 'in::corp2::lookup::Bus_Entity_Type::MT',
														    Layouts_Lookup.Lookup_Common,CSV(SEPARATOR(['|']), QUOTE('"'), TERMINATOR(['\r\n', '\n'])));

		export record_type_code                  := dataset(_dataset().foreign_prod + Constants.cluster[2..] + 'in::corp2::lookup::Record_Type::MT',
														     Layouts_Lookup.Lookup_Common,CSV(SEPARATOR(['|']), QUOTE('"'), TERMINATOR(['\r\n', '\n'])));
		
		export activity_code                     := dataset(_dataset().foreign_prod + Constants.cluster[2..] + 'in::corp2::lookup::Activity_Type::MT',
														     Layouts_Lookup.Lookup_Common,CSV(SEPARATOR(['|']), QUOTE('"'), TERMINATOR(['\r\n', '\n'])));
		
		export bus_purpose_code                  := dataset(_dataset().foreign_prod + Constants.cluster[2..] + 'in::corp2::lookup::Bus_Purpose_Type::MT',
														     Layouts_Lookup.Lookup_Common,CSV(SEPARATOR(['|']), QUOTE('"'), TERMINATOR(['\r\n', '\n'])));
		
		export change_code                       := dataset(_dataset().foreign_prod + Constants.cluster[2..] + 'in::corp2::lookup::Change_Code::MT',
														     Layouts_Lookup.Lookup_Common,CSV(SEPARATOR(['|']), QUOTE('"'), TERMINATOR(['\r\n', '\n'])));
		
		export corp_type_code                    := dataset(_dataset().foreign_prod + Constants.cluster[2..] + 'in::corp2::lookup::Corp_Type::MT',
														     Layouts_Lookup.Lookup_Common,CSV(SEPARATOR(['|']), QUOTE('"'), TERMINATOR(['\r\n', '\n'])));
		
		export owner_type_code                   := dataset(_dataset().foreign_prod + Constants.cluster[2..] + 'in::corp2::lookup::Owner_Type::MT',
														     Layouts_Lookup.Lookup_Common,CSV(SEPARATOR(['|']), QUOTE('"'), TERMINATOR(['\r\n', '\n'])));
		
		export status_reason_code                := dataset(_dataset().foreign_prod + Constants.cluster[2..] + 'in::corp2::lookup::Status_Reason_Code::MT',
														     Layouts_Lookup.Lookup_Common,CSV(SEPARATOR(['|']), QUOTE('"'), TERMINATOR(['\r\n', '\n'])));

		export trademark_class_code              := dataset(_dataset().foreign_prod + Constants.cluster[2..] + 'in::corp2::lookup::Trademark_Class::MT',
														     Layouts_Lookup.Lookup_Common,CSV(SEPARATOR(['|']), QUOTE('"'), TERMINATOR(['\r\n', '\n'])));

		
		export iso_state_code                    := dataset(_dataset().foreign_prod + Constants.cluster[2..] + 'in::corp2::lookup::Iso_State::MT', Layouts_Lookup.Layout_iso_state, thor);
		

		
    end;

	
	//****************  Update process begins   *******************************************************
	export Update(string fileDate, string version, boolean pShouldSpray = _Dataset().bShouldSpray, boolean pOverwrite = false) := function
		
		// function that trim's leading and trailing white spaces and uppercases the given string. 
		trimUpper(string str) := function
		   return stringlib.StringToUpperCase(trim(str, left, right));
		end;
		
		// function to refomat the data given in mmddccyy to ccyymmdd
		formatDate(string8 instr) := function
		   string8 outStr := if (trim(instr,left,right) <> '',
		                         trim(instr,left,right)[5..8] + 
					             trim(instr,left,right)[1..2] + 
					             trim(instr,left,right)[3..4],'');
		   return outStr;
		end;
		
		in_file := ascii(Files_Raw_Input.VendorSource(filedate));
		
		//*************************** BUSINESS ***************************************************
		Layouts_Raw_Input.Bus_Rec trfRawToBusn(in_file l) := transform
		                                            //skip(trim(l.RecordType,left,right) != '1')
		   self.NonReadableText       := l.blob[1..5];
		   self.StatCode              := l.blob[6..6];
		   self.BusinessEntityCode    := l.blob[7..7];
		   self.BusinessEntityNum     := l.blob[8..13];
		   self.IncorporateDate       := l.blob[14..21];
		   self.TermofExistence       := l.blob[22..25];
		   self.ExpirationDate        := l.blob[26..33];
		   self.StatusCode            := l.blob[34..36];
		   self.StatusReasonCode      := l.blob[37..39];
		   self.FilingDate            := l.blob[40..47];
		   self.InactiveReasonCode    := l.blob[48..48];
		   self.InactiveDate          := l.blob[49..56];
		   self.ReviverReinstateDate  := l.blob[57..64];
		   self.CorporationType       := l.blob[65..66];
		   self.BusinessPurposeCD     := l.blob[67..69];
		   self.MontanaCodeStatute    := l.blob[70..78];
		   self.StateOfJurisdiction   := l.blob[79..80];
		   self.NoticeDate            := l.blob[81..88];
		   self.InvolDissolIntentDate := l.blob[89..96];
		   self.VolunDissolIntentDate := l.blob[97..104];
		   self.ARLastGenDate         := l.blob[105..112];
		   self.ARLastFiledDate       := l.blob[113..120];
		   self.SuspensionDate        := l.blob[121..128];
		   self.SuspensionIntentDate  := l.blob[129..136];
		   self.SuspensionDissolDate  := l.blob[137..145];		   
		   self                       := l;		   
		end;
		
		Busn_recs := project(in_file(trim(RecordType,left,right) = '1'), trfRawToBusn(left));
		//****************************************************************************************
	
        //*************************** BUSINESS NAME **********************************************
		Layouts_Raw_Input.Bus_Name_Rec trfRawToBusName(in_file l) := transform
		                                            //skip(trim(l.RecordType,left,right) != '2')
		   self.NonReadableText := l.blob[1..5];
		   self.StatusCode      := l.blob[6..6];
		   self.ReasonCode      := l.blob[7..7];
		   self.InactiveDate    := l.blob[8..15];
		   self.Filler          := l.blob[16..17];
		   self.BusinessName    := l.blob[18..161];		  
		   self                 := l;		   
		end;
		
		Bus_Name_recs := project(in_file(trim(RecordType,left,right) = '2'), trfRawToBusName(left));
		//******************************************************************************************
		
		//*************************** OFFICER/PARTNER **********************************************
		Layouts_Raw_Input.Off_Patner_Rec trfRawToOFCPT(in_file l) := transform
		                                            //skip(trim(l.RecordType,left,right) != '3')
		   self.NonReadableText   := l.blob[1..5];
		   self.StatusCode        := l.blob[6..6];
		   self.OfficerNmTypeCD   := l.blob[7..7];
		   self.OfficerFirstNm    := l.blob[8..19];
		   self.OfficerInitial    := l.blob[20..21];
		   self.OfficerLastNm     := l.blob[22..37];
		   self.OfficerStreetAddr := l.blob[38..67];
		   self.OfficerCity       := l.blob[68..89];
		   self.OfficerState      := l.blob[90..91];
		   self.OfficerZip        := l.blob[92..100];
		   self.OfficerCountry    := l.blob[101..130];
		   self.ManagerDissocDate := l.blob[131..138];
		   self                   := l;		   
		end;
		
		Officer_Cont_recs := project(in_file(trim(RecordType,left,right) = '3'), trfRawToOFCPT(left));
		//****************************************************************************************
		
		//*************************** SHARE ******************************************************
		Layouts_Raw_Input.Off_Share_Rec trfRawToShare(in_file l) := transform
		                                            //skip(trim(l.RecordType,left,right) != '4')
		   self.NonReadableText   := l.blob[1..5];
		   self.StatusCode        := l.blob[6..6];
		   self.AuthorizedNbr     := l.blob[7..14];
		   self.Class             := l.blob[15..15];
		   self.Series            := l.blob[16..30];
		   self.SharesIssued      := l.blob[31..38];
		   self.ParValue          := l.blob[39..39];
		   self.ParValueAmnt      := l.blob[40..48];		   
		   self                   := l;		   
		end;
		
		Share_Stock_recs := project(in_file(trim(RecordType,left,right) = '4'), trfRawToShare(left));
		//****************************************************************************************
		
        //*************************** RELATED BUSINESS *******************************************
		Layouts_Raw_Input.Rel_Bus_Rec trfRawToRelBus(in_file l) := transform
		                                            //skip(trim(l.RecordType,left,right) != '5')
		   self.NonReadableText   := l.blob[1..5];
		   self.StatusCode        := l.blob[6..6];
		   self.RelatedBusinessID := l.blob[7..13];
		   self.RelationshipType  := l.blob[14..14];
		   self.RegMgrDissocDt    := l.blob[15..22];
		   self.RegMgrAddrLine1   := l.blob[23..52];
		   self.RegMgrAddrLine2   := l.blob[53..82];
		   self.RegMgrCity        := l.blob[83..104];
		   self.RegMgrState       := l.blob[105..106];
		   self.RegMgrZip         := l.blob[107..115];
		   self.RegMgrCountry     := l.blob[116..145];		   
		   self                   := l;		   
		end;
		
		Rel_Bus_recs := project(in_file(trim(RecordType,left,right) = '5'), trfRawToRelBus(left));
		//****************************************************************************************
        
		//*************************** AGENT/OWNER ************************************************
		Layouts_Raw_Input.Agent_Own_Rec trfRawToAgent(in_file l) := transform
		                                            //skip(trim(l.RecordType,left,right) != '6')
		   self.NonReadableText  := l.blob[1..5];
		   self.StatusCode       := l.blob[6..6];
		   self.OwnerTypeCD      := l.blob[7..7];
		   self.RAName           := l.blob[8..42];
		   self.RAAddrLine1      := l.blob[43..72];
		   self.RAAddrLine2      := l.blob[73..102];
		   self.RACity           := l.blob[103..124];
		   self.RAState          := l.blob[125..126];
		   self.RAZip            := l.blob[127..135];		      
		   self                  := l;		   
		end;
		
		Agent_Own_recs := project(in_file(trim(RecordType,left,right) = '6'), trfRawToAgent(left));
		//****************************************************************************************
		
		//*************************** RELATED BUSINESS ABN ***************************************
		Layouts_Raw_Input.Rel_Bus_ABN_Rec trfRawToRelBusABN(in_file l) := transform
		                                            //skip(trim(l.RecordType,left,right) != '7')
		   self.NonReadableText  := l.blob[1..5];
		   self.StatusCode       := l.blob[6..6];
		   self.Counties         := l.blob[7..63];
		   self.DateFirstUse     := l.blob[64..71];
		   self.FolderLocation   := l.blob[72..78];
		   self.Purpose          := l.blob[79..113];		    
		   self                  := l;		   
		end;
		
		Rel_Bus_ABN_Recs := project(in_file(trim(RecordType,left,right) = '7'), trfRawToRelBusABN(left));
        //****************************************************************************************
		
		//*************************** RELATED BUSINESS FRGN **************************************
		Layouts_Raw_Input.Rel_Bus_FRGN_Rec trfRawToRelBusFRGN(in_file l) := transform
		                                            //skip(trim(l.RecordType,left,right) != '8')
		   self.NonReadableText           := l.blob[1..5];
		   self.StatusCode                := l.blob[6..6];
		   self.QualificationFilingDt     := l.blob[7..14];
		   self.PrincipleOfficeStreetAddr := l.blob[15..44];
		   self.PrincipleOfficeCity       := l.blob[45..66];
		   self.PrincipleOfficeSt         := l.blob[67..68];
		   self.PrincipleOfficeZip        := l.blob[69..77];
		   self.PrincipleOfficeCountry    := l.blob[78..97];
		   self.CountryofJurisdiction     := l.blob[98..127];
		   self.TotalReceipts             := l.blob[128..142];
		   self.MontanaReceipts           := l.blob[143..157];
		   self.TotalValue                := l.blob[158..172];
		   self.MontanaValue              := l.blob[173..187];
		   self.PercentageEmploymentMT    := l.blob[188..190];
		   self                           := l;		   
		end;
		
		Rel_Bus_FRGN_Recs := project(in_file(trim(RecordType,left,right) = '8'), trfRawToRelBusFRGN(left));
        //****************************************************************************************

        //*************************** RELATED BUSINESS TRADEMARK *********************************
		Layouts_Raw_Input.Rel_Bus_TM_Rec trfRawToRelBusTM(in_file l) := transform
		                                            //skip(trim(l.RecordType,left,right) != '9')
		   self.NonReadableText        := l.blob[1..5];
		   self.StatusCode             := l.blob[6..6];
		   self.DateOfFirstUseMT       := l.blob[7..14];
		   self.DateOfFirstUseAnywhere := l.blob[15..22];
		   self.RenewalDate            := l.blob[23..30];
		   self.ClassCD                := l.blob[31..33];
		   self.DescriptionOfGoods     := l.blob[34..68];
		   self.MannerOfUse            := l.blob[69..103];
		   self.FolderLocation         := l.blob[104..109];		   
		   self                        := l;		   
		end;
		
		Rel_Bus_TM_Recs := project(in_file(trim(RecordType,left,right) = '9'), trfRawToRelBusTM(left));
		//****************************************************************************************
		
		Layout_common_vendor := record
		    Layouts_Raw_Input.Bus_Rec;
			Layouts_Raw_Input.Bus_Name_Rec.BusinessName;
			Layouts_Raw_Input.Agent_Own_Rec.OwnerTypeCD;
			Layouts_Raw_Input.Agent_Own_Rec.RAName;
			Layouts_Raw_Input.Agent_Own_Rec.RAAddrLine1;
			Layouts_Raw_Input.Agent_Own_Rec.RAAddrLine2;
			Layouts_Raw_Input.Agent_Own_Rec.RACity;
			Layouts_Raw_Input.Agent_Own_Rec.RAState;
			Layouts_Raw_Input.Agent_Own_Rec.RAZip;
			Layouts_Raw_Input.Rel_Bus_ABN_Rec.Counties;
			Layouts_Raw_Input.Rel_Bus_ABN_Rec.Purpose;
			Layouts_Raw_Input.Rel_Bus_FRGN_Rec.QualificationFilingDt;
			Layouts_Raw_Input.Rel_Bus_FRGN_Rec.PrincipleOfficeStreetAddr;
			Layouts_Raw_Input.Rel_Bus_FRGN_Rec.PrincipleOfficeCity;
			Layouts_Raw_Input.Rel_Bus_FRGN_Rec.PrincipleOfficeSt;
			Layouts_Raw_Input.Rel_Bus_FRGN_Rec.PrincipleOfficeZip;
			Layouts_Raw_Input.Rel_Bus_FRGN_Rec.PrincipleOfficeCountry;
			Layouts_Raw_Input.Rel_Bus_FRGN_Rec.CountryofJurisdiction;
			Layouts_Raw_Input.Rel_Bus_TM_Rec.DateOfFirstUseMT;
			Layouts_Raw_Input.Rel_Bus_TM_Rec.ClassCD;
			Layouts_Raw_Input.Rel_Bus_TM_Rec.DescriptionOfGoods;
			Layouts_Raw_Input.Rel_Bus_TM_Rec.MannerOfUse;
		end;
		
		
		Layout_Common_vendor joinBusWBusName(Busn_recs l, Bus_Name_recs r) := transform
		    self.BusinessName := r.BusinessName;
		    self := l;
		    self := [];
		end;
		
		Busn_Busnm_recs := join(Busn_recs, Bus_Name_recs,
		                        trim(left.BusinessEntityID) = trim(right.BusinessEntityID) and
								trim(left.BusinessEntityNo) = trim(right.BusinessEntityNo),
		                        joinBusWBusName(left, right), left outer);
		
				
		Layout_Common_vendor joinBusBusNameWRA(Layout_Common_vendor l, Agent_Own_recs r) := transform
		    self.OwnerTypeCD   := r.OwnerTypeCD;
			self.RAName        := r.RAName;
			self.RAAddrLine1   := r.RAAddrLine1;
			self.RAAddrLine2   := r.RAAddrLine2;
			self.RACity        := r.RACity;
			self.RAState       := r.RAState;
			self.RAZip         := r.RAZip;
		    self               := l;
		    self               := [];
		end;
		
		Busn_Busnm_RA_recs := join(Busn_Busnm_recs, Agent_Own_recs(trim(BusinessEntityID) <> 'T'),
		                           trim(left.BusinessEntityID) = trim(right.BusinessEntityID) and
								   trim(left.BusinessEntityNo) = trim(right.BusinessEntityNo),
		                           joinBusBusNameWRA(left, right), left outer);
		

		Layout_Common_vendor joinBusBusNRaWABN(Layout_Common_vendor l, Rel_Bus_ABN_Recs r) := transform
		    self.Counties      := r.Counties;
			self.Purpose       := r.Purpose;
		    self               := l;
		    self               := [];
		end;
		
		Busn_Busnm_RA_ABN_recs := join(Busn_Busnm_RA_recs, Rel_Bus_ABN_Recs,
		                              trim(left.BusinessEntityID) = trim(right.BusinessEntityID) and
								      trim(left.BusinessEntityNo) = trim(right.BusinessEntityNo),
		                              joinBusBusNRaWABN(left, right), left outer);
		
		
		Layout_Common_vendor joinBusBusNRaAbnWFrgn(Layout_Common_vendor l, Rel_Bus_FRGN_Recs r) := transform
		    self.QualificationFilingDt     := r.QualificationFilingDt;
			self.PrincipleOfficeStreetAddr := r.PrincipleOfficeStreetAddr;
			self.PrincipleOfficeCity       := r.PrincipleOfficeCity;
			self.PrincipleOfficeSt         := r.PrincipleOfficeSt;
			self.PrincipleOfficeZip        := r.PrincipleOfficeZip;
			self.PrincipleOfficeCountry    := r.PrincipleOfficeCountry;
			self.CountryofJurisdiction     := r.CountryofJurisdiction;
		    self                           := l;
			self                           := [];
		end;
		
		Busn_Busnm_RA_ABN_FRGN_recs := join(Busn_Busnm_RA_ABN_recs, Rel_Bus_FRGN_Recs,
		                                    trim(left.BusinessEntityID) = trim(right.BusinessEntityID) and
								            trim(left.BusinessEntityNo) = trim(right.BusinessEntityNo),
		                                    joinBusBusNRaAbnWFrgn(left, right), left outer);		


		Layout_Common_vendor joinBusBusNRaAbnFrgnWTm(Layout_Common_vendor l, Rel_Bus_TM_Recs r) := transform
		    self.DateOfFirstUseMT   := r.DateOfFirstUseMT;
			self.ClassCD            := r.ClassCD;
			self.DescriptionOfGoods := r.DescriptionOfGoods;
			self.MannerOfUse        := r.MannerOfUse;
			self                    := l;
		    
		end;
		
		Busn_Busnm_RA_ABN_FRGN_TM_recs := join(Busn_Busnm_RA_ABN_FRGN_recs, Rel_Bus_TM_Recs,
		                                       trim(left.BusinessEntityID) = trim(right.BusinessEntityID) and
								               trim(left.BusinessEntityNo) = trim(right.BusinessEntityNo),
		                                       joinBusBusNRaAbnFrgnWTm(left, right), left outer);
		
		//Filtering out the Trademark records out of the Agent Owner file. These records will treated as new corp records.
		Fil_Agent_Own_TM_Recs := Agent_Own_recs(trim(BusinessEntityID) = 'T', trim(RecordType) = '6');
		
		Layout_common_vendor trfTMToCommon(Fil_Agent_Own_TM_Recs l) := transform
		   self := l;
		   self := [];
		end;
		
		TM_Records := project(Fil_Agent_Own_TM_Recs, trfTMToCommon(left));
		
		Combined_PreCorp_Recs := Busn_Busnm_RA_ABN_FRGN_TM_recs + TM_Records;
		
		Layout_Ven_Common_Cont := record
		   Layouts_Raw_Input.Off_Patner_Rec;
		   Layouts_Raw_Input.Bus_Name_Rec.BusinessName;
		end;
		
		ded_Busn_Busnm_RA_ABN_FRGN_TM_recs := dedup(sort(Busn_Busnm_RA_ABN_FRGN_TM_recs,BusinessEntityID, BusinessEntityNo),
		                                            BusinessEntityID,BusinessEntityNo);
		
		Layout_Ven_Common_Cont getBusNameforConts(Officer_Cont_recs l, Busn_Busnm_RA_ABN_FRGN_TM_recs r) := transform
		   self.BusinessName := r.BusinessName;
		   self := l;
		end;
		
		PreCont_recs := join(Officer_Cont_recs, ded_Busn_Busnm_RA_ABN_FRGN_TM_recs,
		                     trim(left.BusinessEntityID) = trim(right.BusinessEntityID) and
						     trim(left.BusinessEntityNo) = trim(right.BusinessEntityNo),
		                     getBusNameforConts(left, right), left outer
							);
		
		//**************************** Code Translations *****************************************
		Layout_Extended := record
		    Layout_common_vendor;
			string100 StatusReasonDesc := '';
			string50  BusinessEntityTypeDesc := '';
			string100 BusinessPurposeDesc := '';
			string100 CorporationDesc := '';
			string100 ClassDesc := '';
			string100 StateDesc := '';
		end;
		
		// translation of StatusReasonCode code.
		Layout_Extended  transReasonCd(Layout_Common_vendor l, File_Lookups.status_reason_code r) := transform
		   self.StatusReasonDesc := trim(r.blob[4..]);
		   self                  := l;		   
		end;
		
		T1 := join(Combined_PreCorp_Recs, File_Lookups.status_reason_code, 
		           trimUpper(left.StatusReasonCode) = trimUpper(right.blob[1..3]),
				   transReasonCd(left,right), left outer, lookup
				  );
		
		// translation of BusinessEntityID code.
		Layout_Extended  transBusEntityID(Layout_Extended l, File_Lookups.bus_entity_Type_code r) := transform
		   self.BusinessEntityTypeDesc := trim(r.blob[2..]);
		   self                        := l;		   
		end;
		
		T2 := join(T1, File_Lookups.bus_entity_Type_code, 
		           trimUpper(left.BusinessEntityID) = trimUpper(right.blob[1]),
				   transBusEntityID(left,right), left outer, lookup
				  );
		
		// translation of BusinessPurposeCD code.
		Layout_Extended  transBusPurposeCD(Layout_Extended l, File_Lookups.bus_purpose_code r) := transform
		   self.BusinessPurposeDesc := trim(r.blob[4..]);
		   self                     := l;		   
		end;
		
		T3 := join(T2, File_Lookups.bus_purpose_code, 
		           trimUpper(left.BusinessPurposeCD) = trimUpper(right.blob[1..3]),
				   transBusPurposeCD(left,right), left outer, lookup
				  );

		// translation of CorporationType code.
		Layout_Extended  transCorpType(Layout_Extended l, File_Lookups.corp_type_code r) := transform
		   self.CorporationDesc := trim(r.blob[3..]);
		   self                 := l;		   
		end;
		
		T4 := join(T3, File_Lookups.corp_type_code, 
		           trim(left.CorporationType,left,right) = right.blob[1..2],
				   transCorpType(left,right), left outer, lookup
				  );

		// translation of Trademark ClassCD code.
		Layout_Extended  transTMClass(Layout_Extended l, File_Lookups.trademark_class_code r) := transform
		   self.ClassDesc  := trim(r.blob[4..]);
		   self            := l;		   
		end;
		
		T5 := join(T4, File_Lookups.trademark_class_code, 
		           trimUpper(left.classCD) = trimUpper(right.blob[1..3]),
				   transTMClass(left,right), left outer, lookup
				  );

		// translation of StateCD code.
		Layout_Extended  transStateCd(Layout_Extended l, File_Lookups.iso_state_code r) := transform
		   self.StateDesc  := trim(r.desc);
		   self            := l;		   
		end;
		
		T6 := join(T5, File_Lookups.iso_state_code, 
		           trimUpper(left.StateOfJurisdiction) = trimUpper(right.code),
				   transStateCd(left,right), left outer, lookup
				  );
		
		//************************************** CORP ***********************************************
		
		Corp2.Layout_Corporate_Direct_Corp_In  trfCleanCorp(Layout_Extended l) := transform		
			boolean  isTMRec                    := if (trimUpper(l.BusinessEntityID) = 'T' and 
			                                           trim(l.RecordType) = '6', true, false);
			string73 tempname 					:= if(trimUpper(l.BusinessEntityID) in ['A','C','D','E','F','L'],
												      stringlib.StringToUpperCase(
			                                            if(trim(l.RAName,left,right) = '', 
			                                               '', Address.CleanPerson73(trim(l.RAName,left,right)))),
													  ''
												     );
			pname 								:= Address.CleanNameFields(tempName);			
			cname 								:= if(trimUpper(l.BusinessEntityID) in ['A','C','D','E','F','L'],
			                                           DataLib.companyclean(trimUpper(l.RAName)),'');
			keepPerson 							:= if(trimUpper(l.BusinessEntityID) in ['A','C','D','E','F','L'],
			                                           corp2.Rewrite_Common.IsPerson(trim(l.RAName)),false);
			keepBusiness 						:= if(trimUpper(l.BusinessEntityID) in ['A','C','D','E','F','L'],
												       corp2.Rewrite_Common.IsCompany(trim(l.RAName)),false);
			
			self.corp_ra_title1					:= if(keepPerson, pname.title, '');
			self.corp_ra_fname1 				:= if(keepPerson, pname.fname, '');
			self.corp_ra_mname1 				:= if(keepPerson, pname.mname, '');
			self.corp_ra_lname1 				:= if(keepPerson, pname.lname, '');
			self.corp_ra_name_suffix1 			:= if(keepPerson, pname.name_suffix, '');
			self.corp_ra_score1 				:= if(keepPerson, pname.name_score, '');
		
			self.corp_ra_cname1 				:= if(keepBusiness, cname[1..70],'');
			self.corp_ra_cname1_score 			:= if(keepBusiness, pname.name_score, '');
			
			string182 clean_address 			:= if(trim(l.PrincipleOfficeStreetAddr,left,right) +
													  trim(l.PrincipleOfficeCity,left,right)  +
													  trim(l.PrincipleOfficeSt,left,right) +
													  trim(l.PrincipleOfficeZip,left,right) <> '',
													  stringlib.StringToUpperCase(
													  Address.CleanAddress182(trim(l.PrincipleOfficeStreetAddr,left,right),
																			  trim(trim(l.PrincipleOfficeCity,left,right) + ', ' +
																				   trim(l.PrincipleOfficeSt,left,right) + ' ' +
																				   stringlib.stringfilter(l.PrincipleOfficeZip,'0123456789'),left,right)
																			    )),'');	
			
			cp_addr                             := Address.CleanAddressFieldsFips(clean_address);
			
			string182 clean_ra_address 			:= if(trim(l.RAAddrLine1,left,right) +
													  trim(l.RAAddrLine2,left,right) +
													  trim(l.RACity,left,right)  +
													  trim(l.RAState,left,right) +
													  trim(l.RAZip,left,right) <> '',
													  stringlib.StringToUpperCase(
													  Address.CleanAddress182(trim(trim(l.RAAddrLine1,left,right) + ' ' +
																				   trim(l.RAAddrLine2,left,right),left,right),
																			  trim(trim(l.RACity,left,right) + ', ' +
																				   trim(l.RAState,left,right) + ' ' +
																				   stringlib.stringfilter(l.RAZip,'0123456789'),left,right)
																			 )),'');
																			   
			ra_addr                             := Address.CleanAddressFieldsFips(clean_ra_address);
			
			self.corp_addr1_prim_range    		:= if (isTMRec, ra_addr.prim_range, cp_addr.prim_range);
			self.corp_addr1_predir 	      		:= if (isTMRec, ra_addr.predir, cp_addr.predir);
			self.corp_addr1_prim_name 	  		:= if (isTMRec, ra_addr.prim_name, cp_addr.prim_name);
			self.corp_addr1_addr_suffix   		:= if (isTMRec, ra_addr.addr_suffix, cp_addr.addr_suffix);
			self.corp_addr1_postdir 	    	:= if (isTMRec, ra_addr.postdir, cp_addr.postdir);
			self.corp_addr1_unit_desig 	  		:= if (isTMRec, ra_addr.unit_desig, cp_addr.unit_desig);
			self.corp_addr1_sec_range 	  		:= if (isTMRec, ra_addr.sec_range, cp_addr.sec_range);
			self.corp_addr1_p_city_name	  		:= if (isTMRec, ra_addr.p_city_name, cp_addr.p_city_name);
			self.corp_addr1_v_city_name	  		:= if (isTMRec, ra_addr.v_city_name, cp_addr.v_city_name);
			self.corp_addr1_state 			    := if (isTMRec, ra_addr.st, cp_addr.st);
			self.corp_addr1_zip5 		      	:= if (isTMRec, ra_addr.zip, cp_addr.zip);
			self.corp_addr1_zip4 		      	:= if (isTMRec, ra_addr.zip4, cp_addr.zip4);
			self.corp_addr1_cart 		      	:= if (isTMRec, ra_addr.cart, cp_addr.cart);
			self.corp_addr1_cr_sort_sz 	 		:= if (isTMRec, ra_addr.cr_sort_sz, cp_addr.cr_sort_sz);
			self.corp_addr1_lot 		    	:= if (isTMRec, ra_addr.lot, cp_addr.lot);
			self.corp_addr1_lot_order 	  		:= if (isTMRec, ra_addr.lot_order,cp_addr.lot_order);
			self.corp_addr1_dpbc 		    	:= if (isTMRec, ra_addr.dbpc, cp_addr.dbpc);
			self.corp_addr1_chk_digit 	  		:= if (isTMRec, ra_addr.chk_digit, cp_addr.chk_digit);
			self.corp_addr1_rec_type			:= if (isTMRec, ra_addr.rec_type, cp_addr.rec_type);
			self.corp_addr1_ace_fips_st	  		:= if (isTMRec, ra_addr.fips_state, cp_addr.fips_state);
			self.corp_addr1_county 	  			:= if (isTMRec, ra_addr.fips_county, cp_addr.fips_county);
			self.corp_addr1_geo_lat 	    	:= if (isTMRec, ra_addr.geo_lat, cp_addr.geo_lat);
			self.corp_addr1_geo_long 	    	:= if (isTMRec, ra_addr.geo_long,cp_addr.geo_long);
			self.corp_addr1_msa 		    	:= if (isTMRec, ra_addr.msa, cp_addr.msa);
			self.corp_addr1_geo_blk				:= if (isTMRec, ra_addr.geo_blk, cp_addr.geo_blk);
			self.corp_addr1_geo_match 	  		:= if (isTMRec, ra_addr.geo_match, cp_addr.geo_match);
			self.corp_addr1_err_stat 	    	:= if (isTMRec, ra_addr.err_stat, cp_addr.err_stat);
																				
			self.corp_ra_prim_range    			:= if (isTMRec, '', ra_addr.prim_range);
			self.corp_ra_predir 	      		:= if (isTMRec, '', ra_addr.predir);
			self.corp_ra_prim_name 	  			:= if (isTMRec, '', ra_addr.prim_name);
			self.corp_ra_addr_suffix   			:= if (isTMRec, '', ra_addr.addr_suffix);
			self.corp_ra_postdir 	    		:= if (isTMRec, '', ra_addr.postdir);
			self.corp_ra_unit_desig 	  		:= if (isTMRec, '', ra_addr.unit_desig);
			self.corp_ra_sec_range 	  			:= if (isTMRec, '', ra_addr.sec_range);
			self.corp_ra_p_city_name	  		:= if (isTMRec, '', ra_addr.p_city_name);
			self.corp_ra_v_city_name	  		:= if (isTMRec, '', ra_addr.v_city_name);
			self.corp_ra_state 			      	:= if (isTMRec, '', ra_addr.st);
			self.corp_ra_zip5 		      		:= if (isTMRec, '', ra_addr.zip);
			self.corp_ra_zip4 		      		:= if (isTMRec, '', ra_addr.zip4);
			self.corp_ra_cart 		      		:= if (isTMRec, '', ra_addr.cart);
			self.corp_ra_cr_sort_sz 	 		:= if (isTMRec, '', ra_addr.cr_sort_sz);
			self.corp_ra_lot 		      		:= if (isTMRec, '', ra_addr.lot);
			self.corp_ra_lot_order 	  			:= if (isTMRec, '', ra_addr.lot_order);
			self.corp_ra_dpbc 		      		:= if (isTMRec, '', ra_addr.dbpc);
			self.corp_ra_chk_digit 	  			:= if (isTMRec, '', ra_addr.chk_digit);
			self.corp_ra_rec_type		  		:= if (isTMRec, '', ra_addr.rec_type);
			self.corp_ra_ace_fips_st	  		:= if (isTMRec, '', ra_addr.fips_state);
			self.corp_ra_county 	  			:= if (isTMRec, '', ra_addr.fips_county);
			self.corp_ra_geo_lat 	    		:= if (isTMRec, '', ra_addr.geo_lat);
			self.corp_ra_geo_long 	    		:= if (isTMRec, '', ra_addr.geo_long);
			self.corp_ra_msa 		      		:= if (isTMRec, '', ra_addr.msa);
			self.corp_ra_geo_blk				:= if (isTMRec, '', ra_addr.geo_blk);
			self.corp_ra_geo_match 	  			:= if (isTMRec, '', ra_addr.geo_match);
			self.corp_ra_err_stat 	    		:= if (isTMRec, '', ra_addr.err_stat);
			
			self.dt_first_seen					:= fileDate;
			self.dt_last_seen					:= fileDate;
			self.dt_vendor_first_reported		:= fileDate;
			self.dt_vendor_last_reported		:= fileDate;
			self.corp_ra_dt_first_seen			:= fileDate;
			self.corp_ra_dt_last_seen			:= fileDate;
			
			self.corp_key						:= '30-' + trimUpper(l.BusinessEntityID) + trimUpper(l.BusinessEntityNo);
			self.corp_vendor					:= '30';
			self.corp_state_origin				:= 'MT';
			self.corp_process_date				:= fileDate;
			self.corp_orig_sos_charter_nbr		:= trimUpper(l.BusinessEntityID) + trimUpper(l.BusinessEntityNo);
			self.corp_src_type					:= 'SOS';
									
			self.corp_address1_type_cd          := if (isTMRec,
			                                           if (trim(clean_ra_address) <> '', 'B', ''),
			                                           if (trim(clean_address) <> '', 'B', '')
													  );
													  
			self.corp_address1_type_desc        := if (isTMRec,
			                                           if (trim(clean_ra_address) <> '', 'BUSINESS', ''),
			                                           if (trim(clean_address) <> '', 'BUSINESS', '')
													  );
													  
			self.corp_address1_line1            := if (isTMRec,
			                                           if (trim(l.RAAddrLine1) <> '',trimUpper(l.RAAddrLine1),''),
			                                           if (trim(l.PrincipleOfficeStreetAddr) <> '',trimUpper(l.PrincipleOfficeStreetAddr),'')
												      );
													  
			self.corp_address1_line2            := if (isTMRec,
			                                           if (trim(l.RAAddrLine2) <> '',trimUpper(l.RAAddrLine2),''),
													   '');
													   
			self.corp_address1_line3            := if (isTMRec,
			                                           if (trim(l.RACity) <> '',trimUpper(l.RACity),''),
			                                           if (trim(l.PrincipleOfficeCity) <> '',trimUpper(l.PrincipleOfficeCity),'')
													  );
													  
			self.corp_address1_line4            := if (isTMRec,
			                                           if (trim(l.RAState) <> '',trimUpper(l.RAState),''),
			                                           if (trim(l.PrincipleOfficeSt) <> '',trimUpper(l.PrincipleOfficeSt),'')
													  );
													  
			self.corp_address1_line5            := if (isTMRec,
			                                           stringlib.stringfilter(l.RAZip, '0123456789'),
			                                           stringlib.stringfilter(l.PrincipleOfficeZip, '0123456789')
													  );
													  
			self.corp_address1_line6            := if (isTMRec,'',
			                                           if (trimUpper(l.PrincipleOfficeCountry) in ['US','USA','UNITED STATES'],
			                                               '',trimUpper(l.PrincipleOfficeCountry))
													  );
			
			self.corp_ra_name                   := if (trimUpper(l.BusinessEntityID) in ['A','C','D','E','F','L'],
			                                           stringlib.StringCleanSpaces(trimUpper(l.RAName)),'');
			
			self.corp_ra_address_type_cd        := '';
			
			self.corp_ra_address_type_desc      := if (trimUpper(l.BusinessEntityID) in ['A','C','D','E','F','L'] and
			                                           trim(clean_ra_address) <> '','REGISTERED OFFICE','');
													   
			self.corp_ra_address_line1          := if (trimUpper(l.BusinessEntityID) in ['A','C','D','E','F','L'],
			                                           trimUpper(l.RAAddrLine1),'');
													   
			self.corp_ra_address_line2          := if (trimUpper(l.BusinessEntityID) in ['A','C','D','E','F','L'],
			                                           trimUpper(l.RAAddrLine2),'');
													   
			self.corp_ra_address_line3          := if (trimUpper(l.BusinessEntityID) in ['A','C','D','E','F','L'],
			                                           trimUpper(l.RACity),'');
													   
			self.corp_ra_address_line4          := if (trimUpper(l.BusinessEntityID) in ['A','C','D','E','F','L'],
			                                           trimUpper(l.RAState),'');
													   
			self.corp_ra_address_line5          := if (trimUpper(l.BusinessEntityID) in ['A','C','D','E','F','L'],
			                                           stringlib.stringfilter(l.RAZip, '0123456789'),'');
			
			self.corp_legal_name                := if (isTMRec,
			                                           stringlib.StringCleanSpaces(trimUpper(l.RAName)),
													   trimUpper(l.BusinessName)
													  );
													  
			self.corp_ln_name_type_cd           := if (isTMRec, '01',
			                                           map(trimUpper(l.BusinessEntityID) = 'A' => '06',
														   trimUpper(l.BusinessEntityID) = 'C' => '01',
														   trimUpper(l.BusinessEntityID) = 'D' => '01',
														   trimUpper(l.BusinessEntityID) = 'E' => '01',
														   trimUpper(l.BusinessEntityID) = 'F' => '01',
														   trimUpper(l.BusinessEntityID) = 'L' => '01',
														   trimUpper(l.BusinessEntityID) = 'P' => '01',
														   trimUpper(l.BusinessEntityID) = 'T' => '04',
														   ''
														  )
													  );
													  
			self.corp_ln_name_type_desc         := map (self.corp_ln_name_type_cd = '01' => 'LEGAL',
														self.corp_ln_name_type_cd = '04' => 'TRADEMARK',
														self.corp_ln_name_type_cd = '06' => 'ASSUMED',														
														''
													   );

			self.corp_status_cd					:= trimUpper(l.StatusCode);
			
			self.corp_status_desc				:= map (self.corp_status_cd = 'ACT' => 'ACTIVE',
													    self.corp_status_cd = 'CAN' => 'CANCELLED',
													    ''
													   );
													  
			self.corp_status_comment            := if (trimUpper(l.StatusReasonCode) in ['','GDS'], 
			                                           '', trimUpper(l.StatusReasonDesc));
													   
			self.corp_standing                  := if (trimUpper(l.StatusReasonCode) = 'GDS', 'Y', '');
			
			self.corp_orig_org_structure_cd     := if (isTMRec, '',trimUpper(l.BusinessEntityID));
			
			self.corp_orig_org_structure_desc   := if (isTMRec, '',trimUpper(l.BusinessEntityTypeDesc));
			
			self.corp_entity_desc               := if (trimUpper(l.BusinessEntityID) = 'T',
			                                          if (trim(l.DescriptionOfGoods,left,right) <> '', 
													      'DESCRIPTION OF GOODS: ' + trimUpper(l.DescriptionOfGoods), '') +
													  if (trim(l.MannerOfUse,left,right) <> '',
													       if (trim(l.DescriptionOfGoods,left,right) <> '',
													           '; MANNER OF USE: ' + trimUpper(l.MannerOfUse),
													  	       'MANNER OF USE: ' + trimUpper(l.MannerOfUse)
														       ),
														   ''),
													   if (trim(l.BusinessPurposeCD,left,right) <> '', 
														   trimUpper(l.BusinessPurposeDesc), '')
													  );

            self.corp_orig_bus_type_cd          := if (trimUpper(l.BusinessEntityID) = 'T', 
			                                           if (trimUpper(l.ClassCD) in ['','00'],'',trimUpper(l.ClassCD)),
			                                           if (trimUpper(l.CorporationType) in ['','00'],'',trimUpper(l.CorporationType))
													  );
			
			self.corp_orig_bus_type_desc        := if (trimUpper(l.BusinessEntityID) = 'T',
			                                           if (trim(l.classCD,left,right) <> '', trimUpper(l.ClassDesc),''),
			                                           if (trim(l.CorporationDesc) <> '',
													       if (trim(l.Purpose) <> '', trimUpper(l.CorporationDesc) +'; ' + trimUpper(l.Purpose),
														       trimUpper(l.CorporationDesc)),
														   if (trim(l.Purpose) <> '', trimUpper(l.Purpose),'')
														  )
													  );			
			
			self.corp_inc_state                 := if (trimUpper(l.StateOfJurisdiction) = self.corp_state_origin, 
													   trimUpper(l.StateOfJurisdiction), '');
			/*
			tempIncorporateDate                 := if (stringlib.stringfilter(l.IncorporateDate, '0123456789') <> '',
			                                           trim(l.IncorporateDate,left,right)[5..8] + 
													   trim(l.IncorporateDate,left,right)[1..2] + 
													   trim(l.IncorporateDate,left,right)[3..4],'');
			*/
			self.corp_inc_date                  := if (trimUpper(l.StateOfJurisdiction) = self.corp_state_origin, 
													   if(_validate.date.fIsValid(formatDate(l.IncorporateDate)),
													      formatDate(l.IncorporateDate),''),
													  '');
			
			self.corp_forgn_date                := if (trimUpper(l.StateOfJurisdiction) <> self.corp_state_origin,
			                                           if(_validate.date.fIsValid(formatDate(l.IncorporateDate)),
													      formatDate(l.IncorporateDate), ''),
													  '');
													   
			self.corp_forgn_state_cd            := if (trimUpper(l.StateOfJurisdiction) not in ['MT','US','OC',''],
			                                           trimUpper(l.StateOfJurisdiction), '');
			
			self.corp_forgn_state_desc          := if (self.corp_forgn_state_cd <> '', trimUpper(l.stateDesc), trimUpper(l.CountryofJurisdiction));			
			
			self.corp_filing_date               := if (trim(l.QualificationFilingDt) <> '',
			                                           if(_validate.date.fIsValid(formatDate(l.QualificationFilingDt)) and
													      _validate.date.fIsValid(formatDate(l.QualificationFilingDt),_validate.date.rules.DateInPast),
													      formatDate(l.QualificationFilingDt), ''),
			                                           if(_validate.date.fIsValid(stringlib.stringfilter(l.FilingDate,'0123456789')) and
			                                              _validate.date.fIsValid(stringlib.stringfilter(l.FilingDate,'0123456789'),_validate.date.rules.DateInPast),
			                                              stringlib.stringfilter(l.FilingDate,'0123456789'),'')			                                         
													  );
													   
			self.corp_term_exist_exp            := if (stringlib.stringfilter(l.ExpirationDate, '0123456789') <> '', 
			                                           if(_validate.date.fIsValid(formatDate(l.ExpirationDate)),
													      formatDate(l.ExpirationDate),''),'');
			
			self.corp_term_exist_cd             := if (trimUpper(l.TermofExistence) = 'PERP', 'P',
			                                           if(self.corp_term_exist_exp <> '', 'D',''));
			
			self.corp_term_exist_desc           := map(self.corp_term_exist_cd = 'D' => 'EXPIRATION DATE',
			                                           self.corp_term_exist_cd = 'P' => 'PERPETUAL',
													   ''
													  );		
			
			addl_info1                          := if ((integer)stringlib.stringfilter(l.InactiveDate,'0123456789') > 0, 
			                                           if(_validate.date.fIsValid(formatDate(l.InactiveDate)), 
			                                              'Inactive Date: ' + formatDate(l.InactiveDate), ''),
													   ''
													  );			

			addl_info2                          := if ((integer)stringlib.stringfilter(l.ReviverReinstateDate,'0123456789') > 0, 
												       if (addl_info1 <> '', 
													       if(_validate.date.fIsValid(formatDate(l.ReviverReinstateDate)),
														      '; REINSTATE DATE: ' + formatDate(l.ReviverReinstateDate), ''),
														   if(_validate.date.fIsValid(formatDate(l.ReviverReinstateDate)),  
													          'REINSTATE DATE: ' + formatDate(l.ReviverReinstateDate), '') 
														  ),
													  '');

			addl_info3                          := if ((integer)stringlib.stringfilter(l.InvolDissolIntentDate,'0123456789') > 0, 
												       if (addl_info1 <> '' or addl_info2 <> '', 
													       if(_validate.date.fIsValid(formatDate(l.InvolDissolIntentDate)),
														      '; INVOLUNTARY INTENT TO DISSOLVE DATE: ' + formatDate(l.InvolDissolIntentDate), ''),
														   if(_validate.date.fIsValid(formatDate(l.InvolDissolIntentDate)),  
													          'INVOLUNTARY INTENT TO DISSOLVE DATE: ' + formatDate(l.InvolDissolIntentDate), '') 
														  ),
													  '');

			addl_info4                          := if ((integer)stringlib.stringfilter(l.VolunDissolIntentDate,'0123456789') > 0, 
												       if (addl_info1 <> '' or addl_info2 <> '' or addl_info3 <> '', 
													       if(_validate.date.fIsValid(formatDate(l.VolunDissolIntentDate)),
														      '; VOLUNTARY INTENT TO DISSOLVE DATE: ' + formatDate(l.VolunDissolIntentDate), ''),
														   if(_validate.date.fIsValid(formatDate(l.VolunDissolIntentDate)),  
													          'VOLUNTARY INTENT TO DISSOLVE DATE: ' + formatDate(l.VolunDissolIntentDate), '')
														   ),
													  '');

			addl_info5                          := if ((integer)stringlib.stringfilter(l.SuspensionDate,'0123456789') > 0, 
												       if (addl_info1 <> '' or addl_info2 <> '' or addl_info3 <> '' or addl_info4 <> '', 
													       if(_validate.date.fIsValid(formatDate(l.SuspensionDate)),
														      '; SUSPENSION DATE: ' + formatDate(l.SuspensionDate), ''),
														   if(_validate.date.fIsValid(formatDate(l.SuspensionDate)),  
													          'SUSPENSION DATE: ' + formatDate(l.SuspensionDate), '') 
														  ),
													  '');

			addl_info6                          := if ((integer)stringlib.stringfilter(l.SuspensionIntentDate,'0123456789') > 0, 
												       if (addl_info1 <> '' or addl_info2 <> '' or addl_info3 <> '' or 
													       addl_info4 <> '' or addl_info5 <> '',
													       if(_validate.date.fIsValid(formatDate(l.SuspensionIntentDate)),
														      '; SUSPENSION INTENTION DATE: ' + formatDate(l.SuspensionIntentDate), ''),
														   if(_validate.date.fIsValid(formatDate(l.SuspensionIntentDate)),  
													          'SUSPENSION INTENTION DATE: ' + formatDate(l.SuspensionIntentDate), '') 
														  ),
													  '');

			addl_info7                          := if ((integer)stringlib.stringfilter(l.SuspensionDissolDate,'0123456789') > 0, 
												       if (addl_info1 <> '' or addl_info2 <> '' or addl_info3 <> '' or 
													       addl_info4 <> '' or addl_info5 <> '' or addl_info6 <> '',
													       if(_validate.date.fIsValid(formatDate(l.SuspensionDissolDate)),
														      '; SUSPENSION DISSOLVE DATE: ' + formatDate(l.SuspensionDissolDate), ''),
														   if(_validate.date.fIsValid(formatDate(l.SuspensionDissolDate)),  
													          'SUSPENSION/DISSOLVE DATE: ' + formatDate(l.SuspensionDissolDate), '') 
														  ),
													  '');
														   
			addl_info8                          := if ((integer)stringlib.stringfilter(l.DateOfFirstUseMT,'0123456789') > 0, 
												       if (addl_info1 <> '' or addl_info2 <> '' or addl_info3 <> '' or 
													       addl_info4 <> '' or addl_info5 <> '' or addl_info6 <> '' or
														   addl_info7 <> '',
													       if(_validate.date.fIsValid(formatDate(l.DateOfFirstUseMT)),
														      '; DATE TM FIRST USED: ' + formatDate(l.DateOfFirstUseMT), ''),
														   if(_validate.date.fIsValid(formatDate(l.DateOfFirstUseMT)),  
													          'DATE TM FIRST USED: ' + formatDate(l.DateOfFirstUseMT), '') 
														  ),
													  '');
			
		
			self.corp_addl_info                 :=  addl_info1 +
													addl_info2 +
													addl_info3 +
													addl_info4 +
												    addl_info5 +
													addl_info6 +
													addl_info7 +
													addl_info8;
													

			//self.corp_ra_addl_info              := if (trimUpper(l.IsAgentResigned) = 'Y', 'RESIGNED', '');
			
			self								:= l;
			self 								:= [];
		end;
		
		MapCleanCorp := project(T6, trfCleanCorp(left));
		//************************************** End ***********************************************
		
		
		//************************************** Cont **********************************************
		
		junk_cont_name := ['WITHOUT','OPERATES','VACANT','OPERATES WITHOUT','NONE STATED','ABBREVIATED LIST','*','NONE LISTED' ];
		
	
		
		Corp2.Layout_Corporate_Direct_Cont_In trfCont(Layout_Ven_Common_Cont l) := transform,
														skip(trim(l.OfficerNmTypeCD,left,right) in ['1','2','3','4','5','6','7'] or
														     trimUpper(l.OfficerFirstNm) in junk_cont_name or
														     trimUpper(l.OfficerLastNm)  in junk_cont_name
															)													     
																			 
			string73 tempname 				:= if(l.OfficerFirstNm + l.OfficerLastNm = '', '', 
			                                                If(trimUpper(l.BusinessEntityID) in ['A','L','P','T'],
															   Address.CleanPersonFML73(stringlib.StringCleanSpaces(trimUpper(l.OfficerFirstNm + l.OfficerInitial + l.OfficerLastNm))),
															   Address.CleanPersonFML73(stringlib.StringCleanSpaces(trimUpper(l.OfficerFirstNm  + ' ' +l.OfficerInitial+ ' ' +l.OfficerLastNm)))
															   ));
			string182 clean_address 		:= stringlib.StringToUpperCase(
			                                     if(trim(l.OfficerStreetAddr,left,right) +
												    trim(l.OfficerCity,left,right) +
													trim(l.OfficerState,left,right) +
													trim(l.OfficerZip,left,right) <> '',
												   Address.CleanAddress182(trim(l.OfficerStreetAddr,left,right),
																		   trim(trim(l.OfficerCity,left,right) + ', ' +
																				trim(l.OfficerState,left,right) + ' ' +
																				stringlib.stringfilter(l.OfficerZip,'0123456789'),
																				left,right
																				)
																		   ),''));	
			caddr                           := Address.CleanAddressFieldsFips(clean_address);
			
	
			
			self.cont_prim_range            := caddr.prim_range;
			self.cont_predir                := caddr.predir;
			self.cont_prim_name             := caddr.prim_name;
			self.cont_addr_suffix           := caddr.addr_suffix;
			self.cont_postdir               := caddr.postdir;
			self.cont_unit_desig            := caddr.unit_desig;
			self.cont_sec_range             := caddr.sec_range;
			self.cont_p_city_name           := caddr.p_city_name;
			self.cont_v_city_name           := caddr.v_city_name;
			self.cont_state                 := caddr.st;
			self.cont_zip5                  := caddr.zip;
			self.cont_zip4                  := caddr.zip4;
			self.cont_cart                  := caddr.cart;
			self.cont_cr_sort_sz            := caddr.cr_sort_sz;
			self.cont_lot                   := caddr.lot;
			self.cont_lot_order             := caddr.lot_order;
			self.cont_dpbc                  := caddr.dbpc;
			self.cont_chk_digit             := caddr.chk_digit;
			self.cont_rec_type              := caddr.rec_type;
			self.cont_ace_fips_st           := caddr.fips_state;
			self.cont_county                := caddr.fips_county;
			self.cont_geo_lat               := caddr.geo_lat;
			self.cont_geo_long              := caddr.geo_long;
			self.cont_msa                   := caddr.msa;
			self.cont_geo_blk               := caddr.geo_blk;
			self.cont_geo_match             := caddr.geo_match;
			self.cont_err_stat              := caddr.err_stat;
			
			self.corp_key					:= '30-' + trimUpper(l.BusinessEntityID) + trimUpper(l.BusinessEntityNo);
			self.corp_vendor				:= '30';		
			self.corp_state_origin			:= 'MT';
			self.corp_process_date			:= fileDate;
			self.dt_first_seen				:= fileDate;
			self.dt_last_seen				:= fileDate;

			self.corp_orig_sos_charter_nbr	:= trimUpper(l.BusinessEntityID) + trimUpper(l.BusinessEntityNo);
			self.corp_legal_name 			:= trimUpper(l.BusinessName);
			
			self.cont_name         	 	    := stringlib.StringCleanSpaces(
			                                    if(l.OfficerFirstNm +l.OfficerLastNm= '', '', 
			                                                  If(trimUpper(l.BusinessEntityID) in ['A','L','P','T'], trimUpper(l.OfficerFirstNm + l.OfficerInitial + l.OfficerLastNm),
																 trimUpper(l.OfficerFirstNm + ' ' + l.OfficerInitial + ' ' + l.OfficerLastNm))));
			cont_name         	 	        := stringlib.StringCleanSpaces(
			                                    if(l.OfficerFirstNm +l.OfficerLastNm= '', '', 
			                                                  If(trimUpper(l.BusinessEntityID) in ['A','L','P','T'], trimUpper(l.OfficerFirstNm + l.OfficerInitial + l.OfficerLastNm),
																 trimUpper(l.OfficerFirstNm + ' ' + l.OfficerInitial + ' ' + l.OfficerLastNm))));													 
			pname 							:= Address.CleanNameFields(tempName);
			keepPerson 						:= Corp2.Rewrite_Common.IsPerson(cont_name);
			keepBusiness 					:= Corp2.Rewrite_Common.IsCompany(cont_name);
			
			self.cont_title1				:= if(keepPerson, pname.title, '');
			self.cont_fname1 				:= if(keepPerson, pname.fname, '');
			self.cont_mname1 				:= if(keepPerson, pname.mname, '');
			self.cont_lname1 				:= if(keepPerson, pname.lname, '');
			self.cont_name_suffix1 			:= if(keepPerson, pname.name_suffix,'');
			self.cont_score1 				:= if(keepPerson, pname.name_score, '');
		
			self.cont_cname1 				:= if(keepBusiness, cont_name,'');
			self.cont_cname1_score 			:= if(keepBusiness, pname.name_score,'');												 
											   
			self.cont_type_cd  		        := if (self.cont_name <> '',
			                                       map(trimUpper(l.OfficerNmTypeCD) = 'A' => 'M',
												       trimUpper(l.OfficerNmTypeCD) = 'D' => 'O',
													   trimUpper(l.OfficerNmTypeCD) = 'G' => 'M',
													   trimUpper(l.OfficerNmTypeCD) = 'L' => 'M',
													   trimUpper(l.OfficerNmTypeCD) = 'P' => 'O',
													   trimUpper(l.OfficerNmTypeCD) = 'Q' => 'O',
													   trimUpper(l.OfficerNmTypeCD) = 'S' => 'O',
													   trimUpper(l.OfficerNmTypeCD) = 'T' => 'O',
													   trimUpper(l.OfficerNmTypeCD) = 'U' => 'O',
												       ''
												      ),
												  '');
			self.cont_type_desc  		    := map(self.cont_type_cd = 'M' => 'MEMBERS/MANAGER/PARTNER',
			                                       self.cont_type_cd = 'O' => 'OFFICER',
												   ''
												  );
			self.cont_title1_desc		    := if (self.cont_name <> '',
			                                       map(trimUpper(l.OfficerNmTypeCD) = 'D' => 'DIRECTOR',
													   trimUpper(l.OfficerNmTypeCD) = 'G' => 'GENERAL PARTNER',
													   trimUpper(l.OfficerNmTypeCD) = 'L' => 'LIMITED PARTNER',
													   trimUpper(l.OfficerNmTypeCD) = 'P' => 'PRESIDENT',
													   trimUpper(l.OfficerNmTypeCD) = 'Q' => 'VICE PRESIDENT',
													   trimUpper(l.OfficerNmTypeCD) = 'S' => 'SECRETARY',
													   trimUpper(l.OfficerNmTypeCD) = 'T' => 'TREASURER',
													   trimUpper(l.OfficerNmTypeCD) = 'U' => 'OTHER',
												       ''
												      ),
												  '');
			
			self.cont_address_line1         := if (trim(l.OfficerStreetAddr) in ['','*'], '', trimUpper(l.OfficerStreetAddr));
			self.cont_address_line2         := if (trim(l.OfficerCity) in ['','*'], '', trimUpper(l.OfficerCity));
			self.cont_address_line3         := if (trim(l.OfficerState) in ['','*'], '', trimUpper(l.OfficerState));
			self.cont_address_line4         := stringlib.stringfilter(l.OfficerZip, '0123456789');
			self.cont_address_line5         := if (trimUpper(l.OfficerCountry) in ['*','US','USA','UNITED STATES'],
			                                       '', trimUpper(l.OfficerCountry));
			
			self.cont_address_type_cd       := if (trim(clean_address) <> '', 'T', '');
			self.cont_address_type_desc     := if (trim(clean_address) <> '', 'CONTACT', '');
			
			tempMangerDisscDate             := stringlib.stringfilter(l.ManagerDissocDate, '0123456789');
			
			self.cont_addl_info             := if ((integer)tempMangerDisscDate <> 0, 
			                                        if(_validate.date.fIsValid(tempMangerDisscDate),
													   'DISSOCIATION DATE: '+ (tempMangerDisscDate),''),'');

			self                            := l;
			self							:= [];
		end;
		
		MapCont := project(PreCont_recs((integer)trim(BusinessEntityNo) <> 0),
		                   trfCont(left));	
		//************************************** End ************************************************

		
		//************************************** STOCK **********************************************
		Corp2.Layout_Corporate_Direct_Stock_In trfStock(Layouts_Raw_Input.Off_Share_Rec l) := transform

			self.corp_key					:= '30-' + trimUpper(l.BusinessEntityID) + trimUpper(l.BusinessEntityNo);
			self.corp_vendor				:= '30';		
			self.corp_state_origin			:= 'MT';
			self.corp_process_date			:= fileDate;
			self.corp_sos_charter_nbr		:= trimUpper(l.BusinessEntityID) + trimUpper(l.BusinessEntityNo);
			
			self.stock_class         		:= map(trimUpper(l.Class) = 'C' => 'COMMON',
                                                   trimUpper(l.Class) = 'O' => 'OTHER',
												   trimUpper(l.Class) = 'P' => 'PREFERRED',
												   ''
												  );
			self.stock_Authorized_Nbr  		:= if ((integer)trim(l.AuthorizedNbr) <> 0, (string)(integer)trim(l.AuthorizedNbr), '');
			
			self.stock_shares_issued		:= if ((integer)trim(l.SharesIssued) <> 0, 
			                                       (string)(integer)trim(l.SharesIssued,left,right), '');
			
			self.stock_par_value  		    := if ((integer)trim(l.ParValueAmnt) <> 0, trim(l.ParValueAmnt), '');
			
			tempParValue                    :=  if(trimUpper(l.ParValue) in ['N', 'P'], 
			                                       map(trimUpper(l.ParValue) = 'N' => 'NO PAR VALUE',
			                                           trimUpper(l.ParValue) = 'P' => 'PAR VALUE',
												       ''
												      ),
												  '');
			
			self.stock_Addl_Info            := if (tempParValue <> '', trim(tempParValue),'')  +			                                   
											   if (trim(l.Series) <> '',
											       if(tempParValue <> '','; STOCK SERIES: '+ trimUpper(l.Series),
												      'STOCK SERIES: '+ trimUpper(l.Series)),'');
			self							:= [];
		end;
		
		MapStock := project(Share_Stock_recs((integer)trim(BusinessEntityNo,left,right) <> 0 ),
		                    trfStock(left));		
		//************************************** End ************************************************
		
		//************************************** ANNUAL REPORT *************************************
		Corp2.Layout_Corporate_Direct_AR_In trfAnnualReport(Layouts_Raw_Input.Bus_Rec  l) := transform,
		                                                    skip ((integer)stringlib.stringfilter(l.ARLastFiledDate,'0123456789') = 0)
		
			self.corp_key					:= '30-' + trimUpper(l.BusinessEntityID) + trimUpper(l.BusinessEntityNo);		
			self.corp_vendor				:= '30';		
			self.corp_state_origin			:= 'MT';
			self.corp_process_date			:= filedate;
			self.corp_sos_charter_nbr		:= trimUpper(l.BusinessEntityID) + trimUpper(l.BusinessEntityNo);
                                          
			self.ar_filed_dt				:= if ((integer)stringlib.stringfilter(l.ARLastFiledDate,'0123456789') <> 0 and
												   _validate.date.fIsValid(formatDate(l.ARLastFiledDate)) and
												   _validate.date.fIsValid(formatDate(l.ARLastFiledDate),_validate.date.rules.DateInPast),
												   formatDate(l.ARLastFiledDate),'');

			self.ar_comment					:= if (self.ar_filed_dt <> '', 'ANNUAL REPORT', '');		
			self							:=[];
		end;
		
		MapAR := project(Busn_Recs, trfAnnualReport(left));
		
		//************************************** End ***********************************************
		
	VersionControl.macBuildNewLogicalFile(Constants.cluster + 'in::corp2::'+version+'::Corp_MT'	,MapCleanCorp	,corp_out	,,,pOverwrite);		
	VersionControl.macBuildNewLogicalFile(Constants.cluster + 'in::corp2::'+version+'::cont_MT'	,sort(MapCont, corp_key)		,cont_out	,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile(Constants.cluster + 'in::corp2::'+version+'::Stock_MT',MapStock		,stock_out,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile(Constants.cluster + 'in::corp2::'+version+'::AR_MT'	,MapAR			,ar_out		,,,pOverwrite);
		                                                                                                                                                      
		Map_MT_As_Corp := parallel(
			 corp_out	
			 ,cont_out	
			,stock_out
			,ar_out		
   );

		result := 
		sequential(
			 if(pshouldspray = true,fSprayFiles('mt',filedate,pOverwrite := pOverwrite))
			,Map_MT_As_Corp
			,parallel(
			 fileservices.addsuperfile(Constants.cluster + 'in::corp2::sprayed::corp'	,Constants.cluster + 'in::corp2::'+version+'::corp_MT')
			,fileservices.addsuperfile(Constants.cluster + 'in::corp2::sprayed::cont'	,Constants.cluster + 'in::corp2::'+version+'::cont_MT')
			,fileservices.addsuperfile(Constants.cluster + 'in::corp2::sprayed::stock',Constants.cluster + 'in::corp2::'+version+'::stock_MT')									
			,fileservices.addsuperfile(Constants.cluster + 'in::corp2::sprayed::ar'		,Constants.cluster + 'in::corp2::'+version+'::ar_MT')										
			)
		);
					
		return result;
	
	end;
	
end;