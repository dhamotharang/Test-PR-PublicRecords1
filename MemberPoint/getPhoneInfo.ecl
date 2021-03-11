import progressive_phone,addrbest,Gateway,Std;
import Royalty, MDR, Phone_Shell;

/*
Run the minor through WFV7 and only return a confirmed phone. 
If no confirmed phones are found do not return anything.

*/
EXPORT getPhoneInfo(dataset (MemberPoint.Layouts.BestExtended) dsBestE, MemberPoint.IParam.BatchParams BParams) := function

// Construct Batch 

		PhoneBatchIn := project(dsBestE, transform(progressive_phone.layout_progressive_batch_in,
					self.did 					:= left.did,
					self.acctno 			:= (string) left.seq,
					self.ssn 					:= if(left.best_ssn <> '',left.best_ssn,left.ssn), 
					self.name_first 	:= if(left.best_fname <> '',left.best_fname,left.fname ),
					self.name_middle 	:= if(left.best_fname <> '',left.best_mname,left.mname ),
					self.name_last 		:= if(left.best_fname <> '',left.best_lname,left.lname ),
					self.name_suffix 	:= left.best_name_suffix,
					//self.dob 					:= if(left.best_dob <> '', left.best_dob,left.dob),
					//self.phoneno 			:= left.primary_phone_number, // Don't give the phone number
					self.prim_range 	:= left.c_best_prim_range,
					self.predir 			:= left.c_best_predir,
					self.prim_name 		:= left.c_best_prim_name,
					self.suffix 			:= left.c_best_addr_suffix,
					self.postdir 			:= left.c_best_postdir,
					self.unit_desig 	:= left.c_best_unit_desig,
					self.sec_range 		:= left.c_best_sec_range,
					self.p_city_name	:= left.c_best_p_city_name,
					self.st						:= left.c_best_st,
					self.z5						:= left.c_best_z5,
					self 							:= []
		));

		gateways_in := Gateway.Configuration.Get();
		//WFP v7 only.  Returns the input phone along with any other selected countTypes.

		isPhoneInfoContactplus	:= Std.Str.ToUpperCase(BParams.StrTransactionType) = MemberPoint.Constants.PhoneTransactionType.ContactPlusPhones;	
		MPD := MemberPoint.Constants.Defaults;

		BOOLEAN includeInputPhone := TRUE; 
		BOOLEAN ReturnScore := BParams.ReturnScore;
		STRING  scoreModel := BParams.Phones_Score_Model;
		UNSIGNED2 MaxNumAssociate := BParams.MaxNumAssociate;
		UNSIGNED2 MaxNumAssociateOther  := BParams.MaxNumAssociateOther;
		UNSIGNED2 MaxNumFamilyOther := BParams.MaxNumFamilyOther;
		UNSIGNED2 MaxNumFamilyClose := BParams.MaxNumFamilyClose;
		UNSIGNED2 MaxNumParent := BParams.MaxNumParent;
		UNSIGNED2 MaxNumSpouse := BParams.MaxNumSpouse;
		UNSIGNED2 MaxNumSubject := BParams.MaxNumSubject;
		UNSIGNED2 MaxNumNeighbor := BParams.MaxNumNeighbor;
		BOOLEAN UsePremiumSource_A := IF(isPhoneInfoContactplus,MPD.UsePremiumSource_A_cp,BParams.UsePremiumSource_A);
      	INTEGER PremiumSource_A_limit := IF(isPhoneInfoContactplus,MPD.PremiumSource_A_limit_cp,BParams.PremiumSource_A_limit);
 
		PhoneParams := module(project(BParams ,progressive_phone.iParam.Batch, opt)) 
				EXPORT BOOLEAN ExcludeDeadContacts       := FALSE;
				EXPORT BOOLEAN SkipPhoneScoring          := FALSE;
				EXPORT BOOLEAN IncludeBusinessPhones     := TRUE;
				EXPORT BOOLEAN IncludeLandlordPhones     := FALSE;
				EXPORT BOOLEAN ExcludeNonCellPPData      := FALSE;
				EXPORT BOOLEAN Include7DigitPhones       := TRUE;
				EXPORT BOOLEAN IncludeRelativeCellPhones := TRUE;
				EXPORT BOOLEAN IncludeCellFirstForPP     := FALSE;
				EXPORT INTEGER CountES                   := 1;
				EXPORT INTEGER CountSE                   := 1;
				EXPORT INTEGER CountAP                   := 1;
				EXPORT INTEGER CountSP                   := 1;
				EXPORT INTEGER CountMD                   := 1;
				EXPORT INTEGER CountCL                   := 1;
				EXPORT INTEGER CountCR                   := 1;
				EXPORT INTEGER CountSX                   := 1;
				EXPORT INTEGER CountPP                   := 1;
				EXPORT INTEGER Count7                    := 1;
				EXPORT INTEGER CountNE                   := 1;
				EXPORT INTEGER CountWK                   := 1;
				EXPORT INTEGER CountRL                   := 1;
				EXPORT INTEGER CountTH                   := 1;
				EXPORT BOOLEAN NameMatch                 := BParams.Match_Name;
				EXPORT BOOLEAN StreetAddressMatch        := BParams.Match_Street_Address;
				EXPORT BOOLEAN CityMatch                 := BParams.Match_City;
				EXPORT BOOLEAN StateMatch                := BParams.Match_State;
				EXPORT BOOLEAN ZipMatch                  := BParams.Match_Zip;
				EXPORT BOOLEAN SSNMatch                  := BParams.Match_SSN;
				EXPORT BOOLEAN DIDMatch                  := BParams.Match_LinkID;
		end;

				dsPhones :=  AddrBest.Progressive_phone_common(PhoneBatchIn,
																PhoneParams
																,
																,
																gateways_in,
																,
																,
																,
																,
																scoreModel,
																MaxNumAssociate,
																MaxNumAssociateOther,
																MaxNumFamilyOther,
																MaxNumFamilyClose,
																MaxNumParent,
																MaxNumSpouse,
																MaxNumSubject,
																MaxNumNeighbor,
																UsePremiumSource_A,
																PremiumSource_A_limit);

// ROYALTIES
	ungroup_dsPhones := UNGROUP(dsPhones);
	_f_out := progressive_phone.functions.UpdateWithMetadata(ungroup_dsPhones);
	results_1 := BatchFinalAssignments(_f_out, Progressive_Phone.Layout_Progressive_phones.common_with_meta_rec, UsePremiumSource_A, scoreModel, BParams.MaxPhoneCount);
	dRoyaltiesByAcctno_EQUIFAX := if(UsePremiumSource_A, Royalty.RoyaltyEFXDataMart.GetBatchRoyaltiesByAcctno(PhoneBatchIn, results_1,,,acctno));
	dRoyalties := Royalty.GetBatchRoyalties(dRoyaltiesByAcctno_EQUIFAX, BParams.ReturnDetailedRoyalties);

	Phone_results := project(results_1, TRANSFORM(progressive_phone.layout_progressive_phone_common,
							SELF := LEFT,
							SELF := []
	));
	dsPhones_final := dataset([{Phone_results,dRoyalties}],MemberPoint.Layouts.ProgressivePhoneRec);
	return(dsPhones_final);
end;