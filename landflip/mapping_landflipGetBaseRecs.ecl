import ut
		 , _Validate
		 , LN_PropertyV2
		 , lib_stringlib
		 , landflip;
		 
string8 startdate := '' : stored('startdate');
string8 enddate := '' : stored('enddate');

layout_landflipDeedRec lTransformDeedToLandflip(LN_PropertyV2.layout_deed_mortgage_common_model_base pInput)
	:=
		TRANSFORM
			self.ln_fares_id						:=	pInput.ln_fares_id;
			self.vendor_source_flag			:=	CASE(pInput.vendor_source_flag, 
																					 'F' => 'FAR_F',
																					 'S' => 'FAR_S',
																					 'O' => 'OKCTY',
																					 'D' => 'DAYTN',
																					 'UNKN'
																					);
			self.fips_cd								:=	pInput.fips_code;
			self.state_cd								:=	pInput.state;
			self.cnty_cd								:=	pInput.fips_code[3..5];
			self.county_name						:=	pInput.county_name;
			//self.apn_num								:=	pInput.apnt_or_pin_number;
			self.apn_num								:=	pInput.fares_unformatted_apn;
			self.buyer									:=	lib_stringlib.StringLib.StringToUpperCase(pInput.name1);
			self.seller									:=	pInput.seller1;
			self.lender									:=	pInput.lender_name;
			self.loan_type_code					:=	pInput.first_td_loan_type_code;
			self.loan_type_desc					:=	''; //Maps to FARES_1080 description mortgage_loan_type_code
			//Convert dates with 'days' values of '00' to '01' and use contract date if it is a valid date, otherwise, use the recording date.
			self.transfer_dt						:=	IF(_Validate.Date.fIsValid(REGEXREPLACE('00$', pInput.contract_date,'01')),
																				//AND (unsigned4)REGEXREPLACE('00$', pInput.contract_date,'01') > (unsigned4)REGEXREPLACE('00$', pInput.recording_date,'01'),
																				REGEXREPLACE('00$', pInput.contract_date,'01'),
																				REGEXREPLACE('00$', pInput.recording_date,'01')
																				); //Filter out blank dates later
			self.transfer_value					:=	pInput.sales_price;
			self.str_info								:=	TRIM(pInput.property_full_street_address) +
																			TRIM(' ' + pInput.property_address_unit_number);
			self.str_city								:=	REGEXFIND('^([A-Za-z ][^\\,]+)[\\,]', pInput.property_address_citystatezip, 1);
			self.str_zip9								:=	REGEXFIND('[0-9]{5}(-[0-9]{4})?', pInput.property_address_citystatezip, 0);
			self.owner_mail_addr				:=	TRIM(TRIM(pInput.mailing_street, RIGHT, LEFT) +
																			TRIM(' ' + pInput.mailing_unit_number, RIGHT, LEFT) +
																			TRIM(' ' + pInput.mailing_csz, RIGHT, LEFT), RIGHT, LEFT);
			self.title_company_name			:=	pInput.title_company_name;
			self.snd_buyer							:=	pInput.name2;
			self.foreclosure_flag				:=	IF(pInput.document_type_code = 'U' OR pInput.document_type_code = 'FC',
																				 'Y',
																				 IF(pInput.document_type_code != '', 'N', '')
																			  ); //If document_type_code = 'U' then it is a forclosure
			self.muni_cd								:=	pInput.legal_city_municipality_township;
		END
		;

layout_landflipDeedAddlRec lTransformAddlDeedToLandflipAddl(LN_PropertyV2.File_addl_fares_deed pInput)
	:=
		TRANSFORM
			self.addl_ln_fares_id				:=	pInput.ln_fares_id;
			self.transfer_type					:=	pInput.fares_transaction_type;
			self.transfer_type_desc			:=	''; //Maps to FARES_1080 description transaction_type
			self.addl_foreclosure_flag	:=	pInput.fares_foreclosure;
		END
		;

pLandflipRec := PROJECT(LN_PropertyV2.File_Deed, lTransformDeedToLandflip(left));

pLandflipAddlRec := PROJECT(LN_PropertyV2.File_addl_fares_deed, lTransformAddlDeedToLandflipAddl(left));

//For testing purposes, only get records from Palm Beach County (fips 12099)
//isInPBC	:=	pLandflipRec.fips_cd = '32400';
//isInPBC	:=	pLandflipRec.state_cd = 'NV';
//isTestFilter := pLandflipRec.fips_cd = '39017';
isTestFilter := pLandflipRec.ln_fares_id = 'RD0746586253'
             OR pLandflipRec.ln_fares_id = 'RD0754767208';

//Only get records from 2008Q1 (3/31/08 - 180 days)							 
isInDateRange	:=	(unsigned4)pLandflipRec.transfer_dt >= (unsigned4)startdate
							AND (unsigned4)pLandflipRec.transfer_dt <= (unsigned4)enddate;


//Filter out "junk" records
isValidKeyFields :=	TRIM(pLandflipRec.apn_num, ALL) != ''
                    //AND (unsigned4)pLandflipRec.apn_num != 0 - Redundant use with REGEXREPLACE filter
										//AND (unsigned4)pLandflipRec.apn_num > 0 - Does not work with apn with leading alpha chars
										AND REGEXREPLACE('0', pLandflipRec.apn_num, '') != ''
										AND pLandflipRec.str_info != '';
										

//Create Landflip Deed recordset based on filters
rsLandflipRec	:=	pLandflipRec(_Validate.Date.fIsValid(pLandflipRec.transfer_dt)
                                            AND isInDateRange
																						AND isValidKeyFields
																						//AND isTestFilter
																					 );
																					 
//Distribute Landflip Deed recordset across the nodes based on the hash of the ln_fares_id																					 
rsLandflipRecDist	:=	DISTRIBUTE(rsLandflipRec,HASH(ln_fares_id));

//Only use record if the transaction_type is 1, 01, or 001											
isValidTransType	:=	(unsigned2)pLandflipAddlRec.transfer_type = 1;
											
//Create Landflip Addl Deed recordset based on filters
rsLandflipAddlDeed	:=	pLandflipAddlRec(isValidTransType);							

//Distribute Landflip Addl Deed recordset across the nodes based on the hash of the ln_fares_id
rsLandflipAddlDeedDist	:=	DISTRIBUTE(rsLandflipAddlDeed, HASH(addl_ln_fares_id));

//Create a transformation to join the Deed and AddlDeed landflip data
layout_landflipBaseRec tLandflipDeedAddlDeed (rsLandflipRec pDeed, rsLandflipAddlDeed pAddlDeed) := transform
	self	:=	pDeed;
	self	:=	pAddlDeed;
end;

//Now join the records based on the ln_fares_id
rsLandflipBase := JOIN(rsLandflipRecDist,
											 rsLandflipAddlDeedDist,
					             left.ln_fares_id = right.addl_ln_fares_id,
					             tLandflipDeedAddlDeed(left, right),
											 local
					            );

//Lookup loan_type_desc
ut.Mac_Convert_Codes_To_Desc(rsLandflipBase,layout_landflipBaseRec,rsLandflipBaseAlltmp,'FARES_1080',
																					'MORTGAGE_LOAN_TYPE_CODE',loan_type_desc,
																					loan_type_code,vendor_source_flag,true);
																					
//Lookup transfer_type_desc
ut.Mac_Convert_Codes_To_Desc(rsLandflipBaseAlltmp,layout_landflipBaseRec,rsLandflipBaseAll,'FARES_1080',
																					'TRANSACTION_TYPE',transfer_type_desc,
																					transfer_type,vendor_source_flag,true);
																				
EXPORT mapping_landflipGetBaseRecs	:=	rsLandflipBaseAll;