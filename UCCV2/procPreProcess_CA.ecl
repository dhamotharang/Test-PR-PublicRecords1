import ut;

export procPreProcess_CA(string filedate) := function

dsDebtInput	   :=	UCCV2.File_CA_AllDebtors_In;
dsSecPrtyInput :=	UCCV2.File_CA_AllSecuredParty_in;
dsFileAdmInput :=	UCCV2.File_CA_FilingAmendments_in;
dsFileInput	   :=	UCCV2.File_CA_Filings_in;


UCCV2.Layout_File_CA_Filing_Master_in	trfFiling(UCCV2.Layout_File_CA_Filings_in	pInput)	:=	transform
	self.process_date						:=	filedate;
	self.initial_filing_number	:=	ut.CleanSpacesAndUpper(pInput.ucc1_num);
	self.ucc3_filing						:=	ut.CleanSpacesAndUpper(pInput.ucc3_num);
	self.ucc_filing_type_desc		:=	ut.CleanSpacesAndUpper(pInput.action_type);
	self.filing_type_id         :=  ut.CleanSpacesAndUpper(pInput.filing_type_id);
	self.filing_date						:=	Stringlib.StringFilterOut(pInput.filing_date_time[1..10], '-');	  //filter
	self.filing_time						:=	Stringlib.StringFilterOut(pInput.filing_date_time[12..16], ':');	//filter
	self.lapse_date							:=	Stringlib.StringFilterOut(pInput.lapse_date[1..10], '-');	
	self.page_count							:=	pInput.page_count;	
	//The vendor no longer sends the filing status.  The filing status is derived based on the lapse date
 	self.filing_status          :=  if(self.lapse_date > self.process_date,'A','L');

end;
	
FilingMasterIn						:=	project(dsFileInput,trfFiling(left));	
										 
FilingMaster							:=	output(FilingMasterIn,,'~thor_data400::in::uccv2::'+filedate+'::ca::initialfiling',overwrite);
AddSuperFiling						:=	fileservices.addsuperfile('~thor_data400::in::uccv2::ca::initialfiling','~thor_data400::in::uccv2::'+filedate+'::ca::initialfiling');
AddSuperFilingProcessed		:=	fileservices.addsuperfile('~thor_data400::in::uccv2::ca::initialfiling::processed','~thor_data400::in::uccv2::'+filedate+'::ca::initialfiling');

UCCV2.Layout_File_CA_BusinessDebtor_in	trfBusDebtor(UCCV2.Layout_File_CA_AllDebtors_in pInput)	:=	transform
	self.process_date						:=	filedate;
	self.initial_filing_number	:=	ut.CleanSpacesAndUpper(pInput.ucc1_num);
	self.filing_number	        :=	ut.CleanSpacesAndUpper(pInput.ucc3_num);
	self.bd_name								:=	ut.CleanSpacesAndUpper(pInput.org_name);
	self.bd_st_address					:=	ut.CleanSpacesAndUpper(pInput.addr1 + ' ' + pInput.addr2 + ' ' + pInput.addr3);
	self.bd_city								:=	ut.CleanSpacesAndUpper(pInput.city);
	self.bd_state								:=	ut.CleanSpacesAndUpper(pInput.state);
	self.bd_zip									:=	pInput.postal_code[1..5];
	self.bd_zip_extn						:=	Stringlib.StringFilterOut(pInput.postal_code[6..],'-');
	self.bd_country     				:=	ut.CleanSpacesAndUpper(pInput.country);
	self.prep_addr_line1				:=	ut.CleanSpacesAndUpper(pInput.addr1 + ' ' + pInput.addr2 + ' ' + pInput.addr3);
	self.prep_addr_last_line		:=	if(pInput.city != '',
																					ut.CleanSpacesAndUpper(trim(pInput.city) + ', ' + trim(pInput.state) + ' ' + trim(pInput.postal_code[1..5])),
																					ut.CleanSpacesAndUpper(trim(pInput.state) + ' ' + trim(pInput.postal_code[1..5]))
																			);	
end;
	
BusDebtorIn	:=	project(dsDebtInput(ut.CleanSpacesAndUpper(debtor_type) = 'ORGANIZATION'),trfBusDebtor(left));

BusDebtor										:=	output(BusDebtorIn,,'~thor_data400::in::uccv2::'+filedate+'::ca::businessdebtor',overwrite);
AddSuperBusDebtor						:=	fileservices.addsuperfile('~thor_data400::in::uccv2::ca::businessdebtor','~thor_data400::in::uccv2::'+filedate+'::ca::businessdebtor');
AddSuperBusDebtorProcessed	:=	fileservices.addsuperfile('~thor_data400::in::uccv2::ca::businessdebtor::processed','~thor_data400::in::uccv2::'+filedate+'::ca::businessdebtor');

UCCV2.Layout_File_CA_PersonDebtor_in	trfPerDebtor(UCCV2.Layout_File_CA_AllDebtors_in	pInput)	:=	transform
	self.process_date						:=	filedate;
	self.initial_filing_number	:=	ut.CleanSpacesAndUpper(pInput.ucc1_num);
	self.pd_last_name						:=	ut.CleanSpacesAndUpper(pInput.last_name);
	self.pd_first_name					:=	ut.CleanSpacesAndUpper(pInput.first_name);
	self.pd_middle_name					:=	ut.CleanSpacesAndUpper(pInput.middle_name);
	self.pd_suffix							:=	ut.CleanSpacesAndUpper(pInput.suffix);
	self.pd_st_address					:=	ut.CleanSpacesAndUpper(pInput.addr1 + ' ' + pInput.addr2 + ' ' + pInput.addr3);
	self.pd_city								:=	ut.CleanSpacesAndUpper(pInput.city);	
	self.pd_state								:=	ut.CleanSpacesAndUpper(pInput.state);
	self.pd_zip									:=	pInput.postal_code[1..5];
	self.pd_zip_extn						:=	if ((integer)Stringlib.StringFilterOut(pInput.postal_code[6..],'-') = 0,
																					'',
																					Stringlib.StringFilterOut(pInput.postal_code[6..],'-')
																			);
	self.pd_country    				  :=	ut.CleanSpacesAndUpper(pInput.country);		
	self.prep_addr_line1				:=	ut.CleanSpacesAndUpper(pInput.addr1 + ' ' + pInput.addr2 + ' ' + pInput.addr3);
	self.prep_addr_last_line		:=	if(pInput.city != '',
																					ut.CleanSpacesAndUpper(trim(pInput.city) + ', ' + trim(pInput.state) + ' ' + trim(pInput.postal_code[1..5])),
																					ut.CleanSpacesAndUpper(trim(pInput.state) + ' ' + trim(pInput.postal_code[1..5]))
																			);	
end;
	
PersonDebtorIn								:=	project(dsDebtInput(ut.CleanSpacesAndUpper(debtor_type) = 'INDIVIDUAL'),trfPerDebtor(left));

PersonDebtor									:=	output(PersonDebtorIn,,'~thor_data400::in::uccv2::'+filedate+'::ca::persondebtor',overwrite);
AddSuperPersonDebtor					:=	fileservices.addsuperfile('~thor_data400::in::uccv2::ca::persondebtor','~thor_data400::in::uccv2::'+filedate+'::ca::persondebtor');
AddSuperPersonDebtorProcessed	:=	fileservices.addsuperfile('~thor_data400::in::uccv2::ca::persondebtor::processed','~thor_data400::in::uccv2::'+filedate+'::ca::persondebtor');


UCCV2.Layout_File_CA_BusinessSecuredParty_in	trfBusSP(UCCV2.Layout_File_CA_AllSecuredParty_in	pInput)	:=	transform
	self.process_date						:=	filedate;
	self.initial_filing_number	:=	ut.CleanSpacesAndUpper(pInput.ucc1_num);
	self.bs_name								:=	ut.CleanSpacesAndUpper(pInput.org_name);
	self.bs_st_address					:=	ut.CleanSpacesAndUpper(pInput.addr1 + ' ' + pInput.addr2 + ' ' + pInput.addr3);
	self.bs_city								:=	ut.CleanSpacesAndUpper(pInput.city);
	self.bs_state								:=	ut.CleanSpacesAndUpper(pInput.state);
	self.bs_zip									:=	pInput.postal_code[1..5];
	self.bs_zip_extn						:=	if ((integer)Stringlib.StringFilterOut(pInput.postal_code[6..],'-') = 0,
																					'',
																					Stringlib.StringFilterOut(pInput.postal_code[6..],'-')
																			);
	self.bs_country				      :=	ut.CleanSpacesAndUpper(pInput.country);	
	self.prep_addr_line1				:=	ut.CleanSpacesAndUpper(pInput.addr1 + ' ' + pInput.addr2 + ' ' + pInput.addr3);
	self.prep_addr_last_line		:=	if(pInput.city != '',
																					ut.CleanSpacesAndUpper(trim(pInput.city) + ', ' + trim(pInput.state) + ' ' + trim(pInput.postal_code[1..5])),
																					ut.CleanSpacesAndUpper(trim(pInput.state) + ' ' + trim(pInput.postal_code[1..5]))
																			);	
end;
	
BusSPIn								:=	project(dsSecPrtyInput(ut.CleanSpacesAndUpper(secured_party_type) = 'ORGANIZATION'),trfBusSP(left));

BusinessSecuredp									:=	output(BusSPIn,,'~thor_data400::in::uccv2::'+filedate+'::ca::businesssecuredp',overwrite);
AddSuperBusinessSecuredp					:=	fileservices.addsuperfile('~thor_data400::in::uccv2::ca::businesssecuredp','~thor_data400::in::uccv2::'+filedate+'::ca::businesssecuredp');
AddSuperBusinessSecuredpProcessed	:=	fileservices.addsuperfile('~thor_data400::in::uccv2::ca::businesssecuredp::processed','~thor_data400::in::uccv2::'+filedate+'::ca::businesssecuredp');

UCCV2.Layout_File_CA_PersonSecuredParty_in	trfPerSP(UCCV2.Layout_File_CA_AllSecuredParty_in	pInput)	:=	transform
	self.process_date						:=	filedate;
	self.initial_filing_number	:=	ut.CleanSpacesAndUpper(pInput.ucc1_num);
	self.ps_last_name						:=	ut.CleanSpacesAndUpper(pInput.last_name);
	self.ps_first_name					:=	ut.CleanSpacesAndUpper(pInput.first_name);
	self.ps_middle_name					:=	ut.CleanSpacesAndUpper(pInput.middle_name);
	self.ps_suffix							:=	ut.CleanSpacesAndUpper(pInput.suffix);
	self.ps_st_address					:=	ut.CleanSpacesAndUpper(pInput.addr1 + ' ' + pInput.addr2 + ' ' + pInput.addr3);
	self.ps_city								:=	ut.CleanSpacesAndUpper(pInput.city);
	self.ps_state								:=	ut.CleanSpacesAndUpper(pInput.state);
	self.ps_zip									:=	pInput.postal_code[1..5];
	self.ps_zip_extn						:=	if ((integer)Stringlib.StringFilterOut(pInput.postal_code[6..],'-') = 0,
																					'',
																					Stringlib.StringFilterOut(pInput.postal_code[6..],'-')
																			);
	self.ps_country				      :=	ut.CleanSpacesAndUpper(pInput.country);
	self.prep_addr_line1				:=	ut.CleanSpacesAndUpper(pInput.addr1 + ' ' + pInput.addr2 + ' ' + pInput.addr3);
	self.prep_addr_last_line		:=	if(pInput.city != '',
																					ut.CleanSpacesAndUpper(trim(pInput.city) + ', ' + trim(pInput.state) + ' ' + trim(pInput.postal_code[1..5])),
																					ut.CleanSpacesAndUpper(trim(pInput.state) + ' ' + trim(pInput.postal_code[1..5]))
																			);	
end;
	
PerSPIn													:=	project(dsSecPrtyInput(ut.CleanSpacesAndUpper(secured_party_type) = 'INDIVIDUAL'),trfPerSP(left));

PersonSecuredp									:=	output(PerSPIn,,'~thor_data400::in::uccv2::'+filedate+'::ca::personsecuredp',overwrite);
AddSuperPersonSecuredp					:=	fileservices.addsuperfile('~thor_data400::in::uccv2::ca::personsecuredp','~thor_data400::in::uccv2::'+filedate+'::ca::personsecuredp');
AddSuperPersonSecuredpProcessed	:=	fileservices.addsuperfile('~thor_data400::in::uccv2::ca::personsecuredp::processed','~thor_data400::in::uccv2::'+filedate+'::ca::personsecuredp');

retval := if (fileservices.getsuperfilesubcount(Cluster.Cluster_In + 'in::uccv2::CA::AllDebtors') > 0       and
              fileservices.getsuperfilesubcount(Cluster.Cluster_In + 'in::uccv2::CA::AllSecuredParty') > 0  and
							fileservices.getsuperfilesubcount(Cluster.Cluster_In + 'in::uccv2::CA::FilingAmendments') > 0 and
							fileservices.getsuperfilesubcount(Cluster.Cluster_In + 'in::uccv2::CA::Filings') > 0,
								parallel(	sequential( FilingMaster
																,AddSuperFiling
																,AddSuperFilingProcessed
															),
										sequential( BusDebtor
																,AddSuperBusDebtor
																,AddSuperBusDebtorProcessed
															),
										sequential( PersonDebtor
																,AddSuperPersonDebtor
																,AddSuperPersonDebtorProcessed
															),
										sequential( BusinessSecuredp
																,AddSuperBusinessSecuredp
																,AddSuperBusinessSecuredpProcessed
															),	
										sequential( PersonSecuredp
																,AddSuperPersonSecuredp
																,AddSuperPersonSecuredpProcessed
															)																
										),
										output('No new files for CA'));

 
return retval;

end;