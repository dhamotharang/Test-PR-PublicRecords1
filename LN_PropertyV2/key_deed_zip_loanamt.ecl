import doxie,ln_propertyv2,Data_Services;

dAddlFaresDeedMortg	:=	distribute(ln_propertyv2.File_addl_fares_deed,hash(ln_fares_id));
dDeedMortg					:=	distribute(ln_propertyv2.file_deed_building,hash(ln_fares_id));
dSearch							:=	distribute(	ln_propertyv2.file_search_building(			source_code[2]	=	'P'
																																				and	ln_fares_id[2]	in	['D','M']
																																				and	zip	!=	''
																																				and	zip	!=	'00000'
																																			),
																		hash(ln_fares_id)
																	);

// Get all the date fields relevant to deed mortgage file from additional fares file
rDeedMortgAddl	:=
record
	dDeedMortg;
	dAddlFaresDeedMortg.fares_mortgage_date;
	dAddlFaresDeedMortg.fares_prior_recording_date;
	dAddlFaresDeedMortg.fares_prior_sales_date;
end;

rDeedMortgAddl	tAddlFaresDeeds(dDeedMortg	le,dAddlFaresDeedMortg	ri)	:=
transform
	self	:=	le;
	self	:=	ri;
end;

dAddlDeedMortg	:=	join(	dDeedMortg,
													dAddlFaresDeedMortg,
													left.ln_fares_id	=	right.ln_fares_id,
													tAddlFaresDeeds(left,right),
													left outer,
													local
												);

// Get cleaned zip code from the search file
rCleanZip_layout	:=
record
	dAddlDeedMortg.ln_fares_id;
	dAddlDeedMortg.recording_date;
	dAddlDeedMortg.contract_date;
	dAddlDeedMortg.arm_reset_date;
	dAddlDeedMortg.first_td_due_date;
	dAddlDeedMortg.fares_mortgage_date;
	dAddlDeedMortg.fares_prior_recording_date;
	dAddlDeedMortg.fares_prior_sales_date;
	dAddlDeedMortg.first_td_loan_amount;
	dAddlDeedMortg.second_td_loan_amount;
	dSearch.zip;
end;

rCleanZip_layout	tAppendCleanZip(dAddlDeedMortg	le,dSearch	ri)	:=
transform
	self	:=	le;
	self	:=	ri;
end;

dDeedMortClean	:=	join(	dAddlDeedMortg,
													dSearch,
													left.ln_fares_id	=	right.ln_fares_id,
													tAppendCleanZip(left,right),
													keep(1),
													local
												);

// Normalize records by dates
rDeedMortgLoanDtNorm_layout	:=
record
	string12	ln_fares_id;
	string11	loan_amount	:=	'';
	string8		loan_date		:=	'';
	string5		zip;
	dDeedMortClean.first_td_loan_amount;        
	dDeedMortClean.second_td_loan_amount;
end;

rDeedMortgLoanDtNorm_layout	tNormLoanDate(dDeedMortClean	pInput,integer	cnt)	:=
transform
	self.loan_date	:=	choose(	cnt,
															pInput.recording_date,
															pInput.contract_date,
															pInput.arm_reset_date,
															pInput.first_td_due_date,
															pInput.fares_mortgage_date,
															pInput.fares_prior_recording_date,
															pInput.fares_prior_sales_date
														);
	self						:=	pInput;
end;

dDeedNormLoanDate	:=	normalize(dDeedMortClean,7,tNormLoanDate(left,counter));

// Normalize records by loan amounts
rDeedMortgNorm_layout	:=
record
	rDeedMortgLoanDtNorm_layout	and not [first_td_loan_amount,second_td_loan_amount];
end;

rDeedMortgNorm_layout	tNormLoanAmt(dDeedNormLoanDate	pInput,integer	cnt)	:=
transform
	self.loan_amount	:=	choose(cnt,pInput.first_td_loan_amount,pInput.second_td_loan_amount);
	self							:=	pInput;
end;

dDeedNormLoanAmt	:=	normalize(dDeedNormLoanDate,2,tNormLoanAmt(left,counter));

// Filter out records which don't have either zip or loan date or loan amount populated
dZipLoanAmt	:=	dDeedNormLoanAmt(			loan_amount	!=	''
																	and	loan_date		!=	''
																	and	zip					!=	''
																);

export key_deed_zip_loanamt := index(	dZipLoanAmt,
																			{zip,loan_amount,loan_date},
																			{ln_fares_id},
																			Data_Services.Data_location.Prefix('Property')+'thor_data400::key::ln_propertyV2::' + doxie.Version_SuperKey + '::deed.zip_loanamt'
																		);