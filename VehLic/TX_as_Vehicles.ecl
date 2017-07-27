import ut;
i := VehLic.File_TX_Raw;

isname(string bnf, string fname, string lname) := bnf = '' and fname <> '' and lname <> '';

string10 lFormatZipAndZip4(string5 pZip5,string4 pZip4)
 := IF(pZip5='',
	   '',
	   pZip5 + if(trim(pZip4)<>'' and trim(pZip4)<>'0000',
				  '-'+pZip4,
				  ''
				 )
	  )
;

isbiz(string bnf) := bnf <> '';
shouldseparate(string bnf1, string fname1, string lname1,
			   string bnf2, string fname2, string lname2) := 
	(isname(bnf1, fname1, lname1) and isname(bnf2, fname2, lname2));

strAddr(le) := macro
	if(shouldseparate(le.ownrttlname1_bnf, le.ownrttlname1_fname, le.ownrttlname1_lname,
					  le.ownrttlname2_bnf, le.ownrttlname2_fname, le.ownrttlname2_lname),
	   le.ownrttlname2,
	   '')
  endmacro;

do_bulk(a) := macro
self.orig_state:='TX';
self.price := le.vehsalesprice;
self.VEHICLE_NUMBERxBG1:= le.docno;
self.ORIG_VIN:= le.vin;
self.YEAR_MAKE:= le.vehmodlyr;
self.MAKE_CODE:= le.vehmk; // need to see
self.VEHICLE_TYPE:='';  // self.VEHICLE_TYPE:=le.vehmodl;
self.MODEL:= le.vehmodl;
self.BODY_CODE:=le.vehbdytype;
self.FUEL_TYPE:=le.dieselindi; // need to map
self.ODOMETER_MILEAGE:=le.vehodmtrreading;
self.NET_WEIGHT:=le.vehemptywt;
self.GROSS_WEIGHT:=le.vehgrosswt;
self.LENGTH_FEET:=le.vehlngth;
self.OWN_1_FEID_SSN:=le.ownrid;
self.OWN_1_CUSTOMER_NAME:= 
	if(shouldseparate(le.ownrttlname1_bnf, le.ownrttlname1_fname, le.ownrttlname1_lname,
					  le.ownrttlname2_bnf, le.ownrttlname2_fname, le.ownrttlname2_lname),
	   le.ownrttlname1,
	   trim(le.ownrttlname1) + ' ' + trim(le.ownrttlname2));

self.OWN_1_ADDR_NON_DISCLOSURE_FLAG:=le.privacyoptcd;
self.OWN_1_STREET_ADDRESS:=trim(le.ownrst1)+' '+trim(le.ownrst2);
self.OWN_1_CITY:=le.ownrcity;
self.OWN_1_STATE:=le.ownrstate;
self.OWN_1_ZIP5_ZIP4_FOREIGN_POSTAL:=lFormatZipAndZip4(le.ownrzpcd,le.ownrzpcdp4);
self.OWN_2_CUSTOMER_NAME:= strAddr(le);
self.OWN_2_ADDR_NON_DISCLOSURE_FLAG:= if (strAddr(le) = '', '', le.privacyoptcd);
self.OWN_2_STREET_ADDRESS:=if (strAddr(le) = '', '', trim(le.ownrst1)+' '+trim(le.ownrst2));
self.OWN_2_CITY:=if (strAddr(le) = '', '', le.ownrcity);
self.OWN_2_STATE:=if (strAddr(le) = '', '', le.ownrstate);
self.OWN_2_ZIP5_ZIP4_FOREIGN_POSTAL:=if(strAddr(le) = '',
									    '',
										lFormatZipAndZip4(le.ownrzpcd,le.ownrzpcdp4));
self.LICENSE_PLATE_NUMBERxBG4:=le.regpltno;
self.REGISTRATION_EFFECTIVE_DATE:=le.regeffdate;
self.REGISTRATION_EXPIRATION_DATE:=le.regexpyr+le.regexpmo;
self.VEHICLE_CLASS_CODE:=le.regclasscd;
self.DECAL_NUMBER:=le.regstrkrno;
self.TRUE_LICENSE_PLSTE_NUMBER:=le.regpltno;
self.EMISSIONS_INSPECTION_STATUSxBG8:=le.dotstndrdsindi;
self.TITLE_NUMBERxBG9:=le.docno;
self.TITLE_ISSUE_DATE:=le.ttlissuedate;
self.TITLE_STATUS_CODE:=le.ttlprocscd;
self.PREVIOUS_TITLE_STATE:=le.othrstatecntry;
self.TITLE_PENDING_FLAG:=le.bndedttlcd;
self.DUPLICATE_TITLE_FLAG:= le.priorccoissueindi;
self.LIEN_COUNTxBG10:=le.lh_count;
self.LH_1_LIEN_DATE:=le.lh1_date;
self.LH_1_CUSTOMER_NUMBER:=le.lh1_number;
self.LH_2_LEIN_DATE:=le.lh2_date;
self.LH_2_CUSTOMER_NUMBER:=le.lh2_number;
self.LH_3_LIEN_DATE:=le.lh3_date;
self.LH_3_CUSTOMER_NUMBER:=le.lh3_number;
self.own_1_title:= le.ownrttlname1_title;
self.own_1_fname:=le.ownrttlname1_fname;
self.own_1_mname:=le.ownrttlname1_mname;
self.own_1_lname:=le.ownrttlname1_lname;
self.own_1_name_suffix:=le.ownrttlname1_name_suffix;
self.own_1_company_name:=le.ownrttlname1_company_name;
self.own_1_prim_range:=le.ownrttlname_prim_range;
self.own_1_predir:=le.ownrttlname_predir;
self.own_1_prim_name:=le.ownrttlname_prim_name;
self.own_1_suffix:=le.ownrttlname_addr_suffix;
self.own_1_postdir:=le.ownrttlname_postdir;
self.own_1_unit_desig:=le.ownrttlname_unit_desig;
self.own_1_sec_range:=le.ownrttlname_sec_range;
self.own_1_p_city_name:=le.ownrttlname_p_city_name;
self.own_1_v_city_name:=le.ownrttlname_v_city_name;
self.own_1_state_2:=le.ownrttlname_state;
self.own_1_zip5:=le.ownrttlname_zip5;
self.own_1_zip4:=le.ownrttlname_zip4;
self.own_1_county:=le.ownrttlname_county;
self.own_1_geo_lat:=le.ownrttlname_geo_lat;
self.own_1_geo_long:=le.ownrttlname_geo_long;
self.own_2_title:=le.ownrttlname2_title;
self.own_2_fname:=le.ownrttlname2_fname;
self.own_2_mname:=le.ownrttlname2_mname;
self.own_2_lname:=le.ownrttlname2_lname;
self.own_2_name_suffix:=le.ownrttlname2_name_suffix;
self.reg_1_title:=le.co_name_title;
self.reg_1_fname:=le.co_name_fname;
self.reg_1_mname:=le.co_name_mname;
self.reg_1_lname:=le.co_name_lname;
self.reg_1_name_suffix:=le.co_name_name_suffix;
self.reg_1_company_name:=le.co_name_company_name;
  endmacro;

Layout_Vehicles intof(Layout_TX_Raw Le) := transform
self.dt_first_seen:= 200206;
self.dt_last_seen:=200206;
self.dt_vendor_first_reported:=200206;
self.dt_vendor_last_reported:=200206;
self.seq_no:= (unsigned4)le.seq_no;
do_bulk(1)
  end;

fpass := project(i,intof(left));

layout_vehicles add_lh1(layout_vehicles le, File_TX_Lien ri) := transform
self.LH_1_CUSTOMER_NAME:=trim(ri.lienhldrname1)+' '+ri.lienhldrname2;
self.LH_1_STREET_ADDRESS:=trim(ri.lienhldrst1)+' '+ri.lienhldrst2;
self.LH_1_CITY:=ri.lienhldrcity;
self.LH_1_STATE:=ri.lienhldrstate;
self.LH_1_ZIP5_ZIP4_FOREIGN_POSTAL:=lFormatZipAndZip4(ri.lienhldrzpcd,ri.lienhldrzpcd4);
  self := le;
  end;

j1 := join(fpass,File_TX_Lien,(integer)left.LH_1_CUSTOMER_NUMBER=(integer)right.lienhldrno,
                                 add_lh1(left,right),lookup,left outer);

layout_vehicles add_lh2(layout_vehicles le, File_TX_Lien ri) := transform
self.LH_2_CUSTOMER_NAME:=trim(ri.lienhldrname1)+' '+ri.lienhldrname2;
self.LH_2_STREET_ADDRESS:=trim(ri.lienhldrst1)+' '+ri.lienhldrst2;
self.LH_2_CITY:=ri.lienhldrcity;
self.LH_2_STATE:=ri.lienhldrstate;
self.LH_2_ZIP5_ZIP4_FOREIGN_POSTAL:=lFormatZipAndZip4(ri.lienhldrzpcd,ri.lienhldrzpcd4);
  self := le;
  end;

j2 := join(j1,File_TX_Lien,(integer)left.LH_2_CUSTOMER_NUMBER=(integer)right.lienhldrno,
                                 add_lh2(left,right),lookup,left outer);

layout_vehicles add_lh3(layout_vehicles le, File_TX_Lien ri) := transform
  self.LH_3_CUSTOMER_NAME:=trim(ri.lienhldrname1)+' '+ri.lienhldrname2;
  self.LH_3_STREET_ADDRESS:=trim(ri.lienhldrst1)+' '+ri.lienhldrst2;
  self.LH_3_CITY:=ri.lienhldrcity;
  self.LH_3_STATE:=ri.lienhldrstate;
  self.LH_3_ZIP5_ZIP4_FOREIGN_POSTAL:=lFormatZipAndZip4(ri.lienhldrzpcd,ri.lienhldrzpcd4);
  self := le;
  end;

j3 := join(j2,File_TX_Lien,(integer)left.LH_3_CUSTOMER_NUMBER=(integer)right.lienhldrno,
                                 add_lh3(left,right),lookup,left outer);

Layout_Vehicles upd_into(Layout_TX_Update le) := transform
do_bulk(1)
self.dt_first_seen := (unsigned8)(le.process_date[1..6]);
self.dt_last_seen := (unsigned8)(le.process_date[1..6]);
self.dt_vendor_first_reported:=(unsigned8)(le.process_date[1..6]);
self.dt_vendor_last_reported:=(unsigned8)(le.process_date[1..6]);
self.LH_1_CUSTOMER_NAME:=trim(le.lh1_name1)+' '+le.lh1_name2;
self.LH_1_STREET_ADDRESS:=trim(le.lh1_st1)+' '+le.lh1_st2;
self.LH_1_CITY:=le.lh1_city;
self.LH_1_STATE:=le.lh1_state;
self.LH_1_ZIP5_ZIP4_FOREIGN_POSTAL:=lFormatZipAndZip4(le.lh1_zpcd,le.lh1_zpcd4);
self.LH_2_CUSTOMER_NAME:=trim(le.lh2_name1)+' '+le.lh2_name2;
self.LH_2_STREET_ADDRESS:=trim(le.lh2_st1)+' '+le.lh2_st2;
self.LH_2_CITY:=le.lh2_city;
self.LH_2_STATE:=le.lh2_state;
self.LH_2_ZIP5_ZIP4_FOREIGN_POSTAL:=lFormatZipAndZip4(le.lh2_zpcd,le.lh2_zpcd4);
self.LH_3_CUSTOMER_NAME:=trim(le.lh3_name1)+' '+le.lh3_name2;
self.LH_3_STREET_ADDRESS:=trim(le.lh3_st1)+' '+le.lh3_st2;
self.LH_3_CITY:=le.lh3_city;
self.LH_3_STATE:=le.lh3_state;
self.LH_3_ZIP5_ZIP4_FOREIGN_POSTAL:=lFormatZipAndZip4(le.lh3_zpcd,le.lh3_zpcd4);
  end;

updp := project(File_TX_Update,upd_into(left));

export TX_as_Vehicles :=  updp+j3 : persist('Persist::VehReg_TX_as_Vehicles');