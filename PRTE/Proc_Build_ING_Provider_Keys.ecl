import	_control, PRTE_CSV;

export Proc_Build_ING_Provider_Keys(string pIndexVersion)	:= function

rKeyING_Provider__ing_provider__did := record
PRTE_CSV.ING_Provider.rthor_data400__key__ing_provider__did;
end;

rKeyING_Provider__ing_provider__id	:=record
  unsigned6 l_providerid;
  string12 did;
  string3 did_score;
  string filetyp;
  string processdate;
  string providerid;
  string addressid;
  string lastname;
  string firstname;
  string middlename;
  string suffix;
  string gender;
  string providernamecompanycount;
  string providernametierid;
  string address;
  string address2;
  string city;
  string state;
  string county;
  string zip;
  string extzip;
  string latitude;
  string longitute;
  string georeturn;
  string highrisk;
  string provideraddresscompanycount;
  string provideraddresstiertypeid;
  string provideraddresstypecode;
  string birthdate;
  string birthdatecompanycount;
  string birthdatetiertypeid;
  string taxid;
  string taxidcompanycount;
  string taxidtiertypeid;
  string phonenumber;
  string phonetype;
  string phonenumbercompanycount;
  string phonenumbertiertypeid;
  string5 prov_clean_title;
  string20 prov_clean_fname;
  string20 prov_clean_mname;
  string20 prov_clean_lname;
  string5 prov_clean_name_suffix;
  string3 prov_clean_cleaning_score;
  string10 prov_clean_prim_range;
  string2 prov_clean_predir;
  string28 prov_clean_prim_name;
  string4 prov_clean_addr_suffix;
  string2 prov_clean_postdir;
  string10 prov_clean_unit_desig;
  string8 prov_clean_sec_range;
  string25 prov_clean_p_city_name;
  string25 prov_clean_v_city_name;
  string2 prov_clean_st;
  string5 prov_clean_zip;
  string4 prov_clean_zip4;
  string4 prov_clean_cart;
  string1 prov_clean_cr_sort_sz;
  string4 prov_clean_lot;
  string1 prov_clean_lot_order;
  string2 prov_clean_dpbc;
  string1 prov_clean_chk_digit;
  string2 prov_clean_record_type;
  string2 prov_clean_ace_fips_st;
  string3 prov_clean_fipscounty;
  string10 prov_clean_geo_lat;
  string11 prov_clean_geo_long;
  string4 prov_clean_msa;
  string7 prov_clean_geo_match;
  string4 prov_clean_err_stat;
  string8 dt_first_seen;
  string8 dt_last_seen;
  string8 dt_vendor_first_reported;
  string8 dt_vendor_last_reported;
  string optoutsitedescription;
  string affidavitreceiveddate;
  string optouteffectivedate;
  string dateoptoutterminationdate;
  string optoutstatus;
  string lastupdate;
  string deceasedindicator;
  string deceaseddate;
  unsigned8 __internal_fpos__;
 END;
rKey_ing_providersanctions_provider__id	:=RECORD
  unsigned6 l_providerid;
  string filetyp;
  string processdate;
  string providerid;
  string sanctiondate;
  string sanctioningstate;
  string sanctionedlicensenumber;
  string lossoflicenseindicator;
  string licensereinstatementdate;
  string sanctionfraudabuseindicator;
  string sanctiontype;
  string sanctionreason;
  string sanctionterms;
  string sanctionconditions;
  string sanctionfines;
  string sanctioningboardtype;
  string sanctioningsource;
  string lastupdate;
  string8 dt_first_seen;
  string8 dt_last_seen;
  string8 dt_vendor_first_reported;
  string8 dt_vendor_last_reported;
  unsigned8 __internal_fpos__;
 END;




rKeyING_Provider__ing_provider__license := record
PRTE_CSV.ING_Provider.rthor_data400__key__ing_provider__license;
end;

dKeyING_Provider__ing_provider__did			:=dataset([],rKeyING_Provider__ing_provider__did);	
dKeyING_Provider__ing_provider__id			:=dataset([],rKeyING_Provider__ing_provider__id); 		
dKeyING_Provider__ing_provider__license	:=dataset([],rKeyING_Provider__ing_provider__license);
dKeyING_providersanctions_provider__id	:=dataset([],rKey_ing_providersanctions_provider__id);	

kKeyING_Provider__ing_provider__did			  := index(dKeyING_Provider__ing_provider__did, {l_did}, {dKeyING_Provider__ing_provider__did}, '~prte::key::ing_provider::'+ pIndexVersion +'::did');
kKeyING_Provider__ing_provider__id		    := index(dKeyING_Provider__ing_provider__id, {l_providerid}, {dKeyING_Provider__ing_provider__id}, '~prte::key::ing_provider::'+ pIndexVersion +'::id');
kKeyING_Provider__ing_provider__license 	:= index(dKeyING_Provider__ing_provider__license, {licensestate,licensenumber}, {dKeyING_Provider__ing_provider__license}, '~prte::key::ing_provider::'+ pIndexVersion +'::license');
rKeyING_providersanctions_provider__id		:= index(dKeyING_providersanctions_provider__id, {l_providerid}, {dKeyING_providersanctions_provider__id}, '~prte::key::ing_providersanctions::'+ pIndexVersion +'::id');
 	
return	sequential(
														parallel(
																build(kKeyING_Provider__ing_provider__did, update),
																build(kKeyING_Provider__ing_provider__id, update),
																build(kKeyING_Provider__ing_provider__license, update),
																build(rKeyING_providersanctions_provider__id, update)
																
																),

   											PRTE.UpdateVersion('IngenixKeys',										//	Package name
   																				 pIndexVersion,												//	Package version
   																				 _control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
   																				 'B',																	//	B = Boca, A = Alpharetta
   																				 'N',																	//	N = Non-FCRA, F = FCRA
   																				 'N'																	//	N = Do not also include boolean, Y = Include boolean, too
   																)
								);
								 

end;