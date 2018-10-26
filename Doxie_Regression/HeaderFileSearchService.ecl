/*--SOAP--
<message name="headerFileSearchRequest">
  <part name="recid" type="xsd:unsignedInt"/>
  <part name="SSN" type="xsd:string"/>
	<part name="UnParsedFullName" type="xsd:string"/>
  <part name="FirstName" type="xsd:string"/>
  <part name="AllowNickNames" type="xsd:boolean"/>
  <part name="RelativeFirstName1" type="xsd:string"/>
  <part name="RelativeFirstName2" type="xsd:string"/>
  <part name="LastName" type="xsd:string"/>
  <part name="OtherLastName1" type="xsd:string"/>
  <part name="PhoneticMatch" type="xsd:boolean"/>
  <part name="MiddleName" type="xsd:string"/>
  <part name="Addr" type="xsd:string"/>
  <part name="City" type="xsd:string"/>
  <part name="OtherCity1" type="xsd:string"/>
  <part name="County" type="xsd:string"/>
  <part name="State" type="xsd:string"/>
  <part name="OtherState1" type="xsd:string"/>
  <part name="OtherState2" type="xsd:string"/>
  <part name="Zip" type="xsd:string"/>
  <part name="ZipRadius" type="xsd:unsignedInt"/>
  <part name="Phone" type="xsd:string"/>
  <part name="DOB" type="xsd:unsignedInt"/>
  <part name="AgeLow" type="xsd:byte"/>
  <part name="AgeHigh" type="xsd:byte"/>
  <part name="DID" type="xsd:string" required="1"/>
  <part name="Household" type="xsd:boolean"/> 
  <part name="RID" type="xsd:string"/>
  <part name="IncludeAllDIDRecords" type="xsd:boolean"/>
  <part name="MaxResults" type="xsd:unsignedInt"/>
  <part name="MaxResultsThisTime" type="xsd:unsignedInt"/>
  <part name="SkipRecords" type="xsd:unsignedInt"/>
  <part name="DPPAPurpose" type="xsd:byte"/>
  <part name="GLBPurpose" type="xsd:byte"/> 
	<part name="ApplicationType"     	type="xsd:string"/>
  <part name="NoLookupSearch" type="xsd:boolean"/>
  <part name="DoNotFillBlanks" type="xsd:boolean"/> 
  <part name="Raw" type="xsd:boolean"/> 
  <part name="DIDOnly" type="xsd:boolean"/>
 </message>
*/
/*--INFO-- This service searches the header file.*/
import doxie,ut,suppress;
export HeaderFileSearchService () := MACRO
#CONSTANT('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.LEGACY);
#option('workflow', 0);
unsigned4 StartTick := doxie_regression.TimeService.Ticks() : stored('StartTick');
doxie.MAC_Header_Field_Declare() //MaxResults_val, SkipRecords_val, MaxResultsThisTime_val, did_only
mod_access := doxie.compliance.GetGlobalDataAccessModule ();

unsigned4 rec_id := 0 : stored('recid');


boolean nolookupsearch := false : stored('NoLookupSearch');
off := sort(doxie.header_records(),penalt,if(tnt IN ['Y','P'],0,1),-dt_last_seen,lname,fname,mname,did,phone,rid);

'Header File Version = ' + header.version;
doxie.MAC_Marshall_Results(off,outf);

PrettyLayout := record
  outf.penalt;
  outf.did;
  outf.tnt;
  outf.glb;
  outf.dppa;
  unsigned4 first_seen := MAP ( outf.dt_first_seen > 0 and ( outf.dt_first_seen < outf.dt_vendor_first_reported or outf.dt_vendor_first_reported=0 )=> outf.dt_first_seen,
           outf.dt_vendor_first_reported > 0 => outf.dt_vendor_first_reported,
		   ~mod_access.isValidGLB () => outf.dt_nonglb_last_seen,
           outf.dt_vendor_last_reported > 0 and outf.dt_vendor_last_reported < outf.dt_last_seen => outf.dt_vendor_last_reported,
           outf.dt_last_seen );
  unsigned4 last_seen := MAP( ~mod_access.isValidGLB ()=>outf.dt_nonglb_last_seen,
                              outf.dt_last_seen<>0 => outf.dt_last_seen,
							  outf.dt_vendor_last_reported);
  outf.fname;
  outf.mname;
  outf.lname;
  string5    name_suffix := IF( outf.name_suffix[1]='U','',outf.name_suffix );
  outf.dob;
  unsigned1 age      := ut.Age(outf.dob);
  unsigned4 dod      := IF(outf.src in ['DE', 'DS'], (unsigned4)stringlib.stringfilter(outf.prim_name, '0123456789'), 0);
  unsigned1 dead_age := IF(outf.src in ['DE', 'DS'] and outf.prim_name<>'', ((unsigned4)stringlib.stringfilter(outf.prim_name, '0123456789') - outf.dob) div 10000, 0);
  outf.ssn;
  outf.valid_ssn;
  outf.prim_range;
  outf.predir;
  outf.prim_name;
  outf.suffix;
  outf.postdir;
  outf.unit_desig;
  outf.sec_range;
  outf.city_name;
  outf.st;
  outf.zip;
  outf.zip4;
  outf.county_name;
  outf.phone;
  outf.listed_phone;
  outf.listed_name;
  outf.output_seq_no;
  unsigned2 veh_cnt := 0;
  unsigned2 dl_cnt := 0;
  unsigned2 head_cnt := 0;
  unsigned2 crim_cnt := 0;
  unsigned2 sex_cnt := 0;
  unsigned2 ccw_cnt := 0;
  unsigned2 rel_count := 0;
  unsigned2 fire_count := 0;
  unsigned2 faa_count := 0;
  unsigned2 prof_count := 0;
  unsigned2 vess_count := 0;
  unsigned2 bus_count := 0;
  unsigned2 prop_count := 0;
  unsigned4 Start_Time := 0;
  unsigned4 Elapsed_Time := 0;
  unsigned4 recid := 0;
  end;

ta2 := table(outf,PrettyLayout);

ta2_dids := dedup(project(ta2, doxie.layout_references),all);
ta2_best := doxie.best_records(ta2_dids, modAccess := mod_access);

PrettyLayout add_value(ta2 le, ta2_best ri) := transform
  self.dob := if (le.dob=0,ri.dob,le.dob);
  self.age := if(le.age=0,ut.Age(ri.dob),le.age);
  self.ssn := if ((unsigned8)le.ssn=0,ri.ssn,le.ssn);
  self.valid_ssn := if ((unsigned8)le.ssn=0 and (unsigned8)ri.ssn<>0,'M',le.valid_ssn);
  self := le;
  end;

jnd := join(ta2,ta2_best,left.did=right.did,add_value(left,right),left outer);

ta3_pre := if( mod_access.no_scrub, ta2, jnd );// Below replaces this filter (ssn NOT IN doxie.pullSSN);
Suppress.MAC_Suppress(ta3_pre,ta3,mod_access.application_type,Suppress.Constants.LinkTypes.SSN,ssn);

PrettyLayout add_lookups(ta3 le, doxie.Key_Did_Lookups ri) := transform
  self := ri;
  self := le;
  end;

jnd2 := join(ta3,doxie.Key_Did_Lookups,left.did=right.did,add_lookups(left,right),left outer);

ta := sort(if ( nolookupsearch,ta3,jnd2 ),output_seq_no);

PrettyLayout rol_it(ta le,ta ri) := transform
  self.glb := le.glb and ri.glb;
  self.dppa := le.dppa and ri.dppa;
  self.valid_ssn := if ( le.valid_ssn='M',ri.valid_ssn,le.valid_ssn );
  self.first_seen := IF( le.first_seen >0 and le.first_seen < ri.first_seen, le.first_seen, ri.first_seen );
  self.last_seen := IF( le.last_seen > ri.last_seen, le.last_seen, ri.last_seen );
  self := le;
  end;
  
ta1 := rollup( ta, rol_it(left,right), record, except dppa, glb, first_seen, last_seen, valid_ssn, output_seq_no );  

justdid :=
RECORD
	doxie.header_records().did;
END;

PrettyLayout addDebug(ta le) :=
TRANSFORM
	self.Start_time := StartTick;
	self.Elapsed_Time := doxie_regression.TimeService.Ticks() - StartTick;
	SELF.recid := rec_id;
	SELF := le;
END;
debug_res := project(ta, addDebug(LEFT));

MAP( did_only => output(DEDUP(table(doxie.header_records(), justdid), did)),
     mod_access.no_scrub => output(outf),
	 output(debug_res, NAMED('Results')))

ENDMACRO;
// HeaderFileSearchService()