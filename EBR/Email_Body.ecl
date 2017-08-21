import ut;

export Email_Body(string filedate) := function

boolean keyfilter :=    stringlib.stringtouppercase(Keynames(filedate).dAll_Oldsuperfilenames.name) != stringlib.stringtouppercase('~thor_data400::key::ebr_2000_trade.bdid')
					and stringlib.stringtouppercase(Keynames(filedate).dAll_Oldsuperfilenames.name) != stringlib.stringtouppercase('~thor_data400::key::ebr_2015_trade_payment_totals.bdid')
					and stringlib.stringtouppercase(Keynames(filedate).dAll_Oldsuperfilenames.name) != stringlib.stringtouppercase('~thor_data400::key::ebr_2020_trade_payment_trends.bdid')
					and stringlib.stringtouppercase(Keynames(filedate).dAll_Oldsuperfilenames.name) != stringlib.stringtouppercase('~thor_data400::key::ebr_2025_trade_quarterly_averages.bdid')
					and stringlib.stringtouppercase(Keynames(filedate).dAll_Oldsuperfilenames.name) != stringlib.stringtouppercase('~thor_data400::key::ebr_4500_collateral_accounts.bdid')
					and stringlib.stringtouppercase(Keynames(filedate).dAll_Oldsuperfilenames.name) != stringlib.stringtouppercase('~thor_data400::key::ebr_5000_bank_details.bdid')
					and stringlib.stringtouppercase(Keynames(filedate).dAll_Oldsuperfilenames.name) != stringlib.stringtouppercase('~thor_data400::key::ebr_5610_demographic_data.bdid')
					and stringlib.stringtouppercase(Keynames(filedate).dAll_Oldsuperfilenames.name) != stringlib.stringtouppercase('~thor_data400::key::ebr_5610_demographic_data.ssn')
					and stringlib.stringtouppercase(Keynames(filedate).dAll_Oldsuperfilenames.name) != stringlib.stringtouppercase('~thor_data400::key::ebr_5610_demographic_data.did')
					and stringlib.stringtouppercase(Keynames(filedate).dAll_Oldsuperfilenames.name) != stringlib.stringtouppercase('~thor_data400::key::ebr_6000_inquiries.bdid')
					and stringlib.stringtouppercase(Keynames(filedate).dAll_Oldsuperfilenames.name) != stringlib.stringtouppercase('~thor_data400::key::ebr_6500_government_trade.bdid')
					and stringlib.stringtouppercase(Keynames(filedate).dAll_Oldsuperfilenames.name) != stringlib.stringtouppercase('~thor_data400::key::ebr_6510_government_debarred_contractor.bdid')
					and stringlib.stringtouppercase(Keynames(filedate).dAll_Oldsuperfilenames.name) != stringlib.stringtouppercase('~thor_data400::key::ebr_7010_snp_data.bdid');




all_superkeynames := Keynames(filedate).dAll_Oldsuperfilenames(keyfilter);

ut.Layout_Names taddqa(ut.Layout_Names l) := 
transform
	self.name	:= l.name + '_qa';
end;

qa_superkeys := project(all_superkeynames, taddqa(left));

retval := ut.fPrepareRoxieEmailBody(qa_superkeys);

return retval;

end;
