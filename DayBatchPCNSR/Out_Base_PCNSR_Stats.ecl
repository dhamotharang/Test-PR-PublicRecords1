import strata;

export Out_Base_PCNSR_Stats(string filedate) := function
 

ds := DayBatchPCNSR.File_PCNSR;


rSTRATA_PCNSR := record
CountGroup              := count(group);
title                  := sum(group,if(ds.title<>'',1,0));
fname                  := sum(group,if(ds.fname<>'',1,0));
mname                  := sum(group,if(ds.mname<>'',1,0));
lname                  := sum(group,if(ds.lname<>'',1,0));
name_suffix            := sum(group,if(ds.name_suffix<>'',1,0));
name_score             := sum(group,if(ds.name_score<>'',1,0));
fname_orig             := sum(group,if(ds.fname_orig<>'',1,0));
mname_orig             := sum(group,if(ds.mname_orig<>'',1,0));
lname_orig             := sum(group,if(ds.lname_orig<>'',1,0));
name_suffix_orig       := sum(group,if(ds.name_suffix_orig<>'',1,0));
title_orig             := sum(group,if(ds.title_orig<>'',1,0));
prim_range             := sum(group,if(ds.prim_range<>'',1,0));
predir                 := sum(group,if(ds.predir<>'',1,0));
prim_name              := sum(group,if(ds.prim_name<>'',1,0));
addr_suffix            := sum(group,if(ds.addr_suffix<>'',1,0));
postdir                := sum(group,if(ds.postdir<>'',1,0));
unit_desig             := sum(group,if(ds.unit_desig<>'',1,0));
sec_range              := sum(group,if(ds.sec_range<>'',1,0));
p_city_name            := sum(group,if(ds.p_city_name<>'',1,0));
v_city_name            := sum(group,if(ds.v_city_name<>'',1,0));
DayBatchPCNSR.File_PCNSR.st;                    
zip                    := sum(group,if(ds.zip<>'',1,0));
zip4                   := sum(group,if(ds.zip4<>'',1,0));
cart                   := sum(group,if(ds.cart<>'',1,0));
cr_sort_sz             := sum(group,if(ds.cr_sort_sz<>'',1,0));
lot                    := sum(group,if(ds.lot<>'',1,0));
lot_order              := sum(group,if(ds.lot_order<>'',1,0));
dbpc                   := sum(group,if(ds.dbpc<>'',1,0));
chk_digit              := sum(group,if(ds.chk_digit<>'',1,0));
rec_type               := sum(group,if(ds.rec_type<>'',1,0));
county                 := sum(group,if(ds.county<>'',1,0));
geo_lat                := sum(group,if(ds.geo_lat<>'',1,0));
geo_long               := sum(group,if(ds.geo_long<>'',1,0));
msa                    := sum(group,if(ds.msa<>'',1,0));
geo_blk                := sum(group,if(ds.geo_blk<>'',1,0));
geo_match              := sum(group,if(ds.geo_match<>'',1,0));
err_stat               := sum(group,if(ds.err_stat<>'',1,0));
//hhid                   := sum(group,if(ds.hhid<>'',1,0));
//did                    := sum(group,if(ds.did<>'',1,0));
//did_score              := sum(group,if(ds.did_score<>'',1,0));
phone_fordid           := sum(group,if(ds.phone_fordid<>'',1,0));
gender                 := sum(group,if(ds.gender<>'',1,0));
date_of_birth          := sum(group,if(ds.date_of_birth<>'',1,0));
address_type           := sum(group,if(ds.address_type<>'',1,0));
demographic_level_indicator := sum(group,if(ds.demographic_level_indicator<>'',1,0));
length_of_residence    := sum(group,if(ds.length_of_residence<>'',1,0));
location_type          := sum(group,if(ds.location_type<>'',1,0));
dqi2_occupancy_count   := sum(group,if(ds.dqi2_occupancy_count<>'',1,0));
delivery_unit_size     := sum(group,if(ds.delivery_unit_size<>'',1,0));
household_arrival_date := sum(group,if(ds.household_arrival_date<>'',1,0));
area_code              := sum(group,if(ds.area_code<>'',1,0));
phone_number           := sum(group,if(ds.phone_number<>'',1,0));
telephone_number_type  := sum(group,if(ds.telephone_number_type<>'',1,0));
phone2_number          := sum(group,if(ds.phone2_number<>'',1,0));
telephone2_number_type := sum(group,if(ds.telephone2_number_type<>'',1,0));
time_zone              := sum(group,if(ds.time_zone<>'',1,0));
refresh_date           := sum(group,if(ds.refresh_date<>'',1,0));
name_address_verification_source   := sum(group,if(ds.name_address_verification_source<>'',1,0));
drop_indicator         := sum(group,if(ds.drop_indicator<>'',1,0));
do_not_mail_flag       := sum(group,if(ds.do_not_mail_flag<>'',1,0));
do_not_call_flag       := sum(group,if(ds.do_not_call_flag<>'',1,0));
business_file_hit_flag := sum(group,if(ds.business_file_hit_flag<>'',1,0));
spouse_title           := sum(group,if(ds.spouse_title<>'',1,0));
spouse_fname           := sum(group,if(ds.spouse_fname<>'',1,0));
spouse_mname           := sum(group,if(ds.spouse_mname<>'',1,0));
spouse_lname           := sum(group,if(ds.spouse_lname<>'',1,0));
spouse_name_suffix     := sum(group,if(ds.spouse_name_suffix<>'',1,0));
spouse_fname_orig      := sum(group,if(ds.spouse_fname_orig<>'',1,0));
spouse_mname_orig      := sum(group,if(ds.spouse_mname_orig<>'',1,0));
spouse_lname_orig      := sum(group,if(ds.spouse_lname_orig<>'',1,0));
spouse_name_suffix_orig := sum(group,if(ds.spouse_name_suffix_orig<>'',1,0));
spouse_title_orig       := sum(group,if(ds.spouse_title_orig<>'',1,0));
spouse_gender           := sum(group,if(ds.spouse_gender<>'',1,0));
spouse_date_of_birth    := sum(group,if(ds.spouse_date_of_birth<>'',1,0));
spouse_indicator        := sum(group,if(ds.spouse_indicator<>'',1,0));
household_income        := sum(group,if(ds.household_income<>'',1,0));
find_income_in_1000s    := sum(group,if(ds.find_income_in_1000s<>'',1,0));
phhincomeunder25k       := sum(group,if(ds.phhincomeunder25k<>'',1,0));
phhincome50kplus        := sum(group,if(ds.phhincome50kplus<>'',1,0));
phhincome200kplus       := sum(group,if(ds.phhincome200kplus<>'',1,0));
medianhhincome          := sum(group,if(ds.medianhhincome<>'',1,0));
own_rent                := sum(group,if(ds.own_rent<>'',1,0));
homeowner_source_code   := sum(group,if(ds.homeowner_source_code<>'',1,0));
telephone_acquisition_date  := sum(group,if(ds.telephone_acquisition_date<>'',1,0));
recency_date            := sum(group,if(ds.recency_date<>'',1,0));
 END;


  
  tStats := table(ds,rSTRATA_PCNSR,st,few);

strata.createXMLStats(tStats,'PCNSR','data',filedate,'',resultsOut);
return resultsOut;
end;
