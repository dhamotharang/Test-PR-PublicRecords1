export MAC_SK_Move_To_Built(keyname, superkeyname, seq_name, numgenerations = '3', one_node = 'false') := macro
/*
theindexprep is the index to be written to disk
Keyname is 'key::xxxx' (to be added to WUID for unique key name)
SuperKeyname is 'key::xxxx' (superfile name)
seq_name is the sequential output name
numgenerations is currently to be just 2, 3 or 4
*/
#uniquename(ng)
%ng% := (integer)numgenerations;

#uniquename(todelete)
%todelete% := map(%ng% = 4 => superkeyname + '_Great_Grandfather',
                  %ng% = 3 => superkeyname + '_Grandfather', 
                  superkeyname + '_father');

#uniquename(workalreadydone)
%workalreadydone%(string sub) :=															//only works on resubmit
	sub[(length(sub) - 14)..length(sub)] = thorlib.wuid()[2..16];   //output key was added to superkey

seq_name := 
	if(%ng% not in [2,3,4], fail('ut.MAC_SF_BuildProcess failure, numgenerations not in [2,3,4]'),
	  if(%workalreadydone%(FileServices.GetSuperFileSubName(superkeyname + '_Built',1)),
		output(keyname + ' work done in previous submission of this WU.'),
		sequential(
				FileServices.StartSuperFileTransaction(),
				FileServices.AddSuperFile(superkeyname + '_Delete', %todelete%,, true),
				#if(%ng% in [3,4])
				   #if(%ng% = 4)
				  	FileServices.ClearSuperFile(superkeyname + '_Great_Grandfather'),
					FileServices.AddSuperFile(superkeyname + '_Great_Grandfather', superkeyname + '_Grandfather',, true),
				   #end
					FileServices.ClearSuperFile(superkeyname + '_Grandfather'),
					FileServices.AddSuperFile(superkeyname + '_Grandfather', superkeyname + '_father',, true),
			     #end
				FileServices.ClearSuperFile(superkeyname + '_father'),
				FileServices.AddSuperFile(superkeyname + '_father', superkeyname + '_Built',, true),
				FileServices.ClearSuperFile(superkeyname + '_Built'),
				FileServices.AddSuperFile(superkeyname + '_Built', keyname), 
			FileServices.FinishSuperFileTransaction(),
			Fileservices.RemoveOwnedSubFiles(superkeyname+'_Delete',true),
			Fileservices.Clearsuperfile(superkeyname+'_Delete')
			/*if(fileservices.getsuperfilesubname(superkeyname + '_Delete',1)=fileservices.getsuperfilesubname(superkeyname + '_QA',1),
					FileServices.ClearSuperFile(superkeyname + '_Delete'),
						Fileservices.RemoveOwnedSubFiles(superkeyname+'_Delete')) */
		)));
endmacro;