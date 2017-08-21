UPS_Testing.MAC_EnumerateRecords(UPS_Testing.DS_AutonomyQueriesBiz, enumBizQueries);
selected_queries := CHOOSEN(enumBizQueries((recno % 5) = 0), 1000);

export DS_AutonomyQueriesBiz1k := project(selected_queries, UPS_Testing.layout_TestCase);
