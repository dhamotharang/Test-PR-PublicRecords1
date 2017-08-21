import did_add, ut, header_slimsort, didville, business_header,business_header_ss, address;

//create temporary clean record format
preDID_rec 			:= record
  ak_comm_fish_vessels.layout_vessels;
  string100 cname;
  string182 clean_address;
  string70  pname1;
  string70  pname2;
  string70  pname3;
end;

//separate companies, owners, and multi owners					
preDID_rec tformat(ak_comm_fish_vessels.layout_vessels L):= transform

string3 v_suffix 	:=  MAP(L.OWNER_NAME_SUF = 'J' => 'JR',
							L.OWNER_NAME_SUF = 'S' => 'SR',																								  				
							L.OWNER_NAME_SUF = '1' => 'I',
							L.OWNER_NAME_SUF = '2' => 'II',
							L.OWNER_NAME_SUF = '3' => 'III',
							L.OWNER_NAME_SUF = '4' => 'IV',
							L.OWNER_NAME_SUF = '5' => 'V',
							L.OWNER_NAME_SUF = '6' => 'VI',
							'');
							
string73  v_concat_name 	:= StringLib.StringCleanSpaces(L.OWNER_LNAME+L.OWNER_FNAME+L.OWNER_MI)+' '+v_suffix;
string182 v_clean_address 	:= Address.CleanAddress182(trim(L.OWNER_STREET,left,right),(trim(L.OWNER_CITY,left,right)+', '+trim(L.OWNER_STATE,left,right))+' '+trim(L.OWNER_ZIP,left,right));  

boolean	v_format	:= REGEXFIND('^(.*),(.*)&(.*)', StringLib.StringCleanSpaces(L.OWNER_LNAME+L.OWNER_FNAME+L.OWNER_MI));

boolean v_temp 	   	:= (~ak_comm_fish_vessels.fIsCompany(v_concat_name)
					and L.OWNER_NAME_TYPE = 'C'
					and v_format);

self.pname1			:= if(L.OWNER_NAME_TYPE <> 'C', address.CleanPersonLFM73(v_concat_name), '');
self.pname2  		:= if(v_temp = true, address.CleanPersonLFM73(REGEXFIND('^(.*),(.*)&(.*)', v_concat_name, 1)+''+REGEXFIND('^(.*),(.*)&(.*)', v_concat_name, 2)), '');
self.pname3  		:= if(v_temp = true, address.CleanPersonLFM73(REGEXFIND('^(.*),(.*)&(.*)', v_concat_name, 1)+''+REGEXFIND('^(.*),(.*)&(.*)', v_concat_name, 3)), '');
self.cname			:= if(L.OWNER_NAME_TYPE = 'C' and ak_comm_fish_vessels.fIsCompany(v_concat_name) and ~v_format, v_concat_name, '');
self.clean_address	:= v_clean_address;
self				:= L;
end;

PCAddress   		:= project(ak_comm_fish_vessels.file_vessels,tformat(left));

//normalize multi holders
ak_comm_fish_vessels.layout_vessels_clean search_mapping_format_temp(PCAddress L, integer1 C) := transform
self.pname    		:= choose(C, L.pname1, L.pname2, L.pname3);
self                := L;
end;
 
MultiAddrNorm   	:= normalize(PCAddress,3,search_mapping_format_temp(left,counter));
MultiRestrict  		:= MultiAddrNorm(pname <> '' or cname <> '');

//dedup all uncleansed fields
outfile			:= dedup(MultiRestrict, except pname,cname,clean_address);

ut.mac_sf_buildprocess(outfile, '~thor_data400::base::ak_comm_fishing::vessels', build_vessel_base, 2,,true);

export proc_vessels := build_vessel_base;