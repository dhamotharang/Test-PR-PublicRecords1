/*--SOAP--
<message name="Indexed read">
  <part name="lnamein" type="xsd:string" required="1"/>
  <part name="fnamein" type="xsd:string"/>
  <part name="prangein" type="xsd:short"/>
  <part name="streetin" type="xsd:string"/>
  <part name="zipsin" type="xsd:short"/>
  <part name="agein" type="xsd:short"/>
  <part name="birth_statein" type="xsd:string"/>
  <part name="birth_monthin" type="xsd:string"/>
</message>
*/
/*--INFO-- A search service / attribute. 
*/
/*--HELP-- Enter a last name and the first 100 records with that 
value will be returned via the ECL attribute.
*/

export ReadIndexDoxie() := macro

string10  lnamein_value       := '' : stored('lnamein');
string10  fnamein_value       := '' : stored('fnamein');
unsigned1 prangein_value      := 0 : stored('prangein');
string10  streetin_value      := '' : stored('streetin');
unsigned1 zipsin_value        := 0 : stored('zipsin');
unsigned1 agein_value         := 0 : stored('agein');
string2   birth_statein_value := '' : stored('birth_statein');
string3   birth_monthin_value := '' : stored('birth_monthin');

dat := _Certification.DataFile;
i   := _Certification.IndexFile;

typeof(dat) xt(dat l, i r) := TRANSFORM
  self.__filepos := r.__filepos;
  SELF := l;
END;

Lname_Filter := KEYED(i.lname = StringLib.StringToUpperCase(lnamein_value));
Fname_Filter := KEYED(fnamein_value='' OR
                      i.fname = StringLib.StringToUpperCase(fnamein_value));
prange_Filter := KEYED(prangein_value=0 OR
                       i.prange = prangein_value);
Street_Filter := KEYED(Streetin_value='' OR
                       i.Street = StringLib.StringToUpperCase(Streetin_value));
zips_Filter := KEYED(zipsin_value=0 OR
                     i.zips = zipsin_value);
age_Filter := KEYED(agein_value=0 OR
                    i.age = agein_value);
birth_state_Filter := KEYED(birth_statein_value='' OR
                            i.birth_state = StringLib.StringToUpperCase(birth_statein_value));
birth_month_Filter := KEYED(birth_monthin_value='' OR
                            i.birth_month = StringLib.StringToUpperCase(birth_monthin_value));

IDX_Filter := Lname_Filter AND 
              Fname_Filter AND
							prange_Filter AND
							Street_Filter AND
							zips_Filter AND
							age_Filter AND
							birth_state_Filter AND
							birth_month_Filter;

o := fetch(dat, i(IDX_filter), RIGHT.__filepos, xt(LEFT, RIGHT));

output(choosen(o,100))

endmacro;