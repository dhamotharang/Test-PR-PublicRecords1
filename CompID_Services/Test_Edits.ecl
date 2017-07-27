// Unit test case for CompId Edits Order (Runnable in builder window)
#WORKUNIT('NAME', 'CompId-EditsV2 Query');

#STORED ('AllowAll', true);
Layout_StrArrayItem := iesp.share.t_StringArrayItem;

EditsOrder := DATASET([
										 {'000RI01472585SEA               000035909733620000030000                                    0353       SS         0204102009'},
										 {'001PI01RS    HAYES                       VICTORIA            J                 12051979   F454877488             Y'}
										], Layout_StrArrayItem);

Result := CompID_Services.Search_Common.getResultForEdits(EditsOrder);

OUTPUT(EditsOrder, NAMED('EditsOrder'));
OUTPUT(Result , NAMED('Result'));

/**
Test data for General Search (Hit)
EditsOrder := DATASET([
										 {'000RI01472585SEA               000035909733620000030000                                    0353       HU         0204102009'},
										 {'000RI021234567890223456789032345678904234567890523456789062345678907234567890823456789092345678900234567890X12X'},
										 {'000RP01RPT_RQSTR_NAME                                    CO_NAME                                           CC'},
										 {'001PI01RS    HAYES                       VICTORIA            J                 12051979   F454877488             Y'},
										 {'001AL01LA 8623     SHALLOW RIDGE DR         SAN ANTONIO         TX78239000000000000000000000000'},
										 {'001DL01CPSJ861876                 OH'}
										], Layout_StrArrayItem);


Test data for SSN Search (Hit)
EditsOrder := DATASET([
										 {'000RI01472585SEA               000035909733620000030000                                    0353       SS         0204102009'},
										 {'001PI01RS    MONAT                       CHARLES             S                 05091944   M072349395             Y'}
										], Layout_StrArrayItem);

Test data for DL Search (Hit)
EditsOrder := DATASET([
										 {'000RI01472585SEA               000035909733620000030000                                    0353       DL         0204102009'},
										 {'001DL01CPSJ861876                 OH'}
										], Layout_StrArrayItem);

SSN Query - Hit (With DL in the Result):
EditsOrder := DATASET([
										 {'000RI01472585SEA               000035909733620000030000                                    0353       SS         0204102009'},
										 {'001PI01RS    HAYES                       VICTORIA            J                 12051979   F454877488             Y'}
										], Layout_StrArrayItem);

Test data for AM Query (Hit)
EditsOrder := DATASET([
											{'000RI01515814ABCBILLX          TEST PENN AVE                                               8888A      AM       I 0204272009                        C02'},
											{'001AL01LA 8623     SHALLOW RIDGE DR         SAN ANTONIO         TX78239000000000000000000000000'}
										], Layout_StrArrayItem);

*/
