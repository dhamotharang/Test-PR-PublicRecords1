import risk_indicators,ut;

export Mac_apply_title(infile,title_field, fname_field, mname_field, outfile) := macro

//split the records with fname and w/o fname
#uniquename(infile_temp)
#uniquename(infile_has_fname)
#uniquename(infile_has_no_fname)
//blank title
%infile_temp% := project(infile, transform(recordof(infile), self.title_field := '', self := left));
%infile_has_fname% := %infile_temp%(fname_field <> '');
%infile_has_no_fname% := %infile_temp%(fname_field = '');

//split the records with DID and w/o DID
#uniquename(infile_has_did)
#uniquename(infile_has_no_did)
#uniquename(p1)
#uniquename(by_did)
#uniquename(by_fname)
#uniquename(p1_has_title_by_did)
#uniquename(p1_has_no_title_by_did)
#uniquename(t1)

%infile_has_did%    := %infile_has_fname%((unsigned6)did > 0);
%infile_has_no_did% := %infile_has_fname%((unsigned6)did = 0);

//generate gender base table
g_file  := risk_indicators.File_gender_base;

//drop where a DID has both genders
%by_did%  := g_file(did>0 and gender <> 'D');

//drop where a confident score greater than .95
%by_fname% := g_file(did=0 and confidence_score>.95 and length(trim(fname))>1);

//apply gender by did
recordof(infile) %t1%(%infile_has_did% le, %by_did% ri) := transform
 self.title_field := if(ri.gender='M','MR',if(ri.gender='F','MS',''));
 self       := le;
end;

%p1%     := if(count(%infile_has_did%) > 7000000000, join(%infile_has_did%,%by_did%,(unsigned6)left.did=right.did,%t1%(left,right),left outer,lookup),
            join(distribute(%infile_has_did%, hash((unsigned6)did)), distribute(%by_did%,hash(did)),(unsigned6)left.did=right.did,%t1%(left,right),left outer, local));

%p1_has_title_by_did%    := %p1%(title_field <> '');
%p1_has_no_title_by_did% := %p1%(title_field = '');

//apply gender by fname
#uniquename(p1_apply_fname)
#uniquename(h_gender_rec)
#uniquename(t2)
#uniquename(p2)
#uniquename(p1_has_valid_fname)
#uniquename(p1_has_invalid_fname)

%h_gender_rec% := record
  string1 fname_gender;
  infile;
  end;

%p1_apply_fname% := project(%p1_has_no_title_by_did% + %infile_has_no_did%, transform(%h_gender_rec%, self := left, self := []));
%p1_has_valid_fname% := %p1_apply_fname%(length(trim(fname_field,left,right)) > 1);
%p1_has_invalid_fname% := %p1_apply_fname%(length(trim(fname_field,left,right)) = 1);

%h_gender_rec% %t2%(%p1_has_valid_fname% le, %by_fname% ri) := transform
 self.title_field    := if(le.fname_field = ri.fname and ri.gender='M','MR',if(le.fname_field = ri.fname and ri.gender='F','MS',''));
 self.fname_gender   := if(self.title_field = 'MR', 'M',if(self.title_field = 'MS', 'F',''));
 self       := le;
 self       := [];
end;

%p2%      := if(count(%p1_has_valid_fname%) > 10000000, join(%p1_has_valid_fname%,%by_fname%,left.fname_field=right.fname,%t2%(left,right),left outer,lookup),
           join(distribute(%p1_has_valid_fname%, hash(fname_field)), distribute(%by_fname%, hash(fname)),
                left.fname_field=right.fname,%t2%(left,right),left outer,local));
//output(%p2%);
//split the records with DID and w/o DID
#uniquename(p2_has_DID)
#uniquename(p2_has_DID_dist)
#uniquename(p2_has_no_DID)
#uniquename(p2_grp)
#uniquename(gender_did_rolled)
#uniquename(t3)
#uniquename(p3)
%p2_has_DID% := (%p2% + %p1_has_invalid_fname%)((unsigned6)did > 0);
%p2_has_DID_dist% := distribute(%p2_has_DID%,hash(did));

%p2_has_no_DID% := %p2%((unsigned6)did = 0);

%p2_grp%  := group(sort(%p2_has_DID_dist%(title_field <> ''),did,local),did,local);
	
//rollup to see if there are any DID that are both male and female, if so make them as blank
%gender_did_rolled% := group(rollup(%p2_grp%, true, transform(%h_gender_rec%,
									 self.title_field := if(left.title_field = right.title_field, right.title_field, ''),
									 self := right)));
//join back after get dual gender
%p2_has_DID_dist% %t3%(%p2_has_DID_dist% le, %gender_did_rolled% ri) := transform

self.title_field    := if(le.did = ri.did, ri.title_field, le.title_field);
self.fname_gender   := if(self.title_field = 'MR', 'M',if(self.title_field = 'MS', 'F',''));
self := le;

end;

%p3% := join(%p2_has_DID_dist%, %gender_did_rolled%, left.did = right.did, %t3%(left, right), left outer, local);
//enhancement by mname, blank gender if fname gender and mname gender conflicted								
#uniquename(p3_has_valid_mname)
#uniquename(p3_has_invalid_mname)
#uniquename(t4)
#uniquename(p4)

%p3_has_valid_mname% := (%p3%+ %p2_has_no_DID%)(title_field <> '' and length(trim(mname_field,left,right)) > 1);
%p3_has_invalid_mname% := project((%p3% + %p2_has_no_DID%)(~(title_field <> '' and length(trim(mname_field,left,right)) > 1)),transform(recordof(infile), self := left));;
recordof(infile) %t4%(%p3_has_valid_mname% le, %by_fname% ri) := transform

string1 comb_gender := if(le.mname_field =ri.fname and le.fname_gender <> ri.gender, 'D',le.fname_gender);						  
self.title_field     := if(comb_gender ='M','MR',if(comb_gender='F','MS', comb_gender));

self                := le;
end;

%p4%      := if(count(%p3_has_valid_mname%) > 10000000, join(%p3_has_valid_mname%,%by_fname%,left.mname_field=right.fname,%t4%(left,right),left outer,lookup),
            join(distribute(%p3_has_valid_mname%, hash(mname_field)),distribute(%by_fname%,hash(fname)),left.mname_field=right.fname,%t4%(left,right),left outer,local));

#uniquename(p4_has_DID)
#uniquename(p4_has_no_DID)
#uniquename(p4_has_DID_dist)
#uniquename(p4_has_DID_dual_gender_dedup)
#uniquename(t5)
#uniquename(p5)
%p4_has_DID% := (%P4% + %p3_has_invalid_mname%)((unsigned6)DID >0);
%p4_has_no_DID% := (%P4% + %p3_has_invalid_mname%)((unsigned6)DID =0);
%p4_has_DID_dist% := distribute(%p4_has_DID%, hash(DID));
%p4_has_DID_dual_gender_dedup% := dedup(sort(distribute( %p4_has_DID%(title_field ='D'), hash(did)), did,local),did,local);
%p4_has_DID_dist% %t5%(%p4_has_DID_dist% le,%p4_has_DID_dual_gender_dedup% ri) := transform
		self.title_field := if (le.DID = ri.DID, ri.title_field, le.title_field);
		self := le;
	end;
%p5% := join(%p4_has_DID_dist%,%p4_has_DID_dual_gender_dedup%, left.did = right.did,%t5%(left,right),left outer,local);

//combine all records
outfile :=  %infile_has_no_fname% + %p1_has_title_by_did% + project(%p4_has_no_DID% + %p5%, transform(recordof(infile), 
            self.title_field := if(left.title_field != 'D', left.title_field, ''), self := left))  
            + project(%p1_has_invalid_fname%((unsigned6)did = 0),transform(recordof(infile), self := left));
endmacro;