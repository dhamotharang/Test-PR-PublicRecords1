	use_record := record
		string use_value {xpath('./')};
		string use_abbreviation {xpath('./@abbreviation')};
	end;

	layout_usage := record
		string usage_all 	{xpath('@all')};
		dataset(use_record) use_type 	{xpath('use')};
	end;

	routing_code := record
		string link_href {xpath('link/@href')};
		string link_rel {xpath('link/@rel')};
	end;

	account_number := record
		string type {xpath('type')};
		string value {xpath('value')};
	end;

	layout_clearer := record
		string step {xpath('@step')};
		string presence_link_href {xpath('presence/link/@href')};
		string presence_link_rel {xpath('presence/link/@rel')};
		dataset(routing_code) routingCodes {xpath('routingCodes/routingCode')};
		dataset(account_number) accountNumber {xpath('accountNumbers/accountNumber')};
		string routeType {xpath('routeType')};
	end;

	layout_intermediary := record
		string step {xpath('@step')};
		string presence_link_href {xpath('presence/link/@href')};
		string presence_link_rel {xpath('presence/link/@rel')};
		dataset(routing_code) routingCodes {xpath('routingCodes/routingCode')};
		dataset(account_number) accountNumber {xpath('accountNumbers/accountNumber')};
		string routeType {xpath('routeType')};
	end;

	layout_beneficiary := record
		string step {xpath('@step')};
		string presence_link_href {xpath('presence/link/@href')};
		string presence_link_rel {xpath('presence/link/@rel')};
		dataset(routing_code) routingCodes {xpath('routingCodes/routingCode')};
		string routeType {xpath('routeType')};
	end;

	layout_route := record
		dataset(layout_clearer) clearer {xpath('clearer')};
		dataset(layout_intermediary) intermediary {xpath('intermediary')};
		dataset(layout_beneficiary) beneficiary {xpath('beneficiary')};
	end;

	layout_extends_ssi := record
		string ssi_link_href {xpath('ssi/link/@href')};
		string ssi_link_rel {xpath('ssi/link/@rel')};
	end;

	export layout_ssi := record
		string deleted {xpath('@deleted')};
		string fid {xpath('@fid')};
		string id {xpath('@id')};
		string resource {xpath('@resource')};
		string source {xpath('@source')};
		string created_on_date {xpath('md:ResourceMetadata/@md:CreatedOn')};
		string deleted_on_date {xpath('md:ResourceMetadata/@md:DeletedOn')};
		string set_link_href {xpath('set/link/@href')};
		string set_link_rel {xpath('set/link/@rel')};
		string currency_link_href  {xpath('currency/link/@href')};
		string currency_link_rel   {xpath('currency/link/@rel')};	
		string status	 {xpath('status')};		
		string correspondentType {xpath('correspondentType')};
		string preferred   {xpath('preferred')};
		string additional_info {xpath('additionalInfo')};
		layout_usage usage {xpath('usage')};
		layout_route route {xpath('route')};
		layout_extends_ssi extendsSSI {xpath('extendsSSI')};
		layout_extends_ssi extendedBySSI {xpath('extendedBySSI')};
	end;
	
