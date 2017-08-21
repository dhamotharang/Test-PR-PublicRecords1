


EXPORT Layout_Export_Admin_Reg_Entity_Licensing := module

export layout_denied_entity := record
  string Extract_Date;
  string Extract_Vendor_Code;
  string Data_Type;
  string Country;
  string Entities;
  string License_Requirement;
  string License_Review_Policy;
  string Federal_Register_Citation;
end;



export layout_add_ent_key := record
  string Ent_Key;
  string Country;
  string Entities;
  string License_Requirement;
  string License_Review_Policy;
  string Federal_Register_Citation;
end;


export layout_set_name_type := record
  string Ent_Key;
  string Country;
  string Entity;
  string name_type;
  string Address;
  string License_Requirement;
  string License_Review_Policy;
  string Federal_Register_Citation;
end;

end;






