export Layout_Wide_Hdr := record
  string12     uid;
  string5      title;  
  string20      fname;
  string20      mname;
  string20      lname;
  string5      name_suffix; 
  string5      title_2:='';  
  string20      fname_2:='';
  string20      mname_2:='';
  string20      lname_2:='';
  string5      name_suffix_2:=''; 
  string5      title_3:='';  
  string20      fname_3:='';
  string20      mname_3:='';
  string20      lname_3:='';
  string5      name_suffix_3:=''; 
  string10      phone; 
  string9      ssn;    
  string8     dob;
  string10      prim_range; 
  string2      predir; 
  string28      prim_name;
  string4      suffix; 
  string2      postdir; 
  string10      unit_desig; 
  string8      sec_range; // ?
  string25     city_name; 
  string2      st; 
  string5      zip; 
  string4      zip4;
  string10      prim_range_2 := ''; 
  string2      predir_2 := '';
  string28      prim_name_2 := '';
  string4      suffix_2 := '';
  string2      postdir_2 := '';
  string10      unit_desig_2 := ''; 
  string8      sec_range_2 := ''; 
  string25     city_name_2 := ''; 
  string2      st_2 := ''; 
  string5      zip_2 := ''; 
  string4      zip4_2 := ''; 
  string10      prim_range_3 := ''; 
  string2      predir_3 := ''; 
  string28      prim_name_3 := '';
  string4      suffix_3 := ''; 
  string2      postdir_3 := ''; 
  string10      unit_desig_3 := '';
  string8      sec_range_3 := '';
  string25     city_name_3 := '';
  string2      st_3 := ''; 
  string5      zip_3 := '';
  string4      zip4_3 := '';
  end;