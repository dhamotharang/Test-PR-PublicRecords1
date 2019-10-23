import ut;

export fnTranslations := module

	export allowflags(dataset(INQL_v2.Layouts.Common_ThorAdditions) basefile) := project(basefile, transform({recordof(basefile), string Allow_Description}, 
									self.Allow_Description := 
									stringlib.stringcleanspaces(map(left.Allow_Flags.allowflags &  ut.bit_set(0,1) = ut.bit_set(0,1) => 'No Restrictions | ', '')+
										map(left.Allow_Flags.allowflags &  ut.bit_set(0,2) = ut.bit_set(0,2) => 'Fraud Prevention | ', '')+
										map(left.Allow_Flags.allowflags &  ut.bit_set(0,3) = ut.bit_set(0,3) => 'ID Verification | ', '')+
										map(left.Allow_Flags.allowflags &  ut.bit_set(0,4) = ut.bit_set(0,4) => 'Authentication | ', '')+
										map(left.Allow_Flags.allowflags &  ut.bit_set(0,5) = ut.bit_set(0,5) => 'Credit Risk Management | ', '')+
										map(left.Allow_Flags.allowflags &  ut.bit_set(0,6) = ut.bit_set(0,6) => 'Insurance Underwriting | ', '')+
										map(left.Allow_Flags.allowflags &  ut.bit_set(0,7) = ut.bit_set(0,7) => 'Collections | ', '')+
										map(left.Allow_Flags.allowflags &  ut.bit_set(0,8) = ut.bit_set(0,8) => 'Law Enforcement | ', '')+
										map(left.Allow_Flags.allowflags &  ut.bit_set(0,9) = ut.bit_set(0,9) => 'Marketing | ', '')+
										map(left.Allow_Flags.allowflags &  ut.bit_set(0,10) = ut.bit_set(0,10) => 'Employment Screening | ', '')+
										map(left.Allow_Flags.allowflags &  ut.bit_set(0,11) = ut.bit_set(0,11) => 'Tenant Screening | ', '')+
										map(left.Allow_Flags.allowflags &  ut.bit_set(0,12) = ut.bit_set(0,12) => 'Disable Observation | ', '')+
										map(left.Allow_Flags.allowflags &  ut.bit_set(0,13) = ut.bit_set(0,13) => 'Opt Out | ', '')+
										map(left.Allow_Flags.allowflags &  ut.bit_set(0,14) = ut.bit_set(0,14) => 'Internal | ', '')+
										map(left.Allow_Flags.allowflags &  ut.bit_set(0,15) = ut.bit_set(0,15) => 'Exclude Access to Inquiry  | ', '')+
										map(left.Allow_Flags.allowflags &  ut.bit_set(0,16) = ut.bit_set(0,16) => 'NEW FLAG 1 - Unused | ', '')+
										map(left.Allow_Flags.allowflags &  ut.bit_set(0,17) = ut.bit_set(0,17) => 'Vertical Filter Out | ', '')+
										map(left.Allow_Flags.allowflags &  ut.bit_set(0,18) = ut.bit_set(0,18) => 'Industry Filter Out | ', '')+
										map(left.Allow_Flags.allowflags &  ut.bit_set(0,19) = ut.bit_set(0,19) => 'Sub Market Filter Out | ', '')+
									  map(left.Allow_Flags.allowflags &  ut.bit_set(0,20) = ut.bit_set(0,20) => 'Additional Healthcare Filter Out | ', '')
										);
									self := left));

	export is_No_Restrictions(unsigned6 allowflags)					:= allowflags & ut.bit_set(0,1) = ut.bit_set(0,1);
	export is_Fraud_Prevention(unsigned6 allowflags)				:= allowflags & ut.bit_set(0,2) = ut.bit_set(0,2);
	export is_ID_Verification(unsigned6 allowflags)					:= allowflags & ut.bit_set(0,3) = ut.bit_set(0,3);
	export is_Authentication(unsigned6 allowflags)					:= allowflags & ut.bit_set(0,4) = ut.bit_set(0,4);
	export is_Credit_Risk_Management(unsigned6 allowflags)	:= allowflags & ut.bit_set(0,5) = ut.bit_set(0,5);
	export is_Insurance_Underwriting(unsigned6 allowflags)	:= allowflags & ut.bit_set(0,6) = ut.bit_set(0,6);
	export is_Collections(unsigned6 allowflags)							:= allowflags & ut.bit_set(0,7) = ut.bit_set(0,7);
	export is_Law_Enforcement(unsigned6 allowflags)					:= allowflags & ut.bit_set(0,8) = ut.bit_set(0,8);
	export is_Marketing(unsigned6 allowflags)								:= allowflags & ut.bit_set(0,9) = ut.bit_set(0,9);
	export is_Employment_Screening(unsigned6 allowflags)		:= allowflags & ut.bit_set(0,10) = ut.bit_set(0,10);
	export is_Tenant_Screening(unsigned6 allowflags)				:= allowflags & ut.bit_set(0,11) = ut.bit_set(0,11);
	export is_Disable_Observation(unsigned6 allowflags)			:= allowflags & ut.bit_set(0,12) = ut.bit_set(0,12);
	export is_Opt_Out(unsigned6 allowflags)									:= allowflags & ut.bit_set(0,13) = ut.bit_set(0,13);
	export is_Internal(unsigned6 allowflags)								:= allowflags & ut.bit_set(0,14) = ut.bit_set(0,14);
	export is_Exclude_Inquiry_Access(unsigned6 allowflags)	:= allowflags & ut.bit_set(0,15) = ut.bit_set(0,15);
	export is_New_Flag(unsigned6 allowflags)								:= allowflags & ut.bit_set(0,16) = ut.bit_set(0,16);
  export is_VerticalFilter(unsigned6 allowflags)					:= allowflags & ut.bit_set(0,17) = ut.bit_set(0,17);
  export is_IndustryFilter(unsigned6 allowflags)					:= allowflags & ut.bit_set(0,18) = ut.bit_set(0,18);
  export is_SubMarketFilter(unsigned6 allowflags)					:= allowflags & ut.bit_set(0,19) = ut.bit_set(0,19);
	export is_AdditionalHealthcare(unsigned6 allowflags)		:= allowflags & ut.bit_set(0,20) = ut.bit_set(0,20);

	export allowflags_str(unsigned6 infield) := 
									stringlib.stringcleanspaces(map(infield &  ut.bit_set(0,1) = ut.bit_set(0,1) => 'No Restrictions | ', '')+
										map(infield &  ut.bit_set(0,2) = ut.bit_set(0,2) => 'Fraud Prevention | ', '')+
										map(infield &  ut.bit_set(0,3) = ut.bit_set(0,3) => 'ID Verification | ', '')+
										map(infield &  ut.bit_set(0,4) = ut.bit_set(0,4) => 'Authentication | ', '')+
										map(infield &  ut.bit_set(0,5) = ut.bit_set(0,5) => 'Credit Risk Management | ', '')+
										map(infield &  ut.bit_set(0,6) = ut.bit_set(0,6) => 'Insurance Underwriting | ', '')+
										map(infield &  ut.bit_set(0,7) = ut.bit_set(0,7) => 'Collections | ', '')+
										map(infield &  ut.bit_set(0,8) = ut.bit_set(0,8) => 'Law Enforcement | ', '')+
										map(infield &  ut.bit_set(0,9) = ut.bit_set(0,9) => 'Marketing | ', '')+
										map(infield &  ut.bit_set(0,10) = ut.bit_set(0,10) => 'Employment Screening | ', '')+
										map(infield &  ut.bit_set(0,11) = ut.bit_set(0,11) => 'Tenant Screening | ', '')+
										map(infield &  ut.bit_set(0,12) = ut.bit_set(0,12) => 'Disable Observation | ', '')+
										map(infield &  ut.bit_set(0,13) = ut.bit_set(0,13) => 'Opt Out | ', '')+
										map(infield &  ut.bit_set(0,14) = ut.bit_set(0,14) => 'Internal | ', '')+
										map(infield &  ut.bit_set(0,15) = ut.bit_set(0,15) => 'Exclude Access to Inquiry  | ', '')+
										map(infield &  ut.bit_set(0,16) = ut.bit_set(0,16) => 'NEW FLAG 1 - Unused | ', '')+
										map(infield &  ut.bit_set(0,17) = ut.bit_set(0,17) => 'Vertical Filter Out | ', '')+
										map(infield &  ut.bit_set(0,18) = ut.bit_set(0,18) => 'Industry Filter Out | ', '')+
										map(infield &  ut.bit_set(0,19) = ut.bit_set(0,19) => 'Sub Market Filter Out | ', '')+
										map(infield &  ut.bit_set(0,20) = ut.bit_set(0,20) => 'Additional Healthcare Filter Out | ', '')
										);
										
end;