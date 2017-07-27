#option('skipFileFormatCrcCheck', 1);
#option('maxLength', 131072);

import ut, lib_stringlib, worldcheck_bridger, worldcheck;

in_file := dataset(WorldCheck_Bridger.Cluster_Name + 'in::worldcheck_bridger::standard'
                                    ,WorldCheck_Bridger.Layout_WorldCheck_in
									,csv(heading(1), separator('\t'),terminator(['\r\n','\r','\n']),quote(''), maxlength(100000)));
									
	Layout_WorldCheck_Premium premTran(in_file l):= transform
		self.Low_Quality_Aliases 	:= '';
		self.Updated_Category 		:= '';
		self := l
	end;

	in_f := project(in_file, premTran(left));

export File_WorldCheck_In := in_f;

