//Pass in your file and it returns your file with the phone type field appended.
// Example: YellowPages.NPA_PhoneType(MyFile,MyFile.phoneField,NewFile.phoneTypeFieldName,NewFile);
//LDS FLAG (defaulted to true) - LDS means Large Dataset. Definition of LDS Flag means that there are enough unique phones to spread across all nodes.

export NPA_PhoneType(infile,phone,param_PhoneType,outfile, lds = true) := macro
import Risk_Indicators, Gong_Neustar;
#uniquename(new_layout)
%new_layout% := record
  infile;
  string25 param_PhoneType;
  end;


#uniquename(tds)
#uniquename(s_tds)  
#uniquename(Toll_Free_Area_Codes)
//Check Telcordia TDS file for phonetypes
//------------------------------------------------------------------------------------------------
%tds%   := Risk_Indicators.File_Telcordia_tds ;
%s_tds% := dedup(sort(distribute(%tds%,hash(npa,nxx,tb)),npa,nxx,tb,-coctype,-ssc,local),npa,nxx,tb,local);
//------------------------------------------------------------------------------------------------
// Temporary 8xx (toll free) number set until NPA_Phone_type is fixed
%Toll_Free_Area_Codes% := ['800','811','822','833','844','855','866','877','888','899'];
//------------------------------------------------------------------------------------------------

#uniquename(t_getType)
#uniquename(j_getType)

%new_Layout% %t_getType%(infile L ,%s_tds% R) := transform
self.param_PhoneType := map(Cellphone.CleanPhones(L.phone)[1..3] in %Toll_Free_Area_Codes% or 
							regexfind('I',R.SSC) => 'FREE',
						map(R.COCType in ['EOC','PMC','RCC','SP1','SP2'] and 
						(regexfind('C',R.SSC) or
						regexfind('R',R.SSC) or
						regexfind('S',R.SSC)) => 'CELL',
					  
						regexfind('B',R.SSC) =>  'PAGE',
					  
						regexfind('N',R.SSC) =>  'POTS',
						
						regexfind('V',R.SSC) =>  'VOIP',
						
						regexfind('T',R.SSC) =>  'TIME',
						
						regexfind('W',R.SSC) =>  'WEATHER',
						
						regexfind('8',R.SSC) =>  'Puerto Rico/US Virgin Isl',''));
self := L;
end;

// #uniquename(j_getTypeS)
// #uniquename(j_getTypeL)

#if(~lds)
	%j_getType%   	:= join(distribute(infile, hash(phone)),%s_tds%,
					cellphone.cleanphones(left.phone)[1..7] = right.npa + right.nxx + right.tb,
					%t_getType%(left,right),left outer, skew(1.0)); 
#else					
	%j_getType%   	:= join(sort(distribute(infile,hash(Cellphone.CleanPhones(phone)[1..7])),Cellphone.CleanPhones(phone)[1..7],local),%s_tds%,
					cellphone.cleanphones(left.phone)[1..7] = right.npa + right.nxx + right.tb,

					%t_getType%(left,right),left outer, skew(1.0)); 
#end

//------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------
//Check Neustar file for phones that have been ported to cell

#uniquename(neustar)
#uniquename(t_getType2)
#uniquename(j_getType2)

%neustar% := distribute(CellPhone.fileNeuStar(CellPhone != ''),hash(CellPhone));

%j_getType% %t_getType2%(%j_getType% L ,%neustar% R) := transform
self.param_PhoneType := if(Cellphone.CleanPhones(L.phone) = R.cellphone,'LNDLN PRTD TO CELL',L.param_PhoneType);
self := L;
end;

#if(~lds)
%j_getType2%   	:= join(%j_getType%,%neustar%,
					cellphone.cleanphones(left.phone) = right.cellphone,
					%t_getType2%(left,right),left outer, skew(1.0)); 
#else
%j_getType2%   	:= join(%j_getType%,%neustar%,
					cellphone.cleanphones(left.phone) = right.cellphone,
					%t_getType2%(left,right),left outer, skew(1.0)); 
#end
//------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------
//Check current EDA file for active phones then label as POTS
#uniquename(currGong)
#uniquename(t_getType3)
#uniquename(j_getType3)
%currGong%:= distribute(dedup(Gong_Neustar.File_GongBase,phoneno,all),hash(phoneno));
%j_getType2% %t_getType3%(%j_getType2% L ,%currGong% R) := transform
self.param_PhoneType := if(Cellphone.CleanPhones(L.phone) = R.phoneno,'POTS',L.param_PhoneType);
self := L;
end;

#if(~lds)
%j_getType3%   	:= join(%j_getType2%,%currGong%,
					cellphone.cleanphones(left.phone) = right.phoneno,

					%t_getType3%(left,right),left outer, skew(1.0)); 
#else
%j_getType3%   	:= join(%j_getType2%,%currGong%,
					cellphone.cleanphones(left.phone) = right.phoneno,

					%t_getType3%(left,right),left outer, skew(1.0)); 
#end
//------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------
//validate npa,nxx,tb

#uniquename(tpm)
#uniquename(t_tpm)
#uniquename(goodnpanxx)

%tpm%  := dedup(
			sort(
				distribute(Risk_Indicators.File_Telcordia_tpm,hash(npa,nxx,tb)),
			npa,nxx,tb,local),
		npa,nxx,tb,local);


%j_getType3% %t_tpm%(%j_getType3% L ,%tpm% R) := transform
self.param_PhoneType := if(Cellphone.CleanPhones(L.phone)[1..3] in %Toll_Free_Area_Codes%, 'FREE',
															if(L.phone[1..7] = R.npa+R.nxx+R.tb,L.param_PhoneType,'INVALID-NPA/NXX/TB'));
self := L;
end;

%goodnpanxx%	:= join(%j_getType3%,%tpm%,
					left.phone[1..7]= right.npa+right.nxx+right.tb,
					%t_tpm%(left,right),left outer,lookup); 
outfile := %goodnpanxx% ;

endmacro;
	