Layout_Common_Crim_Offender_new := RECORD
  string8 process_date;
  string8 file_date;
  string60 offender_key;
  string5 vendor;
  string20 source_file;
  string2 record_type;
  string25 orig_state;
  string15 id_num;
  string56 pty_nm;
  string1 pty_nm_fmt;
  string20 orig_lname;
  string20 orig_fname;
  string20 orig_mname;
  string10 orig_name_suffix;
  string20 lname;
  string20 fname;
  string20 mname;
  string6 name_suffix;
  string1 pty_typ;
  unsigned8 nid;
  string1 ntype;
  unsigned2 nindicator;
  string1 nitro_flag;
  string9 ssn;
  string35 case_num;
  string40 case_court;
  string8 case_date;
  string5 case_type;
  string25 case_type_desc;
  string30 county_of_origin;
  string10 dle_num;
  string9 fbi_num;
  string10 doc_num;
  string10 ins_num;
  string25 dl_num;
  string2 dl_state;
  string2 citizenship;
  string8 dob;
  string8 dob_alias;
  string13 county_of_birth;
  string25 place_of_birth;
  string25 street_address_1;
  string25 street_address_2;
  string25 street_address_3;
  string10 street_address_4;
  string10 street_address_5;
  string13 current_residence_county;
  string13 legal_residence_county;
  string3 race;
  string30 race_desc;
  string7 sex;
  string3 hair_color;
  string15 hair_color_desc;
  string3 eye_color;
  string15 eye_color_desc;
  string3 skin_color;
  string15 skin_color_desc;
  string10 scars_marks_tattoos_1;
  string10 scars_marks_tattoos_2;
  string10 scars_marks_tattoos_3;
  string10 scars_marks_tattoos_4;
  string10 scars_marks_tattoos_5;
  string3 height;
  string3 weight;
  string5 party_status;
  string60 party_status_desc;
  string10 _3g_offender;
  string10 violent_offender;
  string10 sex_offender;
  string10 vop_offender;
  string1 data_type;
  string26 record_setup_date;
  string45 datasource;
  qstring10 prim_range;
  string2 predir;
  qstring28 prim_name;
  qstring4 addr_suffix;
  string2 postdir;
  qstring10 unit_desig;
  qstring8 sec_range;
  qstring25 p_city_name;
  qstring25 v_city_name;
  string2 st;
  qstring5 zip5;
  qstring4 zip4;
  string4 cart;
  string1 cr_sort_sz;
  string4 lot;
  string1 lot_order;
  string2 dpbc;
  string1 chk_digit;
  string2 rec_type;
  string2 ace_fips_st;
  string3 ace_fips_county;
  string10 geo_lat;
  string11 geo_long;
  string4 msa;
  string7 geo_blk;
  string1 geo_match;
  string4 err_stat;
  unsigned1 clean_errors;
  string18 county_name;
  string12 did;
  string3 score;
  string9 ssn_appended;
  string1 curr_incar_flag;
  string1 curr_parole_flag;
  string1 curr_probation_flag;
  string8 src_upload_date;
  string3 age;
  string150 image_link;
  string1 fcra_conviction_flag;
  string1 fcra_traffic_flag;
  string8 fcra_date;
  string1 fcra_date_type;
  string8 conviction_override_date;
  string1 conviction_override_date_type;
  string2 offense_score;
  unsigned8 offender_persistent_id;
 END;

	
#workunit('name','New Crim Offender Keys');

      
dPrev    := dataset('~thor_data400::base::corrections_offenders_public_father', Layout_Common_Crim_Offender_new,flat);
dNew     := dataset('~thor_data400::base::corrections_offenders_public', Layout_Common_Crim_Offender_new,flat);

rSlim
:=
  record
                typeof(dPrev.source_file)           source_file;
                typeof(dPrev.offender_key)     offender_key;
  end
;

rSlim      tSlimIt(dPrev pInput)
:=
  transform
                self         := pInput;
  end
;

dPrevSlim            := project(dPrev,tSlimIt(left));
dNewSlim           := project(dNew,tSlimIt(left));

dPrevDist            := distribute(dPrevSlim,hash(offender_key));
dPrevSort            := sort(dPrevDist,offender_key,local);
dPrevDedup      := dedup(dPrevSort,offender_key,local);
dNewDist            := distribute(dNewSlim,hash(offender_key));
dNewSort           := sort(dNewDist,offender_key,local);
dNewDedup      := dedup(dNewSort,offender_key,local);

rSlim      tNewOnly(/*dPrevDedup pPrev,*/ dNewDedup pNew)
:=
  transform
                self         := pNew;
  end
;

dNewOnly          := join(dPrevDedup,dNewDedup,
                                                                                left.offender_key = right.offender_key,
                                                                                tNewOnly(/*left,*/right),
                                                                                right only,
                                                                                local
                                                                   );

dNewOnlySort  := sort(dNewOnly,source_file);
dNewOnlyDedup             := dedup(dNewOnlySort,source_file,keep(10));

output(choosen(dNewOnlyDedup,all));


 
