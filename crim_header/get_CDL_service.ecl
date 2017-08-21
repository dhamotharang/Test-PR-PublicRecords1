/*--SOAP--
<message name = 'crim_header get_CDL_service'>

	<part name = "CDL" type = "tns:EspStringArray"/>

</message>
*/
/*--INFO-- This service searches the CRIM_HEADER file by CDL. */
//  <part name = "Latest Match Only?" type= "xsd:boolean"/>

export get_CDL_service() := macro

set of string14	 user_cdl_sval := [] : stored('CDL');
set of unsigned6	user_cdl := (set of integer) user_cdl_sval;

layout_pretty := record
	unsigned6		cdl;
  boolean			latest_match := false;
  string1     data_type;
	string60    offender_key;
  unsigned6  	did;
	boolean				in_latest;

	string1        name_type;
	string5				 title;
  string20       fname;
  string20       mname;
  string20       lname;
  string5        name_suffix;
  string8        dob;
//
//
  string10    	prim_range;
//  string2       predir;
  string28      prim_name;
//  string4     addr_suffix;
//  string2     postdir;
//  string10    unit_desig;
  string8       sec_range;
//  string25    p_city_name;
  string25      v_city_name;
  string2       state;
  string5       zip5;
//  string4     zip4;
//
  string35      case_number;
  string25      dl_num;
  string2       dl_state;
  string9       orig_ssn;
  string20      dle_num;
  string20      fbi_num;
  string20      doc_num;
  string20      ins_num;
	string20      id_num;
	string20	   	ncic_number;	// from sex offender
	string20			sor_number;		// from sex offender
	string40			veh_tag;		// from sex offender
	string2				veh_state;		// from sex offender
//  string8         	dob_alias;
  string2       vendor;
  string2       state_origin;
  string35      source_file;
	unsigned6 		rid;
	string8				earliest_process_date;
	string8				latest_process_date;
end;

layout_pretty  get_by_cdl(crim_header.key_crim_header_cdl l) := transform
	self := l;
end;
my_ch := project(crim_header.key_crim_header_cdl(i_cdl IN user_cdl), get_by_cdl(LEFT));

layout_pretty  append_by_rid(my_ch l,crim_header.key_crim_header_sample_rids r) := transform 
self.latest_match := if(l.rid=r.rid,true,false);
self 	:= l;
end;
outf := join(my_ch,crim_header.key_crim_header_sample_rids,keyed(left.rid=right.i_rid),append_by_rid(left,right),left outer);

output(choosen(sort(outf,cdl,-latest_match,offender_key,-did),10000),named('RESULTS'));

endmacro;
