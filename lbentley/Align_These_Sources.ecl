export Align_These_Sources := 
module

	export layout_mapping :=
	RECORD

		STRING2       old_code		;
		set of string new_codes		;
						 
	END;																				

	export dSources := DATASET([
		 {'B'   ,['BA']				        }
		,{'C'   ,sourcetools.set_corpv2  	        }
		,{'FF'  ,['FL'] 	            }
		,{'IF'  ,sourcetools.set_fbnv2 	          }
		,{'MD'  ,['ML'] 	            }
		,{'ID'  ,['IC'] 	            }
		,{'WC'  ,['MW'] 	            }/* and l.vendor_id[1..2] = 'MS'*/
		,{'PR'  ,sourcetools.set_property         }
		,{'FA'  ,['AR'] 	            }
		,{'DE'  ,['DA'] 	            }
		,{'DC'  ,['DF']	              }
		,{'D '  ,['DN']  	            }
		,{'AF'  ,sourcetools.set_Atf 	            }
		,{'MV'  ,sourcetools.set_direct_vehicles  }
		,{'AW'  ,sourcetools.set_WC               }
		,{'AE'  ,sourcetools.set_experian_vehicles}
		,{'EB'  ,['ER'] 	            }
		,{'ED'  ,['EY'] 	            }
		,{'FC'  ,['FK'] 	            }
		,{'FD'  ,['FI']               }
		,{'ST'	,sourcetools.set_State_Sales_Tax}

	], layout_mapping);

end;
	//		,{'L2'  ,set_liens            } // this is not changing yet
	//		,{'LP'  ,sourcetools.set_property         }//have to figure out how to go backwards here
