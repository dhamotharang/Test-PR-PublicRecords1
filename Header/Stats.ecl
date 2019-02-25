IMPORT $,std;
IMPORT PromoteSupers,ut,InsuranceHeader_PostProcess,IDL_Header;
EXPORT Stats := module

		export _rec := record
								string10  version;
								string100 variable;
								real8     value;
		end;
		shared _filename := '~thor_data400::stats::header';
		shared ver(string seq) := workunit+if(seq='','','_'+seq);
		export _file := dataset(_filename,_rec,flat,opt);
		export add(dataset(_rec) new_stats, string seq='') := function
		
							new_stats_file := dedup(_file + new_stats,version,variable,all);
							PromoteSupers.MAC_SF_BuildProcess( new_stats_file ,_filename ,out_ ,numgenerations:=2
																	,pVersion:=ver(seq),pCompress:=true);

							return out_;
		end;
        export remove(string10  version_, string100 variable_, real8 value_, string seq='') := function
                            new_stats_file := _file(~(version=version_ AND variable=variable_ AND value=value_));
                            PromoteSupers.MAC_SF_BuildProcess( new_stats_file ,_filename ,out_ ,numgenerations:=2
																	,pVersion:=ver(seq),pCompress:=true);

							return out_;
        end;
        export remove_variable_by_regex_match(string variable_, string seq='') := function
                           
                           new_stats_file := _file(~(regexfind(variable_,variable)));
                           PromoteSupers.MAC_SF_BuildProcess( new_stats_file ,_filename ,out_ ,numgenerations:=2
																	,pVersion:=ver(seq),pCompress:=true);
                           return out_;
        end;
        export get(string variable_) := project(_file(variable=variable_),{{_file} - variable});

		// -------------------------------------------------------------------------------------------------------------------

		// PublicRecords Linking Stats

		chdr:=project($.File_Headers,			TRANSFORM(IDL_Header.Layout_Header_Link,SELF:=LEFT,SELF:=[]));
		phdr:=project($.file_header_previous,	TRANSFORM(IDL_Header.Layout_Header_Link,SELF:=LEFT,SELF:=[]));

		isForPublicRecords:=TRUE;

		filedate:=regexfind('[0-9]{8}',std.file.SuperFileContents(header.Filename_Header)[1].name,0);

		EXPORT GenerateLinkingStats:=sequential(
		
				InsuranceHeader_PostProcess.fn_persistenceStats(chdr,phdr,filedate[1..6],TRUE),
				InsuranceHeader_PostProcess.fn_EntityStats(chdr,phdr,filedate[1..6],TRUE)
				
		);
end;