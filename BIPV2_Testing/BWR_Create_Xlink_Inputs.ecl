//**THESE ARE ALL FOR MICRO
import BIPV2,Business_DOT,ut,Data_Services;
// set_cities := ['BOCA RATON','BOCARATON','BOCA RTN','BCA RTN','DELRAY BEACH','DEL RAY BEACH','DELRAY BCH','DEL RAY BCH', 'MIAMISBURG','DAYTON','GERMANTOWN','KETTERING'];
size_sample := 5000;


//INQ
mbslayout := RECORD
   string company_id;
   string global_company_id;
  END;

allowlayout := RECORD
   unsigned8 allowflags;
  END;

businfolayout := RECORD
   string primary_market_code;
   string secondary_market_code;
   string industry_1_code;
   string industry_2_code;
   string sub_market;
   string vertical;
   string use;
   string industry;
  END;

persondatalayout := RECORD
   string full_name;
   string first_name;
   string middle_name;
   string last_name;
   string address;
   string city;
   string state;
   string zip;
   string personal_phone;
   string work_phone;
   string dob;
   string dl;
   string dl_st;
   string email_address;
   string ssn;
   string linkid;
   string ipaddr;
   string5 title;
   string20 fname;
   string20 mname;
   string20 lname;
   string5 name_suffix;
   string10 prim_range;
   string2 predir;
   string28 prim_name;
   string4 addr_suffix;
   string2 postdir;
   string10 unit_desig;
   string8 sec_range;
   string25 v_city_name;
   string2 st;
   string5 zip5;
   string4 zip4;
   string2 addr_rec_type;
   string2 fips_state;
   string3 fips_county;
   string10 geo_lat;
   string11 geo_long;
   string4 cbsa;
   string7 geo_blk;
   string1 geo_match;
   string4 err_stat;
   string appended_ssn;
   unsigned6 appended_adl;
  END;

busdatalayout := RECORD
   string cname;
   string address;
   string city;
   string state;
   string zip;
   string company_phone;
   string ein;
   string charter_number;
   string ucc_number;
   string domain_name;
   string10 prim_range;
   string2 predir;
   string28 prim_name;
   string4 addr_suffix;
   string2 postdir;
   string10 unit_desig;
   string8 sec_range;
   string25 v_city_name;
   string2 st;
   string5 zip5;
   string4 zip4;
   string2 addr_rec_type;
   string2 fips_state;
   string3 fips_county;
   string10 geo_lat;
   string11 geo_long;
   string4 cbsa;
   string7 geo_blk;
   string1 geo_match;
   string4 err_stat;
   unsigned6 appended_bdid;
   string appended_ein;
  END;

bususerdatalayout := RECORD
   string first_name;
   string middle_name;
   string last_name;
   string address;
   string city;
   string state;
   string zip;
   string personal_phone;
   string dob;
   string dl;
   string dl_st;
   string ssn;
   string5 title;
   string20 fname;
   string20 mname;
   string20 lname;
   string5 name_suffix;
   string10 prim_range;
   string2 predir;
   string28 prim_name;
   string4 addr_suffix;
   string2 postdir;
   string10 unit_desig;
   string8 sec_range;
   string25 v_city_name;
   string2 st;
   string5 zip5;
   string4 zip4;
   string2 addr_rec_type;
   string2 fips_state;
   string3 fips_county;
   string10 geo_lat;
   string11 geo_long;
   string4 cbsa;
   string7 geo_blk;
   string1 geo_match;
   string4 err_stat;
   string appended_ssn;
   unsigned6 appended_adl;
  END;

permissablelayout := RECORD
   string glb_purpose;
   string dppa_purpose;
   string fcra_purpose;
  END;

searchlayout := RECORD
   string datetime;
   string start_monitor;
   string stop_monitor;
   string login_history_id;
   string transaction_id;
   string sequence_number;
   string method;
   string product_code;
   string transaction_type;
   string function_description;
   string ipaddr;
  END;

r := RECORD
  mbslayout mbs;
  allowlayout allow_flags;
  businfolayout bus_intel;
  persondatalayout person_q;
  busdatalayout bus_q;
  bususerdatalayout bususer_q;
  permissablelayout permissions;
  searchlayout search_info;
  string source;
 END;


bi := dataset(Data_Services.foreign_prod + 'thor400_20::out::inquiry_acclogs::business_search_2012', r, thor);

mac(f) := macro
#uniquename(bic)
%bic% := bi(bus_q.f <> '');
output(count(%bic%), named('cnt_' + #text(f)));
output((%bic%), named('sample_' + #text(f)));
endmacro;

// mac(cname)
// mac(address)
// mac(city)
// mac(state)
// mac(zip)
// mac(company_phone)
// mac(ein)
// mac(charter_number)
// mac(domain_name)
// mac(prim_range)
// mac(prim_name)

bigood := 
project(
	bi(
		bus_q.cname <> '' or bus_q.company_phone <> '' or bus_q.ein <> '' //any of these
		or ((bus_q.city <> '' or bus_q.zip <> '') and (bus_q.prim_range <> '' or bus_q.prim_name <> '')) //or some kind of locale and street info
	),
	transform(
		{busdatalayout, r},
		self := left.bus_q, //this just to make the fields i am looking for more obvious and readable
		self := left
	)
);

// output(bigood,,'~thor_data400::out::inquiry_acclogs::business_search_20121230', overwrite);

micro4000 := enth(Business_DOT.Files.city_samp(bigood, state, city), 4000);			//this filter requires city and state, so it skews my inquiries.  i need some with zip and no city st
justcname1000 := enth(bigood(city = '' and state = '' and zip = '' and address = ''), 1000);

// output(micro4000, named('micro4000'));
// output(justcname1000, named('justcname1000'));

inq := 
project(
	micro4000 + justcname1000,
	transform(
		BIPV2_Testing.layouts.xlink,
		self.rid := counter + (3*size_sample);
		self.src := 'INQ';
		self.bdid_input := left.appended_bdid,
		self.bdid := 0,
		self.bdid_score := 0,
		BIPV2.IDmacros.mac_SetIDsZero()		

		self.company_name := left.cname;
		self.company_prim_range := left.prim_range;
		self.company_prim_name := left.prim_name;
		self.company_zip := left.zip5;
		self.company_sec_range := left.sec_range;
		self.company_city :=  if(left.zip5 <> '' and counter % 2 = 0, '', left.v_city_name);
		self.company_state := if(left.zip5 <> '' and counter % 2 = 0, '', left.st);
		self.company_phone := '';
		self.company_fein := left.ein;

		self.email_address := '';									
		self.fname := '';	
		self.mname := '';	
		self.lname := '';			
		
	)
);


// output(inq, named('inq'));
// output(count(inq(company_city = '')), named('count_inq_no_city'));

// **this is how i actually ran it
// others := dataset('~thor_data400::bipv2::xlink::all', BIPV2_Testing.layouts.xlink, thor);
// output(others, named('others'));
// allv2 := others & inq;
// output(allv2,,'~thor_data400::bipv2::xlink::allv2', overwrite);




//PAW
import PAW;
dPawFull:=PAW.File_Base;
dPawFiltered:=enth(Business_DOT.Files.city_samp(dPawFull, company_state, company_city), size_sample);
dPawP :=
project(
	dPawFiltered,
	transform(
		BIPV2_Testing.layouts.xlink,
		self.rid := counter,
		self.src := 'PAW';
		self.bdid_input := left.bdid,
		self.bdid := 0,
		self.bdid_score := 0,
		BIPV2.IDmacros.mac_SetIDsZero()		
		self := left
	)
) : persist('~thor_data400::bipv2::xlink::paw');


//CORP
import Corp2;
dCorpFull := Corp2.Files(,,true).base.corp.qa;
dCorpFiltered:=enth(Business_DOT.Files.city_samp(dCorpFull,corp_addr1_state,corp_addr1_v_city_name), size_sample);
dCorpP :=
project(
	dCorpFiltered,
	transform(
		BIPV2_Testing.layouts.xlink,
		self.rid := counter + size_sample;
		self.src := 'CORP';
		self.bdid_input := left.bdid,
		self.bdid := 0,
		self.bdid_score := 0,
		BIPV2.IDmacros.mac_SetIDsZero()		

		self.company_name := left.corp_legal_name;
		self.company_prim_range := left.corp_addr1_prim_range;
		self.company_prim_name := left.corp_addr1_prim_name;
		self.company_zip := left.corp_addr1_zip5;
		self.company_sec_range := left.corp_addr1_sec_range;
		self.company_city := left.corp_addr1_v_city_name;
		self.company_state := left.corp_addr1_state;
		self.company_phone := '';
		self.company_fein := '';

		self.email_address := '';									
		self.fname := '';	
		self.mname := '';	
		self.lname := '';			
		
	)
) : persist('~thor_data400::bipv2::xlink::Corp');

//UCC
import UCCV2;
dUCC := UCCV2.File_UCC_Party_Base_AID(company_name <> '');
dUCCFiltered:=enth(Business_DOT.Files.city_samp(dUCC,st,v_city_name), size_sample);
dUCCP :=
project(
	dUCCFiltered,
	transform(
		BIPV2_Testing.layouts.xlink,
		self.rid := counter + (2*size_sample);
		self.src := 'UCC';
		self.bdid_input := left.bdid,
		self.bdid := 0,
		self.bdid_score := 0,
		BIPV2.IDmacros.mac_SetIDsZero()		

		self.company_name := left.company_name;
		self.company_prim_range := left.prim_range;
		self.company_prim_name := left.prim_name;
		self.company_zip := left.zip5;
		self.company_sec_range := left.sec_range;
		self.company_city := left.v_city_name;
		self.company_state := left.st;
		self.company_phone := '';
		self.company_fein := left.fein;

		self.email_address := '';									
		self.fname := '';	
		self.mname := '';	
		self.lname := '';			
		
	)
) : persist('~thor_data400::bipv2::xlink::UCC');

//ALL
allem := dPawP & dCorpP & dUCCP & inq;
output(allem,,'~thor_data400::bipv2::xlink::allv2', overwrite);
