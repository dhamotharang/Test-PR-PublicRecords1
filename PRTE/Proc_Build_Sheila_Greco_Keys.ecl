import	_control;

export Proc_Build_Sheila_Greco_Keys(string pIndexVersion) := function

companies := RECORD,maxlength(9999)
   string maincompanyid;
   string companyname;
   string ticker;
   string fortunerank;
   string primaryindustry;
   string address1;
   string address2;
   string city;
   string state;
   string zip;
   string country;
   string region;
   string phone;
   string extension;
   string weburl;
   string sales;
   string employees;
   string competitors;
   string divisionname;
   string siccode;
   string auditor;
   string entrydate;
   string lastupdate;
   string entrystaffid;
   string description;
  END;

layout_clean182_fips := RECORD
   string10 prim_range;
   string2 predir;
   string28 prim_name;
   string4 addr_suffix;
   string2 postdir;
   string10 unit_desig;
   string8 sec_range;
   string25 p_city_name;
   string25 v_city_name;
   string2 st;
   string5 zip;
   string4 zip4;
   string4 cart;
   string1 cr_sort_sz;
   string4 lot;
   string1 lot_order;
   string2 dbpc;
   string1 chk_digit;
   string2 rec_type;
   string2 fips_state;
   string3 fips_county;
   string10 geo_lat;
   string11 geo_long;
   string4 msa;
   string7 geo_blk;
   string1 geo_match;
   string4 err_stat;
  END;

cleaned_dates := RECORD
   unsigned4 entrydate;
   unsigned4 lastupdate;
  END;

cleaned_phones := RECORD
   string10 phone;
  END;

arecord := RECORD
  unsigned6 ultid;
  unsigned6 orgid;
  unsigned6 seleid;
  unsigned6 proxid;
  unsigned6 powid;
  unsigned6 empid;
  unsigned6 dotid;
  unsigned2 ultscore;
  unsigned2 orgscore;
  unsigned2 selescore;
  unsigned2 proxscore;
  unsigned2 powscore;
  unsigned2 empscore;
  unsigned2 dotscore;
  unsigned2 ultweight;
  unsigned2 orgweight;
  unsigned2 seleweight;
  unsigned2 proxweight;
  unsigned2 powweight;
  unsigned2 empweight;
  unsigned2 dotweight;
  unsigned8 source_rec_id;
  unsigned6 bdid;
  unsigned1 bdid_score;
  unsigned8 raw_aid;
  unsigned8 ace_aid;
  unsigned4 dt_first_seen;
  unsigned4 dt_last_seen;
  unsigned4 dt_vendor_first_reported;
  unsigned4 dt_vendor_last_reported;
  string1 record_type;
  companies rawfields;
  layout_clean182_fips clean_address;
  cleaned_dates clean_dates;
  cleaned_phones clean_phones;
  integer1 fp;
 END;

return	sequential(
					parallel(		
						 buildindex(index(dataset([],arecord),{ultid,orgid,seleid,proxid,powid,empid,dotid},{dataset([],arecord)},'keyname')
						 ,'~prte::key::sheila_greco::' + pIndexVersion + '::linkids',update) 
 																	 ),
						PRTE.UpdateVersion('SheilaGrecoKeys',			         	//	Package name
						  							pIndexVersion,											//	Package version
							  						_control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
														 'B',																//	B = Boca, A = Alpharetta
														 'N',																//	N = Non-FCRA, F = FCRA
														 'N'));															//	N = Do not also include boolean, Y = Include boolean, too
end;
 
