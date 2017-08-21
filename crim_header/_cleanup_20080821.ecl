import ut;

o_lo
 := record
	unsigned6		cdl;
	unsigned6 		rid;
	boolean			in_latest;
	string8			earliest_process_date;
	string8			latest_process_date;
// below were taken from Crim_Common.Layout_Moxie_Crim_Offender2
//  string8        	process_date;
    string60       	offender_key;
    string2        	vendor;
    string2        	state_origin;
    string1        	data_type;
    string35       	source_file;
    string35       	case_number;
//    string40       	case_court;		
//    string50       case_name;
//    string5        case_type;
//    string25       case_type_desc;
//    string8        case_filing_dt;
//    string56       pty_nm;
//    string1        pty_nm_fmt;
//    string20       orig_lname;
//    string20       orig_fname;
//    string20       orig_mname;
//    string10       orig_name_suffix;
	 string1       	name_type;
//    string1        nitro_flag;
    string9        	orig_ssn;
    string20       	dle_num;
    string20       	fbi_num;
    string20       	doc_num;
    string20       	ins_num;
	string20       	id_num;
	string20	   	ncic_number;	// from sex offender
	string20		sor_number;		// from sex offender
    string25       	dl_num;
    string2        	dl_state;
	string40		veh_tag;		// from sex offender
	string2			veh_state;		// from sex offender
//    string2        citizenship;
   string8         	dob;
   string8         	dob_alias;
//    string2        place_of_birth;
//    string25       street_address_1;
//    string25       street_address_2;
//    string25       street_address_3;
//    string10       street_address_4;
//    string10       street_address_5;
//    string5        race;
//    string30       race_desc;
//    string1        sex;
//    string5        hair_color;
//    string25       hair_color_desc;
//    string5        eye_color;
//    string25       eye_color_desc;
//    string5        skin_color;
//    string25       skin_color_desc;
//    string3        height;
//    string3        weight;
//    string10       party_status;
//    string60       party_status_desc;
    string10       prim_range;
    string2        predir;
    string28       prim_name;
    string4        addr_suffix;
    string2        postdir;
    string10       unit_desig;
    string8        sec_range;
    string25       p_city_name;
    string25       v_city_name;
    string2        state;
    string5        zip5;
    string4        zip4;
//    string4        cart;
//    string1        cr_sort_sz;
//    string4        lot;
//    string1        lot_order;
//    string2        dpbc;
//    string1        chk_digit;
//    string2        rec_type;
//    string2        ace_fips_st;
//    string3        ace_fips_county;
//    string10       geo_lat;
//    string11       geo_long;
//    string4        msa;
//    string7        geo_blk;
//    string1        geo_match;
//    string4        err_stat;		// kept this for possible address related issue debug
    string5        title;
    string20       fname;
    string20       mname;
    string20       lname;
    string5        name_suffix;
//    string3        cleaning_score;
//    string9 	     ssn;
	unsigned6  	   did;
	unsigned1 	   did_score;		// kept this for decision criteria if conflict within a [cdl,offender_key]
//	string12 	pgid;
end;

o_ch_in:= dataset('~thor_data400::temp::cdl::ngcdl2::it5_for_restart_20080821',o_lo,flat);
o_ch:= o_ch_in(vendor not in crim_header.bad_vendors and  (lname<>'' or fname<>'' or mname<>''));


n_lo := crim_header.layout_crim_header;

n_lo to_new(o_lo l) := transform
self.cdl := l.rid;
self.county_fips_code_origin:='';
self.gender:='';
self.dob := if(((length(trim(l.dob,left,right))=4) and (l.dob[1..2] in ['19','20'])),trim(l.dob,left,right)+'0000', l.dob); 
self := l
end;

n_ch := project(o_ch,to_new(left));

count(o_ch_in);
count(o_ch);
count(n_ch);

output(n_ch,,'~thor_data400::temp::cdl::it0_20080221');

