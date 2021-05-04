'''
Created on Jan 28 2019

@author: zsuffern
Default Dir := "C:\\Users\\suffza01\\Documents\\Git Projects\\HC_Thor\\Healthcare_Provider_ExternalLinking"
Example Command: 
$ python HackOMatic.py -H C:\\Users\\suffza01\\Documents\\Git\ Projects\\HC_Thor\\Healthcare_Provider_ExternalLinking\\HCP_EL_Hacksv2.py -R "C:\\Users\\suffza01\\Documents\\Git Projects\\HC_Thor\\Healthcare_Provider_ExternalLinking" -d
'''
import argparse
import sys
import Base_HackOMatic

#Parse Input
parser = argparse.ArgumentParser(prog='Hack-O-Matic')
parser.add_argument('--version', action='version', version='%(prog)s 1.0')
parser.add_argument("-v", "--verbose",help="Turn on verbose mode to see all output.",action="store_true")
parser.add_argument("-D", "--Dir", help="The Directory you wish to apply hacks to.")
parser.add_argument("-r", "--revert", help="Revert to unhacked files.", action="store_true")
parser.add_argument("-H", "--Hacks", required=('-r' not in sys.argv and '--revert' not in sys.argv), help="The Hacks you wish to apply to your Directory.")
parser.add_argument("-p", "--partial", help="Allows for some hacks to apply even if others fail.", action="store_true")
parser.add_argument("-o", "--overwrite", help="Allows for overwriting of orig files.", action="store_true")
parser.add_argument("-d", "--debug", help="Doesn't save files but allows you to see how hacks are applied. Also turns on verbose mode.", action="store_true")
args = parser.parse_args()

Base_HackOMatic.HackOMatic(args.Dir,args.Hacks,args.revert,args.partial,args.overwrite,args.debug,args.verbose)
