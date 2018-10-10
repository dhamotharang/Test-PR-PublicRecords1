import Prof_License,STD;
EXPORT IsValidLayout ( dataset(Prof_License.Layout_proLic_in ) d)  := module

string spec_char := ' \\b[$+=?@|<>^*%!] \\b';



rIsValidLayout := record

		d.source_st,
		d.vendor;
		total																	:= count(group);
	
		profession_or_board_badcount 						:= sum(group, if ( STD.Str.Filter ( d.profession_or_board , '0123456789') <> ' '  or  STD.Str.Filter ( d.profession_or_board ,spec_char)   <> ' ' , 1,0) );
		license_type_badcount  										:= sum(group,if ( STD.Str.Filter (d.license_type , '0123456789')  <> ' ' or  STD.Str.Filter ( d.license_type ,spec_char) <> ' '  , 1,0) );
		status_badcount  													:= sum(group,if ( STD.Str.Filter (d.status , '0123456789')  <> ' '  , 1,0) );
		orig_license_number_badcount  						:= sum(group,if ( STD.Str.Filter (d.orig_license_number , 'ABCDEFGHIJKLMONPQRSTUVWXYZ')  <> ' ' or  STD.Str.Filter ( d.orig_license_number ,spec_char) <> ' ' , 1,0) );
		license_number_badcount  									:= sum(group,if ( STD.Str.Filter (d.license_number , 'ABCDEFGHIJKLMONPQRSTUVWXYZ')  <> ' ' or  STD.Str.Filter ( d.license_number ,spec_char) <> ' ' , 1,0) );
		company_name_badcount  										:=sum(group,if ( STD.Str.Filter (d.company_name, '0123456789')  <> ' ' or  STD.Str.Filter ( d.company_name ,spec_char) <> ' ' , 1,0) );
		orig_name_badcount  											:=sum(group,if ( STD.Str.Filter (d.orig_name,'0123456789')  <> ' ' or  STD.Str.Filter ( d.orig_name ,spec_char) <> ' ' , 1,0) );
		issue_date_badcount  											:= sum(group,if ( STD.Str.Filter (d.issue_date,'ABCDEFGHIJKLMONPQRSTUVWXYZ')  <> ' '   or    STD.Date.IsValidDate ((integer) d.issue_date) = false or STD.Str.Filter ( d.issue_date ,spec_char) <> ' ' , 1,0) );
		expiration_date_badcount  								:=sum(group,if (STD.Str.Filter (d.expiration_date,'ABCDEFGHIJKLMONPQRSTUVWXYZ')  <> ' ' or  STD.Date.IsValidDate ((integer) d.expiration_date) = false or   STD.Str.Filter ( d.expiration_date ,spec_char) <> ' ' , 1,0) );
		source_st_badcount  											:= sum(group,if (STD.Str.Filter (d.source_st,'0123456789')  <> ' ' or  STD.Str.Filter ( d.source_st ,spec_char) <> ' ' , 1,0) );	
		vendor_badcount  													:= sum(group,if (STD.Str.Filter (d.vendor,'0123456789')  <> ' '  or  STD.Str.Filter ( d.vendor ,spec_char) <> ' ' , 1,0) );
	
end;

stats := table(d,rIsValidLayout,source_st,vendor,few);

rSampledata := record

string profession_or_board_sample := '';
string license_type_sample := '';
string status_sample := '';
string orig_license_number_sample := '';
string company_name_sample := '';
string orig_name_sample := '';
string issue_date_sample := '';
string expiration_date_sample := '';
string source_st ;
string vendor;
end;


rSampledata getsample ( d  l ) := transform
self.profession_or_board_sample := if (STD.Str.Filter ( l.profession_or_board , '0123456789') <> ' '  or  STD.Str.Filter ( l.profession_or_board ,spec_char)   <> ' ', l.profession_or_board ,'0');
self.license_type_sample := if (  STD.Str.Filter (l.license_type , '0123456789')  <> ' ' or  STD.Str.Filter (l.license_type ,spec_char) <> ' ', l.license_type  ,'0');
self.status_sample := if ( STD.Str.Filter (l.status , '0123456789')  <> ' ' , l.status, '0' );
self.orig_license_number_sample := if (  STD.Str.Filter (l.orig_license_number , 'ABCDEFGHIJKLMONPQRSTUVWXYZ')  <> ' ' or  STD.Str.Filter ( l.orig_license_number ,spec_char) <> ' ', l.orig_license_number  ,'0');
self.orig_name_sample := if ( STD.Str.Filter (l.orig_name,'0123456789')  <> ' ' or  STD.Str.Filter ( l.orig_name ,spec_char) <> ' ', l.orig_name  ,'0');
self.issue_date_sample := if ( STD.Str.Filter (l.issue_date,'ABCDEFGHIJKLMONPQRSTUVWXYZ')  <> ' '  or  STD.Date.IsValidDate ((integer) l.issue_date) = false or  STD.Str.Filter ( l.issue_date ,spec_char) <> ' ', l.issue_date ,'0' );
self.expiration_date_sample := if ( STD.Str.Filter (l.expiration_date,'ABCDEFGHIJKLMONPQRSTUVWXYZ')  <> ' ' or  STD.Date.IsValidDate ((integer) l.expiration_date) = false or  STD.Str.Filter ( l.expiration_date ,spec_char) <> ' ' , l.expiration_date ,'0' );
self.company_name_sample := if (  STD.Str.Filter (l.company_name, '0123456789')  <> ' ' or  STD.Str.Filter (l.company_name ,spec_char) <> ' ', l.company_name ,'0' );
self := l;

end;

dgetsample := project ( d, getsample(left));


bad_stats :=  stats (  issue_date_badcount > 0  ) + stats ( expiration_date_badcount > 0)  + stats ( orig_license_number_badcount > 0)  + stats ( profession_or_board_badcount > 0) ;

 Set of string bad_stats_vendor :=  Set(bad_stats,vendor ) ;
  Set of  string  bad_stats_source :=    Set(bad_stats,source_st ) ;


bad_sample := Sequential ( if ( count(stats (  issue_date_badcount > 0   )) > 0  , Output( dgetsample ( issue_date_sample not in ['0',''] ) ,named ( 'Bad_Issue_Dates'))),
                                       if ( count(stats (  expiration_date_badcount > 0 )) > 0  , Output( dgetsample ( expiration_date_sample  not in ['0','']) ,named ( 'Bad_Expiration_Dates'))),
							 if ( count(stats (  orig_license_number_badcount > 0 )) > 0 , Output( dgetsample ( orig_license_number_sample  not in ['0','']) ,named ( 'Bad_License_Number'))),
							if ( count(stats (  profession_or_board_badcount > 0 ))  > 0, Output( dgetsample ( profession_or_board_sample  not in ['0','']) ,named ( 'Bad_Profes_Board'))),
							if (count(stats (  license_type_badcount > 0 )) > 0 , Output( dgetsample ( license_type_sample  not in ['0','']) ,named ( 'Bad_LicenseTypes'))),
							if (count(stats (  orig_name_badcount > 0 )) > 0 , Output( dgetsample ( orig_name_sample not in ['0','']) ,named ( 'Bad_orig_name'))),
							if (count(stats (  status_badcount > 0 ))  > 0, Output( dgetsample ( status_sample not in ['0','']) ,named ( 'Bad_Status'))),
							Output('All_Samples_are_Valid')
						 );

 export out_all  :=  Sequential (  output(choosen(stats,1000) , named('PL_InputStats')),
                                                          if ( count( bad_stats)  > 0  , Sequential ( bad_sample, Output(bad_stats_vendor,named ('Bad_Vendor_Set')), Output(bad_stats_source,named ('Bad_Source_Set')),
                                                                                                                                 FAIL( 'Vendor : '+bad_stats[1].vendor+ ' , source st:' +bad_stats[1].source_st+' modified layout.Please verify')
																							 )
										          )
										);
end;