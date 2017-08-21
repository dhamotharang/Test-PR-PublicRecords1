
/*							 '1'
							,0
							,'Entity'
							,'BAE74C62-6774-4a33-96C4-B622120264CA'
							,'WORLDCHECK PREMIUM PLUS'
							,'WorldCheck - Premium Plus Complete File'
							,'31'
							,'False'
							,''
*/
EXPORT hdr_layout := RECORD
	unicode		ids;
	integer		numrows;
	unicode	  Type;							// <Type>
	unicode		GUID;							// <ID>
	unicode	 	name;							// <Name>
	unicode		description;			// <Description>
	unicode		speciallistid;		// <SpecialListID>
	unicode		encryption;				// <Encrypt>
	unicode		publication;			// <Publication>2015-07-29T12:00:00.0000000Z
	dataset(Layout_Country) Countries;
	dataset(Layout_Subcategory) Subcategories;
	//{xpath('Publication')}, dataset(Layout_country_rollup1) SearchCriteria});
END;