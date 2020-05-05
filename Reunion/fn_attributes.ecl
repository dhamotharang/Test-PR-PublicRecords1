
EXPORT fn_attributes(unsigned1 mode, DATASET(RECORDOF(reunion.mapping_reunion_main().all)) dInMain) := FUNCTION

	reunion.layouts.lAttributes toAttributes(dInMain L) := TRANSFORM
		SELF.main_adl := INTFORMAT(L.did,12,1);
		SELF := L;
	END;

	attrSF_core := '~thor::base::mylife::core::append_attributes';
	coreAttributes := dataset(attrSF_core, reunion.layouts.lMainRaw, thor);

	AttributesFull := PROJECT(dInMain, transform(reunion.layouts.lAttributes, SELF.main_adl := INTFORMAT(LEFT.did,12,1); SELF := LEFT;));
	AttributesCore := PROJECT(coreAttributes, transform(reunion.layouts.lAttributes, SELF.main_adl := INTFORMAT(LEFT.did,12,1); SELF := LEFT;));

	return if(mode = 1, AttributesFull, AttributesCore);

END;