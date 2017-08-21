import did_add, ut, header_slimsort, didville, business_header,business_header_ss, address;

//create temporary clean record format
preDID_rec 			:= record
  ak_comm_fish_vessels.layout_permits;
  string100 cname;
  string182 clean_address;
  string70  pname1;
  string70  pname2;
  string70  pname3;
end;


//separate companies, owners, and multi holders				
preDID_rec tformat(ak_comm_fish_vessels.layout_permits L):= transform

string3 v_suffix 	:=  MAP(L.HOLDER_SUFFIX = 'J' => 'JR',
							L.HOLDER_SUFFIX = 'S' => 'SR',																								  				
							L.HOLDER_SUFFIX = '1' => 'I',
							L.HOLDER_SUFFIX = '2' => 'II',
							L.HOLDER_SUFFIX = '3' => 'III',
							L.HOLDER_SUFFIX = '4' => 'IV',
							L.HOLDER_SUFFIX = '5' => 'V',
							L.HOLDER_SUFFIX = '6' => 'VI',
							'');
							
string73  v_concat_name 	:= StringLib.StringCleanSpaces(L.HOLDER_LNAME+L.HOLDER_FNAME+L.HOLDER_MINITIAL)+' '+v_suffix;
string182 v_clean_address 	:= Address.CleanAddress182(trim(L.HOLDER_STREET,left,right),(trim(L.HOLDER_CITY,left,right)+', '+trim(L.HOLDER_STATE,left,right))+' '+trim(L.HOLDER_ZIP,left,right));  

boolean	v_format	:= REGEXFIND('^(.*),(.*)&(.*)', StringLib.StringCleanSpaces(L.HOLDER_LNAME+L.HOLDER_FNAME+L.HOLDER_MINITIAL));

boolean v_temp 	   	:= (~ak_comm_fish_vessels.fIsCompany(v_concat_name)
					and L.HOLDER_NAME_TYPE = 'C'
					and v_format);

self.pname1			:= if(L.HOLDER_NAME_TYPE <> 'C', address.CleanPersonLFM73(v_concat_name), '');
self.pname2  		:= if(v_temp = true, address.CleanPersonLFM73(REGEXFIND('^(.*),(.*)&(.*)', v_concat_name, 1)+''+REGEXFIND('^(.*),(.*)&(.*)', v_concat_name, 2)), '');
self.pname3  		:= if(v_temp = true, address.CleanPersonLFM73(REGEXFIND('^(.*),(.*)&(.*)', v_concat_name, 1)+''+REGEXFIND('^(.*),(.*)&(.*)', v_concat_name, 3)), '');
self.cname			:= if(L.HOLDER_NAME_TYPE = 'C' and ak_comm_fish_vessels.fIsCompany(v_concat_name) and ~v_format, v_concat_name, '');
self.clean_address	:= v_clean_address;
self				:= L;
end;

PCAddress   		:= project(ak_comm_fish_vessels.file_permits,tformat(left));


//normalize multi holders
ak_comm_fish_vessels.layout_permits_clean search_mapping_format_temp(PCAddress L, integer1 C) :=transform
self.pname    		:= choose(C, L.pname1, L.pname2, L.pname3);
self                := L;
end;
 
MultiAddrNorm := normalize(PCAddress,3,search_mapping_format_temp(left,counter));
outfile  	  := MultiAddrNorm(pname <> '' or cname <> '');

ut.mac_sf_buildprocess(outfile, '~thor_data400::base::ak_comm_fishing::permits', build_permit_base, 2,,true);

export proc_permits := build_permit_base;