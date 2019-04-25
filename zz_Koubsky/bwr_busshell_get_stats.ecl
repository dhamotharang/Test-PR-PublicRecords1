// EXPORT bwr_busshell_get_stats := 'todo';

IMPORT ashirey, Business_Risk_BIP, zz_Koubsky.bus_shell_spr12_layout;


// inputFile := '~bpahl::tmp::business_shell_results_sprint12_w20141211-140022_pow.csv';
// inputFile := '~bpahl::tmp::business_shell_results_sprint13_w20150106-182112_pow.csv';
inputFile := '~bpahl::tmp::business_shell_results_sprint14_w20150116-155402_pow.csv';

input_lay := RECORD
	// zz_Koubsky.bus_shell_spr12_layout.layout;
	// zz_Koubsky.bus_shell_spr13_layout.layout;
	zz_Koubsky.bus_shell_spr14_layout.layout;
	// Business_Risk_BIP.Layouts.OutputLayout;
	// STRING200 ErrorCode := '';
END;

ds_input := DATASET(inputFile, input_lay, CSV(HEADING(1), QUOTE('"')));

OUTPUT(COUNT(ds_input), named('full_count'));

ashirey.Flatten(ds_input, ds_flat);
// ashirey.Flatten( ds_input, ds_flat,,,true);
output(choosen(ds_flat, 25), named('full_output'));

/*
string attribute := 'verification__proxidpowidtreecount';
// string attribute := 'verification__phonematchsourcecount';
// output(choosen(ds_flat(#expand(attribute) > '6'), 20), named(attribute + '_output'));
// output(count(ds_flat(#expand(attribute) > '6')), named(attribute + '_count'));

ds_flat2 := sort(ds_flat, -(integer) #expand(attribute));
output(choosen(ds_flat2, 5), named(attribute + '_output'));
// output(count(ds_flat2), named(attribute + '_count'));

// ds_badsource := ds_flat( #expand(attribute) not in zz_Koubsky.bus_shell_spr12_layout.sources);
// output(choosen(ds_badsource, 25), named(attribute + '_bad_output'));
// output(count(ds_badsource), named(attribute + '_bad_count'));
// output(count(ds_flat), named('total_count'));
*/

zz_Koubsky_SALT.mac_profile(ds_flat);

/*
DATASET bus_shell_stats :=
zz_Koubsky.macro_busshell_stats(ds_flat, 'input_echo__seq') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'input_echo__acctno') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'input_echo__historydate') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'input_echo__powid') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'input_echo__proxid') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'input_echo__seleid') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'input_echo__orgid') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'input_echo__ultid') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'input_echo__companyname') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'input_echo__altcompanyname') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'input_echo__streetaddress1') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'input_echo__streetaddress2') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'input_echo__city') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'input_echo__state') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'input_echo__zip') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'input_echo__prim_range') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'input_echo__predir') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'input_echo__prim_name') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'input_echo__addr_suffix') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'input_echo__postdir') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'input_echo__unit_desig') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'input_echo__sec_range') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'input_echo__zip5') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'input_echo__zip4') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'input_echo__lat') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'input_echo__long') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'input_echo__addr_type') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'input_echo__addr_status') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'input_echo__county') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'input_echo__geo_block') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'input_echo__fein') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'input_echo__phone10') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'input_echo__ipaddr') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'input_echo__companyurl') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'input_echo__rep_fullname') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'input_echo__rep_nametitle') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'input_echo__rep_firstname') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'input_echo__rep_middlename') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'input_echo__rep_lastname') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'input_echo__rep_namesuffix') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'input_echo__rep_formerlastname') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'input_echo__rep_streetaddress1') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'input_echo__rep_streetaddress2') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'input_echo__rep_city') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'input_echo__rep_state') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'input_echo__rep_zip') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'input_echo__rep_prim_range') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'input_echo__rep_predir') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'input_echo__rep_prim_name') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'input_echo__rep_addr_suffix') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'input_echo__rep_postdir') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'input_echo__rep_unit_desig') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'input_echo__rep_sec_range') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'input_echo__rep_zip5') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'input_echo__rep_zip4') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'input_echo__rep_lat') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'input_echo__rep_long') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'input_echo__rep_addr_type') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'input_echo__rep_addr_status') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'input_echo__rep_county') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'input_echo__rep_geo_block') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'input_echo__rep_ssn') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'input_echo__rep_dateofbirth') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'input_echo__rep_phone10') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'input_echo__rep_age') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'input_echo__rep_dlnumber') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'input_echo__rep_dlstate') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'input_echo__rep_email') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'input_echo__rep_lexid') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'input_echo__rep_lexidscore') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__inputbusnamecheck') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__inputaltbusnamecheck') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__inputbusaddrline1check') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__inputbusaddrcitycheck') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__inputbusaddrstatecheck') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__inputbusaddrzipcheck') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__inputbusfeincheck') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__inputbusphonecheck') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__inputauthrepfirstnamecheck') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__inputauthreplastnamecheck') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__inputauthrepmiddlenamecheck') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__inputauthrepaddrline1check') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__inputauthrepaddrcitycheck') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__inputauthrepaddrstatecheck') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__inputauthrepaddrzipcheck') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__inputauthrepssncheck') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__inputauthrepphonecheck') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__inputauthrepagecheck') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__inputauthrepdobyearcheck') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__inputauthrepdobmonthcheck') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__inputauthrepdobdaycheck') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__inputauthrepdrvrsliscnumcheck') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__inputauthrepdrvrsliscstatecheck') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__inputauthrepformerlastnamecheck') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__datefirstseen') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__datelastseen') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__sourcelist') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__sourcedatefirstseenlist') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__sourcedatelastseenlist') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__sourcecount') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__sourcefbn') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__sourcebureau') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__sourceucc') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__sourcebbbmember') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__sourcebbbnonmember') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__sourceirsnonprofit') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__sourceosha') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__sourcebankruptcy') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__sourceproperty') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__namematch') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__namematchsourcelist') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__namematchsourcecount') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__namemiskey') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__addrmiskey') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__addrinputresidential') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__addrbestresidential') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__addrconsumercount') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__addrcitymatch') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__addrcitymatchsourcelist') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__addrstatematch') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__addrstatematchsourcelist') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__addrzipcodematch') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__addrzipcodematchsourcelist') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__addrcityzipmatch') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__addrverification') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__addrisbest') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__addrverificationsourcelist') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__addrverificationsourcecount') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__addrcurrentlyreported') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__addreverreported') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__phonematch') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__phonematchsourcelist') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__phonematchsourcecount') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__phonemiskey') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__phoneaddrmismatch') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__phonedisconnected') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__feinmatchsourcelist') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__feinmatchsourcecount') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__feinverification') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__feinmiskeyflag') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__busfeinonfilecount') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__busfeinlinkedtopersonaddr') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__busfeinlinkedtopersonphone') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__busaddrconsumerfirstname') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__busaddrconsumerlastname') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__busaddrconsumerfullname') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__bnap') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__bnat') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__bnas') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__bviindicator') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__inputidmatchpowid') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__inputidmatchproxid') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__inputidmatchseleid') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__inputidmatchorgid') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__inputidmatchultid') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__ultidorgidtreecount') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__ultidseleidtreecount') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__ultidproxidtreecount') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__ultidpowidtreecount') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__orgidseleidtreecount') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__orgidproxidtreecount') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__orgidpowidtreecount') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__seleidproxidtreecount') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__seleidpowidtreecount') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'verification__proxidpowidtreecount') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'ar2bi__abr2bi') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'ar2bi__ar2bbusnameauthrepfirst') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'ar2bi__ar2bbusnameauthreppreffirst') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'ar2bi__ar2bbusnameauthrepfirstfile') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'ar2bi__ar2bbusnameauthreppreffirstfile') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'ar2bi__ar2bbusnameauthreplast') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'ar2bi__ar2bbusnameauthreplastfile') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'ar2bi__ar2bbusnameauthrepfull') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'ar2bi__ar2bbusnameauthrepfullfile') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'ar2bi__ar2bpropertyoverlapcount') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'ar2bi__ar2bbusaddrauthrepowned') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'ar2bi__ar2butilityoverlapcount') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'ar2bi__ar2bpublishedassociation') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'ar2bi__ar2bsharedinquirycount') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'ar2bi__ar2bsameaddr') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'ar2bi__ar2bsameaddrfile') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'ar2bi__ar2bsamephone') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'ar2bi__ar2bsamephonefile') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'public_record__bankruptever') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'public_record__bankrupt07year') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'public_record__bankrupt02year') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'public_record__bankrupt01year') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'public_record__bankruptrecenttype') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'public_record__bankruptrecentdate') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'public_record__lienfilingdatelist') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'public_record__lienreleasedatelist') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'public_record__lientypelist') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'public_record__lienfilingstatuslist') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'public_record__lienfilingstatelist') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'public_record__lienamountlist') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'public_record__lientotalamount') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'public_record__liencount') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'public_record__lien01years') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'public_record__judgmentcount') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'public_record__judgment01years') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'public_record__judgmentreleaseddatelist') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'public_record__judgmentfilingdatelist') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'public_record__judgmenttypelist') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'public_record__judgmentfilingstatuslist') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'public_record__judgmentamountlist') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'public_record__judgmenttotalamount') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'public_record__ucccount') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'public_record__uccdatelist') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'public_record__ucctypeslist') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'public_record__uccfilingstatuslist') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'public_record__uccfilingamountlist') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'public_record__ucccollateralcount') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'public_record__uccpropertycount') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'public_record__govdebarred') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'public_record__govdebarreddate') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'assets__propertycount') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'assets__propertystatelist') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'assets__propertylandusecodelist') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'assets__propertylotsizelist') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'assets__propertybuildingarealist') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'assets__propertyyearbuiltlist') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'assets__propertycountofbuildingslist') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'assets__propertycountofunitslist') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'assets__propertymortgageamountlist') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'assets__propertymortgagetypelist') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'assets__propertyassesedvaluelist') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'assets__propertyassesedtotal') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'assets__aircraftcount') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'assets__aircraftownershiplist') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'assets__aircraftregisteredlist') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'assets__aircraftcertificatedatelist') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'assets__watercraftcount') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'assets__watercraftuselist') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'assets__watercraftregisteredlist') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'tradeline__tradecurrentaccountbalance') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'tradeline__trade06monthhighbalance') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'tradeline__trade06monthlowbalance') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'tradeline__tradehighextendedcredit') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'tradeline__trademedianextendedcredit') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'tradeline__trademedianhighextendedcredit') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'tradeline__tradenew12monthhighbalance') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'tradeline__tradereg12monthhighbalance') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'tradeline__tradecombo12monthhighbalance') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'tradeline__tradeactivetotalbalance') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'tradeline__tradepercentnewgoodstanding') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'tradeline__tradepercentreggoodstanding') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'tradeline__tradepercentcombogoodstanding') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'tradeline__tradenewcount') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'tradeline__traderegcount') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'tradeline__tradecombocount') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'tradeline__tradepercentnew1to30dpd') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'tradeline__tradepercentnew31to60dpd') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'tradeline__tradepercentnew61to90dpd') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'tradeline__tradepercentnew91ormoredpd') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'tradeline__tradepercentreg1to30dpd') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'tradeline__tradepercentreg31to60dpd') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'tradeline__tradepercentreg61to90dpd') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'tradeline__tradepercentreg91ormoredpd') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'tradeline__tradepercentcombo1to30dpd') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'tradeline__tradepercentcombo31to60dpd') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'tradeline__tradepercentcombo61to90dpd') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'tradeline__tradepercentcombo91ormoredpd') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'tradeline__bureauinqindustrycodelist') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'tradeline__bureauinqindustrydescriptionlist') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'tradeline__bureauinqmonthlist') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'tradeline__bureauinqyearlist') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'tradeline__bureauinqtotallist') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'firmographic__busobservedage') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'firmographic__busreportedage') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'firmographic__industrysourcenaicbestlist') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'firmographic__industrynaicbestlist') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'firmographic__industrynaicprimary') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'firmographic__industrysourcenaiccompletelist') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'firmographic__industrynaiccompletelist') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'firmographic__industrysicsourcebestlist') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'firmographic__industrysicbestlist') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'firmographic__industrysicprimary') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'firmographic__industrysourcesiccompletelist') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'firmographic__industrysiccompletelist') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'firmographic__employeecountsourcelist') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'firmographic__employeecountdatefirstseenlist') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'firmographic__employeecountdatelastseenlist') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'firmographic__employeecountlist') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'firmographic__employeecountsmallest') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'firmographic__employeecountlargest') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'firmographic__employeecountmostrecent') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'firmographic__employeecount') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'firmographic__buscontactcount') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'firmographic__bussquarefootage') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'firmographic__busownorrent') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'firmographic__industrygroup') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'firmographic__bushasdunsnumberlist') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'firmographic__financereportedsales') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'firmographic__financereportedearnings') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'firmographic__financereportedassets') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'firmographic__financereportedliabilities') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'firmographic__financeworthofbus') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'firmographic__bustypenameadvertized') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'firmographic__bustypeaddress') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'firmographic__busingoodstanding') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'firmographic__buswebsiteonfile') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'firmographic__buswebsiteext') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'firmographic__businactiveindicator') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'firmographic__businactiveever') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'demographic__busshellcompany') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'demographic__associatecount') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'demographic__associatecrimeindex') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'demographic__associatefelonycount') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'demographic__associatecountwithfelony') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'demographic__associatebankyruptcount') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'demographic__associatecountwithbankruptcy') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'demographic__associatebankyrupt1yearcount') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'demographic__associatebusinesscount') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'demographic__associatecitycount') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'demographic__addrmedianincome') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'demographic__addrmedianvalue') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'demographic__addrmurderindex') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'demographic__addrcartheftindex') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'demographic__addrburglaryindex') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'demographic__addrcrimeindex') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'demographic__addrmobilityindex') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'demographic__addrvacantpropcount') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'demographic__addrcountyfcindex') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'other__stockindicator') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'other__stockchange') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'other__buspublicorprivate') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'other__oshainspectiondatelist') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'other__oshatotalpenaltieslist') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'other__oshaseriousviolationslist') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'other__oshatotalviolationslist') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'other__oshapenaltydollarslist') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'other__irs5500pensionplan') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'sos__sosdateofincorporationlist') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'sos__soseverdefunct') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'sos__sostypeoffilingtermlist') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'sos__sosstateofincorporationlist') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'sos__sosdateoffilinglist') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'sos__soscodelist') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'sos__sosfilingcodelist') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'sos__sosforeignstatelist') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'sos__soscorporatestructurelist') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'sos__sosownershiptypelist') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'sos__soslocationdescriptionlist') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'sos__sosnatureofbusinesslist') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'sos__soscountofamendmentslist') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'sos__sosregisteragentchangelist') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'sos__sosregisteragentchangedatelist') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'taxes__corptaxesowed') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'taxes__corpfranchisetaxes') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'taxes__corptaxprogram') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'inquiry_information__inquiryindustrydescriptionlist') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'inquiry_information__inquirydatelist') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'inquiry_information__inquiry12months') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'inquiry_information__inquiry06months') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'inquiry_information__inquiry03months') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'inquiry_information__inquiryconsumeraddress') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'inquiry_information__inquiryconsumerphone') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'inquiry_information__inquiryconsumeraddressssn') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'industry_comparison__compareavgnumemployeeindustry') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'industry_comparison__comparemednumemployeeindustry') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'industry_comparison__compareavgnumemployeestate') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'industry_comparison__comparemednumemployeestate') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'industry_comparison__compareavgnumemployeezip') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'industry_comparison__comparemednumemployeezip') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'industry_comparison__compareavgnumemployeeall') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'industry_comparison__comparemednumemployeeall') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'industry_comparison__compareavgnetworthindustry') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'industry_comparison__comparemednetworthindustry') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'industry_comparison__compareavgnetworthstate') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'industry_comparison__comparemednetworthstate') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'industry_comparison__compareavgnetworthzip') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'industry_comparison__comparemednetworthzip') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'industry_comparison__compareavgnetworthall') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'industry_comparison__comparemednetworthall') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'industry_comparison__comparegrowshrinkstagnant') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'errorcode') +
zz_Koubsky.macro_busshell_stats(ds_flat, 'file_ind')
;

OUTPUT(bus_shell_stats,, '~nkoubsky::out::businessshell_stats_' + thorlib.wuid(), THOR, expire(30));
*/