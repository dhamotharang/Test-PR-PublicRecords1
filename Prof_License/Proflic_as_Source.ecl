﻿/*2017-07-01T09:58:51Z (wma_prod)
C:\Users\MaWX.RISK\AppData\Roaming\HPCC Systems\eclide\wma_prod\prod\Prof_License\Proflic_as_Source\2017-07-01T09_58_51Z.ecl
*/
/*2016-09-22T23:13:38Z (Wendy Ma)
DF-17551
*/
import header,mdr,fcra_list,data_services;

export Proflic_as_Source(dataset(layout_prolic_out_with_AID) pProfLic = dataset([],layout_prolic_out_with_AID), boolean pForHeaderBuild=false,boolean pForFCRAHeaderBuild=false)
 :=
  function
	dSourceData	:=	map(pForHeaderBuild =>
					   dataset('~thor_data400::Base::ProfLicHeader_Building',layout_prolic_out_with_AID,flat)(prolic_key[1..1]<>'C'),
						 pForFCRAHeaderBuild =>
					   dataset('~thor_data400::Base::ProfLicfcraHeader_Building',layout_prolic_out_with_AID,flat)(prolic_key[1..1]<>'C' 
						 and (vendor in fcra_list.constants.proflic_approved_vendor
						 or (vendor = fcra_list.constants.proflic_approved_vendor_ks and profession_or_board = fcra_list.constants.proflic_profession_or_board)
						 or vendor[1..3] in fcra_list.constants.proflic_approved_new_src_code)),
					   pProfLic(prolic_key[1..1]<>'C')
					  );

	src_rec := header.layouts_SeqdSrc.PL_src_rec;

	header.Mac_Set_Header_Source(dSourceData,layout_prolic_out_with_AID,src_rec,MDR.sourceTools.src_Professional_License,withUID)

	return withUID;
  end
 ;
