IMPORT Gateway, Phone_Shell, RiskWise, PhoneMart, doxie, Models, STD;

EXPORT Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus Gather_Phones (DATASET(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus) Input,
																																						 DATASET(Gateway.Layouts.Config) Gateways,
																																						 UNSIGNED1 GLBPurpose,
																																						 UNSIGNED1 DPPAPurpose,
																																						 STRING50 DataRestrictionMask,
																																						 STRING50 DataPermissionMask,
																																						 UNSIGNED1 PhoneRestrictionMask,
																																						 UNSIGNED3 MaxPhones,
																																						 UNSIGNED3 InsuranceVerificationAgeLimit,
																																						 STRING2 SPIIAccessLevel, // 5A or 5B - used in TransUnion Gateway
																																						 STRING30 VerticalMarket, // Example: 'Receivables Management' restricts certain Gateways
																																						 STRING30 IndustryClass, // Example: 'UTILI' restricts Utility Data
																																						 INTEGER RelocationsMaxDaysBefore,
																																						 INTEGER RelocationsMaxDaysAfter,
																																						 INTEGER RelocationsTargetRadius,
																																						 BOOLEAN IncludeLastResort = FALSE, // Incolude the Phones of Last Resort Phones Plus Royalty Dataset (There is a cost associated with this)
																																						 BOOLEAN IncludePhonesFeedback = FALSE,
																																						 BOOLEAN TestAccount = FALSE, // Indicates if TestAccounts should be enforced for Gateways
																																						 BOOLEAN Batch = FALSE, // Indicates if this is a Batch transaction (FALSE = realtime)
																																						 UNSIGNED2 SX_Match_Restriction_Limit = 10, // By default return a MAX of 10 Extended Skip Trace Phones
																																						 BOOLEAN Strict_APSX = FALSE, // By default don't enforce strict Extended Skip Trace matching
																																						 BOOLEAN BlankOutDuplicatePhones = FALSE,
																																						 BOOLEAN UsePremiumSource_A = FALSE,
																																						 BOOLEAN RunRelocation = FALSE,
                                       UNSIGNED2 PhoneShellVersion = 10, // use 2-digit notation (10 = Phone Shell Version 1.0, 20 = Version 2.0, etc)
                                       doxie.IDataAccess mod_access = MODULE (doxie.IDataAccess) END) := FUNCTION

  IncludeLexIDCounts := if(PhoneShellVersion >= 21, true, false); // include LexID Count/'all' attributes if PhoneShell Version 2.1+

	/* ******************************************************************************
   ********************************************************************************
	 ** This function calls all of the search functions and then joins the results **
	 ** together.  It is intended that these functions run in parallel to help     **
	 ** with performance.                                                          **
	 ********************************************************************************
	 ** Searches: CoResident, EDA, Infutor, Parent, People At Work,      **
	 **   Phones Feedback, Phones Plus, Relative Close Proximity, Relocation,      **
	 **   Spouse, Targus PDE, TransUnion and Utility.                              **
	 ********************************************************************************
	 ****************************************************************************** */

	 HeaderAddresses := Phone_Shell.Search_Header_Unique_Addresses(Input, GLBPurpose, DPPAPurpose, DataRestrictionMask, mod_access);

	 NonSubjectPhones := Phone_Shell.Search_Parent_Spouse_Relative_RawData(Input, mod_access);

	 InputPhones := Phone_Shell.Search_Input(Input, PhoneRestrictionMask, PhoneShellVersion);

	 Infutor := Phone_Shell.Search_Infutor(Input, PhoneRestrictionMask, PhoneShellVersion, mod_access);

	 PeopleAtWork := Phone_Shell.Search_PeopleAtWork(Input, PhoneRestrictionMask, PhoneShellVersion, mod_access);

	 PhonesFeedback := IF(IncludePhonesFeedback, Phone_Shell.Search_PhonesFeedback(Input, PhoneRestrictionMask, PhoneShellVersion, mod_access));

	 Relocation := IF(RunRelocation, Phone_Shell.Search_Relocation(Input, RelocationsMaxDaysBefore, RelocationsMaxDaysAfter, RelocationsTargetRadius, PhoneRestrictionMask, PhoneShellVersion));

	 Utility := Phone_Shell.Search_Utility(Input, GLBPurpose, PhoneRestrictionMask, IndustryClass, PhoneShellVersion);

	 Spouse := Phone_Shell.Search_Spouse(Input, NonSubjectPhones (Subj_Phone_Type = '41'), PhoneRestrictionMask, PhoneShellVersion);

	 Parent := Phone_Shell.Search_Parent(Input, NonSubjectPhones (Subj_Phone_Type = '42'), PhoneRestrictionMask, PhoneShellVersion);

	 RelativeCloseProximity := Phone_Shell.Search_RelativeCloseProximity(Input, NonSubjectPhones (Subj_Phone_Type = '43'), PhoneRestrictionMask, PhoneShellVersion);

	 CoResident := Phone_Shell.Search_CoResident(Input, NonSubjectPhones (Subj_Phone_Type = '44'), PhoneRestrictionMask, PhoneShellVersion);

	 EDA := Phone_Shell.Search_EDA(Input, HeaderAddresses, PhoneRestrictionMask, PhoneShellVersion, mod_access);

	 PhonesPlus := Phone_Shell.Search_PhonesPlus(Input, HeaderAddresses, GLBPurpose, DPPAPurpose, IncludeLastResort, PhoneRestrictionMask, DataPermissionMask, IndustryClass, DataRestrictionMask, PhoneShellVersion, mod_access);

	 SkipTrace := Phone_Shell.Search_Extended_Skip_Trace(Input, PhoneRestrictionMask, DataRestrictionMask, SX_Match_Restriction_Limit, Strict_APSX, PhoneShellVersion, mod_access);

	 Neighbors := Phone_Shell.Search_Neighbors(Input, PhoneRestrictionMask, DataRestrictionMask, GLBPurpose, DPPAPurpose, PhoneShellVersion := PhoneShellVersion, in_mod_access := mod_access);

	 /* ***************************************************************
		* 		Gateway Searches *
	  *************************************************************** */
	 Targus := Phone_Shell.Search_Gateway_Targus(Input, Gateways, DPPAPurpose, GLBPurpose, PhoneRestrictionMask);

	 TransUnion := Phone_Shell.Search_Gateway_TransUnion(Input, Gateways, DPPAPurpose, GLBPurpose, VerticalMarket, SPIIAccessLevel, PhoneRestrictionMask, DataRestrictionMask);

	 /* ***************************************************************
		* 									Join It All Together												*
	  *************************************************************** */
	  Combined := 	InputPhones (TRIM(Sources.Source_List) <> '' AND TRIM(Gathered_Phone) <> '')+
								CoResident (TRIM(Sources.Source_List) <> '' AND TRIM(Gathered_Phone) <> '') +
								EDA (TRIM(Sources.Source_List) <> '' AND TRIM(Gathered_Phone) <> '') +
								Infutor (TRIM(Sources.Source_List) <> '' AND TRIM(Gathered_Phone) <> '') +
								Parent (TRIM(Sources.Source_List) <> '' AND TRIM(Gathered_Phone) <> '') +
								PeopleAtWork (TRIM(Sources.Source_List) <> '' AND TRIM(Gathered_Phone) <> '') +
								PhonesFeedback (TRIM(Sources.Source_List) <> '' AND TRIM(Gathered_Phone) <> '') +
								PhonesPlus (TRIM(Sources.Source_List) <> '' AND TRIM(Gathered_Phone) <> '') +
								RelativeCloseProximity (TRIM(Sources.Source_List) <> '' AND TRIM(Gathered_Phone) <> '') +
								Relocation (TRIM(Sources.Source_List) <> '' AND TRIM(Gathered_Phone) <> '') +
								Spouse (TRIM(Sources.Source_List) <> '' AND TRIM(Gathered_Phone) <> '') +
								Utility (TRIM(Sources.Source_List) <> '' AND TRIM(Gathered_Phone) <> '') +
								SkipTrace (TRIM(Sources.Source_List) <> '' AND TRIM(Gathered_Phone) <> '') +
								Neighbors (TRIM(Sources.Source_List) <> '' AND TRIM(Gathered_Phone) <> '') +
								/* Gateways */
								Targus (TRIM(Sources.Source_List) <> '' AND TRIM(Gathered_Phone) <> '') +
								TransUnion (TRIM(Sources.Source_List) <> '' AND TRIM(Gathered_Phone) <> '');
		//get Equifax data
		//We don't need to check DRM 24 for this because we are not exposing the phone, just verifying it.
		WithPhoneMart := JOIN(Input, PhoneMart.key_phonemart_did,
							LEFT.DID <> 0 AND KEYED(LEFT.DID = RIGHT.l_DID) and RIGHT.phone != '',
								TRANSFORM(Phone_Shell.Layouts.Bureau_Phones,
											self.seq := left.Clean_Input.Seq;
											self.did := (UNSIGNED8) left.did;
											SELF.Bureau_Last_Update := TRIM((string)RIGHT.DT_LAST_SEEN);
											SELF.Bureau_Verified := TRUE; // We have a hit on Equifax, this number is verified
											SELF.Gathered_Phone := RIGHT.phone),
											KEEP(500), ATMOST(RiskWise.max_atmost));
			WithPhoneMartDate_srted := DEDUP(SORT(WithPhoneMart, Seq, did, Gathered_Phone, -(integer) Bureau_Last_Update),
								Seq, Did, Gathered_Phone);

		WithPhoneMartDate := JOIN(WithPhoneMartDate_srted, Combined,
							LEFT.Seq = RIGHT.Clean_Input.Seq AND
							(UNSIGNED8) LEFT.DID = (UNSIGNED8) RIGHT.DID AND
							LEFT.Gathered_phone = RIGHT.Gathered_phone,
									TRANSFORM(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus,
											SELF.Bureau.Bureau_Last_Update := TRIM((string) left.Bureau_Last_Update);
											SELF.Bureau.Bureau_Verified := left.Bureau_Verified;
											SELF.Experian_File_One_Verification.Experian_Verified := left.Bureau_Verified; //for sake of existing model
											SELF.Experian_File_One_Verification.Experian_Last_Update := TRIM((string) left.Bureau_Last_Update); //for sake of existing model
											SELF := RIGHT),
											RIGHT OUTER);
	 Equifax := Phone_Shell.Search_Equifax(Input, WithPhoneMartDate, DataRestrictionMask, PhoneRestrictionMask, UsePremiumSource_A, PhoneShellVersion, mod_access);
	 Combined_data := WithPhoneMartDate + Equifax (TRIM(Sources.Source_List) <> '' AND TRIM(Gathered_Phone) <> '');

	 ValidCombined := Combined_data (TRIM(Sources.Source_List) <> '' AND TRIM(Gathered_Phone) <> '');

	 Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus cleanData(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus le) := TRANSFORM
			// If the first seen date comes after the last seen date it is likely that information wasn't populated, use the last seen date as the first seen date
			SELF.Sources.Source_List_First_Seen := IF((INTEGER)le.Sources.Source_List_First_Seen >= (INTEGER)le.Sources.Source_List_Last_Seen, le.Sources.Source_List_Last_Seen, le.Sources.Source_List_First_Seen);

			SELF := le;
	 END;

	 cleanedCombined := PROJECT(ValidCombined, cleanData(LEFT));

	 SortedNumbers := SORT(cleanedCombined, Clean_Input.seq, Gathered_Phone, Sources.Source_List);

	 /* ***************************************************************
		*   Roll up by phone number, we want to count up the sources	  *
	  *************************************************************** */
	 Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus combineSources(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus le, Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus ri) := TRANSFORM

			SELF.Gathered_Phone := le.Gathered_Phone;
			SELF.Sources.Source_List := TRIM(le.Sources.Source_List) + ',' + TRIM(ri.Sources.Source_List);
			SELF.Sources.Source_List_First_Seen := TRIM(le.Sources.Source_List_First_Seen) + ',' + TRIM(ri.Sources.Source_List_First_Seen);
			SELF.Sources.Source_List_Last_Seen := TRIM(le.Sources.Source_List_Last_Seen) + ',' + TRIM(ri.Sources.Source_List_Last_Seen);

			SELF.Sources.Source_Owner_Name_Prefix := TRIM(le.Sources.Source_Owner_Name_Prefix) + ',' + TRIM(ri.Sources.Source_Owner_Name_Prefix);
			SELF.Sources.Source_Owner_Name_First 	:= TRIM(le.Sources.Source_Owner_Name_First) + ',' + TRIM(ri.Sources.Source_Owner_Name_First);
			SELF.Sources.Source_Owner_Name_Middle := TRIM(le.Sources.Source_Owner_Name_Middle) + ',' + TRIM(ri.Sources.Source_Owner_Name_Middle);
			SELF.Sources.Source_Owner_Name_Last  	:= TRIM(le.Sources.Source_Owner_Name_Last) + ',' + TRIM(ri.Sources.Source_Owner_Name_Last);
			SELF.Sources.Source_Owner_Name_Suffix := TRIM(le.Sources.Source_Owner_Name_Suffix) + ',' + TRIM(ri.Sources.Source_Owner_Name_Suffix);
			SELF.Sources.Source_Owner_DID := TRIM(le.Sources.Source_Owner_DID) + ',' + TRIM(ri.Sources.Source_Owner_DID);

   SELF.Sources.Source_List_All_Last_Seen := if(IncludeLexIDCounts,TRIM(le.Sources.Source_List_All_Last_Seen) + ',' + TRIM(ri.Sources.Source_List_All_Last_Seen),'');
			SELF.Sources.Source_Owner_All_DIDs     := if(IncludeLexIDCounts,TRIM(le.Sources.Source_Owner_All_DIDs) + ',' + TRIM(ri.Sources.Source_Owner_All_DIDs),'');

			SELF.Raw_Phone_Characteristics.Phone_Subject_Level := MIN(le.Raw_Phone_Characteristics.Phone_Subject_Level, ri.Raw_Phone_Characteristics.Phone_Subject_Level); // Keep whichever was closest to the subject

			// Keep the title which is most descriptive/accurate.
			subject_title := MAP(TRIM(le.Raw_Phone_Characteristics.Phone_Subject_Title) = 'Subject' OR TRIM(ri.Raw_Phone_Characteristics.Phone_Subject_Title) = 'Subject'																								=> 'Subject',
																																TRIM(le.Raw_Phone_Characteristics.Phone_Subject_Title) = 'Subject at Household' OR TRIM(ri.Raw_Phone_Characteristics.Phone_Subject_Title) = 'Subject at Household'											=> 'Subject at Household',
																																TRIM(le.Raw_Phone_Characteristics.Phone_Subject_Title) = 'Husband' OR TRIM(ri.Raw_Phone_Characteristics.Phone_Subject_Title) = 'Husband'																								=> 'Husband',
																																TRIM(le.Raw_Phone_Characteristics.Phone_Subject_Title) = 'Wife' OR TRIM(ri.Raw_Phone_Characteristics.Phone_Subject_Title) = 'Wife'																											=> 'Wife',
																																TRIM(le.Raw_Phone_Characteristics.Phone_Subject_Title) = 'Spouse' OR TRIM(ri.Raw_Phone_Characteristics.Phone_Subject_Title) = 'Spouse'																									=> 'Spouse',
																																TRIM(le.Raw_Phone_Characteristics.Phone_Subject_Title) = 'Father' OR TRIM(ri.Raw_Phone_Characteristics.Phone_Subject_Title) = 'Father'																									=> 'Father',
																																TRIM(le.Raw_Phone_Characteristics.Phone_Subject_Title) = 'Mother' OR TRIM(ri.Raw_Phone_Characteristics.Phone_Subject_Title) = 'Mother'																									=> 'Mother',
																																TRIM(le.Raw_Phone_Characteristics.Phone_Subject_Title) = 'Parent' OR TRIM(ri.Raw_Phone_Characteristics.Phone_Subject_Title) = 'Parent'																									=> 'Parent',
																																TRIM(le.Raw_Phone_Characteristics.Phone_Subject_Title) = 'Brother' OR TRIM(ri.Raw_Phone_Characteristics.Phone_Subject_Title) = 'Brother'																								=> 'Brother',
																																TRIM(le.Raw_Phone_Characteristics.Phone_Subject_Title) = 'Sister' OR TRIM(ri.Raw_Phone_Characteristics.Phone_Subject_Title) = 'Sister'																									=> 'Sister',
																																TRIM(le.Raw_Phone_Characteristics.Phone_Subject_Title) = 'Sibling' OR TRIM(ri.Raw_Phone_Characteristics.Phone_Subject_Title) = 'Sibling'																								=> 'Sibling',
																																TRIM(le.Raw_Phone_Characteristics.Phone_Subject_Title) = 'Son' OR TRIM(ri.Raw_Phone_Characteristics.Phone_Subject_Title) = 'Son'																												=> 'Son',
																																TRIM(le.Raw_Phone_Characteristics.Phone_Subject_Title) = 'Daughter' OR TRIM(ri.Raw_Phone_Characteristics.Phone_Subject_Title) = 'Daughter'																							=> 'Daughter',
																																TRIM(le.Raw_Phone_Characteristics.Phone_Subject_Title) = 'Child' OR TRIM(ri.Raw_Phone_Characteristics.Phone_Subject_Title) = 'Child'																										=> 'Child',
																																TRIM(le.Raw_Phone_Characteristics.Phone_Subject_Title) = 'Grandson' OR TRIM(ri.Raw_Phone_Characteristics.Phone_Subject_Title) = 'Grandson'																							=> 'Grandson',
																																TRIM(le.Raw_Phone_Characteristics.Phone_Subject_Title) = 'Granddaughter' OR TRIM(ri.Raw_Phone_Characteristics.Phone_Subject_Title) = 'Granddaughter'																		=> 'Granddaughter',
																																TRIM(le.Raw_Phone_Characteristics.Phone_Subject_Title) = 'Grandchild' OR TRIM(ri.Raw_Phone_Characteristics.Phone_Subject_Title) = 'Grandchild'																					=> 'Grandchild',
																																// Strangely enough, somewhere in our data Grandchild is misspelled - fix those spelling issues
																																TRIM(le.Raw_Phone_Characteristics.Phone_Subject_Title) = 'Gradchild' OR TRIM(ri.Raw_Phone_Characteristics.Phone_Subject_Title) = 'Gradchild'																						=> 'Grandchild',
																																TRIM(le.Raw_Phone_Characteristics.Phone_Subject_Title) = 'Grandfather' OR TRIM(ri.Raw_Phone_Characteristics.Phone_Subject_Title) = 'Grandfather'																				=> 'Grandfather',
																																TRIM(le.Raw_Phone_Characteristics.Phone_Subject_Title) = 'Grandmother' OR TRIM(ri.Raw_Phone_Characteristics.Phone_Subject_Title) = 'Grandmother'																				=> 'Grandmother',
																																TRIM(le.Raw_Phone_Characteristics.Phone_Subject_Title) = 'Grandparent' OR TRIM(ri.Raw_Phone_Characteristics.Phone_Subject_Title) = 'Grandparent'																				=> 'Grandparent',
																																TRIM(le.Raw_Phone_Characteristics.Phone_Subject_Title) = 'Relative' OR TRIM(ri.Raw_Phone_Characteristics.Phone_Subject_Title) = 'Relative'																							=> 'Relative',
																																TRIM(le.Raw_Phone_Characteristics.Phone_Subject_Title) = 'Neighbor' OR TRIM(ri.Raw_Phone_Characteristics.Phone_Subject_Title) = 'Neighbor'																							=> 'Neighbor',
																																TRIM(le.Raw_Phone_Characteristics.Phone_Subject_Title) = 'Associate By SSN' OR TRIM(ri.Raw_Phone_Characteristics.Phone_Subject_Title) = 'Associate By SSN'															=> 'Associate By SSN',
																																TRIM(le.Raw_Phone_Characteristics.Phone_Subject_Title) = 'Associate By Address' OR TRIM(ri.Raw_Phone_Characteristics.Phone_Subject_Title) = 'Associate By Address'											=> 'Associate By Address',
																																TRIM(le.Raw_Phone_Characteristics.Phone_Subject_Title) = 'Associate By Business' OR TRIM(ri.Raw_Phone_Characteristics.Phone_Subject_Title) = 'Associate By Business'										=> 'Associate By Business',
																																TRIM(le.Raw_Phone_Characteristics.Phone_Subject_Title) = 'Associate By Property' OR TRIM(ri.Raw_Phone_Characteristics.Phone_Subject_Title) = 'Associate By Property'										=> 'Associate By Property',
																																TRIM(le.Raw_Phone_Characteristics.Phone_Subject_Title) = 'Associate By Shared Associates' OR TRIM(ri.Raw_Phone_Characteristics.Phone_Subject_Title) = 'Associate By Shared Associates'	=> 'Associate By Shared Associates',
																																TRIM(le.Raw_Phone_Characteristics.Phone_Subject_Title) = 'Associate By Vehicle' OR TRIM(ri.Raw_Phone_Characteristics.Phone_Subject_Title) = 'Associate By Vehicle'											=> 'Associate By Vehicle',
																																TRIM(le.Raw_Phone_Characteristics.Phone_Subject_Title) = 'Associate' OR TRIM(ri.Raw_Phone_Characteristics.Phone_Subject_Title) = 'Associate'																						=> 'Associate',
																																TRIM(le.Raw_Phone_Characteristics.Phone_Subject_Title) <> ''																																																														=> le.Raw_Phone_Characteristics.Phone_Subject_Title,
																																																																																																																													 ri.Raw_Phone_Characteristics.Phone_Subject_Title);
			SELF.Raw_Phone_Characteristics.Phone_Subject_Title := subject_title;

			SELF.Raw_Phone_Characteristics.Phone_Match_Code := Phone_Shell.Common.CombineMatchcodes(le.Raw_Phone_Characteristics.Phone_Match_Code, ri.Raw_Phone_Characteristics.Phone_Match_Code);

			// These are populated in Phone_Shell.Search_PhonesPlus.  If a 'PP*' source is included in the Source List, these should be populated
			SELF.PhonesPlus_Characteristics.PhonesPlus_Type := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_Type) NOT IN ['', 'U'], le.PhonesPlus_Characteristics.PhonesPlus_Type, IF(TRIM(ri.PhonesPlus_Characteristics.PhonesPlus_Type) <> '', ri.PhonesPlus_Characteristics.PhonesPlus_Type, le.PhonesPlus_Characteristics.PhonesPlus_Type));
			SELF.PhonesPlus_Characteristics.PhonesPlus_Source := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_Source) <> '', le.PhonesPlus_Characteristics.PhonesPlus_Source, ri.PhonesPlus_Characteristics.PhonesPlus_Source);
			SELF.PhonesPlus_Characteristics.PhonesPlus_Carrier := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_Carrier) <> '', le.PhonesPlus_Characteristics.PhonesPlus_Carrier, ri.PhonesPlus_Characteristics.PhonesPlus_Carrier);
			SELF.PhonesPlus_Characteristics.PhonesPlus_City := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_City) <> '', le.PhonesPlus_Characteristics.PhonesPlus_City, ri.PhonesPlus_Characteristics.PhonesPlus_City);
			SELF.PhonesPlus_Characteristics.PhonesPlus_State := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_State) <> '', le.PhonesPlus_Characteristics.PhonesPlus_State, ri.PhonesPlus_Characteristics.PhonesPlus_State);

			// These are populated in Phone_Shell.Search_PhonesFeedback.  If a 'PF' source is included in the Source List, these should likely be populated
			SELF.Phone_Feedback.Phone_Feedback_Date := IF(TRIM(le.Phone_Feedback.Phone_Feedback_Date) NOT IN ['', '0'], le.Phone_Feedback.Phone_Feedback_Date, ri.Phone_Feedback.Phone_Feedback_Date);
			SELF.Phone_Feedback.Phone_Feedback_Result := IF(le.Phone_Feedback.Phone_Feedback_Result <> 0, le.Phone_Feedback.Phone_Feedback_Result, ri.Phone_Feedback.Phone_Feedback_Result);
			SELF.Phone_Feedback.Phone_Feedback_First := IF(TRIM(le.Phone_Feedback.Phone_Feedback_First) <> '', le.Phone_Feedback.Phone_Feedback_First, ri.Phone_Feedback.Phone_Feedback_First);
			SELF.Phone_Feedback.Phone_Feedback_Middle := IF(TRIM(le.Phone_Feedback.Phone_Feedback_Middle) <> '', le.Phone_Feedback.Phone_Feedback_Middle, ri.Phone_Feedback.Phone_Feedback_Middle);
			SELF.Phone_Feedback.Phone_Feedback_Last := IF(TRIM(le.Phone_Feedback.Phone_Feedback_Last) <> '', le.Phone_Feedback.Phone_Feedback_Last, ri.Phone_Feedback.Phone_Feedback_Last);
			SELF.Phone_Feedback.Phone_Feedback_Last_RPC_Date := IF(TRIM(le.Phone_Feedback.Phone_Feedback_Last_RPC_Date) NOT IN ['', '0'], le.Phone_Feedback.Phone_Feedback_Last_RPC_Date, ri.Phone_Feedback.Phone_Feedback_Last_RPC_Date);

			// These are populated in Phone_Shell.Search_EDA
			SELF.EDA_Characteristics.EDA_num_phones_indiv := le.EDA_Characteristics.EDA_num_phones_indiv + ri.EDA_Characteristics.EDA_num_phones_indiv;
			SELF.EDA_Characteristics.EDA_num_phones_connected_indiv := le.EDA_Characteristics.EDA_num_phones_connected_indiv + ri.EDA_Characteristics.EDA_num_phones_connected_indiv;
			SELF.EDA_Characteristics.EDA_num_phones_discon_indiv := le.EDA_Characteristics.EDA_num_phones_discon_indiv + ri.EDA_Characteristics.EDA_num_phones_discon_indiv;
			SELF.EDA_Characteristics.EDA_days_indiv_first_seen_with_phone := MAX(le.EDA_Characteristics.EDA_days_indiv_first_seen_with_phone, ri.EDA_Characteristics.EDA_days_indiv_first_seen_with_phone);
			SELF.EDA_Characteristics.EDA_is_discon_15_days := le.EDA_Characteristics.EDA_is_discon_15_days OR ri.EDA_Characteristics.EDA_is_discon_15_days;
			SELF.EDA_Characteristics.EDA_is_discon_30_days := le.EDA_Characteristics.EDA_is_discon_30_days OR ri.EDA_Characteristics.EDA_is_discon_30_days;
			SELF.EDA_Characteristics.EDA_is_discon_60_days := le.EDA_Characteristics.EDA_is_discon_60_days OR ri.EDA_Characteristics.EDA_is_discon_60_days;
			SELF.EDA_Characteristics.EDA_is_discon_90_days := le.EDA_Characteristics.EDA_is_discon_90_days OR ri.EDA_Characteristics.EDA_is_discon_90_days;
			SELF.EDA_Characteristics.EDA_is_discon_180_days := le.EDA_Characteristics.EDA_is_discon_180_days OR ri.EDA_Characteristics.EDA_is_discon_180_days;
			SELF.EDA_Characteristics.EDA_is_discon_360_days := le.EDA_Characteristics.EDA_is_discon_360_days OR ri.EDA_Characteristics.EDA_is_discon_360_days;

			// Make sure to appropriately track all of the Royalties
			SELF.Royalties.TargusComprehensive_Royalty := le.Royalties.TargusComprehensive_Royalty + ri.Royalties.TargusComprehensive_Royalty;
			SELF.Royalties.QSentCIS_Royalty := le.Royalties.QSentCIS_Royalty + ri.Royalties.QSentCIS_Royalty;
			SELF.Royalties.LastResortPhones_Royalty := le.Royalties.LastResortPhones_Royalty + ri.Royalties.LastResortPhones_Royalty;
			SELF.Royalties.EFXDataMart_Royalty := le.Royalties.EFXDataMart_Royalty + ri.Royalties.EFXDataMart_Royalty;
			SELF := le;
	 END;

	 combinedNumbers := ROLLUP(SortedNumbers, LEFT.Clean_Input.seq = RIGHT.Clean_Input.seq AND LEFT.Gathered_Phone = RIGHT.Gathered_Phone, combineSources(LEFT, RIGHT));

	 PhoneRestrictionMaskSet := CASE(PhoneRestrictionMask,
																		Phone_Shell.Constants.PRM.AllPhones 							=> [Phone_Shell.Constants.Phone_Subject_Level.Subject, Phone_Shell.Constants.Phone_Subject_Level.Household, Phone_Shell.Constants.Phone_Subject_Level.FirstDegreeRelative, Phone_Shell.Constants.Phone_Subject_Level.LeadToSubject],
																		Phone_Shell.Constants.PRM.SubjectDIDOnly					=> [Phone_Shell.Constants.Phone_Subject_Level.Subject],
																		Phone_Shell.Constants.PRM.AddressOnly							=> [Phone_Shell.Constants.Phone_Subject_Level.Household],
																		Phone_Shell.Constants.PRM.FirstDegreeRelativeOnly	=> [Phone_Shell.Constants.Phone_Subject_Level.FirstDegreeRelative],
																																																								// All other masks the filtering gets done in each of the Phone_Shell.Search_* attributes
																																																							 [Phone_Shell.Constants.Phone_Subject_Level.Subject, Phone_Shell.Constants.Phone_Subject_Level.Household, Phone_Shell.Constants.Phone_Subject_Level.FirstDegreeRelative, Phone_Shell.Constants.Phone_Subject_Level.LeadToSubject]);
	 // Catch all to ensure we only return Subject/Address/First Degree Relative phones and no phones under the full 10 digits
	 filteredNumbers := combinedNumbers (Raw_Phone_Characteristics.Phone_Subject_Level IN PhoneRestrictionMaskSet AND LENGTH(STD.Str.Filter(Gathered_Phone, '0123456789')) = 10 AND Gathered_Phone[1] <> '0');

	 groupedNumbers := GROUP(SORT(filteredNumbers, Clean_Input.seq), Clean_Input.seq);

	 // Keep the MaxPhones, but we need it to be deterministic as well so keep the ones matching subject, followed by the best match code, followed by the most sources, followed by the phone number itself
	 keepers := TOPN(groupedNumbers, MaxPhones, Clean_Input.seq, Raw_Phone_Characteristics.Phone_Subject_Level, -LENGTH(TRIM(Raw_Phone_Characteristics.Phone_Match_Code)), -STD.Str.FindCount(Sources.Source_List, ','), -LENGTH(TRIM(Sources.Source_List)), Gathered_Phone);

	 Sequenced := PROJECT(UNGROUP(keepers), TRANSFORM(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus, SELF.Unique_Record_Sequence := COUNTER;
																																																						// Strangely enough, somewhere in our data Grandchild is misspelled - fix those spelling issues
																																																						SELF.Raw_Phone_Characteristics.Phone_Subject_Title := IF(LEFT.Raw_Phone_Characteristics.Phone_Subject_Title = 'Gradchild', 'Grandchild', LEFT.Raw_Phone_Characteristics.Phone_Subject_Title);

                                                      // now that we have all the data populated and filtered from all sources, time to clean up and count the 'all' parameters
                                                      allNumbers := models.common.zip2(LEFT.Sources.Source_Owner_All_DIDs, LEFT.Sources.Source_List_All_Last_Seen,',',models.common.options.leftouter);
                                                      // filter out all '0' DIDs as we don't want to show or count them
                                                      allNumbers_nonZero := allNumbers(str1 != '0');
                                                      // keep one record per DID (str1), with the most recent (str2 descending) date for each did
                                                      allNumbersDeduped := dedup(sort(allNumbers_nonZero,str1,-str2),str1);
                                                      todaysDate := Phone_Shell.Common.parseDate((string) STD.Date.Today(), TRUE);

                                                      SELF.Sources.Source_Count_All_DIDs := count(allNumbersDeduped);
                                                      SELF.Sources.Source_Count_DIDs_3yr := count(allNumbersDeduped(Std.Date.MonthsBetween((INTEGER)str2, (INTEGER)todaysDate)<=36));
                                                      SELF.Sources.Source_Count_DIDs_2yr := count(allNumbersDeduped(Std.Date.MonthsBetween((INTEGER)str2, (INTEGER)todaysDate)<=24));
                                                      SELF.Sources.Source_Count_DIDs_18mo := count(allNumbersDeduped(Std.Date.MonthsBetween((INTEGER)str2, (INTEGER)todaysDate)<=18));
                                                      SELF.Sources.Source_Count_DIDs_12mo := count(allNumbersDeduped(Std.Date.MonthsBetween((INTEGER)str2, (INTEGER)todaysDate)<=12));
                                                      SELF.Sources.Source_Count_DIDs_9mo := count(allNumbersDeduped(Std.Date.MonthsBetween((INTEGER)str2, (INTEGER)todaysDate)<=9));
                                                      SELF.Sources.Source_Count_DIDs_6mo := count(allNumbersDeduped(Std.Date.MonthsBetween((INTEGER)str2, (INTEGER)todaysDate)<=6));
                                                      SELF.Sources.Source_Count_DIDs_3mo := count(allNumbersDeduped(Std.Date.MonthsBetween((INTEGER)str2, (INTEGER)todaysDate)<=3));

                                                      // prob a denormalize to get allNumbersDeduped back into comma-delimited format for putting it back in.
                                                      // ref publicrecords_kel.ecl_functions.common_functions.roll_field
                                                      DIDList := PROJECT(allNumbersDeduped,TRANSFORM({string roll_field}, self.roll_field := (string)left.str1));
                                                      concatDIDs := ROLLUP(DIDList, TRUE, TRANSFORM({string roll_field},
			                                                      SELF.roll_field := LEFT.roll_field + ',' + RIGHT.roll_field));
                                                      SELF.Sources.Source_Owner_All_DIDs := concatDIDs[1].roll_field;

                                                      DateList := PROJECT(allNumbersDeduped,TRANSFORM({string roll_field}, self.roll_field := (string)left.str2));
                                                      concatDates := ROLLUP(DateList, TRUE, TRANSFORM({string roll_field},
                                                         SELF.roll_field := left.roll_field + ',' + right.roll_field));
                                                      SELF.Sources.Source_List_All_Last_Seen := concatDates[1].roll_field;

																																																						SELF := LEFT));

	 /* ***************************************************************
		*      DEBUGGING SECTION -- COMMENT OUT FOR PRODUCTION		    	*
	  *************************************************************** */
	 // OUTPUT(CHOOSEN(Input, MaxPhones), NAMED('Input'));
	 // OUTPUT(CHOOSEN(HeaderAddresses, MaxPhones), NAMED('HeaderAddresses'));
	 // OUTPUT(CHOOSEN(InputPhones (TRIM(Gathered_Phone) <> ''), MaxPhones), NAMED('InputPhones'));
	 // OUTPUT(CHOOSEN(EDA (TRIM(Gathered_Phone) <> ''), MaxPhones), NAMED('EDA'));
	 // OUTPUT(CHOOSEN(Infutor (TRIM(Gathered_Phone) <> ''), MaxPhones), NAMED('Infutor'));
	 // OUTPUT(CHOOSEN(PeopleAtWork (TRIM(Gathered_Phone) <> ''), MaxPhones), NAMED('PeopleAtWork'));
	 // OUTPUT(CHOOSEN(PhonesFeedback (TRIM(Gathered_Phone) <> ''), MaxPhones), NAMED('PhonesFeedback'));
	 // OUTPUT(CHOOSEN(PhonesPlus (TRIM(Gathered_Phone) <> ''), MaxPhones), NAMED('PhonesPlus'));
	  //OUTPUT(CHOOSEN(Relocation (TRIM(Gathered_Phone) <> ''), MaxPhones), NAMED('Relocation'));
	 // OUTPUT(CHOOSEN(Utility (TRIM(Gathered_Phone) <> ''), MaxPhones), NAMED('Utility'));
	 // OUTPUT(CHOOSEN(NonSubjectPhones (TRIM(subj_phone10) <> ''), MaxPhones), NAMED('NonSubjectPhones'));
	 // OUTPUT(CHOOSEN(Spouse (TRIM(Gathered_Phone) <> ''), MaxPhones), NAMED('Spouse'));
	 // OUTPUT(CHOOSEN(Parent (TRIM(Gathered_Phone) <> ''), MaxPhones), NAMED('Parent'));
	 // OUTPUT(CHOOSEN(RelativeCloseProximity (TRIM(Gathered_Phone) <> ''), MaxPhones), NAMED('RelativeCloseProximity'));
	 // OUTPUT(CHOOSEN(CoResident (TRIM(Gathered_Phone) <> ''), MaxPhones), NAMED('CoResident'));
	 // OUTPUT(CHOOSEN(Targus (TRIM(Gathered_Phone) <> ''), MaxPhones), NAMED('Targus'));
	 // OUTPUT(CHOOSEN(TransUnion (TRIM(Gathered_Phone) <> ''), MaxPhones), NAMED('TransUnion'));
	 // OUTPUT(CHOOSEN(Combined, MaxPhones), NAMED('Combined'));
	 // OUTPUT(CHOOSEN(cleanedCombined, MaxPhones), NAMED('cleanedCombined'));
	 // OUTPUT(CHOOSEN(SortedNumbers, MaxPhones), NAMED('SortedNumbers'));
	 // OUTPUT(CHOOSEN(combinedNumbers, MaxPhones), NAMED('combinedNumbers'));
	 // OUTPUT(CHOOSEN(Sequenced, MaxPhones), NAMED('Sequenced'));
	 // OUTPUT(DataRestrictionMask,NAMED('DataRestrictionMask'));
	 // OUTPUT(UsePremiumSource_A,NAMED('UsePremiumSource_A'));
	 /* ***************************************************************
		* 									Return Final Result 												*
	  *************************************************************** */
	// Sequenced := dataset([], Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus);
	 RETURN(Sequenced);
END;
