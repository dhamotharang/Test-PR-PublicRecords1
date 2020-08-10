IMPORT $, MDR, Phones, doxie;

// Equifax data
EXPORT GetEquifaxPhones(DATASET($.Layouts.BatchInAppendDID) dIn,
												$.iParam.SearchParams               inMod) :=
FUNCTION
	dEquifaxPhones := IF(inMod.UseEquifax, Phones.Raw.EquifaxPhones.ByPhone(dIn, homephone, FALSE));

	$.Layouts.PhoneFinder.Common tFormat2Common(RECORDOF(dEquifaxPhones) pInput) :=
	TRANSFORM
		SELF.phone_source  := $.Constants.PhoneSource.EquifaxPhones;
    SELF.src           := MDR.sourceTools.src_Equifax;
    SELF.phone         := pInput.equifax_phone.phone;
    SELF.dt_first_seen := (STRING)pInput.equifax_phone.dt_first_seen;
    SELF.dt_last_seen  := (STRING)pInput.equifax_phone.dt_last_seen;
    SELF.dob           := (INTEGER)pInput.dob;
    SELF.zip           := (STRING)pInput.equifax_phone.zipcode;
    SELF.did           := pInput.equifax_phone.did;
    SELF.ssn           := (STRING)pInput.equifax_phone.ssn;
    SELF.city_name     := (STRING)pInput.equifax_phone.city;
    SELF.st            := (STRING)pInput.equifax_phone.state;
    SELF.fname         := (STRING)pInput.equifax_phone.fname;
    SELF.lname         := (STRING)pInput.equifax_phone.lname;
    SELF.mname         := (STRING)pInput.equifax_phone.mname;
    SELF.batch_in      := pInput;
		SELF               := pInput;
		SELF               := [];
	END;

	dEquifaxFormat2Common := PROJECT(dEquifaxPhones, tFormat2Common(LEFT));

	// Debug
	#IF($.Constants.Debug.EquifaxPhones)
		IF(inMod.UseEquifax, OUTPUT(dIn, NAMED('dEquifaxPhones_In'), EXTEND));
		IF(inMod.UseEquifax, OUTPUT(dEquifaxPhones, NAMED('dEquifaxPhones'), EXTEND));
		IF(inMod.UseEquifax, OUTPUT(dEquifaxFormat2Common, NAMED('dEquifaxFormat2Common'), EXTEND));
	#END

	RETURN dEquifaxFormat2Common;
END;