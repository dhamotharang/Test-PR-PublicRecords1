import Bair, Bair_composite, Bair_ExternalLinkKeys,Bair_Layers;

EXPORT Keys := MODULE

	SHARED _version := 'qa';

	EXPORT GeoHash(boolean delta=false) := Bair.Key_GeoHash(_version,delta);
	EXPORT DataProviderKey := Bair.Key_Data_Provider(_version);
	EXPORT GroupAccessKey := Bair.Key_Group_Access(_version);
	EXPORT ImageKey(boolean delta=false) := Bair.Key_Images(_version,delta);
	EXPORT NotesKey(boolean delta=false) := Bair.Key_Notes(_version,delta);
	EXPORT ClassificationKey() := Bair.Key_Classification(_version);
	EXPORT LayerSearchKey() := Bair_Layers.Key_AgencyLayer_Search(_version,false);
	EXPORT LayerPayloadKey() := Bair_Layers.Key_AgencyLayer_Payload(_version,false);
		
	// Payload keys
	EXPORT PayloadMOKey(boolean delta=false) := Bair.Key_Payload_MO(_version,delta);
	EXPORT PayloadMOUDFKey(boolean delta=false) := Bair.Key_Payload_MO_UDF_V2(_version,delta);
	EXPORT PayloadVehicleKey(boolean delta=false) := Bair.Key_Payload_Vehicle(_version,delta);
	EXPORT PayloadPersonKey(boolean delta=false) := Bair.Key_Payload_Person(_version,delta);
	EXPORT PayloadPersonUDFKey(boolean delta=false) := Bair.Key_Payload_Person_UDF_V2(_version,delta);
	EXPORT PayloadCFSKey(boolean delta=false) := Bair.Key_Payload_CFS_v2(_version,delta);
	EXPORT PayloadCFSKey_Officer(boolean delta=false) := Bair.Key_Payload_CFS_Officer(_version,delta);
	EXPORT PayloadOffenderKey(boolean delta=false)  := Bair.Key_Payload_Offender(_version,delta);
	EXPORT PayloadIntelKey(boolean delta=false)  := Bair.Key_Payload_Intel_v2(_version,delta);
	EXPORT PayloadCrashKey(boolean delta=false)  := Bair.Key_Payload_Crash_V2(_version,delta);
	EXPORT PayloadCrashPersonKey(boolean delta=false)  := Bair.Key_Payload_Crash_Person(_version,delta);
	EXPORT PayloadCrashVehicleKey(boolean delta=false)  := Bair.Key_Payload_Crash_Vehicle(_version,delta);
	EXPORT PayloadLPRKey(boolean delta=false) :=  Bair.Key_Payload_LPR(_version,delta);
	EXPORT PayloadSSKey(boolean delta=false) := Bair.Key_Payload_Shotspotter(_version,delta);
	
	// composite keys
	EXPORT PayloadKey_MO_EID(boolean delta=false) := Bair_composite.Key_MO_EID(_version, delta);
	EXPORT PayloadKey_MO_PHONE(boolean delta=false) := Bair_composite.Key_MO_PHONE(_version,delta);
	
	// external link keys
	EXPORT PayloadKey_EID_hash(boolean delta=false) := Bair_ExternalLinkKeys.Key_eid_hash();

	EXPORT _test() := MACRO
		output(BairRx_Common.Keys.PayloadMOKey(), named('mo'));
		output(BairRx_Common.Keys.PayloadMOUDFKey(), named('mo_udf'));
		output(BairRx_Common.Keys.PayloadVehicleKey(), named('vehicle'));
		output(BairRx_Common.Keys.PayloadPersonKey(), named('person'));
		output(BairRx_Common.Keys.PayloadPersonUDFKey(), named('person_udf'));
		output(BairRx_Common.Keys.PayloadCFSKey(), named('cfs'));
		output(BairRx_Common.Keys.PayloadCFSKey_Officer(), named('cfs_officers'));
		output(BairRx_Common.Keys.PayloadOffenderKey(), named('Offenders'));
		output(BairRx_Common.Keys.PayloadIntelKey(), named('Intel'));
		output(BairRx_Common.Keys.PayloadCrashKey(), named('Crash'));
		output(BairRx_Common.Keys.PayloadCrashPersonKey(), named('PayloadCrashPersonKey'));
		output(BairRx_Common.Keys.PayloadCrashVehicleKey(), named('PayloadCrashVehicleKey'));
		output(BairRx_Common.Keys.PayloadLPRKey(), named('licenseplate'));
		output(BairRx_Common.Keys.PayloadSSKey(), named('Shotspotter'));
		output(BairRx_Common.Keys.GeoHash(), named('GeoHash'));
		output(BairRx_Common.Keys.GroupAccessKey, named('GroupAccess'));
		output(BairRx_Common.Keys.DataProviderKey, named('DataProvider'));
		output(BairRx_Common.Keys.NotesKey().IDX, named('NotesKey'));
		output(BairRx_Common.Keys.NotesKey().FILE, named('NotesFile'));
		output(BairRx_Common.Keys.ImageKey().IDX, named('ImageKey'));
		output(BairRx_Common.Keys.ImageKey().FILE, named('ImageFile'));
		output(BairRx_Common.Keys.ClassificationKey(), named('Classification'));
		output(BairRx_Common.Keys.PayloadKey_MO_EID(), named('Composite_MO_EID'));
		output(BairRx_Common.Keys.PayloadKey_MO_PHONE(), named('Composite_MO_PHONE'));
		output(BairRx_Common.Keys.PayloadKey_EID_hash(), named('ExternalLink_EID_hash'));
		output(BairRx_Common.Keys.LayerSearchKey(), named('LayerSearchKey'));
		output(BairRx_Common.Keys.LayerPayloadKey(), named('LayerPayloadKey'));
	ENDMACRO;
	
END;