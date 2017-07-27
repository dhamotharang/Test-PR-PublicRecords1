export ECLWatch_URL
 :=
  module
	export	string	WU_Details							:=	'http://' + _Control.ThisEnvironment.ESP_IPAddress	+ ':' + _Control.PortAddress.esp_html + '/?inner=../WsWorkunits/WUInfo?Wuid=' + workunit;
 	export	string	DFU_WU_Details(string pWorkUnit)	:=	'http://' + _Control.ThisEnvironment.ESP_IPAddress	+ ':' + _Control.PortAddress.esp_html + '/?inner=/FileSpray/GetDFUWorkunit?wuid=' + pWorkUnit;
  end
 ;
