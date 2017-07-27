import doxie_crs;

export timeline_summary(
	dataset(doxie.layout_references) in_dids, 
	string1 in_party_type = '', 
	boolean IncludeCorporateAffiliations = false) := FUNCTION

ThisDid := in_dids[1].did;

iAddresses := Comp_Addresses(did=ThisDid);

Time_Rec := doxie_crs.layout_timeline_summary;
  
Time_Rec make_rec_from_address(iAddresses le,unsigned1 c) := transform
  self.event_date := IF(c=1,le.dt_first_seen,le.dt_last_seen)*100;
  self.occurrence := MAP( self.event_date=0 => skip, 
                          c=1 => 'First Seen at','Last Seen at');
  self := le;
  end;  
  
n := normalize(iAddresses,2,make_rec_from_address(left,counter));

Time_Rec make_rec_from_death(DeathFile_Records le,unsigned c) := transform
  self.event_date := (unsigned8)IF(c=1,le.dod8,le.dob8);
  self.occurrence := MAP( self.event_date=0 => skip,
                          c=1 => 'Died','Born' );
  self := le;					 
  end;
  
d := normalize(DeathFile_Records,2,make_rec_from_death(left,counter));  

Time_Rec make_rec_from_ucc(doxie_crs.layout_UCC_Records le) := transform
  self.event_date := (unsigned8)le.filing_date;
  self.occurrence := 'UCC Filed to '+le.secured_name;
  end;

u := project(UCC_Legacy_Records(in_dids,,in_party_type),make_rec_from_ucc(left));

Time_Rec make_rec_from_akas(SSN_Records le,unsigned c) := transform
  self.event_date := IF( c=1,le.first_seen, le.last_seen )*100;
  self.occurrence := MAP( c=1 and le.first_seen<>le.last_seen => 'First seen as',
                          c=1 => 'Seen as',
					 le.first_seen<>le.last_seen => 'Last seen as',
					 skip );
  self := le;					 
  end;

s := normalize(SSN_Records(did=ThisDid),2,make_rec_from_akas(left,counter));

corp_recs := doxie.corp_affiliations_records(in_dids);

Time_Rec make_rec_from_corps(corp_recs le) := transform
  self.event_date := (unsigned)le.filing_date;
  self.occurrence := 'Filed Corporation:'+le.corporation_name;
  end;

c := project( dedup(corp_recs(IncludeCorporateAffiliations),filing_date,corporation_name,all),make_rec_from_corps(left));

al := s+d+n+u+c;
so := sort(al(event_date<>0),-event_date);  
  
return so;

END;