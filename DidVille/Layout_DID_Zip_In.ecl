export Layout_DID_Zip_In := record
/*	unsigned4 seq;
	qstring20 fname;
	qstring20 lname;
	unsigned3 zip;
	real inrad;
	real outrad;
	unsigned1	maxdidcnt;
*/
	qString20	FirstName {xpath('FirstName')} := '';
	qstring20	LastName {xpath('LastName')} := '';
	string5	Zip {xpath('Zip')} := '';
	string4	InnerRadius {xpath('InnerRadius')} := '5' ;
	string4	OuterRadius {xpath('OuterRadius')} := '50';
	unsigned1	MaxDidCount {xpath('MaxDidCount')} := 1;
	unsigned4	Seq {xpath('Seq')} := 1;
	boolean	AppendBests {xpath('AppendBests')} := true;
end;