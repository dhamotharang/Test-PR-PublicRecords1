IMPORT PersonContext;
EXPORT _FakePersonContextData := MODULE
	EXPORT Ignore := TRUE;	
	EXPORT Records := DATASET([
  /*{'SearchStatus', 'LexId', 'RecId1', 'RecId2', 'RecId3', 'RecId4', 'CD_Id', 'DataGroup', 'RecordType', 'DataTypeVersion', 'DateAdded', 'EventType', 'SourceSystem', 'StatementSequence', 'StatementId', 'Content'}*/
  {'501','355','', '','', '', '', 'PERSON', 'CS', '1', '2016-8-11-17:00.00', 'ADD', 'MBS', '1', '10089', 'This is about 355'}
  ,{'501','355','', '','', '', '', 'PERSON', 'CS', '1', '2016-8-11-17:00.00', 'ADD', 'MBS', '1', '10089', 'This is about 355 again'}
  ,{'501','355','10645841083312294166', '','', '', '', 'MARRIAGE_SEARCH', 'RS', '1', '2016-8-11-17:00.00', 'ADD', 'MBS', '1', '10089', 'This is from 355 about 10645841083312294166'}
  ,{'501','355','17901302347663125305', '','', '', '', 'MARRIAGE', 'RS', '1', '2016-8-11-17:00.00', 'ADD', 'MBS', '1', '10089', 'This message is from 355 about 17901302347663125305'}
	,{'501','355','5153912657954622373', '','', '', '', 'MARRIAGE_SEARCH', 'CS', '1', '2016-8-11-17:00.00', 'ADD', 'MBS', '1', '10089', 'This is about 355'}
	,{'501','355','9781123237896377785', '','', '', '', 'MARRIAGE_SEARCH', 'CS', '1', '2016-8-11-17:00.00', 'ADD', 'MBS', '1', '10089', 'This message is from 355 about 9781123237896377785'}
  ], PersonContext.Layouts.Layout_PCResponseRec);
END;
	
	
