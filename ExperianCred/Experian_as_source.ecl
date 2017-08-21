/*2014-09-13T16:33:05Z (Jose Bello_Prod)

*/
import ut,header,std;

export Experian_as_source(dataset(ExperianCred.Layouts.Layout_Out) pExperian = dataset([],ExperianCred.Layouts.Layout_Out), boolean pForHeaderBuild=false, boolean pFastHeader = false)
 :=
  function
	dSourceData0_	:=	map(pForHeaderBuild => dataset('~thor_data400::Base::ExperianHeader_Building',ExperianCred.Layouts.Layout_Out,flat)
					   ,pFastHeader => dataset('~thor_data400::Base::ExperianQuickHeader_Building',ExperianCred.Layouts.Layout_Out,flat)
					   ,pExperian
						 )
						 ;
				  
	dSourceData0 := if (pFastHeader
	, dSourceData0_(ut.DaysApart((STRING8)Std.Date.Today(), ((string)date_vendor_last_reported)[..6] + '01') <= Header.Sourcedata_month.v_fheader_days_to_keep
							 or ut.DaysApart((STRING8)Std.Date.Today(), ((string)date_last_seen)[..6]            + '01') <= Header.Sourcedata_month.v_fheader_days_to_keep)
	, dSourceData0_);

    ExperianCred.Layouts.Layout_Out_old  ref(dSourceData0 l) := transform 
	self.Orig_Address_date :=  l.Orig_Address_Create_Date ;  
	self.fname := if(trim(l.fname,left,right)='NULL', '', l.fname);
	self.mname := if(trim(l.mname,left,right)='NULL', '', l.mname);
	self.lname := if(trim(l.lname,left,right)='NULL', '', l.lname);
	self:= l; 
	end; 
	
	dSourceData :=  project(dSourceData0 , ref(left)); 

	src_rec:=header.layouts_SeqdSrc.EN_src_rec;

	seed:=if(pFastHeader,999999999999,1);
	header.Mac_Set_Header_Source(dSourceData(nametype[1..2]!='SP'),ExperianCred.Layouts.Layout_Out_old,src_rec,'EN',with_id,seed)

	return fn_Not_Primary_EN(with_id);
  end
 ;
 