export mac_ToLayoutMaster(indataset,outdataset,infname,inmname,inlname,
						inssn,
						indob,
						inphone,
						inprim_name,inprim_range,inst,incity_name,inzip,insec_range,
						instates,
						inlname1,inlname2,inlname3,
						incity1,incity2,incity3,
						inrel_fname1,inrel_fname2,inrel_fname3,
						inlookups,
						inDID,
					//personal above.  business below
						inbname,
						infein,
						inbphone,
						inbprim_name,inbprim_range,inbst,inbcity_name,inbzip,inbsec_range,
						inbdid,
						useFakeIDs) :=
MACRO 

outdataset := 
	project(
		indataset,
		transform(
			autokey.layouts.master,
			self.inp.fname := left.infname;
			self.inp.mname := left.inmname;
			self.inp.lname := left.inlname;
			self.inp.ssn := if((integer)left.inssn=0,'',(string9)left.inssn);
			self.inp.dob := (integer)left.indob;
			self.inp.phone := (string10)left.inphone;
			self.inp.prim_name := left.inprim_name;
			self.inp.prim_range := left.inprim_range;
			self.inp.st := left.inst;
			self.inp.city_name := left.incity_name;
			self.inp.zip := (string6)left.inzip;
			self.inp.sec_range := left.insec_range;
			self.inp.states := left.instates;
			self.inp.lname1 := left.inlname1;
			self.inp.lname2 := left.inlname2;
			self.inp.lname3 := left.inlname3;
			self.inp.city1 := left.incity1;
			self.inp.city2 := left.incity2;
			self.inp.city3 := left.incity3;
			self.inp.rel_fname1 := left.inrel_fname1;
			self.inp.rel_fname2 := left.inrel_fname2;
			self.inp.rel_fname3 := left.inrel_fname3;
			self.inp.lookups := left.inlookups;
			self.inp.DID := (unsigned6)left.inDID;
			self.inp.bname := left.inbname;
			self.inp.fein := if((integer)left.infein=0,'',(string9)left.infein);
			self.inp.bphone := (string10)left.inbphone;
			self.inp.bprim_name := left.inbprim_name;
			self.inp.bprim_range := left.inbprim_range;
			self.inp.bst := left.inbst;
			self.inp.bcity_name := left.inbcity_name;
			self.inp.bzip := (string5)left.inbzip;
			self.inp.bsec_range := left.inbsec_range;
			self.inp.BDID := (unsigned6)left.INBDID;
			self.FakeID := 
			#if(useFakeIDs)
				left.FakeID;
			#else
				0;
			#end;
			// self := left;
			self.p := [];
			self.b := [];
		)
	);

endmacro;