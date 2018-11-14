import std;	

	base := files.ds_ssi;
	base_layout := layout_ssi;
	
	layout_expanded := record(base_layout)
			integer8 primary_key;
			string currency_id;
			string clearer_office_id;
			string intermediary_office_id;
			string beneficiary_office_id;
			string clearer_routing_code_id;
			string intermediary_routing_code_id;
			string beneficiary_routing_code_id;
			string further_office_id;
			string further2_office_id;
			string further_routing_code_id;
			string further2_routing_code_id;
			string ssi_set_id;
			string currency_iso_code; // ssi/currency→/currency/isoCode
			string owner_tfpuid; // ssi/route/beneficiary/presence→/office/@tfpuid
			string owner_bic_code; // ssi/route/beneficiary/routingCodes/routingCode→ /routingCode[codeType="SWIFT BIC"]/codeValue
			string clearer_account_number;	
			string clearer_tfpuid; // ssi/route/clearer/presence→/office/@tfpuid
			string clearer_bic_code; // ssi/route/clearer/routingCodes/routingCode→ /routingCode[codeType="SWIFT BIC"]/codeValue
			string holder_tfpuid; // ssi/route/intermediary[1]/presence→/office/tfpuid
			string holder_bic_code; // ssi/route/intermediary[1]/routingCodes/routingCode→/routingCode[codeType='SWIFT BIC']/codeValue
			string holder_account_number; // ssi/route/intermediary[1]/accountNumbers/accountNumber
			string further_tfpuid;
			string further_bic_code;
			string further2_tfpuid;
			string further2_bic_code;
	end;

	
	layout_expanded xform_expand(base l, integer seq_count) :=  transform( layout_expanded, 
			self.primary_key := seq_count;
			self.currency_id := if(l.currency_link_href != '', std.str.splitwords(l.currency_link_href,'/')[3], '');
			self.clearer_office_id := if(count(l.route.clearer) > 0, std.str.splitwords(l.route.clearer[1].presence_link_href,'/')[3], '');
			self.intermediary_office_id := if(count(l.route.intermediary) > 0, std.str.splitwords(l.route.intermediary[1].presence_link_href,'/')[3], '');
			self.beneficiary_office_id := if(count(l.route.beneficiary) > 0, std.str.splitwords(l.route.beneficiary[1].presence_link_href,'/')[3], '');
			self.clearer_routing_code_id := if(count(l.route.clearer.routingCodes) > 0, if(l.route.clearer[1].routingCodes[1].link_href != '', std.str.splitwords(l.route.clearer[1].routingCodes[1].link_href,'/')[3], ''), '');
			self.intermediary_routing_code_id := if(count(l.route.intermediary.routingCodes) > 0, if(l.route.intermediary[1].routingCodes[1].link_href != '', std.str.splitwords(l.route.intermediary[1].routingCodes[1].link_href,'/')[3], ''), '');
			self.beneficiary_routing_code_id := if(count(l.route.beneficiary.routingCodes) > 0, if(l.route.beneficiary[1].routingCodes[1].link_href != '', std.str.splitwords(l.route.beneficiary[1].routingCodes[1].link_href,'/')[3], ''), '');											
			self.further_office_id	:= if(count(l.route.intermediary) > 0, std.str.splitwords(l.route.intermediary[2].presence_link_href,'/')[3], '');;
			self.further2_office_id := if(count(l.route.intermediary) > 0, std.str.splitwords(l.route.intermediary[3].presence_link_href,'/')[3], '');
			self.further_routing_code_id := if(count(l.route.intermediary.routingCodes) > 0, if(l.route.intermediary[1].routingCodes[2].link_href != '', std.str.splitwords(l.route.intermediary[2].routingCodes[1].link_href,'/')[3], ''), '');
			self.further2_routing_code_id := if(count(l.route.intermediary.routingCodes) > 0, if(l.route.intermediary[1].routingCodes[3].link_href != '', std.str.splitwords(l.route.intermediary[3].routingCodes[1].link_href,'/')[3], ''), '');
			self.ssi_set_id := if(l.set_link_href != '', std.str.splitwords(l.set_link_href,'/')[3], '');
			self.owner_tfpuid			:= '';
			self.owner_bic_code			:= '';
			self.clearer_account_number	:= if(count(l.route.clearer.accountNumber) > 0, l.route.clearer[1].accountNumber[1].value, '');
			self.clearer_tfpuid			:= '';
			self.clearer_bic_code		:= '';
			self.holder_tfpuid			:= '';
			self.holder_bic_code		:= '';
			self.holder_account_number	:= if(count(l.route.intermediary[1].accountNumber) > 0, l.route.intermediary[1].accountNumber[1].value, '');
			self.further_tfpuid			:= '';
			self.further_bic_code		:= '';
			self.further2_tfpuid		:= '';
			self.further2_bic_code		:= '';	
			self.currency_iso_code := '';
			self := l);	

	
	ssi_ds_expanded := project(base, xform_expand(left, counter));
															
	EXPORT file_ssi_flat := ssi_ds_expanded;														