IMPORT Business_Risk_BIP, STD;


EXPORT RegularExpressions := MODULE

EXPORT CONSTRUCTION_EXPR := '\\b(^construction|^construction\\s+|(\\s*\\bconstruction\\b\\s*).*$|' +
                              '^constructio|^constructio\\s+|(\\s*\\bconstructio\\b\\s*).*$|' +
                              '^construc|^construc\\s+|(\\s*\\bconstruc\\b\\s*).*$|' +
                              '^constructi|^constructi\\s+|(\\s*\\bconstructi\\b\\s*).*$|' +
                              '^contruction|^contruction\\s+|(\\s\\bcontruction\\b\\s*).*$|' +
                              '^construct|^construct\\s+|(\\s*\\bconstruct\\b\\s*).*$|' +
                              '^constructions|^constructions\\s+|(\\s*\\bconstructions\\b\\s*).*$|'  +
                              '^constuction|^constuction\\s+|(\\s*\\bconstuction\\b\\s*).*$|'  +
                              '^constructon|^constructon\\s+|(\\s*\\bconstructon\\b\\s*).*$|'  +
                              '^construcion|^construcion\\s+|(\\s*\\bconstrucion\\b\\s*).*$|'  + 
                              '^constrution|^constrution\\s+|(\\s*\\bconstrution\\b\\s*).*$|'  + 
                              '^constracting|^constracting\\s+|(\\s*\\bconstracting\\b\\s*).*$|'  + 
                              '^constructn|^constructn\\s+|(\\s*\\bconstructn\\b\\s*).*$|' + 
                              '^costruction|^costruction\\s+|(\\s*\\bcostruction\\b\\s*).*$|'  + 
                              '^constrction|^constrction\\s+|(\\s*\\bconstrction\\b\\s*).*$|' + 
                              '^constructin|^constructin\\s+|(\\s*\\bconstructin\\b\\s*).*$|'  + 
                              '^consruction|^consruction\\s+|(\\s*\\bconsruction\\b\\s*).*$)\\b';
                              
  // EXPORT CONSTRUCTION_EXPR := '(\\s*\\bconstruction\\b\\s*).*$|' +
                              // '(\\s*\\bconstructio\\b\\s*).*$|' +
                              // '(\\s*\\bconstruc\\b\\s*).*$|' +
                              // '(\\s*\\bconstructi\\b\\s*).*$|' +
                              // '(\\s*\\bcontruction\\b\\s*).*$|' +
                              // '^(\\s*\\bconstruct\\b\\s*).*$|' +
                              // '(\\s*\\bconstructions\\b\\s*).*$|' +
                              // '(\\s*\\bconstuction\\b\\s*).*$|' +
                              // '(\\s*\\bconstructon\\b\\s*).*$|' +
                              // '(\\s*\\bconstrucion|\\b\\s*).*$|' +
                              // '(\\s*\\bconstrution\\b\\s*).*$|' +
                              // '(\\s*\\bconstracting\\b\\s*).*$|' +
                              // '(\\s*\\bconstructn\\b\\s*).*$|' + 
                              // '(\\s*\\bcostruction\\b\\s*).*$|' +
                              // '(\\s*\\bconstrction\\b\\s*).*$|' +
                              // '(\\s*\\bconstructin\\b\\s*).*$|' +
                              // '(\\s*\\bconsruction\\b\\s*).*$';
                              
  EXPORT PROPERTY_EXPR := '\\b(^properties|^properties\\s+|(\\s*\\bproperties\\b\\s*).*$|' +
                          '^property|^property\\s+|(\\s*\\bproperty\\b\\s*).*$|' +
                          '^properti|^properti\\s+|(\\s*\\bproperti\\b\\s*).*$|' +
                          '^propertie|^propertie\\s+|(\\s*\\bpropertie\\b\\s*).*$|' +
                          '^propeties|^propeties\\s+|(\\s*\\bpropeties\\b\\s*).*$|' +
                          '^propertys|^propertys\\s+|(\\s*\\bpropertys\\b\\s*).*$|' +
                          '^propertis|^propertis\\s+|(\\s*\\bpropertis\\b\\s*).*$|' +
                          '^properies|^properies\\s+|(\\s*\\bproperies\\b\\s*).*$|' +
                          '^proerties|^proerties\\s+|(\\s*\\b^proerties\\b\\s*).*$|' +
                          '^prperties|^prperties\\s+|(\\s*\\bprperties\\b\\s*).*$|' +
                          '^propertes|^propertes\\s+|(\\s*\\bpropertes\\b\\s*).*$|' +
                          '^prperty|^prperty\\s+|(\\s*\\bprperty\\b\\s*).*$|' +
                          '^properities|^properities\\s+|(\\s*\\bproperities\\b\\s*).*$|' +
                          '^propety|^propety\\s+|(\\s*\\bpropety\\b\\s*).*$|' +
                          '^proprty|^proprty\\s+|(\\s*\\bproprty\\b\\s*).*$|' +
                          '^proprties|^proprties\\s+|(\\s*\\bproprties\\b\\s*).*$)\\b';
                          
  EXPORT TRUCK_EXPR := '\\b(^trucking|^trucking\\s+|(\\s*\\btrucking\\b\\s*).*$|' +
                       '^truck|^truck\\s+|(\\s*\\btruck\\b\\s*).*$|' +
                       '^trucks|^trucks\\s+|(\\s*\\btrucks\\b\\s*).*$|' +
                       '^truckin|^truckin\\s+|(\\s*\\btruckin\\b\\s*).*$|' +
                       '^truc|^truc\\s+|(\\s*\\btruc\\b\\s*).*$|' +
                       '^trucker|^trucker\\s+|(\\s*\\btrucker\\b\\s*).*$)\\b';
                     
 EXPORT REALTY_EXPR := '\\b(^realty|^realty\\s+|(\\s*\\brealty\\b\\s*).*$|' +
                       '^reality|^reality\\s+|(\\s*\\breality\\b\\s*).*$|' +
                       '^realties|^realties\\s+|(\\s*\\brealties\\b\\s*).*$|' +
                       '^realtor|^realtor\\s+|(\\s*\\brealtor\\b\\s*).*$)\\b';

  EXPORT INSURANCE_EXPR := '\\b(^insurance|^insurance\\s+|(\\s*\\binsurance\\b\\s*).*$|' +
                       '^insur|^insur\\s+|(\\s*\\binsur\\b\\s*).*$|' +
                       '^insuranc|^insuranc\\s+|(\\s*\\binsuranc\\b\\s*).*$|' +
                       '^insured|^insured\\s+|(\\s*\\binsured\\b\\s*).*$|' +
                       '^insurers|^insurers\\s+|(\\s*\\binsurers\\b\\s*).*$|' +
                       '^insure|^insure\\s+|(\\s*\\binsure\\b\\s*).*$|' +
                       '^insurer|^insurer\\s+|(\\s*\\binsurer\\b\\s*).*$)\\b';

  EXPORT HOLDINGS_EXPR := '\\b(^holdings|^holdings\\s+|(\\s*\\bholdings\\b\\s*).*$|' +
                          '^holding|^holding\\s+|(\\s*\\bholding\\b\\s*).*$|' +
                          '^hold|^hold\\s+|(\\s*\\bhold\\b\\s*).*$|' +
                          '^holdin|^holdin\\s+|(\\s*\\bholdin\\b\\s*).*$|' +
                          '^holdins|^holdins\\s+|(\\s*\\bholdins\\b\\s*).*$)\\b';

  EXPORT INVESTMENT_EXPR := '\\b(^investments|^investments\\s+|(\\s*\\binvestments\\b\\s*).*$|' +
                          '^investment|^investment\\s+|(\\s*\\binvestment\\b\\s*).*$|' +
                          '^invest|^invest\\s+|(\\s*\\binvest\\b\\s*).*$|' +
                          '^investing|^investing\\s+|(\\s*\\binvesting\\b\\s*).*$|' +
                          '^investors|^investors\\s+|(\\s*\\binvestors\\b\\s*).*$|' +
                          '^investor|^investor\\s+|(\\s*\\binvestor\\b\\s*).*$|' +
                          '^investing|^investing\\s+|(\\s*\\binvesting\\b\\s*).*$|' + 
                          '^investment|^investment\\s+|(\\s*\\binvestment\\b\\s*).*$|' +
                          '^investmen|^investmen\\s+|(\\s*\\binvestmen\\b\\s*).*$|' +
                          '^invesments|^invesments\\s+|(\\s*\\binvesments\\b\\s*).*$|' +
                          '^invesment|^invesment\\s+|(\\s*\\binvesment\\b\\s*).*$|' +
                          '^investements|^investements\\s+|(\\s*\\binvestements\\b\\s*).*$|' +
                          '^invetments|^invetments\\s+|(\\s*\\binvetments\\b\\s*).*$|' +
                          '^investmens|^investmens\\s+|(\\s*\\binvestmens\\b\\s*).*$|' +
                          '^invstments|^invstments\\s+|(\\s*\\binvstments\\b\\s*).*$|' +
                          '^invests|^invests\\s+|(\\s*\\binvests\\b\\s*).*$|' +
                          '^investmnts|^investmnts\\s+|(\\s*\\binvestmnts\\b\\s*).*$|' +
                          '^investement|^investement\\s+|(\\s*\\binvestement\\b\\s*).*$|' +
                          '^investmnt|^investmnt\\s+|(\\s*\\binvestmnt\\b\\s*).*$)\\b'; 

  EXPORT TRANSPORT_EXPR := '\\b(^transport|^transport\\s+|(\\s*\\btransport\\b\\s*).*$|' +
                          '^transportation|^transportation\\s+|(\\s*\\btransportation\\b\\s*).*$|' +
                          '^transports|^transports\\s+|(\\s*\\btransports\\b\\s*).*$|' +
                          '^transporation|^transporation\\s+|(\\s*\\btransporation\\b\\s*).*$|' +
                          '^transporters|^transporters\\s+|(\\s*\\btransporters\\b\\s*).*$|' +
                          '^transportaion|^transportaion\\s+|(\\s*\\btransportaion\\b\\s*).*$|' +
                          '^transporting|^transporting\\s+|(\\s*\\btransporting\\b\\s*).*$|' +
                          '^transportatio|^transportatio\\s+|(\\s*\\btransportatio\\b\\s*).*$|' +
                          '^transpor|^transpor\\s+|(\\s*\\btranspor\\b\\s*).*$)\\b';
                          
  EXPORT FARM_EXPR :=     '\\b(^farm|^farm\\s+|(\\s*\\bfarm\\b\\s*).*$|' +
                          '^farms|^farms\\s+|(\\s*\\bfarms\\b\\s*).*$|' +
                          '^farming|^farming\\s+|(\\s*\\bfarming\\b\\s*).*$|' +
                          '^farmers|^farmers\\s+|(\\s*\\bfarmers\\b\\s*).*$|' +
                          '^farmer|^farmer\\s+|(\\s*\\bfarmer\\b\\s*).*$)\\b';

  EXPORT PAINT_EXPR :=    '\\b(^painting|^painting\\s+|(\\s*\\bpainting\\b\\s*).*$|' +
                          '^paint|^paint\\s+|(\\s*\\bpaint\\b\\s*).*$|' +
                          '^paints|^paints\\s+|(\\s*\\bpaints\\b\\s*).*$|' +
                          '^painted|^painted\\s+|(\\s*\\bpainted\\b\\s*).*$|' +
                          '^painter|^painter\\s+|(\\s*\\bpainter\\b\\s*).*$|' +
                          '^paintings|^paintings\\s+|(\\s*\\bpaintings\\b\\s*).*$|' +
                          '^paintin|^paintin\\s+|(\\s*\\bpaintin\\b\\s*).*$)\\b';
                          
  EXPORT RESTAURANT_EXPR := '\\b(^restaurant|^restaurant\\s+|(\\s*\\brestaurant\\b\\s*).*$|' +
                          '^restaurants|^restaurants\\s+|(\\s*\\brestaurants\\b\\s*).*$|' +
                          '^restaurante|^restaurante\\s+|(\\s*\\brestaurante\\b\\s*).*$|' +
                          '^resturant|^resturant\\s+|(\\s*\\bresturant\\b\\s*).*$|' +
                          '^restaur|^restaur\\s+|(\\s*\\brestaur\\b\\s*).*$|' +
                          '^restauran|^restauran\\s+|(\\s*\\brestauran\\b\\s*).*$|' +
                          '^restaurnt|^restaurnt\\s+|(\\s*\\brestaurnt\\b\\s*).*$)\\b';
                          
  EXPORT CONSULT_EXPR   := '\\b(^consulting|^consulting\\s+|(\\s*\\bconsulting\\b\\s*).*$|' +
                          '^consultants|^consultants\\s+|(\\s*\\bconsultants\\b\\s*).*$|' +
                          '^consultant|^consultant\\s+|(\\s*\\bconsultant\\b\\s*).*$|' +
                          '^consult|^consult\\s+|(\\s*\\bconsult\\b\\s*).*$|' +
                          '^consultancy|^consultancy\\s+|(\\s*\\bconsultancy\\b\\s*).*$|' +
                          '^consultation|^consultation\\s+|(\\s*\\bconsultation\\b\\s*).*$|' +
                          '^consultin|^consultin\\s+|(\\s*\\bconsultin\\b\\s*).*$|' +
                          '^consultations|^consultations\\s+|(\\s*\\bconsultations\\b\\s*).*$|' +
                          '^cnsulting|^cnsulting\\s+|(\\s*\\bcnsulting\\b\\s*).*$|' +
                          '^consultng|^consultng\\s+|(\\s*\\bconsultng\\b\\s*).*$)\\b';
                          
  EXPORT PLUMB_EXPR     := '\\b(^plumbing|^plumbing\\s+|(\\s*\\bplumbing\\b\\s*).*$|' +
                          '^plumb|^plumb\\s+|(\\s*\\bplumb\\b\\s*).*$|' +
                          '^plumbling|^plumbling\\s+|(\\s*\\bplumbling\\b\\s*).*$|' +
                          '^pluming|^pluming\\s+|(\\s*\\bpluming\\b\\s*).*$|' +
                          '^plumbin|^plumbin\\s+|(\\s*\\bplumbin\\b\\s*).*$|' +
                          '^plumber|^plumber\\s+|(\\s*\\bplumber\\b\\s*).*$)\\b'; 
                          
  EXPORT LANDSCAPE_EXPR := '\\b(^landscape|^landscape\\s+|(\\s*\\blandscape\\b\\s*).*$|' +
                          '^landscaping|^landscaping\\s+|(\\s*\\blandscaping\\b\\s*).*$|' +
                          '^landscapes|^landscapes\\s+|(\\s*\\blandscapes\\b\\s*).*$|' +
                          '^landscap|^landscap\\s+|(\\s*\\blandscap\\b\\s*).*$|' +
                          '^lanscaping|^lanscaping\\s+|(\\s*\\blanscaping\\b\\s*).*$|' +
                          '^landscapi|^landscapi\\s+|(\\s*\\blandscapi\\b\\s*).*$' +
                          '^landscapin|^landscapin\\s+|(\\s*\\blandscapin\\b\\s*).*$' +
                          '^landscapers|^landscapers\\s+|(\\s*\\blandscapers\\b\\s*).*$|' +
                          '^lanscape|^lanscape\\s+|(\\s*\\blanscape\\b\\s*).*$|' +
                          '^landscaper|^landscaper\\s+|(\\s*\\blandscaper\\b\\s*).*$)\\b'; 

  EXPORT LAWN_EXPR      := '\\b(^lawn|^lawn\\s+|(\\s*\\blawn\\b\\s*).*$|' +
                          '^lawns\\s+|(\\s*\\blawns\\b\\s*).*$)\\b';
  
  EXPORT ELECTRIC_EXPR  := '\\b(^electric|^electric\\s+|(\\s*\\belectric\\b\\s*).*$|' +
                          '^electrical|^electrical\\s+|(\\s*\\belectrical\\b\\s*).*$|' +
                          '^electri|^electri\\s+|(\\s*\\belectri\\b\\s*).*$|' +
                          '^electr|^electr\\s+|(\\s*\\belectr\\b\\s*).*$|' +
                          '^electrica|^electrica\\s+|(\\s*\\belectrica\\b\\s*).*$|' +
                          '^eletric|^eletric\\s+|(\\s*\\beletric\\b\\s*).*$|' +
                          '^electic|^electic\\s+|(\\s*\\belectic\\b\\s*).*$|' +
                          '^electricity|^electricity\\s+|(\\s*\\belectricity\\b\\s*).*$|' +
                          '^electrc|^electrc\\s+|(\\s*\\belectrc\\b\\s*).*$|' +
                          '^elctric|^elctric\\s+|(\\s*\\belctric\\b\\s*).*$|' +
                          '^electricial|^electricial\\s+|(\\s*\\belectricial\\b\\s*).*$|' +
                          '^elecric|^elecric\\s+|(\\s*\\belecric\\b\\s*).*$|' +
                          '^lectric|^lectric\\s+|(\\s*\\blectric\\b\\s*).*$|' +
                          '^electical|^electical\\s+|(\\s*\\belectical\\b\\s*).*$|' +
                          '^electrics|^electrics\\s+|(\\s*\\belectrics\\b\\s*).*$|' +
                          '^electrial|^electrial\\s+|(\\s*\\belectrial\\b\\s*).*$)\\b';
                          
  EXPORT BUILDER_EXPR :=  '\\b(^builders|^builders\\s+|(\\s*\\bbuilders\\b\\s*).*$|' +
                          '^builder|^builder\\s+|(\\s*\\bbuilder\\b\\s*).*$|' +
                          '^builde|^builde\\s+|(\\s*\\bbuilde\\b\\s*).*$|' +
                          '^buildrs|^buildrs\\s+|(\\s*\\bbuildrs\\b\\s*).*$|' +
                          '^building|^building\\s+|(\\s*\\bbuilding\\b\\s*).*$|' +
                          '^buildings|^buildings\\s+|(\\s*\\bbuildings\\b\\s*).*$|' +
                          '^build|^build\\s+|(\\s*\\bbuild\\b\\s*).*$|' +
                          '^builder|^builder\\s+|(\\s*\\bbuilder\\b\\s*).*$)\\b';
                          
  EXPORT MANAGER_EXPR :=  '\\b(^management|^management\\s+|(\\s*\\bmanagement\\b\\s*).*$|' +
                          '^managers|^managers\\s+|(\\s*\\bmanagers\\b\\s*).*$|' +
                          '^managment|^managment\\s+|(\\s*\\bmanagment\\b\\s*).*$|' +
                          '^manager|^manager\\s+|(\\s*\\bmanager\\b\\s*).*$|' +
                          '^managed|^managed\\s+|(\\s*\\bmanaged\\b\\s*).*$|' +
                          '^managem|^managem\\s+|(\\s*\\bmanagem\\b\\s*).*$|' +
                          '^managing|^managing\\s+|(\\s*\\bmanaging\\b\\s*).*$|' +
                          '^manag|^manag\\s+|(\\s*\\bmanag\\b\\s*).*$|' +
                          '^mangement|^mangement\\s+|(\\s*\\bmangement\\b\\s*).*$|' +
                          '^managements|^managements\\s+|(\\s*\\bmanagements\\b\\s*).*$|' +
                          '^manangement|^manangement\\s+|(\\s*\\bmanangement\\b\\s*).*$|' +
                          '^managemnt|^managemnt\\s+|(\\s*\\bmanagemnt\\b\\s*).*$)\\b';

  EXPORT MORTGAGE_EXPR := '\\b(^mortgage|^mortgage\\s+|(\\s*\\bmortgage\\b\\s*).*$|' +
                          '^mortgages|^mortgages\\s+|(\\s*\\bmortgages\\b\\s*).*$|' +
                          '^mortage|^mortage\\s+|(\\s*\\bmortage\\b\\s*).*$|' +
                          '^mortgag|^mortgag\\s+|(\\s*\\bmortgag\\b\\s*).*$|' +
                          '^morgage|^morgage\\s+|(\\s*\\bmorgage\\b\\s*).*$)\\b';
                          
  EXPORT FINANCIAL_EXPR := '\\b(^financial|^financial\\s+|(\\s*\\bfinancial\\b\\s*).*$|' +
                          '^financia|financia\\s+|(\\s*\\bfinancia\\b\\s*).*$|' +
                          '^finacial|finacial\\s+|(\\s*\\bfinacial\\b\\s*).*$|' +
                          '^fiancial|fiancial\\s+|(\\s*\\bfiancial\\b\\s*).*$|' +
                          '^financials|^financials\\s+|(\\s*\\bfinancials\\b\\s*).*$|' +
                          '^fianancial|^fianancial\\s+|(\\s*\\bfianancial\\b\\s*).*$|' +
                          '^financal|^financal\\s+|(\\s*\\bfinancal\\b\\s*).*$|' +
                          '^finanacial|^finanacial\\s+|(\\s*\\bfinanacial\\b\\s*).*$)\\b';
                          
  EXPORT ESTATE_EXPR    := '\\b(^estate|^estate\\s+|(\\s*\\bestate\\b\\s*).*$|' +
                          '^estates|^estates\\s+|(\\s*\\bestates\\b\\s*).*$|' +
                          '^estat|^estat\\s+|(\\s*\\bestat\\b\\s*).*$|' +
                          '^esate|^esate\\s+|(\\s*\\besate\\b\\s*).*$)\\b';

  EXPORT HOME_EXPR      := '\\b(^home|^home\\s+|(\\s*\\bhome\\b\\s*).*$|' +
                          '^homes|^homes\\s+|(\\s*\\bhomes\\b\\s*).*$|' +
                          '^hommes|^hommes\\s+|(\\s*\\bhommes\\b\\s*).*$)\\b';
                          
  EXPORT BANK_EXPR      := '\\b(^bank|^bank\\s+|(\\s*\\bbank\\b\\s*).*$|' +
                          '^banking|^banking\\s+|(\\s*\\bbanking\\b\\s*).*$|' +
                          '^banker|^banker\\s+|(\\s*\\bbanker\\b\\s*).*$)\\b';
                          
  EXPORT CHURCH_EXPR    := '\\b(^church|^church\\s+|(\\s*\\bchurch\\b\\s*).*$|' +
                          '^churc|^churc\\s+|(\\s*\\bchurc\\b\\s*).*$|' +
                          '^churches|^churches\\s+|(\\s*\\bchurches\\b\\s*).*$|' +
                          '^churchs|^churchs\\s+|(\\s*\\bchurchs\\b\\s*).*$|' +
                          '^chuch|^chuch\\s+|(\\s*\\bchuch\\b\\s*).*$)\\b';
                          
  EXPORT CONTRACT_EXPR  := '\\b(^contracting|^contracting\\s+|(\\s*\\bcontracting\\b\\s*).*$|' +
                          '^contract|^contract\\s+|(\\s*\\bcontract\\b\\s*).*$|' +
                          '^contracto|^contracto\\s+|(\\s*\\bcontracto\\b\\s*).*$|' +
                          '^contrac|^contrac\\s+|(\\s*\\bcontrac\\b\\s*).*$|' +
                          '^contracts|^contracts\\s+|(\\s*\\bcontracts\\b\\s*).*$|' +
                          '^contractor|^contractor\\s+|(\\s*\\bcontractor\\b\\s*).*$|' +
                          '^contractors|^contractors\\s+|(\\s*\\bcontractors\\b\\s*).*$|' +
                          '^contractor|^contractor\\s+|(\\s*\\bcontractor\\b\\s*).*$|' +
                          '^constractors|^constractors\\s+|(\\s*\\bconstractors\\b\\s*).*$)\\b';
                          
  EXPORT APTMENT_EXPR   := '\\b(^apartments|^apartments\\s+|(\\s*\\bapartments\\b\\s*).*$|' +
                          '^apartment\\s+|(\\s*\\bapartment\\b\\s*).*$|' +
                          '^apartmen|^apartment\\s+|(\\s*\\bapartmen\\b\\s*).*$|' +
                          '^aprtments|^aprtments\\s+|(\\s*\\baprtments\\b\\s*).*$|' +
                          '^appartments|^appartments\\s+|(\\s*\\bappartments\\b\\s*).*$|' +
                          '^apartm|^apartm\\s+|(\\s*\\bapartm\\b\\s*).*$)\\b';

  EXPORT ROOF_EXPR      := '\\b(^roofing|^roofing\\s+|(\\s*\\broofing\\b\\s*).*$|' +
                          '^roof|^roof\\s+|(\\s*\\broof\\b\\s*).*$|' +
                          '^roofer|^roofer\\s+|(\\s*\\broofer\\b\\s*).*$)\\b';

  EXPORT CAFE_EXPR      := '\\b(^cafe|^cafe\\s+|(\\s*\\bcafe\\b\\s*).*$|' +
                          '^caffe|^caffe\\s+|(\\s*\\bcaffe\\b\\s*).*$|' +
                          '^cafes|^cafes\\s+|(\\s*\\bcafes\\b\\s*).*$)\\b';

  EXPORT HEAT_EXPR      := '\\b(^heating|^heating\\s+|(\\s*\\bheating\\b\\s*).*$|' +
                          '^heat|^heat\\s+|(\\s*\\bheat\\b\\s*).*$|' +
                          '^heati|^heati\\s+|(\\s*\\bheati\\b\\s*).*$|' +
                          '^heatin|^heatin\\s+|(\\s*\\bheatin\\b\\s*).*$|' +
                          '^heatng|^heatng\\s+|(\\s*\\bheatng\\b\\s*).*$)\\b';
                          
  EXPORT PIZZA_EXPR     := '\\b(^pizza|^pizza\\s+|(\\s*\\bpizza\\b\\s*).*$)\\b';
  
  EXPORT LAW_EXPR       := '\\b(^law|^law\\s+|(\\s*\\blaw\\b\\s*).*$|' +
                          '^laws|^laws\\s+|(\\s*\\blaws\\b\\s*).*$)\\b';
  
  EXPORT DEVELOP_EXPR   := '\\b(^development|^development\\s+|(\\s*\\bdevelopment\\b\\s*).*$|' +
                          '^developers|^developers\\s+|(\\s*\\bdevelopers\\b\\s*).*$|' +
                          '^developments|^developments\\s+|(\\s*\\bdevelopments\\b\\s*).*$|' +
                          '^develop|^develop\\s+|(\\s*\\bdevelop\\b\\s*).*$|' +
                          '^developmen|^developmen\\s+|(\\s*\\bdevelopmen\\b\\s*).*$|' +
                          '^developement|^developement\\s+|(\\s*\\bdevelopement\\b\\s*).*$|' +
                          '^develo|^develo\\s+|(\\s*\\bdevelo\\b\\s*).*$|' +
                          '^developer|^developer\\s+|(\\s*\\bdeveloper\\b\\s*).*$|' +
                          '^developm|^developm\\s+|(\\s*\\bdevelopm\\b\\s*).*$|' +
                          '^developing|^developing\\s+|(\\s*\\bdeveloping\\b\\s*).*$|' +
                          '^developmnt|^developmnt\\s+|(\\s*\\bdevelopmnt\\b\\s*).*$|' +
                          '^develoment|^develoment\\s+|(\\s*\\bdeveloment\\b\\s*).*$|' +
                          '^devlopment|^devlopment\\s+|(\\s*\\bdevlopment\\b\\s*).*$|' +
                          '^development|^development\\s+|(\\s*\\bdevelopment\\b\\s*).*$)\\b';

  EXPORT CLEAN_EXPR     := '\\b(^cleaning|^cleaning\\s+|(\\s*\\bcleaning\\b\\s*).*$|' +
                          '^clean|^clean\\s+|(\\s*\\bclean\\b\\s*).*$|' +
                          '^cleanin|^cleanin\\s+|(\\s*\\bcleanin\\b\\s*).*$|' +
                          '^cleaner|^cleaner\\s+|(\\s*\\bcleaner\\b\\s*).*$)\\b';

  EXPORT SERVICE_EXPR   := '\\b(^service|^service\\s+|(\\s*\\bservice\\b\\s*).*$|' +
                          '^services|^services\\s+|(\\s*\\bservices\\b\\s*).*$|' +
                          '^servic|^servi\\s+|(\\s*\\bservic\\b\\s*).*$|' +
                          '^servicing|^servicing\\s+|(\\s*\\bservicing\\b\\s*).*$|' +
                          '^evice|^evice\\s+|(\\s*\\bevice\\b\\s*).*$|' +
                          '^servics|^servics\\s+|(\\s*\\bservics\\b\\s*).*$|' +
                          '^servies|^servies\\s+|(\\s*\\bservies\\b\\s*).*$|' +
                          '^srvices|^srvices\\s+|(\\s*\\bsrvices\\b\\s*).*$|' +
                          '^servces|^servces\\s+|(\\s*\\bservces\\b\\s*).*$|' +
                          '^serivices|^serivices\\s+|(\\s*\\bserivices\\b\\s*).*$|' +
                          '^servicer|^servicer\\s+|(\\s*\\bservicer\\b\\s*).*$)\\b';

  EXPORT SALE_EXPR      := '\\b(^sales|^sales\\s+|(\\s*\\bsales\\b\\s*).*$|' +
                          '^sale|^sale\\s+|(\\s*\\bsale\\b\\s*).*$)\\b';
  
  EXPORT TREE_EXPR      := '\\b(^tree|^tree\\s+|(\\s*\\btree\\b\\s*).*|' +
                          '^trees|^trees\\s+|(\\s*\\btrees\\b\\s*).*$|' +
                          '^trtee|^trtee\\s+|(\\s*\\btrtee\\b\\s*).*$)\\b';

  EXPORT CONCRETE_EXPR  := '\\b(^concrete|^concrete\\s+|(\\s*\\bconcrete\\b\\s*).*$|' +
                          '^concret|^concret\\s+|(\\s*\\bconcret\\b\\s*).*$|' +
                          '^conrete|^conrete\\s+|(\\s*\\bconrete\\b\\s*).*$)\\b';

  EXPORT SALON_EXPR     := '\\b(^salon|^salon\\s+|(\\s*\\bsalon\\b\\s*).*|' +
                          '^salons|^salons\\s+|(\\s*\\bsalons\\b\\s*).*$)\\b';
  
  EXPORT REMODEL_EXPR   := '\\b(^remodeling|^remodeling\\s+|(\\s*\\bremodeling\\b\\s*).*$|' +
                          '^remodel|^remodel\\s+|(\\s*\\bremodel\\b\\s*).*$|' +
                          '^remodelers|^remodelers\\s+|(\\s*\\bremodelers\\b\\s*).*$|' +
                          '^remodelin|^remodelin\\s+|(\\s*\\bremodelin\\b\\s*).*$|' +
                          '^remodeler|^remodeler\\s+|(\\s*\\bremodeler\\b\\s*).*$)\\b';

  EXPORT LOGIST_EXPR    := '\\b(^logistics|^logistics\\s+|(\\s*\\blogistics\\b\\s*).*$|' +
                          '^logistic|^logistic\\s+|(\\s*\\blogistic\\b\\s*).*$|' +
                          '^logistical|^logistical\\s+|(\\s*\\blogistical\\b\\s*).*$|' +
                          '^logistix|^logistix\\s+|(\\s*\\blogistix\\b\\s*).*$|' +
                          '^logisitics|^logisitics\\s+|(\\s*\\blogisitics\\b\\s*).*$)\\b';

  EXPORT CAPITAL_EXPR   := '\\b(^capital|^capital\\s+|(\\s*\\bcapital\\b\\s*).*$|' +
                          '^capitol|^capitol\\s+|(\\s*\\bcapitol\\b\\s*).*$|' +
                          '^capitl|^capitl\\s+|(\\s*\\bcapitl\\b\\s*).*$|' +
                          '^capita|^capita\\s+|(\\s*\\bcapita\\b\\s*).*$|' +
                          '^kapital|^kapital\\s+|(\\s*\\bkapital\\b\\s*).*$)\\b';

  EXPORT STORE_EXPR     := '\\b(^store|^store\\s+|(\\s*\\bstore\\b\\s*).*$|' +
                           '^stores|^stores\\s+|(\\s*\\bstores\\b\\s*).*$)\\b';
  
  EXPORT FOOD_EXPR      := '\\b(^food|^food\\s+|(\\s*\\bfood\\b\\s*).*$|' +
                          '^foods|^foods\\s+|(\\s*\\bfoods\\b\\s*).*$)\\b';
  
  EXPORT AUTO_EXPR      := '\\b(^auto|^auto\\s+|(\\s*\\bauto\\b\\s*).*$|' +
                          '^autos|^autos\\s+|(\\s*\\bautos\\b\\s*).*$|' +
                          '^automotive|^automotive\\s+|(\\s*\\bautomotive\\b\\s*).*$|' +
                          '^automobile|^automobile\\s+|(\\s*\\bautomobile\\b\\s*).*$|' +
                          '^automative|^automative\\s+|(\\s*\\bautomative\\b\\s*).*$|' +
                          '^automotiv|^automativ\\s+|(\\s*\\bautomotiv\\b\\s*).*$|' +
                          '^automotives|^automatives\\s+|(\\s*\\bautomotives\\b\\s*).*$|' +
                          '^automot|^automot\\s+|(\\s*\\bautomot\\b\\s*).*$)\\b';

  EXPORT SUPPLY_EXPR    := '\\b(^supply|^supply\\s+|(\\s*\\bsupply\\b\\s*).*$|' +
                          '^supplies|^supplies\\s+|(\\s*\\bsupplies\\b\\s*).*$|' +
                          '^suppl|^suppl\\s+|(\\s*\\bsuppl\\b\\s*).*$|' +
                          '^supplier|^supplier\\s+|(\\s*\\bsupplier\\b\\s*).*$)\\b';

  EXPORT STORAGE_EXPR   := '\\b(^storage|^storage\\s+|(\\s*\\bstorage\\b\\s*).*$|' +
                          '^storag|^storag\\s+|(\\s*\\bstorag\\b\\s*).*$)\\b';
  
  EXPORT TRAVEL_EXPR    := '\\b(^travel|^travel\\s+|(\\s*\\btravel\\b\\s*).*$|' +
                          '^traveling|^traveling\\s+|(\\s*\\btraveling\\b\\s*).*$|' +
                          '^travels|^travels\\s+|(\\s*\\btravels\\b\\s*).*$|' +
                          '^traveler|^traveler\\s+|(\\s*\\btraveler\\b\\s*).*$)\\b';

  EXPORT DRYWALL_EXPR   := '\\b(^drywall|^drywall\\s+|(\\s*\\bdrywall\\b\\s*).*$)\\b';
  
  EXPORT HEALTH_EXPR    := '\\b(^health|^health\\s+|(\\s*\\bhealth\\b\\s*).*$|' +
                          '^healthy|^healthy\\s+|(\\s*\\bhealthy\\b\\s*).*$)\\b';
  
  EXPORT TILE_EXPR      := '\\b(^tile|^tile\\s+|(\\s*\\btile\\b\\s*).*$|' +
                          '^tiles|^tiles\\s+|(\\s*\\btiles\\b\\s*).*$|' +
                          '^tiler|^tiler\\s+|(\\s*\\btiler\\b\\s*).*$)\\b';

  EXPORT VENTURE_EXPR   := '\\b(^ventures|^ventures\\s+|(\\s*\\bventures\\b\\s*).*$|' +
                          '^venture|^venture\\s+|(\\s*\\bventure\\b\\s*).*$|' +
                          '^ventur|^ventur\\s+|(\\s*\\bventur\\b\\s*).*$|' +
                          '^venturi|^ventur1\\s+|(\\s*\\bventuri\\b\\s*).*$)\\b';

  EXPORT OIL_EXPR       := '\\b(^oil|^oil\\s+|(\\s*\\boil\\b\\s*).*$|' +
                            '^oils|^oils\\s+|(\\s*\\boils\\b\\s*).*$)\\b';
  
  EXPORT RANCH_EXPR     := '\\b(^ranch|^ranch\\s+|(\\s*\\branch\\b\\s*).*$|' +
                          '^rancho|^rancho\\s+|(\\s*\\brancho\\b\\s*).*$|' +
                          '^ranches|^ranches\\s+|(\\s*\\branches\\b\\s*).*$)\\b';

  EXPORT MANUF_EXPR     := '\\b(^manufacturing|^manufacturing\\s+|(\\s*\\bmanufacturing\\b\\s*).*$|' +
                          '^manufacturers|^manufacturers\\s+|(\\s*\\bmanufacturers\\b\\s*).*$|' +
                          '^manufactured|^manufactured\\s+|(\\s*\\bmanufactured\\b\\s*).*$|' +
                          '^manufacturer\\s+|(\\s*\\bmanufacturer\\b\\s*).*$|' +
                          '^manufacturi\\|^manufacturers+|(\\s*\\bmanufacturi\\b\\s*).*$|' +
                          '^manufactures|^manufactures\\s+|(\\s*\\bmanufactures\\b\\s*).*$|' +
                          '^manufactoring|^manufactoring\\s+|(\\s*\\bmanufactoring\\b\\s*).*$|' +
                          '^manufactur|^manufactur\\s+|(\\s*\\bmanufactur\\b\\s*).*$|' +
                          '^manufacturin|^manufacturin\\s+|(\\s*\\bmanufacturin\\b\\s*).*$|' +
                          '^manufacture|^manufacture\\s+|(\\s*\\bmanufacture\\b\\s*).*$|' +
                          '^manfacturing|^manfacturing\\s+|(\\s*\\bmanfacturing\\b\\s*).*$)\\b';

  EXPORT RETAIL_EXPR    := '\\b(^retail|^retail\\s+|(\\s*\\bretail\\b\\s*).*$|' +
                          '^retailer|^retailer\\s+|(\\s*\\bretailer\\b\\s*).*$)\\b';
  
  EXPORT MARKET_EXPR    := '\\b(^market|^market\\s+|(\\s*\\bmarket\\b\\s*).*$|' +
                          '^marketing|^marketing\\s+|(\\s*\\bmarketing\\b\\s*).*$|' +
                          '^markets|^markets\\s+|(\\s*\\bmarkets\\b\\s*).*$|' +
                          '^marketers|^marketers\\s+|(\\s*\\bmarketers\\b\\s*).*$|' +
                          '^marketin|^marketin\\s+|(\\s*\\bmarketin\\b\\s*).*$|' +
                          '^markey|^markey\\s+|(\\s*\\bmarkey\\b\\s*).*$|' +
                          '^marketi|^marketi\\s+|(\\s*\\bmarketi\\b\\s*).*$|' +
                          '^marketer|^marketer\\s+|(\\s*\\bmarketer\\b\\s*).*$|' +
                          '^marken|^marken\\s+|(\\s*\\bmarken\\b\\s*).*$)\\b';

  EXPORT GRILL_EXPR     := '\\b(^grill|^grill\\s+|(\\s*\\bgrill\\b\\s*).*$|' +
                          '^grille|^grille\\s+|(\\s*\\bgrille\\b\\s*).*$|' +
                          '^gril|^gril\\s+|(\\s*\\bgril\\b\\s*).*$)\\b';

  EXPORT EQUIPMENT_EXPR := '\\b(^equipment|^equipment\\s+|(\\s*\\bequipment\\b\\s*).*$|' +
                          '^equip|^equip\\s+|(\\s*\\bequip\\b\\s*).*$|' +
                          '^equiptment|^equiptment\\s+|(\\s*\\bequiptment\\b\\s*).*$|' +
                          '^equipmen|^equipmen\\s+|(\\s*\\bequipmen\\b\\s*).*$|' +
                          '^equipmnt|^equipmnt\\s+|(\\s*\\bequipmnt\\b\\s*).*$|' +
                          '^equipmen|^equipmen\\s+|(\\s*\\bequipmen\\b\\s*).*$)\\b';

  EXPORT DESGIN_EXPR    := '\\b(^design|^design\\s+|(\\s*\\bdesign\\b\\s*).*$|' +
                          '^designs|^designs\\s+|(\\s*\\bdesigns\\b\\s*).*$|' +
                          '^designer|^designer\\s+|(\\s*\\bdesigner\\b\\s*).*$|' +
                          '^designers|^designers\\s+|(\\s*\\bdesigners\\b\\s*).*$|' +
                          '^designed|^designed\\s+|(\\s*\\bdesigned\\b\\s*).*$|' +
                          '^desig|^desig\\s+|(\\s*\\bdesig\\b\\s*).*$|' +
                          '^designing|^designing\\s+|(\\s*\\bdesigning\\b\\s*).*$|' +
                          '^dsign|^dsign\\s+|(\\s*\\bdsign\\b\\s*).*$|' +
                          '^desgn|^desgn\\s+|(\\s*\\bdesgn\\b\\s*).*$|' +
                          '^designz|^designz\\s+|(\\s*\\bdesignz\\b\\s*).*$)\\b';

  EXPORT MEDIC_EXPR     := '\\b(^medical|^medical\\s+|(\\s*\\bmedical\\b\\s*).*$|' +
                          '^medica|^medica\\s+|(\\s*\\bmedica\\b\\s*).*$|' +
                          '^medics|^medics\\s+|(\\s*\\bmedics\\b\\s*).*$)\\b';

  EXPORT REPAIR_EXPR    := '\\b(^repair|^repair\\s+|(\\s*\\brepair\\b\\s*).*$|' +
                          '^repairs|^repairs\\s+|(\\s*\\brepairs\\b\\s*).*$|' +
                          '^repai|^repai\\s+|(\\s*\\brepai\\b\\s*).*$|' +
                          '^rpair|^rpair\\s+|(\\s*\\brpair\\b\\s*).*$|' +
                          '^repairing|^repairing\\s+|(\\s*\\brepairing\\b\\s*).*$)\\b';

  EXPORT CENTER_EXPR    := '\\b(^center|^center\\s+|(\\s*\\bcenter\\b\\s*).*$|' +
                          '^centers|^centers\\s+|(\\s*\\bcenters\\b\\s*).*$|' +
                          '^cente|^cente\\s+|(\\s*\\bcente\\b\\s*).*$|' +
                          '^centr|^centr\\s+|(\\s*\\bcentr\\b\\s*).*$)\\b';

  EXPORT HIAR_EXPR      := '\\b(^hair|^hair\\s+|(\\s*\\bhair\\b\\s*).*$)\\b';
  
  EXPORT ASSOCIATE_EXPR := '\\b(^association|^association\\s+|(\\s*\\bassociation\\b\\s*).*$|' +
                          '^associates|^associates\\s+|(\\s*\\bassociates\\b\\s*).*$|' +
                          '^associat|^associat\\s+|(\\s*\\bassociat\\b\\s*).*$|' +
                          '^associated|^associated\\s+|(\\s*\\bassociated\\b\\s*).*$|' +
                          '^associate|^associate\\s+|(\\s*\\bassociate\\b\\s*).*$|' +
                          '^associati|^associati\\s+|(\\s*\\bassociati\\b\\s*).*$|' +
                          '^associatio|^associatio\\s+|(\\s*\\bassociatio\\b\\s*).*$|' +
                          '^associ|^associ\\s+|(\\s*\\bassoci\\b\\s*).*$|' +
                          '^assocation|^assocation\\s+|(\\s*\\bassocation\\b\\s*).*$|' +
                          '^associations|^associations\\s+|(\\s*\\bassociations\\b\\s*).*$|' +
                          '^associaton|associaton\\s+|(\\s*\\bassociaton\\b\\s*).*$|' +
                          '^asociation|^asociation\\s+|(\\s*\\basociation\\b\\s*).*$|' +
                          '^assocates|^assocates\\s+|(\\s*\\bassocates\\b\\s*).*$|' +
                          '^assocites|^assocites\\s+|(\\s*\\bassocites\\b\\s*).*$|' +
                          '^asociates|^asociates\\s+|(\\s*\\basociates\\b\\s*).*$)\\b';
                          
  EXPORT CARE_EXPR      := '\\b(^care|^care\\s+|(\\s*\\bcare\\b\\s*).*$)\\b';
  
  EXPORT AGENCY_EXPR    := '\\b(^agency|^agency\\s+|(\\s*\\bagency\\b\\s*).*$|' +
                          '^agencies|agencies\\s+|(\\s*\\bagencies\\b\\s*).*$|' +
                          '^agncy|^agncy\\s+|(\\s*\\bagncy\\b\\s*).*$|' +
                          '^agent|^agent\\s+|(\\s*\\bagent\\b\\s*).*$)\\b';

  EXPORT DDS_EXPR       := '\\b(^dds|^dds\\s+|(\\s*\\bdds\\b\\s*).*$)\\b';
  
  EXPORT PUBLISH_EXPR   := '\\b(^publishing|^publishing\\s+|(\\s*\\bpublishing\\b\\s*).*$|' +
                          '^publishers|^publishers\\s+|(\\s*\\bpublishers\\b\\s*).*$)\\b';
  
  EXPORT MACHINE_EXPR   := '\\b(^machine|^machine\\s+|(\\s*\\bmachine\\b\\s*).*$|' +
                          '^machining|^machining\\s+|(\\s*\\bmachining\\b\\s*).*$|' +
                          '^machines|^machines\\s+|(\\s*\\bmachines\\b\\s*).*$|' +
                          '^machin|^machin\\s+|(\\s*\\bmachin\\b\\s*).*$s+)\\b';

  EXPORT MASONRI_EXPR   := '\\b(^masonry|^masonry\\s+|(\\s*\\bmasonry\\b\\s*).*$|' +
                          '^masonary|^masonary\\s+|(\\s*\\bmasonary\\b\\s*).*$)\\b';
  
  EXPORT EXPRESS_EXPR   := '\\b(^express|^express\\s+|(\\s*\\bexpress\\b\\s*).*$|' +
                          '^xpress|^xpress\\s+|(\\s*\\bxpress\\b\\s*).*$|' +
                          '^expres|^expres\\s+|(\\s*\\bexpres\\b\\s*).*$)\\b';

  EXPORT PHOT0GRAPHY_EXPR := '\\b(^photography|^photography\\s+|(\\s*\\bphotography\\b\\s*).*$)\\b';
  
  EXPORT CATER_EXPR     := '\\b(^catering|^catering\\s+|(\\s*\\bcatering\\b\\s*).*$|' +
                          '^caterers|^caterers\\s+|(\\s*\\bcaterers\\b\\s*).*$|' +
                          '^cater|^cater\\s+|(\\s*\\bcater\\b\\s*).*$|' +
                          '^catered|^catered\\s+|(\\s*\\bcatered\\b\\s*).*$|' +
                          '^crater|^crater\\s+|(\\s*\\bcrater\\b\\s*).*$|' +
                          '^caterer|^caterer\\s+|(\\s*\\bcaterer\\b\\s*).*$|' +
                          '^caterin|^caterin\\s+|(\\s*\\bcaterin\\b\\s*).*$' +
                          '^katering|^katering\\s+|(\\s*\\bkatering\\b\\s*).*$)\\b';

  EXPORT DELI_EXPR      := '\\b(^deli|^deli\\s+|(\\s*\\bdeli\\b\\s*).*$)\\b';
  
  EXPORT COUNTY_EXPR    := '\\b(^county|^county\\s+|(\\s*\\bcounty\\b\\s*).*$|' +
                          '^count|^count\\s+|(\\s*\\bcount\\b\\s*).*$|' +
                          '^counties|^counties\\s+|(\\s*\\bcounties\\b\\s*).*$)\\b';

  EXPORT PROFESSIONAL_EXPR := '\\b(^professional|^professional\\s+|(\\s*\\bprofessional\\b\\s*).*$|' +
                          '^professionals|^professionals\\s+|(\\s*\\bprofessionals\\b\\s*).*$|' +
                          '^profesional|^profesional\\s+|(\\s*\\bprofesional\\b\\s*).*$|' +
                          '^proffessional|^proffessional\\s+|(\\s*\\bproffessional\\b\\s*).*$|' +
                          '^professinal|^professinal\\s+|(\\s*\\bprofessinal\\b\\s*).*$)\\b';

  EXPORT ENGERI_EXPR    := '\\b(^energy|^energy\\s+|(\\s*\\benergy\\b\\s*).*$|' +
                          '^energies|^energies\\s+|(\\s*\\benergies\\b\\s*).*$|' +
                          '^enrgy|^enrgy\\s+|(\\s*\\benrgy\\b\\s*).*$)\\b';

  EXPORT CARPENTRI_EXPR := '\\b(^carpentry|^carpentry\\s+|(\\s*\\bcarpentry\\b\\s*).*$|' +
                          '^carpenter|^carpenter\\s+|(\\s*\\bcarpenter\\b\\s*).*$)\\b';
  
  EXPORT COMPANY_EXPR   := '\\b(^companies|^companies\\s+|(\\s*\\bcompanies\\b\\s*).*$|' +
                          '^company|^company\\s+|(\\s*\\bcompany\\b\\s*).*$|' +
                          '^comany|^comany\\s+|(\\s*\\bcomany\\b\\s*).*$|' +
                          '^kompany|^kompany\\s+|(\\s*\\bkompany\\b\\s*).*$|' +
                          '^compant|^compant\\s+|(\\s*\\bcompant\\b\\s*).*$|' +
                          '^ompany|^ompany\\s+|(\\s*\\bompany\\b\\s*).*$|' +
                          '^companys|^companys\\s+|(\\s*\\bcompanys\\b\\s*).*$|' +
                          '^companie|^companie\\s+|(\\s*\\bcompanie\\b\\s*).*$|' +
                          '^compamy|^compamy\\s+|(\\s*\\bcompamy\\b\\s*).*$|' +
                          '^comapany|^comapany\\s+|(\\s*\\bcomapany\\b\\s*).*$|' +
                          '^co|^co\\s+|(\\s*\\bco\\b\\s*).*$)\\b';

  EXPORT WHOLESALE_EXPR := '\\b(^wholesale\\s+|(\\s*\\bwholesale\\b\\s*).*$|' +
                          '^wholesalers\\s+|(\\s*\\bwholesalers\\b\\s*).*$|' +
                          '^wholesaler\\s+|(\\s*\\bwholesaler\\b\\s*).*$|' +
                          '^wholesales\\s+|(\\s*\\bwholesales\\b\\s*).*$)\\b';

  EXPORT INTERNATIONAL_EXPR := '\\b(^international|^international\\s+|(\\s*\\binternational\\b\\s*).*$|' + 
                          '^internationale|^internationale\\s+|(\\s*\\binternationale\\b\\s*).*$)\\b';

  EXPORT BAR_EXPR       := '\\b(^bar|^bar\\s+|(\\s*\\bbar\\b\\s*).*$|' +
                          '^bars|^bars\\s+|(\\s*\\bbars\\b\\s*).*$)\\b';
  
  EXPORT DENTAL_EXPR    := '\\b(^dental\\s+|(\\s*\\bdental\\b\\s*).*$)\\b';
  
  EXPORT PRINT_EXPR     := '\\b(^printing|^printing\\s+|(\\s*\\bprinting\\b\\s*).*$|' +
                          '^print|^print\\s+|(\\s*\\bprint\\b\\s*).*$|' +
                          '^prints|^prints\\s+|(\\s*\\bprints\\b\\s*).*$|' +
                          '^printed|^printed\\s+|(\\s*\\bprinted\\b\\s*).*$)\\b';

  EXPORT PRODUCT_EXPR   := '\\b(^products|^products\\s+|(\\s*\\bproducts\\b\\s*).*$|' +
                          '^product|^product\\s+|(\\s*\\bproduct\\b\\s*).*$|' +
                          '^productos|^productos\\s+|(\\s*\\bproductos\\b\\s*).*$)\\b';

  EXPORT FREIGHT_EXPR   := '\\b(^freight|^freight\\s+|(\\s*\\bfreight\\b\\s*).*$)\\b';
  
  EXPORT FAMILY_EXPR    := '\\b(^family|^family\\s+|(\\s*\\bfamily\\b\\s*).*$|' +
                          '^families|^families\\s+|(\\s*\\bfamilies\\b\\s*).*$|' +
                          '^famil|^famil\\s+|(\\s*\\bfamil\\b\\s*).*$|' +
                          '^famly|^famly\\s+|(\\s*\\bfamly\\b\\s*).*$|' +
                          '^familys|^familys\\s+|(\\s*\\bfamilys\\b\\s*).*$|' +
                          '^familty|^familty\\s+|(\\s*\\bfamilty\\b\\s*).*$)\\b';

  EXPORT FIT_EXPR       := '\\b(^fitness|^fitness\\s+|(\\s*\\bfitness\\b\\s*).*$|' +
                          '^fitnes|^fitnes\\s+|(\\s*\\bfitnes\\b\\s*).*$)\\b';
  
  EXPORT TAX_EXPR       := '\\b(^tax|^tax\\s+|(\\s*\\btax\\b\\s*).*$)\\b';
  
  EXPORT BODY_EXPR      := '\\b(^body|^body\\s+|(\\s*\\bbody\\b\\s*).*$|' +
                          '^bodies|^bodies\\s+|(\\s*\\bbodies\\b\\s*).*$)\\b';
  
  EXPORT CONDOMINIUM_EXPR := '\\b(^condominium|^condominium\\s+|(\\s*\\bcondominium\\b\\s*).*$|' +
                          '^condominiums|^condominiums\\s+|(\\s*\\bcondominiums\\b\\s*).*$|' +
                          '^condominiu|^condominiu\\s+|(\\s*\\bcondominiu\\b\\s*).*$|' +
                          '^condominum|^condominum\\s+|(\\s*\\bcondominum\\b\\s*).*$|' +
                          '^condo|^condo\\s+|(\\s*\\bcondo\\b\\s*).*$)\\b';

  EXPORT COMMUNICATION_EXPR := '\\b(^communications|^communications\\s+|(\\s*\\bcommunications\\b\\s*).*$|' +
                          '^communication|^communication\\s+|(\\s*\\bcommunication\\b\\s*).*$|' +
                          '^communicatio|^communicatio\\s+|(\\s*\\bcommunicatio\\b\\s*).*$|' +
                          '^communcations|^communcations\\s+|(\\s*\\bcommuncations\\b\\s*).*$|' +
                          '^communic|^communic\\s+|(\\s*\\bcommunic\\b\\s*).*$)\\b';

  EXPORT FURNITURE_EXPR := '\\b(^furniture|^furniture\\s+|(\\s*\\bfurniture\\b\\s*).*$|' +
                          '^funiture|^funiture\\s+|(\\s*\\bfuniture\\b\\s*).*$|' +
                          '^furnitur|^furnitur\\s+|(\\s*\\bfurnitur\\b\\s*).*$)\\b';

  EXPORT TITLE_EXPR     := '\\b(^title|^title\\s+|(\\s*\\btitle\\b\\s*).*$|' +
                          '^titling|^titling\\s+|(\\s*\\btitling\\b\\s*).*$|' +
                          '^titl|^titl\\s+|(\\s*\\btitl\\b\\s*).*$|' +
                          '^titles|^titles\\s+|(\\s*\\btitles\\b\\s*).*$|' +
                          '^tiling|^tiling\\s+|(\\s*\\btiling\\b\\s*).*$)\\b';

  EXPORT RESOURCE_EXPR  := '\\b(^resources|^resources\\s+|(\\s*\\bresources\\b\\s*).*$|' +
                          '^resource|^resource\\s+|(\\s*\\bresource\\b\\s*).*$|' +
                          '^resourc|^resourc\\s+|(\\s*\\bresourc\\b\\s*).*$)\\b';

  EXPORT EXCAV_EXPR     := '\\b(^excavating|^excavating\\s+|(\\s*\\bexcavating\\b\\s*).*$|' +
                          '^excavation|^excavation\\s+|(\\s*\\bexcavation\\b\\s*).*$|' +
                          '^excav|^excav\\s+|(\\s*\\bexcav\\b\\s*).*$|' +
                          '^excavators|^excavators\\s+|(\\s*\\bexcavators\\b\\s*).*$|' +
                          '^excavatin|^excavatin\\s+|(\\s*\\bexcavatin\\b\\s*).*$|' +
                          '^excavator|^excavator\\s+|(\\s*\\bexcavator\\b\\s*).*$)\\b';

  EXPORT ENTERPRISE_EXPR := '\\b(^enterprises|^enterprises\\s+|(\\s*\\benterprises\\b\\s*).*$|' +
                          '^enterprise|^enterprise\\s+|(\\s*\\benterprise\\b\\s*).*$|' +
                          '^enterprizes|^enterprizes\\s+|(\\s*\\benterprizes\\b\\s*).*$|' +
                          '^enterprize|^enterprize\\s+|(\\s*\\benterprize\\b\\s*).*$|' +
                          '^enteprises|^enteprises\\s+|(\\s*\\benteprises\\b\\s*).*$|' +
                          '^interprises|^interprises\\s+|(\\s*\\binterprises\\b\\s*).*$|' +
                          '^enterpises|^enterpises\\s+|(\\s*\\benterpises\\b\\s*).*$|' +
                          '^entrprises|^entrprises\\s+|(\\s*\\bentrprises\\b\\s*).*$|' +
                          '^enterpries|^enterpries\\s+|(\\s*\\benterpries\\b\\s*).*$|' +
                          '^enterpries|^enterpries\\s+|(\\s*\\benterpries\\b\\s*).*$|' +
                          '^interprise|^interprise\\s+|(\\s*\\binterprise\\b\\s*).*$)\\b';

  EXPORT THERAPY_EXPR   := '\\b(^therapy|^therapy\\s+|(\\s*\\btherapy\\b\\s*).*$|' +
                          '^therapies|^therapies\\s+|(\\s*\\btherapies\\b\\s*).*$|' +
                          '^therap|^therap\\s+|(\\s*\\btherap\\b\\s*).*$)\\b';

  EXPORT  MART_EXPR     := '\\b(^mart|^mart\\s+|(\\s*\\bmart\\b\\s*).*$)\\b';

  EXPORT ENGINNEER_EXPR  := '\\b(^engineering|^engineering\\s+|(\\s*\\bengineering\\b\\s*).*$|' +
                          '^engineers|^engineers\\s+|(\\s*\\bengineers\\b\\s*).*$|' +
                          '^engineered|^engineered\\s+|(\\s*\\bengineered\\b\\s*).*$|' +
                          '^engineer|^engineer\\s+|(\\s*\\bengineer\\b\\s*).*$|' +
                          '^engineerin|^engineerin\\s+|(\\s*\\bengineerin\\b\\s*).*$|' +
                          '^enginering|^enginering\\s+|(\\s*\\benginering\\b\\s*).*$|' +
                          '^engineerin|^engineerin\\s+|(\\s*\\bengineeri\\b\\s*).*$)\\b';

  EXPORT GIFT_EXPR      := '\\b(^gift|^gift\\s+|(\\s*\\bgift\\b\\s*).*$|' +
                          '^gifts|^gifts\\s+|(\\s*\\bgifts\\b\\s*).*$)\\b';
  
  EXPORT SCHOOL_EXPR    := '\\b(^school|^school\\s+|(\\s*\\bschool\\b\\s*).*$|' +
                          '^schools|^schools\\s+|(\\s*\\bschools\\b\\s*).*$|' +
                          '^schoo|^schoo\\s+|(\\s*\\bschoo\\b\\s*).*$)\\b';

  EXPORT CHIROPRACT_EXPR := '\\b(^chiropractic|^chiropractic\\s+|(\\s*\\bchiropractic\\b\\s*).*$|' +
                          '^chiropratic|^chiropratic\\s+|(\\s*\\bchiropratic\\b\\s*).*$|' +
                          '^chiropract|^chiropract\\s+|(\\s*\\bchiropract\\b\\s*).*$|' +
                          '^chiropracti|^chiropracti\\s+|(\\s*\\bchiropracti\\b\\s*).*$|' +
                          '^chropractic|^chropractic\\s+|(\\s*\\bchropractic\\b\\s*).*$)\\b';

  EXPORT INDUSTRY_EXPR  := '\\b(^industries|^industries\\s+|(\\s*\\bindustries\\b\\s*).*$|' +
                          '^industry|^industry\\s+|(\\s*\\bindustry\\b\\s*).*$|' +
                          '^industr|^industr\\s+|(\\s*\\bindustr\\b\\s*).*$|' +
                          '^industri|^industri\\s+|(\\s*\\bindustri\\b\\s*).*$|' +
                          '^industrie|^industrie\\s+|(\\s*\\bindustrie\\b\\s*).*$|' +
                          '^industies|^industies\\s+|(\\s*\\bindusties\\b\\s*).*$)\\b';

  EXPORT MEDIA_EXPR     := '\\b(^media|^media\\s+|(\\s*\\bmedia\\b\\s*).*$)\\b';
  
  EXPORT SHOP_EXPR      := '\\b(^shop|^shop\\s+|(\\s*\\bshop\\b\\s*).*$|' +
                          '^shops|^shops\\s+|(\\s*\\bshops\\b\\s*).*$|' +
                          '^shopp|^shopp\\s+|(\\s*\\bshopp\\b\\s*).*$)\\b';

  EXPORT SYSTEM_EXPR    := '\\b(^systems|^systems\\s+|(\\s*\\bsystems\\b\\s*).*$|' +
                          '^system|^system\\s+|(\\s*\\bsystem\\b\\s*).*$|' +
                          '^syste|^syste\\s+|(\\s*\\bsyste\\b\\s*).*$|' +
                          '^sytems|^sytems\\s+|(\\s*\\bsytems\\b\\s*).*$)\\b';

  EXPORT CUSTOM_EXPR    := '\\b(^custom|^custom\\s+|(\\s*\\bcustom\\b\\s*).*$|' +
                          '^kustom|^kustom\\s+|(\\s*\\bkustom\\b\\s*).*$|' +
                          '^customized|^customized\\s+|(\\s*\\bcustomized\\b\\s*).*$)\\b';

  EXPORT DOLLAR_EXPR    := '\\b(^dollar|^dollar\\s+|(\\s*\\bdollar\\b\\s*).*$|' +
                          '^dollars|^dollars\\s+|(\\s*\\bdollars\\b\\s*).*$)\\b';
  
  EXPORT MINISTRI_EXPR  := '\\b(^ministries|^ministries\\s+|(\\s*\\bministries\\b\\s*).*$|' +
                          '^ministry|^ministry\\s+|(\\s*\\bministry\\b\\s*).*$|' +
                          '^ministri|^ministri\\s+|(\\s*\\bministri\\b\\s*).*$|' +
                          '^ministrie|^ministrie\\s+|(\\s*\\bministrie\\b\\s*).*$|' +
                          '^ministr|^ministr\\s+|(\\s*\\bministr\\b\\s*).*$|' +
                          '^ministeries|^ministeries\\s+|(\\s*\\bministeries\\b\\s*).*$)\\b';

  EXPORT TRADE_EXPR     := '\\b(^trading|^trading\\s+|(\\s*\\btrading\\b\\s*).*$|' +
                          '^trade|^trade\\s+|(\\s*\\btrade\\b\\s*).*$|' +
                          '^trader|^trader\\s+|(\\s*\\btrader\\b\\s*).*$|' +
                          '^trades|^trades\\s+|(\\s*\\btrades\\b\\s*).*$)\\b';

  EXPORT GROUP_EXPR     := '\\b(^group|^group\\s+|(\\s*\\bgroup\\b\\s*).*$|' +
                          '^groups|^groups\\s+|(\\s*\\bgroups\\b\\s*).*$|' +
                          '^groupe|^groupe\\s+|(\\s*\\bgroupe\\b\\s*).*$|' +
                          '^goup|^goup\\s+|(\\s*\\bgoup\\b\\s*).*$)\\b';

  EXPORT PHARMACY_EXPR  := '\\b(^pharmacy|^pharmacy\\s+|(\\s*\\bpharmacy\\b\\s*).*$|' +
                          '^pharmacies|^pharmacies\\s+|(\\s*\\bpharmacies\\b\\s*).*$|' +
                          '^pharmac|^pharmac\\s+|(\\s*\\bpharmac\\b\\s*).*$)\\b';

  EXPORT CPA_EXPR       := '\\b(^cpa|^cpa\\s+|(\\s*\\bcpa\\b\\s*).*$)\\b';
  
  EXPORT AIR_EXPR       := '\\b(^air|^air\\s+|(\\s*\\bair\\b\\s*).*$)\\b';
  
  EXPORT JEWERLY_EXPR   := '\\b(^jewelry|^jewelry\\s+|(\\s*\\bjewelry\\b\\s*).*$)\\b';
  
  EXPORT SPA_EXPR       := '\\b(^spa|^spa\\s+|(\\s*\\bspa\\b\\s*).*$)\\b';
  
  EXPORT MAINTENANCE_EXPR := '\\b(^maintenance|^maintenance\\s+|(\\s*\\bmaintenance\\b\\s*).*$|' +
                          '^maintenanc|^maintenanc\\s+|(\\s*\\bmaintenanc\\b\\s*).*$|' +
                          '^maintenence|^maintenence\\s+|(\\s*\\bmaintenence\\b\\s*).*$|' +
                          '^maintenace|^maintenace\\s+|(\\s*\\bmaintenace\\b\\s*).*$)\\b';

  EXPORT PLLC_EXPR      := '\\b(^pllc|^pllc\\s+|(\\s*\\bpllc\\b\\s*).*$)\\b';
  
  EXPORT MOTOR_EXPR     := '\\b(^motor|^motor\\s+|(\\s*\\bmotor\\b\\s*).*$|' +
                          '^motors|^motors\\s+|(\\s*\\bmotors\\b\\s*).*$|' +
                          '^motoring|^motoring\\s+|(\\s*\\bmotoring\\b\\s*).*$)\\b';

  EXPORT ACADEMY_EXPR   := '\\b(^academy|^academy\\s+|(\\s*\\bacademy\\b\\s*).*$|' +
                          '^academ|^academ\\s+|(\\s*\\bacadem\\b\\s*).*$)\\b';
  
  EXPORT WATER_EXPR     := '\\b(^water|^water\\s+|(\\s*\\bwater\\b\\s*).*$|' +
                          '^waters|^waters\\s+|(\\s*\\bwaters\\b\\s*).*$)\\b';
  
  EXPORT ENTERTAIN_EXPR := '\\b(^entertainment|^entertainment\\s+|(\\s*\\bentertainment\\b\\s*).*$|' +
                          '^entertain|entertain\\s+|(\\s*\\bentertain\\b\\s*).*$|' +
                          '^entertaiment|^entertaiment\\s+|(\\s*\\bentertaiment\\b\\s*).*$|' +
                          '^entertainmen|^entertainmen\\s+|(\\s*\\bentertainmen\\b\\s*).*$)\\b';

  EXPORT STREET_EXPR    := '\\b(^street|^street\\s+|(\\s*\\bstreet\\b\\s*).*$|' +
                          '^streets|^streets\\s+|(\\s*\\bstreets\\b\\s*).*$)\\b';
  
  EXPORT HEALTHCARE_EXPR := '\\b(^healthcare|^healthcare\\s+|(\\s*\\bhealthcare\\b\\s*).*$|' +
                          '^healthcar|^healthcar\\s+|(\\s*\\bhealthcar\\b\\s*).*$|' +
                          '^heathcare|^heathcare\\s+|(\\s*\\bheathcare\\b\\s*).*$)\\b'; 

  EXPORT TOW_EXPR       := '\\b(^towing|^towing\\s+|(\\s*\\btowing\\b\\s*).*$)\\b';
  
  EXPORT CLUB_EXPR      := '\\b(^club|^club\\s+|(\\s*\\bclub\\b\\s*).*$|' +
                          '^clubs|^clubs\\s+|(\\s*\\bclubs\\b\\s*).*$|' +
                          '^klub|^klub\\s+|(\\s*\\bklub\\b\\s*).*$)\\b';

  EXPORT HOUSE_EXPR     := '\\b(^house|^house\\s+|(\\s*\\bhouse\\b\\s*).*$|' +
                          '^housing|^housing\\s+|(\\s*\\bhousing\\b\\s*).*$|' +
                          '^houses|^houses\\s+|(\\s*\\bhouses\\b\\s*).*$)\\b';

  EXPORT SECURITY_EXPR  := '\\b(^security|^security\\s+|(\\s*\\bsecurity\\b\\s*).*$|' +
                          '^secured|^secured\\s+|(\\s*\\bsecured\\b\\s*).*$|' +
                          '^sercurity|^sercurity\\s+|(\\s*\\bsercurity\\b\\s*).*$)\\b';

  EXPORT ACCOUNT_EXPR   := '\\b(^account|^account\\s+|(\\s*\\baccount\\b\\s*).*$|' +
                          '^accounting|^accounting\\s+|(\\s*\\baccounting\\b\\s*).*$|' +
                          '^accountants|^accountants\\s+|(\\s*\\baccountants\\b\\s*).*$|' +
                          '^accountant^accountant\\s+|(\\s*\\baccountant\\b\\s*).*$|' +
                          '^accountancy|^accountancy\\s+|(\\s*\\baccountancy\\b\\s*).*$|' +
                          '^accounts|^accounts\\s+|(\\s*\\baccounts\\b\\s*).*$)\\b';

  EXPORT CITY_EXPR      := '\\b(^city|^city\\s+|(\\s*\\bcity\\b\\s*).*$|' +
                          '^cities|^cities\\s+|(\\s*\\bcities\\b\\s*).*$|' +
                          '^citi|^citi\\s+|(\\s*\\bciti\\b\\s*).*$|' +
                          '^citys|^citys\\s+|(\\s*\\bcitys\\b\\s*).*$)\\b';

  EXPORT STUDIO_EXPR    := '\\b(^studio|^studio\\s+|(\\s*\\bstudio\\b\\s*).*$|' +
                          '^studios|^studios\\s+|(\\s*\\bstudios\\b\\s*).*$|' +
                          '^studi|^studi\\s+|(\\s*\\bstudi\\b\\s*).*$|' +
                          '^stdio|^stdio\\s+|(\\s*\\bstdio\\b\\s*).*$)\\b';

  EXPORT EDUCATION_EXPR := '\\b(^education|^education\\s+|(\\s*\\beducation\\b\\s*).*$|' +
                          '^educational|^educational\\s+|(\\s*\\beducational\\b\\s*).*$|' +
                          '^educators|^educators\\s+|(\\s*\\beducators\\b\\s*).*$|' +
                          '^educ|^educ\\s+|(\\s*\\beduc\\b\\s*).*$|' +
                          '^educatio|^educatio\\s+|(\\s*\\beducatio\\b\\s*).*$)\\b';

  EXPORT TIRE_EXPR      := '\\b(^tire|^tire\\s+|(\\s*\\btire\\b\\s*).*$|' +
                          '^tires|^tires\\s+|(\\s*\\btires\\b\\s*).*$)\\b';
  
  EXPORT HOMEOWNER_EXPR := '\\b(^homeowners|homeowners\\s+|(\\s*\\bhomeowners\\b\\s*).*$|' +
                          '^homeowner|homeowner\\s+|(\\s*\\bhomeowner\\b\\s*).*$)\\b';
  
  EXPORT SOLUTION_EXPR  := '\\b(^solutions|^solutions\\s+|(\\s*\\bsolutions\\b\\s*).*$|' +
                          '^solution|^solutions\\s+|(\\s*\\bsolution\\b\\s*).*$|' +
                          '^soulutions|^soulutions\\s+|(\\s*\\bsoulutions\\b\\s*).*$)\\b';

  EXPORT PART_EXPR      := '\\b(^parts|^parts\\s+|(\\s*\\bparts\\b\\s*).*$|' +
                          '^part|^part\\s+|(\\s*\\bpart\\b\\s*).*$)\\b';
  
  EXPORT INN_EXPR       := '\\b(^inn|^inn\\s+|(\\s*\\binn\\b\\s*).*$)\\b';
  
  EXPORT BEAUTY_EXPR    := '\\b(^beauty|^beauty\\s+|(\\s*\\bbeauty\\b\\s*).*$|' +
                          '^beautiful|^beautiful\\s+|(\\s*\\bbeautiful\\b\\s*).*$)\\b';
  
  EXPORT GLASS_EXPR     := '\\b(^glass|glass\\s+|(\\s*\\bglass\\b\\s*).*$|'+
                          '^glas|glas\\s+|(\\s*\\bglas\\b\\s*).*$)\\b';
  
  EXPORT RESEARCH_EXPR  := '\\b(^research|^research\\s+|(\\s*\\bresearch\\b\\s*).*$|' +
                          '^researc|^researc\\s+|(\\s*\\bresearc\\b\\s*).*$)\\b';
  
  EXPORT MUSIC_EXPR     := '\\b(^music|^music\\s+|(\\s*\\bmusic\\b\\s*).*$|' +
                          '^musical|^musical\\s+|(\\s*\\bmusical\\b\\s*).*$|' +
                          '^musica|^musica\\s+|(\\s*\\bmusica\\b\\s*).*$|' +
                          '^musick|^musick\\s+|(\\s*\\bmusick\\b\\s*).*$|' +
                          '^musik|^musik\\s+|(\\s*\\bmusik\\b\\s*).*$)\\b';

  EXPORT CLINIC_EXPR    := '\\b(^clinic|^clinic\\s+|(\\s*\\bclinic\\b\\s*).*$|' +
                          '^clinical|^clinical\\s+|(\\s*\\bclinical\\b\\s*).*$|' +
                          '^clinics|^clinics\\s+|(\\s*\\bclinics\\b\\s*).*$|' +
                          '^clinica|^clinica\\s+|(\\s*\\bclinica\\b\\s*).*$|' +
                          '^clini|^clini\\s+|(\\s*\\bclini\\b\\s*).*$|' +
                          '^clinc|^clinc\\s+|(\\s*\\bclinc\\b\\s*).*$)\\b';

  EXPORT RENTAL_EXPR    := '\\b(^rentals|^rentals\\s+|(\\s*\\brentals\\b\\s*).*$|' +
                          '^rental|^rentals\\s+|(\\s*\\brental\\b\\s*).*$|' +
                          '^rentall|^rentall\\s+|(\\s*\\brentall\\b\\s*).*$)\\b';

  EXPORT ATTORNEY_EXPR  := '\\b(^attorney|^attorney\\s+|(\\s*\\battorney\\b\\s*).*$|' +
                          '^attorneys|^attorneys\\s+|(\\s*\\battorneys\\b\\s*).*$)\\b';
  
  EXPORT BAPTIST_EXPR   := '\\b(^baptist|^baptist\\s+|(\\s*\\bbaptist\\b\\s*).*$|' +
                          '^baptiste|^baptists\\s+|(\\s*\\bbaptiste\\b\\s*).*$|' +
                          '^baptis|^baptis\\s+|(\\s*\\bbaptis\\b\\s*).*$|' +
                          '^baptst|^baptst\\s+|(\\s*\\bbaptst\\b\\s*).*$)\\b';

  EXPORT SPORT_EXPR     := '\\b(^sports|^sports\\s+|(\\s*\\bsports\\b\\s*).*$|' +
                          '^sport|^sport\\s+|(\\s*\\bsport\\b\\s*).*$|' +
                          '^sporting|^sporting\\s+|(\\s*\\bsporting\\b\\s*).*$|' +
                          '^sportz|^sportz\\s+|(\\s*\\bsportz\\b\\s*).*$)\\b';

  EXPORT LEASE_EXPR     := '\\b(^leasing|^leasing\\s+|(\\s*\\bleasing\\b\\s*).*$|' +
                          '^lease|^lease\\s+|(\\s*\\blease\\b\\s*).*$|' +
                          '^leased|^leased\\s+|(\\s*\\bleased\\b\\s*).*$)\\b';

  EXPORT WIRELESS_EXPR  := '\\b(^wireless|^wireless\\s+|(\\s*\\bwireless\\b\\s*).*$|' +
                          '^wreless|^wreless\\s+|(\\s*\\bwreless\\b\\s*).*$)\\b';
  
  EXPORT CAR_EXPR       := '\\b(^car|^car\\s+|(\\s*\\bcar\\b\\s*).*$|' +
                          '^cars|^cars\\s+|(\\s*\\bcars\\b\\s*).*$)\\b';
  
  EXPORT UNITED_EXPR    := '\\b(^united|^united\\s+|(\\s*\\bunited\\b\\s*).*$)\\b';
  
  EXPORT POWER_EXPR     := '\\b(^power|^power\\s+|(\\s*\\bpower\\b\\s*).*$|' +
                          '^powers|^powers\\s+|(\\s*\\bpowers\\b\\s*).*$|' +
                          '^powered|^powered\\s+|(\\s*\\bpowered\\b\\s*).*$)\\b';

  EXPORT INSTITUTE_EXPR := '\\b(^institute|^institute\\s+|(\\s*\\binstitute\\b\\s*).*$|' +
                          '^institutional|^institutional\\s+|(\\s*\\binstitutional\\b\\s*).*$|' +
                          '^institutes|^institutes\\s+|(\\s*\\binstitutes\\b\\s*).*$|' +
                          '^institut|^institut\\s+|(\\s*\\binstitut\\b\\s*).*$|' +
                          '^institution|^institution\\s+|(\\s*\\binstitution\\b\\s*).*$)\\b';

  EXPORT GARDEN_EXPR    := '\\b(^garden|^garden\\s+|(\\s*\\bgarden\\b\\s*).*$|' +
                          '^gardens|^gardens\\s+|(\\s*\\bgardens\\b\\s*).*$|' +
                          '^gardners|^gardners\\s+|(\\s*\\bgardners\\b\\s*).*$|' +
                          '^gardeners|^gardeners\\s+|(\\s*\\bgardeners\\b\\s*).*$|' +
                          '^gardening|^gardening\\s+|(\\s*\\bgardening\\b\\s*).*$)\\b';

  EXPORT COMPUTER_EXPR  := '\\b(^computer|^computer\\s+|(\\s*\\bcomputer\\b\\s*).*$|' +
                          '^computers|^computers\\s+|(\\s*\\bcomputers\\b\\s*).*$|' +
                          '^computing|^computing\\s+|(\\s*\\bcomputing\\b\\s*).*$|' +
                          '^compute|^compute\\s+|(\\s*\\bcompute\\b\\s*).*$)\\b';

  EXPORT PARK_EXPR      := '\\b(^park|^park\\s+|(\\s*\\bpark\\b\\s*).*$|' +
                          '^parking|^parking\\s+|(\\s*\\bparking\\b\\s*).*$)\\b';
  
  EXPORT GENERAL_EXPR   := '\\b(^general|^general\\s+|(\\s*\\bgeneral\\b\\s*).*$|' +
                          '^generals|^generals\\s+|(\\s*\\bgenerals\\b\\s*).*$|' +
                          '^genera|^genera\\s+|(\\s*\\bgenera\\b\\s*).*$|' +
                          '^genral|^genral\\s+|(\\s*\\bgenral\\b\\s*).*$)\\b';

  EXPORT CHRISTIAN_EXPR := '\\b(^christian|^christian\\s+|(\\s*\\bchristian\\b\\s*).*$|' +
                          '^christians|^christians\\s+|(\\s*\\bchristians\\b\\s*).*$)\\b';
  
  EXPORT FIRE_EXPR      := '\\b(^fire|^fire\\s+|(\\s*\\bfire\\b\\s*).*$)\\b';
  
  EXPORT CONTROL_EXPR   := '\\b(^control|^control\\s+|(\\s*\\bcontrol\\b\\s*).*$|' +
                          '^controls|^controls\\s+|(\\s*\\bcontrols\\b\\s*).*$|' +
                          '^contro|^contro\\s+|(\\s*\\bcontro\\b\\s*).*$|' +
                          '^controlled|^controlled\\s+|(\\s*\\bcontrolled\\b\\s*).*$)\\b';

  EXPORT COMMERCIAL_EXPR := '\\b(^commercial|^commercial\\s+|(\\s*\\bcommercial\\b\\s*).*$|' +
                          '^comercial|^comercial\\s+|(\\s*\\bcomercial\\b\\s*).*$|' +
                          '^commericial|^commericial\\s+|(\\s*\\bcommericial\\b\\s*).*$)\\b';

  EXPORT ART_EXPR       := '\\b(^arts|^arts\\s+|(\\s*\\barts\\b\\s*).*$|' +
                           '^art|^art\\s+|(\\s*\\bart\\b\\s*).*$)\\b';
  
  EXPORT GAS_EXPR       := '\\b(^gas|^gas\\s+|(\\s*\\bgas\\b\\s*).*$)\\b';
  
  EXPORT PARTNER_EXPR   := '\\b(^partners|^partners\\s+|(\\s*\\bpartners\\b\\s*).*$|' +
                          '^partner|^partner\\s+|(\\s*\\bpartner\\b\\s*).*$|' +
                          '^partnersh|^partnersh\\s+|(\\s*\\bpartnersh\\b\\s*).*$|' +
                          '^partnership|^partnership\\s+|(\\s*\\bpartnership\\b\\s*).*$|' +
                          '^partnershi|^partnerhi\\s+|(\\s*\\bpartnershi\\b\\s*).*$|' +
                          '^partnerships|^partnerships\\s+|(\\s*\\bpartnerships\\b\\s*).*$|' +
                          '^partnersh|^partnersh\\s+|(\\s*\\bpartnersh\\b\\s*).*$)\\b';

  EXPORT FOUNDATION_EXPR := '\\b(^foundation|^foundation\\s+|(\\s*\\bfoundation\\b\\s*).*$|' +
                          '^foundations|^foundations\\s+|(\\s*\\bfoundations\\b\\s*).*$|' +
                          '^foundat|^foundat\\s+|(\\s*\\bfoundat\\b\\s*).*$|' +
                          '^foundatio|^foundatio\\s+|(\\s*\\bfoundatio\\b\\s*).*$)\\b';

  EXPORT MARINE_EXPR    := '\\b(^marine|^marine\\s+|(\\s*\\bmarine\\b\\s*).*$|' +
                          '^mariner|^mariner\\s+|(\\s*\\bmariner\\b\\s*).*$|' +
                          '^marines|^marines\\s+|(\\s*\\bmarines\\b\\s*).*$|' +
                          '^mariners|^mariners\\s+|(\\s*\\bmariners\\b\\s*).*$)\\b';

  EXPORT MOBILE_EXPR    := '\\b(^mobile|^mobile\\s+|(\\s*\\bmobile\\b\\s*).*$|' +
                          '^mobility|^mobility\\s+|(\\s*\\bmobility\\b\\s*).*$|' +
                          '^moble|^moble\\s+|(\\s*\\bmoble\\b\\s*).*$)\\b';

  EXPORT VIDEO_EXPR     := '\\b(^video|^video\\s+|(\\s*\\bvideo\\b\\s*).*$|' +
                          '^videos|^videos\\s+|(\\s*\\bvideos\\b\\s*).*$)\\b';
  
  EXPORT BUSINESS_EXPR  := '\\b(^business|^business\\s+|(\\s*\\bbusiness\\b\\s*).*$|' +
                          '^businesses|^businesses\\s+|(\\s*\\bbusinesses\\b\\s*).*$|' +
                          '^busines|^busines\\s+|(\\s*\\bbusines\\b\\s*).*$)\\b';

  EXPORT CARPET_EXPR    := '\\b(^carpet|^carpet\\s+|(\\s*\\bcarpet\\b\\s*).*$|' +
                          '^carpets|^carpets\\s+|(\\s*\\bcarpets\\b\\s*).*$|' +
                          '^carpeting|^carpeting\\s+|(\\s*\\bcarpeting\\b\\s*).*$)\\b';

  EXPORT WORK_EXPR      := '\\b(^works|^works\\s+|(\\s*\\bworks\\b\\s*).*$|' +
                          '^work|^work\\s+|(\\s*\\bwork\\b\\s*).*$|' +
                          '^working|^working\\s+|(\\s*\\bworking\\b\\s*).*$)\\b';

  EXPORT GOLF_EXPR      := '\\b(^golf|^golf\\s+|(\\s*\\bgolf\\b\\s*).*$)\\b';
  
  EXPORT TECHNOLOG_EXPR := '\\b(^technologies|^technologies\\s+|(\\s*\\btechnologies\\b\\s*).*$|' +
                          '^technology|^technology\\s+|(\\s*\\btechnology\\b\\s*).*$|' +
                          '^technolgies|^technolgies\\s+|(\\s*\\btechnolgies\\b\\s*).*$|' +
                          '^technologi|^technologi\\s+|(\\s*\\btechnologi\\b\\s*).*$|' +
                          '^technologie|^technologie\\s+|(\\s*\\btechnologie\\b\\s*).*$|' +
                          '^technolog|^technolog\\s+|(\\s*\\btechnolog\\b\\s*).*$|' +
                          '^techologies|^techologies\\s+|(\\s*\\btechologies\\b\\s*).*$|' +
                          '^technological|^technological\\s+|(\\s*\\btechnological\\b\\s*).*$|' +
                          '^technolgy|^technolgy\\s+|(\\s*\\btechnolgy\\b\\s*).*$|' +
                          '^tecnologies|^tecnologies\\s+|(\\s*\\btecnologies\\b\\s*).*$|' +
                          '^techology|^techology\\s+|(\\s*\\btechology\\b\\s*).*$|' +
                          '^technoligies|^technoligies\\s+|(\\s*\\btechnoligies\\b\\s*).*$)\\b';

  EXPORT LLC_EXPR       := '\\b(^llc|^llc\\s+|(\\s*\\bllc\\b\\s*).*$)\\b';
  
  EXPORT CONDITION_EXPR := '\\b(^conditioning|^conditioning\\s+|(\\s*\\bconditioning\\b\\s*).*$|' +
                           '^conditionin|^conditionin\\s+|(\\s*\\bconditionin\\b\\s*).*$)\\b';
  
  EXPORT COOL_EXPR      := '\\b(^cooling|^cooling\\s+|(\\s*\\bcooling\\b\\s*).*$)\\b';
  
  EXPORT MECHAN_EXPR    := '\\b(^mechanical|^mechanical\\s+|(\\s*\\bmechanical\\b\\s*).*$|' +
                           '^mechanic|^mechanic\\s+|(\\s*\\bmechanic\\b\\s*).*$|' +
                           '^mechanics|^mechanics\\s+|(\\s*\\bmechanics\\b\\s*).*$)\\b';

  EXPORT REFRIGER_EXPR  := '\\b(^refrigeration|^refrigeration\\s+|(\\s*\\brefrigeration\\b\\s*).*$)\\b';
  
  EXPORT WINDOW_EXPR    := '\\b(^window|^window\\s+|(\\s*\\bwindow\\b\\s*).*$|' +
                           '^windows|^windows\\s+|(\\s*\\bwindows\\b\\s*).*$)\\b';

END;



