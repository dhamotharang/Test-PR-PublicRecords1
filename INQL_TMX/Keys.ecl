import doxie, tools, ut;

export Keys(

  string  pversion	= '',
	boolean pUseProd = false,
	boolean pIsFull = false // KJE - Added

) :=
module

  // IMPORTANT NOTE: One must perform a SORT on the resultant dataset so that the SAMPLE invocations against 
  // the dataset will behave properly; the results will be correct instead of returning the full dataset!
	Base := SORT(DISTRIBUTE(Files(pversion, pUseProd, pIsFull).Base.qa, HASH(request_id)), request_id, LOCAL);

  //----------------------------------------------------------------------------------------------------------
  // Create the KEY_PAYLOAD dataset form from the BASE file.
  //----------------------------------------------------------------------------------------------------------
	Key_Payload := PROJECT
                 (
                      Base, 
                      TRANSFORM 
                      (
                         INQL_TMX.Layouts.key_payload, 
                         SELF.trans_date := left.date_time[1..4]+left.date_time[6..7]+left.date_time[9..10],
                         SELF.trans_hhmm := left.date_time[12..13]+left.date_time[15..16],
                         SELF.trans_ss := left.date_time[18..19],
                         SELF := LEFT
                      )
                 );

  // Compute and populate the recid value in the KEY_PAYLOAD for indexing purposes.
  ut.MAC_Sequence_Records(Key_Payload, recid, Sequenced_Key_Payload);
  
  SHARED Sequenced_Key_Payload_Final := Sequenced_Key_Payload;
  
  //----------------------------------------------------------------------------------------------------------
  // Create the slimmed KEY_SEARCH data set 
  //----------------------------------------------------------------------------------------------------------
  Key_Search_Slim := PROJECT(Sequenced_Key_Payload_Final, INQL_TMX.Layouts.key_search);
  
	tools.mac_FilesIndex
  (
      'Key_Search_Slim, {org_id, trans_date, trans_hhmm, trans_ss, api_type, event_type}, {Key_Search_Slim}', 
      Keynames(pversion, pUseProd, pIsFull).Search, 
      Search
  );

  //----------------------------------------------------------------------------------------------------------
  // Split up the dataset into odd / even pulls so as not to overload the system with this massive dataset.
  //----------------------------------------------------------------------------------------------------------
  EXPORT ds_Search_ID_1 := SAMPLE(Sequenced_Key_Payload_Final, 2, 1);
  
	tools.mac_FilesIndex
  (
      'ds_Search_ID_1, {recid, org_id, trans_date, trans_hhmm, trans_ss, api_type, event_type}, {ds_Search_ID_1}', 
      Keynames(pversion, pUseProd, pIsFull).Search_ID_1, 
      Search_ID_1
  );

  EXPORT ds_Search_ID_2 := SAMPLE(Sequenced_Key_Payload_Final, 2, 2);

	tools.mac_FilesIndex
  (
      'ds_Search_ID_2, {recid, org_id, trans_date, trans_hhmm, trans_ss, api_type, event_type}, {ds_Search_ID_2}', 
      Keynames(pversion, pUseProd, pIsFull).Search_ID_2, 
      Search_ID_2
  );
  
end;
