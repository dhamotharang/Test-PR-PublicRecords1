import FLAccidents;
// flc3v_v2_in := dataset('~thor_data400::sprayed::flcrash3v'
									// ,FLAccidents.Layout_FLCrash2v_v3, csv(Heading(1),separator(','),terminator(['\n','\r\n']),quote('')));

flc3v_v4_in := dataset('~thor_data400::sprayed::flcrash3v'
											,FLAccidents.Layout_FLCrash3, csv(Heading(1),separator(','),terminator(['\n','\r\n'])))(accident_nbr <> 'report_number');

//Get trailer owner info from vehicles file
flc2v_v4_in := dataset('~thor_data400::sprayed::flcrash2v'
							,FLAccidents.Layout_FLCrash2v_v4, csv(Heading(1),separator(','),terminator(['\n','\r\n'])));

BadNameFilter 	:= '(UNKNOWN|UNK |UK |N/A|TEST )';

layout_owner := record
flc2v_v4_in.accident_nbr;
flc2v_v4_in.vehicle_owner_business;
flc2v_v4_in.vehicle_owner_firstname;
flc2v_v4_in.vehicle_owner_middlename;
flc2v_v4_in.vehicle_owner_lastname;
flc2v_v4_in.vehicle_owner_suffix;
flc2v_v4_in.vehicle_owner_address;
flc2v_v4_in.vehicle_owner_st;
flc2v_v4_in.vehicle_owner_city;
flc2v_v4_in.vehicle_owner_zip;
//total:= count(group);
end;

tbl_owner := sort(table(flc2v_v4_in,layout_owner,accident_nbr,vehicle_owner_business,vehicle_owner_firstname,vehicle_owner_middlename,
									vehicle_owner_lastname,vehicle_owner_suffix,vehicle_owner_address,vehicle_owner_st,vehicle_owner_city,vehicle_owner_zip,few),
									accident_nbr);
/////////////
flc3v_v2_rec := FLAccidents.Layout_FLCrash3v_v2;

flc3v_v2_rec flc3v_convert_to_old(flc3v_v4_in l,tbl_owner r ) := transform
self. rec_type_3                    :=  '3'; 
self.section_nbr	:= Intformat((integer)l.section_nbr,2,1);                       
self.towed_trlr_veh_owner_name		:=	IF(trim(r.vehicle_owner_lastname,left,right) != '',
																					StringLib.StringCleanSpaces(REGEXREPLACE(BadNameFilter,(r.vehicle_owner_firstname+' '+r.vehicle_owner_middlename+' '+r.vehicle_owner_lastname),'')),
																					StringLib.StringCleanSpaces(REGEXREPLACE(BadNameFilter,r.vehicle_owner_business, '')));
self.towed_trlr_veh_owner_name_suffix	:= r.vehicle_owner_suffix;
self.towed_trlr_veh_owner_st_city	:=	trim(trim(r.vehicle_owner_address,left,right)+' '+trim(r.vehicle_owner_city,left,right),left,right);
self.towed_trlr_veh_owner_st	:= r.vehicle_owner_st;
self.towed_trlr_veh_owner_zip	:= map(trim(r.vehicle_owner_zip[6..9],left,right) = '0000' and  regexfind('[1-9]',trim(r.vehicle_owner_zip,left,right)) = true => r.vehicle_owner_zip[1..5],
																regexfind('[1-9]',trim(r.vehicle_owner_zip,left,right)) = false => '',r.vehicle_owner_zip); 
self.towed_trlr_veh_tag_nbr	:= IF(regexfind('NA',l.towed_trlr_veh_tag_nbr),'',l.towed_trlr_veh_tag_nbr);
self.towed_trlr_veh_id_nbr	:= IF(regexfind('NA',l.towed_trlr_veh_id_nbr),'',l.towed_trlr_veh_id_nbr);
self.towed_trailer_type := '88';
self                                := l;
self                                := [];
end;

jrecs:= join(flc3v_v4_in,tbl_owner,
					left.accident_nbr = right.accident_nbr,
					flc3v_convert_to_old(left,right),left outer);

export InFile_FLCrash3v_v4 := dedup(sort(jrecs,accident_nbr,towed_trlr_veh_owner_name),ALL,except section_nbr);