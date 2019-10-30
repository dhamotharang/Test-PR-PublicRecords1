import data_services;
export File_Telcordia_TMP := module

export File_Telcordia_In_TMP 	:= dataset(data_services.foreign_prod + 'thor_200::in::telcordia::tmp', Layout_Telcordia_TMP.Layout_In_TMP, thor);

export File_Telcordia_In_OCN 	:= dataset(data_services.foreign_prod + 'thor_200::in::telcordia::ocn', Layout_Telcordia_TMP.Layout_In_OCN, thor);

export File_Telcordia_In_PLNAME := dataset(data_services.foreign_prod + 'thor_200::in::telcordia::plname', Layout_Telcordia_TMP.Layout_In_PLNAME, thor);

tmp_ocn := join(File_Telcordia_In_TMP, 
				File_Telcordia_In_OCN,
				left.ocn = right.ocn,
				transform(Layout_Telcordia_TMP.Layout_Out_TMP, self := left, self := right),
				left outer);
				

tmp_ocn_plname := join(tmp_ocn, 
				File_Telcordia_In_PLNAME,
				left.state = right.state and
				left.place_name = right.place_name,
				transform(Layout_Telcordia_TMP.Layout_Out_TMP, self := left, self := right),
				left outer);
				
tmp_block_id_A := tmp_ocn_plname (Block_id = 'A');


tmp_block_id_A_denorm := normalize(tmp_block_id_A, 
									 10,
									 transform(Layout_Telcordia_TMP.Layout_Out_TMP, self.block_id := (string1) (counter - 1), self := left));
									 
tmp_dedp := dedup(sort(tmp_block_id_A_denorm + tmp_ocn_plname (Block_id <> 'A'), record), record);									 

export File_Telcordia_TMP_Out := tmp_dedp : 
								 persist('~thor_data400::persist::Phonesplus::File_Telcordia_TMP');

end;