#!/bin/bash
# ------------------------------------------------------------------
# @yuxuliu@cisco.com 'core file' delete tool.
# Delete all core files
# Version: 1.5
# ------------------------------------------------------------------

if [[ "$1" == "-h" || "$1" == "" ]]  ;then
  echo """
0.      Login root uesr.
1.      enable_testapi.bin 3600                                                         //enable testapi
2.      ./delcores.sh -s                                                               //Display all Cores
3.      ./delcores.sh -d                                                               //DELETE ALL Cores
"""
elif [ "$1" == "-s" ]; then
  echo ""
  moquery -c dbgexpCoreStatus | grep "dn" | awk {'print $3'}
  echo ""
elif [ "$1" == "-d" ]; then
  echo -e "\nDelete ALL COREs" \?\?\?
  read -p "Confirm action? [N/y]: " confirm
  case $confirm in
    [yY])
          for i in `moquery -c dbgexpCoreStatus | grep "dn" | awk {'print $3'}`
          do
				
                icurl -X POST http://localhost:7777/testapi/mo/.json --data-binary '{"dbgexpCoreStatus":{"attributes":{"dn":"'$i'","status":"deleted"},"children":[]}}'
          done
          echo -e "\nDONE!\n";;
    *)
    echo -e "\nCanceled! THINKING BEFORE DOING!\n";;
  esac
fi