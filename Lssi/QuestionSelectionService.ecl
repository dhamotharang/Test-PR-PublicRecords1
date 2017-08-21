/*--SOAP--
<message name="QuestionSelectionService">
  <part name="lname4" type="xsd:string"/>
  <part name="fname3" type="xsd:string"/>
  <part name="city" type="xsd:string"/>
  <part name="state" type="xsd:string"/>
  <part name="threshold" type="xsd:unsignedInt"/>
  <part name="CustomCount" type="xsd:string">
        <html>
          <td width="25%"><font face="Verdana" size="2">CustomCount:</font></td>
          <td><font face="Verdana" size="2">
            <select name="CustomCount">
                        <Option value=""></Option>
                        <Option value="lssi">Lssi</Option>
                        <Option value="seisint">Seisint</Option>
                </select>                              
           </font></td>
        </html>
	</part>
 </message>
*/
/*--INFO--
*/
export QuestionSelectionService () :=
MACRO

#stored('DPPAPurpose',1);
#stored('GLBPurpose',1);

STRING4 _lname4 := '' : STORED('lname4');
STRING3 _fname3 := '' : STORED('fname3');
STRING25 _city := '' : STORED('city');
STRING2 _state := '' : STORED('state');
unsigned1 thresh_use := 90 : STORED('threshold');
STRING10 custom_count := '' : STORED('CustomCount');

QSTRING4 lname4_use := StringLib.StringToUpperCase(_lname4);
QSTRING3 fname3_use := StringLib.StringToUpperCase(_fname3);
QSTRING25 city_use := StringLib.StringToUpperCase(_city);
QSTRING2 state_use := StringLib.StringToUpperCase(_state);

i := lssi.Key_Determiner(keyed(city = city_use),
					keyed(st = state_use),
					keyed(lname4 = lname4_use),
					keyed(fname3[1..length(trim(fname3_use))] = fname3_use[1..length(trim(fname3_use))]),
					prob >= thresh_use);


j := JOIN(i, i, 	LEFT.fname3 = RIGHT.fname3 AND
			// of course city = city
				LEFT.city = RIGHT.city AND
			// RIGHT is a subset of LEFT
				LEFT.incCode|RIGHT.incCode = LEFT.incCode AND
			 // RIGHT is not = to LEFT
				LEFT.incCode != RIGHT.incCode, LEFT ONLY);

output(SORT(j, fname3, incCost), NAMED('results'));

output(case(custom_count,
		  'lssi'		=>	count(doxie.lssi_records),
		  'seisint'	=>	count(doxie.gong_records),
		  0), NAMED('CustomCount'))

ENDMACRO;