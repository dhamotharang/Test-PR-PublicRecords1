IMPORT iesp, AutoStandardI, UPS_Services;

BOOLEAN fetchHeader := false;
BOOLEAN doRollup := false;

inputName := ROW( { '', // string62 Full {xpath('Full')}
										'JEFFERY', // string20 First {xpath('First')}
										'', // string20 Middle {xpath('Middle')}
										'WOODS', // string20 Last {xpath('Last')}
										'', // string5 Suffix {xpath('Suffix')}
										'', // string3 Prefix {xpath('Prefix')}
										'' }, // string120 CompanyName {xpath('CompanyName')}
	iesp.share.t_NameAndCompany);

inputAddr := ROW( { 'DAVID', // string28 StreetName {xpath('StreetName')};
										'945', // string10 StreetNumber {xpath('StreetNumber')};
										'', // string2 StreetPreDirection {xpath('StreetPreDirection')};
										'', // string2 StreetPostDirection {xpath('StreetPostDirection')};
										'TRCE', // string4 StreetSuffix {xpath('StreetSuffix')};
										'', // string10 UnitDesignation {xpath('UnitDesignation')};
										'', // string8 UnitNumber {xpath('UnitNumber')};
										'', // string60 StreetAddress1 {xpath('StreetAddress1')};
										'', // string60 StreetAddress2 {xpath('StreetAddress2')};
										'GA', // string2 State {xpath('State')};
										'SUWANEE', // string25 City {xpath('City')};
										'30024', // string5 Zip5 {xpath('Zip5')};
										'', // string4 Zip4 {xpath('Zip4')};
										'', // string18 County {xpath('County')};
										'', // string9 PostalCode {xpath('PostalCode')};
										'' }, // string50 StateCityZip {xpath('StateCityZip')};
	iesp.share.t_Address);

inputPhone := '7708863306';

iesp.ECL2ESP.setInputName(inputName);
iesp.ECL2ESP.setInputAddress(inputAddr);
#stored('phone', inputPhone);
#stored('MaxResults', 100);

mod := AutoStandardI.GlobalModule();
search_inputs := project(mod, UPS_Services.IF_PartialMatchSearchParams, opt);
dids := CHOOSEN(UPS_Services.mod_PartialMatch(search_inputs).records, 30);
output(dids);

#IF(fetchHeader)
commonLayout := UPS_Services.layout_Common;
commonLayout toCommonLayout(dids L, doxie.key_header R) := TRANSFORM
	SELF.rollup_key := R.did;
	SELF.rollup_key_type := 'did';
	
	SELF.state := R.st;
	
	SELF.score_phone := 0;
	SELF.score_name := 0;
	SELF.score_addr := 0;

	SELF.company_name := '';
	
	SELF := R;
END;

hdr_recs := JOIN(dids, doxie.key_header, LEFT.did = RIGHT.s_did, toCommonLayout(LEFT, RIGHT), KEYED);
// output(hdr_recs);

score_inputs := PROJECT(mod, UPS_Services.mod_Score.params);
scored_recs := UPS_Services.mod_Score.score_records(score_inputs, hdr_recs);
output(scored_recs);

#IF(doRollup)

roll_params := MODULE(UPS_Services.mod_Rollup.params)
	export nameQueryInputs := inputName;
	export addrQueryInputs := inputAddr;
	export phoneQueryInput := inputPhone;
END;

rolled_recs := UPS_Services.mod_Rollup.roll(roll_params, scored_recs);
output(rolled_recs);
#END
#END