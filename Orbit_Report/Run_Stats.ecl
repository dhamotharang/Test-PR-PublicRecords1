import ut,Codes,_Control;
export Run_Stats(dsname,ds,groupbyfield,datefield,emailme,groupbycat,retval,usenafield='\'false\'',filename='\'optional\'') := macro
	#uniquename(string_rec)
	#uniquename(tab_out)
	
	#if ( groupbycat = 'st' )
		%string_rec% := record
			string statefield := '';
			string mydate := '';
		end;
		
		#uniquename(join_recs)
		%string_rec% %join_recs%(ds l,Codes.File_Codes_V3_In r) := transform
			self.statefield := if(usenafield = 'true' and r.long_desc = '','NA',r.long_desc);
			self.mydate := l.datefield;
		end;
		
		#uniquename(join_out)
		%join_out% := join(ds(trim(datefield) <> '' 
							and trim(groupbyfield) <> '' and datefield < ut.getdate),
							Codes.File_Codes_V3_In(file_name = 'GENERAL' and field_name = 'STATE_LONG'),
							left.groupbyfield = right.code,
							%join_recs%(left,right),
							left outer,
							lookup);
		
		#uniquename(tab_rec)
		
		%tab_rec% := record
			%join_out%.statefield;
			string maxdate := if(
							max(group,%join_out%.mydate)[5..6] <> '',
							max(group,%join_out%.mydate)[5..6],
							'12'
							) +  '/' + 
							if(
								max(group,%join_out%.mydate)[7..8] <> '',
								max(group,%join_out%.mydate)[7..8],
								'31'
							  ) + '/' + max(group,%join_out%.mydate)[1..4];
			count(group);
		end;
		
		%tab_out% := table(%join_out%(statefield <> ''),%tab_rec%,statefield,few);
		retval := if (_Control.ThisEnvironment.Name = 'Prod_Thor',
								sequential(output(sort(%tab_out%,statefield),,'~thor_data400::stats::orbit::build::merge::'+dsname,overwrite,csv),
				if ( filename = 'optional',
				lib_fileservices.FileServices.Despray('~thor_data400::stats::orbit::build::merge::'+dsname,_control.IPAddress.bctlpedata10,'/data/data_lib_2_hus2/orbit_stats/'+dsname + '/' + dsname + '_build.csv',,,,TRUE),
				lib_fileservices.FileServices.Despray('~thor_data400::stats::orbit::build::merge::'+dsname,_control.IPAddress.bctlpedata10,'/data/data_lib_2_hus2/orbit_stats/'+dsname + '/' + filename + '_build.csv',,,,TRUE)
				)),
				output('No Report generated')
				);
	#else
		%string_rec% := record
			string statefield := '';
			string mydate := '';
		end;
		
		#uniquename(proj_recs)
		%string_rec% %proj_recs%(ds l) := transform
			self.statefield := l.groupbyfield;
			self.mydate := trim(l.datefield);
		end;
		
		#uniquename(proj_out)
		%proj_out% := project(ds,%proj_recs%(left));
		
		#uniquename(tab_rec)
		
		%tab_rec% := record
			%proj_out%.statefield;
			string maxdate := if(length(max(group,%proj_out%.mydate)) > 4,
									if(
										max(group,%proj_out%.mydate)[5..6] <> '',
										max(group,%proj_out%.mydate)[5..6],
										'12'
										) +  '/' + 
									if(
										max(group,%proj_out%.mydate)[7..8] <> '',
										max(group,%proj_out%.mydate)[7..8],
										'31'
										) + '/' + max(group,%proj_out%.mydate)[1..4],
									max(group,%proj_out%.mydate)
									);
								
			count(group);
		end;
		
		%tab_out% := table(%proj_out%(trim(mydate) <> '' 
							and trim(statefield) <> '' and mydate < ut.getdate),%tab_rec%,statefield,few);
							
		retval := if (_Control.ThisEnvironment.Name = 'Prod_Thor',
						sequential(output(sort(%tab_out%,statefield),,'~thor_data400::stats::orbit::build::merge::'+dsname,overwrite,csv),
				if (filename='optional',
				lib_fileservices.FileServices.Despray('~thor_data400::stats::orbit::build::merge::'+dsname,_control.IPAddress.bctlpedata10,'/data/data_lib_2_hus2/orbit_stats/'+dsname + '/' + dsname + '_build.csv',,,,TRUE),
				lib_fileservices.FileServices.Despray('~thor_data400::stats::orbit::build::merge::'+dsname,_control.IPAddress.bctlpedata10,'/data/data_lib_2_hus2/orbit_stats/'+dsname + '/' + filename + '_build.csv',,,,TRUE)
				)),
				output('No Report generated')
				);
	#end
	
	
	
	
	
	
endmacro;