IMPORT ebr,EBR_Services;

EXPORT Layouts := 
MODULE
  
  // the demo 5600 input layout was used in the output layout.
  // the sales_actual input declaration is string7 and is an EBR 
  // code. Removing the input declaration and adding a
  // string20, so the conversion can take place and be output.
  EXPORT demographic_5600_output_Rec := RECORD
    ebr.Layout_5600_demographic_data_In - [SALES_ACTUAL];
    STRING20 SALES_ACTUAL;
  END;
  
END;