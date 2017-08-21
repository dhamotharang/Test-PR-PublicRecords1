/*--SOAP--
<message name="Service_Ip_Search">
	<part name="SourceIp" type="xsd:string"/>
	<part name="DestinationIp" type="xsd:string"/>
	<part name="SourcePort" type="xsd:int"/>
	<part name="DestinationPort" type="xsd:int"/>
	<part name="SentPackets" type="xsd:int"/>
	<part name="DestinationPackets" type="xsd:int"/>
	<part name="RecordLimit" type="xsd:int"/>
</message>
*/
/*--INFO-- 
	This service will search the IP traffic given a variety of paraemters. <BR/>
	need a little description here
*/
export Service_Ip_Search := MACRO
	STRING srcip  := '' : STORED('SourceIp');
	STRING destip := '' : STORED('DestinationIp');
	INTEGER srcport  := -1 : STORED('SourcePort');
	INTEGER destport := -1 : STORED('DestinationPort');
	INTEGER sent_packets  := -1 : STORED('SentPackets');
	INTEGER rcv_packets := -1 : STORED('DestinationPackets');
	INTEGER recLimit := 100 : STORED('RecordLimit');
	
	ds_results := dolecki.Mod_G2_Ip_Search.F_search(
		srcip, 
		destip, 
		srcport, 
		destport, 
		sent_packets, 
		rcv_packets);
	
	output(CHOOSEN(ds_results,recLimit));

ENDMACRO;
