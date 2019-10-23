IMPORT data_services, fbnv2;

/********************************
Before we grab this sprayed file we have to make sure that
if we receive updates from Experian  
we have to run FBNV2.fsprayFBNfiles attribute passing file date 
for spray and to add new update raw files to this supper file 
thor_data400::in::experian::sprayed::fbn.
********************************/

trimUpper(string s) := function
		  return trim(stringlib.StringToUppercase(s),left,right);
		  end;

//we are excluding when Record_Code='Z'	because these records are blank records.  
valid_fbn_raw := sort(dataset(Cluster.Cluster_In +'in::experian::sprayed::fbn',fbnv2.Layout_fbn_experian.fbn_direct_raw,flat)(trimUpper(Record_Code)<>'Z'),filing_number, name_type);

NewLayout	:=	record
	fbnv2.Layout_fbn_experian.fbn_direct_raw;
	string2  	filing_st;
	string30 	LinkingKey;
	string30  	Bus_name;
	STRING38 	Tmsid					:='';
	STRING35 	Rmsid					:='';
	string20	Filing_No	;
end;

newlayout	trfNewLayout(valid_fbn_raw input)	:=	transform
	self	:=	input;
	self	:=	[];
end;

fbn_raw	:=	project(valid_fbn_raw, trfNewLayout(left));

newLayout trfMerge(newLayout l,newLayout r)	:=	transform

	samegroup 		:= if(trimUpper(l.filing_number) = trimUpper(r.filing_number),true,false); 
	self.LinkingKey	:= if (samegroup and trimUpper(l.name_type) <> trimUpper(r.name_type),
							l.link,
							if(samegroup and trimUpper(l.name_type) = 'O' and trimUpper(r.name_type) ='O',l.LinkingKey,r.link)
					       );
	self.Bus_name 	:= if(samegroup and trimUpper(l.name_type) <> trimUpper(r.name_type),
						stringlib.StringToUppercase(l.name),
						if(samegroup and trimUpper(l.name_type) = 'O' and trimUpper(r.name_type) ='O',l.bus_name,stringlib.StringToUppercase(r.name))
					   );
	self.filing_st 	:= if (samegroup and trimUpper(l.name_type) <> trimUpper(r.name_type),
						 stringlib.StringToUppercase(l.filing_state),
						 if(samegroup and trimUpper(l.name_type) = 'O' and trimUpper(r.name_type) ='O',l.filing_st,stringlib.StringToUppercase(r.filing_state))
					   );
    self.Filing_No 	:= if (samegroup and trimUpper(l.name_type) <> trimUpper(r.name_type),
						 stringlib.StringToUppercase(l.Filing_Number),
						 if(samegroup and trimUpper(l.name_type) = 'O' and trimUpper(r.name_type) ='O',l.Filing_No,stringlib.StringToUppercase(r.Filing_Number))
					   );
					   
	self		  	:= r;
end;

New_fbn_raw	:=	iterate(fbn_raw	, trfMerge(left,right));


NewLayout	trftmsid(New_fbn_raw input)	:=	transform
	self.tmsid	:=	'EXP' + hash64(trim(Input.Bus_Name,left,right)+trim(input.filing_st,left,right)+trim(input.Filing_No,left,right));
	self.rmsid	:=	trim(Input.LinkingKey,left,right);	
	self		:=	input;
end;

ds_fbn_raw	:=	project(New_fbn_raw,trftmsid(left));

export File_fbn_experian_in :=ds_fbn_raw:persist(cluster.cluster_out+'persist::FBNV2::RawFBN_Experian'); 