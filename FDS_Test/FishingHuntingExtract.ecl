
import eMerges,address,ut,versioncontrol;

layout_base:=emerges.layout_hunters_out;

export FishingHuntingExtract(
	 string					pversion
	,dataset(layout_base)	zHFbase			= eMerges.file_hunters_out
	,set of string			pZipCodes		= fds_test.ZipcodeSet
	,boolean				pOverwrite		= false
	,boolean				pCsvout			= true
	,string					pSeparator		= '|'	
	
) :=function 

filter := zHFbase (zip in pZipCodes or mail_ace_zip in pZipCodes );
dHF_filter:=	dedup(sort(filter,-process_date,- file_acquired_date,-date_last_seen,best_ssn,license_type_mapped,source_state,HuntFishPerm,DateLicense
   							,fname,lname,prim_range,prim_name,P_city_name,st,zip,mail_prim_range,mail_prim_name,mail_p_city_name,mail_st,mail_ace_zip),best_ssn,license_type_mapped,source_state,HuntFishPerm,DateLicense
   							,fname,lname,prim_range,prim_name,P_city_name,st,zip,mail_prim_range,mail_prim_name,mail_p_city_name,mail_st,mail_ace_zip);

	trimUpper(string s) := function
		return trim(stringlib.StringToUppercase(s),left,right);
	end;
			
	temp_Lay:=record
			Layouts.Response.Fishing_Hunting_Extract;
			string  	sourceKey			;
			string8		process_date		;
			string8   	date_last_seen		;
			string8    	file_acquired_date  ;
	end;

			
 temp_Lay tConvert2Response(layout_base l) 	:=transform,skip(l.fname ='' and l.lname='')

			self.sourceKey					:=if(l.best_ssn !='',trim(l.best_ssn,left,right) ,trim( 
												trim(l.fname,left,right) +
												trim(l.lname,left,right) +
												trim(l.prim_range,left,right) + 
												trim( l.prim_name,left,right) +    
												trim(l.p_city_name,left,right) +  
												trim(l.st + l.zip,left,right) ,left,right));
													
			self.Source_Zip					:=if((integer)l.zip != 0 and trim(l.zip,left,right)in pZipCodes,trim(l.zip,left,right),
												if((integer)l.mail_ace_zip != 0 and trim(l.mail_ace_zip,left,right)in pZipCodes,trim(l.mail_ace_zip,left,right),''));
			self.first_Name					:=trim(l.fName,left,right)             ;
			self.middle_Name				:=trim(l.mName,left,right)            ;
			self.last_Name					:=trim(l.lName,left,right)             ;
			self.Street_Addr				:=trim(Address.Addr1FromComponents(
																 l.prim_range
																,l.predir
																,l.prim_name
																,l.suffix
																,l.postdir
																,'',''
															),left,right);
			self.Secondary_Addr				:=trim(Address.Addr1FromComponents(
																 l.unit_desig
																,l.sec_range
																,''
																,''
																,''
																,''
																,''
															),left,right);
			self.res_City					:=trim(l.p_city_name,left,right);
			self.St							:=trim(l.st,left,right);
			self.zip						:=if((integer)l.zip != 0,trim(l.zip,left,right),'');
			self.license_type				:=trimUpper(l.license_type_mapped);
			self.license_state				:=trimUpper(l.source_state)  ;
			self.license_date				:=if((integer)l.DateLicense!= 0, trim(l.DateLicense[5..8]+l.DateLicense[1..4],left,right),'');
			self.license_number				:=if((integer)l.HuntFishPerm != 0,l.HuntFishPerm ,'');
			self.SSN_Out					:=if((integer)l.best_ssn != 0,l.best_ssn ,'');
			self.Gender						:=map(trimUpper(l.gender) ='M'=>'MALE',
												      trimUpper(l.gender) ='F'=>'FEMALE','')      ;
			self.DOB						:=if((integer)l.DOB!= 0,trim(l.DOB[5..8]+l.DOB[1..4],left,right),'');
			self.Home_State                 :=trim(l.Homestate,left,right);
			self.mail_Street_Addr			:=trim(Address.Addr1FromComponents(
																 l.mail_prim_range
																,l.mail_predir
																,l.mail_prim_name
																,l.mail_addr_suffix
																,l.mail_postdir
																,'',''
															),left,right);
			self.mail_Secondary_Addr		:=trim(Address.Addr1FromComponents(
																 l.mail_unit_desig
																,l.mail_sec_range
																,''
																,''
																,''
																,''
																,''
															),left,right);
			self.mail_City					:=trim(l.mail_p_city_name,left,right);
			self.mail_St					:=trim(l.mail_st,left,right);			
			self.mail_Zip					:=if((integer)l.mail_ace_zip != 0,trim(l.mail_ace_zip,left,right),'');
			self							:=l;
			self							:=[];
end;


	dresponse 			:= project(dHF_filter ,tConvert2Response(left));
	
	dresponse_sort 		:= sort(dresponse,Source_Zip,sourceKey);
	
    temp_Lay  trfMerge_recID(temp_Lay  l ,temp_Lay  r)	:=	transform
      	
      	self.rec_ID	:= if (  l.rec_ID='',
								'1',
								if ( trim(l.sourceKey,left,right) = trim(r.sourceKey,left,right),
									l.rec_ID,
									(string)((integer)l.rec_ID + 1)
									)
								);
		
		self		:=	r;
	end;
      					   
        	dresponse_rid	:=	iterate(dresponse_sort, trfMerge_recID(left,right));
									
		FDS_Test.Layouts.Response.Fishing_Hunting_Extract	trfResponse(temp_Lay  l )	:=	transform
			self			:=	l;
		end;
		
		response 		:=dedup(sort(project(dresponse_rid,trfResponse(left)),(integer)rec_ID),rec_ID, keep(5));
		FDS_response    := sort(response,(integer)Source_Zip,(integer)rec_ID);

return if(pOverwrite,
		sequential(
		 output('Hunting/Fishing Extract Results Follow'	,named('__'							))
		,output(FDS_response,,'~thor_data400::out::FDS_Test::'+pversion+'::HuntFish_License::Extract',csv(separator(pSeparator),terminator('\n')),__compressed__,overwrite)
		//,output(choosen(dataset('~thor_data400::out::FDS_Test::'+pversion+'::HuntFish_License::Extract',Layouts.Response.Fishing_Hunting_Extract, csv(separator(pSeparator))),50000))
				 )
		,output(pversion+' Version already exist')
		);

end;