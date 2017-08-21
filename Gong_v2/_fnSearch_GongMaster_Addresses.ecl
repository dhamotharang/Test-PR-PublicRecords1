export _fnSearch_GongMaster_Addresses(
						string v1phone10 = '',
						string v1current_record_flag = '',
						string v1prim_range = '', 
						string v1predir = '', 
						string v1prim_name = '',
						string v1suffix='',
						string v1postdir='',
						string v1unit_desig='',
						string v1sec_range='',
						string v1p_city_name='',
						string v1v_city_name='',
						string v1st='',
						string v1z5='',
						string v1z4='',
						string v1err_stat=''
									) := function

vphone10  				:= stringlib.stringtouppercase(v1phone10 );
vcurrent_record_flag  	:= stringlib.stringtouppercase(v1current_record_flag );
vprim_range  			:= stringlib.stringtouppercase(v1prim_range );
vpredir  				:= stringlib.stringtouppercase(v1predir );
vprim_name  			:= stringlib.stringtouppercase(v1prim_name );
vsuffix 				:= stringlib.stringtouppercase(v1suffix);
vpostdir 				:= stringlib.stringtouppercase(v1postdir);
vunit_desig 			:= stringlib.stringtouppercase(v1unit_desig);
vsec_range 				:= stringlib.stringtouppercase(v1sec_range);
vp_city_name 			:= stringlib.stringtouppercase(v1p_city_name);
vv_city_name 			:= stringlib.stringtouppercase(v1v_city_name);
vst 					:= stringlib.stringtouppercase(v1st);
vz5 					:= stringlib.stringtouppercase(v1z5);
vz4 					:= stringlib.stringtouppercase(v1z4);
verr_stat 				:= stringlib.stringtouppercase(v1err_stat);
						
dbphone10 := 				if(vphone10 <> '', gong_v2.File_GongMaster(phone10 = vphone10), gong_v2.File_GongMaster);

dbcurrent_record_flag := 	if(vcurrent_record_flag <> '', dbphone10(current_record_flag = vcurrent_record_flag), dbphone10);

dbprim_range := 			if(vprim_range <> '', dbcurrent_record_flag(vprim_range = prim_range), dbcurrent_record_flag);

dbpredir := 				if(vpredir <> '', dbprim_range(vpredir = predir), dbprim_range);

dbprim_name := 				if(vprim_name <> '', dbpredir(vprim_name = prim_name), dbpredir);

dbsuffix := 				if(vsuffix <> '', dbprim_name(vsuffix = suffix), dbprim_name);

dbpostdir := 				if(vpostdir <> '', dbsuffix(vpostdir = postdir), dbsuffix);

dbunit_desig := 			if(vunit_desig <> '', dbpostdir(vunit_desig = unit_desig), dbpostdir);

dbsec_range := 				if(vsec_range <> '', dbunit_desig(vsec_range = sec_range), dbunit_desig);

dbp_city_name := 			if(vp_city_name <> '', dbsec_range(vp_city_name = p_city_name), dbsec_range);

dbv_city_name := 			if(vv_city_name <> '', dbp_city_name(vv_city_name = v_city_name), dbp_city_name);

dbst := 					if(vst <> '', dbv_city_name(vst = st), dbv_city_name);

dbz5 := 					if(vz5 <> '', dbst(vz5 = z5), dbst);

dbz4 := 					if(vz4 <> '', dbz5(vz4 = z4), dbz5);

dberr_stat := 				if(length(verr_stat) = 1, dbz4(verr_stat[1..1] = err_stat[1..1]),
									if(length(verr_stat) = 4, dbz4(verr_stat = err_stat), dbz4)) ;

////////////////////////
Address1 := vprim_range + ';' + vpredir + ';' + vprim_name + ';' + vsuffix + ';' + vpostdir;
Address2 := ';' +vunit_desig + ';' + vsec_range;
LastLine := ';' +vp_city_name + ';' + vv_city_name + ';' + vst + ';' + vz5 + ';' + vz4;
Other := ';' +if(verr_stat <> '', 'Err Stat ' + verr_stat, '') + ';' + vphone10 + ';' + if(vcurrent_record_flag <> '', 'Current Record ' + vcurrent_record_flag, '');

Criteria := 	stringlib.stringcleanspaces(
					regexreplace('^;', regexreplace(';$',regexreplace(';+', ADDRESS1 + ADDRESS2 + LASTLINE + OTHER, ';'), ''), '')
				);

run_search := parallel(
				output(criteria,named('Criteria_for_Search'));
				output(choosen(dberr_stat, 250), named('Sample_Address_Output'));
				output(dberr_stat,,'out::gong::address_search_' + workunit, overwrite, expire(14));
				output('*output file will expire in 14 days', named('_'))):
					success(FileServices.SendEmail( 'michelle.fletcher@lexisnexis.com','Gong Search Complete: ' + workunit, Criteria + ' - ' + workunit));

return run_search;

end;
