
import Prof_license;
dPrev	:= 	dataset('~thor_data400::base::prof_licenses_aid_father',layout_prolic_out_with_AID,flat);
dNew :=   dataset('~thor_data400::base::prof_licenses_AID',layout_prolic_out_with_AID,flat);

rSlim
 :=
  record
typeof(dPrev.date_first_seen) date_first_seen;
typeof(dPrev.date_last_seen) date_last_seen;
typeof(dPrev.profession_or_board) profession_or_board;
typeof(dPrev.license_type) license_type;
typeof(dPrev.status) status;
typeof(dPrev.orig_license_number) orig_license_number;
typeof(dPrev.license_number) license_number;
typeof(dPrev.previous_license_number) previous_license_number;
typeof(dPrev.previous_license_type) previous_license_type;
typeof(dPrev.company_name) company_name;
typeof(dPrev.orig_name) orig_name;
typeof(dPrev.name_order) name_order;
typeof(dPrev.orig_former_name) orig_former_name;
typeof(dPrev.former_name_order) former_name_order;
typeof(dPrev.orig_addr_1) orig_addr_1;
typeof(dPrev.orig_addr_2) orig_addr_2;
typeof(dPrev.orig_addr_3) orig_addr_3;
typeof(dPrev.orig_addr_4) orig_addr_4;
typeof(dPrev.orig_city) orig_city;
typeof(dPrev.orig_st) orig_st;
typeof(dPrev.orig_zip) orig_zip;
typeof(dPrev.county_str) county_str;
typeof(dPrev.country_str) country_str;
typeof(dPrev.business_flag) business_flag;
typeof(dPrev.phone) phone;
typeof(dPrev.sex) sex;
typeof(dPrev.dob) dob;
typeof(dPrev.issue_date) issue_date;
typeof(dPrev.expiration_date) expiration_date;
typeof(dPrev.last_renewal_date) last_renewal_date;
typeof(dPrev.license_obtained_by) license_obtained_by;
typeof(dPrev.board_action_indicator) board_action_indicator;
typeof(dPrev.source_st) source_st;
typeof(dPrev.vendor) vendor;
typeof(dPrev.action_record_type) action_record_type;
typeof(dPrev.action_complaint_violation_cds) action_complaint_violation_cds;
typeof(dPrev.action_complaint_violation_desc) action_complaint_violation_desc;
typeof(dPrev.action_complaint_violation_dt) action_complaint_violation_dt;
typeof(dPrev.action_case_number) action_case_number;
typeof(dPrev.action_effective_dt) action_effective_dt;
typeof(dPrev.action_cds) action_cds;
typeof(dPrev.action_desc) action_desc;
typeof(dPrev.action_final_order_no) action_final_order_no;
typeof(dPrev.action_status) action_status;
typeof(dPrev.action_posting_status_dt) action_posting_status_dt;
typeof(dPrev.action_original_filename_or_url) action_original_filename_or_url;
typeof(dPrev.additional_name_addr_type) additional_name_addr_type;
typeof(dPrev.additional_orig_name) additional_orig_name;
typeof(dPrev.additional_name_order) additional_name_order;
typeof(dPrev.additional_orig_additional_1) additional_orig_additional_1;
typeof(dPrev.additional_orig_additional_2) additional_orig_additional_2;
typeof(dPrev.additional_orig_additional_3) additional_orig_additional_3;
typeof(dPrev.additional_orig_additional_4) additional_orig_additional_4;
typeof(dPrev.additional_orig_city) additional_orig_city;
typeof(dPrev.additional_orig_st) additional_orig_st;
typeof(dPrev.additional_orig_zip) additional_orig_zip;
typeof(dPrev.additional_phone) additional_phone;
typeof(dPrev.misc_occupation) misc_occupation;
typeof(dPrev.misc_practice_hours) misc_practice_hours;
typeof(dPrev.misc_practice_type) misc_practice_type;
typeof(dPrev.misc_email) misc_email;
typeof(dPrev.misc_fax) misc_fax;
typeof(dPrev.misc_web_site) misc_web_site;
typeof(dPrev.misc_other_id) misc_other_id;
typeof(dPrev.misc_other_id_type) misc_other_id_type;
typeof(dPrev.education_continuing_education) education_continuing_education;
typeof(dPrev.education_1_school_attended) education_1_school_attended;
typeof(dPrev.education_1_dates_attended) education_1_dates_attended;
typeof(dPrev.education_1_curriculum) education_1_curriculum;
typeof(dPrev.education_1_degree) education_1_degree;
typeof(dPrev.education_2_school_attended) education_2_school_attended;
typeof(dPrev.education_2_dates_attended) education_2_dates_attended;
typeof(dPrev.education_2_curriculum) education_2_curriculum;
typeof(dPrev.education_2_degree) education_2_degree;
typeof(dPrev.education_3_school_attended) education_3_school_attended;
typeof(dPrev.education_3_dates_attended) education_3_dates_attended;
typeof(dPrev.education_3_curriculum) education_3_curriculum;
typeof(dPrev.education_3_degree) education_3_degree;
typeof(dPrev.additional_licensing_specifics) additional_licensing_specifics;
typeof(dPrev.personal_pob_cd) personal_pob_cd;
typeof(dPrev.personal_pob_desc) personal_pob_desc;
typeof(dPrev.personal_race_cd) personal_race_cd;
typeof(dPrev.personal_race_desc) personal_race_desc;
typeof(dPrev.status_status_cds) status_status_cds;
typeof(dPrev.status_effective_dt) status_effective_dt;
typeof(dPrev.status_renewal_desc) status_renewal_desc;
typeof(dPrev.status_other_agency) status_other_agency;

  end
 ;

rSlim	tSlimIt(dPrev pInput)
 :=
  transform
	self	:= pInput;
  end
 ;

dPrevSlim	:= project(dPrev,tSlimIt(left));
dNewSlim	:= project(dNew,tSlimIt(left));


dPrevDist	:= distribute(dPrevSlim,hash(source_st,vendor,profession_or_board,license_number,company_name,orig_name));
dPrevSort	:= sort(dPrevDist,source_st,vendor,profession_or_board,license_number,company_name,orig_name,date_first_seen,date_last_seen,local);




dNewDist	:= distribute(dNewSlim,hash(source_st,vendor,profession_or_board,license_number,company_name,orig_name));
dNewSort	:= sort(dNewDist,source_st,vendor,profession_or_board,license_number,company_name,orig_name,date_first_seen,date_last_seen,local);


rSlim	tNewOnly(dPrevSort pPrev, dNewSort pNew)
 :=
  transform
	self	:= pNew;
  end
 ;


dNewOnly	:= join(dPrevSort,dNewSort,
					left.source_st = right.source_st and
					left.vendor = right.vendor and 
					left.profession_or_board = right.profession_or_board and
					left.orig_license_number = right.orig_license_number and
					left.license_number = right.license_number and
					left.company_name = right.company_name and
					left.orig_name = right.orig_name and 
					left.date_first_seen = right.date_first_seen and
					left.date_last_seen = right.date_last_seen,
					tNewOnly(left,right),
					Right only, local
				    );
					


d	:= dNewOnly;


stat_rec :=  record
d.source_st;
d.vendor;
d.profession_or_board;
date_last_seen := MAX(group,d.date_last_seen);
totalrecs := count(group);
MINdate := MIN(group,if(d.issue_date<>'',d.issue_date,'99999999'));
MAXdate := MAX(group,if(d.issue_date<>'',d.issue_date,'00000000'));

has_profession_or_board := AVE(group,IF(stringlib.stringfilterout(d.profession_or_board,'0')<>'',100,0));
has_license_type := AVE(group,IF(stringlib.stringfilterout(d.license_type,'0')<>'',100,0));
has_status := AVE(group,IF(stringlib.stringfilterout(d.status,'0')<>'',100,0));
has_orig_license_number := AVE(group,IF(stringlib.stringfilterout(d.orig_license_number,'0')<>'',100,0));
has_license_number := AVE(group,IF(stringlib.stringfilterout(d.license_number,'0')<>'',100,0));
has_previous_license_number := AVE(group,IF(stringlib.stringfilterout(d.previous_license_number,'0')<>'',100,0));
has_previous_license_type := AVE(group,IF(stringlib.stringfilterout(d.previous_license_type,'0')<>'',100,0));
has_company_name := AVE(group,IF(stringlib.stringfilterout(d.company_name,'0')<>'',100,0));
has_orig_name := AVE(group,IF(stringlib.stringfilterout(d.orig_name,'0')<>'',100,0));
has_name_order := AVE(group,IF(stringlib.stringfilterout(d.name_order,'0')<>'',100,0));
has_orig_former_name := AVE(group,IF(stringlib.stringfilterout(d.orig_former_name,'0')<>'',100,0));
has_former_name_order := AVE(group,IF(stringlib.stringfilterout(d.former_name_order,'0')<>'',100,0));
has_orig_addr_1 := AVE(group,IF(stringlib.stringfilterout(d.orig_addr_1,'0')<>'',100,0));
has_orig_addr_2 := AVE(group,IF(stringlib.stringfilterout(d.orig_addr_2,'0')<>'',100,0));
has_orig_addr_3 := AVE(group,IF(stringlib.stringfilterout(d.orig_addr_3,'0')<>'',100,0));
has_orig_addr_4 := AVE(group,IF(stringlib.stringfilterout(d.orig_addr_4,'0')<>'',100,0));
has_orig_city := AVE(group,IF(stringlib.stringfilterout(d.orig_city,'0')<>'',100,0));
has_orig_st := AVE(group,IF(stringlib.stringfilterout(d.orig_st,'0')<>'',100,0));
has_orig_zip := AVE(group,IF(stringlib.stringfilterout(d.orig_zip,'0')<>'',100,0));
has_county_str := AVE(group,IF(stringlib.stringfilterout(d.county_str,'0')<>'',100,0));
has_country_str := AVE(group,IF(stringlib.stringfilterout(d.country_str,'0')<>'',100,0));
has_business_flag := AVE(group,IF(stringlib.stringfilterout(d.business_flag,'0')<>'',100,0));
has_phone := AVE(group,IF(stringlib.stringfilterout(d.phone,'0')<>'',100,0));
has_sex := AVE(group,IF(stringlib.stringfilterout(d.sex,'0')<>'',100,0));
has_dob := AVE(group,IF(stringlib.stringfilterout(d.dob,'0')<>'',100,0));
has_issue_date := AVE(group,IF(stringlib.stringfilterout(d.issue_date,'0')<>'',100,0));
has_expiration_date := AVE(group,IF(stringlib.stringfilterout(d.expiration_date,'0')<>'',100,0));
has_last_renewal_date := AVE(group,IF(stringlib.stringfilterout(d.last_renewal_date,'0')<>'',100,0));
has_license_obtained_by := AVE(group,IF(stringlib.stringfilterout(d.license_obtained_by,'0')<>'',100,0));
has_board_action_indicator := AVE(group,IF(stringlib.stringfilterout(d.board_action_indicator,'0')<>'',100,0));
has_source_st := AVE(group,IF(stringlib.stringfilterout(d.source_st,'0')<>'',100,0));
has_vendor := AVE(group,IF(stringlib.stringfilterout(d.vendor,'0')<>'',100,0));
has_action_record_type := AVE(group,IF(stringlib.stringfilterout(d.action_record_type,'0')<>'',100,0));
has_action_complaint_violation_cds := AVE(group,IF(stringlib.stringfilterout(d.action_complaint_violation_cds,'0')<>'',100,0));
has_action_complaint_violation_desc := AVE(group,IF(stringlib.stringfilterout(d.action_complaint_violation_desc,'0')<>'',100,0));
has_action_complaint_violation_dt := AVE(group,IF(stringlib.stringfilterout(d.action_complaint_violation_dt,'0')<>'',100,0));
has_action_case_number := AVE(group,IF(stringlib.stringfilterout(d.action_case_number,'0')<>'',100,0));
has_action_effective_dt := AVE(group,IF(stringlib.stringfilterout(d.action_effective_dt,'0')<>'',100,0));
has_action_cds := AVE(group,IF(stringlib.stringfilterout(d.action_cds,'0')<>'',100,0));
has_action_desc := AVE(group,IF(stringlib.stringfilterout(d.action_desc,'0')<>'',100,0));
has_action_final_order_no := AVE(group,IF(stringlib.stringfilterout(d.action_final_order_no,'0')<>'',100,0));
has_action_status := AVE(group,IF(stringlib.stringfilterout(d.action_status,'0')<>'',100,0));
has_action_posting_status_dt := AVE(group,IF(stringlib.stringfilterout(d.action_posting_status_dt,'0')<>'',100,0));
has_action_original_filename_or_url := AVE(group,IF(stringlib.stringfilterout(d.action_original_filename_or_url,'0')<>'',100,0));
has_additional_name_addr_type := AVE(group,IF(stringlib.stringfilterout(d.additional_name_addr_type,'0')<>'',100,0));
has_additional_orig_name := AVE(group,IF(stringlib.stringfilterout(d.additional_orig_name,'0')<>'',100,0));
has_additional_name_order := AVE(group,IF(stringlib.stringfilterout(d.additional_name_order,'0')<>'',100,0));
has_additional_orig_additional_1 := AVE(group,IF(stringlib.stringfilterout(d.additional_orig_additional_1,'0')<>'',100,0));
has_additional_orig_additional_2 := AVE(group,IF(stringlib.stringfilterout(d.additional_orig_additional_2,'0')<>'',100,0));
has_additional_orig_additional_3 := AVE(group,IF(stringlib.stringfilterout(d.additional_orig_additional_3,'0')<>'',100,0));
has_additional_orig_additional_4 := AVE(group,IF(stringlib.stringfilterout(d.additional_orig_additional_4,'0')<>'',100,0));
has_additional_orig_city := AVE(group,IF(stringlib.stringfilterout(d.additional_orig_city,'0')<>'',100,0));
has_additional_orig_st := AVE(group,IF(stringlib.stringfilterout(d.additional_orig_st,'0')<>'',100,0));
has_additional_orig_zip := AVE(group,IF(stringlib.stringfilterout(d.additional_orig_zip,'0')<>'',100,0));
has_additional_phone := AVE(group,IF(stringlib.stringfilterout(d.additional_phone,'0')<>'',100,0));
has_misc_occupation := AVE(group,IF(stringlib.stringfilterout(d.misc_occupation,'0')<>'',100,0));
has_misc_practice_hours := AVE(group,IF(stringlib.stringfilterout(d.misc_practice_hours,'0')<>'',100,0));
has_misc_practice_type := AVE(group,IF(stringlib.stringfilterout(d.misc_practice_type,'0')<>'',100,0));
has_misc_email := AVE(group,IF(stringlib.stringfilterout(d.misc_email,'0')<>'',100,0));
has_misc_fax := AVE(group,IF(stringlib.stringfilterout(d.misc_fax,'0')<>'',100,0));
has_misc_web_site := AVE(group,IF(stringlib.stringfilterout(d.misc_web_site,'0')<>'',100,0));
has_misc_other_id := AVE(group,IF(stringlib.stringfilterout(d.misc_other_id,'0')<>'',100,0));
has_misc_other_id_type := AVE(group,IF(stringlib.stringfilterout(d.misc_other_id_type,'0')<>'',100,0));
has_education_continuing_education := AVE(group,IF(stringlib.stringfilterout(d.education_continuing_education,'0')<>'',100,0));
has_education_1_school_attended := AVE(group,IF(stringlib.stringfilterout(d.education_1_school_attended,'0')<>'',100,0));
has_education_1_dates_attended := AVE(group,IF(stringlib.stringfilterout(d.education_1_dates_attended,'0')<>'',100,0));
has_education_1_curriculum := AVE(group,IF(stringlib.stringfilterout(d.education_1_curriculum,'0')<>'',100,0));
has_education_1_degree := AVE(group,IF(stringlib.stringfilterout(d.education_1_degree,'0')<>'',100,0));
has_education_2_school_attended := AVE(group,IF(stringlib.stringfilterout(d.education_2_school_attended,'0')<>'',100,0));
has_education_2_dates_attended := AVE(group,IF(stringlib.stringfilterout(d.education_2_dates_attended,'0')<>'',100,0));
has_education_2_curriculum := AVE(group,IF(stringlib.stringfilterout(d.education_2_curriculum,'0')<>'',100,0));
has_education_2_degree := AVE(group,IF(stringlib.stringfilterout(d.education_2_degree,'0')<>'',100,0));
has_education_3_school_attended := AVE(group,IF(stringlib.stringfilterout(d.education_3_school_attended,'0')<>'',100,0));
has_education_3_dates_attended := AVE(group,IF(stringlib.stringfilterout(d.education_3_dates_attended,'0')<>'',100,0));
has_education_3_curriculum := AVE(group,IF(stringlib.stringfilterout(d.education_3_curriculum,'0')<>'',100,0));
has_education_3_degree := AVE(group,IF(stringlib.stringfilterout(d.education_3_degree,'0')<>'',100,0));
has_additional_licensing_specifics := AVE(group,IF(stringlib.stringfilterout(d.additional_licensing_specifics,'0')<>'',100,0));
has_personal_pob_cd := AVE(group,IF(stringlib.stringfilterout(d.personal_pob_cd,'0')<>'',100,0));
has_personal_pob_desc := AVE(group,IF(stringlib.stringfilterout(d.personal_pob_desc,'0')<>'',100,0));
has_personal_race_cd := AVE(group,IF(stringlib.stringfilterout(d.personal_race_cd,'0')<>'',100,0));
has_personal_race_desc := AVE(group,IF(stringlib.stringfilterout(d.personal_race_desc,'0')<>'',100,0));
has_status_status_cds := AVE(group,IF(stringlib.stringfilterout(d.status_status_cds,'0')<>'',100,0));
has_status_effective_dt := AVE(group,IF(stringlib.stringfilterout(d.status_effective_dt,'0')<>'',100,0));
has_status_renewal_desc := AVE(group,IF(stringlib.stringfilterout(d.status_renewal_desc,'0')<>'',100,0));
has_status_other_agency := AVE(group,IF(stringlib.stringfilterout(d.status_other_agency,'0')<>'',100,0));
end;

stats := table(d,stat_rec,source_st,vendor,profession_or_board,few);

stats_sorted := sort(stats,source_st,vendor,profession_or_board);

export Prof_License_NewRelease_stats := output(choosen(stats_sorted, 10000)); 
