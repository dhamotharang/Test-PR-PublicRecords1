export MAC_SK_BuildProcess_v2(theindexprep, newkeyname, superkeyname, seq_name, one_node = 'false', diffing = 'false') := macro
/*
theindexprep is the index to be written to disk
SuperKeyname is 'key::xxxx' (superfile name)
seq_name is the sequential output name
numgenerations is currently to be just 2, 3 or 4
*/

#uniquename(todelete)
%todelete% := superkeyname + '_Built';
#uniquename(difftodelete)
%difftodelete% := superkeyname + '_diff_Built';

#uniquename(workalreadydone)
%workalreadydone%(string sub) :=								//only works on resubmit
	sub[(length(sub) - 14)..length(sub)] = thorlib.wuid()[2..16];   	//output key was added to superkey

#uniquename(superdiffname)
%superdiffname% := superkeyname+'_diff';


seq_name := 
	  if(%workalreadydone%(FileServices.GetSuperFileSubName(%todelete%,1)),
		output(superkeyname + ' work done in previous submission of this WU.'),
		sequential(
			#if (one_node)
				buildindex(theindexprep,newkeyname,overwrite,few),
			#else 
				#if(~diffing)
					buildindex(theindexprep,newkeyname,overwrite),
				#else
					buildindex(theindexprep,newkeyname,DISTRIBUTE(index(theindexprep,superkeyname+'_Prod')),overwrite),
					keydiff(index(theindexprep,superkeyname+'_Prod'),index(theindexprep,newkeyname),%superdiffname%+thorlib.WUID()),
				#end
			#end
			FileServices.StartSuperFileTransaction(),
				FileServices.AddSuperFile(superkeyname + '_Delete', %todelete%,, true),
				#if(diffing)
					FileServices.AddSuperFile(%superdiffname% + '_Delete', %difftodelete%,, true),
				#end
				FileServices.ClearSuperfile(%todelete%),
				FileServices.AddSuperFile(superkeyname + '_Built', newkeyname), 
				#if(diffing)
					FileServices.ClearSuperfile(%difftodelete%),
					FileServices.AddSuperFile(%superdiffname% + '_Built', %superdiffname% + thorlib.WUID()), 
				#end
			FileServices.FinishSuperFileTransaction(),
			FileServices.ClearSuperFile(superkeyname + '_Delete',true)
			#if(diffing)
				,FileServices.ClearSuperFile( %superdiffname% + '_Delete',true)
			#end
		));
endmacro;
