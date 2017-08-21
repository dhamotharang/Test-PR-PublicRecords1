/*--SOAP--
<message name="Service_Basic_Search">
	<part name="_SourceIP" type="xsd:string"/>
	<part name="_SourcePort" type="xsd:int" maxlength="5"/>
	<part name="_DestinationIP" type="xsd:string"/>
	<part name="_DestinationPort" type="xsd:int" maxlength="5"/>
	<part name="_Protocol" type="xsd:string" maxlength="16"/>
	<part name="_Source_Country" type="xsd:string" maxlength="2"/>
	<part name="_Destination_Country" type="xsd:string" maxlength="2"/>	
	<part name="_PacketsSent" type="xsd:int" maxlength="10"/> 
	<part name="_PacketsReceived" type="xsd:int" maxlength="10"/>
	<part name="_FirewallRecords" type="xsd:int" maxlength="10"/>
	<part name="_start_date" type="xsd:string"/>
	<part name="_stop_date" type="xsd:string"/>
	<part name="_min_duration" type="xsd:float"/>
	<part name="_max_duration" type="xsd:float"/>
	<part name="_min_tod" type="xsd:int" maxlength="10"/>
	<part name="_max_tod" type="xsd:int" maxlength="10"/>
	<!--part name="_Duration" type="xsd:string"-->
	
	<part name="RecordLimit" type="xsd:int"/>
</message>
*/
/*--INFO-- This service supports wildcard (*) syntax in the IP fields. Fields left <BR/>
	blank will be interpretted as ALL. Fields to choose the sort order will be added.<BR/>
	Results are sorted by start time by default. SortByIP will cause the results to be sorted <BR/>
	by source and destination IP addresses.<BR/><BR/>
	Sample input to test with is as follows: <BR/>
	srcIp=12.104.54.* DestIp=(blank)<BR/>
	srcIp=12.104.54.* DestIp=147.*137.*<BR/>
	srcIp=*.104.54.*  DestIp=147.137.1.2<BR/>
*/

export Service_Basic_Search := MACRO
	STRING   SourceIP         := '' : STORED('_SourceIP');
	INTEGER3 SourcePort       := -1 : STORED('_SourcePort');
	STRING   DestinationIP    := '' : STORED('_DestinationIP');
	INTEGER3 DestinationPort  := -1 : STORED('_DestinationPort');
	STRING   Protocol         := '' : STORED('_Protocol');
	STRING2  Source_CC        := '' : STORED('_Source_Country');
	STRING2  Destination_CC   := '' : STORED('_Destination_Country');
	INTEGER5  PacketsSent     := -1 : STORED('_PacketsSent');
	INTEGER5  PacketsReceived := -1 : STORED('_PacketsReceived');
	INTEGER5 FirewallRecords  := -1 : STORED('_FirewallRecords');
	STRING start_date         := '' : STORED('_start_date');
	STRING stop_date          := '' : STORED('_stop_date');
	REAL4 min_duration        := -1 : STORED('_min_duration');
	REAL4 max_duration        := -2 : STORED('_max_duration');
	INTEGER4 min_tod         := -1 : STORED('_min_tod');
	INTEGER4 max_tod         := -2 : STORED('_max_tod');
	INTEGER2  recLimit        := 100 : STORED('RecordLimit');
	
	start_fallback := -140737488355328;
	stop_fallback := 140737488355327;
	
	ms_start__ := buzzsaw.Mod_Data_Util.translate_date(start_date, start_fallback);
	ms_stop__ := buzzsaw.Mod_Data_Util.translate_date(stop_date, stop_fallback);
//	output(ms_start__ + ' and ' + ms_stop__);

	ignore_dates := (ms_start__ = start_fallback AND ms_stop__ = stop_fallback);
	ms_start := IF( ignore_dates, 1, ms_start__);
	ms_stop := IF( ignore_dates, -1, ms_stop__);
//	output(ignore_dates + ' => ' + ms_start + ' and ' + ms_stop);
	
	
	/*
	 * Search the traffic log data
	 */
	ds := buzzsaw.Mod_Basic_Filters.F_Basic_Search(
			sourceIP, 
			SourcePort, 
			destinationIP, 
			DestinationPort,
			Protocol,
			Source_CC,
			Destination_CC,
			PacketsSent,
			PacketsReceived,
			FirewallRecords,
			ms_start,
			ms_stop,
			min_duration,
			max_duration,
			min_tod,
			max_tod,
			recLimit+1
			);

	/*
	 * Join the srcips with location
	 */
//	data_found := buzzsaw.Mod_Basic_Filters.F_Unpack_U4(ds);
	
//	IF(count(ds) > recLimit, output('yes', NAMED('more_data')));
	output(CHOOSEN(ds, recLimit),NAMED('data'));

ENDMACRO;