import POE,mdr;

export As_POE(

	dataset(DataBridge.layouts.Base) pBase	= DataBridge.Files().base.qa

) :=
function

	POE.Layouts.Base	tMapToPOE(DataBridge.layouts.Base l, unsigned1 cnt) :=
	transform,
	 skip(cnt = 2 and trim(l.Title_Desc_2,left,right) = '' or
	      cnt = 3 and trim(l.Title_Desc_3,left,right) = '' or
				cnt = 4 and trim(l.Title_Desc_4,left,right) = '' or
				trim(l.fname + l.lname,left,right)          = '' or
				trim(l.clean_company_name,left,right)       = '' )
				
		self.source	                     := l.source;
		self.did												 := l.did;																	
		self.did_score									 := l.did_score;														
		self.dt_first_seen							 := l.dt_first_seen;												
		self.dt_last_seen					 			 := l.dt_last_seen;												
		self.vendor_id									 := (string)l.record_sid; 													
		self.subject_name.title					 := l.title; 
	  self.subject_name.fname					 := l.fname;
	  self.subject_name.mname					 := l.mname;
	  self.subject_name.lname					 := l.lname;
	  self.subject_name.name_suffix		 := l.name_suffix;
		self.subject_address.prim_range	 := l.prim_range;
	  self.subject_address.predir      := l.predir;
	  self.subject_address.prim_name   := l.prim_name;
	  self.subject_address.addr_suffix := l.addr_suffix;
	  self.subject_address.postdir		 := l.postdir;
	  self.subject_address.unit_desig	 := l.unit_desig;
	  self.subject_address.sec_range	 := l.sec_range;
	  self.subject_address.city_name	 := l.v_city_name;
	  self.subject_address.st					 := l.st;
	  self.subject_address.zip				 := l.zip;
	  self.subject_address.zip4				 := l.zip4;
		self.subject_job_title					 := choose(cnt,l.Title_Desc_1,l.Title_Desc_2,l.Title_Desc_3,l.Title_Desc_4);
		self.company_name							   := l.clean_company_name;
		self.company_address.prim_range	 := l.prim_range;
	  self.company_address.predir      := l.predir;
	  self.company_address.prim_name   := l.prim_name;
	  self.company_address.addr_suffix := l.addr_suffix;
	  self.company_address.postdir		 := l.postdir;
	  self.company_address.unit_desig	 := l.unit_desig;
	  self.company_address.sec_range	 := l.sec_range;
	  self.company_address.city_name	 := l.v_city_name;
	  self.company_address.st					 := l.st;
	  self.company_address.zip				 := l.zip;
	  self.company_address.zip4				 := l.zip4;
		self.company_phone							 := (unsigned5)l.clean_telephone_num;
		self.company_rawaid				 			 := l.raw_aid;
		self.company_aceaid				 			 := l.ace_aid;
		self.global_sid								   := l.global_sid; 
		self.record_sid                  := l.record_sid;
		self                             := [];
	end;
	
	NormPOE := normalize(pBase, 4, tMapToPOE(left, counter));
	
	return NormPOE;
end;