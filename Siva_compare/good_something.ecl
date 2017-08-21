EXPORT good_something := 'todo';

EXPORT Freq( indata, outstats, individuals='\'\'', excludes='[]', includes='[]', countThreshold=-1, metaStats='\'\'', groupby='[]' ) := MACRO

	/*
	This macro does some basic frequency calculations on indata's constituent fields, indicating the relative frequency of each value in its field.

	INDATA         -- input dataset that MUST be a flat layout - no named sub-layouts, no nested datasets
	OUTSTATS       -- output dataset suitable for writing to CSV file. contains one empty row preceeding every group of statistics
	                  for easier groking.
	INDIVIDUALS    -- specifies whether each field should have its stats output directly to the workunit, suitable for simple
	                  viewing after query execution. if populated, all values in a particular dataset are prefixed with 
					  individuals+'_' (eg, foobar_age, foobar_name).
	EXCLUDES       -- a set of strings indicating which fields within INDATA should be completely ignored from calculation (eg,
	                  SSN, DID).
	INCLUDES       -- a set of strings indicating which fields within INDATA should be included; all other fields are implicitly
	                  excluded. If populated, this overrides excludes.
	COUNTTHRESHOLD -- Any field with more than this many unique values is omitted from statistics. This makes it useful for
	                  blanket exclusion of highly discrete data (eg, phone numbers, SSNs, addresses) without having to explicitly
					  exclude them. Also, setting countThreshold:=1 lets you easily find fields that have no variation.
	METASTATS      -- If not blank, outputs a dataset (named 'meta_'+metaStats) indicating how many unique values were found for
	                  every field, showing how much variation exists. If countThreshold is used, the meta stats exclude fields
					  that exceed the threshold.
	GROUPBY        -- If present, the statistics will be broken down by each of these fields. For example, if groupby is ['state'],
	                  and INCLUDES is 'firstname', then the results will be frequencies for first names grouped by state (eg,
					  AK, AARON, 123456, 0.030
					  AK, ADAM,   12345, 0.003
					  ...
					  AL, AARON, 234567, 0.007
					  ...
					  
	******** WARNING: ********
	This macro will not play nicely with any nested datasets. For example:
	 
		r1 := { integer age, string name, boolean deceased };
		r2 := { r1 alice, r1 bob };
		r3 := { r1, unsigned dob };
		r4 := { integer account, dataset(r1) people };

	r1, r2 and r3 will work fine, but r4 will throw syntax errors when passed to this macro.
	**************************
	 */
	loadxml('<xml/>');
	#exportxml(freqdist, recordof(indata) )

	#uniquename(tot_recs)
	%tot_recs% := count(indata);
	
	// for traversing structures with named children (but NOT child datasets!)
	#declare(fpath)
	#declare(path)
	#set(path,'')
	
	#uniquename(ex)
	#if(count(includes) > 0)
		#uniquename(inc)
		%inc% := (set of string)((set of qstring)includes);
		// set the excludes to be everything not in includes. pretty basic idea.
		%ex% := []
		#for(freqdist)
			#for(Field)
				#if(%{@isRecord}%=1 and %@isEnd%=0)
					// starting to traverse a new section. append this section's name to the path
					// don't start with a leading '.'
					#if( '' != %'path'% )
						#set(path, %'path'% + '.' + %'{@name}'%)
					#end
				#elseif(%@isEnd%)
					#set(path, %'path'%[1..LENGTH(%'path'%)-LENGTH(%'{@name}'%)-1])
				#else
					#if( StringLib.StringToUpperCase(%'@name'%) not in %inc% )
						+ [StringLib.StringToUpperCase(%'@name'%)]
					#end
				#end
				
			#end
		#end
		;
	#else
	  // no includes specified, so just use excludes. cast to set of qstring in order to avoid case issues
	  %ex% := (set of string)((set of qstring)excludes);
	#end
	
	

	#set(path,'')

	// regardless of whether we're outputting data directly to the WU,
	// return a single dataset of statistics to a dataset

	// for every field:
	//    tmp_current := stats for that field,
	//    tmp_cumulative := tmp_previous + tmp_current,
	//    tmp_previous gets set to tmp_cumulative
	// then set out_stats to tmp_previous

	#uniquename(tmp_cumulative)
	#uniquename(tmp_previous)
	#declare(fieldname)
	%tmp_previous% := dataset( [], {
						#if(count(groupby) > 0)
							#declare(grp_idx)
							#set(grp_idx,1)
							#loop
								#if( %grp_idx% > count(groupby))
									#break
								#else
									#set(fieldname, groupby[%grp_idx%])
									typeof(indata.%fieldname%) %fieldname%,
									#set(grp_idx, %grp_idx%+1)
								#end
							#end
						#end
			string name, string value, integer cnt, real4 pct } );

	#uniquename(separator)
	%separator% := project( dataset([{0}], {integer i}), transform( recordof(%tmp_previous%), self := [] ));

	#for(freqdist)
		#for(Field)
			#if(%{@isRecord}%=1 and %@isEnd%=0)
				// starting to traverse a new section. append this section's name to the path
				// don't start with a leading '.'
				#if( '' = %'path'% )
					#set(path, %'{@name}'%)
				#else
					#set(path, %'path'% + '.' + %'{@name}'%)
				#end
			#elseif(%@isEnd%=1)
				#set(path, %'path'%[1..LENGTH(%'path'%)-LENGTH(%'{@name}'%)-1])
			
			#else
				// the full path. eg, if path=shell_input and @name=in_streetaddress, then fpath=shell_input.in_streetaddress
				#set(fpath,'')
				#if( '' = %'path'% )
					#set(fpath, %'@name'%)
				#else
					#set(fpath, %'path'% + '.' + %'@name'%)
				#end
				
				#if(StringLib.StringToUppercase(%'fpath'%) not in %ex%  )
					#uniquename(layout)
					%layout% := record
						#if(count(groupby) > 0)
							#set(grp_idx,1)
							#loop
								#if( %grp_idx% > count(groupby))
									#break
								#else
									#set(fieldname, groupby[%grp_idx%])
									indata.%fieldname%;
									#set(grp_idx, %grp_idx%+1)
								#end
							#end
						#end
						string name := %'@name'%;
						string value :=
							/* make the value into a string. really only particularly special for booleans, since (string)false = '' */
							#if( %'@type'% in ['string','data'] )
								indata.%fpath%
							#elseif( %'@type'% in ['integer','unsigned integer','real'] )
								(string)indata.%fpath%
							#elseif( %'@type'% = 'boolean' )
								if(indata.%fpath%, 'true', 'false')
							#else
								(string)indata.%fpath% // try this as a fallback for other types (?)
							#end
						;
							
						integer cnt := count(group);
						real4 pct := count(group)/%tot_recs%;
					end;
					
					#uniquename(tmp_table)
					%tmp_table% := table( indata, %layout%, 
						#if(count(groupby) > 0)
							#set(grp_idx,1)
							#loop
								#if( %grp_idx% > count(groupby))
									#break
								#else
									#set(fieldname, groupby[%grp_idx%])
									%fieldname%,
									#set(grp_idx, %grp_idx%+1)
								#end
							#end
						#end
						%fpath%
					);
					
					#uniquename(tmp_current)
					%tmp_current% := 
					#if(countThreshold != -1)
						// when a threshold IS specified, check how many distinct values exist by TABLE with a field name
						if(count(%tmp_table%) <= countThreshold,
					#end
						%separator% + group( %tmp_table%, name) // data rows
						
					#if(countThreshold != -1 )
						// when only including a certain set, close the IF()
						)
					#end
					;
					
					%tmp_cumulative% := %tmp_previous% + %tmp_current%;
					#set(tmp_previous, %'tmp_cumulative'%)
					#uniquename(tmp_cumulative)


				
					
					#if(''!=individuals)
						if(countThreshold=-1 or count(%tmp_tbl%) <= countThreshold,
							output(%tmp_table%, named(individuals+'__' + StringLib.StringSubstituteOut(%'fpath'%, '.', '_')), all);
						);
					#end

				#end
				
			#end
			
		#end
	#end
	// tmp_cumulative was just assigned a unique name. tmp_previous is the former cumulative dataset, so use that one.
	outstats := %tmp_previous%;
	
	// using a string instead of a boolean lets you run Freq w/meta stats on multiple datasets without colliding on output names
	#if(''!=metaStats )
		#uniquename(metaDS)
		%metaDS% := table( outstats(cnt > 0) , {outstats.name, integer unique_vals := count(group)}, name );

		output(%metaDS%, named('meta_'+metaStats), all);
	#end
ENDMACRO;