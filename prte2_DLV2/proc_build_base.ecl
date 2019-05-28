IMPORT  prte2_DLV2,PromoteSupers,prte2,std,AID,Address,PRTE2,ut;

EXPORT PROC_BUILD_BASE(String filedate) := FUNCTION
  PRTE2.CleanFields(Files.dl2_drvlic_in,dInClean);
  dExistingRecords := PROJECT(dInClean(TRIM(cust_name) = ''), TRANSFORM(Layouts.Layout_Base, SELF := LEFT, SELF := [])); 
  dNewRecords			 := dInClean(TRIM(cust_name) <> '');
  
  AddressDataSet := PRTE2.AddressCleaner( dNewRecords,
	 ['addr1'],
	 ['addr2'],
	 ['city'],
	 ['state'],
	 ['zip'],
	 ['clean_address'],
   ['orig_rawaid']);	
	
	DS_out	:=	Project(AddressDataSet,
  Transform(Layouts.Layout_Base,
      cleanName := Address.CleanPersonFML73_fields(Left.name); 
			self.title          := CleanName.title;
			self.fname          := CleanName.fname;
			self.mname          := CleanName.mname;   
			self.lname          := CleanName.lname;
			self.name_suffix    := CleanName.name_suffix;	
      SELF.cleaning_score	:= CleanName.name_score;
			
			self.prim_range := left.clean_address.prim_range;
      self.predir := left.clean_address.predir;
      self.prim_name := left.clean_address.prim_name;
      self.suffix := left.clean_address.addr_suffix;
      self.postdir := left.clean_address.postdir;
      self.unit_desig := left.clean_address.unit_desig;
      self.sec_range := left.clean_address.sec_range;
      self.p_city_name := left.clean_address.p_city_name;
      self.v_city_name := left.clean_address.v_city_name;
      self.st := left.clean_address.st;
      self.zip := left.clean_address.zip;
      self.zip4 := left.clean_address.zip4;
      self.cart := left.clean_address.cart;
      self.cr_sort_sz := left.clean_address.cr_sort_sz;
      self.lot := left.clean_address.lot;
      self.lot_order := left.clean_address.lot_order;
      self.dpbc := left.clean_address.dbpc;
      self.chk_digit := left.clean_address.chk_digit;
      self.record_type := left.clean_address.rec_type;
      self.ace_fips_st := left.clean_address.fips_state;
      self.county := left.clean_address.fips_county;
      self.geo_lat := left.clean_address.geo_lat;
      self.geo_long := left.clean_address.geo_long;
      self.msa := left.clean_address.msa;
      self.geo_blk := left.clean_address.geo_blk;
      self.geo_match := left.clean_address.geo_match;
      self.err_stat := left.clean_address.err_stat;
      SELF.did := prte2.fn_AppendFakeID.did(SELF.fname, SELF.lname, Left.link_ssn, Left.link_dob, Left.cust_name);

      dob_temp:=(integer4)left.link_dob;			
			SELF.age := (qstring3)ut.age(dob_temp);
     	self:=Left; 
self:=[];
));

  dFinal := ds_OUT + dExistingRecords;
  ut.MAC_Sequence_Records(dFinal,dl_seq,dFinalSeq);
	PromoteSupers.MAC_SF_BuildProcess(dFinalSeq,Constants.file_base, writefile);
  RETURN writefile;

END;