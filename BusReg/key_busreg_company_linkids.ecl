import BIPV2, Data_Services, doxie,ut, address, AID, VersionControl;

EXPORT key_busreg_company_linkids := MODULE

  // DEFINE THE INDEX
	shared superfile_name		:= BusReg.keynames(, VersionControl._Flags.IsDataland).Roxie.linkids.company_link_ids.qa;
	
	shared slimLayout	:=	record
			unsigned6												Bdid												:= 0;
			unsigned1												bdid_score									:= 0;
			UNSIGNED6												br_id														;     //Linking field to contact records
			unsigned4 											dt_first_seen										;
			unsigned4 											dt_last_seen										;
			unsigned4 											dt_vendor_first_reported				;
			unsigned4 											dt_vendor_last_reported					;
			string1													record_type											;
			
			unsigned4												record_date											;
			
			BusReg.layouts.input.old	-	ADCRecordNo						rawfields			;
			Address.Layout_Clean_Name				clean_officer1_name							;
			Address.Layout_Clean_Name				clean_officer2_name							;
			Address.Layout_Clean_Name				clean_officer3_name							;
			Address.Layout_Clean_Name				clean_officer4_name							;
			Address.Layout_Clean_Name				clean_officer5_name							;
			Address.Layout_Clean_Name				clean_officer6_name							;
			Address.Layout_Clean182_fips		Clean_mailing_address						;
			Address.Layout_Clean182_fips		Clean_location_address					;
			Address.Layout_Clean182_fips		Clean_ra_address								;
			Address.Layout_Clean182_fips		Clean_officer1_address					;
			Address.Layout_Clean182_fips		Clean_officer2_address					;
			Address.Layout_Clean182_fips		Clean_officer3_address					;
			Address.Layout_Clean182_fips		Clean_officer4_address					;
			Address.Layout_Clean182_fips		Clean_officer5_address					;
			Address.Layout_Clean182_fips		Clean_officer6_address					;
			BusReg.layouts.Miscellaneous.Cleaned_Dates		clean_dates											;
			BusReg.layouts.Miscellaneous.Cleaned_Phones		clean_phones										;
			string100				Clean_mailing_address1	;
			string50				Clean_mailing_address2	;
			string100				Clean_location_address1	;
			string50				Clean_location_address2	;
			string100				Clean_RA_address1				;
			string50				Clean_RA_address2			 	;		
			string100				Clean_officer1_address1	;
			string50				Clean_officer1_address2	;
			string100				Clean_officer2_address1	;
			string50				Clean_officer2_address2	;
			string100				Clean_officer3_address1	;
			string50				Clean_officer3_address2	;
			string100				Clean_officer4_address1	;
			string50				Clean_officer4_address2	;
			string100				Clean_officer5_address1	;
			string50				Clean_officer5_address2	;
			string100				Clean_officer6_address1	;
			string50				Clean_officer6_address2	;			
			AID.Common.xAID	Append_MailRawAID		:=	0;
			AID.Common.xAID	Append_MailACEAID		:=	0;
			
			AID.Common.xAID	Append_LocRawAID		:=	0;
			AID.Common.xAID	Append_LocACEAID		:=	0;

			AID.Common.xAID	Append_RARawAID			:=	0;
			AID.Common.xAID	Append_RAACEAID			:=	0;
			
			AID.Common.xAID	Append_Off1RawAID		:=	0;
			AID.Common.xAID	Append_Off1ACEAID		:=	0;
			
			AID.Common.xAID	Append_Off2RawAID		:=	0;	
			AID.Common.xAID	Append_Off2ACEAID		:=	0;	
			
			AID.Common.xAID	Append_Off3RawAID		:=	0;	
			AID.Common.xAID	Append_Off3ACEAID		:=	0;	
			
			AID.Common.xAID	Append_Off4RawAID		:=	0;
			AID.Common.xAID	Append_Off4ACEAID		:=	0;	
			
			AID.Common.xAID	Append_Off5RawAID		:=	0;
			AID.Common.xAID	Append_Off5ACEAID		:=	0;	
			
			AID.Common.xAID	Append_Off6RawAID		:=	0;
			AID.Common.xAID	Append_Off6ACEAID		:=	0;	
			UNSIGNED8 source_rec_id						  :=  0;  //Added for BIP2V2 project
			BIPV2.IDlayouts.l_xlink_ids;								//Added for BIP2V2 project
	end;
	
	shared Base				:= project(BusReg.Files().Base.AID.Built,transform(slimLayout, self := left));
	
	BIPV2.IDmacros.mac_IndexWithXLinkIDs(Base, k, superfile_name)
	export Key := k;


	//DEFINE THE INDEX ACCESS
	export kFetch2(
		dataset(BIPV2.IDlayouts.l_xlink_ids2) inputs, 
		string1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	//The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
																								//Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
																								//Should be enumerated or something?  at least need constants defined somewhere if you keep string1
		unsigned2 ScoreThreshold = 0,								//Applied at lowest leve of ID
		joinLimit = 25000,
		unsigned1 JoinType = BIPV2.IDconstants.JoinTypes.KeepJoin
		) :=
	FUNCTION

		BIPV2.IDmacros.mac_IndexFetch2(inputs, Key, out, Level, joinLimit, JoinType);
		return out;																					

	END;
	
	// Depricated version of the above kFetch2
	export kFetch(
		dataset(BIPV2.IDlayouts.l_xlink_ids) inputs, 
		string1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	//The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
																								//Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
																								//Should be enumerated or something?  at least need constants defined somewhere if you keep string1
		unsigned2 ScoreThreshold = 0,								//Applied at lowest leve of ID
		joinLimit = 25000
		) :=
	FUNCTION

		inputs_for2 := project(inputs, BIPV2.IDlayouts.l_xlink_ids2);
		f2 := kFetch2(inputs_for2, Level, ScoreThreshold, JoinLimit);		
		return project(f2, recordof(Key));																				

	END;

END;