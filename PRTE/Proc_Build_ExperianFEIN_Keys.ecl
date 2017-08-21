import	_control;

export Proc_Build_ExperianFEIN_Keys(string pIndexVersion) := function

rKeyExperianFEIN__linkids	:= RECORD
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
  string9 business_identification_number;
  string40 business_name;
  string30 business_address;
  string28 business_city;
  string2 business_state;
  string5 business_zip;
  string1 norm_type;
  string9 norm_tax_id;
  string1 norm_confidence_level;
  string1 norm_display_configuration;
  string120 long_name;
  string2 source;
  unsigned8 source_rec_id;
  unsigned6 bdid;
  unsigned1 bdid_score;
  unsigned4 dt_vendor_first_reported;
  unsigned4 dt_vendor_last_reported;
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
  unsigned8 raw_aid;
  unsigned8 ace_aid;
  string100 prep_addr_line1;
  string50 prep_addr_line_last;
  integer1 fp;
end; 

ds_linkids	:=dataset([],rKeyExperianFEIN__linkids);	
								
linkids_IN	:=index(ds_linkids, {ultid,orgid,seleid,proxid,powid,empid,dotid}, {ds_linkids}, '~prte::key::experian_fein::' + pIndexVersion + '::linkids');	
                                                                                                
return	sequential(
										build(linkids_IN, update),
										PRTE.UpdateVersion('ExperianFEINKeys',	//	Package name
												pIndexVersion,											//	Package version
												_control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
												 'B',																//	B = Boca, A = Alpharetta
												 'N',																//	N = Non-FCRA, F = FCRA
												 'N')	    													//	N = Do not also include boolean, Y = Include boolean, too
										 );
end;
