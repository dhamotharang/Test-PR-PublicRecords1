
import utilfile, Certegy , header,death_master,_control,watchdog ; 

export pro_monitor(string DestinationIP = _control.IPAddress.bctlpedata11) := module 

//shared DestinationIP       := _control.IPAddress.edata12; 

string8 certegy_maxdate := max(Certegy.Files.certegy_base,Certegy.Files.certegy_base.date_vendor_last_reported); 

certgy_update := Certegy.Files.certegy_base(date_vendor_last_reported = certegy_maxdate); 

temp_rec_certegy := record 
		 string	did       
		,string	did_score 
		,String orig_DL_State
		,String orig_DL_Num
		,String orig_SSN
		,String orig_DL_Issue_Dte
		,String orig_DL_Expire_Dte
		,String orig_Professional_Title
		,String orig_Functional_Title
		,String orig_House_Bldg_Num
		,String orig_Street_Suffix
		,String orig_Apt_Num
		,String orig_Unit_Desc
		,String orig_Street_Post_Dir
		,String orig_Street_Pre_Dir
		,String orig_State
		,String orig_Zip
		,String orig_DOB
		,String orig_Deceased_Dte
		,String orig_Home_Tel_Area
		,String orig_Home_Tel_Num
		,String orig_Work_Tel_Area
		,String orig_Work_Tel_Num
		,String orig_Work_Tel_Ext
		,String orig_First_Name
		,String orig_Mid_Name
		,String orig_Last_Name
		,String orig_Street_Name
		,String orig_City
		,String clean_ssn
		,String clean_DOB
		,String clean_hphone
		,String clean_wphone
		,string  date_first_seen 
		,string  date_last_seen 
		,string  date_vendor_first_reported 
		,string  date_vendor_last_reported 
        ,string  title					
	    ,string  fname					
	    ,string  mname					
	    ,string  lname					
	    ,string  name_suffix		
	    ,string  name_score			
        ,string  prim_range
		,string  predir
		,string  prim_name
		,string  addr_suffix
		,string  postdir
		,string  unit_desig
		,string  sec_range
		,string  p_city_name
		,string  v_city_name
		,string  st
		,string  zip
		,string  zip4
		,string  cart
		,string  cr_sort_sz
		,string  lot
		,string  lot_order
		,string  dbpc
		,string  chk_digit
		,string  rec_type
		,string	 fips_county
		,string	 county
		,string  geo_lat
		,string  geo_long
		,string  msa
		,string  geo_blk
		,string  geo_match
		,string  err_stat
end;

temp_rec_certegy reformat( certgy_update l ) := transform 
self.did :=  (string) l.did ; 
self.did_score := (string) l.did_score ; 
self := l ; 
end; 
v_certegy := project(certgy_update ,reformat(left)); 

file_v_certegy := output(v_certegy,,'~thor_data::out::promonitor::certegy_'+certegy_maxdate,csv(
HEADING('did|did_score|orig_DL_State|orig_DL_Num|orig_SSN|orig_DL_Issue_Dte|orig_DL_Expire_Dte|orig_Professional_Title|orig_Functional_Title|orig_House_Bldg_Num|orig_Street_Suffix|orig_Apt_Num|orig_Unit_Desc|orig_Street_Post_Dir|orig_Street_Pre_Dir|orig_State|orig_Zip|orig_DOB|orig_Deceased_Dte|orig_Home_Tel_Area|orig_Home_Tel_Num|orig_Work_Tel_Area|orig_Work_Tel_Num|orig_Work_Tel_Ext|orig_First_Name|orig_Mid_Name|orig_Last_Name|orig_Street_Name|orig_City|clean_ssn|clean_DOB|clean_hphone|clean_wphone|date_first_seen|date_last_seen|date_vendor_first_reported|date_vendor_last_reported|title|fname|mname|lname|name_suffix|name_score|prim_range|predir|prim_name|addr_suffix|postdir|unit_desig|sec_range|p_city_name|v_city_name|st|zip|zip4|cart|cr_sort_sz|lot|lot_order|dbpc|chk_digit|rec_type|fips_county|county|geo_lat|geo_long|msa|geo_blk|geo_match|err_stat\n','',SINGLE)
,SEPARATOR('|'), TERMINATOR('\n')),OVERWRITE);

certegy_d := fileservices.despray('~thor_data::out::promonitor::certegy_'+certegy_maxdate, DestinationIP, '/data/hds_180/pro_monitor/build/certegy/certegy_'+certegy_maxdate+'.txt',,,,TRUE); 
export certegy_despray := sequential(file_v_certegy,certegy_d);  

/**********************************************************************************************/
/*                                   Death Master                                             */
/**********************************************************************************************/

death := Header.File_DID_Death_MasterV3_SSA(death_rec_src='SSA'); 
string8 death_filedate := max(death,death.filedate); 
death_update := death(filedate = death_filedate);  

temp_rec_death := RECORD
	string	did;
	string	did_score;
	string	filedate;
	string	rec_type;
	string	rec_type_orig;
	string	ssn;
	string	lname;
	string	name_suffix;
	string	fname;
	string	mname;
	string	vorp_code;
	string	dod8;
	string	dob8;
	string	st_country_code;
	string	zip_lastres;
	string	zip_lastpayment;
	string	state;
	string	fipscounty;
	string	state_death_id;
	string	src;
	string	glb_flag;
END;

temp_rec_death reformat1( death_update l ) := transform 
	self.did_score	:=	(string) l.did_score ; 
	self						:=	l; 
end; 
v_death := project(death_update ,reformat1(left)); 

file_v_death := output(v_death,,'~thor_data::out::promonitor::death_'+death_filedate,csv(
HEADING('did|did_score|filedate|rec_type|rec_type_orig|ssn|lname|name_suffix|fname|mname|vorp_code|dod8|dob8|st_country_code|zip_lastres|zip_lastpayment|state|fipscounty|state_death_id|src|glb_flag\n','',SINGLE)
,SEPARATOR('|'), TERMINATOR('\n')),OVERWRITE);
death_d :=  fileservices.despray('~thor_data::out::promonitor::death_'+death_filedate, DestinationIP, '/data/hds_180/pro_monitor/build/dmaster/dmaster_'+death_filedate+'.txt',,,,TRUE); 

export  death_despray := sequential(file_v_death,death_d); 
 
/**********************************************************************************************/
/*                                   End Death Master                                         */
/**********************************************************************************************/

//utility := utilfile.file_util_in ; 
utility  := UtilFile.file_util_daily ; // changed to this file as full base file(utilfile.file_util_in)doesn't have update file dids. 
string8 utility_date :=  max(utility,utility.record_date); 
utility_update := utility(record_date = utility_date);  
// Append DOB 
utility_update_dist := distribute(utility_update((unsigned)did<>0),hash((INTEGER)did)); 
fbest := Watchdog.File_Best ; 
recordof(utility_update_dist) tgetdob(recordof(utility_update_dist) l	,recordof(fbest) r) :=
		transform
		self.dob							:=(string)r.dob;
		self 										:= l;
		end;
		
		getdob	:= join( utility_update_dist
											,fbest
											,(unsigned6)left.did= right.did
											,tgetdob(left,right)
											,left outer
											,local)
								+ PROJECT(DISTRIBUTE(utility_update((unsigned)did=0)),TRANSFORM(recordof(utility_update_dist),
											self.dob := '0';	// probably a bug, but it is here to be backwards compatible
											self := LEFT));

temp_rec_util := record 
string        id;
string       exchange_serial_number;
string         date_added_to_exchange;
string        connect_date;
string         date_first_seen;
string         record_date;
string        util_type;
string       orig_lname;
string        orig_fname;
string        orig_mname;
string         orig_name_suffix;
string         addr_type;
string        addr_dual;
string        address_street;
string       address_street_Name;
string         address_street_Type;
string         address_street_direction;
string        address_apartment;
string        address_city;
string         address_state;
string        address_zip;
string         ssn;
string       work_phone;
string        phone;
string         dob;
string         drivers_license_state_code;
string        drivers_license;
string		  csa_indicator := '';
string        prim_range;
string         predir;
string        prim_name;
string         addr_suffix;
string         postdir;
string       unit_desig;
string         sec_range;
string        p_city_name;
string       v_city_name;
string         st;
string        zip;
string         zip4;
string         cart;
string         cr_sort_sz;
string         lot;
string         lot_order;
string         dbpc;
string         chk_digit;
string         rec_type;
string         county;
string        geo_lat;
string        geo_long;
string         msa;
string         geo_blk;
string         geo_match;
string         err_stat;
string        did;
string         title;
string        fname;
string        mname;
string        lname;
string         name_suffix;
string         name_score;
end; 
	
temp_rec_util reformat2( getdob l ) := transform 
self := l ; 
end; 
v_util := project(getdob ,reformat2(left)); 	

file_v_util := output(v_util,,'~thor_data::out::promonitor::utility_'+utility_date,csv(
HEADING('id|exchange_serial_number|date_added_to_exchange|connect_date|date_first_seen|record_date|util_type|orig_lname|orig_fname|orig_mname|orig_name_suffix|addr_type|addr_dual|address_street|address_street_Name|address_street_Type|address_street_direction|address_apartment|address_city|address_state|address_zip|ssn|work_phone|phone|dob|drivers_license_state_code|drivers_license|csa_indicator|prim_range|predir|prim_name|addr_suffix|postdir|unit_desig|sec_range|p_city_name|v_city_name|st|zip|zip4|cart|cr_sort_sz|lot|lot_order|dbpc|chk_digit|rec_type|county|geo_lat|geo_long|msa|geo_blk|geo_match|err_stat|did|title|name|mname|lname|name_suffix|name_score\n','',SINGLE)
,SEPARATOR('|'), TERMINATOR('\n')),OVERWRITE);

util_d := fileservices.despray('~thor_data::out::promonitor::utility_'+utility_date, DestinationIP, '/data/hds_180/pro_monitor/build/utility/utility_'+utility_date+'.txt',,,,TRUE); 

export  util_despray := sequential(file_v_util,util_d);  

end; 
 

