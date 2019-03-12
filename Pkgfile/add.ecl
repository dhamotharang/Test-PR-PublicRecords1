// THIS MODULE CAN BE EXPANDED BY ADDING FUNCTIONALITIES WHEN NEW
// PACKAGE ID TYPES ARE INTRODUCED INTO THE ROXIE PACKAGE FILE
EXPORT add(string clustername = '') := module
	////////////////////////////////////////////////////////////////////////
	// Function: SFiles - to add Key Package ID, Superfiles and Subfiles
	// Paramters: FileRecord Dataset
	// Functionality: 1. add the files to package
	//								2. Remove files if it already exists and then re-add
	//								3. Based on the isfullreplace flag in FileRecord
	//								4. the subfiles will either be appended or replaced
	////////////////////////////////////////////////////////////////////////
	export SFiles(dataset(layouts.flat_layouts.FileRecord) File_DS, string pkgfileversion = WORKUNIT[2..]) := function
		// Existing package - flat file 
		KEY_DS := pkgfile.files('flat',clustername).getflatpackage(pkgcode = 'K');
		NONKEY_DS := pkgfile.files('flat',clustername).getflatpackage(pkgcode <> 'K');
		PKG_DS_CheckTil := KEY_DS;
		// Take care of '~'
		layouts.flat_layouts.FileRecord PrefixTild(File_DS l) := transform
			self.superfile := '~'+regexreplace('~',l.superfile,'');
			self.subfile := '~'+regexreplace('~',l.subfile,'');
			self := l;
		end;
		
		pkgfile.layouts.flat_layouts.packageid fullprefixtild(PKG_DS_CheckTil l) := transform
			self.superfileid := '~'+regexreplace('~',l.superfileid,'');
			self.subfilevalue := '~'+regexreplace('~',l.subfilevalue,'');
			self := l;
		end;
		
		FilePrefixed := project(File_DS,PrefixTild(left));
		PKG_DS := project(PKG_DS_CheckTil,fullprefixtild(left));
		// full or delta replacement records
		FullReplaceRecs := FilePrefixed(isfullreplace or isdeltareplace);
		// delta update or delta replacement records
		AppendRecs := FilePrefixed(~isfullreplace);
		
		// Remove the new full/delta replacement records from existing package
		layouts.flat_layouts.packageid RemoveNew(PKG_DS l,FullReplaceRecs r) := transform
			// (l.superfileid = r.superfile and (~l.isfullreplace and r.isdeltareplace) - will take care of delta replace
			// (l.superfileid = r.superfile and r.isfullreplace) - will take care of full replace
			// both will removed
			self.subfilevalue := if ((l.superfileid = r.superfile and (~l.isfullreplace and r.isdeltareplace))
																	or (l.superfileid = r.superfile and r.isfullreplace)
																	,''
																	,l.subfilevalue
																	);
			self := l;
		end;
		
		NewRemoved := join(PKG_DS,FullReplaceRecs,stringlib.StringToUpperCase(left.id) = stringlib.StringToUpperCase(right.packageid) and
																						stringlib.StringToUpperCase(left.superfileid) = stringlib.StringToUpperCase(right.superfile),
																						RemoveNew(left,right),
																						left outer,
																						lookup)(subfilevalue <> '');
		
		// handle new delta records if any
		layouts.flat_layouts.packageid xNewRecords(PKG_DS l,AppendRecs r) := transform
			// (l.superfileid = r.superfile and l.subfilevalue = r.subfile) - remove the record from result if both super/sub are same between
							// package file and new request
			self.subfilevalue := if ((l.superfileid = r.superfile and l.subfilevalue = r.subfile), '', r.subfile);
			self.isfullreplace := r.isfullreplace;
			self := l;
		end;
		
		dNewRecords := dedup(sort(join(PKG_DS,AppendRecs,stringlib.StringToUpperCase(left.id) = stringlib.StringToUpperCase(right.packageid) and
																						stringlib.StringToUpperCase(left.superfileid) = stringlib.StringToUpperCase(right.superfile),
																						xNewRecords(left,right))(subfilevalue <> ''),id,superfileid,subfilevalue), record, except whenupdated);
		
		// Convert New records that are full replace of Package Layout
		layouts.flat_layouts.packageid ConvertNew(FullReplaceRecs l) := transform
			self.pkgcode := 'K';
			self.id := l.packageid;
			self.superfileid := l.superfile;
			self.subfilevalue := l.subfile;
			self.daliip := l.daliip;
			self.whenupdated := pkgfileversion;
			self.isfullreplace := l.isfullreplace;
			self := [];
		end;
		
		NewConverted := project(FullReplaceRecs(isfullreplace),ConvertNew(left));
		
		ADD_DS := sort(NewRemoved + dNewRecords + NewConverted + NONKEY_DS,id,superfileid,-isfullreplace,subfilevalue);

		// Promote to Package Super File
		
		pkgfile.Promote(clustername).New(ADD_DS,'flat',filepromoted,pkgfileversion);
		
		return filepromoted;
	end;
	////////////////////////////END////////////////////////////////////////
	
	////////////////////////////////////////////////////////////////////////
	// Function: Queries - to add Query Package ID
	// Paramters: Package ID = Query name, 
	//						Baseid = superfile name or unique identifier that identifies
	//										a set of superfiles, default is blank which will include 
	//										all ids (best thing to do in LN environment)
	//						compulsory = attribute value for query
	//						eft = enablefieldtranslation value for query
	// Functionality: 1. add queries to package
	//								2. Remove queries if it already exists and then re-add
	// Note: Unlike adding keys, this function will allow users to add
	// one query at any given time, but a potential functionality can added
	// in the future to pass in a dataset for bulk updates
	////////////////////////////////////////////////////////////////////////
	
	export Queries(dataset(layouts.flat_layouts.queries) l_packageid, string pkgfileversion = WORKUNIT[2..]) := function
		// Full Package 
		PKG_DS := pkgfile.files('flat',clustername).getflatpackage;
		// New Package ID
		
		layouts.flat_layouts.packageid removeold(PKG_DS l, l_packageid r) := transform
			self := l;
		end;
		
		New_DS := join(sort(distribute(PKG_DS,hash(id)),id, local), 
										sort(distribute(l_packageid,hash(id)),id,local), 
										left.id = right.id and left.baseid = right.baseid, 
										left only);
		
		layouts.flat_layouts.packageid getnewids(l_packageid l) := transform
			self.pkgcode := 'Q';
			self.whenupdated := pkgfileversion;
			self := l
		end;
		
		l_DS := project(l_packageid,getnewids(left));
		// Remove Package ID if it already exists
		
		
		ADD_DS := NEW_DS + l_DS;
		// Promote to Package Super File - Flat file
		pkgfile.Promote(clustername).New(ADD_DS,'flat',filepromoted,pkgfileversion);
		
		return filepromoted;
		
	end;
	////////////////////////////END////////////////////////////////////////
	
	////////////////////////////////////////////////////////////////////////
	// Function: Environment - to add Environment Variables
	// Paramters: Package ID = Defaulted to EnvironmentVariables, 
	//						id = environment variable name
	//						val = environment variable value
	// Functionality: 1. add environment variables to package
	//								2. Remove environments if it already exists and then re-add
	// Note: Unlike adding keys, this function will allow users to add
	// one environment variable at any given time, but a potential functionality can added
	// in the future to pass in a dataset for bulk updates
	////////////////////////////////////////////////////////////////////////
	
	export Environment(string l_packageid = 'EnvironmentVariables', string l_id = '',string l_val = '',string pkgfileversion = WORKUNIT[2..]) := function
		 
		PKG_DS := pkgfile.files('flat',clustername).getflatpackage;
		l_DS := dataset([{'E',l_packageid,l_id,l_val,pkgfileversion}],layouts.flat_layouts.packageid);
		New_DS := PKG_DS(~(pkgcode = 'E' and id = l_packageid and environmentid = l_id));
		ADD_DS := NEW_DS + l_DS;
		
		pkgfile.Promote(clustername).New(ADD_DS,'flat',filepromoted,pkgfileversion);
		
		return filepromoted;
	end;
	
	////////////////////////////END////////////////////////////////////////
end;