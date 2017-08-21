// Added date logic in the first_seen, last_Seen & nonglb date fields below. This is for bug# 23340

import header,Prof_License;

export	proflic_as_header(dataset(Prof_License.layout_prolic_out_with_AID) pProfLic = dataset([],Prof_License.layout_prolic_out_with_AID), boolean pForHeaderBuild=false,boolean pForFCRAHeaderBuild=false)
 :=
  function
	dProfLicAsSource	:=	if(pForHeaderBuild,header.Files_SeqdSrc().PL,Prof_License.ProfLic_as_Source(pProfLic,pForHeaderBuild,pForFCRAHeaderBuild));

	header.Layout_New_Records into(dProfLicAsSource L) := transform
		self.did := if(pForFCRAHeaderBuild, (unsigned6)L.DID, 0);
		self.rid := if(pForFCRAHeaderBuild, L.UID, 0);
		self.vendor_id := L.license_number[1..18];
		self.dt_first_seen := if((integer)l.date_first_seen=0,0,(unsigned3)(l.date_first_seen[1..6]));
		self.dt_last_seen := if((integer)l.date_last_seen=0,0,(unsigned3)(l.date_last_seen[1..6]));
		self.dt_vendor_first_reported := if((integer)l.date_first_seen=0,0,(unsigned3)(l.date_first_seen[1..6]));
		self.dt_vendor_last_reported := if((integer)l.date_last_seen=0,0,(unsigned3)(l.date_last_seen[1..6]));
		self.dt_nonglb_last_seen := if((integer)l.date_last_seen=0,0,(unsigned3)(l.date_last_seen[1..6]));
		self.rec_type := '2';
		self.pflag1 := '';
		self.pflag2 := '';
		self.pflag3 := If(l.vendor='INFUTOR','I','');
		self.jflag1 := '';
		self.jflag2 := '';
		self.jflag3 := '';
		self.ssn := '';
		self.dob := (integer)L.dob;
		self.city_name := L.p_city_name;
		self.cbsa := if(l.msa='','',l.msa+'0');
		self.RawAID	:=	l.RawAID;
		self := L;
	end;

ProfLic_In := IF(pForFCRAHeaderBuild,
dedup(sort(distribute(project(dProfLicAsSource,into(LEFT))(prim_name!='' and lname!=''),hash(did)),
record, except rid, uid, vendor_id, persistent_record_id, local),record, except rid, uid, vendor_id, persistent_record_id,local), 
project(dProfLicAsSource,into(LEFT))(prim_name!='' and lname!=''));
 
    return ProfLic_In;
  end
 ;
