
/*--SOAP--
<message name="Validate_Keybuild_Service">
  <part name="CompanyName"    		type="xsd:string"/>
  <part name="City"        				type="xsd:string"/>
  <part name="State"       				type="xsd:string"/>
	<part name="JustOutputAHundredRecords"    type="xsd:boolean"/>
</message>
*/
/*--INFO-- This is a sample service for searching autokey payload keys. 
Valid input data: 
<ul>
<li>company name</li>
<li>city</li>
<li>state</li>
</ul>
*/

import doxie, AutoKeyI, AutoStandardI;

export Validate_Keybuild_Service() := function
	
	// 0. Retrieve all SOAP variables from global memory area.
	doxie.MAC_Header_Field_Declare()
	
	BOOLEAN just_output_some_recs := FALSE : STORED('JustOutputAHundredRecords');
	
	// 1.  Search the Autokeys.
	cons       := LaborActions_EBSA.Constants( filedate := '' );
	pl_autokey := LaborActions_EBSA.key_AutokeyPayload;

	tempmod := module(project(AutoStandardI.GlobalModule(),AutoKeyI.AutoKeyStandardFetchArgumentInterface,opt))
		export string autokey_keyname_root := cons.str_autokeyname;
		export string typestr              := cons.ak_typeStr;
		export set of string1 get_skip_set := cons.ak_skipSet;
		export boolean workHard            := TRUE;
		export boolean noFail              := TRUE;
		export boolean useAllLookups       := TRUE;
	end;

	ids := AutoKeyI.AutoKeyStandardFetch(tempmod).ids;

	// 2. Obtain the autokey payload.
	fids_deduped := dedup(sort(ids(isFake), id), id);
	
	outPL := 
		join(
			fids_deduped, 
			pl_autokey,
			keyed(left.id = right.FakeID), 
			TRANSFORM(RIGHT),
			limit(ut.limits.default, skip)
		);
	
	some_recs := IF( just_output_some_recs, CHOOSEN(pl_autokey, 100) );
	
	out_recs := outPL + some_recs;
	
	// 3. Output.	
	RETURN OUTPUT( out_recs, NAMED('Autokey_Payload'), ALL );

end;

/*
// Run in Builder Window:
#STORED('CompanyName','AGRIFOS FERTILIZER')
#STORED('City'       ,'')
#STORED('State'      ,'')
#STORED('JustOutputAHundredRecords',TRUE)

LaborActions_EBSA.Validate_Keybuild_Service()

*/