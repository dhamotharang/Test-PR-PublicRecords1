Import watercraft_infutor, Address, AID, ut, VersionControl, NID, PromoteSupers;

#workunit('name', 'Infutor Watercraft Base Build');

// Grab date from Logical Filename
RawInVirtual	:=	RECORD
	watercraft_infutor.layouts.watercraft_infutor_in;
	STRING	__filename	{ VIRTUAL(logicalfilename)};
END;

ds:= dataset('~thor_data400::in::watercraft::infutor',RawInVirtual,CSV(terminator('\n'),separator('\t'),quote('')));

RawWithDate	:= PROJECT(ds, TRANSFORM(Watercraft_infutor.layouts.layout_CleanFields, SELF.filedate:=regexfind('[0-9]{8}',LEFT.__filename, 0);
																																										SELF := LEFT;
																																										SELF := [];// Grab date from Logical Filename
											));

ds_raw_base := dataset('~thor_data400::base::infutor_watercraft_raw',Watercraft_infutor.layouts.layout_CleanFields,flat);

//file_date := VersionControl.fGetFilenameVersion('~thor_data400::in::watercraft::infutor');

//Concat Names and addresses for cleaning
Watercraft_infutor.layouts.layout_CleanFields ConcatCleanFields(RawWithDate L) := TRANSFORM
//	self.File_date := thorlib.wuid()[2..9];
	self.Filedate	:= L.filedate;
	self.make := REGEXREPLACE('UNKNOWN',StringLib.StringToUpperCase(L.make),'');
	self.Clean_Name	:= if(L.fname<>'', trim(L.fname,left,right)+' ' ,  '') +
	                                 if(L.mname <>'',trim(L.mname)+ ' ', '')+ trim(L.lname,left,right)+ trim(L.suffix,left,right);
	tempPreDirection					:= IF(TRIM(L.predir,all) = '',TRIM(L.postdir,all),TRIM(L.predir,all));
	t1_AptType		:= StringLib.StringFindReplace(trim(L.apt_type,all),'#TE', 'STE');
	t2_AptType		:= StringLib.StringFindReplace(t1_AptType, '#NIT','UNIT');
	TempADDRESS1	:= StringLib.StringCleanSpaces(trim(L.house_nbr,left,right)+' '+tempPreDirection+' '+trim(L.street,left,right)+' '
																							+trim(L.street_type,left,right)+' '+t2_AptType+' '+StringLib.StringFilterOut(trim(L.apt_nbr,all),'-'));
	self.ADDRESS1	:= StringLib.StringFilterOut(StringLib.StringToUpperCase(TempADDRESS1),',.;*!\'');
	self.ADDRESS2 := StringLib.StringCleanSpaces(trim(L.city,left,right) + if(L.city <> '',', ',' ') + trim(L.state,left,right) + ' ' + L.zip);
	self.Clean_Address := Address.CleanAddress182(self.ADDRESS1,self.ADDRESS2);
	self := L;
END;

ds_ConcatFields := project(RawWithDate(fname != '' and lname != ''), ConcatCleanFields(LEFT));

//Add name_type 
// Address.Mac_Is_Business_Parsed(ds_ConcatFields,fPreclean,fname,mname,lname,suffix,,name_type);
	
	//Clean input name	
	NID.Mac_CleanParsedNames(ds_ConcatFields, FileClnName, 
													firstname:=fname, lastname:=lname, middlename := mname, namesuffix := suffix
													,includeInRepository:=true, normalizeDualNames:=false);

// Clean names
	person_flags := ['P', 'D'];
  Bus_flags   := ['B', 'U', 'I', 'T']; 		
	fClean_name := project(FileClnName,transform({Watercraft_infutor.layouts.layout_CleanFields},            
                      self.pname1          := if(left.nametype IN person_flags, left.cln_title + left.Cln_fname + left.cln_mname + left.cln_lname + left.cln_suffix,'');
											self.cname1          := if(left.nametype IN Bus_flags, StringLib.StringCleanSpaces(left.fullname) ,''); 
											self                 := left));

//Rollup to capture most current record and latest last_seen_date
BOOLEAN basefileexists	:=	nothor(fileservices.GetSuperFileSubCount('~thor_data400::base::infutor_watercraft_raw')) > 0; 
	
ds_combined := IF(basefileexists,fClean_name + ds_raw_base,fClean_name);
ds_distrib := distribute(ds_combined, HASH(PID,lname,fname,mname[1]));
ds_sort	:= sort(ds_distrib(Clean_Name != ''),PID,lname,fname,mname[1],suffix,make,model,year,city,state,local); 

Watercraft_infutor.layouts.layout_CleanFields xformCombined(ds_sort l, ds_sort r)	:= TRANSFORM
	self.filedate					:=	MAX(r.filedate);
	self.first_seen_date	:=	(string)ut.EarliestDate((integer)l.first_seen_date,(integer)r.first_seen_date);
	self.last_seen_date		:=	MAX(r.last_seen_date);
	self := l;
END;
	
	
RollupInfutor	:=	ROLLUP(ds_sort,	xformCombined(LEFT,RIGHT),
																	PID,
																	lname,
																	fname,
																	mname[1],
																	suffix,
																	make,
																	model,
																	year,
																	city,
																	state,
																	local);

PromoteSupers.MAC_SF_BuildProcess(RollupInfutor,'~thor_data400::base::infutor_watercraft_raw',build_infutor_out,3, /*csvout*/false, /*compress*/true/*,(string8)file_date*/);

EXPORT file_infutor_in := build_infutor_out;