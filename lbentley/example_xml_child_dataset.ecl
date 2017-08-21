export example_xml_child_dataset := 'todo';
//OUTPUT(fbnv2.File_TX_Dallas_Xml)


Layout_Business_Address := RECORD
 STRING StreetAddr    {XPATH('S1')};
 STRING City          {XPATH('CY')};
 STRING State         {XPATH('ST')};
 STRING Zip						{XPATH('ZP')};	
end;


Layout_Owner := RECORD
 STRING FirstLast  {XPATH('FL')};
 STRING StreetAddr {XPATH('S1')};
 STRING City       {XPATH('CY')};
 STRING State      {XPATH('ST')};
 STRING Zip				 {XPATH('ZP')};
end; 


Layout_Doc_Child := RECORD
 STRING Transaction_Date {XPATH('TD')};
 STRING LG2              {XPATH('LG2')};
 STRING PU               {XPATH('PU')};
 STRING DN               {XPATH('DN')}; 
 STRING TYP              {XPATH('TYP')}; 
 STRING FileDate         {XPATH('FD')}; 
 STRING FN               {XPATH('FN')}; 
 STRING LXD              {XPATH('LXD')}; 
 STRING FI               {XPATH('FI')}; 
 STRING CI               {XPATH('CI')};  
 DATASET(Layout_Business_Address) Bus_Addr {XPATH('BA')};  
 DATASET(Layout_Owner) Owner               {XPATH('OW')};             
 STRING NS               {XPATH('NS')};    
 STRING VI               {XPATH('VI')};
end;
  
Layout_Doc := RECORD
 STRING Doc {XPATH('@doc')};
 DATASET(Layout_Doc_Child) Doc_Details {XPATH('TD')};
 STRING Transaction_Date {XPATH('TD')};
end;

Layout_Doc_test := RECORD
 STRING Transaction_Date := Xmltext('TD');
end;

Layout_Doc2 := RECORD
 STRING line;
end;

Layout_Doc2 tPreProcess(Layout_Doc2 l) :=
transform

	self.line := '<doc>' + regexreplace(l.line + '</doc>';

end;

 
//a := DATASET('~thor_data400::in::fbnv2::20070809::sample',Layout_Doc,XML('doc/doc') );
a := DATASET('~thor_data400::in::fbnv2::20070809::sample',Layout_Doc2,csv(separator('')));

a2 := project(a, tPreProcess(left));

parsed	:= parse(a2, line, Layout_Doc_test, xml('DOC/doc'));

output(a);
output(a2);
output(parsed);


						 

                              

