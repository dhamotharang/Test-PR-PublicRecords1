#stored('did_add_force', 'thor');
#option('multiplePersistInstances',FALSE);

version := '201703';

ds1 := DEDUP(SORT(DISTRIBUTE(Spokeo.File_Spokeo_In, hash32(SpokeoID)),
					SpokeoID, name, addr1, city, state, zipcode, dob, phone, local),
					SpokeoID, name, addr1, city, state, zipcode, dob, phone, local);

ds := PROJECT(ds1, TRANSFORM(Spokeo.Layout_Out, self := left; self := []));;

result := Spokeo.ProcessFile(ds);

out := Spokeo.ToSpokeoOut(result);

writeitout := OUTPUT(out,,'~thor::spokeo::out::' + version, CSV(
																SEPARATOR('|')
																, TERMINATOR('\r\n')
																, HEADING(1,SINGLE)
																,QUOTE('"')
																),
													OVERWRITE);


SEQUENTIAL(
	OUTPUT(result,,'~thor::spokeo::processed::' + workunit, COMPRESSED, OVERWRITE),
	writeitout
	// despray
);
