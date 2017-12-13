import ut,Codes,_Control;
export get_huntfish_data(dsname,ds,groupbyfield,datefield,emailme,groupbycat,retval,usenafield='\'false\'',filename='\'optional\'') := macro
	
	
	#if ( groupbycat = 'st' )
		#uniquename(string_rec1)
		#uniquename(tab_out1)
		%string_rec1% := record
			string statefield := '';
			string mydate := '';
		end;
		
		#uniquename(join_recs1)
		%string_rec1% %join_recs1%(ds l,Codes.File_Codes_V3_In r) := transform
			self.statefield := if(usenafield = 'true' and r.long_desc = '','NA',r.long_desc);
			self.mydate := l.datefield;
		end;
		
		#uniquename(join_out1)
		%join_out1% := join(ds(trim(datefield) <> '' 
							and trim(groupbyfield) <> '' and datefield < ut.getdate),
							Codes.File_Codes_V3_In(file_name = 'GENERAL' and field_name = 'STATE_LONG'),
							left.groupbyfield = right.code,
							%join_recs1%(left,right),
							left outer,
							lookup);
		
		#uniquename(tab_rec1)
		
		%tab_rec1% := record
			%join_out1%.statefield;
			string maxdate := if(
							max(group,%join_out1%.mydate)[5..6] <> '',
							max(group,%join_out1%.mydate)[5..6],
							'12'
							) +  '/' + 
							if(
								max(group,%join_out1%.mydate)[7..8] <> '',
								max(group,%join_out1%.mydate)[7..8],
								'31'
							  ) + '/' + max(group,%join_out1%.mydate)[1..4];
			count(group);
		end;
		
		%tab_out1% := table(%join_out1%(statefield <> ''),%tab_rec1%,statefield,few);
		retval := sequential(output(sort(%tab_out1%,statefield),,'~thor_data400::stats::orbit::build::merge::'+dsname,overwrite,csv),
				if ( filename = 'optional',
				lib_fileservices.FileServices.Despray('~thor_data400::stats::orbit::build::merge::'+dsname,_control.IPAddress.bctlpedata11,'/data/prod_data_build_13/production_data/emerges/hvc/orbit_stats/'+dsname + '/' + dsname + '_build.csv',,,,TRUE),
				lib_fileservices.FileServices.Despray('~thor_data400::stats::orbit::build::merge::'+dsname,_control.IPAddress.bctlpedata11,'/data/prod_data_build_13/production_data/emerges/hvc/orbit_stats/'+dsname + '/' + filename + '_build.csv',,,,TRUE)
				));
	#else
		#uniquename(string_rec2)
		#uniquename(tab_out2)
		%string_rec2% := record
			string statefield := '';
			string mydate := '';
		end;
		
		#uniquename(proj_recs2)
		%string_rec2% %proj_recs2%(ds l) := transform
			self.statefield := l.groupbyfield;
			self.mydate := trim(l.datefield);
		end;
		
		#uniquename(proj_out2)
		%proj_out2% := project(ds,%proj_recs2%(left));
		
		#uniquename(tab_rec2)
		
		%tab_rec2% := record
			%proj_out2%.statefield;
			string maxdate := if(length(max(group,%proj_out2%.mydate)) > 4,
									if(
										max(group,%proj_out2%.mydate)[5..6] <> '',
										max(group,%proj_out2%.mydate)[5..6],
										'12'
										) +  '/' + 
									if(
										max(group,%proj_out2%.mydate)[7..8] <> '',
										max(group,%proj_out2%.mydate)[7..8],
										'31'
										) + '/' + max(group,%proj_out2%.mydate)[1..4],
									max(group,%proj_out2%.mydate)
									);
								
			count(group);
		end;
		
		%tab_out2% := table(%proj_out2%(trim(mydate) <> '' 
							and trim(statefield) <> '' and mydate < ut.getdate),%tab_rec2%,statefield,few);
							
		retval := sequential(output(sort(%tab_out2%,statefield),,'~thor_data400::stats::orbit::build::merge::'+dsname,overwrite,csv),
				if (filename='optional',
				lib_fileservices.FileServices.Despray('~thor_data400::stats::orbit::build::merge::'+dsname,_control.IPAddress.bctlpedata11,'/data/prod_data_build_13/production_data/emerges/hvc/orbit_stats'+dsname + '/' + dsname + '_build.csv',,,,TRUE),
				lib_fileservices.FileServices.Despray('~thor_data400::stats::orbit::build::merge::'+dsname,_control.IPAddress.bctlpedata11,'/data/prod_data_build_13/production_data/emerges/hvc/orbit_stats'+dsname + '/' + filename + '_build.csv',,,,TRUE)
				));
	#end
endmacro;