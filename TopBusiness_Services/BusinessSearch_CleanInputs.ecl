import address,TopBusiness,TopBusiness_Search,ut;

export BusinessSearch_CleanInputs(dataset(BusinessSearch_Layouts.Input) inds) := module

	export dataset(TopBusiness_Search.InputLayout) Compare := function

		tempcleaned := project(inds,
			transform(TopBusiness_Search.InputLayout,
				self.acctno := left.acctno,
				self.company_name := stringlib.StringToUpperCase(left.company_name),
				self.clean_company_name := stringlib.StringToUpperCase(left.company_name),
				self.fein := stringlib.StringFilter(left.tin,'0123456789'),
				self.llid9 := (unsigned6)stringlib.StringFilter(left.llid9,'0123456789'),
				self.llid12 := (unsigned6)stringlib.StringFilter(left.llid12,'0123456789'),
				self.street := stringlib.StringToUpperCase(left.addr),
				tempaddress := address.CleanAddressFieldsFips(address.CleanAddress182(left.addr,left.city + ' ' + left.state + ' ' + left.zip)).addressrecord;
				self.city := stringlib.StringToUpperCase(left.city),
				self.state := stringlib.StringToUpperCase(left.state),
				self.zip := stringlib.StringFilter(left.zip,'0123456789'),
				self.truecity := left.city,
				self.truestate := left.state,
				self.truezip := left.zip,
				self := tempaddress,
				self.phone_number := stringlib.StringFilter(left.phone10,'0123456789'),
				self.radius := (unsigned2)left.radius,
				self.url := left.url,
				self.email_address := stringlib.StringToUpperCase(left.email_address),
				self.last_name := stringlib.StringToUpperCase(left.last_name),
				self.first_name := stringlib.StringToUpperCase(left.first_name),
				self.middle_name := stringlib.StringToUpperCase(left.middle_name),
				self.sic := stringlib.Stringfilter(left.sic,'0123456789'),
				self.ph_phrase := '',
				self.phrase := '',
				self.cleanurl := ''));

		pattern p_nodot := pattern('[^ .]');
		pattern p_prefix_part := (p_nodot+) before('.');
		pattern p_prefix := (p_prefix_part '.')+;
		pattern p_us_suffix := 'gov' or 'com' or 'net' or 'edu' or 'org' or 'mil' or 'info' or 'coop' or 'biz' or 'aero' or 'int';
		pattern p_us_state :=
			'ak' or 'hi' or 'ca' or 'wa' or 'or' or 'id' or 'nv' or 'az' or 'nm' or 'co' or 'ut' or 'wy' or 'mt' or
			'me' or 'vt' or 'nh' or 'ma' or 'ct' or 'ri' or 'ny' or 'nj' or 'pa' or 'md' or 'de' or 'va' or 'wv' or
			'nc' or 'sc' or 'ga' or 'fl' or 'oh' or 'mi' or 'ky' or 'tn' or 'al' or 'ms' or 'la' or 'ar' or 'mo' or
			'in' or 'il' or 'wi' or 'mn' or 'nd' or 'sd' or 'ia' or 'ne' or 'ok' or 'tx' or 'dc' or 'ks';
		pattern p_us_state_suffix := (('k12.' p_us_state) or (p_us_state penalty(10))) '.us';
		pattern p_us := p_us_suffix or p_us_state_suffix;
		pattern p_intl_suffix := p_us_suffix or 'co' or 'ac';
		pattern p_intl_cc := 'eu' or 'yu' or 'su' or 'uk' or 'ad' or 'ae' or 'af' or 'ag' or 'ai' or 'al' or 'am' or 'ao' or 'aq' or 'ar' or 'as' or 'at' or 'au' or 'aw' or 'ax' or 'az' or 'ba' or 'bb' or 'bd' or 'be' or 'bf' or 'bg' or 'bh' or 'bi' or 'bj' or 'bl' or 'bm' or 'bn' or 'bo' or 'bq' or 'br' or 'bs' or 'bt' or 'bv' or 'bw' or 'by' or 'bz' or 'ca' or 'cc' or 'cd' or 'cf' or 'cg' or 'ch' or 'ci' or 'ck' or 'cl' or 'cm' or 'cn' or 'co' or 'cr' or 'cu' or 'cv' or 'cw' or 'cx' or 'cy' or 'cz' or 'de' or 'dj' or 'dk' or 'dm' or 'do' or 'dz' or 'ec' or 'ee' or 'eg' or 'eh' or 'er' or 'es' or 'et' or 'fi' or 'fj' or 'fk' or 'fm' or 'fo' or 'fr' or 'ga' or 'gb' or 'gd' or 'ge' or 'gf' or 'gg' or 'gh' or 'gi' or 'gl' or 'gm' or 'gn' or 'gp' or 'gq' or 'gr' or 'gs' or 'gt' or 'gu' or 'gw' or 'gy' or 'hk' or 'hm' or 'hn' or 'hr' or 'ht' or 'hu' or 'id' or 'ie' or 'il' or 'im' or 'in' or 'io' or 'iq' or 'ir' or 'is' or 'it' or 'je' or 'jm' or 'jo' or 'jp' or 'ke' or 'kg' or 'kh' or 'ki' or 'km' or 'kn' or 'kp' or 'kr' or 'kw' or 'ky' or 'kz' or 'la' or 'lb' or 'lc' or 'li' or 'lk' or 'lr' or 'ls' or 'lt' or 'lu' or 'lv' or 'ly' or 'ma' or 'mc' or 'md' or 'me' or 'mf' or 'mg' or 'mh' or 'mk' or 'ml' or 'mm' or 'mn' or 'mo' or 'mp' or 'mq' or 'mr' or 'ms' or 'mt' or 'mu' or 'mv' or 'mw' or 'mx' or 'my' or 'mz' or 'na' or 'nc' or 'ne' or 'nf' or 'ng' or 'ni' or 'nl' or 'no' or 'np' or 'nr' or 'nu' or 'nz' or 'om' or 'pa' or 'pe' or 'pf' or 'pg' or 'ph' or 'pk' or 'pl' or 'pm' or 'pn' or 'pr' or 'ps' or 'pt' or 'pw' or 'py' or 'qa' or 're' or 'ro' or 'rs' or 'ru' or 'rw' or 'sa' or 'sb' or 'sc' or 'sd' or 'se' or 'sg' or 'sh' or 'si' or 'sj' or 'sk' or 'sl' or 'sm' or 'sn' or 'so' or 'sr' or 'ss' or 'st' or 'sv' or 'sx' or 'sy' or 'sz' or 'tc' or 'td' or 'tf' or 'tg' or 'th' or 'tj' or 'tk' or 'tl' or 'tm' or 'tn' or 'to' or 'tr' or 'tt' or 'tv' or 'tw' or 'tz' or 'ua' or 'ug' or 'um' or 'us' or 'uy' or 'uz' or 'va' or 'vc' or 've' or 'vg' or 'vi' or 'vn' or 'vu' or 'wf' or 'ws' or 'ye' or 'yt' or 'za' or 'zm' or 'zw';
		pattern p_intl := (p_intl_suffix '.' p_intl_cc) or ((p_intl_cc) penalty(10));
		pattern p_suffix := (p_us or p_intl) before('/' or '.' or last);
		pattern p_domain := p_nodot+ '.' p_suffix;
		pattern p_url := opt(p_prefix) p_domain;
		pattern p_ip_node := pattern('[0-9]') or pattern('[1-9][0-9]') or pattern('1[0-9][0-9]') or pattern('2[0-4][0-9]') or pattern('25[0-5]');
		pattern p_ip := p_ip_node '.' p_ip_node '.' p_ip_node '.' p_ip_node;
		pattern p_rest := pattern('.')+;
		pattern p_path := '/' opt(p_rest);
		pattern p_domain_find := (first (((p_url or p_ip) opt(p_path)) or (p_rest penalty(80))) last) or (first last);

		TopBusiness_Search.InputLayout parseTransform(tempcleaned l) := transform
			self.cleanurl := map(
				matchtext(p_domain) != '' => matchtext(p_domain),
				matchtext(p_ip) != '' => matchtext(p_ip),
				l.url = '' => '',
				trim(l.url) + '.'); // incomplete domain... add the period to ensure that we at least don't get searches for a*
			self := l;
		end;

		tempparse := dedup(parse(tempcleaned,trim(url),p_domain_find,parseTransform(left),best),record,all);
		
		return tempparse;
		
	end;
	
	export dataset(TopBusiness_Search.InputLayout) Search := function
	
		TopBusiness.Macro_CleanCompanyName(Compare,company_name,clean_company_name,CleanedCompare0);
		
		CleanedCompare := Compare + CleanedCompare0;
		
		// We need to clean the address in order to ensure that, among other things, city is spelled right.
		// Example is N AGUSTA SC will clean to N AUGUSTA SC.
		fn_clean(string in_street,string in_city,string in_state,string in_zip) :=
			address.CleanAddressFieldsFips(address.CleanAddress182(in_street,trim(in_city) + ', ' + trim(in_state) + ' ' + trim(in_zip)));
			
		fn_state(string in_street,string in_city,string in_state,string in_zip) := map(
			fn_clean(in_street,in_city,in_state,in_zip).st != '' => fn_clean(in_street,in_city,in_state,in_zip).st,
			in_state != '' => in_state,
			ziplib.ZipToState2(in_zip));
		
		fn_city(string in_street,string in_city,string in_state,string in_zip) := map(
			fn_clean(in_street,in_city,in_state,in_zip).p_city_name != '' => fn_clean(in_street,in_city,in_state,in_zip).p_city_name,
			in_city);
			
		addnewstuff := project(CleanedCompare,
			transform({recordof(left);string newst;string newcity;set of integer4 newzipset},
				temp_clean := address.CleanAddressFieldsFips(address.CleanAddress182(left.street,trim(left.city) + ', ' + trim(left.state) + ' ' + trim(left.zip)));
				self.newst := map(
					temp_clean.st != '' => temp_clean.st,
					left.state != '' => left.state,
					ziplib.ZipToState2(left.zip));
				self.newcity := map(
					temp_clean.p_city_name != '' => temp_clean.p_city_name,
					left.city);
				self.newzipset := ut.ZipsWithinCity(self.newst,self.newcity),
				self := left));
		
		normalized_address_1 := normalize(
			addnewstuff,
			if(left.state != '' and left.city != '',count(dataset(left.newzipset,{integer4 zip})),0) + 1,
			transform(TopBusiness_Search.InputLayout,
				self.zip := choose(counter,
					left.zip,
					intformat(dataset(left.newzipset,{integer4 zip})[counter - 1].zip,5,1)),
				self.state := left.newst,
				self.city := left.newcity,
				self := left));
		
		zip_radius_pairs := dedup(normalized_address_1(zip != '' and radius != 0),zip,radius,all);
		
		tempzipcodelistrec := record
			normalized_address_1;
			dataset({integer4 zip}) zipcodes {maxcount(2048)};
		end;
		
		zip_radius_codes := project(zip_radius_pairs,
			transform(tempzipcodelistrec,
				self.zipcodes := dataset(ziplib.ZipsWithinRadius(left.zip,(real)left.radius),{integer4 zip}),
				self := left));
		
		normalized_codes := normalize(zip_radius_codes,
			count(left.zipcodes),
			transform({zip_radius_codes.zip,zip_radius_codes.radius,string5 newzip},
				self.newzip := intformat(left.zipcodes[counter].zip,5,1),
				self := left));
		
		normalized_add_codes := join(normalized_address_1,normalized_codes,
			left.zip = right.zip and
			left.radius = right.radius,
			transform(recordof(left),
				self.zip := right.newzip,
				self := left));
		
		dedup_normalized_address := dedup(normalized_add_codes,all);
		
		add_correct_state := project(dedup_normalized_address,
			transform(recordof(left),
				self.state := ziplib.ZipToState2(left.zip),
				self := left));
		
		rededup := dedup(normalized_address_1(zip = '' or radius = 0) + add_correct_state,all);
		
		return rededup;
	
	end;
		
end;
