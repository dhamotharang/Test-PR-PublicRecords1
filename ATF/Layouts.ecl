import AID;
EXPORT Layouts := Module

	Export firearms_in:=record
		string9 Lic_Regn;
		string9 Lic_Dist;
		string9 Lic_Cnty;
		string9 Lic_Type;
		string11 Lic_Xprdte;
		string9 Lic_Seqn;
		string51 License_Name;
		string51 Business_Name;
		string51 Premise_Street;
		string28 Premise_City;
		string14 Premise_State;
		string17 Premise_Zip;
		string51 Mail_Street;
		string28 Mail_City;
		string11 Mail_State;
		string14 Mail_Zip_Code;
		string11 Voice_Phone;
	end;
	Export explosives_in:=record
   		string9	  Lic_Regn;
   		string9	  Lic_Dist;
   		string9	  Lic_Cnty;
   		string9	  Lic_Type;
   		string11	Lic_Xprdte;
   		string9	  Lic_Seqn;
   		string51	License_Name;
   		string51	Business_Name;
   		string51	Premise_Street;
   		string28	Premise_City;
   		string14	Premise_State;
   		string17	Premise_Zip;
   		string51	Mail_Street;
   		string24	Mail_City;
   		string11	Mail_State;
   		string14	Mail_Zip_Code;
   		string11	Voice_Phone;
   		end;	


	Export Temp:=record
		String60  Prepped_addr1:='';
		String35  Prepped_addr2:='';
		AID.Common.xAID		RawAID;	
		layout_firearms_explosives_in;
	end;
	
	export temp_rec:=record 
		temp;
		string1		license1_nametype	:= '';
    string1		license2_nametype	:= '';
    string5  	license3_title	:= '';       
   	string20 	license3_fname	:= '';     
    string20 	license3_mname	:= '';     
   	string20 	license3_lname	:= '';     
   	string5 	license3_name_suffix	:= ''; 
   	string51 	license3_cname	:= '';
		string1		license3_nametype	:= '';
   	string5 	license4_title	:= '';       
   	string20 	license4_fname	:= '';     
   	string20 	license4_mname	:= '';     
    string20 	license4_lname 	:= '';    
   	string5 	license4_name_suffix	:= ''; 
   	string51 	license4_cname	:= ''; 
   	string1  	license4_nametype	:= '';
   	end;	

end;