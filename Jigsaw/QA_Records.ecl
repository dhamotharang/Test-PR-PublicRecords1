export QA_Records :=
function

	//get new records for QA
	ds := Jigsaw.Files().base.qa;

ds1 := dataset('~thor_data400::base::jigsaw::father::data',Jigsaw.Layouts.base,flat);

dist := distribute(ds,HASH(rawfields.contactid));

dist1 := distribute(ds1,HASH(rawfields.contactid));

Jigsaw.Layouts.base tr(dist l,dist1 re) := transform
self := l;
end;

j1 := join(dist,dist1,LEFT.rawfields.contactid=RIGHT.rawfields.contactid,tr(LEFT,RIGHT)	,LEFT ONLY ,local);



	return output(choosen(j1(did <> 0 and bdid <> 0),500), named('SampleJigsawNewRecordsForQA'));

end;
