EXPORT count_categories(

    pSeg_Dataset
   ,pSort_Order 
) :=
functionmacro

  #UNIQUENAME(ds_segs_table )
  #UNIQUENAME(ds_segs_out   )
  #UNIQUENAME(ds_total_out  )

  lay_out := {unsigned srt,string category,string subcategory,string file,string cnt};

  %ds_segs_table% := table(pSeg_Dataset ,{category,subcategory,string file := trim(#TEXT(pSeg_Dataset)),unsigned cnt := count(group)} ,category,subcategory ,few);
  
  %ds_segs_out%  := project(%ds_segs_table%  ,transform(lay_out,self.srt := pSort_Order,self.cnt := ut.fIntWithCommas(left.cnt),self := left));
  %ds_total_out% := dataset([{pSort_Order,'Total','',trim(#TEXT(pSeg_Dataset)),ut.fIntWithCommas(count(pSeg_Dataset))}]  
  ,lay_out);  

  return %ds_total_out% + %ds_segs_out%;

endmacro;