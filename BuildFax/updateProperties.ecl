IMPORT Address, RoxieKeyBuild;
EXPORT updateProperties (STRING bFileName, STRING build_date) := FUNCTION
l_property_s			:= LayoutExports.property;
l_property	    	:= Layout.property;// Reusing original layout rather new ones
CleanAddress			:= Layout.CleanAddress;// Reusing original layout rather new ones
Sprayedproperty		:= DATASET(Constants(bFileName).spray_subfile,l_property_s,
														 CSV(SEPARATOR(Constants().FieldSeparator),TERMINATOR(Constants().RecordTerminator), Quote(Constants().QuoteBack), MAXLENGTH(Constants().MAX_RECORD_SIZE)));
l_property_s propertyConversion (l_property_s L) := TRANSFORM
	SELF.ID					:= StringLib.StringToUpperCase (L.ID);
	SELF.RADDRESS1	:= StringLib.StringToUpperCase (L.RADDRESS1);
	SELF.RADDRESS2	:= StringLib.StringToUpperCase (L.RADDRESS2);
	SELF.RCITY			:= StringLib.StringToUpperCase (L.RCITY);
	SELF.RSTATE			:= StringLib.StringToUpperCase (L.RSTATE);
	SELF.RZIP				:= StringLib.StringToUpperCase (L.RZIP);
	SELF.OADDRESS1	:= StringLib.StringToUpperCase (L.OADDRESS1);
	SELF.OADDRESS2	:= StringLib.StringToUpperCase (L.OADDRESS2);
	SELF.OCITY			:= StringLib.StringToUpperCase (L.OCITY);
	SELF.OSTATE			:= StringLib.StringToUpperCase (L.OSTATE);
	SELF.OZIP				:= StringLib.StringToUpperCase (L.OZIP);
	SELF.CorrectAddressDescription	:= StringLib.StringToUpperCase (L.CorrectAddressDescription);
	SELF.PIN				:= StringLib.StringToUpperCase (L.PIN);
	SELF.CensusTract:= StringLib.StringToUpperCase (L.CensusTract);
	SELF.FloodZone	:= StringLib.StringToUpperCase (L.FloodZone);
	SELF.Acreage		:= StringLib.StringToUpperCase (L.Acreage);
	SELF.Section		:= StringLib.StringToUpperCase (L.Section);
	SELF.Township		:= StringLib.StringToUpperCase (L.Township);
	SELF.Range			:= StringLib.StringToUpperCase (L.Range);
	SELF.Area				:= StringLib.StringToUpperCase (L.Area);
	SELF.Parcel			:= StringLib.StringToUpperCase (L.Parcel);
	SELF.Lot				:= StringLib.StringToUpperCase (L.Lot);
	SELF.Block			:= StringLib.StringToUpperCase (L.Block);
	SELF.Grid				:= StringLib.StringToUpperCase (L.Grid);
	SELF.PropertyMap:= StringLib.StringToUpperCase (L.PropertyMap);
	SELF.Volume			:= StringLib.StringToUpperCase (L.Volume);
	SELF.Page				:= StringLib.StringToUpperCase (L.Page);
	SELF.District		:= StringLib.StringToUpperCase (L.District);
	SELF.Subdivision:= StringLib.StringToUpperCase (L.Subdivision);
	SELF.Development:= StringLib.StringToUpperCase (L.Development);
	SELF.Elevation	:= StringLib.StringToUpperCase (L.Elevation);
	SELF.Zone				:= StringLib.StringToUpperCase (L.Zone);
	SELF.StreetExtract:= StringLib.StringToUpperCase (L.StreetExtract);
	SELF						:= L;
	SELF						:= [];
END;
convertedProperty	:= PROJECT (Sprayedproperty(ID <> 'ID'), propertyConversion(LEFT));
l_property mapAddress (l_property_s L) := TRANSFORM
		CZIP					:= StringLib.StringFindReplace (TRIM(L.RZIP, ALL), '-','');
		OZIP					:= StringLib.StringFindReplace (TRIM(L.OZIP, ALL), '-','');
		ADDRESS1			:= IF (L.RADDRESS1 <> '', L.RADDRESS1, L.OADDRESS1);
		ADDRESS2			:= IF (L.RADDRESS2 <> '', L.RADDRESS2, L.OADDRESS2);
		STFromID			:= L.ID[stringlib.stringfind(L.ID, '|', 1)+1..(stringlib.stringfind(L.ID, '|', 1)+ 2)];
		CITY					:= IF (L.RCITY <> '', L.RCITY, L.OCITY);
		ZIP5					:= IF (CZIP <> '', CZIP[1..5], OZIP[1..5]);
		STATE					:= MAP (L.RSTATE <> '' => L.RSTATE, 
		                      L.OSTATE <> '' => L.OSTATE,
													stringlib.StringToUpperCase(STFromID));// state can come from raw or original or from ID record
		SELF.CADDRESS1:= TRIM(ADDRESS1, LEFT, RIGHT);
		SELF.CADDRESS2:= TRIM(ADDRESS2, LEFT, RIGHT);
		SELF.CCITY		:= TRIM(CITY, LEFT, RIGHT);
		SELF.CZIP5		:= TRIM(ZIP5, LEFT, RIGHT);
		SELF.CSTATE		:= TRIM(STATE, LEFT, RIGHT);
		SELF					:= L;
		SELF					:= [];
END;
mappedAddress			:= PROJECT (convertedProperty, mapAddress(LEFT)):PERSIST('~thor::persist::buildfax::mappedAddress');
dedupAddress 			:= DEDUP(SORT (mappedAddress,CADDRESS1,CADDRESS2,CCITY,CSTATE,CZIP5), CADDRESS1,CADDRESS2,CCITY,CSTATE,CZIP5);
	
l_property addressStandard (l_property L) := TRANSFORM
		ADDRLINE1				:= L.CADDRESS1 + '' + L.CADDRESS2;
		ADDRLINE2				:= Address.Addr2FromComponents(L.CCITY, L.CSTATE, L.CZIP5); 
		clean 					:= Address.GetCleanAddress(ADDRLINE1, ADDRLINE2, address.Components.Country.US).results;
		SELF.prim_range := clean.prim_range;
		SELF.predir     := clean.predir;
		SELF.prim_name  := clean.prim_name;
		SELF.addr_suffix:= clean.suffix;
		SELF.postdir    := clean.postdir;
		SELF.unit_desig := clean.unit_desig;
		SELF.sec_range 	:= clean.sec_range;
		SELF.CITY			 	:= clean.v_city;
		SELF.ST				 	:= clean.state;
		SELF.ZIP			 	:= clean.zip;
		SELF.ZIP4			 	:= clean.zip4;
		SELF.ERROR_CODE	:= clean.error_msg;
		SELF						:= L;
END;
cleanAddresses			:= PROJECT (dedupAddress, addressStandard(LEFT)):PERSIST('~thor::persist::buildfax::addresscleaning');

l_property joinAddress (l_property L, l_property R) := TRANSFORM
		SELF.prim_range := R.prim_range;
		SELF.predir     := R.predir;
		SELF.prim_name  := R.prim_name;
		SELF.addr_suffix:= R.addr_suffix;
		SELF.postdir    := R.postdir;
		SELF.unit_desig := R.unit_desig;
		SELF.sec_range 	:= R.sec_range;
		SELF.CITY			 	:= R.city;
		SELF.ST				 	:= R.st;
		SELF.ZIP			 	:= R.zip;
		SELF.ZIP4			 	:= R.zip4;
		SELF.ERROR_CODE	:= R.ERROR_CODE;
		SELF						:= L;
END;
property		      := JOIN (mappedAddress,cleanAddresses,	LEFT.CADDRESS1 = RIGHT.CADDRESS1 AND
																													LEFT.CADDRESS2 = RIGHT.CADDRESS2 AND
																													LEFT.CCITY = RIGHT.CCITY AND
																													LEFT.CSTATE = RIGHT.CSTATE AND
																													LEFT.CZIP5 = RIGHT.CZIP5, joinAddress(LEFT, RIGHT));
RoxieKeyBuild.Mac_SF_BuildProcess_V2(property, FILES.BASE_PREFIX_NAME, bFileName, build_date, propertyBase, 3, false, true);//Skip header row

opropertyCnt				:= OUTPUT(COUNT(property));
TabStproperty				:= TABLE (property, {CSTATE, ERROR_CODE, INTEGER CTR := count(group)}, CSTATE, ERROR_CODE);
TabStOneByteErrProp	:= TABLE (property, {CSTATE, ERROR_CODE[1..1], INTEGER CTR := count(group)}, CSTATE, ERROR_CODE[1..1]);
TabErrorProp				:= TABLE (property, {ERROR_CODE, INTEGER CTR := count(group)}, ERROR_CODE);
oTabStproperty			:= OUTPUT(SORT(TabStproperty, -ctr), all);
oTabStOneByteErrProp:= OUTPUT(SORT(TabStOneByteErrProp, -ctr), all);
oTabErrorProp				:= OUTPUT(SORT(TabErrorProp, -ctr), all);

RETURN PARALLEL(opropertyCnt, oTabStproperty, oTabStOneByteErrProp, oTabErrorProp, propertyBase);
END;