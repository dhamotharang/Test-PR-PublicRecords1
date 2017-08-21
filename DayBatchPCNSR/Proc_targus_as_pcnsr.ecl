import DayBatchPCNSR,targus, address;

ds_Targus:=distribute(targus.file_consumer_base,hash(first_name,last_name,st,zip));


DayBatchPCNSR.Layout_PCNSR tr(ds_Targus l) := transform

	self.title_orig			:= trim(l.title,left);
	self.fname_orig			:= trim(l.first_name,left);
	self.mname_orig			:= trim(l.middle_name,left)[1];
	self.lname_orig			:= trim(l.last_name,left);
	self.name_suffix_orig	:= trim(l.last_name_suffix,left);
	
	gender1					:= datalib.gender(l.CleanName[	6	..	25	]);
	self.gender				:= if(gender1 in ['F','M'],gender1,'');

	fullName				:= trim(l.secondary_first_name+' '+l.secondary_middle_name	+' '+l.last_name,left,right);
	string182 spouse_cname	:= if(l.secondary_first_name<>'',address.CleanPersonFML73(fullName),'');
	self.spouse_indicator	:= if(l.secondary_first_name<>'','Y','N');

	self.spouse_title		:= spouse_cname[	1	..	5	];
	self.spouse_fname		:= spouse_cname[	6	..	25	];
	self.spouse_mname		:= spouse_cname[	26	..	45	];
	self.spouse_lname		:= spouse_cname[	46	..	65	];
	self.spouse_name_suffix	:= spouse_cname[	66	..	70	];

	self.spouse_title_orig			:= trim(l.secondary_name_title,left);
	self.spouse_fname_orig			:= trim(l.secondary_first_name,left);
	self.spouse_mname_orig			:= trim(l.secondary_middle_name,left)[1];
	self.spouse_lname_orig			:= if(l.secondary_first_name<>'',trim(l.last_name,left),'');
	self.spouse_name_suffix_orig	:= trim(l.secondary_name_suffix,left);

	gender2					:= datalib.gender(l.secondary_first_name);
	self.spouse_gender		:= if(gender2 in ['F','M'],gender2,'');


	self.prim_range		:= l.CleanAddress[	1	..	10	];
	self.predir			:= l.CleanAddress[	11	..	12	];
	self.prim_name		:= l.CleanAddress[	13	..	40	];
	self.addr_suffix	:= l.CleanAddress[	41	..	44	];
	self.postdir		:= l.CleanAddress[	45	..	46	];
	self.unit_desig		:= l.CleanAddress[	47	..	56	];
	self.sec_range		:= l.CleanAddress[	57	..	64	];
	self.p_city_name	:= l.CleanAddress[	65	..	89	];
	self.v_city_name	:= l.CleanAddress[	90	..	114	];
	self.st				:= l.CleanAddress[	115	..	116	];
	self.zip			:= l.CleanAddress[	117	..	121	];
	self.zip4			:= l.CleanAddress[	122	..	125	];
	self.cart			:= l.CleanAddress[	126	..	129	];
	self.cr_sort_sz		:= l.CleanAddress[	130	..	130	];
	self.lot			:= l.CleanAddress[	131	..	134	];
	self.lot_order		:= l.CleanAddress[	135	..	135	];
	self.dbpc			:= l.CleanAddress[	136	..	137	];
	self.chk_digit		:= l.CleanAddress[	138	..	138	];
	self.rec_type		:= l.CleanAddress[	139	..	140	];
	self.county			:= l.CleanAddress[	141	..	145	];
	self.geo_lat		:= l.CleanAddress[	146	..	155	];
	self.geo_long		:= l.CleanAddress[	156	..	166	];
	self.msa			:= l.CleanAddress[	167	..	170	];
	self.geo_blk		:= l.CleanAddress[	171	..	177	];
	self.geo_match		:= l.CleanAddress[	178	..	178	];
	self.err_stat		:= l.CleanAddress[	179	..	182	];

	self.title			:= l.CleanName[	1	..	5	];
	self.fname			:= l.CleanName[	6	..	25	];
	self.mname			:= l.CleanName[	26	..	45	];
	self.lname			:= l.CleanName[	46	..	65	];
	self.name_suffix	:= l.CleanName[	66	..	70	];
	self.name_score		:= l.CleanName[	71	..	73	];

	string phone				:= trim(l.phone_number,all);
	self.area_code				:= if(length(phone)=10,phone[1..3],'');
	self.phone_number			:= if(length(phone)=10,phone[4..10],phone[length(phone)-6 .. length(phone)]);
	self.telephone_number_type	:= case ((qstring)l.phone_type
													,'M' => 'C'
													,'C' => 'T'
													,'G' => 'P'
													,'T' => 'O'
													,'D' => 'O'
													,'O' => 'B'
													,'W' => 'B'
													,'P' => 'V'
													,'H' => 'V'
													,'R' => 'V'
													,'A' => 'V'
													,'S' => 'V'
													,l.phone_type
													);

	self.do_not_call_flag		:= if(l.no_solicitation_code<>'','1','');
	self.Telephone_Acquisition_Date	:= if(length(trim(l.validation_date,all))=8,l.validation_date[1..6],'');

	self	:= l;
	self	:= [];

end;

Targus_as_PCNSR	:=	project(ds_Targus, tr(left)) : persist ('~thor_data400::persist::targus_as_pcnsr');

export Proc_targus_as_PCNSR := Targus_as_PCNSR;