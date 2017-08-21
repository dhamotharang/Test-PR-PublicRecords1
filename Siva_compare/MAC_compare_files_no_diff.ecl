EXPORT MAC_compare_files_no_diff () := functionmacro


  string80 out_string := 'Both file are same';

  return output ( out_string, named('result'), overwrite);

endmacro;
