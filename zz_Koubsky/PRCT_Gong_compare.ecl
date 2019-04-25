// EXPORT PRCT_Gong_compare := 'todo';

in_filename := '~nkoubsky::prct::in::person_entity_20170724_csv';
		
in_layout := record
		STRING DID;
		STRING link_dob;
		STRING link_ssn;
		STRING fname;
		STRING mname;
		STRING lname;
		STRING suffix;
		STRING dob;
		STRING ssn;
		STRING addr1;
		STRING addr2;
		STRING city;
		STRING st;
		STRING zip;
		STRING src;
		STRING phone;
		STRING date_first_reported;
		STRING date_last_reported;
		STRING date_first_seen;
		STRING date_last_seen;
		STRING per_order;
end;

in_file := dataset(in_filename, in_layout, csv(heading(1)));
debug_set := [
								'146734588',
								'1473236086',
								'147633844',
								'1509142832',
								'151023895',
								'152317056',
								'15257774',
								'1556744741',
								'1586579531',
								'1048522770',
								'1621019765',
								'1648015016',
								'1059083200',
								'1713024148',
								'1735227865',
								'1743621396',
								'1763605391',
								'1798704094',
								'181713882',
								'1863406392',
								'1872652977',
								'187449752',
								'1878621168',
								'1907736003',
								'1917204230',
								'1922325835',
								'1945508909',
								'1996465276',
								'2011547144',
								'2054767868',
								'2084267602',
								'2093405892',
								'2095196233',
								'1105522006',
								'2130191913',
								'2138058936',
								'2186319820',
								'2290424416',
								'2340999923',
								'2399877503',
								'2404331914',
								'2479831942',
								'2498062082',
								'2517040800',
								'2542876464',
								'2549031434',
								'2559074065',
								'2651867881',
								'2675851350',
								'2764003810',
								'2779676898',
								'2806390210',
								'2896688847',
								'2911236922',
								'2922846212',
								'2946363499',
								'3036383608',
								'1167717862',
								'3098719869',
								'3152255608',
								'3166583703',
								'3209646797',
								'3214107743',
								'3248452191',
								'3281369221',
								'3315444904',
								'3356499515',
								'3377310547',
								'3378518346',
								'1204613243',
								'3437693246',
								'3441452436',
								'3460762287',
								'3557801766',
								'3588836576',
								'3609249844',
								'3632941689',
								'3647686186',
								'1214315958',
								'3668081861',
								'3698780170',
								'1028563471',
								'3748673817',
								'1261541407',
								'3826196460',
								'3843363262',
								'3857935594',
								'1268271518',
								'3877825280',
								'39058186',
								'3907437257',
								'3911122558',
								'3962204777',
								'4009148627',
								'402218271',
								'4031640054',
								'4047201307',
								'4100969252',
								'4114703238',
								'129657512',
								'4123819180',
								'4136102027',
								'4141851851',
								'4142327849',
								'4175945720',
								'4193209077',
								'425691592',
								'1305944530',
								'454761668',
								'489181928',
								'1319413063',
								'539751604',
								'557519960',
								'567702846',
								'573319075',
								'581043330',
								'587293601',
								'592275790',
								'624172454',
								'626725692',
								'642022764',
								'661493843',
								'675849281',
								'715821083',
								'133998112',
								'790234136',
								'814916930',
								'826260945',
								'1366589813',
								'854098332',
								'857871297',
								'873463902',
								'878354874',
								'891309272',
								'908981568',
								'909910921',
								'924606596',
								'1379164479',
								'952406855',
								'961600344',
								'997689441',
								'1400429940',
								'1035236703',
								'1441726837'];
								
in_file_phones := distribute(in_file(trim(phone, all) <> '' and DID in debug_set), (integer) phone);
output(count(in_file), named('in_file_count'));
output(in_file, named('in_file'));
output(count(in_file_phones), named('in_file_phones_count'));
output(in_file_phones, named('in_file_phones'));

gong_key := distribute(Gong.Key_History_phone, (integer) phone10);
gong_key_current := gong_key(dt_last_seen[1..4] >= '2010' or current_record_flag = 'Y');
// gong_key_current := gong_key(current_record_flag = 'Y');
// gong_key_current := gong_key;
output(count(gong_key), named('gong_history_key_count'));
output(gong_key, named('gong_history_key'));
output(count(gong_key_current), named('curent_gong_history_key_count'));
output(gong_key_current, named('current_gong_history_key'));

j_lay := record
		in_layout input;
		recordof(gong_key) gong_history;
end;

joined_phones := join(in_file_phones, gong_key_current, left.phone = right.phone10,
											transform(j_lay, self.input := left, self.gong_history := right));
											// transform(j_lay, self.input := left, self.gong_history := right), local);
											
output(choosen(joined_phones, 100), named('joined_results'));
output(joined_phones,, 'nkoubsky::out::prct_joined_phones_' + thorlib.wuid(), csv(heading(single), quote('"')), OVERWRITE);						
