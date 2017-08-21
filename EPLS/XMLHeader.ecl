

hdg1 := '<?xml version="1.0" ?>\r\n';
hdg2 := '<!DOCTYPE Records SYSTEM "http://www.epls.gov/EPLS.dtd">\r\n';
hdg3 := '<Records>\r\n';

HeaderXml := hdg1 + hdg3;
FooterXml := '</Records>';



EXPORT XMLHeader(dataset(Layout_EPLS) ds) := 
	OUTPUT(ds,,'~thor::out::epls::results',
			xml('Record', heading(HeaderXml,FooterXml),trim, OPT), overwrite);
