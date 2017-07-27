//This was grabbed from the Crim_common module to be used in the CrimSrch for DID and SSN blanking

did_st_set := [
'WA000137071458'
];

did_vendor_set := [
'FL002120228383',
'69002120228383',
'08001001038301',
'01001517399556',
'01000214803073',
'01001063346398',
'03000035949478',
'NJ000729814470',
'IL002638383768',
'2W001207068128',
'32000288540329',
'67000288540329',
'ID000985843685',
'01000330437615',
'01001163299475',
'47001163299475',
'01002340318797',
'01001804364553',
'IL000731871636',
'01002182254379',
'01002786882328',
'01000843184142',
'FL001223108383',
'69002202468450',
'69001222152935',
'46001667132974',
'01001113850260',
'69000588107631',
'83001256032551',
'MI001256032551',
'27001669222601',
'31002414829850',
'2Q000567609059',
'SC000567609059',
'12000469009868',
'01001369763635',
'12001369763635',
'TX001369763635',
'12007492130957',
'01001263157971',
'AT001171965981',
'18001171965981',
'53000780645354',
'04001950637938',
'01001148441584',
'69000833339757',
'08001281635581',
'MI001724632592',
'69001724632592',
'83001724632592',
'01001173820620',
'PA000613441541',
'08001112068405',
'01000333276841',
'69000260277358',
'AA002354446602',
'53002375427703',
'88033638328663'
]; 

vendor_case_number_did := [
'12071GC0200093400000061812824',
'082009CR 052012001722381798'
];

export fn_blank_the_did(dataset(recordof(Layout_Moxie_Offender_temp)) in_crim) := function

recordof(in_crim) t1(in_crim le) := transform
// self.did := if(le.state_of_origin+le.did in did_st_set,'',le.did);
 self.did := MAP(le.state_of_origin+le.did in did_st_set => '',
                 le.vendor+le.did in did_vendor_set => '',
								 trim(le.vendor)+trim(le.case_number)+trim(le.did) in vendor_case_number_did => '',
								 le.did);
 self.ssn := MAP(le.vendor+le.did in did_vendor_set => '',
								 trim(le.vendor)+trim(le.case_number)+trim(le.did) in vendor_case_number_did => '',
								 le.ssn); 
 self     := le;
end;

p1 := project(in_crim,t1(left));

return p1;

end;