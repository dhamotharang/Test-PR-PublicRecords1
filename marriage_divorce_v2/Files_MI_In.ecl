 import ut;


export Files_MI_In := MODULE

 export File_Mar_Div_MI_Interm_In :=dataset(ut.foreign_prod+'~thor_200::in::marriage_divorce_20070627', marriage_divorce_v2.Layouts_MI_mar_div.Layout_intermediate_MI_mar_div, flat);

 //need to do this portion in abintio beacuse of the record  layouts.
 //export File_Mar_Div_MI_In :=dataset(ut.foreign_prod+'~thor_data200::in::mar_div::20070625::mi::md_data', marriage_divorce_v2.Layouts_MI_mar_div.Layout_MI_mar_div, flat);

 

end;