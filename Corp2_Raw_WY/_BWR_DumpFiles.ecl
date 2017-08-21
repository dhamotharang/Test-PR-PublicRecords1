import corp2_mapping, corp2_raw_wy;

state_origin			 := 'WY';
state_fips	 			 := '56';	
state_desc	 			 := 'WYOMING';

fileDate					 := '20160810';         

puseprod				   := true;

keys							 := ['1988-000248158','8930','56-8930','2006-000522864','81723','56-81723','1986-000233418','7720','56-7720'];
		
Filing 						 := dedup(sort(distribute(Corp2_Raw_WY.Files(fileDate,puseprod).Input.Filing.Logical,hash(filing_id)),record,local),record,local)   : independent;
FilingAR					 := dedup(sort(distribute(Corp2_Raw_WY.Files(fileDate,puseprod).Input.FilingAR.Logical,hash(filing_id)),record,local),record,local) : independent;
Party							 := dedup(sort(distribute(Corp2_Raw_WY.Files(fileDate,puseprod).Input.Party.Logical,hash(source_id)),record,except party_id,local),record,except party_id,local) : independent;

Main							 := dataset('~thor_data400::in::corp2::'+fileDate+'::main_WY',corp2_mapping.layoutscommon.main,thor);
AR								 := dataset('~thor_data400::in::corp2::'+fileDate+'::ar_WY',corp2_mapping.layoutscommon.ar,thor);
Stock							 := dataset('~thor_data400::in::corp2::'+fileDate+'::stock_WY',corp2_mapping.layoutscommon.stock,thor);

output(filing(filing_id in keys or filing_num in keys),named('filing'));
output(filingar(filing_id in keys),named('filingar'));
output(party(source_id in keys),named('party'));

output(main(corp_key in keys or corp_orig_sos_charter_nbr in keys),named('main'));
output(ar(corp_key in keys or corp_sos_charter_nbr in keys),named('ar'));
output(stock(corp_key in keys or corp_sos_charter_nbr in keys),named('stock'));

Corporation				:= Main(recordorigin = 'C');
output(Corporation,named('Corporation'));
output(count(Corporation),named('cnt_Corporation'));
Contacts					:= Main(recordorigin = 'T');
output(Contacts,named('Contacts'));
output(count(Contacts),named('cnt_Contacts'));