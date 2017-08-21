EXPORT Layout_US_Bureau_of_Industry_And_Security_Denied_Persons := MODULE

export Layout_Denied_Persons_List := record
   string Name;
   string eff_date;
   string exp_date;
   string Standard_Order;
   string Street_Address;
   string Federal_Citation;
   string denial_type;
end;

end;