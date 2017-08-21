/*--SOAP--
<message name="Service_Ip_Location">
	<part name="_CountryCode" type="xsd:string"/>
	<part name="_CountryName" type="xsd:string"/>
	<part name="_Region" type="xsd:string"/>
	<part name="_City" type="xsd:string"/>
	<part name="_IspName" type="xsd:string"/>
	<part name="_DomainName" type="xsd:string"/>
	<part name="RecordLimit" type="xsd:int"/>
</message>
*/
/*--INFO-- 
	Search for IP traffic via the joined IP Location data
*/

export Service_Ip_Location := MACRO
	STRING country_code := '' : STORED('_CountryCode');
	STRING country_name := '' : STORED('_CountryName');
	STRING region       := '' : STORED('_Region');
	STRING city         := '' : STORED('_City');
	STRING isp_name     := '' : STORED('_IspName');
	STRING domain_name  := '' : STORED('_DomainName');
	INTEGER recLimit    := 100 : STORED('RecordLimit');

	STRING ip := '';
	
	ds := buzzsaw.Module_Ip_Location.find(ip,country_code,country_name,region,city,isp_name,domain_name);

	output(CHOOSEN(ds,recLimit));
	
ENDMACRO;