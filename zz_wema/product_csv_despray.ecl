import ut, STD;
// a1 := '20190114';

//fp201
fp_file_out := '~scoringqa::out::nonfcra::fraudpoint_xml_american_express_fp1109_0_v201_' +  ut.GetDate  +'_1';
STD.File.DeSpray(fp_file_out +'_CSV_copy', '10.140.128.250','/data/Tweet Intel/' + fp_file_out +'_CSV_copy',,,,true);
//liv4
LIv4_attribute_file_out := '~scoringqa::out::nonfcra::leadintegrity_xml_generic_attributes_v4_' +  ut.GetDate  +'_1';
STD.File.DeSpray(LIv4_attribute_file_out +'_CSV_copy', '10.140.128.250','/data/Tweet Intel/' + LIv4_attribute_file_out +'_CSV_copy',,,,true);
LIv4_score_file_out := '~scoringqa::out::nonfcra::leadintegrity_xml_generic_msn1106_0_v4_' +  ut.GetDate  +'_1';
STD.File.DeSpray(LIv4_score_file_out +'_CSV_copy', '10.140.128.250','/data/Tweet Intel/' + LIv4_score_file_out +'_CSV_copy',,,,true);
//bnk4
bnk4_file_out := '~scoringqa::out::nonfcra::bnk4_xml_chase_bd3605_0_' +  ut.GetDate  +'_1';
STD.File.DeSpray(bnk4_file_out +'_CSV_copy', '10.140.128.250','/data/Tweet Intel/' + bnk4_file_out +'_CSV_copy',,,,true);
//cbbl
cbbl_file_out := '~scoringqa::out::nonfcra::cbbl_xml_chase_' +  ut.GetDate  +'_1';
STD.File.DeSpray(cbbl_file_out +'_CSV_copy', '10.140.128.250','/data/Tweet Intel/' + cbbl_file_out +'_CSV_copy',,,,true);
//pi02
pi02_file_out := '~scoringqa::out::nonfcra::pi02_xml_chase_fp3710_0_' +  ut.GetDate  +'_1';
STD.File.DeSpray(pi02_file_out +'_CSV_copy', '10.140.128.250','/data/Tweet Intel/' + pi02_file_out +'_CSV_copy',,,,true);
//bocashell 41
bocashell_41_fcra_prod_file_out := '~foreign::10.173.44.105::scoringqa::out::fcra::bocashell_41_historydate_999999_prod_' +  ut.GetDate  +'_1';
STD.File.DeSpray(bocashell_41_fcra_prod_file_out +'_CSV_copy', '10.140.128.250','/data/Tweet Intel2/' + bocashell_41_fcra_prod_file_out +'_CSV_copy',,,,true);
//bocashell 50
bocashell_50_fcra_prod_file_out := '~foreign::10.173.44.105::scoringqa::out::fcra::bocashell_50_historydate_999999_prod_' +  ut.GetDate  +'_1';
STD.File.DeSpray(bocashell_50_fcra_prod_file_out +'_CSV_copy', '10.140.128.250','/data/Tweet Intel2/' + bocashell_50_fcra_prod_file_out +'_CSV_copy',,,,true);
//rv3
rv3_score_file_out := '~scoringqa::out::fcra::riskview_xml_generic_allflagships_v3_' +  ut.GetDate  +'_1';
STD.File.DeSpray(rv3_score_file_out +'_CSV_copy', '10.140.128.250','/data/Tweet Intel/' + rv3_score_file_out +'_CSV_copy',,,,true);
rv3_attribute_file_out := '~scoringqa::out::fcra::riskview_xml_generic_attributes_v3_' +  ut.GetDate  +'_1';
STD.File.DeSpray(rv3_attribute_file_out +'_CSV_copy', '10.140.128.250','/data/Tweet Intel/' + rv3_attribute_file_out +'_CSV_copy',,,,true);


fn_LastTwoMonths(string10 date_inp,integer offset) := function
res  := GLOBAL(ut.DateFrom_DaysSince1900(ut.DaysSince1900(date_inp[1..4], date_inp[5..6], date_inp[7..8]) - offset));
return res[1..8];
end;

Prev8Days:=fn_LastTwoMonths(ut.GetDate,8);
//fp201
fp_file_out_old := '~scoringqa::out::nonfcra::fraudpoint_xml_american_express_fp1109_0_v201_' +  Prev8Days + '_1';
delete_file_fp := '/data/Tweet Intel/'+ fp_file_out_old +'_CSV_copy';
STD.File.DeleteExternalFile('10.140.128.250',delete_file_fp);
//liv4
LIv4_attribute_file_out_old := '~scoringqa::out::nonfcra::leadintegrity_xml_generic_attributes_v4_' +  Prev8Days + '_1';
delete_file_LIv4_attribute := '/data/Tweet Intel/'+ LIv4_attribute_file_out_old +'_CSV_copy';
STD.File.DeleteExternalFile('10.140.128.250',delete_file_LIv4_attribute);
LIv4_score_file_out_old := '~scoringqa::out::nonfcra::leadintegrity_xml_generic_msn1106_0_v4_' +  Prev8Days + '_1';
delete_file_LIv4_score := '/data/Tweet Intel/'+ LIv4_score_file_out_old +'_CSV_copy';
STD.File.DeleteExternalFile('10.140.128.250',delete_file_LIv4_score);
//bnk4
bnk4_file_out_old := '~scoringqa::out::nonfcra::bnk4_xml_chase_bd3605_0_' +  Prev8Days + '_1';
delete_file_bnk4 := '/data/Tweet Intel/'+ bnk4_file_out_old +'_CSV_copy';
STD.File.DeleteExternalFile('10.140.128.250',delete_file_bnk4);
//cbbl
cbbl_file_out_old := '~scoringqa::out::nonfcra::cbbl_xml_chase_' +  Prev8Days + '_1';
delete_file_cbbl := '/data/Tweet Intel/'+ cbbl_file_out_old +'_CSV_copy';
STD.File.DeleteExternalFile('10.140.128.250',delete_file_cbbl);
//pi02
pi02_file_out_old := '~scoringqa::out::nonfcra::pi02_xml_chase_fp3710_0_' +  Prev8Days + '_1';
delete_file_pi02 := '/data/Tweet Intel/'+ pi02_file_out_old +'_CSV_copy';
STD.File.DeleteExternalFile('10.140.128.250',delete_file_pi02);
//bocashell 41
bocashell_41_fcra_prod_file_out_old := '~foreign::10.173.44.105::scoringqa::out::fcra::bocashell_41_historydate_999999_prod_' +  Prev8Days + '_1';
delete_file41_prod := '/data/Tweet Intel2/'+ bocashell_41_fcra_prod_file_out_old +'_CSV_copy';
STD.File.DeleteExternalFile('10.140.128.250',delete_file41_prod);
//bocashell 50
bocashell_50_fcra_prod_file_out_old := '~foreign::10.173.44.105::scoringqa::out::fcra::bocashell_50_historydate_999999_prod_' +  Prev8Days + '_1';
delete_file50_prod := '/data/Tweet Intel2/'+ bocashell_50_fcra_prod_file_out_old +'_CSV_copy';
STD.File.DeleteExternalFile('10.140.128.250',delete_file50_prod);
//rv3
rv3_attribute_file_out_old := '~scoringqa::out::fcra::riskview_xml_generic_attributes_v3_' +  Prev8Days + '_1';
delete_file_rv3_attribute := '/data/Tweet Intel/'+ rv3_attribute_file_out_old +'_CSV_copy';
STD.File.DeleteExternalFile('10.140.128.250',delete_file_rv3_attribute);
rv3_score_file_out_old := '~scoringqa::out::fcra::riskview_xml_generic_allflagships_v3_' +  Prev8Days + '_1';
delete_file_rv3_score := '/data/Tweet Intel/'+ rv3_score_file_out_old +'_CSV_copy';
STD.File.DeleteExternalFile('10.140.128.250',delete_file_rv3_score);


EXPORT product_csv_despray := 'todo';


/*
import ut, STD;
fp_file_out := '~scoringqa::out::nonfcra::fraudpoint_xml_american_express_fp1109_0_v201_' +  ut.GetDate  +'_1';
STD.File.DeSpray(fp_file_out +'_CSV_copy', '10.140.128.250','/data/Tweet Intel/' + fp_file_out +'_CSV_copy',,,,true);
LIv4_attribute_file_out := '~scoringqa::out::nonfcra::leadintegrity_xml_generic_attributes_v4_' +  ut.GetDate  +'_1';
STD.File.DeSpray(LIv4_attribute_file_out +'_CSV_copy', '10.140.128.250','/data/Tweet Intel/' + LIv4_attribute_file_out +'_CSV_copy',,,,true);
LIv4_score_file_out := '~scoringqa::out::nonfcra::leadintegrity_xml_generic_msn1106_0_v4_' +  ut.GetDate  +'_1';
STD.File.DeSpray(LIv4_score_file_out +'_CSV_copy', '10.140.128.250','/data/Tweet Intel/' + LIv4_score_file_out +'_CSV_copy',,,,true);
bnk4_file_out := '~scoringqa::out::nonfcra::bnk4_xml_chase_bd3605_0_' +  ut.GetDate  +'_1';
STD.File.DeSpray(bnk4_file_out +'_CSV_copy', '10.140.128.250','/data/Tweet Intel/' + bnk4_file_out +'_CSV_copy',,,,true);
cbbl_file_out := '~scoringqa::out::nonfcra::cbbl_xml_chase_' +  ut.GetDate  +'_1';
STD.File.DeSpray(cbbl_file_out +'_CSV_copy', '10.140.128.250','/data/Tweet Intel/' + cbbl_file_out +'_CSV_copy',,,,true);
pi02_file_out := '~scoringqa::out::nonfcra::pi02_xml_chase_fp3710_0_' +  ut.GetDate  +'_1';
STD.File.DeSpray(pi02_file_out +'_CSV_copy', '10.140.128.250','/data/Tweet Intel/' + pi02_file_out +'_CSV_copy',,,,true);
rv3_score_file_out := '~scoringqa::out::fcra::riskview_xml_generic_allflagships_v3_' +  ut.GetDate  +'_1';
STD.File.DeSpray(rv3_score_file_out +'_CSV_copy', '10.140.128.250','/data/Tweet Intel/' + rv3_score_file_out +'_CSV_copy',,,,true);
rv3_attribute_file_out := '~scoringqa::out::fcra::riskview_xml_generic_attributes_v3_' +  ut.GetDate  +'_1';
STD.File.DeSpray(rv3_attribute_file_out +'_CSV_copy', '10.140.128.250','/data/Tweet Intel/' + rv3_attribute_file_out +'_CSV_copy',,,,true);
bocashell_50_fcra_file_out := '~scoringqa::out::fcra::bocashell_50_historydate_999999_cert_' +  ut.GetDate  +'_1';
STD.File.DeSpray(bocashell_50_fcra_file_out +'_CSV_copy', '10.140.128.250','/data/Tweet Intel2/' + bocashell_50_fcra_file_out +'_CSV_copy',,,,true);
bocashell_41_fcra_file_out := '~scoringqa::out::fcra::bocashell_41_historydate_999999_cert_' +  ut.GetDate  +'_1';
STD.File.DeSpray(bocashell_41_fcra_file_out +'_CSV_copy', '10.140.128.250','/data/Tweet Intel2/' + bocashell_41_fcra_file_out +'_CSV_copy',,,,true);
bocashell_50_fcra_prod_file_out := '~foreign::10.173.44.105::scoringqa::out::fcra::bocashell_50_historydate_999999_prod_' +  ut.GetDate  +'_1';
STD.File.DeSpray(bocashell_50_fcra_prod_file_out +'_CSV_copy', '10.140.128.250','/data/Tweet Intel2/' + bocashell_50_fcra_prod_file_out +'_CSV_copy',,,,true);
bocashell_41_fcra_prod_file_out := '~foreign::10.173.44.105::scoringqa::out::fcra::bocashell_41_historydate_999999_prod_' +  ut.GetDate  +'_1';
STD.File.DeSpray(bocashell_41_fcra_prod_file_out +'_CSV_copy', '10.140.128.250','/data/Tweet Intel2/' + bocashell_41_fcra_prod_file_out +'_CSV_copy',,,,true);
fn_LastTwoMonths(string10 date_inp,integer offset) := function
res  := GLOBAL(ut.DateFrom_DaysSince1900(ut.DaysSince1900(date_inp[1..4], date_inp[5..6], date_inp[7..8]) - offset));
return res[1..8];
end;
Prev8Days:=fn_LastTwoMonths(ut.GetDate,8);
fp_file_out_old := '~scoringqa::out::nonfcra::fraudpoint_xml_american_express_fp1109_0_v201_' +  Prev8Days + '_1';
delete_file_fp := '/data/Tweet Intel/'+ fp_file_out_old +'_CSV_copy';
STD.File.DeleteExternalFile('10.140.128.250',delete_file_fp);
LIv4_attribute_file_out_old := '~scoringqa::out::nonfcra::leadintegrity_xml_generic_attributes_v4_' +  Prev8Days + '_1';
delete_file_LIv4_attribute := '/data/Tweet Intel/'+ LIv4_attribute_file_out_old +'_CSV_copy';
STD.File.DeleteExternalFile('10.140.128.250',delete_file_LIv4_attribute);
LIv4_score_file_out_old := '~scoringqa::out::nonfcra::leadintegrity_xml_generic_msn1106_0_v4_' +  Prev8Days + '_1';
delete_file_LIv4_score := '/data/Tweet Intel/'+ LIv4_score_file_out_old +'_CSV_copy';
STD.File.DeleteExternalFile('10.140.128.250',delete_file_LIv4_score);
bnk4_file_out_old := '~scoringqa::out::nonfcra::bnk4_xml_chase_bd3605_0_' +  Prev8Days + '_1';
delete_file_bnk4 := '/data/Tweet Intel/'+ bnk4_file_out_old +'_CSV_copy';
STD.File.DeleteExternalFile('10.140.128.250',delete_file_bnk4);
cbbl_file_out_old := '~scoringqa::out::nonfcra::cbbl_xml_chase_' +  Prev8Days + '_1';
delete_file_cbbl := '/data/Tweet Intel/'+ cbbl_file_out_old +'_CSV_copy';
STD.File.DeleteExternalFile('10.140.128.250',delete_file_cbbl);
pi02_file_out_old := '~scoringqa::out::nonfcra::pi02_xml_chase_fp3710_0_' +  Prev8Days + '_1';
delete_file_pi02 := '/data/Tweet Intel/'+ pi02_file_out_old +'_CSV_copy';
STD.File.DeleteExternalFile('10.140.128.250',delete_file_pi02);
rv3_attribute_file_out_old := '~scoringqa::out::fcra::riskview_xml_generic_attributes_v3_' +  Prev8Days + '_1';
delete_file_rv3_attribute := '/data/Tweet Intel/'+ rv3_attribute_file_out_old +'_CSV_copy';
STD.File.DeleteExternalFile('10.140.128.250',delete_file_rv3_attribute);
rv3_score_file_out_old := '~scoringqa::out::fcra::riskview_xml_generic_allflagships_v3_' +  Prev8Days + '_1';
delete_file_rv3_score := '/data/Tweet Intel/'+ rv3_score_file_out_old +'_CSV_copy';
STD.File.DeleteExternalFile('10.140.128.250',delete_file_rv3_score);
bocashell_50_fcra_file_out_old := '~scoringqa::out::fcra::bocashell_50_historydate_999999_cert_' +  Prev8Days + '_1';
delete_file50 := '/data/Tweet Intel2/'+bocashell_50_fcra_file_out_old +'_CSV_copy';
STD.File.DeleteExternalFile('10.140.128.250',delete_file50);
bocashell_41_fcra_file_out_old := '~scoringqa::out::fcra::bocashell_41_historydate_999999_cert_' +  Prev8Days + '_1';
delete_file41 := '/data/Tweet Intel2/'+bocashell_41_fcra_file_out_old +'_CSV_copy';
STD.File.DeleteExternalFile('10.140.128.250',delete_file41);
bocashell_41_fcra_prod_file_out_old := '~foreign::10.173.44.105::scoringqa::out::fcra::bocashell_41_historydate_999999_prod_' +  Prev8Days + '_1';
delete_file41_prod := '/data/Tweet Intel2/'+ bocashell_41_fcra_prod_file_out_old +'_CSV_copy';
STD.File.DeleteExternalFile('10.140.128.250',delete_file41_prod);
bocashell_50_fcra_prod_file_out_old := '~foreign::10.173.44.105::scoringqa::out::fcra::bocashell_50_historydate_999999_prod_' +  Prev8Days + '_1';
delete_file50_prod := '/data/Tweet Intel2/'+ bocashell_50_fcra_prod_file_out_old +'_CSV_copy';
STD.File.DeleteExternalFile('10.140.128.250',delete_file50_prod);
*/