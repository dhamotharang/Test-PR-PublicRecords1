export Mac_getSearchStatus(bkversion=3,mainfile,searchfile,outfile) := macro
//bkversion = 2
//resulting outfile will be in the following layout => BankruptcyV2.layout_bankruptcy_main.layout_bankruptcy_main_filing
//bkversion = 3
//resulting outfile will be in the following layout => BankruptcyV2.layout_bankruptcy_main_v3.layout_bankruptcy_main_filing

#uniquename(tempSearchStatus)
#uniquename(tnormalize)
#uniquename(search_norm)
%tempSearchStatus%	:=	record
	//bankruptcyV2.Layout_bankruptcy_search_v3;
	searchfile;
	string8     status_date;
	string30    status_type;
end;

#uniquename(mainflatlayout)

	
%tempSearchStatus% %tnormalize%(searchfile L, integer cnt) := transform
	self.status_date := choose(Cnt, l.converted_date,
									l.dateVacated,
									l.dateTransferred,
									l.discharged);
	self.status_type := choose(cnt,	if(l.converted_date <> '', 'CONVERTED' , ''),
									if(l.dateVacated<>'','VACATED',''),
									if(l.dateTransferred <>'', 'TRANSFERRED',''),
									if(L.discharged<>'',stringlib.StringToUpperCase(L.disposition),''));									
	self := L;
end;

%search_norm% := dedup(normalize(searchfile, 4, %tnormalize%(left, counter),local),tmsid,status_date,status_type,all)(status_date+status_type!='');

#uniquename(SearchStatus)
#uniquename(fatlayout)
#uniquename(tmakefatrecord)
#uniquename(file_flat)
#uniquename(tmakefatrecord)
#uniquename(tmakechildren)
#uniquename(rolledSearch)
%SearchStatus% := record, maxlength(10000)
	string8     status_date := '';
	string30    status_type := '';
end;

%fatLayout%	:=	RECORD
	//bankruptcyV2.Layout_bankruptcy_search_v3;
	searchfile;
	dataset(%SearchStatus%)   status;
end;

%fatLayout% %tmakefatrecord%(%tempSearchStatus% L) := transform
  self.status   := DATASET([{ l.status_date, l.status_type }], bankruptcyV2.Layout_bankruptcy_main_v3.layout_status);
  self := L;
end;

%file_flat% := project(%search_norm%, %tmakefatrecord%(left));

%fatLayout% %tmakechildren%(%fatLayout% l, %fatLayout% r) := transform
	self.status				:=	L.status + row({r.status[1].status_date, r.status[1].status_Type},BankruptcyV2.layout_bankruptcy_main.layout_status);
	self					:=	L;
end;

%rolledSearch% := rollup(%file_flat%,TMSID,%tmakechildren%(left, right),local);



#uniquename(trfMain2)
//#uniquename(getmainfile)
#uniquename(mainfilelayout)
#uniquename(outfile1)
#uniquename(norm_recs)
#uniquename(norm_out)
#uniquename(get_childds)
#uniquename(get_childds_out) 
#uniquename(childds_rollup)
#uniquename(trfMain)
////////////////////////////////////////////////////////////////////////////////////////////////
#IF (bkversion = 2)
	
	%mainflatlayout% := record
		Bankruptcyv2.layout_bankruptcy_main.layout_bankruptcy_main_filing - status;
		string8     status_date := '';
		string30    status_type := '';
	end;
	
	%mainfilelayout% := Bankruptcyv2.layout_bankruptcy_main.layout_bankruptcy_main_filing;
	
//	%getmainfile% := Bankruptcyv2.file_bankruptcy_main;
	
	Bankruptcyv2.layout_bankruptcy_main.layout_bankruptcy_main_filing %trfMain%(mainfile l, %fatLayout% r) := transform
		self.disposed_Date		:= 	r.discharged;
		self.orig_filing_type	:=	r.filing_type;
		self.status				:=	(r.status + l.status)(status_date !='');
		self.comments			:=	l.comments(filing_date !='');
		self					:=	l;
		self					:=	r;
	end;
	%outfile1%	:= join(distribute(mainfile,hash(tmsid)), distribute(%rolledSearch%,hash(tmsid))
										,trim(left.TMSID,left,right) = trim(right.TMSID,left,right)
										,%trfMain%(left, right), left outer, local);
	
	
	
#ELSE
	%mainflatlayout% := record
		recordof(mainfile) - status;
		string8     status_date := '';
		string30    status_type := '';
	end;
	
	%mainfilelayout% := typeof(mainfile);
	
	//%getmainfile% := mainfile;
	
	typeof(mainfile) %trfMain2%(mainfile l, %fatLayout% r) := transform
		self.status				:=	(r.status + l.status)(status_date !='');
		self.comments			:=	l.comments(filing_date !='');
		self					:=	l;
		self					:=	r;
	end;
	%outfile1%	:= join(distribute(mainfile,hash(tmsid)), distribute(%rolledSearch%,hash(tmsid))
										,trim(left.TMSID,left,right) = trim(right.TMSID,left,right)
										,%trfMain2%(left, right), left outer, local);
	
	
#END;
////////////////////////////////////////////////////////////////////////////////////////////////

// since Bankruptcyv2.layout_bankruptcy_main.layout_status is the same as 
// Bankruptcyv2.layout_bankruptcy_main_v3.layout_status following code will
// be common to both v2 and v3 base file

// following code lines will dedup the status child dataset

%mainflatlayout% %norm_recs%(%outfile1% l, Bankruptcyv2.layout_bankruptcy_main_v3.layout_status r)  := transform
	self.status_date := r.status_date;
	self.status_type := r.status_type;
	self := l;
end;

%norm_out% := dedup(sort(normalize(%outfile1%,left.status,%norm_recs%(left,right),local),tmsid,process_date,status_date,status_type,local),tmsid,process_date,status_date,status_type,local); 

%mainfilelayout% %get_childds%(%norm_out% l) := transform
	self.status   := DATASET([{ l.status_date, l.status_type }], bankruptcyV2.Layout_bankruptcy_main.layout_status);
	self := l;
end;

%get_childds_out% := project(%norm_out%,%get_childds%(left));

%mainfilelayout% %childds_rollup%(%get_childds_out% l,%get_childds_out% r) := transform
	self.status				:=	L.status + row({r.status[1].status_date, r.status[1].status_Type},BankruptcyV2.layout_bankruptcy_main.layout_status);
	self := l;
end;

// note there is funnel - reason being normalize drops records that have
// empty status so add all records that have count(status) = 0 to the resultant
// rollup
outfile := sort(distribute(rollup(%get_childds_out%,TMSID+orig_case_number+court_name+court_location+process_date,%childds_rollup%(left, right),local),hash(tmsid)) + distribute(%outfile1%(count(status) = 0),hash(tmsid)),tmsid,local);


endmacro;

