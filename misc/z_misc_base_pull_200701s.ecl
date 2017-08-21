//
set of string12          basic_set_of_dids:= ['000235841492']; //2
// set of string12          basic_set_of_dids:= ['001220721802']; //jackson
// 
// ran dids that follow:
//set of string12          basic_set_of_dids:= ['002427801529']; steinger
//set of string12          basic_set_of_dids:= ['000665813676']; dolecki
//set of string12          basic_set_of_dids:= ['126359341300']; xsulli?
//set of string12          basic_set_of_dids:= ['000036957881']; pierson
//set of string12          basic_set_of_dids:= ['000271207846']; hughes
//set of string12          basic_set_of_dids:= ['002026698536']; pomphrey
//
//set of string10 basic_set_of_phones:=['4102191077']; 
set of string10 basic_set_of_phones:=['ZZZ1234567']; 
// 
// get integer did set
//
set of unsigned integer6 basic_set_of_didi := (set of unsigned integer6) basic_set_of_dids;
//
// /* run on 400
//
// output business set
// 
my_file_business_contacts_plus := business_header.File_Business_Contacts_Plus(did in basic_set_of_didi);
from_did_bdids := set(my_file_business_contacts_plus,bdid);
set of unsigned integer6 from_did_bdidi := (set of unsigned integer6) from_did_bdids;
//
output(my_file_business_contacts_plus,,'~thor_200::temp::file_business_contacts_plus.csv2',csv);
output(my_file_business_contacts_plus,,'~thor_200::temp::file_business_contacts_plus.xml2',xml);
output(business_header.File_Business_Relatives(bdid1 in from_did_bdidi or bdid2 in from_did_bdidi),,'~thor_200::temp::file_business_relatives.csv2',csv);
output(business_header.File_Business_Relatives(bdid1 in from_did_bdidi or bdid2 in from_did_bdidi),,'~thor_200::temp::file_business_relatives.xml2',xml);
output(business_header.File_Business_Header_Base(bdid in from_did_bdidi),,'~thor_200::temp::file_business_header_base.csv2',csv);
output(business_header.File_Business_Header_Base(bdid in from_did_bdidi),,'~thor_200::temp::file_business_header_base.xml2',xml);
output(business_header.File_Employment_Out(did in basic_set_of_dids),,'~thor_200::temp::file_employment_out.csv2',csv);
output(business_header.File_Employment_Out(did in basic_set_of_dids),,'~thor_200::temp::file_employment_out.xml2',xml);
//
// gong and phones plus
// 
from_did_phone := set(gong.file_history(did in basic_set_of_didi),phone10);
//
output(gong.File_GongBase(phoneno in basic_set_of_phones or phoneno in from_did_phone),,'~thor_200::temp::file_gong_base.csv2',csv);
output(gong.File_GongBase(phoneno in basic_set_of_phones or phoneno in from_did_phone),,'~thor_200::temp::file_gong_base.xml2',xml);
output(gong.File_History(did in basic_set_of_didi or phone10 in basic_set_of_phones),,'~thor_200::temp::file_gong.file_history.csv2',csv);
output(gong.File_History(did in basic_set_of_didi or phone10 in basic_set_of_phones),,'~thor_200::temp::file_gong.file_history.xml2',xml);
output(phonesplus.file_phonesplus_base(did in basic_set_of_didi),,'~thor_200::temp::file_phonesplus_base.csv2',csv);
output(phonesplus.file_phonesplus_base(did in basic_set_of_didi),,'~thor_200::temp::file_phonesplus_base.xml2',xml);
//
// end of 400 run */
//
// /* run on 400_2
//
// output person set 
// 
person1_didi := set(header.File_Relatives(person1 in basic_set_of_didi or person2 in basic_set_of_didi),person1);
person2_didi := set(header.File_Relatives(person1 in basic_set_of_didi or person2 in basic_set_of_didi),person2);
//
output(header.File_Relatives(person1 in basic_set_of_didi or person2 in basic_set_of_didi),,'~thor_200::temp::file_relatives.csv2',csv);
output(header.File_Relatives(person1 in basic_set_of_didi or person2 in basic_set_of_didi),,'~thor_200::temp::file_relatives.xml2',xml);
output(drivers.File_Dl(did in basic_set_of_didi),,'~thor_200::temp::file_dl.csv2',csv);
output(drivers.File_Dl(did in basic_set_of_didi),,'~thor_200::temp::file_dl.xml2',xml);
output(emerges.file_voters_base(did_out in basic_set_of_dids),,'~thor_200::temp::file_voters_base.csv2',csv);
output(emerges.file_voters_base(did_out in basic_set_of_dids),,'~thor_200::temp::file_voters_base.xml2',xml);
output(header.File_Headers(did in basic_set_of_didi  or did in person1_didi or did in person2_didi),,'~thor_200::temp::file_headers.csv2',csv);
output(header.File_Headers(did in basic_set_of_didi  or did in person1_didi or did in person2_didi),,'~thor_200::temp::file_headers.xml2',xml);
output(watchdog.File_Best(did in basic_set_of_didi),,'~thor_200::temp::file_best_12345.csv2',csv);
output(watchdog.File_Best(did in basic_set_of_didi),,'~thor_200::temp::file_best_12345.xml2',xml);
// use this best for all 5 "bests" and make them the same? //
//
// ln_fares_id dependant set
// 
my_file_search_DID := ln_property.File_Search_DID(did in basic_set_of_didi);
from_did_ln_fares_ids := set(my_file_search_did,ln_fares_id);
//
output(my_file_search_DID,,'~thor_200::temp::file_search_did.csv2',csv);
output(my_file_search_DID,,'~thor_200::temp::file_search_did.xml2',xml);
output(ln_property.File_Assessment(ln_fares_id in from_did_ln_fares_ids),,'~thor_200::temp::file_assessment.csv2',csv);
output(ln_property.File_Assessment(ln_fares_id in from_did_ln_fares_ids),,'~thor_200::temp::file_assessment.xml2',xml);
output(ln_property.File_Deed(ln_fares_id in from_did_ln_fares_ids),,'~thor_200::temp::file_deed.csv2',csv);
output(ln_property.File_Deed(ln_fares_id in from_did_ln_fares_ids),,'~thor_200::temp::file_deed.xml2',xml);
//
// eq utility
//
output(UtilFile.file_util_daily(did in basic_set_of_dids),,'~thor_200::temp::file_util_daily.csv2',csv);
output(UtilFile.file_util_daily(did in basic_set_of_dids),,'~thor_200::temp::file_util_daily.xml2',xml);
//
// end of 400_2 run */
//
