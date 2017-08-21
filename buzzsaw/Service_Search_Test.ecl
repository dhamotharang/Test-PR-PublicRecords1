/*--SOAP--
<message name="Service_Search_Test">
	<part name="_SourceIP" type="xsd:string"/>
	<part name="_SourcePort" type="xsd:int" maxlength="5"/>
	<part name="_DestinationIP" type="xsd:string"/>
	<part name="_DestinationPort" type="xsd:int" maxlength="5"/>
	<part name="_SortByIP" type="xsd:boolean"/>
</message>
*/
/*--INFO-- This service supports wildcard (*) syntax in the IP fields. Fields left <BR/>
	blank will be interpretted as ALL. Fields to choose the sort order will be added.<BR/>
	Results are sorted by start time by default. SortByIP will cause the results to be sorted <BR/>
	by source and destination IP addresses.<BR/><BR/>
	Sample input to test with is as follows: <BR/>
	srcIp=12.104.54.* DestIp=(blank)<BR/>
	srcIp=12.104.54.* DestIp=147 or 137<BR/>
  srcIp=*.104.54.*  DestIp=147 or 137<BR/>
	Protocols to use are 6 or 17. Ports to use to filter are 53 or 80.

*/

export Service_Search_Test := MACRO


	BOOLEAN sortByIp := FALSE : STORED('_SortByIP');
	STRING SourceIP := '' : STORED('_SourceIP');
	INTEGER3 SourcePort := -1 : STORED('_SourcePort');
	STRING DestinationIP := '' : STORED('_DestinationIP');
	INTEGER3 DestinationPort := -1 : STORED('_DestinationPort');



//filtered_n := buzzsaw.Mod_Data.DS_U4(destip_u4=1466090792);
filtered_n := FETCH(buzzsaw.Mod_Data.DS_U4,
		buzzsaw.Mod_Data.IDX_U4_destip_u4(destip_u4=1466090792),
		RIGHT.RecPtr
		//,
);

num_found := count(filtered_n);		
data_found := filtered_n;

output(num_found, NAMED('count'));
output(data_found, NAMED('data'));


ENDMACRO;