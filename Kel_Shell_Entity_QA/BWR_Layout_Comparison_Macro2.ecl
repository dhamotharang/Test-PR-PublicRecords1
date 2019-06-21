//STEP 1
// flattened files logical names
src_logical_file:='~kreddy::test::source_file_layset';
desti_logical_file:='~kreddy::test::desti_file_layset';

//STEP 2
// Update Kel_Shell_Entity_QA.Layouts layouts (SRC_Lay, DESI_lay)


source_file_pjt:= DATASET(src_logical_file, Kel_Shell_Entity_QA.Layouts.SRC_Lay, THOR);
desti_file:= DATASET(desti_logical_file, Kel_Shell_Entity_QA.Layouts.DESTI_Lay, THOR);

//STEP 3
// run this
Kel_Shell_Entity_QA.Layout_Comparison_Macro2(source_file_pjt,// flatten file
																						 desti_file, // flatten file
																						 src_logical_file, 
																						 desti_logical_file);

EXPORT BWR_Layout_Comparison_Macro2 := 'todo';