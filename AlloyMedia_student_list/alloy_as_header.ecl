import Header;

export	alloy_as_header(dataset(AlloyMedia_student_list.layouts.Layout_base) pAlloy = dataset([],AlloyMedia_student_list.layouts.Layout_base), boolean pForHeaderBuild=false)
 :=
  function
	dAlloyAsSource	:=	AlloyMedia_student_list.alloy_as_source(pAlloy,pForHeaderBuild);

	Header.Layout_New_Records Translate_Alloy_to_Header(dAlloyAsSource l) := transform
		//don't even populate vendor dates because they can eventually get used in watchdog/bestaddress
		self.did                      :=	0;
		self.rid                      :=	0;
		self.src											:=	'AL';	//Is this ok as an identifier?
		self.dt_first_seen            :=	0;
		self.dt_last_seen             :=	0;
		self.dt_vendor_first_reported :=	0;
		self.dt_vendor_last_reported  :=	0;
		self.dt_nonglb_last_seen      :=	0;

		self.rec_type                 :=	''; //What is this?

		self.vendor_id                :=	(qstring18)HASH32(L.sequence_number + L.key_code); //Will this length fit?

		self.phone                    :=	L.clean_phone_number;

		self.title										:=	L.clean_title;
		self.fname										:=	L.clean_fname;
		self.mname										:=	L.clean_mname;
		self.lname										:=	L.clean_lname;
		self.name_suffix							:=	L.clean_name_suffix;

		self.prim_range								:=	L.clean_prim_range;
		self.predir										:=	L.clean_predir;
		self.prim_name								:=	L.clean_prim_name;
		self.suffix										:=	L.clean_name_suffix;
		self.postdir									:=	L.clean_postdir;
		self.unit_desig								:=	L.clean_unit_desig;
		self.sec_range								:=	L.clean_sec_range;
		self.city_name								:=	L.clean_p_city_name;
		self.st												:=	L.clean_st;
		self.zip											:=	L.clean_zip5;
		self.zip4											:=	L.clean_zip4;
		self.county										:=	L.clean_county;
		self.geo_blk									:=	L.clean_geo_blk;

		self                          :=	L;
		self													:=	[];
	end;


	alloy_project := project(dAlloyAsSource,Translate_Alloy_to_Header(left));

	alloy_filtered	:=	alloy_project(fname<>'' and length(trim(lname))>1 and prim_name<>'' and zip<>'');

    return alloy_filtered;
  end
 ;
