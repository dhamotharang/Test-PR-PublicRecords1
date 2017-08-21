

//**** THREE CHOICES *****

// choo := 50;      
// choo := 100;      
choo := 2000;      
// choo := 10000;      


 
// str_service := 'UPS_Services.RightAddressService.0'; //this is the old .2 plus removal of the bsearch shortcircuit
// str_service := 'UPS_Services.RightAddressService.1'; //this is the old .2 





ds := roxielogs.File_LogsTrim.records;
r0 := ds(stringlib.stringtouppercase(queryname) = 'UPS_SERVICES.RIGHTADDRESSSERVICE');

e := r0: persist('cemtemp::Deleteme2');
er := e(
receivetime > '2010-09', 
stringlib.stringfind(querytext, 'alskfjasdlf', 1) = 0
);


SearchRequest := iesp.rightaddress.t_RightAddressSearchRequest;

e1 := 
enth(
	er,
	choo
);
strchoo := (string)choo;





#workunit('name',strchoo)

roxielogs.mac_XML_Parser(e1, ds1, First, Querytext)
roxielogs.mac_XML_Parser(ds1, ds2, Middle, Querytext)
roxielogs.mac_XML_Parser(ds2, ds3, LastNameOrCompany, Querytext)
roxielogs.mac_XML_Parser(ds3, ds4, PowerSearch, Querytext)
roxielogs.mac_XML_Parser(ds4, ds5, StreetAddress1, Querytext)
roxielogs.mac_XML_Parser(ds5, ds6, StreetAddress2, Querytext)
roxielogs.mac_XML_Parser(ds6, ds7, State, Querytext)
roxielogs.mac_XML_Parser(ds7, ds8, City, Querytext)
roxielogs.mac_XML_Parser(ds8, ds9, Zip5, Querytext)
roxielogs.mac_XML_Parser(ds9, ds10, Zip4, Querytext)
roxielogs.mac_XML_Parser(ds10, ds11, County, Querytext)
roxielogs.mac_XML_Parser(ds11, ds12, PostalCode, Querytext)
roxielogs.mac_XML_Parser(ds12, ds13, StateCityZip, Querytext)
roxielogs.mac_XML_Parser(ds13, ds14, Phone10, Querytext)
// requests := project(parse_e, transform(SearchRequest, self := left, self := []));
dsp := 
project(
	ds14, 
	transform(
		ups_testing.layout_TestCase,
		self.fname := left.first,
		self.mname := left.middle,
		self.lname := left.lastnameorcompany,
		self.cname := left.lastnameorcompany,
		self.addr := left.streetaddress1,
		self.zip := left.zip5,
		self.phone := left.phone10,
		self := left
	)
);



requests := UPS_Testing.fn_BuildTestCases(dsp);

sequential(

output(UPS_Testing.fn_TestSuite(requests, '.0', 'a'))
,output(UPS_Testing.fn_TestSuite(requests, '.1', 'a'))

,output(UPS_Testing.fn_TestSuite(requests, '.0', 'b'))
,output(UPS_Testing.fn_TestSuite(requests, '.1', 'b'))

,output(UPS_Testing.fn_TestSuite(requests, '.1', 'c'))
,output(UPS_Testing.fn_TestSuite(requests, '.0', 'c'))

,output(UPS_Testing.fn_TestSuite(requests, '.1', 'd'))
,output(UPS_Testing.fn_TestSuite(requests, '.0', 'd'))
)