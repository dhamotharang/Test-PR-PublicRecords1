/*--SOAP--
<message name="Service_Ip_Search2">
	<part name="CountryCode" type="xsd:string"/>
	<part name="Region" type="xsd:string"/>
	<part name="City" type="xsd:string"/>
	<part name="IspName" type="xsd:string"/>
	<part name="RecordLimit" type="xsd:int"/>
</message>
*/
/*--INFO-- 
	This service will return a variety of distributions. <BR/>
	The default sort order applied is ascending so the items that appear most often will be returned in the top of the list.<BR/>
	It's often useful to get the values that appear the least so the option to apply a descending sort is provided. <BR/>
	The default record limit is 100.
*/
export Service_Ip_Search2 := MACRO
	STRING _country_code  := '' : STORED('CountryCode');
	STRING _region := '' : STORED('Region');
	STRING _city  := '' : STORED('City');
	STRING _isp_name := '' : STORED('IspName');
	INTEGER recLimit := 100 : STORED('RecordLimit');
	



FN_UIPL          := '~g2::firewall_all_unique_ips_with_location_info';
FN_UIPL_ID       := '~g2::uipl';
FN_UIPL_ID_Idx   := '~g2::uipl::key:id';
FN_UIPL_1347     := '~g2::uipl::1347';
FN_UIPL_1347_Idx := '~g2::uipl::key::1347';

L_UIPL := RECORD
	STRING ip;
	STRING country_code;
	STRING country_name;
	STRING region;
	STRING city;
	STRING latitude;
	STRING longitude;
	STRING isp_name;
	STRING domain_name;
END;

L_UIPL_ID := RECORD
	UNSIGNED4 id;
	STRING ip;
	STRING country_code; //1
	STRING country_name; //2
	STRING region; //3
	STRING city; //4
	STRING latitude; //5
	STRING longitude; //6
	STRING isp_name; //7
	STRING domain_name; //8
END;

L_Hash := RECORD
	INTEGER8 v;
	UNSIGNED4 id;
END;

IDX_UIPL_id := INDEX(
	DATASET(FN_UIPL_ID, { L_UIPL_ID, UNSIGNED8 RecPtr {virtual(fileposition)}},THOR),
	{
		id
	},
	{
		country_code,
		country_name,
		region,
		city,
		latitude,
		longitude,
		isp_name,
		domain_name,
		RecPtr
	},
	FN_UIPL_ID_Idx
);

IDX_UIPL_1347 := INDEX(
	DATASET(FN_UIPL_1347, { L_Hash, UNSIGNED8 RecPtr {virtual(fileposition)}},THOR),
	{v},
	{id,RecPtr},
	FN_UIPL_1347_Idx
);

L_UIPL_ID idit(L_UIPL l, INTEGER c) := TRANSFORM
	SELF.id := c;
	SELF := l;
END;

ds_uipl := DATASET(FN_UIPL,L_UIPL,THOR);
ds_uipl_id := DATASET(FN_UIPL_ID,L_UIPL_ID,THOR);

L_Hash hashit(L_UIPL_ID l) := TRANSFORM
	SELF.v := HASH64(l.country_code,l.region,l.city,l.isp_name);
	SELF.id := l.id;
END;

IDX_UIPL_id join_original_data(IDX_UIPL_1347 l, IDX_UIPL_id r) := TRANSFORM
	SELF := r;
END;

INTEGER8 hashed_value := HASH64(_country_code,_region,_city,_isp_name);
ds_results := JOIN(
	CHOOSEN(IDX_UIPL_1347(v = hashed_value),recLimit),
	IDX_UIPL_id,
	LEFT.id = RIGHT.id,
	join_original_data(LEFT,RIGHT)
);

output(CHOOSEN(ds_results,recLimit));



ENDMACRO;
