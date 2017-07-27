import ut;
m := File_MS_Full;
u := File_MS_Update;
boolean leads(string what, string wth) := wth = what[..length(trim(wth))];

string strip_lead(string num) :=
  MAP (
leads(num,'AFRV') =>'AFRV',
leads(num,'AIR') =>'AIR',
leads(num,'AL') =>'AL',
leads(num,'AM') =>'AM',
leads(num,'AK') =>'AK',
leads(num,'AP') =>'AP',
leads(num,'AQ') =>'AQ',
leads(num,'AR') =>'AR',
leads(num,'AT') =>'AT',
leads(num,'RLAU') =>'RLAU',
leads(num,'B10') =>'B10',
leads(num,'B 10') =>'B 10',
leads(num,'BS') =>'BS',
leads(num,'BTLR') =>'BTLR',
leads(num,'CBUS') =>'CBUS',
leads(num,'CD') =>'CD',
leads(num,'CF') =>'CF',
leads(num,'CL') =>'CL',
leads(num,'DB') =>'DB',
leads(num,'DC') =>'DC',
leads(num,'DD') =>'DD',
leads(num,'DF') =>'DF',
leads(num,'MCD') =>'MCD',
leads(num,'DOT') =>'DOT',
leads(num,'DU') =>'DU',
leads(num,'DAV') =>'DAV',
leads(num,'F10') =>'F10',
leads(num,'F 10') =>'F 10',
leads(num,'FIRE') =>'FIRE',
leads(num,'FL') =>'FL',
leads(num,'FL10') =>'FL10',
leads(num,'G') =>'G',
leads(num,'GL') =>'GL',
leads(num,'GM') =>'GM',
leads(num,'GV') =>'GV',
leads(num,'HST') =>'HST',
leads(num,'HM') =>'HM',
leads(num,'MHP') =>'MHP',
leads(num,'HRS') =>'HRS',
leads(num,'HREP') =>'HREP',
leads(num,'HTLR') =>'HTLR',
leads(num,'KIA') =>'KIA',
leads(num,'LEPO') =>'LEPO',
leads(num,'LESO') =>'LESO',
leads(num,'LEST') =>'LEST',
leads(num,'LG') =>'LG',
leads(num,'MA') =>'MA',
leads(num,'MC') =>'MC',
leads(num,'MOH') =>'MOH',
leads(num,'MV') =>'MV',
leads(num,'NC') =>'NC',
leads(num,'NG') =>'NG',
leads(num,'PHRB') =>'PHRB',
leads(num,'PHRT') =>'PHRT',
leads(num,'PSC') =>'PSC',
leads(num,'RLPU') =>'RLPU',
leads(num,'POW') =>'POW',
leads(num,'RFAF') =>'RFAF',
leads(num,'RFAR') =>'RFAR',
leads(num,'RFCG') =>'RFCG',
leads(num,'RFMC') =>'RFMC',
leads(num,'RFMM') =>'RFMM',
leads(num,'RFNG') =>'RFNG',
leads(num,'RFNA') =>'RFNA',
leads(num,'RFRV') =>'RFRV',
leads(num,'SBUS') =>'SBUS',
leads(num,'SC') =>'SC',
leads(num,'SEN') =>'SEN',
leads(num,'SL') =>'SL',
leads(num,'SHMC') =>'SHMC',
leads(num,'MNG') =>'MNG',
leads(num,'SO') =>num[1..4],
leads(num,'SR') =>'SR',
leads(num,'SS') =>'SS',
leads(num,'MCT') =>'MCT',
leads(num,'BTLR') =>'BTLR',
leads(num,'PTLR') =>'PTLR',
leads(num,'TAXI') =>'TAXI',
leads(num,'UH') =>'UH',
leads(num,'US') =>'US',
leads(num,'ASU') =>'ASU',
leads(num,'BC') =>'BC',
leads(num,'BMC') =>'BMC',
leads(num,'CCC') =>'CCC',
leads(num,'CLCC') =>'CLCC',
leads(num,'DSU') =>'DSU',
leads(num,'ECCC') =>'ECCC',
leads(num,'EMCC') =>'EMCC',
leads(num,'HICC') =>'HICC',
leads(num,'HOCC') =>'HOCC',
leads(num,'ICC') =>'ICC',
leads(num,'JSU') =>'JSU',
leads(num,'JCJC') =>'JCJC',
leads(num,'MBC') =>'MBC',
leads(num,'MHC') =>'MHC',
leads(num,'MCC') =>'MCC',
leads(num,'MLC') =>'MLC',
leads(num,'MSC') =>'MSC',
leads(num,'MDCC') =>'MDCC',
leads(num,'GCCC') =>'GCCC',
leads(num,'MSU') =>'MSU',
leads(num,'MUW') =>'MUW',
leads(num,'MVSU') =>'MVSU',
leads(num,'NECC') =>'NECC',
leads(num,'NWCC') =>'NWCC',
leads(num,'PRCC') =>'PRCC',
leads(num,'RC') =>'RC',
leads(num,'SMCC') =>'SMCC',
leads(num,'TC') =>'TC',
leads(num,'UM') =>'UM',
leads(num,'USM') =>'USM',
leads(num,'WCC') =>'WCC',
leads(num,'WC') =>'WC',
leads(num,'JSU') =>'JSU',
leads(num,'MSU') =>'MSU',
leads(num,'UM') =>'UM',
leads(num,'USM') =>'USM',
leads(num,'VFW') =>'VFW',
leads(num,'VR') =>'VR',
leads(num,'VET') =>'VET',
leads(num,'WLM') =>'WLM',
leads(num,'WLB') =>'WLB',
leads(num,'WLD') =>'WLD',
leads(num,'WLH') =>'WLH',
leads(num,'WLR') =>'WLR',
leads(num,'WLS') =>'WLS',
leads(num,'WLT') =>'WLT',
leads(num,'WLY') =>'WLY','' );
  
trans() := macro
self.vrid:= 0 ;
self.dt_first_seen:=(unsigned6)(le.process_date[1..6]);
self.dt_last_seen:=(unsigned6)(le.process_date[1..6]);
self.dt_vendor_first_reported:=(unsigned6)(le.process_date[1..6]);
self.dt_vendor_last_reported:=(unsigned6)(le.process_date[1..6]);
self.orig_state := 'MS';
self.VEHICLE_NUMBERxBG1:= le.title_num ;
self.ORIG_VIN:= le.vin;
self.FIRST_REGISTRATION_DATE:= if(ut.Date_MMDDYY_i2(le.purchase_date)<>0,(string8)ut.Date_MMDDYY_i2(le.purchase_date),'');
self.YEAR_MAKE:= if((unsigned1)le.veh_year<10,'20','19')+le.veh_year ;
self.MAKE_CODE:= le.veh_make ;
self.VEHICLE_TYPE:= le.veh_type ;
self.MODEL:= le.veh_mod ;
self.BODY_CODE:= le.veh_bod_style ;
self.VEHICLE_USE:= le.type_own_code ;
self.FUEL_TYPE:= le.fuel_type ;
self.GROSS_WEIGHT:= le.veh_gross_weight ;
self.LICENSE_PLATE_NUMBERxBG4:= le.tag_num[length(trim(strip_lead(le.tag_num)))+1..] ;
self.OWN_1_CUSTOMER_NAME:= le.title_own_name;
self.OWN_1_STREET_ADDRESS:= le.title_own_street ;
self.OWN_1_CITY:= le.title_own_city ;
self.OWN_1_STATE:= le.title_own_st ;
//self.OWN_1_ZIP5_ZIP4_FOREIGN_POSTAL:= le.title_own_zip_new ;
self.OWN_1_ZIP5_ZIP4_FOREIGN_POSTAL:= le.title_own_zip_new[1..5] +
									  if(trim(le.title_own_zip_new[6..9]) <> '' and trim(le.title_own_zip_new[6..9]) <> '0000',
									     '-' + le.title_own_zip_new[6..9],
										 ''
										);
//reformatting of zip code above
self.PLATE_ISSUE_DATE:= if(ut.Date_MMDDYY_i2(le.tag_issue_date)<>0,(string8)ut.Date_MMDDYY_i2(le.tag_issue_date),'');
self.DECAL_TYPE:= le.LST_REG_TRAN_TYP;
self.TRUE_LICENSE_PLSTE_NUMBER:= le.tag_num ;
self.REG_1_CUSTOMER_NAME:= le.reg_name ;
self.REG_1_STREET_ADDRESS:= le.reg_street ;
self.REG_1_CITY:= le.reg_city ;
self.REG_1_STATE:= le.reg_st ;
//self.REG_1_ZIP5_ZIP4_FOREIGN_POSTAL:= le.reg_zip_new ;
self.REG_1_ZIP5_ZIP4_FOREIGN_POSTAL:= le.reg_zip_new[1..5] + 
									  if(trim(le.reg_zip_new[6..9]) <> '' and trim(le.reg_zip_new[6..9]) <> '0000',
									     '-' + le.reg_zip_new[6..9],
										 ''
										);
//reformatting of zip code above
self.REG_1_RESIDENCE_COUNTY:= le.reg_county ;
self.TITLE_NUMBERxBG9:= le.title_num ;
self.TITLE_TRANSACTION_ID:= le.title_micro_num_new ;
self.TITLE_ISSUE_DATE:= if(ut.Date_MMDDYY_i2(le.title_issue_date)<>0,(string8)ut.Date_MMDDYY_i2(le.title_issue_date),'');
self.TITLE_STATUS_CODE:= le.title_stat ;
self.TITLE_TYPE:= le.LST_TITLE_TRANS_TYPE ;
self.SALVAGE_TYPE:= le.title_type ;
self.LH_1_LIEN_DATE:= if(ut.Date_MMDDYY_i2(le.ln_1_date)<>0,(string8)ut.Date_MMDDYY_i2(le.ln_1_date),'');
self.LH_1_CUSTOMER_NUMBER:= le.ln_1_num_new ;
self.LH_1_CUSTOMER_NAME := IF((unsigned8)le.ln_1_num_new<>0,'Lienholder Number:'+le.ln_1_num_new,'');
self.LH_2_CUSTOMER_NAME := IF((unsigned8)le.ln_2_num_new<>0,'Lienholder Number:'+le.ln_2_num_new,'');
self.LH_2_LEIN_DATE:= if(ut.Date_MMDDYY_i2(le.ln_2_date)<>0,(string8)ut.Date_MMDDYY_i2(le.ln_2_date),'');
self.LH_2_CUSTOMER_NUMBER:= le.ln_2_num_new  ;
self.own_1_title:= le.title_title1 ;
self.own_1_fname:= le.title_fname1 ;
self.own_1_mname:= le.title_mname1 ;
self.own_1_lname:= le.title_lname1 ;
self.own_1_name_suffix:= le.title_suffix1;
self.own_1_company_name:= le.title_company1 ;
self.own_2_title:= le.title_title2 ;
self.own_2_fname:= le.title_fname2 ;
self.own_2_mname:= le.title_mname2 ;
self.own_2_lname:= le.title_lname2 ;
self.own_2_name_suffix:= le.title_suffix2;
self.own_2_company_name:= le.title_company2 ;
self.own_1_prim_range:= le.title_prim_range ;
self.own_1_predir:= le.title_predir ;
self.own_1_prim_name:= le.title_prim_name ;
self.own_1_suffix:= le.title_addr_suffix ;
self.own_1_postdir:= le.title_postdir ;
self.own_1_unit_desig:= le.title_unit_desig ;
self.own_1_sec_range:= le.title_sec_range ;
self.own_1_p_city_name:= le.title_p_city_name ;
self.own_1_v_city_name:= le.title_v_city_name ;
self.own_1_state_2:= le.title_st ;
self.own_1_zip5:= le.title_zip ;
self.own_1_zip4:= le.title_zip4 ;
self.own_1_county:= le.title_county ;
self.own_1_geo_lat:= le.title_geo_lat ;
self.own_1_geo_long:= le.title_geo_long ;
self.reg_1_title:= le.reg_title1 ;
self.reg_1_fname:= le.reg_fname1 ;
self.reg_1_mname:= le.reg_mname1 ;
self.reg_1_lname:= le.reg_lname1 ;
self.reg_1_name_suffix:= le.reg_suffix1 ;
self.reg_1_company_name:= le.reg_company1 ;
self.reg_2_title:= le.reg_title2 ;
self.reg_2_fname:= le.reg_fname2 ;
self.reg_2_mname:= le.reg_mname2 ;
self.reg_2_lname:= le.reg_lname2 ;
self.reg_2_name_suffix:= le.reg_suffix2 ;
self.reg_2_company_name:= le.reg_company2 ;
self.reg_1_prim_range:= le.reg_prim_range ;
self.reg_1_predir:= le.reg_predir ;
self.reg_1_prim_name:= le.reg_prim_name ;
self.reg_1_suffix:= le.reg_addr_suffix ;
self.reg_1_postdir:= le.reg_postdir ;
self.reg_1_unit_desig:= le.reg_unit_desig ;
self.reg_1_sec_range:= le.reg_sec_range ;
self.reg_1_p_city_name:= le.reg_p_city_name ;
self.reg_1_v_city_name:= le.reg_v_city_name ;
self.reg_1_state_2:= le.reg_st ;
self.reg_1_zip5:= le.reg_zip5 ;
self.reg_1_zip4:= le.reg_zip4 ;
self.reg_1_county:= le.reg_county ;
self.reg_1_geo_lat:= le.reg_geo_lat ;
self.reg_1_geo_long:= le.reg_geo_long ;
  endmacro;

lDaysInMonthSet := ['31','28','31','30','31','30','31','31','30','31','30','31'];

string2 lLastDayOfMonth(string2 pMonthString)
 := lDaysInMonthSet[(integer1)pMonthString];

string8 lYMtoYMD(string4 pYearString, string2 pMonthString)
 := if((integer4)pYearString=0 or (integer4)pMonthString=0,
	   '',
	   pYearString+pMonthString+lLastDayOfMonth(pMonthString)
	  );

layout_vehicles intof(m le) := transform
self.price := intformat((unsigned8)le.msrp_val,8,1);
self.MINOR_COLOR_CODE:= le.veh_color2 ;
self.MAJOR_COLOR_CODE:= le.veh_color1 ;
self.FLEET_NUMBER:= le.indiv_fleet ;
self.ODOMETER_STATUS:= le.odometer_new[1..2] ;
self.ODOMETER_MILEAGE:= le.odometer_new[3..8] ;
self.OWN_1_RESIDENCE_COUNTY:= le.title_own_county ;
self.REGISTRATION_EXPIRATION_DATE:= if((integer4)(le.tag_exp_cen+le.tag_exp_year+le.tag_exp_month)<>0,lYMtoYMD(le.tag_exp_cen+le.tag_exp_year,le.tag_exp_month),'');
self.DECAL_NUMBER:= le.decal_num ;
self.REGISTRATION_STATUS_CODE:= le.tag_stat ;
self.ACTIVITY_DATExBG6:= if((integer4)(le.last_cics_upd_cen+le.last_cics_upd_new)<>0,le.last_cics_upd_cen+le.last_cics_upd_new,'');
self.ACTIVITY_COUNTY:= le.cnty_off ;
self.PREVIOUS_TITLE_STATE:= le.prev_tag_state ;
self.LIEN_COUNTxBG10:= le.num_lein ;
self.LICENSE_PLATE_CODE:= IF ( strip_lead(le.tag_num) = '', le.tag_type, strip_lead(le.tag_num) ) ;
  trans()
  end;

layout_vehicles intof_u(u le) := transform
self.MINOR_COLOR_CODE:= le.veh_color1[2] ;
self.MAJOR_COLOR_CODE:= le.veh_color1[1] ;
self.LICENSE_PLATE_CODE:= strip_lead(le.tag_num);
self.odometer_status := le.odom_code;
self.odometer_mileage := le.odometer;
self.registration_expiration_date:= 
  if((integer4)(le.reg_exp_yr+le.tag_exp_mo)<>0,
	 MAP((unsigned1)le.tag_exp_mo=0 and (unsigned1)le.reg_exp_yr=0 => '00',
	     (unsigned1)le.reg_exp_yr<10 => '20',
		 '19')+le.reg_exp_yr+ le.tag_exp_mo+lLastDayOfMonth(le.tag_exp_mo),
	 ''
    );
  trans()
  end;

main_p := project(m(master_rec_stat<>''),intof(left));
main_u := project(u,intof_u(left));

layout_vehicles patch(layout_vehicles le) := transform
  self.LICENSE_PLATE_NUMBERxBG4:= 
    if ( stringlib.stringfind(le.LICENSE_PLATE_NUMBERxBG4,' 000',1) = 0,
         trim(le.license_plate_numberxbg4,all),
         le.LICENSE_PLATE_NUMBERxBG4[..stringlib.stringfind(le.LICENSE_PLATE_NUMBERxBG4,' 000',1)-1]
         +
         le.LICENSE_PLATE_NUMBERxBG4[stringlib.stringfind(le.LICENSE_PLATE_NUMBERxBG4,' 000',1)+4..]);

  self.own_1_zip5 := if ( (unsigned4)le.own_1_zip5=0,'',le.own_1_zip5 );
  self := le;
  end;

export MS_as_Vehicles := project(main_u+main_p,patch(left));