//identical to yellowpages.npa_phonetype except this one also returns the tds_state field
//batch uses the other, as of design i'm not sure how they'd be impacted to me changing the original one

export NPA_PhoneType_forSuppression(infile_pt,phone,param_PhoneType,outfile_pt) := macro
import cellphone, Risk_Indicators;

#uniquename(new_layout)
#uniquename(phone_string)
#uniquename(phone_string_cellphone)
%new_layout% := record
  infile_pt;
  string25 param_PhoneType;
  string2  tds_state;
  string10 %phone_string%;
  string10 %phone_string_cellphone%;
  end;

#uniquename(transform_for_string_phone)
#uniquename(project_for_string_phone)

%new_layout% %transform_for_string_phone%(infile_pt le) := transform
 self.%phone_string%           := (string)le.phone;
 self.%phone_string_cellphone% := cellphone.cleanphones(self.%phone_string%);
 self.param_phonetype          := '';
 self.tds_state                := '';
 self                          := le;
end;

%project_for_string_phone% := project(infile_pt,%transform_for_string_phone%(left));

#uniquename(tds)
#uniquename(s_tds)  
#uniquename(Toll_Free_Area_Codes)

//------------------------------------------------------------------------------------------------
%s_tds%   := Risk_Indicators.File_Telcordia_tds ;
//------------------------------------------------------------------------------------------------
// Temporary 8xx (toll free) number set until NPA_Phone_type is fixed
%Toll_Free_Area_Codes% := ['800','811','822','833','844','855','866','877','888','899'];
//------------------------------------------------------------------------------------------------

#uniquename(t_getType)
#uniquename(j_getType)

%new_Layout% %t_getType%(%project_for_string_phone% L ,%s_tds% R) := transform
self.param_PhoneType := map(L.%phone_string_cellphone%[1..3] in %Toll_Free_Area_Codes% or 
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
self.tds_state := r.state;
self := L;
end;


%j_getType%   	:= join(%project_for_string_phone%,%s_tds%,
					    left.%phone_string_cellphone%[1..7] = right.npa + right.nxx + right.tb,
					    %t_getType%(left,right),lookup,left outer); 
//------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------
//Check Neustar file for phones that have been ported to cell

#uniquename(neustar)
#uniquename(t_getType2)
#uniquename(j_getType2)

%neustar% := CellPhone.fileNeuStar;

%j_getType% %t_getType2%(%j_getType% L ,%neustar% R) := transform
self.param_PhoneType := if(L.%phone_string_cellphone% = R.cellphone,'LNDLN PRTD TO CELL',L.param_PhoneType);
self := L;
end;


%j_getType2%   	:= join(%j_getType%,%neustar%,
					left.%phone_string_cellphone% = right.cellphone,
					%t_getType2%(left,right),lookup,left outer); 
//------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------

outfile_pt := %j_getType2% ;

endmacro;