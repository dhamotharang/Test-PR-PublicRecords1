/*--SOAP--
<message name="GetDistribution_Service">
	<part name="DurationDist" type="xsd:boolean"/>
	<part name="SrcByteDist" type="xsd:boolean"/>
	<part name="DestByteDist" type="xsd:boolean"/>
	<part name="DescendingSort" type="xsd:boolean"/>
	<part name="RecordLimit" type="xsd:int"/>
	<part name="SourceIp" type="xsd:string"/>
</message>
*/
/*--INFO-- 
	This service will return a variety of distributions. <BR/>
	The default sort order applied is ascending so the items that appear most often will be returned in the top of the list.<BR/>
	It's often useful to get the values that appear the least so the option to apply a descending sort is provided. <BR/>
	The default record limit is 100.
*/
//#WORKUNIT('cluster', 'thor_demo')
export MyTest_Service := MACRO
	BOOLEAN getDuration := FALSE : STORED('DurationDist');
	BOOLEAN getSrcByteDist := FALSE : STORED('SrcByteDist');
	BOOLEAN getDestByteDist := FALSE : STORED('DestByteDist');
	BOOLEAN descSort := FALSE : STORED('DescendingSort');
	INTEGER recLimit := 100 : STORED('RecordLimit');
	STRING country := 'MX' : STORED('SourceIp');
	
MyRec := {STRING1 Letter};
SomeFile := DATASET([{'A'},{'B'},{'C'},{'D'},{'E'}],MyRec);

//output(CHOOSEN(buzzsaw.Mod_Data.DS_Unique_Ips_Location(country_code = country),100));
//output(CHOOSEN(buzzsaw.Mod_Data.DS_U4(destport=recLimit),100));

output(SomeFile);

ENDMACRO;