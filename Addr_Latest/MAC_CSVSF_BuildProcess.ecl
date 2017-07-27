export MAC_CSVSF_BuildProcess(thedataset, basename, seq_name, file_type, numgenerations = '3') := macro
/*
thedataset is the dataset to be written to disk
basename is 'base::xxxx'
numgenerations is currently to be just 2 or 3
*/
#uniquename(ng)
%ng% := (integer)numgenerations;
if(%ng% not in [2,3], fail('ut.MAC_SF_BuildProcess failure, numgenerations not in [2,3]'));

#uniquename(ft)
%ft% := (string)file_type;

#uniquename(todelete)
%todelete% := if(%ng% = 3, basename + '_Grandfather', basename + '_father');

#uniquename(workalreadydone)
%workalreadydone%(string sub) :=															//only works on resubmit
	sub[(length(sub) - 14)..length(sub)] = thorlib.wuid()[2..16];   //output file was added to basename

seq_name := 
	if(%workalreadydone%(FileServices.GetSuperFileSubName(basename,1)),
		output(basename + ' work done in previous submission of this WU.'),
		sequential(
                    #if(%ft% = 'out' or %ft% = 'OUT')
				output(thedataset,,basename + thorlib.WUID(),
                           csv(heading('"cubs","name","addr line1","city","state","zip","cubs2","dob","bad address flag","ssn","drl","drl-state","prim range","predir","prim name","addr suffix","postdir","unit desig","sec range","city name","st","zip5","zip4","name match type","addr match type","dob match type","ssn match type","drl match type","rec match type","in last name","matched last name","in mid name","matched mid name","in first name","matched first name","in ssn","matched ssn","in birth date","matched birth date"'+'\n',''),
                                       separator(','), terminator('\n'), quote('"')),overwrite),
                    #else 
                         #if(%ft% = 'stat' or %ft% = 'STAT')
                             output(thedataset,,basename + thorlib.WUID(),
                             csv(separator(','), terminator('\n')),overwrite),
                         #else
					    output(thedataset,,basename + thorlib.WUID(),
                             csv(separator(','), terminator('\n'), quote('"')),overwrite),
                         #end
                    #end
				FileServices.StartSuperFileTransaction(),
					FileServices.AddSuperFile(basename + '_Delete', %todelete%,, true),
					#if(%ng% = 3)
						FileServices.ClearSuperFile(basename + '_Grandfather'),
						FileServices.AddSuperFile(basename + '_Grandfather', basename + '_father',, true),
					#end
					FileServices.ClearSuperFile(basename + '_father'),
					FileServices.AddSuperFile(basename + '_father', basename,, true),
					FileServices.ClearSuperFile(basename),
					FileServices.AddSuperFile(basename, basename + thorlib.WUID()), 
				FileServices.FinishSuperFileTransaction(),
				FileServices.ClearSuperFile(basename + '_Delete',true)
		));
endmacro;