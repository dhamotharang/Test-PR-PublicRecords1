optout_record_layout :=
RECORD
  string10 product;
  string5 linking_type;
  string20 linking_id;
  string15 document_type;
  string60 document_id;
  string8 date_added;
  string25 user;
  string25 compliance_id;
  string255 comment;
 END;






df_document_id_old := dataset('~thor_data400::base::new_suppression_file_father', optout_record_layout, flat);
df_document_id_new := dataset('~thor_data400::base::new_suppression_file', optout_record_layout, flat);

df_linking_id_old := dataset('~thor_data400::base::new_suppression_file_father', optout_record_layout, flat);
df_linking_id_new := dataset('~thor_data400::base::new_suppression_file', optout_record_layout, flat);


                          
new_document_id_results := join(df_document_id_old, df_document_id_new, left.document_id=right.document_id, right only);
new_linking_id_results := join(df_linking_id_old, df_linking_id_new, left.linking_id=right.linking_id, right only);



//output(new_document_id_results,, '~thor_data400::out::suppression_document_id::samples',named('Document_ID_Samples_test'),thor,overwrite);
output(new_linking_id_results,, '~thor_data400::out::suppression_linking_id::samples',named('Linking_ID_Samples'),thor,overwrite);


