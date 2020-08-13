/*--SOAP--
<message name="HriSicCodetoAddressRequest" fast_display = "true">
  <part name="SicCodes" type="tns:EspStringArray"/>
  <part name="LatLong" type="tns:XmlDataSet" cols="70" rows="25"/>
  <part name="Radius" type="xsd:unsignedInt"/>
  <part name="Zip" type="xsd:string"/>
  <part name="MaxAddresses" type="xsd:unsignedInt"/>
  <part name="MaxPeoplePerAddress" type="xsd:unsignedInt"/>
  <part name="MaxBusinessesPerAddress" type="xsd:unsignedInt"/>
  <part name="DataRestrictionMask" type="xsd:string"/>
  <part name="IncludeNonHriSicCodes" type="xsd:boolean"/>
</message>
*/
/*--INFO-- This service searches address, given a sic_code and zip radius .*/

/*
<message name="HriSicCodetoAddressService" wuTimeout="300000">
*/
 


export hri_siccode_to_address_service := macro
import risk_indicators, watchdog, AutoStandardI, doxie;

unsigned1 max_adder := 10 : STORED('MaxAddresses');
unsigned1 max_people_per := 10 : STORED('MaxPeoplePerAddress');
unsigned1 max_bus_per := 10 : STORED('MaxBusinessesPerAddress');

fetched := TOPN(risk_indicators.address_records,max_adder,distance);

out_rec := record
     unsigned4 seq;
	string4 sic_code;
	string10  prim_range;
     string2   predir;
     string28  prim_name;
     string4   suffix;
     string2   postdir;
     string5   unit_desig;
     string8   sec_range;
     string25  city;
     string2   state;                                       
     string5   zip;
     string4   zip4;	
     real      distance;
	string12  bdid;
	string sic_description;
end;

out_rec get_addr(fetched le, integer c) := transform
	self.seq := c;
	SELF.sic_description := if(risk_indicators.leSic4Desc(le.sic_code)<>'',
	                           risk_indicators.leSic4Desc(le.sic_code),   
	                           risk_indicators.leSic2Desc(le.sic_code[1..2]));
	SELF.zip := le.z5;
	SELF.zip4 := le.z4;
	self := le;
end;

final_recs := project(fetched,get_addr(left, counter));

doxie.layout_addressSearch slim(out_rec le) :=
TRANSFORM
	SELF := le;
END;
get_recs := PROJECT(final_recs, slim(LEFT));

// get did's
dids := doxie.did_from_address(get_recs, false);
gm := AutoStandardI.GlobalModule();
mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated(gm);
doxie.mac_best_records(dids, did, best_recs, true, mod_access.isValidGLB(), , mod_access.DataRestrictionMask);	

layout_people :=
RECORD
	unsigned seq;
	watchdog.Layout_Best;
END;

layout_people get_best_w_seq(dids l, best_recs r) := TRANSFORM
	SELF.seq := l.seq;
	SELF := r;
END;

get_best := join(dids, best_recs,
								 LEFT.did = right.did and 
								 LEFT.prim_name=RIGHT.prim_name AND
								 LEFT.prim_range=RIGHT.prim_range AND
								 LEFT.zip=RIGHT.zip, 
								 get_best_w_seq(left, right));

ddp_best := DEDUP(DEDUP(SORT(get_best,seq,did),seq,did),seq,KEEP(max_people_per));

// get bdid's
bhbf := Business_Header.Key_BH_Best;

layout_buesiness :=
RECORD
	unsigned seq;
	Business_Header.Layout_BH_Best;
END;

layout_buesiness getbus(final_recs le, bhbf ri) := TRANSFORM,
	SKIP(le.prim_name<>ri.prim_name OR le.prim_range<>ri.prim_range OR
		(INTEGER)le.zip<>ri.zip)
	SELF := ri;
	SELF := le;
END;
get_bbest := JOIN(final_recs, bhbf,
				keyed((unsigned6)LEFT.bdid = RIGHT.bdid) AND 
				doxie.compliance.isBusHeaderSourceAllowed(right.source, mod_access.DataPermissionMask, mod_access.DataRestrictionMask),
				getbus(LEFT, RIGHT),
				keep (1), limit (0));


ddp_bbest := DEDUP(DEDUP(SORT(get_bbest,seq,bdid),seq,bdid),seq,KEEP(max_bus_per));

final_layout :=
RECORD,MAXLENGTH(100000)
	unsigned seq;
	DATASET(out_rec) Risk_Address;
	// final_recs;      //above feature has been rolled back, keep for later use
	DATASET(layout_buesiness) Businesses;
	DATASET(layout_people) People;
END;

final_layout xpand(final_recs le) :=
TRANSFORM
	SELF.seq := le.seq;
	SELF.Risk_Address := le;
	SELF.Businesses := [];
	SELF.People := [];
	// self := le;
END;
p_main := PROJECT(final_recs, xpand(LEFT));

final_layout addBus(final_layout le, ddp_bbest ri ) :=
TRANSFORM
	SELF.seq := le.seq;
	SELF.Risk_Address := le.Risk_Address;
	SELF.Businesses := le.Businesses+ri;
	SELF.People := [];
	// self := le;
END;
dn1 := DENORMALIZE(p_main, ddp_bbest, LEFT.seq=RIGHT.seq, addBus(LEFT,RIGHT));

final_layout addPeep(final_layout le, ddp_best ri ) :=
TRANSFORM
	SELF.seq := le.seq;
	SELF.Risk_Address := le.Risk_Address;
	SELF.Businesses := le.Businesses;
	SELF.People := le.People+ri;
	// self := le;
END;
dn2 := DENORMALIZE(dn1, ddp_best, LEFT.seq=RIGHT.seq, addPeep(LEFT,RIGHT));

output(SORT(dn2,seq),NAMED('Results'))

endmacro;
