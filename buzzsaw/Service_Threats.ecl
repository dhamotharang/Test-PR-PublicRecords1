/*--SOAP--
<message name="Service_Threats">
	<part name="_SourceIP" type="xsd:string"/>
	<part name="_SourcePort" type="xsd:int" maxlength="5"/>
	<part name="_DestinationIP" type="xsd:string"/>
	<part name="_DestinationPort" type="xsd:int" maxlength="5"/>
	<part name="_Protocol" type="xsd:string" maxlength="16"/>
	<part name="_Source_Country" type="xsd:string" maxlength="2"/>
	<part name="_Destination_Country" type="xsd:string" maxlength="2"/>	
	<part name="_PacketsSent" type="xsd:int" maxlength="10"/> 
	<part name="_PacketsReceived" type="xsd:int" maxlength="10"/>
	<part name="_Source_Threat" type="xsd:string" maxlength="16"/>
	<part name="_Destination_Threat" type="xsd:string" maxlength="16"/>
	<part name="_FirewallRecords" type="xsd:int" maxlength="10"/>
	<part name="_start_date" type="xsd:string"/>
	<part name="_stop_date" type="xsd:string"/>
	<part name="_min_duration" type="xsd:float"/>
	<part name="_max_duration" type="xsd:float"/>
	<part name="_min_tod" type="xsd:int" maxlength="10"/>
	<part name="_max_tod" type="xsd:int" maxlength="10"/>
	<part name="RecordLimit" type="xsd:int"/>
</message>
*/
/*--INFO-- This service supports wildcard (*) syntax in the IP fields. Fields left <BR/>
	blank will be interpretted as ALL. 

*/

export Service_Threats := MACRO
	STRING   SourceIP        := '' : STORED('_SourceIP');
	INTEGER3 SourcePort      := -1 : STORED('_SourcePort');
	STRING   DestinationIP   := '' : STORED('_DestinationIP');
	INTEGER3 DestinationPort := -1 : STORED('_DestinationPort');
	STRING   Protocol        := '' : STORED('_Protocol');
	STRING   SourceCountry   := '' : STORED('_Source_Country');
	STRING   DestCountry     := '' : STORED('_Destination_Country');
	INTEGER5 PacketsSent     := -1 : STORED('_PacketsSent');
	INTEGER5 PacketsReceived := -1 : STORED('_PacketsReceived');
	STRING   SourceThreat    := '' : STORED('_Source_Threat');
	STRING   DestThreat      := '' : STORED('_Destination_Threat');
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

	ds := buzzsaw.Mod_Basic_Filters.F_Filter_Threats(
			sourceIP, 
			SourcePort, 
			destinationIP, 
			DestinationPort,
			Protocol,
			SourceCountry,
			DestCountry,
			PacketsSent,
			PacketsReceived,
			SourceThreat,
			DestThreat,
			FirewallRecords,
			ms_start,
			ms_stop,
			min_duration,
			max_duration,
			min_tod,
			max_tod,			
			recLimit+1);

	/*
	 * Join the srcips with location
	 */ 
	ds_locs := buzzsaw.Mod_Basic_Filters.F_Unpack_Threats(CHOOSEN(ds, recLimit));
	
	data_found := PROJECT(ds_locs, TRANSFORM(buzzsaw.Mod_Data.L_Firewall_Unpacked, 
				SELF.date := buzzsaw.Mod_Y2K.format_date(LEFT.ms_start),
				SELF := LEFT)
			);
	
	output(data_found, NAMED('data'));



ENDMACRO;