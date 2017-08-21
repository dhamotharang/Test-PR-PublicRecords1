
{unsigned8 Ent_ID, Layout_XG.layout_addresses} 
	xForm(Layouts.rAddress infile) := TRANSFORM
	self.Ent_ID := infile.Ent_id;
	self.type := 'Unknown';
	self.street_1 := infile.Address;
	self.city := infile.City;
	self.state := infile.StateProvince;	//ExpandRegion(infile.country, infile.stateprovince);
	self.postal_code := infile.PostalCode;
	self.country := infile.Country;
	self.comments := infile.NameSource + IF(infile.Remarks='','',' || ' + infile.Remarks);
	self := [];
END;	

EXPORT GetAddresses(dataset(Layouts.rAddress) addrin) := FUNCTION

	return PROJECT(sort(DISTRIBUTE(addrin,Ent_ID),Ent_Id,Address_ID,local), xform(LEFT));

END;