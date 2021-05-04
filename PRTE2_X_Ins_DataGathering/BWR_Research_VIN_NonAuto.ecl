/*  ********************************************************************************
It is quite hard to find odd vehicles like trailers - I finally had to look up a specific VIN
that we ended up with in our base file - that showed me best_body_code was always TL for that trailer
and then searching on the TL - I found I also needed to search TRAILER inside vina_make_desc

Someday we'll probably have to search for MotorHomes, ATVs, 4-wheelers, dirt bikes, etc so it'll take some research
********************************************************************************  */

IMPORT VehicleV2,STD,PRTE2_Common_DevOnly;

// Years := ['2016','2017','2018','2019','2020','2021'];
Years := ['2019','2020','2021'];
DS2 := VehicleV2.file_VehicleV2_main(vina_model_year IN Years AND vina_vin <>''
                                    AND vina_veh_type NOT IN ['P','M','T'] 
                                    AND orig_vehicle_type_code NOT IN ['P','T'] 
                                    // AND (vina_veh_type NOT IN ['P','M'] 
                                          // OR (vina_veh_type <> 'T' AND orig_vehicle_type_code NOT IN ['P','U'] ) )
                                    // AND (vina_make_desc <> '' OR vina_series_desc <> '') 
                                    );

COUNT(DS2);
CHOOSEN(DS2,200);

DS3 :=  VehicleV2.file_VehicleV2_main(vina_model_year in Years AND vina_vin ='');
DS3;

DS5 :=  VehicleV2.file_VehicleV2_main(vina_model_year in Years AND vina_vin <>'');
PRTE2_Common_DevOnly.MAC_CrossTabCount(DS5,orig_vehicle_type_code);
PRTE2_Common_DevOnly.MAC_CrossTabCount(DS5,orig_body_code);
PRTE2_Common_DevOnly.MAC_CrossTabCount(DS5,orig_body_desc);
PRTE2_Common_DevOnly.MAC_CrossTabCount(DS5,vina_body_style_desc);
/* ********************************************************************************
DS2 with AND vina_veh_type NOT IN ['P','M','T'] AND orig_vehicle_type_code NOT IN ['P','T'] mostly found Trailers (at least in first 200)
D3 above Tried searching for vina_vin='' and got odd stuff.  
One case may be useful: orig_make_code='SPARTAN' vina_ncic_make='SPTN' and orig_vehicle_type_code was 'T' Fuel='D'
                        vina_series_desc and vina_vp_series_name both = "MOTOR HOME" orig_body_code was blank
                        orig_body_desc and vina_body_style_desc were both "MULTI PA"

D5 above - First 100 of those:

PRTE2_Common_DevOnly.MAC_CrossTabCount(DS5,orig_vehicle_type_code);
L    	38523
U    	1597275
T    	1655081
P    	30220786
X    	1817
M    	672440
NOTE: Looks like orig matches well to vina_veh_type = Code that indicates the type of vehicle
   M=motorcycle
   P=passenger car
   L=light truck				Tested 2019 and there were no "L" values... so using "T" instead
   T=heavy truck				BUT "T" include semi trucks unless you alter filter only orig_vehicle_type_code='P'  (exclude "T") 
   X=trailer
   U=unknown (we could not determine the type of vehicle by decoding the VIN) 

PRTE2_Common_DevOnly.MAC_CrossTabCount(DS5,orig_body_code);
BOX  
AI   
FLBTR
ME   
PK   
GA   
ORM  
3H   
DM   
CCH  
PMM  
TRCTK
MC   
3MC  
6P   
A1   
03   
2DCP 
AUTO 
BS   
RC   
TRLER
07   
3 DR 
5DCG 
GRN  
VAN  
MTO  
2DHB 
JPV  
3X   
UTLTR
4C   
BUMPE
FLBTK
4DSW 
3U   
TF   
SN   
UTLTY
LI   
2D   
ATC  
CG   
CW   
PKK  
VNV  
B1   
HS   
TNTL 
MCY  
BR   
CA   
RB   
4IP  
BO   
LIMO 
DBUG 
DUM  
PC   
JAY  
SNOW 
WAG  
3WHL 
UTI  
WRTK 
DA   
RT   
GN   
TL 2W
TL HE
4DHB 
18   
OR   
LL   
MS   
TL HO
TRA  
GC   
JT   
2YY  
TC CO
2DMHB
BOXTR
FBL  
BG   
5H   
WD   
??   
SMV  
LIV  
MD   
SVP  
VANTK
EV   
TI   
2L   
SO   
ZHHT 
14   


PRTE2_Common_DevOnly.MAC_CrossTabCount(DS5,orig_body_desc);
DOUBLE CAB SWB      
SINGLE CAB 3P       
FLATBED TR          
SMALL TRAILER       
TANKER TRAILER      
ECONOMY HAULER      
SKIDDER             
STATION WAGO        
ROAD/STREET         
ARBOC RAIL REAR     
CONV CAB TRACTO     
UNKNOWN TRAILE      
SE SEMI             
AC AUTO CARRIE      
CARGO VAN           
Car Hauler          
TRAILE              
WELL DRILLING RIG   
AUXILIARY DOLLY     
GRAN COUPE 4D 4     
TANK TYPE           
GSNECK              
STEP DECK           
CT CAR TRAILER      
LOWBOY OR LO        
MOTORIZED HOME CUTAW
CONVERTIBLE HAR     
COMPETITION         
DUMP TRAILER        
KING CAB 4P 4       
SIDE DUMP T         
FLATBED             
GONDOLA             
MOTORIZED HOME      
PANEL               
STAKE               
SUV 2D 2D 6P 6P     
WAGON 7P 7P         
CARGO TRAILE        
PICKUP TRUCK        
ENCL, NON RE        
REGULAR CAB LON     
HARDTOP, 2 DOOR     
MINI MOTOCRO        
CABRIOLET 2D 2D     
FIRE TRUCK          
CAB OVER            
UTILITY TRLR        
TOW TRUCK AND WRECKE
ROLL OFF            
TRAILR              
CONVENTION AL AB    
SWB SUPERCAB 4D     
DROP FRAME          
LIVERY SEDAN 4D     
LOWBOY              
MINI ROAD/TRAIL     
WAGON 3D 3D 15P     
4 DOOR SEDA         
INTERCITY COACH     
TRENCHER            
CV CONVERTIBLE      
MH MOTORIZED H      
LOW BED TRAILE      
UTILITY VEH         
ALL TERRAIN         
MEDIUM ROOF WAG     
SIDE BY SIDE        
20 45 OPP           
5 DOOR              
SEDAN 4D 4D 4P      
REAR ENGINE SCH     
SPECIAL MOBILE      
HATCHBACK 5D 5D     
       CONVENTI     
WAGON WAGON MED     
HEARSE SEDAN 4D     
LOW SPEED           
GOOSENECK TRAI      
AIR COMPRESSOR      
CONTAINER           
2 DOOR              
BOX TRAILER         
STRAIGHT TRU        
MINI BIKE           
FLAT-BED OR PLATFORM
TRAILER             
BUS                 
CPE 2DR             
GOLF TRAILER        
HATCHBACK 2D 2D     
CREW/CARGO EXTE     
OPEN BODY           
SUPER CREW SUPE     
CUTAWAY VAN 2D      
MC MOTORCYCLE       
PARK TRAILER        
CAB/CHASSIS LWB     
MOTORHOME C         
3 SEAT              


PRTE2_Common_DevOnly.MAC_CrossTabCount(DS5,vina_body_style_desc);
Gliders                  
Club Chassis             
2 Dr Wagon Sport Utility 
ROADSTER                 
Road/Street              
4 Door EXT Cab PK        
Curtainside              
CONVERSION VAN           
VAN                      
Concrete/Transit MIX     
Lowbed                   
TRAILER                  
CHASSIS                  
Limousine                
OTHER                    
Extended Cargo Van       
UTILITY TRAILER          
TRAVEL TRAILER           
Unknown                  
CARGO VAN                
DUMP TRUCK               
SPECIAL MOBILE EQUIP     
Contain Chassis          
FLAT-BED OR PLATFORM     
SEMI TRAILER             
FLATBED                  
SPORT UTILITY VEHICL     
GRAIN                    
ENCL, NON RE             
Livestock                
STOCK TRAILE             
4 Dr Wagon Sport Utility 
Van                      
EN ENCL, NON R           
Hatchback 2 Door         
LIVESTOCK RA             
CARGO TRAILERS           
Station Wagon            
4 WHEEL DRIVE            
Racer                    
TRACTOR                  
Utility                  
Side BY Side             
TILT TANDEM              
SEMI                     
Fire Truck               
Tandem                   
Roll OFF                 
Hearse                   
Cargo Van                
HOPPER                   
FB FLATBED OR            
Moto Cross               
Mini Moto Cross          
Motorized Home           
                         
Logging                  
2 DOOR                   
Crew Pickup              
2 WHEEL DRIVE            
BOAT TRAILER             
STATION WAGON            
GOOSENECK TR             
Flatbed                  
TRUCK                    
Cutaway                  
Extended Sport Van       
3 Door Coupe             
GOOSENECK TRAI           
Tank                     
PICKUP                   
Club Cab Pickup          
Dump                     
MOBILE HOME              
Convertible              
Grain                    
LIFT                     
MOTORCYCLE               
4 DOOR                   
Enduro                   
Bus                      
4 Dr EXT Cab/Chass       
HE HORSE TRAIL           
TENT                     
Auto Transporter         
CAMPING TRAILER          
FLAT BED                 
Crew Chassis             
Cab And Chassis          
LIVESTOCK                
LIVESTOCK RACK           
GRAIN TRAILE             
Sedan 4 Door             
Sport Van                
SK STOCK TRAIL           
TANDEM                   
COUPE                    
SEDAN, 2 DOOR            
DIRT                     
Commercial Chassis 4     

*********************************************************************************** */