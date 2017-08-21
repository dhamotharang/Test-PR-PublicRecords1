//import lib_metaphone,lib_KeyLib,Address,ut;
import ut;
export proc_build_basefile(dataset(layout_gongMaster) mstr, string rundate) := function

		currGong := distribute(mstr(current_record_flag ='Y'));

		Layout_Base t_building2(currGong L) := transform
			append_targus_address := l.z4 = '' and l.appnd_z4 <> '' and l.err_stat[1..1] = 'E';

			self.filedate       := L.filedate;	//L.last_udt_date[5..8] + L.last_udt_date[1..4] + '_01';
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

			self.group_id := L.group_id;
			self.group_seq := L.group_seq;
			
			self := L;
		end;

		n_building := project(currGong, t_building2(left));
		dd_currGong := //sort(DISTRIBUTE(
											DISTRIBUTE(dedup(n_building,record, except sequence_number,all));
										//	HASH(phoneno, name_last, name_first
										//	phoneno, name_last, name_first);

/*		outfile :=  output(dd_currGong,,thor_cluster+'base::neu_gong::'+ rundate,overwrite,__compressed__);
		outfile :=  sequential(output(dd_currGong,,thor_cluster+'base::neu_gong::'+ rundate,overwrite,__compressed__),
		fileservices.clearsuperfile('~thor_data400::base::neustar::gong'),
						fileservices.addsuperfile('~thor_data400::base::neustar::gong',thor_cluster+'base::neu_gong'+ rundate);
						fileservices.addsuperfile('~thor_data400::base::neustar::gong_father',thor_cluster+'base::neu_gong'+ rundate));
						
						/* after previous base added to father, remove the oldest subfile from father if there is over 2 weeks of data */
//					if(FileServices.GetSuperFileSubCount('~thor_data400::base::neustar::gong_father') > 12,
//							FileServices.RemoveSuperFile('~thor_data400::base::neustar::gong_father', '~'+FileServices.GetSuperFileSubName('~thor_data400::base::neustar::gong_father', 1), true), 
//							output('No Super Removed from Father'));
									/*fileservices.promotesuperfilelist(['~thor_data400::base::gong',
																										 '~thor_data400::base::gong_father',
																										 '~thor_data400::base::gong_delete'],
																										Gong_v2.thor_cluster+'base::lss_gong'+ rundate,true));
	*/				
		return dd_currGong;

end;
