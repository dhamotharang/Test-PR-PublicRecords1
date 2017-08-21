import ut,mdr;
export move_header_raw_to_prod(string filedate = Header.version_build) := function

	basename:='~thor_data400::base::header_raw';
	delete:=basename+'_delete';
	prod:=basename+'_prod';
	father:=basename+'_father';
	gfather:=basename+'_grandfather';
	built:=basename+'_built';

	seq_name:=map(
								FileServices.GetSuperFileSubName(basename,1) = FileServices.GetSuperFileSubName(prod, 1) 
															=> output('Built already in Prod. No action taken.')
								,   FileServices.GetSuperFileSubCount(built) = 0
								and FileServices.GetSuperFileSubCount(built+'1') = 0
								and FileServices.GetSuperFileSubCount(built+'2') = 0
								and FileServices.GetSuperFileSubCount(built+'3') = 0
								and FileServices.GetSuperFileSubCount(built+'4') = 0
															=> output('Built is empty! No action taken.')
							,sequential(
									FileServices.AddSuperFile(delete, gfather,, true)
									,FileServices.ClearSuperFile(gfather)

									,FileServices.AddSuperFile(gfather, father,, true)
									,FileServices.ClearSuperFile(father)

									,FileServices.AddSuperFile(father, prod,, true)
									,FileServices.ClearSuperFile(prod)

									,FileServices.AddSuperFile(prod, built,, true)

									,if(FileServices.GetSuperFileSubCount(built+'1') > 0
											,sequential(
																FileServices.ClearSuperFile(basename)
																,FileServices.ClearSuperFile(built)

																,FileServices.AddSuperFile(built, built+'1',, true)
																,FileServices.AddSuperFile(basename, built+'1',, true)
																,FileServices.ClearSuperFile(built+'1')

																,FileServices.AddSuperFile(built+'1', built+'2',, true)
																,FileServices.ClearSuperFile(built+'2')

																,FileServices.AddSuperFile(built+'2', built+'3',, true)
																,FileServices.ClearSuperFile(built+'3')

																,FileServices.AddSuperFile(built+'3', built+'4',, true)
																,FileServices.ClearSuperFile(built+'4')
																)
											)

									,FileServices.ClearSuperFile(delete,true)
									,output('_built moved to _prod')));

	return seq_name;

END;