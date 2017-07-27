import Gong,lib_metaphone,lib_KeyLib,Address,ut;

export proc_build_lss_gong(infile,rundate,outfile) := macro


#uniquename(currGong)
#uniquename(slim_currGong)
#uniquename(tbl_group)
#uniquename(t_id)
#uniquename(newIDFile)
#uniquename(j_id)
#uniquename(t_building2)
#uniquename(n_building)
#uniquename(dd_currGong)


%currGong% := distribute(infile(current_record_flag ='Y'),hash(group_id));

/////////////////////////////////////////////////////////////////////////////////////////////////////////////
%slim_currGong% := record
%currGong%.group_id;
unsigned8 moxie_group_id := 0;
end;

%tbl_group% := distribute(dedup(table(%currGong%,%slim_currGong%),record,all),hash(group_id));

ut.MAC_Sequence_Records(%tbl_group%,moxie_group_id,%newIDFile%);


%currGong% %t_id%(%currGong% L, %newIDFile% R) := transform
self.group_id := if(L.group_id = R.group_id,intformat(R.moxie_group_id,10,1),'');
self := L;
end;

%j_id% := join(%currGong%,%newIDFile%,
			left.group_id = right.group_id,
			%t_id%(left,right),left outer,local);

Gong.layout_gong %t_building2%(%j_id% L) := transform
self.filedate       := L.last_udt_date[5..8] + L.last_udt_date[1..4] + '_01';
self.cr_sort_sz		:= L.privacy_flag;
self.phoneno        := L.phone10;
self.sequence_number:= (string)L.sequence_number;

self.predir 		:= if(L.predir       = '',L.appnd_predir     ,L.predir);
self.prim_range		:= if(L.prim_range   = '',L.appnd_prim_range ,L.prim_range);
self.prim_name 		:= if(L.prim_name    = '',L.appnd_prim_name  ,L.prim_name);
self.suffix  		:= if(L.suffix       = '',L.appnd_suffix     ,L.suffix);
self.postdir 		:= if(L.postdir      = '',L.appnd_postdir    ,L.postdir);
self.p_city_name	:= if(L.p_city_name  = '',L.appnd_p_city_name,L.p_city_name);
self.unit_desig		:= if(L.unit_desig   = '',L.appnd_unit_desig ,L.unit_desig);
self.sec_range 		:= if(L.sec_range    = '',L.appnd_sec_range  ,L.sec_range);
self.st 		    := if(L.st           = '',L.appnd_st         ,L.st);
self.z5 		    := if(L.z5           = '',L.appnd_z5         ,L.z5);
//self.z4				:= if(L.z4           = '',L.appnd_z4         ,L.z4);
  
self.see_also_text  := L.special_listing_txt;

self := L;
end;

%n_building% := project(%j_id%, %t_building2%(left));
%dd_currGong% := dedup(%n_building%,record, except sequence_number,all);

outfile :=  sequential(output(%dd_currGong%,,Gong_v2.thor_cluster+'base::lss_gong'+ rundate,overwrite),
				fileservices.clearsuperfile('~thor_data400::base::gong'),
				fileservices.addsuperfile('~thor_data400::base::gong',Gong_v2.thor_cluster+'base::lss_gong'+ rundate));
			
endmacro;