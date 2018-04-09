/*2005-07-22T18:04:25Z (Colin Maroney)
2005-07-22T10:36:39Z, Copied with AMT from Attribute Modified by sysadmin
*/
/*--SOAP--
<message name="Batch Indexed read">
  <part name="batch_in" type="tns:XmlDataSet" cols="70" rows="25"/>
</message>
*/
/*--INFO-- A batch-type search service / attribute. 
*/
/*--HELP-- Enter a batch of records and matching records will be returned.
*/
export ReadIndexDoxieBatch() := function
//indat := _RoxieStressTest.Setup.Datafile;
inrec := RECORD
  unsigned8 id;
	fcode := 0;
	Fmsg  := '';
	string10  lnamein;
	string10  fnamein;
	unsigned1 prangein;
	string10  streetin;
	unsigned1 zipsin;
	unsigned1 agein;
	string2   birth_statein;
	string3   birth_monthin;
	end;
infilerec := DATASET([],inrec) : STORED('batch_in',few);

dat := _Certification.DataFile;
i   := _Certification.IndexFile;

typeof(dat) xt(infilerec l, dat r) := TRANSFORM
  self.__filepos := r.__filepos;
  SELF := r;
END;

o := join(infilerec, dat, right.lname = StringLib.StringToUpperCase(left.lnamein) and
									(left.fnamein='' OR
                      right.fname = StringLib.StringToUpperCase(left.fnamein)) and
									(left.prangein=0 OR
                       right.prange = left.prangein) and
									(left.Streetin='' OR
                       right.Street = StringLib.StringToUpperCase(left.Streetin)) and
									(left.zipsin=0 OR
                     right.zips = left.zipsin) and
									(left.agein=0 OR
                    right.age = left.agein) and
									(left.birth_statein='' OR
                            right.birth_state = StringLib.StringToUpperCase(left.birth_statein)) and
									(left.birth_monthin='' OR
                            right.birth_month = StringLib.StringToUpperCase(left.birth_monthin)),
									xt(LEFT, RIGHT), keyed(i));

output(choosen(o,100),NAMED('Result'));
  return true;
end;//macro;