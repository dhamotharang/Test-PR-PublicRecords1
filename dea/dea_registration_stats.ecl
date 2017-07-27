import DEA;

//update filename before executing
outf := dataset('~thor_data400::base::deaw20050301-163803', DEA.layout_DEA_Out, flat, unsorted);

d := distribute(outf,hash(date_first_reported));

stat_rec :=  record
'dea_registration',
Dea.version,
d.date_first_reported;
total := count(group);
date_first_reported_count := count(group,d.date_first_reported<>'');
date_last_reported_count := count(group,d.date_last_reported<>'');
Dea_Registration_Number_count := count(group,d.Dea_Registration_Number<>'');
Business_activity_code_count := count(group,d.Business_activity_code<>'');
Drug_Schedules_count := count(group,d.Drug_Schedules<>'');
Expiration_Date_count := count(group,d.Expiration_Date<>'');
Address1_count := count(group,d.Address1<>'');
Address2_count := count(group,d.Address2<>'');
Address3_count := count(group,d.Address3<>'');
Address4_count := count(group,d.Address4<>'');
Address5_count := count(group,d.Address5<>'');
State_count := count(group,d.State<>'');
Zip_Code_count := count(group,d.Zip_Code<>'');
prim_range_count := count(group,d.prim_range<>'');
predir_count := count(group,d.predir<>'');
prim_name_count := count(group,d.prim_name<>'');
addr_suffix_count := count(group,d.addr_suffix<>'');
postdir_count := count(group,d.postdir<>'');
unit_desig_count := count(group,d.unit_desig<>'');
sec_range_count := count(group,d.sec_range<>'');
p_city_name_count := count(group,d.p_city_name<>'');
v_city_name_count := count(group,d.v_city_name<>'');
st_count := count(group,d.st<>'');
zip_count := count(group,d.zip<>'');
zip4_count := count(group,d.zip4<>'');
cart_count := count(group,d.cart<>'');
cr_sort_sz_count := count(group,d.cr_sort_sz<>'');
lot_count := count(group,d.lot<>'');
lot_order_count := count(group,d.lot_order<>'');
dbpc_count := count(group,d.dbpc<>'');
chk_digit_count := count(group,d.chk_digit<>'');
rec_type_count := count(group,d.rec_type<>'');
county_count := count(group,d.county<>'');
geo_lat_count := count(group,d.geo_lat<>'');
geo_long_count := count(group,d.geo_long<>'');
msa_count := count(group,d.msa<>'');
geo_blk_count := count(group,d.geo_blk<>'');
geo_match_count := count(group,d.geo_match<>'');
err_stat_count := count(group,d.err_stat<>'');
title_count := count(group,d.title<>'');
fname_count := count(group,d.fname<>'');
mname_count := count(group,d.mname<>'');
lname_count := count(group,d.lname<>'');
name_suffix_count := count(group,d.name_suffix<>'');
name_score_count := count(group,d.name_score<>'');
is_company_flag_count := count(group,d.is_company_flag<>'');
cname_count := count(group,d.cname<>'');
crlf_count := count(group,d.crlf<>'');
county_name_count := count(group,d.county_name<>'');
did_count := count(group,d.did<>'');
score_count := count(group,d.score<>'');
best_ssn_count := count(group,d.best_ssn<>'');
end;

stats := table(d,stat_rec,date_first_reported,few);

output(choosen(stats,1000));