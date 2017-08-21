import ut;

// This attribute doesnt have a ton of use anymore.  Could just as easily use a BWR to call mod_build.

export proc :=
MODULE

shared date := 
ut.GetDate;

#workunit('name','RAIN');

//i think this replaces all of the previous code from this attribute, but you cant currently run it all at once because the prop part needs 400 and the phone part needs prod 200
// export DoAll := FidelityProp.mod_build().DoAll(date);

// or for just the prop file
export DoProp := count(FidelityProp.mod_build().DoProp(date));

// just the phone part
export PropWPhones(dataset(FidelityProp.layouts.from_prop_fid_dob) prop) := FidelityProp.mod_build().DoPropWPhones(date, prop);

//the rest
export DoRest(
	dataset(FidelityProp.layouts.from_prop_fid) prop,
	dataset(FidelityProp.layouts.out) wphones) :=
sequential(
	FidelityProp.mod_build().DoCSVout(date, wphones),
	FidelityProp.mod_build().DoCounts(prop, wphones)
);


END;