#OPTION('multiplePersistInstances', FALSE);
filedate := '20160209';
version  := '20160216';
puseprod := true;
//sequential(corp2_mapping.SC.Update('20160209','20160315',false,true));
state_origin			 			:= 'SC';
state_fips	 				 		:= '45';
state_desc	 			 			:= 'SOUTH CAROLINA';

CorpFileRaw							:= Corp2_Raw_SC.Files(fileDate,puseprod).input.CorpFile.logical;
CorpFile			 					:= sort(distribute(CorpFileRaw,hash(corpid)),corpid,local) 			: independent;

IsBadAddress					  := CorpFile.agentaddress1<>'' and CorpFile.agentaddress2='' and CorpFile.agentcity='' and CorpFile.agentstate = '';
BadAddresses						:= CorpFile(IsBadAddress);
//FilteredBadAddresses 		:= BadAddresses(regexfind('TWO SHELTER CTR GRNVL',agentaddress1,0)<>'');
//output(FilteredBadAddresses,named('FilteredBadAddresses'));

CorpFixedAddresses  	  := project(BadAddresses, 
																	 transform(Corp2_Raw_SC.Layouts.CorpFileLayoutIn,
																						 self.agentname			:= left.agentaddress1;
																						 self.agentaddress1 := Corp2_Raw_SC.Functions.Address(state_origin,state_desc,left.agentaddress1).addr;
																						 self.agentcity 		:= Corp2_Raw_SC.Functions.Address(state_origin,state_desc,left.agentaddress1).city;
																						 self.agentstate		:= Corp2_Raw_SC.Functions.Address(state_origin,state_desc,left.agentaddress1).state;
																						 self.agentzip		  := Corp2_Raw_SC.Functions.Address(state_origin,state_desc,left.agentaddress1).zip;
																						 self.incstate			:= Corp2_Raw_SC.Functions.State_or_Country(left.incstate);
																						 self 							:= left;
																						)
																	);	

output(CorpFixedAddresses,named('CorpFixedAddresses'));
MoreBadAddresses := CorpFixedAddresses(agentcity in ['SC','PLEASANT','BEACH','ISLAND','ISL']);
output(MoreBadAddresses,named('MoreBadAddresses'));
output(count(MoreBadAddresses),named('cntMoreBadAddresses'));
