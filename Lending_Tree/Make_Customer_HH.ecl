// Project Customer file to Houshold ID format
Lending_Tree.Layout_Customer_HH InitHouseholdID(Lending_Tree.Layout_Customers L) := TRANSFORM
SELF.household_id := '';
SELF.home_equity_pref := '';
SELF := L;
END;

Customer_HH_Init := PROJECT(Lending_Tree.File_Customers, InitHouseholdID(LEFT));
COUNT(Customer_HH_Init);

// Group and assign household ids to Lending Tree Customer File
Customer_HH_Grpd := GROUP(Customer_HH_Init, ace_zip, prim_name, prim_range, sec_range, ALL);

Lending_Tree.Layout_Customer_HH AssignHouseholdID(Lending_Tree.Layout_Customer_HH L, Lending_Tree.Layout_Customer_HH R) := TRANSFORM
SELF.household_id := IF(L.household_id <> '', L.household_id, R.party_id);
SELF := R;
END;

Customer_HH_ID := GROUP(ITERATE(Customer_HH_Grpd, AssignHouseholdID(LEFT, RIGHT)));
COUNT(Customer_HH_ID);

// Update Home Equity Preference
Lending_Tree.Layout_Customer_HH UpdateHEPref(Lending_Tree.Layout_Customer_HH L, Lending_Tree.Layout_Home_Equity_Pref R) := TRANSFORM
SELF.home_equity_pref := R.home_equity_pref;
SELF := L;
END;

Customer_HH := JOIN(Customer_HH_ID,
                    Lending_Tree.File_Home_Equity_Pref,
                    LEFT.qf_id = RIGHT.qf_id,
                    UpdateHEPref(LEFT, RIGHT),
                    LEFT OUTER);

COUNT(Customer_HH);
OUTPUT(Customer_HH,,'LendTree::Customers_HH');