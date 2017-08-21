IMPORT ut;

layout_landflipFORec lTransformProcessedFlipsToBase(mapping_landflipProcessBaseRecs pInput)
	:=
		TRANSFORM
			self.state_cd										:=	pInput.leftrec.state_cd;
			self.cnty_cd										:=	pInput.leftrec.cnty_cd;
			self.county_name								:=	pInput.leftrec.county_name;
			self.apn_num										:=	pInput.leftrec.apn_num;
			self.buyer											:=	pInput.leftrec.buyer;
			self.seller											:=	pInput.leftrec.seller;
			self.lender											:=	pInput.leftrec.lender;
			self.loan_type_code							:=	pInput.leftrec.loan_type_code;
			self.loan_type_desc							:=	pInput.leftrec.loan_type_desc;
			self.transfer_dt								:=	pInput.leftrec.transfer_dt;
			self.transfer_days							:=	'';
			self.transfer_type							:=	pInput.leftrec.transfer_type;
			self.transfer_type_desc					:=	pInput.leftrec.transfer_type_desc;
			self.transfer_value							:=	pInput.leftrec.transfer_value;
			self.diff_amt										:=	'';
			self.diff_percent								:=	'';
			self.str_info										:=	pInput.leftrec.str_info;
			self.str_city										:=	pInput.leftrec.str_city;
			self.str_zip9										:=	pInput.leftrec.str_zip9;
			self.str_carrier_rt							:=	'';
			self.owner_mail_addr						:=	pInput.leftrec.owner_mail_addr;
			self.title_company_name					:=	pInput.leftrec.title_company_name;
			self.snd_buyer									:=	pInput.leftrec.snd_buyer;
			self.third_buyer								:=	'';
			self.fourth_buyer								:=	'';
			self.foreclosure_flag						:=	pInput.leftrec.foreclosure_flag;
			self.field_office								:=	'';
			self.muni_cd										:=	pInput.leftrec.muni_cd;
		END
	;

layout_landflipFORec lTransformProcessedFlipsToFlipped(mapping_landflipProcessBaseRecs pInput)
	:=
		TRANSFORM
			self.state_cd										:=	pInput.rightrec.state_cd;
			self.cnty_cd										:=	pInput.rightrec.cnty_cd;
			self.county_name								:=	pInput.rightrec.county_name;
			self.apn_num										:=	pInput.rightrec.apn_num;
			self.buyer											:=	pInput.rightrec.buyer;
			self.seller											:=	pInput.rightrec.seller;
			self.lender											:=	pInput.rightrec.lender;
			self.loan_type_code							:=	pInput.rightrec.loan_type_code;
			self.loan_type_desc							:=	pInput.rightrec.loan_type_desc;
			self.transfer_dt								:=	pInput.rightrec.transfer_dt;
			self.transfer_days							:=	MAP(
																							ut.DaysApart(pInput.rightrec.transfer_dt, pInput.leftrec.transfer_dt)	=	0 =>	'0',
																							ut.DaysApart(pInput.rightrec.transfer_dt, pInput.leftrec.transfer_dt)	BETWEEN 1 AND 30		=> '30',
																							ut.DaysApart(pInput.rightrec.transfer_dt, pInput.leftrec.transfer_dt)	BETWEEN 31 AND 60		=> '60',
																							ut.DaysApart(pInput.rightrec.transfer_dt, pInput.leftrec.transfer_dt)	BETWEEN 61 AND 180	=> '180',
																							'UNK'
																						 );
			self.transfer_type							:=	pInput.rightrec.transfer_type;
			self.transfer_type_desc					:=	pInput.rightrec.transfer_type_desc;
			self.transfer_value							:=	pInput.rightrec.transfer_value;
			self.diff_amt										:=	(string)((unsigned4)pInput.rightrec.transfer_value - (unsigned4)pInput.leftrec.transfer_value);
			self.diff_percent								:=	(string)ROUND((((unsigned4)pInput.rightrec.transfer_value - (unsigned4)pInput.leftrec.transfer_value)*100/(unsigned4)pInput.leftrec.transfer_value));
			self.str_info										:=	pInput.rightrec.str_info;
			self.str_city										:=	pInput.rightrec.str_city;
			self.str_zip9										:=	pInput.rightrec.str_zip9;
			self.str_carrier_rt							:=	'';
			self.owner_mail_addr						:=	pInput.rightrec.owner_mail_addr;
			self.title_company_name					:=	pInput.rightrec.title_company_name;
			self.snd_buyer									:=	pInput.rightrec.snd_buyer;
			self.third_buyer								:=	'';
			self.fourth_buyer								:=	'';
			self.foreclosure_flag						:=	pInput.rightrec.foreclosure_flag;
			self.field_office								:=	'';
			self.muni_cd										:=	'';
		END
	;

pLandflipBaseRec 		:=	PROJECT(mapping_landflipProcessBaseRecs, lTransformProcessedFlipsToBase(left));
pLandflipFlippedRec :=	PROJECT(mapping_landflipProcessBaseRecs, lTransformProcessedFlipsToFlipped(left));

rsLandflipBaseFlippedCombo		:=	pLandflipBaseRec + pLandflipFlippedRec;

rsFieldOfficeLookup	:= File_FieldOfficeLookup;

layout_landflipFORec tlandflipJoinFieldOffice (rsLandflipBaseFlippedCombo pFlip, rsFieldOfficeLookup pLkp) := transform
	self.field_office	:=	pLkp.field_office;
	self	:=	pFlip;
end;

rsLandflipBaseFlippedFieldOffice	:=	JOIN(rsLandflipBaseFlippedCombo, rsFieldOfficeLookup,
   																						left.state_cd = right.state_cd AND left.cnty_cd = right.cnty_cd,
   																						tlandflipJoinFieldOffice(left, right),
   																						left outer,
   																						lookup
                                             );
																						 
rsLandflipFieldOfficeRecs	:=	SORT(rsLandflipBaseFlippedFieldOffice, state_cd, cnty_cd, apn_num, transfer_dt, diff_amt);

EXPORT mapping_landflipFORecs := rsLandflipFieldOfficeRecs;