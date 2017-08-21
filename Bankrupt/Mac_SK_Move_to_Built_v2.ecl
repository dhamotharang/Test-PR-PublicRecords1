export Mac_SK_Move_to_Built_v2(superkeyname, lkeyname, seq_name, one_node = 'false', diffing = 'false')
:= macro

#uniquename(todelete)
%todelete% := superkeyname + '_Built';

#uniquename(difftodelete)
%difftodelete% := superkeyname + '_diff_Built';

#uniquename(superdiffname)
%superdiffname% := superkeyname+'_diff';

#uniquename(workalreadydone)
%workalreadydone%(string sub) :=								//only works on resubmit
	sub[(length(sub) - 14)..length(sub)] = thorlib.wuid()[2..16];   	//output key was added to superkey

seq_name := if(%workalreadydone%(FileServices.GetSuperFileSubName(%todelete%,1)),
				output(superkeyname + ' work done in previous submission of this WU.'),
				sequential(
						FileServices.StartSuperFileTransaction(),
						FileServices.AddSuperFile(superkeyname + '_Delete', %todelete%,, true),
						#if(diffing)
							FileServices.AddSuperFile(%superdiffname% + '_Delete', %difftodelete%,, true),
						#end
						FileServices.ClearSuperfile(%todelete%),
						FileServices.AddSuperFile(superkeyname + '_Built', lkeyname), 
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