import STD,ut;

export FileInfo(string filename
									,string esp // roxie or thor ONLY IP for example 10.242.31.11
									) := module

	 export GetLayout() := function
		rDFUInfoRequest := record
			string Name{xpath('Name')} := filename;
		end;
	
		rDFUInfoResponse := record,maxlength(30000)
			string fullxml{xpath('FileDetail/Ecl')};
			string contenttype{xpath('FileDetail/ContentType')};
		end;
	
		dDFUInfo := SOAPCALL('http://' + esp + ':8010/Wsdfu/?ver_=1.22'
												,'DFUInfo'
												,rDFUInfoRequest
												,dataset(rDFUInfoResponse)											
												,xpath('DFUInfoResponse')
												,HTTPHEADER('Authorization', 'Basic ' + ut.Credentials().fGetEncodedValues())
										 );

		return dDFUInfo;
		
	end;
	
	
	export rExceptions := record
		string errormsg{xpath('Exception/Message')}
	end;
		
	export IndexFields() := function

		rDFUSearchDataRequest := record
			string OpenLogicalName{xpath('OpenLogicalName')} := filename;
		end;
	
		rKeyedColumns := record
			string keyfields{xpath('ColumnLabel')};
		end;
	
		
	
		rDFUSearchDataResponse := record
			string logicalname{xpath('LogicalName')};
			dataset(rKeyedColumns) keycols1{xpath('DFUDataKeyedColumns1/DFUDataColumn')};
			dataset(rKeyedColumns) keycols2{xpath('DFUDataKeyedColumns2/DFUDataColumn')};
			dataset(rKeyedColumns) keycols3{xpath('DFUDataKeyedColumns3/DFUDataColumn')};
			dataset(rKeyedColumns) keycols4{xpath('DFUDataKeyedColumns4/DFUDataColumn')};
			dataset(rKeyedColumns) keycols5{xpath('DFUDataKeyedColumns5/DFUDataColumn')};
			dataset(rKeyedColumns) keycols6{xpath('DFUDataKeyedColumns6/DFUDataColumn')};
			dataset(rKeyedColumns) keycols7{xpath('DFUDataKeyedColumns7/DFUDataColumn')};
			dataset(rKeyedColumns) keycols8{xpath('DFUDataKeyedColumns8/DFUDataColumn')};
			dataset(rKeyedColumns) keycols9{xpath('DFUDataKeyedColumns9/DFUDataColumn')};
			dataset(rKeyedColumns) keycols10{xpath('DFUDataKeyedColumns10/DFUDataColumn')};
			dataset(rKeyedColumns) keycols11{xpath('DFUDataKeyedColumns11/DFUDataColumn')};
			dataset(rKeyedColumns) keycols12{xpath('DFUDataKeyedColumns12/DFUDataColumn')};
			dataset(rKeyedColumns) keycols13{xpath('DFUDataKeyedColumns13/DFUDataColumn')};
			dataset(rKeyedColumns) keycols14{xpath('DFUDataKeyedColumns14/DFUDataColumn')};
			dataset(rKeyedColumns) keycols15{xpath('DFUDataKeyedColumns15/DFUDataColumn')};
			dataset(rKeyedColumns) keycols16{xpath('DFUDataKeyedColumns16/DFUDataColumn')};
			dataset(rKeyedColumns) keycols17{xpath('DFUDataKeyedColumns17/DFUDataColumn')};
			dataset(rKeyedColumns) keycols18{xpath('DFUDataKeyedColumns18/DFUDataColumn')};
			dataset(rKeyedColumns) keycols19{xpath('DFUDataKeyedColumns19/DFUDataColumn')};
			dataset(rKeyedColumns) keycols20{xpath('DFUDataKeyedColumns20/DFUDataColumn')};
			dataset(rExceptions) exceptions{xpath('Exceptions')};
		end;
	
		dDFUSearchData := SOAPCALL('http://'+esp+':8010/Wsdfu/?ver_=1.22'
												,'DFUSearchData'
												,rDFUSearchDataRequest
												,dataset(rDFUSearchDataResponse)
												,xpath('DFUSearchDataResponse')
												,HTTPHEADER('Authorization', 'Basic ' + ut.Credentials().fGetEncodedValues())
										 );

		return dDFUSearchData;
	
	end;
	
	export rKeyedColumn := record
			string keyfields;
		end;

	export rKeyedFields := record
			string lname;
			dataset(rKeyedColumn) keycols1;
			dataset(rKeyedColumn) keycols2;
			dataset(rKeyedColumn) keycols3;
			dataset(rKeyedColumn) keycols4;
			dataset(rKeyedColumn) keycols5;
			dataset(rKeyedColumn) keycols6;
			dataset(rKeyedColumn) keycols7;
			dataset(rKeyedColumn) keycols8;
			dataset(rKeyedColumn) keycols9;
			dataset(rKeyedColumn) keycols10;
			dataset(rKeyedColumn) keycols11;
			dataset(rKeyedColumn) keycols12;
			dataset(rKeyedColumn) keycols13;
			dataset(rKeyedColumn) keycols14;
			dataset(rKeyedColumn) keycols15;
			dataset(rKeyedColumn) keycols16;
			dataset(rKeyedColumn) keycols17;
			dataset(rKeyedColumn) keycols18;
			dataset(rKeyedColumn) keycols19;
			dataset(rKeyedColumn) keycols20;
			dataset(rExceptions) exceptions;
		end;
	
	
	
	
	export NormalizeFields() := function
		dIndexFields := IndexFields();
		
		rKeyedFields xKeyedColumns(dIndexFields l) := transform
			self.lname := filename;
			self := l;
		end;

		dKeyedFields := project(dIndexFields,xKeyedColumns(left));

		rNormFields := record
			string lname;
			string keycol := '';
			dataset(rKeyedColumn) kcols;
			integer cnt;
			string errormsg;
			//dataset(rExceptions) exceptions;
		end;

		rNormFields xNormFields(dKeyedFields l, integer c) := transform
			self.lname := l.lname;
			//self.keycol := r.keyfields;
			self.kcols := choose(c
														,l.keycols1
														,l.keycols2
														,l.keycols3
														,l.keycols4
														,l.keycols5
														,l.keycols6
														,l.keycols7
														,l.keycols8
														,l.keycols9
														,l.keycols10
														,l.keycols11
														,l.keycols12
														,l.keycols13
														,l.keycols14
														,l.keycols15
														,l.keycols16
														,l.keycols17
														,l.keycols18
														,l.keycols19
														,l.keycols20
														);
			self.cnt := c;
			self.errormsg := l.exceptions[1].errormsg;
		end;
		
		dNormFields := normalize(dKeyedFields,20,xNormFields(left,counter));
		
		rNormFields xRollup(dNormFields l, dNormFields r) := transform
				self.kcols				:=	L.kcols + r.kcols;
				self					:=	L;
		end;

		dRollup := rollup(dNormFields(count(kcols) > 0),lname,xRollup(left, right));

		rNormFields xNormRecs(dRollup l, rKeyedColumn r) := transform
			self.keycol := r.keyfields;
			self := l;
		end;

		dNormrecswithkcols := normalize(dRollup, left.kcols, xNormRecs(left,right));

		// no kcols

		dErrors := dNormFields(count(kcols) < 1 and errormsg <> '');
	
		dNormrecs := dNormrecswithkcols + dErrors;
	
		// rDeNormFields := record
			// string infilename;
			// string keyedfields;
		// end;

		dDummyFields := dataset([{filename,'',[],0,''}],rNormFields);

		rNormFields xDeNormFields(dDummyFields l,dNormrecs r) := transform
			
			self.keycol := l.keycol + ',' + r.keycol;
			self := r;
		end;

		deNormRecs := denormalize(dDummyFields
																	,dNormrecs
																	,left.lname = right.lname
																	,xDeNormFields(left,right));
		return deNormRecs;
		
	end;
	
	export LayoutDetails() := function

		dLayout := GetLayout();
		dNorm := NormalizeFields();
		
		rLayoutDetails := record
			string keyedfields;
			string fulllayout;
			string errormsg := '';
		end;
		
		rLayoutDetails xLayoutDetails(dLayout l) := transform
			self.fulllayout := l.fullxml;
			self.keyedfields := if (STD.Str.ToUpperCase(l.contenttype) = 'KEY'
																,dNorm[1].keycol
																,'');
																
			self.errormsg := dNorm[1].errormsg;
		end;
		
		dLayoutDetails := project(dLayout,xLayoutDetails(left));
		
		return dLayoutDetails;
	end;
	
end;