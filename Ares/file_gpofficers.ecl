import std;

Relationship_ds := Files.ds_relationship;

//find Accuity Location ID
recordof(Relationship_ds.details.employment.positions) xform(recordof(Relationship_ds.details.employment.positions) r ) := transform
	self:=r;
end;

//get the positions
positions :=  normalize(Relationship_ds,left.details.employment.positions,xform(right));

//get the office id from the href field under office
officers_office_id_layout := Record
	string officeId := '';
END;

officers_office_id_layout xform2(positions L) := TRANSFORM
//TODO what will happen if there is a null or more than one office?
	self.officeId := if(L.office[1].href != '', std.str.splitwords(L.office[1].href,'/')[3], '');
END;

officers_office_ids := project(positions, xform2(LEFT));

Accuity_Location_ID_layout:= RECORD
//TODO maybe add an attribute here that points to the relationshiop id????
	STRING Accuity_Location_ID;
END;

Accuity_Location_ID_layout office_location_xform (recordof(Ares.Files.ds_office) R) := TRANSFORM
	SELF.Accuity_Location_ID := R.tfpuid;
END;

Accuity_Location_IDs := join(officers_office_ids, Ares.Files.ds_office, right.tfpuid !='' AND LEFT.officeId = right.id, office_location_xform(right));

EXPORT file_gpofficers := Accuity_Location_IDs;

