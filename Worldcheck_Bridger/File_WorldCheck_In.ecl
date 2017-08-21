#option('skipFileFormatCrcCheck', 1);
#option('maxLength', 131072);

import ut, lib_stringlib, worldcheck_bridger, worldcheck;

in_file := dataset(WorldCheck_Bridger.Cluster_Name + 'in::worldcheck_bridger::standard'
                                    ,WorldCheck_Bridger.Layout_WorldCheck_in
									,csv(heading(1), separator('\t'),terminator(['\r\n','\r','\n']),quote(''), maxlength(100000)));
									
	in_f := PROJECT(in_file, TRANSFORM(Layout_WorldCheck_Premium,
						//self.Last_Name := Latin9ToUnicode(left.Last_Name);
						//self.First_Name := Latin9ToUnicode(left.First_Name);
						self.Aliases := Latin9ToUnicode(left.Aliases);
						self.Low_Quality_Aliases := U'';
						self.Alternate_Spelling := Latin9ToUnicode(left.Alternate_Spelling);
						//self.Companies := Latin9ToUnicode(left.Companies);
						self := LEFT;
						self := [])
				);

export File_WorldCheck_In := in_f;

