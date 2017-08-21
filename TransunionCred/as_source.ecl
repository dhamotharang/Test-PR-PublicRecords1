/*2014-09-13T16:32:07Z (Jose Bello_Prod)

*/
import ut,header,Std;

export as_source(dataset(Layouts.base) pFile = dataset([],Layouts.base), boolean pForHeaderBuild=false,boolean pFastHeader= false)
 :=
  function
	dSourceData_	:=	map(pForHeaderBuild => dataset('~thor_data400::base::transunioncredheader_building',Layouts.base,flat)
										,pFastHeader => dataset('~thor_data400::base::transunioncredQuickHeader_building',Layouts.base,flat)
										,pFile 
										)
										;
	
	dSourceData := if (pFastHeader
	, dSourceData_(ut.DaysApart((STRING8)Std.Date.Today(), ((string)dt_vendor_last_reported)[..6] + '01')  <= Header.Sourcedata_month.v_fheader_days_to_keep
							or ut.DaysApart((STRING8)Std.Date.Today(), ((string)dt_last_seen)[..6]            + '01')  <= Header.Sourcedata_month.v_fheader_days_to_keep)
	, dSourceData_);

	src_rec := header.layouts_SeqdSrc.TN_src_rec;

	seed:=if(pFastHeader,999999999999,1);
	header.Mac_Set_Header_Source(dSourceData,Layouts.base,src_rec,'TN',with_id,seed)

	return fn_Not_Primary_TN(with_id);
  end
 ;