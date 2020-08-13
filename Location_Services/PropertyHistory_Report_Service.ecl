/*--SOAP--
<message name="PropertyHistory_Report_Service">
	<part name="apn"  type="xsd:string"/>
	<part name="StreetAddress" type="xsd:string"/>
	<part name="City"  type="xsd:string"/>
	<part name="State"  type="xsd:string"/>
	<part name="Zip"  type="xsd:string"/>
	<part name="FIPSCounty" type="xsd:string"/>
	<part name="DPPAPurpose" type="xsd:byte"/>
	<part name="GLBPurpose" type="xsd:byte"/> 
	<part name="ApplicationType"     	type="xsd:string"/>
	<part name="LnBranded" type="xsd:boolean"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="IncludeAVM" type="xsd:boolean"/>
 </message>
*/
/*--INFO-- Search propery data, and produces a report of the most recent 5 owners*/

IMPORT Address,AutoStandardI,LN_PropertyV2,_Control,demo_data,doxie;

export PropertyHistory_Report_Service := MACRO

	STRING45	apn 			:= '' 	: STORED('apn');
	STRING120 streetLine 	:= '' 	: STORED('StreetAddress');
	STRING25	city			:= ''	: STORED('City');
	STRING2	st			:= ''	: STORED('State');
	STRING5	zip5			:= AutoStandardI.GlobalModule().zip;
	STRING5	fips			:= ''	: STORED('FIPSCounty');
	UNSIGNED1 dppaFlag 		:= 0 	: STORED('DPPAPurpose');
	UNSIGNED1 glbaFlag 		:= 8 	: STORED('GLBPurpose');
	BOOLEAN 	LNBranded  	:= FALSE	: STORED('LnBranded');
	BOOLEAN	doAVM		:= FALSE	: STORED('IncludeAVM');
	BOOLEAN	includeAssignmentsAndReleases		:= FALSE	: STORED('includeAssignmentsAndReleases');
	appType := AutoStandardI.InterfaceTranslator.application_type_val.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.application_type_val.params));

	in0 := DATASET([{1}], {INTEGER seq});
 	
	Location_Services.Layout_PropHistory_In copyArgs(in0 l) := TRANSFORM
		STRING cityLine 	:= Address.Addr2FromComponents(city, st, zip5);
		STRING182 fline 	:= Address.CleanAddress182(streetLine,cityLine);
		SELF.seq 			:= l.seq;
		// SELF.in_fares_unformatted_apn := STRINGLIB.StringToUpperCase(apn);
		SELF.in_fares_unformatted_apn := LN_PropertyV2.fn_strip_pnum(apn);
		SELF.in_streetAddress := STRINGLIB.StringToUpperCase(streetLine);
		// prefer input values, but fill in where blank
		SELF.in_city 		:= if (city = '', fline[65..89], STRINGLIB.StringToUpperCase(city));
		SELF.in_state 		:= if (st = '', fline[115..116], STRINGLIB.StringToUpperCase(St));
		SELF.in_zipCode 	:= IF(_Control.ThisEnvironment.RoxieEnv = _Control.RoxieEnv.Demo, 
								if (zip5 = '' and trim(fline[65..89]) IN demo_data.q_constants.city_names,
																		demo_data.q_constants.zip, zip5),
								if (zip5 = '', fline[117..121], zip5));
		SELF.in_fips 		:= fips;
		SELF.prim_range 	:= fline[1..10];
		SELF.predir 		:= fline[11..12];
		SELF.prim_name 	:= fline[13..40];
		SELF.addr_suffix 	:= fline[41..44];
		SELF.postdir 		:= fline[45..46];
		SELF.unit_desig 	:= fline[47..56];
		SELF.sec_range 	:= fline[57..64];
	END;
	
	inData := PROJECT(in0, copyArgs(LEFT));
	
	nosec := inData(sec_range = '');
	wsec := indata(sec_range != '');
	
	
	inData  secChecker(noSec L, recordof(LN_PropertyV2.key_addr_fid()) R) := transform
		self := R;
		self := L;
	end;
	testsec :=limit( 
						dedup(sort(join(nosec, LN_PropertyV2.key_addr_fid(),
						keyed(left.prim_Range = right.prim_range) and
						keyed(left.prim_name = right.prim_name) and
						keyed(left.in_zipcode = right.zip) and
						keyed(left.predir = right.predir) and
						wild(right.postdir) and
						keyed(left.addr_suffix = right.suffix) and
						wild(right.sec_range) and
						keyed(right.source_code_2 = 'P'), //P = Property address, O = Owner address, C = careof address, S = seller address
            // actual counts can be as high as hundreds of thousands: appartments, condos, business, etc.,
            // but for the purpose of input verification this is irrelevant
						secChecker(LEFT,RIGHT),limit (2000, skip), left outer),
						prim_range,prim_name,in_zipcode,sec_range),
						prim_range,prim_name,in_zipcode,(left.sec_range=right.sec_range or left.sec_range='')),1,skip);

// may index read be more efficient?	
// testsec := LN_PropertyV2.key_addr_fid (keyed (prim_name), keyed (prim_range), keyed (zip), keyed (predir), 
//   wild (postdir), keyed (suffix), keyed (sec_range!=''), keyed (source_code_2 = 'P'));
						
	inD := wsec + testsec;
	
	if (count(inD) = 0, fail(310, doxie.ErrorCodes(310)));
	
	res := Location_Services.Property_History_Function(inD, dppaFlag, glbaFlag, appType, LNBranded, doAVM, includeAssignmentsAndReleases);

	// payroy := RECORD
// string5 Royalty_Type;
// unsigned royalty_count;
// unsigned non_royalty_count;
// END;

// royalties :=dataset([{'Fares',count(res(do_royal=1)),count(res(do_royal=0))
	// }],payroy);  
	
	OUTPUT(res, NAMED('Results'));
	// OUTPUT(royalties,Named('RoyaltySet'));
	
ENDMACRO;
// PropertyHistory_Report_Service()