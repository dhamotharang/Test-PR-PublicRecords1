EXPORT files := module

EXPORT Email_Event_In      := DATASET(constants.In_Email_Event, Layouts.event_layout, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')) );
EXPORT Email_Domain_In     := DATASET(constants.In_Email_Domain, Layouts.domain_layout, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')) );
EXPORT Email_Event_Base	   := dataset(Constants.Email_Event_Base, Layouts.Base_Event_Layout, thor);
EXPORT Domain_Event_Base   := dataset(Constants.Domain_Event_Base, Layouts.Base_Domain_Layout, thor);

end;