
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

temp_rec := record 
 d ; 
 integer cnt_seq := 0  ; 
 end ; 
 
 temp_rec reformat( d l) := transform 
 
 self := l ; 
 end; 
  
 d_proj :=  project(d , reformat(left)); 
 d_dist := distribute(d_proj,  hash(source_st,vendor,profession_or_board)); 
 d_sort      := sort(d_dist, source_st,vendor,profession_or_board,local); 
 d_sort_grpd := group(d_sort, source_st,vendor,profession_or_board,local);

d_sort_grpd tkeepflag(d_sort_grpd L, d_sort_grpd R,integer cnt = 10) := transform

  self.cnt_seq := cnt+1 ;                  
  self := R;

end;
sample_out := GROUP(iterate(d_sort_grpd, tkeepflag(left, right,counter)));
//output(sample_out) ; 
output(count(sample_out));
output(count(sample_out(cnt_seq <= 10)));
output(choosen(sample_out(cnt_seq <= 10),2000)) ;
output(choosen(sample_out(cnt_seq <= 10),2994,2001)) ;
export Prof_License_QA_SAMPLE_records  := output(sample_out(cnt_seq <= 10)) ;
