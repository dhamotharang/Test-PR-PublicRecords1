import ut, address, aid, lib_stringlib, address, did_add, Business_Header_SS;

EXPORT _PATCH:=MODULE

EXPORT fixAllowFlag(dataset(inquiry_acclogs.Layout.Common_ThorAdditions) infile) := function

	outfile := PROJECT(infile, transform(inquiry_acclogs.layout.Common_ThorAdditions, 
	
 //chkVal := self.internal_flag + left.disable_observation;

	self.Allow_Flags.AllowFlags := 
		if(//(unsigned)chkVal = 0 and chkVal = '' and 
		left.bus_intel.sub_market not in inquiry_acclogs.fnCleanFunctions.SubMarket_FilterCds and
		left.bus_intel.vertical not in inquiry_acclogs.fnCleanFunctions.FilterCds and
		~regexfind(inquiry_acclogs.fnCleanFunctions.FilterCds_extra,left.bus_intel.vertical) and  
		left.bus_intel.industry not in inquiry_acclogs.fnCleanFunctions.Industry_FilterCds, /*and 
		~(self.bus_intel.industry in ['', '[BLANK]'] and (self.mbs_company_name in inquiry_acclogs.fnCleanFunctions.healthcare_FilterCds_extra
		or self.acct_name in inquiry_acclogs.fnCleanFunctions.healthcare_FilterCds_extra
		or self.cust_name in inquiry_acclogs.fnCleanFunctions.healthcare_FilterCds_extra)),	*/
		left.Allow_Flags.allowflags, // no restrictions true , opt-out true is default
		
		map(left.bus_intel.vertical in inquiry_acclogs.fnCleanFunctions.FilterCds => ut.bit_set(0,17), ut.bit_set(0,0)) |
		map(regexfind(inquiry_acclogs.fnCleanFunctions.FilterCds_extra,left.bus_intel.vertical,nocase) => ut.bit_set(0,17), ut.bit_set(0,0)) |
		map(left.bus_intel.industry in inquiry_acclogs.fnCleanFunctions.Industry_FilterCds => ut.bit_set(0,18), ut.bit_set(0,0)) |
		map(left.bus_intel.sub_market in inquiry_acclogs.fnCleanFunctions.SubMarket_FilterCds => ut.bit_set(0,19), ut.bit_set(0,0))),

	//	self.translation := inquiry_acclogs.fnTranslations.allowflags_str(self.allowflags);

		self := left));
return outfile;
END;
END;