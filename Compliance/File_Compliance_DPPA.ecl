EXPORT File_Compliance_DPPA := 
	MODULE

			#OPTION('multiplePersistInstances',FALSE); 

			IMPORT Codes, MDR, ut, doxie;

			 rCodes_v3_key :=
				RECORD
					string35 file_name;  //identifies the dataset, or type of data
					string50 field_name;
					string5 field_name2;
					string15 code;
					string330 long_desc;
					unsigned8 __fpos;
				 END;

			//CodesV3Key: thor_data400::key::codes_v3_qa 
		export fCodes_v3_key := index(Codes.file_codes_v3_in,{file_name,field_name,field_name2,code,long_desc,__fpos},
																ut.foreign_prod+'thor_data400::key::codes_v3_'+doxie.Version_SuperKey);

			//output(MDR.SourceTools.set_DPPA_sources);
			//output(MDR.SourceTools.DPPAOriginState('FD'));
			//Mdr.sourcetools.fTranslateSource(src)  //This will get the definition/description for the source code
			//Mdr.sourcetools.sourceIsDPPA(src)
			//Mdr.sourcetools.SourceIsGLB(src)


		 layout_DPPA_Sources :=
				RECORD
					string2 source_code;
				END;

			//MDR.SourceTools.set_DPPA_sources	
		export file_DPPA_Sources :=	
				DATASET([{'^W'},{'DD'},{'FD'},{'JD'},{'ID'},{'KD'},{'PD'},{'AD'},{'CD'},{'ND'},{'MD'},{'QD'},{'HD'},{'ED'},{'BD'},{'GD'},{'OD'},{'RD'},{'SD'},{'TD'},{'WD'},{'VD'},{'YD'},{'1X'},{'2X'},{'3X'},{'4X'},{'5X'},{'6X'},{'7X'},{'8X'},{'9X'},{'ZX'},{'XX'},{'BX'},{'MA'},{'FV'},{'IV'},{'KV'},{'3V'},{'AV'},{'NV'},{'SV'},{'MV'},{'LV'},{'RV'},{'PV'},{'EV'},{'XV'},{'QV'},{'OV'},{'TV'},{'WV'},{'YV'},{'AE'},{'BE'},{'EE'},{'CE'},{'&E'},{'$E'},{'GE'},{'JE'},{'IE'},{'KE'},{'LE'},{'NE'},{'ME'},{'RE'},{'PE'},{'VE'},{'YE'},{'XE'},{'ZE'},{'@E'},{'HE'},{'+E'},{'?E'},{'QE'},{'!E'},{'OE'},{'=E'},{'SE'},{'TE'},{'.E'},{'UE'},{'WE'},{'#E'},{'#W'},{'LW'},{'RW'},{'ZW'},{'CW'},{'EW'},{'FW'},{'GW'},{'IW'},{'PW'},{'HW'},{'KW'},{'JW'},{'DW'},{'QW'},{'XW'},{'1W'},{'BW'},{'2W'},{'3W'},{'NW'},{'4W'},{'5W'},{'6W'},{'7W'},{'YW'},{'OW'},{'8W'},{'SW'},{'TW'},{'[W'},{'9W'},{'VW'},{'WW'},{'!W'},{'@W'},{'(W'},{'$W'},{')W'},{'VA'}
/*								[{'^W'},
									{'DD'},
									{'FD'},
									{'JD'},
									{'ID'},
									{'KD'},
									{'PD'},
									{'AD'},
									{'CD'},
									{'ND'},
									{'MD'},
									{'ED'},
									{'BD'},
									{'GD'},
									{'OD'},
									{'RD'},
									{'SD'},
									{'TD'},
									{'WD'},
									{'VD'},
									{'YD'},
									{'1X'},
									{'2X'},
									{'3X'},
									{'4X'},
									{'5X'},
									{'6X'},
									{'7X'},
									{'8X'},
									{'9X'},
									{'ZX'},
									{'XX'},
									{'BX'},
									{'MA'},
									{'FV'},
									{'IV'},
									{'KV'},
									{'3V'},
									{'AV'},
									{'NV'},
									{'SV'},
									{'MV'},
									{'LV'},
									{'RV'},
									{'PV'},
									{'EV'},
									{'XV'},
									{'QV'},
									{'OV'},
									{'TV'},
									{'WV'},
									{'YV'},
									{'AE'},
									{'BE'},
									{'EE'},
									{'CE'},
									{'&E'},
									{'$E'},
									{'GE'},
									{'JE'},
									{'IE'},
									{'KE'},
									{'LE'},
									{'NE'},
									{'ME'},
									{'RE'},
									{'PE'},
									{'VE'},
									{'YE'},
									{'XE'},
									{'ZE'},
									{'@E'},
									{'HE'},
									{'+E'},
									{'?E'},
									{'QE'},
									{'!E'},
									{'OE'},
									{'=E'},
									{'SE'},
									{'TE'},
									{'.E'},
									{'UE'},
									{'WE'},
									{'#E'},
									{'#W'},
									{'LW'},
									{'RW'},
									{'ZW'},
									{'CW'},
									{'EW'},
									{'FW'},
									{'GW'},
									{'IW'},
									{'PW'},
									{'HW'},
									{'KW'},
									{'JW'},
									{'DW'},
									{'QW'},
									{'XW'},
									{'1W'},
									{'BW'},
									{'2W'},
									{'3W'},
									{'NW'},
									{'4W'},
									{'5W'},
									{'6W'},
									{'7W'},
									{'YW'},
									{'OW'},
									{'8W'},
									{'SW'},
									{'TW'},
									{'[W'},
									{'9W'},
									{'VW'},
									{'WW'},
									{'!W'},
									{'@W'},
									{'(W'},
									{'$W'},
									{')W'},
									{'VA'}
*/									
						],	
				layout_DPPA_Sources)
			//			 :PERSIST('~thor400_92::persist::compliance::file_DPPA_Sources')
						 ;
						 
			//OUTPUT(file_DPPA_Sources);			 


		shared layout_DPPA_Sources_V2 :=
				RECORD
//					boolean is_GLB := false;
					boolean is_DPPA := true;
					string2 source_code;
					string state_code := '';
					string src_translation := '';
				END;
				
			layout_DPPA_Sources_V2 xfmSources(file_DPPA_Sources LE) :=
					TRANSFORM
						self.source_code := TRIM(LE.source_code);
						
//						self.is_GLB := Mdr.sourcetools.sourceIsGLB(self.source_code);
						self.is_DPPA := Mdr.sourcetools.sourceIsDPPA(self.source_code);
						self.state_code := Mdr.sourcetools.DPPAOriginState(self.source_code);
						self.src_translation := Mdr.sourcetools.fTranslateSource(self.source_code);
						
						self := LE;
					END;
					
		export rs_DPPA_Sources := PROJECT(file_DPPA_Sources, xfmSources(LEFT));

			//OUTPUT(rs_DPPA_Sources);


		export layout_DPPA_Uses :=
				RECORD
					layout_DPPA_Sources_V2;
					string codesV3_state := '';
					string codesV3_code := '';
					string DPPA_restriction := '';
				END;
				

			layout_DPPA_Uses xfmDPPAUses(fCodes_v3_key LE, rs_DPPA_Sources RI) :=
				TRANSFORM
					self.codesV3_state := LE.field_name2;
					self.codesV3_code := LE.code;
					self.DPPA_restriction := LE.long_desc;
					
					self.is_DPPA := true;
					
					SELF := LE;
					SELF := RI;
				END;


		export file_DPPA_Uses := JOIN(DEDUP(sort(distribute(fCodes_v3_key(file_name IN ['GENERAL'] AND REGEXFIND('(DL|PURPOSE)', field_name)), hash(field_name2)), field_name2,code, local), field_name2,code, ALL,local)
														,sort(distribute(rs_DPPA_Sources, hash(state_code)), state_code, local)
														,TRIM(left.field_name2) = TRIM(right.state_code)
														,xfmDPPAUses(left,right)
														,LEFT OUTER
														):PERSIST('~thor400_92::persist::compliance::file_DPPA_restricted')
														;

			//OUTPUT(sort(file_DPPA_Uses, state_code,codesV3_state,codesV3_code), ALL); 

			//---------------------------------------------------------------------------------------------
						
		export layout_Compliance_DPPA_Uses :=
				RECORD
					string DataSrc := '';
					string DPPA_Name := '';
					string DPPA_Code_LN := '';
					string DPPA_Desc := '';
					
				END;		
				
		export file_Compliance_DPPA_Uses :=	
				DATASET([
									{'PRMA LEXIS','GOVT','1','Court, Law Enforcement, or Government Agencies'},
									{'PRMA LEXIS','VEHICLE','2','Motor Vehicle Safety or Theft'},	//May 2015
									{'PRMA LEXIS','DEBT_FRAUD','3','Normal Course of Business'},
									{'PRMA LEXIS','LITIGATION','4','Civil, Criminal, Administrative, or Arbitral Proceedings'},
									{'PRMA LEXIS','INSURER','6','Insurance'},
									{'PRMA LEXIS','AGENCY','7','Licensed Private Investigative or Security Services'},
									{'PRMA LEXIS','NONE','0','No Permissible Purpose'},
									{'PRMA LEXIS','','0','No Permissible Purpose'},
									{'CREDITPORTAL','GOVT','1','Court, Law Enforcement, or Government Agencies'},
									{'CREDITPORTAL','DEBT_FRAUD','3','Normal Course of Business'},
									{'CREDITPORTAL','LITIGATION','4','Civil, Criminal, Administrative, or Arbitral Proceedings'},
									{'CREDITPORTAL','INSURER','6','Insurance'},
									{'CREDITPORTAL','AGENCY','7','Licensed Private Investigative or Security Services'},
									{'CREDITPORTAL','NONE','0','No Permissible Purpose'},
									{'CREDITPORTAL','','0','No Permissible Purpose'},
									{'BOCA','DPPA_VEHICLE','2','Motor Vehicle Safety or Theft'},
									{'BOCA','DPPA_BUSINESS','3','Normal Course of Business'},
									{'BOCA','DPPA_LITIGATION','4','Civil, Criminal, Administrative, or Arbitral Proceedings'},
									{'BOCA','DPPA_COMMLICENSE','5','Commercial Drivers License'},
									{'BOCA','DPPA_AGENCY','7','Licensed Private Investigative or Security Services'},
									{'BOCA','DPPA_PRIVINVEST','7','Licensed Private Investigative or Security Services'}
							],	
				layout_Compliance_DPPA_Uses)
						 :PERSIST('~thor400_92::persist::compliance::file_Compliance_DPPA_Uses')
						 ;
						 
			//OUTPUT(file_Compliance_DPPA_Uses, ALL);			 
	END;