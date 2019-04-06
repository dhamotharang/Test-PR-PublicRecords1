import header, ut,mdr,Std;

export LiensV2_as_header(dataset(LiensV2.Layout_Liens_party_HeaderIngest) lien_in = dataset([],LiensV2.Layout_Liens_party_HeaderIngest), boolean pForHeaderBuild=false, boolean pFastHeader = false)
 :=
function


party_all_ := if(pForHeaderBuild,
					  dataset('~thor_data400::base::LiensV2_partyHeader_Building',LiensV2.Layout_Liens_party_HeaderIngest,flat)	
								((integer)did <= 999999001000 and cname='' and lname!='' and fname!='' and prim_name!=''  and (trim(prim_name)<>'NONE' and trim(v_city_name)<>'NONE')),
					   lien_in((integer)did <= 999999001000)
					  );
party_all := if (pFastHeader, dataset('~thor_data400::base::LiensV2_partyQuickHeader_Building',LiensV2.Layout_Liens_party_HeaderIngest,flat)
								((integer)did <= 999999001000 and cname='' and lname!='' and fname!='' and prim_name!=''  and (trim(prim_name)<>'NONE' and trim(v_city_name)<>'NONE')
									and ut.DaysApart((STRING8)Std.Date.Today(), date_vendor_last_reported[..6] + '01') <= Header.Sourcedata_month.v_fheader_days_to_keep), 
								party_all_);
					  
dL2AsSource	:=	header.Files_SeqdSrc(pFastHeader).LiensV2;


 party_all_dist := distribute(party_all,hash(tmsid_old));
 party_all_sort := sort(party_all_dist ,tmsid_old,local) ;
 dL2AsSource_dist	 := distribute(dL2AsSource,hash(tmsid));
 dL2AsSource_sort := sort(dL2AsSource_dist,tmsid,local);
 
 
 
src_rec := record
 header.Layout_Source_ID;
 //liensv2.Layout_as_source;
 LiensV2.Layout_Liens_party_HeaderIngest;
end;


src_rec addSearch(party_all L,dL2AsSource R) := transform
		self := r;
		self := L;
end;			 

	join_get_uid := join( party_all_sort ,dL2AsSource_sort,(left.tmsid_old = right.tmsid) , addSearch(left, right),local);


header.Layout_New_Records intoHeader(join_get_uid L) := transform
	  self.did := if(pFastHeader, (unsigned)l.did, 0);
	  self.rid := 0;
	  self.dt_first_seen := (integer)l.date_first_seen[1..6];
	  self.dt_last_seen := (integer)l.date_last_seen[1..6];
	  self.dt_vendor_last_reported := (integer)l.date_vendor_last_reported[1..6];
	  self.dt_vendor_first_reported := (integer)l.date_vendor_first_reported[1..6];
	  self.dt_nonglb_last_seen := (integer)l.date_vendor_last_reported[1..6];
	  self.rec_type := '1';
	  self.vendor_id := trim(l.tmsid_old) + trim(l.rmsid_old);
	  self.dob := 0;
	  self.ssn := if ((integer)l.ssn=0 or length(trim(l.ssn, all)) <> 9 or regexfind('[^0-9]', l.ssn),'',l.ssn); //added code to check input length
	  self.city_name := l.v_city_name;
	  self.phone := '';
	  self.title := l.title;
	  self.fname := l.fname;
	  self.mname := l.mname;
	  self.lname := l.lname;
	  self.name_suffix := l.name_suffix;
	  //self.st := l.state;
	  self.county := l.county[3..5];
	  self.cbsa := if(l.msa!='',l.msa+'0','');
	  self.src := MDR.sourceTools.src_Liens_v2;
	  self.suffix := l.addr_suffix;
	  self := l;
	  end;

all_rec := project(join_get_uid,intoheader(left));

return dedup(all_rec,all,hash);

end;