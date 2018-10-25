import doxie, tools, ut;

export Keys(

	 string		pversion							= ''
	,boolean pUseProd = false

) :=
module

	shared Base					:= project(Files(pversion,pUseProd).Base.Built,transform(thrive.layouts.baseOld, self := left;));
	shared FilterBdids	:= Base(bdid	!= 0);
	shared FilterDids		:= Base(did		!= 0);

  // DF-21492 - Blank out fields in FCRA file thor_data400::key::thrive::fcra::qa::did
  fields_to_clear  := 'phone_work,phone_home,phone_cell,monthsemployed,own_home,is_military,drvlic_state,monthsatbank,ip,yrsthere,' +
                      'besttime,credit,loanamt,loantype,ratetype,mortrate,ltv,propertytype,datecollected,title,fips_st,fips_county,' +
                      'clean_phone_work,clean_phone_home,clean_phone_cell';
  ut.MAC_CLEAR_FIELDS(Base(did		!= 0), FilterDidsFCRA_temp, fields_to_clear);
  shared FilterDidsFCRA		:= DEDUP(FilterDidsFCRA_temp);
	
		tools.mac_FilesIndex('FilterBdids	,{bdid}	  ,{FilterBdids	}'	,keynames(pversion,pUseProd).Bdid		,Bdid  );
		tools.mac_FilesIndex('FilterDids		,{did	}	  ,{FilterDids	}'	,keynames(pversion,pUseProd).Did		,Did	 );
		tools.mac_FilesIndex('FilterDidsFCRA		,{did	}	  ,{FilterDidsFCRA	}'	,keynames(pversion,pUseProd).Did_fcra,Did_fcra	 );
end;
