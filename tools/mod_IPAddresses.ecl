import _control;
export mod_IPAddresses :=
module
	export iplayout :=
	record
	
		string servername {maxlength(1000)};
		string ipaddress {maxlength(1000)};
	
	end;
	
	export serversinfo := dataset([
		 {'edata10'					,_control.IPAddress.edata10					}
		,{'edata11'					,_control.IPAddress.edata11					}
		,{'edata11b'				,_control.IPAddress.edata11b				}
		,{'edata12'					,_control.IPAddress.edata12					}
		,{'edata14'					,_control.IPAddress.edata14					}
		,{'edata14a'				,_control.IPAddress.edata14a				}
		,{'edata15'					,_control.IPAddress.edata15					}
		,{'sdsmoxiedev01'		,_control.IPAddress.sdsmoxiedev01		}
		,{'tapeload01'			,_control.IPAddress.tapeload01			}
		,{'tapeload02'			,_control.IPAddress.tapeload02			}
		,{'tapeload02b'			,_control.IPAddress.tapeload02b			}
		,{'dataland_esp'		,_control.IPAddress.dataland_esp		}
		,{'dataland_dali'		,_control.IPAddress.dataland_dali		}
		,{'dataland_sasha'	,_control.IPAddress.dataland_sasha	}
		,{'prod_thor_esp'		,_control.IPAddress.prod_thor_esp		}
		,{'prod_thor_dali'	,_control.IPAddress.prod_thor_dali	}
		,{'prod_thor_sasha'	,_control.IPAddress.prod_thor_sasha	}
	],  iplayout );
	
	export fGetIPAddressFromServerName(string pServerName) :=
	function
		server 		:= serversinfo(regexfind('^' + pServerName + '$', servername,nocase))[1].ipaddress;
		
		ipaddress := if(server = '', pServerName, server);
		
		return ipaddress;
	end;
end;
