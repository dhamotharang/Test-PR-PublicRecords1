EXPORT Layout_Foreign_Agents_Registration := module

export layout_active_foreign_principals := record
  string Country_Location_Represented;
  string Foreign_Principal;
  string Foreign_Principal_Registration_Date;
  string Address;
  string State;
  string Registrant;
  string Registration_Num;
  string Registration_Date;
end;

export layout_active_registrants := record
  string Registrant;
  string Registration_Num;
  string Registration_Date;
  string Business_Name;
  end;

export layout_active_short_form_registrants := record
  string Short_Form_Name;
  string Short_Form_Date;
  string Short_Form_Termination_Date;
  string Registrant;
  string Registration_Num;
  string Registration_Date;
  string Address;
  string State;
end;

export layout_farareport := record
  string Country;
  string Registrant_ID;
  string Registrant;
  string Registration_Terminated;
  string Address_Line_1;
  string Address_Line_2;
  string Address_Line_3;
  string Foreign_Principal;
  string Foreign_Principal_Terminated;
  string Nature_of_Service;
  string Activities;
  string Finances;
end;

// sub layouts

export layout_parse_address := record
  string Country;
  string Registrant_ID;
  string Registrant;
  string Registrant_Terminated;
  string Address_Line_1;
  string Address_Line_2;
  string Address_Line_3;
  string Foreign_Principal;
  string Foreign_Principal_Terminated;
  string Nature_of_Service;
  string Activities;
  string Finances;
 end; 

export layout_parse_name_address := record
  string Short_Form_Name; 
  string short_Form_Name_primary;
	string short_Form_Name_aka;
  string Name_Type;
  //string Short_Form_Date;
  //string Short_Form_Termination_Date;
  string Registrant;
  string Registration_Num;
  //string Registration_Date;
  // string Address;
  // string Address2;
  // string Address3;
  //string State;
	//string rec_numb;
	//string Short_Form_Terminated;
end;


end;





