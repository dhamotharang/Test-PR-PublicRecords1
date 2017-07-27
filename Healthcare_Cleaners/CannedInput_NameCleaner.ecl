#Stored('DPPAPurpose',1);
#Stored('GLBPurpose',1);
#Stored('DataRestrictionMask','00000000000000000');
#WORKUNIT('name','Healthcare_Cleaners.CannedInput_NameCleaner Test');    //name it "MyJob"
Import Healthcare_Cleaners;
rec_in := Healthcare_Cleaners.Layouts.rawNameInput;
rec_in setinput():=transform
		self.acctno := '1';
		// self.nameFull := 'Raymond Dieter Jr., M.D., F.A.C.S.  ';
		// self.nameFull := 'Rob Hensen M.A.M.F.C.               ';
		// self.nameFull := 'Abby M. Jamison Duran M.s.               ';
		// self.nameFull := 'Michels Doctor Dawn, MD ';
		// self.nameFull := 'Doctor Dawn Michels MD ';
		// self.nameFull := 'Andre A. D\'Hemecourt, MD ';
		// self.nameFull := 'Huma H. Naqvi MD ';
		// self.nameFull := 'Karen J. Richardson, ANP CS ';
		// self.nameFull := 'Gary Stuck Do ';
		// self.nameFull := 'Arturo Briones, DC ';
		// self.nameFull := 'Jed Seitzinger Do ';
		// self.nameFull := 'Gordon Davis Do  '; 
		// self.nameFull := 'Dr. Susan M. June  ';
		// self.nameFull := 'Dr. D.r. Susan M. June  ';
		// self.nameFull := 'John C. Breckinridge Sr sr, MD  ';
		// self.nameFull := 'N. Diamond Do  ';
		// self.nameFull := 'Mr T.J. Cully  ';
		// self.nameFull := 'Health Metro, DNT  ';
		// self.nameFull := 'James D.k. Park   ';
		// self.nameFull := 'Sen Wu, DMD   ';//x
		// self.nameFull := 'Qin Pu Pa   ';
		// self.nameFull := 'Macdonald Andre J., MD  ';
		// self.nameFull := 'Gary E. Cockran M.a.  ';
		// self.nameFull := 'Raymond Dieter Jr., MD F.A.C.S. ';
		// self.nameFull := 'Dawn Doctor ';
		// self.nameFull := 'Dawn Doctor MD';
		// self.nameFull := 'Dawn Do ';
		// self.nameFull := 'Dawn Do, DO  ';
		// self.nameFull := 'Shimona R. Bhatia, DO MPH  ';
		// self.nameFull := 'William J. W. Au   ';
		// self.nameFull := 'Orlando A. Arana, MD   ';
		// self.nameFull := 'Jack Barning Jr, DC ';
		// self.nameFull := 'Amy Jermann, PAC ';
		// self.nameFull := 'Sat Siri Kaur Khalsa ';
		// self.nameFull := 'Arthur M. Inc. Dumke Jr, DO ';
		// self.nameFull := 'Clark Daniel Medicine ';//x
		// self.nameFull := 'Eric Paul Bachelor, MD F.A.C.S. ';//x
		// self.nameFull := 'Joseph A. Arena, MD ';//x
		// self.nameFull := 'Connie Cook II, PA-C  ';
		self.nameFull := 'Tammy Tryboski, PT  ';
		self.isLFM := false;
		self.namePrefix := '';
		self.nameFirst := '';
		self.nameMiddle := '';
		self.nameLast := '';
		self.nameSuffix := '';
		self.nameProfessionalSuffix := '';
	self:=[]
end;
ds_in:=dataset([setinput()]);
results:=project(ds_in,transform(Healthcare_Cleaners.Layouts.cleanNameOutput,
															cln:=Healthcare_Cleaners.Functions.doNameClean(left);
															self := cln[1];));
output(results);