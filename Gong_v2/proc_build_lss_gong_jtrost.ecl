import Gong,lib_metaphone,lib_KeyLib,Address,ut;

export proc_build_lss_gong_jtrost(string rundate) := function

currGong := distribute(Gong_v2.File_GongMaster(current_record_flag ='Y'),hash(group_id));

slim_currGong := record
currGong.group_id;
unsigned8 moxie_group_id := 0;
end;

tbl_group := distribute(dedup(table(currGong,slim_currGong),record,all),hash(group_id));

ut.MAC_Sequence_Records(tbl_group,moxie_group_id,newIDFile);

currGong t_id(currGong L, newIDFile R) := transform
self.group_id := if(L.group_id = R.group_id,intformat(R.moxie_group_id,10,1),'');
self := L;
end;

j_id := join(currGong,newIDFile,
			left.group_id = right.group_id,
			t_id(left,right),left outer,local);

Gong.layout_gong t_building2(j_id L) := transform

	append_targus_address := l.z4 = '' and l.appnd_z4 <> '' and l.err_stat[1..1] = 'E';

self.filedate       := L.last_udt_date[5..8] + L.last_udt_date[1..4] + '_01';
self.cr_sort_sz		:= L.privacy_flag;
self.phoneno        := L.phone10;
self.sequence_number:= (string)L.sequence_number;

self.predir 			:= if(append_targus_address	,L.appnd_predir     ,L.predir);
self.prim_range		:= if(append_targus_address	,L.appnd_prim_range ,L.prim_range);
self.prim_name 		:= if(append_targus_address	,L.appnd_prim_name  ,L.prim_name);
self.suffix  			:= if(append_targus_address	,L.appnd_suffix     ,L.suffix);
self.postdir 			:= if(append_targus_address	,L.appnd_postdir    ,L.postdir);
self.p_city_name	:= if(append_targus_address	,L.appnd_p_city_name,L.p_city_name);
self.unit_desig		:= if(append_targus_address	,L.appnd_unit_desig ,L.unit_desig);
self.sec_range 		:= if(append_targus_address	,L.appnd_sec_range  ,L.sec_range);
self.st 		    	:= if(append_targus_address	,L.appnd_st         ,L.st);
self.z5 		    	:= if(append_targus_address	,L.appnd_z5         ,L.z5);
self.z4						:= if(append_targus_address	,L.appnd_z4         ,L.z4);

self.address_appnd_flag := if(append_targus_address, 'TARG', 'LSSI');
  
self.see_also_text  := L.special_listing_txt;

self := L;
end;

n_building := project(j_id, t_building2(left));
dd_currGong := sort(dedup(n_building,record, except sequence_number,all), phoneno, name_last, name_first);

outfile :=  sequential(output(dd_currGong,,Gong_v2.thor_cluster+'base::lss_gong'+ rundate,overwrite,__compressed__),
fileservices.clearsuperfile('~thor_data400::base::gong'),
				fileservices.addsuperfile('~thor_data400::base::gong',Gong_v2.thor_cluster+'base::lss_gong'+ rundate);
				fileservices.addsuperfile('~thor_data400::base::gong_father',Gong_v2.thor_cluster+'base::lss_gong'+ rundate));
				
				/* after previous base added to father, remove the oldest subfile from father if there is over 2 weeks of data */
								if(FileServices.GetSuperFileSubCount('~thor_data400::base::gong_father') > 12,
									FileServices.RemoveSuperFile('~thor_data400::base::gong_father', '~'+FileServices.GetSuperFileSubName('~thor_data400::base::gong_father', 1)), 
									output('No Super Removed from Father'));
							/*fileservices.promotesuperfilelist(['~thor_data400::base::gong',
																								 '~thor_data400::base::gong_father',
																								 '~thor_data400::base::gong_delete'],
																								Gong_v2.thor_cluster+'base::lss_gong'+ rundate,true));*/
			
return outfile;

end;