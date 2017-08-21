import Drivers, Address, ut, lib_stringlib, DriversV2, NID;

export Cleaned_DL_OH(string processDate, string fileDate) := function

	in_file := DriversV2.File_DL_OH_Update(fileDate);

	layout_out := DriversV2.Layouts_DL_OH_In.Layout_OH_Cleaned;
	
	string lFixNameCharacters(string pOrigName)
	  := if(lib_stringlib.stringlib.stringfind(pOrigName,'*',1) <> 0,
			lib_stringlib.stringlib.stringfindreplace(
			  lib_stringlib.stringlib.stringfindreplace(
				lib_stringlib.stringlib.stringfindreplace(pOrigName,'%',' '),
				',',' '),
			   '*',', ')
				,pOrigName
		   );
	

	layout_out mapClean(in_file l) := transform
		string73 tempName := stringlib.StringToUpperCase(if(trim(l.PIMNAM,left,right) <> '',
															Address.CleanPerson73(trim(lFixNameCharacters(l.PIMNAM),left,right)),
															''));
		
		self.title           := tempName[1..5];
		self.fname           := tempName[6..25];
		self.mname           := tempName[26..45];
		self.lname           := tempName[46..65];
		self.name_suffix	   := ut.fGetSuffix(tempName[66..70]);
		self.cleaning_score	 := tempName[71..73];
		self.prim_range      := '';
		self.predir 	       := '';
		self.prim_name 	     := '';
		self.suffix          := '';
		self.postdir 	       := '';
		self.unit_desig 	   := '';
		self.sec_range 	     := '';
		self.p_city_name	   := '';
		self.v_city_name	   := '';
		self.state	         := '';
		self.zip 		         := '';
		self.zip4 		       := '';
		self.cart 		       := '';
		self.cr_sort_sz 	   := '';
		self.lot 		         := '';
		self.lot_order 	     := '';
		self.dbpc 		       := '';
		self.chk_digit 	     := '';
		self.rec_type	       := '';
		self.ace_fips_st	   := '';
		self.county     	   := '';
		self.geo_lat 	       := '';
		self.geo_long 	     := '';
		self.msa 		         := '';
		self.geo_blk         := '';
		self.geo_match 	     := '';
		self.err_stat 	     := '';	
		self.process_date    := lib_stringlib.stringlib.stringfilter(processDate,'0123456789');
		self.DBKOLN          := stringlib.StringToUpperCase(trim(l.DBKOLN,left,right));
		self.PINSS4          := stringlib.StringToUpperCase(trim(l.PINSS4,left,right));
		self.DVNLIC          := stringlib.StringToUpperCase(trim(l.DVNLIC,left,right));			
		self.DVCCLS          := stringlib.StringToUpperCase(trim(l.DVCCLS,left,right));
		self.DVCTYP          := stringlib.StringToUpperCase(trim(l.DVCTYP,left,right));
		self.PIFDON          := stringlib.StringToUpperCase(trim(l.PIFDON,left,right));
		self.PICHCL          := stringlib.StringToUpperCase(trim(l.PICHCL,left,right));
		self.PICECL          := stringlib.StringToUpperCase(trim(l.PICECL,left,right));			
		self.PIQWGT          := lib_stringlib.stringlib.stringfilter(l.PIQWGT,'0123456789');
		self.PINHFT          := lib_stringlib.stringlib.stringfilter(l.PINHFT,'0123456789');
		self.PINHIN          := lib_stringlib.stringlib.stringfilter(l.PINHIN,'0123456789');
		self.PICSEX          := stringlib.StringToUpperCase(trim(l.PICSEX,left,right));
		self.DVDDOI          := lib_stringlib.stringlib.stringfilter(l.DVDDOI,'0123456789');
		self.DVC2PL          := stringlib.StringToUpperCase(trim(l.DVC2PL,left,right));			
		self.DVDEXP          := lib_stringlib.stringlib.stringfilter(l.DVDEXP,'0123456789');
		self.DRNAGY          := stringlib.StringToUpperCase(trim(l.DRNAGY,left,right));
		self.DVFOCD          := stringlib.StringToUpperCase(trim(l.DVFOCD,left,right));
		self.DVFOPD          := stringlib.StringToUpperCase(trim(l.DVFOPD,left,right));			
		self.DVNAPP          := stringlib.StringToUpperCase(trim(l.DVNAPP,left,right));
		self.DVCATT          := stringlib.StringToUpperCase(trim(l.DVCATT,left,right));
		self.DVDNOV          := stringlib.StringToUpperCase(trim(l.DVDNOV,left,right));
		self.DVCDED          := stringlib.StringToUpperCase(trim(l.DVCDED,left,right));
		self.DVCGRS          := stringlib.StringToUpperCase(trim(l.DVCGRS,left,right));			
		self.DVFDUP          := stringlib.StringToUpperCase(trim(l.DVFDUP,left,right));
		self.DVCGEN          := stringlib.StringToUpperCase(trim(l.DVCGEN,left,right));
		self.DVFLSD          := stringlib.StringToUpperCase(trim(l.DVFLSD,left,right));
		self.DVQDUP          := stringlib.StringToUpperCase(trim(l.DVQDUP,left,right));
		self.DVFOHR          := stringlib.StringToUpperCase(trim(l.DVFOHR,left,right));
		self.DBKMTK          := stringlib.StringToUpperCase(trim(l.DBKMTK,left,right));
		self.DVFRCS          := stringlib.StringToUpperCase(trim(l.DVFRCS,left,right));
		self.DVNWBI          := stringlib.StringToUpperCase(trim(l.DVNWBI,left,right));
		self.SYCPGM          := stringlib.StringToUpperCase(trim(l.SYCPGM,left,right));
		self.SYTDA1          := stringlib.StringToUpperCase(trim(l.SYTDA1,left,right));
		self.SYCUID          := stringlib.StringToUpperCase(trim(l.SYCUID,left,right));
		self.DVFFRD          := stringlib.StringToUpperCase(trim(l.DVFFRD,left,right));
		//TSA & Medical Certificaton in next 5 fields
		self.DVCTSA          := stringlib.StringToUpperCase(trim(l.DVCTSA,left,right));
		self.DVDTSA          := stringlib.StringToUpperCase(trim(l.DVDTSA,left,right));
		self.DVDTEX          := stringlib.StringToUpperCase(trim(l.DVDTEX,left,right));
		self.DVCSCE          := stringlib.StringToUpperCase(trim(l.DVCSCE,left,right));
		self.DVDMCE          := stringlib.StringToUpperCase(trim(l.DVDMCE,left,right));
		self.FILLER          := stringlib.StringToUpperCase(trim(l.FILLER,left,right));
		self.PIMNAM          := stringlib.StringToUpperCase(trim(l.PIMNAM,left,right));
		self.PIGSTR          := stringlib.StringToUpperCase(trim(l.PIGSTR,left,right));		
		self.PIGCTY          := stringlib.StringToUpperCase(trim(l.PIGCTY,left,right));
		self.PIGSTA          := stringlib.StringToUpperCase(trim(l.PIGSTA,left,right));
		self.PIGZIP          := trim(l.PIGZIP,left,right);
		self.PINCNT          := stringlib.StringToUpperCase(trim(l.PINCNT,left,right));
		self.PIDD01          := stringlib.StringToUpperCase(trim(l.PIDD01,left,right));
		self.PIDDOD          := stringlib.StringToUpperCase(trim(l.PIDDOD,left,right));
		self.PIDAUP          := lib_stringlib.stringlib.stringfilter(l.PIDAUP,'0123456789');
		self                 := l;		
	end;

	Cleaned_OH_File := project(in_file, mapClean(left));
	
	return Cleaned_OH_File;
end;