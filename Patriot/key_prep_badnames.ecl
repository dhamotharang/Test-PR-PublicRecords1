//DF-28226
export key_prep_badnames := index(annotated_names,{fname,mname,lname,cnt},{annotated_names}-[fname,mname,lname,cnt],'~thor_data400::key::annotated_names_' + thorlib.wuid());