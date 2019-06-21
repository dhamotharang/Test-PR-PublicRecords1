
//******  Layout Comparison Macro **************

//step 1
// change the logical file names
source_logical_file:= '~foreign::10.194.90.202::' + 'qview::pr::phone_nonfcra_vault_src';
destination_logical_file:= '~foreign::10.194.90.202::' + 'qview::pr::phone_nonfcra_ent';


  // get logical file layout and convert into set

filtered_lay_source_logical_file:= Kel_Shell_Entity_QA.Get_layout(source_logical_file);
filtered_lay_destination_logical_file:= Kel_Shell_Entity_QA.Get_layout(destination_logical_file);
 
 // ****** example test layout *************
// filtered_lay_source_logical_file :=['integer8', 'B2bActvTLInOthCnt', 'integer', 'B2bActvTLBalInOthTot', 'integer7', 'inputlexidecho', 'integer7', 'xx'] ;  
// filtered_lay_destination_logical_file :=['integer7', 'B2bActvTLInOthCnt', 'data2', 'B2bActvTLBalInOthTot', 'string50', 'inputlexidecho'];

//step 2
// run this
Kel_Shell_Entity_QA.Layout_Comparison_Macro(filtered_lay_source_logical_file, filtered_lay_destination_logical_file);      

EXPORT BWR_Layout_Comparison_Macro := 'todo';